Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C5606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=py6AQxxw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1A610E09B;
	Mon, 19 Oct 2026 20:55:21 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A227D10E09B;
 Mon, 19 Oct 2026 20:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:From:Reply-To;
 bh=rn+rbtMF0KgE80M5jRWJcg8DBOejqoyF5SdvUePruH0=; b=py6AQxxwcdbH3iCMC8wHD97QWJ
 WlcgVOvz7Kv4iMP3wF6jbYgJ0ZnqYOfmwR6hO3lVWypo7U5zFyIvBy+x2KrZDOQ8x8rnWFge5FDSy
 tZ3XATLuIe9bmuVHWoVvLaY3lV7GkWQ0d7ZhmPdhcZDE/nX/JfdXyuyGkEgesiLMYowbaQuuSfig7
 mJXHzd5SMpGyJPwqTS3xRMrSS0UpIm4ZbbIAlj1nmVvwFYY27XLmEm96fN/jF8pA204p2adHYT5BB
 v0ieVVIUVWeLyN/iPbCu5PBvs1HSY1IJ54EcbNYl0vVzDI/TqUT06/ae7Jiu8oi+fkg7vl61bM9Tg
 egsH153Q==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xIuNo-003s40-9a; Mon, 19 Oct 2026 22:55:01 +0200
Date: Mon, 19 Oct 2026 17:54:54 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Simao Gomes Viana <simao.gomes@toowoxx.de>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Chunming Zhou <david1.zhou@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Natalie Vock <nat@pixelcluster.dev>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: Re: [PATCH 0/2] drm/amdgpu: fix memleak when amdgpu_vm_ptes_update
 fails
Message-ID: <ataDnhNZGvd5Q32o@quatroqueijos.cascardo.eti.br>
References: <20260929-amdgpu_vm_update_funcs_abort-v1-0-a8072140a7db@igalia.com>
 <8f533a48-3e40-418f-8155-5d09572834b8.bea56be8-1518-494d-8b16-c514e825d963.8771c778-bb79-4752-8713-e4313b5951e5@emailsignatures365.codetwo.com>
 <69100e57-9ca9-4ff5-b8c8-fc087244976e@toowoxx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <69100e57-9ca9-4ff5-b8c8-fc087244976e@toowoxx.de>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi, Simao.

Thanks for the report. I have notice this issue in some of the test runs
and realized that my changes prevented that as well. I just did not have
the chance to investigate further how it happened and how it was fixed by
my changes.

Thanks for the analysis, and, specially, thanks for being honest about the
usage of Claude.

Given I have found this in testing as well, and that this is not only
caused by a synthetic reproducer, I will see if we can get this in stable
releases.

Regards.
Cascardo.

