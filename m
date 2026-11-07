Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79549606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L5dShEHn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D17E010E606;
	Sat,  7 Nov 2026 13:27:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3AE10E600
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 13:27:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B565740AC3;
 Sat,  7 Nov 2026 13:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72A01F008A1;
 Sat,  7 Nov 2026 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794058049;
 bh=jHo1KtDdlGA9DSIFi2GWmdxqmrc53iL3yuI0wVgmS5U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L5dShEHntsZ3rWORw5x0i8Ca4SRZF5zcwzzgRpRaldbrc/UqNo0Tkf5n8VNm6bl88
 XSzl/fARE/HDZAUN+OBWKXNBi318dehfNvf0MEV5UkcTyafb0bVoUNzrCHi250nDg3
 z4peVXPHcr9oc23rPDKGGF/uJNuFFPEK0/fLmGykMtXVFcqGsv3wU9++dUk7IP3Yoz
 kYoyoz+KUJacFXNOLmbCT2wsvPPyoFQpjcGFNRpVheRTn4wSl7lp6ev29Zt5S7pJCG
 f6OyuP9lEj6jLoolq359cTe0JZbhznG0EN+uQ7hiE4zWUSzWKJPLsgZ/hqqCQZRdR3
 yUkPkuni8I7gw==
Message-ID: <sashiko-outbox-202921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] tracing: account ring buffer pages and trace_array
 metadata to memcg
To: "Tao Cui" <cui.tao@linux.dev>, akpm@linux-foundation.org,
 dgilbert@interlog.com, mkp@kernel.org, loberman@redhat.com,
 jmeneghi@redhat.com, kraxel@redhat.com, vivek.kasireddy@intel.com,
 mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, stefanha@redhat.com,
 sgarzare@redhat.com, rostedt@goodmis.org, vdonnefort@google.com,
 mhiramat@kernel.org, jgg@ziepe.ca, kevin.tian@intel.com, axboe@kernel.dk
Cc: linux-mm@kvack.org, James.Bottomley@HansenPartnership.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 joro@8bytes.org, will@kernel.org, linux-scsi@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com, robin.murphy@arm.com,
 mason@kernel.org, aesteve@redhat.com, tjmercier@google.com, harry@kernel.org,
 vbabka@suse.cz, cuitao@kylinos.cn, media-ci@linuxtv.org
In-Reply-To: <20261106131829.3228926-5-cui.tao@linux.dev>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-5-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:27:27 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] tracing: alloc_cpu_data() mischarges global_trace and
  read-page swaps
- [Medium] tracing: alloc_cpu_data() memcg limit triggers
  trace_rb_cpu_prepare() WARN
- [Low] tracing: inaccurate snapshot size claim and inconsistent
  GFP_KERNEL_ACCOUNT use
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] tracing: memory leak in trace_array_create_systems() [1]
--

commit a11da3138f9fda850c1b05bae82b0be7e738b994
Author: Tao Cui <cuitao@kylinos.cn>

tracing: account ring buffer pages and trace_array metadata to memcg

This commit adds __GFP_ACCOUNT to ring buffer subbuffer allocations in
alloc_cpu_data() and switches trace_array allocations in
trace_array_create_systems() to GFP_KERNEL_ACCOUNT.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index e760d2fe386fb..f925936378639 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -441,7 +441,13 @@ static struct buffer_data_page *alloc_cpu_data(int c=
pu, int order)
>  	 * gracefully without invoking oom-killer and the system is not
>  	 * destabilized.
>  	 */
> -	mflags =3D GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO;
> +	/*
> +	 * The subbuffers are charged to the memcg of whoever caused the
> +	 * allocation: the creator of a trace instance, or root at boot for
> +	 * the global trace.
> +	 */
> +	mflags =3D GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_COMP | __GFP_ZERO |
> +		  __GFP_ACCOUNT;
> =20
>  	page =3D alloc_pages_node(cpu_to_node(cpu), mflags, order);
>  	if (!page)

[Severity: Medium]
Does charging every alloc_cpu_data() call to current's memcg misattribute
global_trace subbuffers and swapped read pages?

At boot, tracer_alloc_buffers() keeps global_trace at its minimum size
(ring_buf_size =3D 1) when ring_buffer_expanded is false.  global_trace is
only expanded to trace_buf_size at runtime in tracing_update_buffers() or
tracing_set_tracer() when a task first enables an event, sets a tracer, or
loads a module using trace_printk().  With __GFP_ACCOUNT in
alloc_cpu_data(), those global_trace pages are charged to whichever cgroup
triggers the lazy expansion and stay pinned to that memcg because
global_trace is never freed.

