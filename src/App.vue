<script setup>
import { ref, onMounted, computed, watch } from 'vue'

const todos = ref([])
const name = ref('')

const input_content = ref('')
const input_category = ref(null)

const todos_asc = computed(() => todos.value.sort((a,b) =>{
	return a.createdAt - b.createdAt
}))

watch(name, (newVal) => {
	localStorage.setItem('name', newVal)
})

watch(todos, (newVal) => {
	localStorage.setItem('todos', JSON.stringify(newVal))
}, {
	deep: true
})

const addTodo = () => {
	if (input_content.value.trim() === '' || input_category.value === null) {
		return
	}

	todos.value.push({
		content: input_content.value,
		category: input_category.value,
		done: false,
		editable: false,
		createdAt: new Date().getTime()
	})
}

const removeTodo = (todo) => {
	todos.value = todos.value.filter((t) => t !== todo)
}

onMounted(() => {
	name.value = localStorage.getItem('name') || ''
	todos.value = JSON.parse(localStorage.getItem('todos')) || []
})
</script>

<template>
	<main class="app">
		
		<section class="greeting">
			<h2 class="title">
				Halo, Dimas Prasetyo
			</h2>
		</section>

		<section class="create-todo">
			<h3>Buat jadwal</h3>

			<form id="new-todo-form" @submit.prevent="addTodo">
				<h4>ada kegiatan apa hari ini?</h4>
				<input 
					type="text" 
					name="content" 
					id="content" 
					placeholder="Masukkan kegiatan"
					v-model="input_content" />
				
				<h4>jenis kegiatan</h4>
				<div class="options">

					<label>
						<input 
							type="radio" 
							name="category" 
							id="category1" 
							value="biasa"
							v-model="input_category" />
						<span class="bubble biasa"></span>
						<div>Biasa</div>
					</label>

					<label>
						<input 
							type="radio" 
							name="category" 
							id="category2" 
							value="penting"
							v-model="input_category" />
						<span class="bubble penting"></span>
						<div>Penting</div>
					</label>

				</div>

				<input type="submit" value="Tambah tugas" />
			</form>
		</section>

		<section class="todo-list">
			<h3>LIST KEGIATAN</h3>
			<div class="list" id="todo-list">

				<div v-for="todo in todos_asc" :class="`todo-item ${todo.done && 'done'}`">
					<label>
						<input type="checkbox" v-model="todo.done" />
						<span :class="`bubble ${
							todo.category == 'biasa' 
								? 'biasa' 
								: 'penting'
						}`"></span>
					</label>

					<div class="todo-content">
						<input type="text" v-model="todo.content" />
					</div>

					<div class="actions">
						<button class="delete" @click="removeTodo(todo)">Delete</button>
					</div>
				</div>

			</div>
		</section>

	</main>
</template>