On Wed, Oct 14, 2026 at 05:17:48PM +0200, Simao Gomes Viana wrote:
> <html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; chars=
et=3Dutf-8">
> <meta name=3D"Generator" content=3D"Microsoft Exchange Server">
> <!-- converted from text -->
> <style>.EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #8=
00000 2px solid; }</style></head>
> <body>
> <font size=3D"2"><div class=3D"PlainText">On Tue, Sep 29, 2026 at 05:34:0=
3PM -0300, Thadeu Lima de Souza Cascardo wrote:<br>
> &gt; When amdgpu_vm_ptes_update fails, there might be an IB jobs leak.<br>
> <br>
> On 7.2.9 this leak ends with command submission blocked in the kernel<br>
> until a reboot, so I tested a backport of the series there.<br>
> <br>
> The leaked job keeps its IB, and that IB never gets a fence, so it<br>
> stays in the delayed IB pool for good. drm_suballoc_try_free() stops<br>
> at the first entry without a fence, and drm_suballoc_next_hole() can<br>
> only skip ahead to an entry that has one. Once a request does not fit<br>
> in front of a leaked IB and no fenced entry is left to skip to,<br>
> amdgpu_sa_bo_new() sleeps uninterruptibly in drm_suballoc_insert(),<br>
> although the rest of the 1 MiB pool may be free. Later page table<br>
> updates that need an IB from that pool block the same way.<br>
> <br>
> I hit this on a Framework Desktop (Ryzen AI Max&#43; 395, Radeon 8060S,<b=
r>
> 512 MiB VRAM carve-out) running Vulkan compute with 62 GiB in GTT. Page<b=
r>
> tables can only be placed in VRAM, which was full at the hang (512 of<br>
> 512 MiB). That boot logged 239 &quot;Couldn't update BO_VA (-12)&quot;, a=
nd I<br>
> did not trace which allocation failed. The first command submission<br>
> after the last of them never returned, with the GPU idle:<br>
> <br>
> &nbsp; INFO: task qwen38_vk:3765381 blocked for more than 122 seconds.<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not tainted 7.2.9 #1-NixOS<br>
> &nbsp; Call Trace:<br>
> &nbsp;&nbsp; &lt;TASK&gt;<br>
> &nbsp;&nbsp; __schedule&#43;0x413/0x1780<br>
> &nbsp;&nbsp; schedule&#43;0x27/0xa0<br>
> &nbsp;&nbsp; drm_suballoc_insert&#43;0x5de/0x680 [drm_suballoc_helper]<br>
> &nbsp;&nbsp; drm_suballoc_new&#43;0x47/0x220 [drm_suballoc_helper]<br>
> &nbsp;&nbsp; amdgpu_sa_bo_new&#43;0x1e/0x40 [amdgpu]<br>
> &nbsp;&nbsp; amdgpu_ib_get&#43;0x42/0xa0 [amdgpu]<br>
> &nbsp;&nbsp; amdgpu_job_alloc_with_ib&#43;0x78/0xe0 [amdgpu]<br>
> &nbsp;&nbsp; amdgpu_vm_sdma_prepare&#43;0x4a/0xb0 [amdgpu]<br>
> &nbsp;&nbsp; amdgpu_vm_update_range&#43;0x22f/0x940 [amdgpu]<br>
> &nbsp;&nbsp; amdgpu_vm_bo_update&#43;0x261/0x740 [amdgpu]<br>
> &nbsp;&nbsp; amdgpu_vm_handle_moved&#43;0x60/0x1e0 [amdgpu]<br>
> &nbsp;&nbsp; amdgpu_cs_ioctl&#43;0x1a19/0x2380 [amdgpu]<br>
> &nbsp;&nbsp; drm_ioctl_kernel&#43;0xae/0x100<br>
> &nbsp;&nbsp; drm_ioctl&#43;0x27e/0x5b0<br>
> &nbsp;&nbsp; amdgpu_drm_ioctl&#43;0x4a/0x80 [amdgpu]<br>
> &nbsp;&nbsp; __x64_sys_ioctl&#43;0x97/0xe0<br>
> &nbsp;&nbsp; do_syscall_64&#43;0x134/0x6b0<br>
> &nbsp;&nbsp; entry_SYSCALL_64_after_hwframe&#43;0x77/0x7f<br>
> <br>
> To reproduce it on demand, I limited failslab to the test task and,<br>
> with its stack filter, to allocations below amdgpu_vm_ptes_update().<br>
> The injected -ENOMEM hits the first slab allocation made while a page<br>
> table is created, which need not be where the real failure happened.<br>
> The program at the end maps a 4 KiB BO at &lt;count&gt; addresses with<br>
> injection on, so every map fails while allocating a page table, after<br>
> amdgpu_vm_sdma_prepare() allocated the job. With injection off, one<br>
> more map then updates the page tables of all earlier mappings, and the<br>
> unmaps clear them again, so both take IBs from the same pool. In<br>
> amdgpu_sa_info, an IB without &quot;protected by&quot; belongs to no subm=
itted<br>
> job, so after the run it is a leaked one.<br>
> <br>
> Results on 7.2.9 without and with the backported series:<br>
> <br>
> Each kernel ran 64 maps and then 2048 maps in one boot, with nothing<br>
> else using the GPU.<br>
> <br>
> Without the series:<br>
> &nbsp; 64 maps: 64 injected failures and 64 &quot;Couldn't update BO_VA (=
-12)&quot;.<br>
> &nbsp;&nbsp;&nbsp; 64 IBs without a fence stayed in the delayed pool (64 =
KiB), and<br>
> &nbsp;&nbsp;&nbsp; the program finished.<br>
> &nbsp; 2048 maps: after 960 failed maps the program blocked in<br>
> &nbsp;&nbsp;&nbsp; drm_suballoc_insert(), called from amdgpu_vm_sdma_prep=
are() in<br>
> &nbsp;&nbsp;&nbsp; amdgpu_gem_va_ioctl(). The delayed pool then held 1024=
 IBs of<br>