In addition, ring_buffer_alloc_read_page() calls alloc_cpu_data() when
reading or splicing from trace_pipe_raw, and ring_buffer_read_page() swaps
that reader-allocated page directly into reader->page while handing the old
ring buffer page back to the reader to be freed:

kernel/trace/ring_buffer.c:ring_buffer_read_page() {
    ...
		dpage =3D reader->page;
		reader->page =3D data_page->data;
		local_set(&reader->write, 0);
		local_set(&reader->entries, 0);
		reader->read =3D 0;
		data_page->data =3D dpage;
    ...
}

A host process reading trace_pipe_raw from a container's instance will
replace the container's charged pages with uncharged pages and uncharge the
container as the old pages are freed, while a cgroup task reading
global_trace will swap pages charged to its own memcg into global_trace.
Similarly, trace_rb_cpu_prepare() during runtime CPU hotplug allocates
per-CPU buffers for all existing instances in the context of the task
onlining the CPU.

[Severity: Medium]
Can hitting the memcg limit in alloc_cpu_data() during instance creation
trigger the WARN(1) in trace_rb_cpu_prepare()?

When alloc_buffer() creates a ring buffer, it allocates the first CPU's
buffer directly and then calls
cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node), which runs
trace_rb_cpu_prepare() for each remaining present CPU:

kernel/trace/ring_buffer.c:trace_rb_cpu_prepare() {
    ...
	buffer->buffers[cpu] =3D
		rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
	if (!buffer->buffers[cpu]) {
		WARN(1, "failed to allocate ring buffer on CPU %u\n",
		     cpu);
		return -ENOMEM;
	}
    ...
}

Because __rb_allocate_pages() only checks si_mem_available() against global
memory, a cgroup with enough headroom for the first CPU (~1.375 MB) that
hits its memcg limit on any subsequent CPU in trace_rb_cpu_prepare() will
trigger this WARN(1) and crash the host if panic_on_warn is set.

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 08614af8fad1c..fd1cfd1f66fbe 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8677,11 +8677,11 @@ trace_array_create_systems(const char *name, cons=
t char *systems,
>  	int ret;
> =20
>  	ret =3D -ENOMEM;
> -	tr =3D kzalloc_obj(*tr);
> +	tr =3D kzalloc_obj(*tr, GFP_KERNEL_ACCOUNT);
>  	if (!tr)
>  		return ERR_PTR(ret);
> =20
> -	tr->name =3D kstrdup(name, GFP_KERNEL);
> +	tr->name =3D kstrdup(name, GFP_KERNEL_ACCOUNT);
>  	if (!tr->name)
>  		goto out_free_tr;
> =20
> @@ -8692,7 +8692,7 @@ trace_array_create_systems(const char *name, const =
char *systems,
>  		goto out_free_tr;
> =20
>  	if (systems) {
> -		tr->system_names =3D kstrdup_const(systems, GFP_KERNEL);
> +		tr->system_names =3D kstrdup_const(systems, GFP_KERNEL_ACCOUNT);
>  		if (!tr->system_names)
>  			goto out_free_tr;
>  	}

[Severity: Low]
Should the alloc_cpumask_var() and zalloc_cpumask_var() calls right between
tr->name and tr->system_names, as well as alloc_cpu_page() and
alloc_cpu_buffer() in ring_buffer.c, also use GFP_KERNEL_ACCOUNT?

Also, the commit message says creating an instance immediately allocates a
full ~1.375 MB per-CPU snapshot buffer, but trace_allocate_snapshot() passes
size =3D 1 when allocate_snapshot is false (which is always the case after
boot), so snapshot_buffer only allocates the minimum pages until a snapshot
is armed.

[Severity: Medium]
This problem wasn't introduced by this patch, but in
trace_array_create_systems() [1], does the out_free_tr error path leak
tr->tracers when trace_array_create_dir() fails?

trace_array_create_dir() calls __update_tracer() -> add_tracer(), which
allocates struct tracers and struct tracer_flags entries on tr->tracers.  If
a later step in trace_array_create_dir() fails and jumps to out_free_tr,
nothing calls free_tracers(tr), leaking the entries already added to
tr->tracers.

[1] https://sashiko.dev/#/bug/linux-9449d18e-1233-4181-9199-09eaead7b576

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106131829.3228=
926-1-cui.tao@linux.dev?part=3D4