> &nbsp;&nbsp;&nbsp; 1 KiB without a fence, 64 of them from the first run, =
which is<br>
> &nbsp;&nbsp;&nbsp; the whole 1 MiB pool. The task stayed in D state, thro=
ugh a<br>
> &nbsp;&nbsp;&nbsp; SIGKILL, until the reboot.<br>
> <br>
> With the series:<br>
> &nbsp; 64 maps: 64 injected failures and 64 &quot;Couldn't update BO_VA (=
-12)&quot;,<br>
> &nbsp;&nbsp;&nbsp; no IB without a fence left, all 65 unmaps done.<br>
> &nbsp; 2048 maps: 2048 injected failures and 2048 &quot;Couldn't update B=
O_VA<br>
> &nbsp;&nbsp;&nbsp; (-12)&quot;, no IB without a fence left, all 2049 unma=
ps done, no task<br>
> &nbsp;&nbsp;&nbsp; in D state.<br>
> <br>
> For 7.2.9 I backported both patches. There, struct<br>
> amdgpu_vm_update_funcs is in amdgpu_vm.h, the map path is still<br>
> amdgpu_vm_update_range() and ends with amdgpu_vm_eviction_unlock(),<br>
> and the hunks of patch 1 for amdgpu_vm_unmap_range() and<br>
> amdgpu_vm_handle_fault() have no counterpart. The added and removed<br>
> lines are the same, only the context differs.<br>
> <br>
> As this blocks command submission until a reboot on 7.2.9, could<br>
> patch 2, with patch 1 as its prerequisite, be tagged for stable? The<br>
> backport to 7.2.9 needed only the changes above.<br>
> <br>
> Claude Code (Claude Opus 5.5) did the source analysis, the backport,<br>
> the test program and script, ran the tests on my machine and drafted<br>
> this mail.<br>
> <br>
> Tested-by: Simao Gomes Viana &lt;simao.gomes@toowoxx.de&gt; # 7.2.9 backp=
ort<br>
> <br>
> Reproducer. It needs CONFIG_FAILSLAB, CONFIG_FAULT_INJECTION_DEBUG_FS<br>
> and CONFIG_FAULT_INJECTION_STACKTRACE_FILTER, and root. The range of<br>
> amdgpu_vm_ptes_update() comes from /proc/kallsyms (readable with<br>
> kptr_restrict at most 1), and its end is the next higher symbol<br>
> address. The other failslab attributes stay at their defaults.<br>
> <br>
> &nbsp; cd /sys/kernel/debug/failslab<br>
> &nbsp; echo N &gt; ignore-gfp-wait<br>
> &nbsp; echo Y &gt; task-filter<br>
> &nbsp; echo -1 &gt; times<br>
> &nbsp; echo 0x&lt;start&gt; &gt; require-start<br>
> &nbsp; echo 0x&lt;end&gt; &gt; require-end<br>
> &nbsp; echo 100 &gt; probability<br>
> <br>
> &nbsp; gcc -O2 -o vm-map-fail vm-map-fail.c \<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(pkg-config --cflags --libs libdrm_amdgpu=
)<br>
> &nbsp; ./vm-map-fail /dev/dri/renderD128 64<br>
> <br>
> /*<br>
> &nbsp;* Maps one 4 KiB buffer at &lt;count&gt; GPU addresses 2 MiB apart =
with<br>
> &nbsp;* /proc/self/make-it-fail set. With failslab limited to that flag a=
nd to call<br>
> &nbsp;* chains through amdgpu_vm_ptes_update(), every map fails in its pa=
ge table<br>
> &nbsp;* allocation after amdgpu_vm_sdma_prepare() allocated the update jo=
b, and the<br>
> &nbsp;* kernel logs &quot;Couldn't update BO_VA (-12)&quot; for it.<br>
> &nbsp;*<br>
> &nbsp;* Then, with the flag cleared, one more map retries the page table =
updates of<br>
> &nbsp;* all &lt;count&gt; earlier mappings, which now allocate their page=
 tables and<br>
> &nbsp;* submit their jobs, and the unmaps clear them again, one job each.=
 Both need<br>
> &nbsp;* IBs from the same pool the failed maps took theirs from.<br>
> &nbsp;*<br>
> &nbsp;* Writing make-it-fail needs CAP_SYS_RESOURCE.<br>
> &nbsp;*<br>
> &nbsp;*&nbsp;&nbsp; vm-map-fail &lt;render node&gt; &lt;count&gt;<br>
> &nbsp;*/<br>
> #include &lt;amdgpu.h&gt;<br>
> #include &lt;amdgpu_drm.h&gt;<br>
> #include &lt;fcntl.h&gt;<br>
> #include &lt;stdio.h&gt;<br>
> #include &lt;stdlib.h&gt;<br>
> #include &lt;string.h&gt;<br>
> #include &lt;unistd.h&gt;<br>
> <br>
> #define BO_SIZE 4096ull<br>
> #define STRIDE (2ull &lt;&lt; 20)<br>
> <br>
> static void check(int r, const char *what)<br>
> {<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;%s: %s\n&quot;, what, strerror(-r))=
;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; exit(1);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
> }<br>
> <br>
> static void set_make_it_fail(const char *value)<br>
> {<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd =3D open(&quot;/proc/se=
lf/make-it-fail&quot;, O_WRONLY);<br>
> <br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fd &lt; 0 || write(fd, val=
ue, 1) !=3D 1) {<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; perror(&quot;/proc/self/make-it-fail&quot;);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; exit(1);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(fd);<br>
> }<br>
> <br>
> static void va_op_all(amdgpu_bo_handle bo, uint64_t base, unsigned int co=
unt,<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t op, const ch=
ar *what)<br>
> {<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (unsigned int i =3D 0; i &=
lt; count; i&#43;&#43;)<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; check(amdgpu_bo_va_op(bo, 0, BO_SIZE, base &#43; i * STRI=
DE, 0, op),<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; what);<br>
> }<br>
> <br>
> int main(int argc, char **argv)<br>
> {<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_alloc_request=
 request =3D {<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; .alloc_size =3D BO_SIZE,<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; .phys_alignment =3D BO_SIZE,<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; .preferred_heap =3D AMDGPU_GEM_DOMAIN_GTT,<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_handle dev;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_va_handle va;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_handle bo;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t major, minor;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int count;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t base;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd;<br>
> <br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (argc !=3D 3 || (count =3D =
strtoul(argv[2], NULL, 10)) =3D=3D 0) {<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;usage: %s &lt;render node&gt; &lt;c=
ount&gt;\n&quot;, argv[0]);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 2;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
> <br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fd =3D open(argv[1], O_RDWR | =
O_CLOEXEC);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fd &lt; 0) {<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; perror(argv[1]);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 1;<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_device_initialize=
(fd, &amp;major, &amp;minor, &amp;dev),<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &quot;amdgpu_device_initialize&quot;);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_bo_alloc(dev, &am=
p;request, &amp;bo), &quot;amdgpu_bo_alloc&quot;);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_va_range_alloc(de=
v, amdgpu_gpu_va_range_general,<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (count &#43;=
 1) * STRIDE, STRIDE, 0, &amp;base, &amp;va,<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0),<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &quot;amdgpu_va_range_alloc&quot;);<br>
> <br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_make_it_fail(&quot;1&quot;=
);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_op_all(bo, base, count, AMD=
GPU_VA_OP_MAP, &quot;map&quot;);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_make_it_fail(&quot;0&quot;=
);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_bo_va_op(bo, 0, B=
O_SIZE, base &#43; count * STRIDE, 0,<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VA_OP_MAP),<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &quot;map without failure injection&quot;);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va_op_all(bo, base, count &#43=
; 1, AMDGPU_VA_OP_UNMAP, &quot;unmap&quot;);<br>
> <br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_va_range_free(va)=
, &quot;amdgpu_va_range_free&quot;);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_bo_free(bo), &quo=
t;amdgpu_bo_free&quot;);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; check(amdgpu_device_deinitiali=
ze(dev), &quot;amdgpu_device_deinitialize&quot;);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(fd);<br>
> <br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;%u failed maps fr=
om 0x%llx, %llu bytes apart, then 1 map and %u unmaps\n&quot;,<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; count, (unsigned long long)base, STRIDE, count &#43; 1);<br>
> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
> }<br>
> </div></font>
>=20
>=20
>=20
> <p style=3D"FONT-SIZE: 10pt; MARGIN-BOTTOM: 5pt; FONT-FAMILY: ARIAL; MARG=
IN-TOP: 0pt"></p><br>
> <table id=3D"0.rt2nciqm8el" style=3D"width: 431px;" cellspacing=3D"0" cel=
lpadding=3D"0">
>   <tbody>
>   <tr>
>     <td style=3D"border-width: 0px 2px 0px 0px; font-size: 10pt; font-fam=
ily: Arial; border-right-style: solid; border-color: rgb(255, 255, 255) rgb=
(99, 143, 193) rgb(255, 255, 255) rgb(255, 255, 255); width: 230px;" valign=
=3D"top" colspan=3D"2" class=3D""><span style=3D"FONT-SIZE: 13px; FONT-FAMI=
LY: Verdana">Mit freundlichen Gr&#xFC;&#xDF;en=20
>       /</span><br style=3D"FONT-SIZE: 13px; FONT-FAMILY: Verdana"><span s=
tyle=3D"FONT-SIZE: 13px; FONT-FAMILY: Verdana">best regards,</span></td>
>     <td style=3D"font-size: 10pt; font-family: Arial; width: 201px; paddi=
ng: 0px 0px 0px 10px; text-align: left;" valign=3D"middle" colspan=3D"3"><a=
 href=3D"https://www.toowoxx.de/" title=3D""><img src=3D"cid:logo-min_9a509=
263-93aa-4c90-952e-cf3ad1644cc3.png" border=3D"0" id=3D"0.w3awvfulmsk" alt=
=3D"Logo_Toowoxx.png" style=3D""></a></td></tr>
>   <tr>
>     <td style=3D"border-width: 0px 2px 0px 0px; font-size: 10pt; font-fam=
ily: Arial; border-right-style: solid; border-color: rgb(255, 255, 255) rgb=
(99, 143, 193) rgb(255, 255, 255) rgb(255, 255, 255); width: 230px;" valign=
=3D"top" colspan=3D"2" class=3D""></td>
>     <td style=3D"font-size: 10pt; font-family: Arial; width: 201px;" vali=
gn=3D"top" colspan=3D"3">&nbsp;<br></td></tr>
>   <tr>
>     <td style=3D"border-width: 0px 2px 0px 0px; border-right-style: solid=
; border-color: rgb(255, 255, 255) rgb(99, 143, 193) rgb(255, 255, 255) rgb=
(255, 255, 255); width: 230px;" valign=3D"top" colspan=3D"2" class=3D""><fo=
nt face=3D"Verdana"><span style=3D"font-size: 13px;"><b>Simao Gomes Viana</=
b></span></font></td>
>     <td style=3D"font-size: 10pt; font-family: Arial; width: 201px; paddi=
ng: 0px 0px 0px 10px;" valign=3D"top" colspan=3D"3"><span style=3D"FONT-SIZ=
E: 13px; FONT-FAMILY: Verdana; FONT-WEIGHT: 700">Toowoxx IT=20
>       GmbH</span></td></tr>
>   <tr>
>     <td style=3D"border-width: 0px 2px 0px 0px; font-size: 10pt; font-fam=
ily: Arial; border-right-style: solid; border-color: rgb(255, 255, 255) rgb=
(99, 143, 193) rgb(255, 255, 255) rgb(255, 255, 255); width: 230px;" valign=
=3D"top" colspan=3D"2"><span style=3D"FONT-SIZE: 13px; FONT-FAMILY: Verdana=
">Senior Developer</span></td>
>     <td style=3D"font-size: 10pt; font-family: Arial; width: 201px; paddi=
ng: 0px 0px 0px 10px;" valign=3D"top" colspan=3D"3"><span style=3D"FONT-SIZ=
E: 13px; FONT-FAMILY: Verdana">Krumbacher Stra&#xDF;e=20
>       1</span><br></td></tr>
>   <tr>
>     <td style=3D"border-width: 0px 2px 0px 0px; font-size: 10pt; font-fam=
ily: Arial; border-right-style: solid; border-color: rgb(255, 255, 255) rgb=
(99, 143, 193) rgb(255, 255, 255) rgb(255, 255, 255); width: 230px;" valign=
=3D"top" colspan=3D"2"></td>
>     <td style=3D"font-size: 10pt; font-family: Arial; width: 201px; paddi=
ng: 0px 0px 0px 10px;" valign=3D"top" colspan=3D"3"><span style=3D"FONT-SIZ=
E: 13px; FONT-FAMILY: Verdana">DE-86489=20
>       Deisenhausen</span><br></td></tr>
>   <tr>
>     <td style=3D"border-width: 0px 2px 0px 0px; font-size: 10pt; font-fam=
ily: Verdana; border-right-style: solid; border-color: rgb(255, 255, 255) r=
gb(99, 143, 193) rgb(255, 255, 255) rgb(255, 255, 255); width: 230px;" vali=
gn=3D"top" colspan=3D"2" class=3D""><br style=3D"font-family: Verdana;"></t=
d>
>     <td style=3D"font-size: 10pt; font-family: Arial; width: 201px; paddi=
ng: 0px 0px 10px 10px;" valign=3D"top" colspan=3D"3"><br></td></tr>
>   <tr>
>     <td style=3D"border-width: 0px 2px 0px 0px; font-family: Verdana; bor=
der-right-style: solid; border-color: rgb(255, 255, 255) rgb(99, 143, 193) =
rgb(255, 255, 255) rgb(255, 255, 255); width: 230px; padding: 0px 0px 10px;=
 text-align: left;" valign=3D"bottom" rowspan=3D"2" colspan=3D"2" class=3D"=
"><span style=3D"font-size: 13px; color: rgb(91, 138, 181); font-family: Ve=
rdana;">E:</span><span style=3D"FONT-SIZE: 13px; FONT-FAMILY: Verdana; COLO=
R: rgb(91,138,181)">&nbsp;</span><a style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Verdana; COLOR: rgb(91,138,181); text-decoration-line: none" href=3D"mailto=
:simao.gomes@toowoxx.de">simao.gomes@toowoxx.de</a><br style=3D"font-family=
: Verdana;"><span style=3D"font-size: 13px; color: rgb(91, 138, 181); font-=
family: Verdana;">T:</span><span style=3D"FONT-SIZE: 13px; FONT-FAMILY: Ver=
dana; COLOR: rgb(91,138,181)">&nbsp;</span><a style=3D"FONT-SIZE: 10pt; FON=
T-FAMILY: Verdana; COLOR: rgb(91,138,181); text-decoration-line: none" href=
=3D"tel:+49 8282 881299-22">+49 8282 881299-22</a><br style=3D"font-family:=
 Verdana;"><span style=3D"font-size: 13px; color: rgb(91, 138, 181); font-f=
amily: Verdana;"></span><span style=3D"font-size: 13px; color: rgb(91, 138,=
 181); font-family: Verdana;"><span style=3D"font-size: 13px; color: rgb(91=
, 138, 181); font-family: Verdana;">W:&nbsp;</span><a title=3D"" style=3D"f=
ont-size: 10pt; color: rgb(91, 138, 181); text-decoration-line: none; font-=
family: Verdana;" href=3D"https://toowoxx.de/">toowoxx.de</a><br><span styl=
e=3D"font-size: 10pt; color: rgb(91, 138, 181);">Teams:&nbsp;</span><a href=
=3D"https://teams.microsoft.com/l/chat/0/0?users=3Dsimao.gomes@toowoxx.de" =
style=3D"color: rgb(91, 138, 181); text-decoration-line: none; background-c=
olor: rgb(255, 255, 255); font-size: 10pt;" title=3D"">Simao Gomes Viana | =
Toowoxx IT GmbH</a></span></td>
>     <td style=3D"font-family: Arial; width: 201px;" valign=3D"top" colspa=
n=3D"3"></td></tr>
>   <tr>
>     <td style=3D"font-family: Arial; width: 201px; padding: 0px 0px 10px =
10px; text-align: left;" valign=3D"bottom" colspan=3D"3"><span style=3D"FON=
T-SIZE: 13px; FONT-FAMILY: Verdana; COLOR: rgb(91,138,181)">Standort=20
>       Ulm</span><br><span style=3D"FONT-SIZE: 13px; FONT-FAMILY: Verdana;=
 COLOR: rgb(0,0,0)">M&#xFC;nchner=20
>       Stra&#xDF;e 15</span><br><span style=3D"FONT-SIZE: 13px; FONT-FAMIL=
Y: Verdana; COLOR: rgb(99,143,193)"><span style=3D"COLOR: rgb(0,0,0)">DE-89=
073 Ulm</span></span></td></tr>
>   <tr style=3D"COLOR: rgb(99,143,193)">
>     <td style=3D"border-width: 2px 0px; font-size: 10pt; border-top-style=
: solid; border-color: rgb(99, 143, 193); font-family: Arial; width: 153.71=
px; border-bottom-style: solid; color: rgb(99, 143, 193); text-align: cente=
r; background-color: rgb(99, 143, 193);" valign=3D"middle" data-preserved-b=
ackground-color=3D"null" class=3D""><span style=3D"FONT-SIZE: 16px; FONT-FA=
MILY: Verdana; COLOR: rgb(255,255,255); TEXT-ALIGN: center; BACKGROUND-COLO=
R: rgb(99,143,193)"><span style=3D"FONT-SIZE: 10pt"><span style=3D"FONT-SIZ=
E: 11pt">FOLGE=20
>       UNS:</span></span></span></td>
>     <td style=3D"border-width: 2px 0px; font-size: 10pt; border-top-style=
: solid; border-color: rgb(99, 143, 193); font-family: Arial; width: 76.289=
4px; border-bottom-style: solid; text-align: center;" valign=3D"middle" dat=
a-preserved-background-color=3D"null" class=3D""><a title=3D"" href=3D"http=
s://de-de.facebook.com/toowoxx"><img id=3D"0.h6m20wiz3li" style=3D"" border=
=3D"0" src=3D"cid:facebook-min_80a01dfe-43c3-4373-a597-c4fa143a8352.png"></=
a></td>
>     <td style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 10pt; BORDER-TOP: rgb=
(99,143,193) 2px solid; FONT-FAMILY: Arial; BORDER-RIGHT-WIDTH: 0px; WIDTH:=
 67px; BORDER-BOTTOM: rgb(99,143,193) 2px solid; BORDER-LEFT-COLOR: rgb(99,=
143,193); COLOR: rgb(99,143,193); TEXT-ALIGN: center; BORDER-RIGHT-COLOR: r=
gb(99,143,193)" valign=3D"middle" data-preserved-background-color=3D"null">=
<a title=3D"" href=3D"https://twitter.com/toowoxx?lang=3Dde"><img id=3D"0.k=
773m4v9m3l" style=3D"" border=3D"0" src=3D"cid:twitter-min_b2b87642-f9c4-4d=
bd-be0d-25e87273c9a0.png"></a><br></td>
>     <td style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 10pt; BORDER-TOP: rgb=
(99,143,193) 2px solid; FONT-FAMILY: Arial; BORDER-RIGHT-WIDTH: 0px; WIDTH:=
 67px; BORDER-BOTTOM: rgb(99,143,193) 2px solid; BORDER-LEFT-COLOR: rgb(99,=
143,193); TEXT-ALIGN: center; BORDER-RIGHT-COLOR: rgb(99,143,193)" valign=
=3D"middle" data-preserved-background-color=3D"null"><a title=3D"" href=3D"=
https://www.instagram.com/toowoxx/?hl=3Dde"><img id=3D"0.2pgnn719k03" style=
=3D"" border=3D"0" src=3D"cid:instagram-min_c8b3f7e6-0b92-486c-bde1-1bb9a71=
60db0.png"></a></td>
>     <td style=3D"BORDER-LEFT-WIDTH: 0px; FONT-SIZE: 10pt; BORDER-TOP: rgb=
(99,143,193) 2px solid; FONT-FAMILY: Arial; BORDER-RIGHT-WIDTH: 0px; WIDTH:=
 67px; BORDER-BOTTOM: rgb(99,143,193) 2px solid; BORDER-LEFT-COLOR: rgb(99,=
143,193); TEXT-ALIGN: center; BORDER-RIGHT-COLOR: rgb(99,143,193)" valign=
=3D"middle" data-preserved-background-color=3D"null"><a title=3D"" href=3D"=
https://de.linkedin.com/company/toowoxx-it-gmbh"><img id=3D"0.sse7zo5p0nr" =
style=3D"aspect-ratio: 236 / 204;" border=3D"0" src=3D"cid:linkedin-min_c30=
0cc73-f06d-4cfc-90c7-f1130e8f3817.png"></a></td></tr>
>   <tr style=3D"COLOR: rgb(99,143,193)">
>     <td style=3D"font-size: 10pt; font-family: Arial; width: 431px; color=
: rgb(99, 143, 193); padding: 10px 0px 0px;" valign=3D"top" colspan=3D"5"><=
span style=3D"FONT-SIZE: 7px; FONT-FAMILY: Verdana, sans-serif; COLOR: rgb(=
99,143,193)"><span style=3D"FONT-SIZE: 7pt; COLOR: rgb(99,143,193)"><span s=
tyle=3D"FONT-SIZE: 8pt; COLOR: rgb(99,143,193)"><span style=3D"FONT-SIZE: 7=
pt; COLOR: rgb(99,143,193)"><span style=3D"COLOR: rgb(156,159,163)">Firmens=
itz:&nbsp; &nbsp; &nbsp; &nbsp;=20
>       &nbsp; &nbsp; &nbsp; &nbsp;Toowoxx IT GmbH, Krumbacher Stra&#xDF;e =
1, 86489=20
>       Deisenhausen</span></span></span></span><br style=3D"FONT-SIZE: 7pt=
; COLOR: rgb(156,159,163)"></span><span style=3D"FONT-SIZE: 7pt; COLOR: rgb=
(156,159,163)"><span style=3D"FONT-FAMILY: Verdana; COLOR: rgb(156,159,163)=
">Gesch&#xE4;ftsf&#xFC;hrer:&nbsp;=20
>       &nbsp; &nbsp; &nbsp;Christian Thoma, Oliver Wiemer, J&#xFC;rgen=20
>       Mayer</span></span><br style=3D"FONT-SIZE: 7pt; FONT-FAMILY: Verdan=
a; COLOR: rgb(156,159,163)"><span style=3D"FONT-SIZE: 7pt; FONT-FAMILY: Ver=
dana; COLOR: rgb(156,159,163)">Handelsregister:&nbsp;=20
>       &nbsp; &nbsp; &nbsp;Amtsgericht Memmingen HRB 13224</span><br style=
=3D"FONT-SIZE: 7pt; FONT-FAMILY: Verdana; COLOR: rgb(156,159,163)"><span st=
yle=3D"FONT-SIZE: 7pt; COLOR: rgb(99,143,193)"><span style=3D"COLOR: rgb(99=
,143,193)"><span style=3D"FONT-SIZE: 8pt; COLOR: rgb(99,143,193)"><span sty=
le=3D"FONT-SIZE: 7pt; COLOR: rgb(99,143,193)"><span style=3D"FONT-FAMILY: V=
erdana; COLOR: rgb(99,143,193)"><span style=3D"COLOR: rgb(156,159,163)">Ums=
atzsteuer ID:&nbsp; &nbsp; &nbsp;=20
>       DE258706918</span></span></span></span></span></span><span style=3D=
"font-size: 7pt;"><span style=3D"font-family: Verdana;"><span style=3D"colo=
r: rgb(156, 159, 163);"><br></span></span></span><span style=3D"FONT-SIZE: =
7pt; COLOR: rgb(99,143,193)"><span style=3D"COLOR: rgb(99,143,193)"><span s=
tyle=3D"FONT-SIZE: 8pt; COLOR: rgb(99,143,193)"><span style=3D"FONT-SIZE: 7=
pt; COLOR: rgb(99,143,193)"><span style=3D"FONT-FAMILY: Verdana; COLOR: rgb=
(99,143,193)"><span style=3D"COLOR: rgb(156,159,163)"><br></span></span></s=
pan></span></span></span></td></tr></tbody></table><p></p><p style=3D"margi=
n: 0.1pt;"><span style=3D"font-size:11.0pt;font-family:&quot;Aptos&quot;,sa=
ns-serif;
> mso-fareast-font-family:Aptos;mso-fareast-theme-font:minor-latin;mso-bidi=
-font-family:
> Aptos;mso-ligatures:standardcontextual;mso-ansi-language:DE;mso-fareast-l=
anguage:
> EN-US;mso-bidi-language:AR-SA"><a href=3D"https://www.toowoxx.de/passkeys=
/" title=3D"https://www.toowoxx.de/passkeys/"><span style=3D"color: rgb(70,=
 120, 134); text-decoration-line: none;"><!--[if gte vml 1]><v:shapetype id=
=3D"_x0000_t75"
>  coordsize=3D"21600,21600" o:spt=3D"75" o:preferrelative=3D"t" path=3D"m@=
4@5l@4@11@9@11@9@5xe"
>  filled=3D"f" stroked=3D"f">
>  <v:stroke joinstyle=3D"miter"/>
>  <v:formulas>
>   <v:f eqn=3D"if lineDrawn pixelLineWidth 0"/>
>   <v:f eqn=3D"sum @0 1 0"/>
>   <v:f eqn=3D"sum 0 0 @1"/>
>   <v:f eqn=3D"prod @2 1 2"/>
>   <v:f eqn=3D"prod @3 21600 pixelWidth"/>
>   <v:f eqn=3D"prod @3 21600 pixelHeight"/>
>   <v:f eqn=3D"sum @0 0 1"/>
>   <v:f eqn=3D"prod @6 1 2"/>
>   <v:f eqn=3D"prod @7 21600 pixelWidth"/>
>   <v:f eqn=3D"sum @8 21600 0"/>
>   <v:f eqn=3D"prod @7 21600 pixelHeight"/>
>   <v:f eqn=3D"sum @10 21600 0"/>
>  </v:formulas>
>  <v:path o:extrusionok=3D"f" gradientshapeok=3D"t" o:connecttype=3D"rect"=
/>
>  <o:lock v:ext=3D"edit" aspectratio=3D"t"/>
> </v:shapetype><v:shape id=3D"_x0030_.3zycwi3oqx" o:spid=3D"_x0000_i1025" =
type=3D"#_x0000_t75"
>  alt=3D"Footer  TOOWOXXPasskey.png" href=3D"https://www.toowoxx.de/passke=
ys/"
>  title=3D"&quot;https://www.toowoxx.de/passkeys/&quot;" style=3D'width:32=
5.5pt;
>  height:94.5pt' o:button=3D"t">
>  <v:imagedata src=3D"clip_image001.png"
>   o:href=3D"cid:footertoowoxxpasskey_3d6cf03f-ffa1-48dd-925f-2b1a6883c66d=
=2Epng"/>
> </v:shape><![endif]--><!--[if !vml]--><a href=3D"https://www.toowoxx.de/p=
asskeys/" title=3D"https://www.toowoxx.de/passkeys/"><img border=3D"0" widt=
h=3D"434" height=3D"126" src=3D"data:image/png;base64,R0lGODdhsgF+AHcAACH+G=
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3D=
=3D" style=3D"height:126px;width:434px" alt=3D"Footer  TOOWOXXPasskey.png" =
v:shapes=3D"_x0030_.3zycwi3oqx" id=3D"0.g681zju500s"></a><!--[endif]--></sp=
an></a></span></p><p style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial; COLOR: r=
gb(99,143,193)">
> </p></body>
> </html>






