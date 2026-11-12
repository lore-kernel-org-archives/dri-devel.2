Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769B606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwpBOVSC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B29631123E3;
	Thu, 12 Nov 2026 23:34:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5216C1123E3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:34:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C16561284;
 Thu, 12 Nov 2026 23:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997FA1F000C9;
 Thu, 12 Nov 2026 23:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794526465;
 bh=O1sJ44DczLtN0BNadQZUYOcqj0jE+7+ttS4KYxv2FBI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KwpBOVSCUW2N1YkoOno0LaPqffNgGLADhDkgloVRqcCdW0oAIrvqYsd9FYc8U1GOj
 w3MvoJaBAjBA5qVHWdXyV3P4p9Qd0g66LBnJtSd1KhSFTcNnsh+aOE9jCPbNT+CeP2
 zmCIF3fI42PPVR8zMNBZmFyJx7iqG06eM9EyNW/G9s0Ob6oBnzncxjEgez2yejo3e8
 4FL3YPpELK9655zT8ts5imFIXFDWCI6VYOBuVHnDVwbzuurCqVrqG/o6exBL77f0MF
 eNKZE0sIf5n9SlfT/G1uj+jb7hvBypJw/PtcDJ9Nhh5hvoPJTAFABpgL9euwUsAWW8
 lSqiKUHU05G/g==
Message-ID: <sashiko-outbox-211956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/13] drm/powervr_sgx: Add render jobs
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-10-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-10-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:34:15 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/powervr_sgx: unclamped default PB page count in
  pb_create()
- [Medium] drm/powervr_sgx: premature sdev->pb publish and PB
  displacement on error
- [Medium] drm/powervr_sgx: graveyard deferral of unused kobjs exhausts
  krange space
--

commit c2a5d476f9621e03f6e1668986df566b2eded3be
Author: Joseph Telaak <joseph@telaak.dev>

drm/powervr_sgx: Add render jobs

This commit adds render contexts, parameter buffer management, render target
datasets, and render and transfer job submission and command building for
PowerVR SGX GPUs.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_render.c b/drivers/gpu/dr=
m/powervr_sgx/pvrsgx_render.c
> new file mode 100644
> index 0000000000000..00b444d05a605
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_render.c
[ ... ]
> +static struct pvrsgx_pb *pb_create(struct pvrsgx_device *sdev, u32 req_p=
ages)
> +{
> +	struct pvrsgx_pb *pb =3D kzalloc_obj(*pb);
> +	u32 pages =3D (req_pages ?: PVRSGX_PB_DEFAULT_PAGES) + PB_EXTRA_PAGES;
> +	int err;

[Severity: Medium]
Can pb_create() allocate a parameter buffer larger than the core's
pb_max_pages when req_pages is 0?

PVRSGX_PB_DEFAULT_PAGES is 0x1000, whereas sgx530_heaps sets pb_max_pages to
0x800.  When the first render context on SGX530 passes param_buffer_pages =
=3D=3D 0,
sdev->pb is created with 0x1000 + PB_EXTRA_PAGES pages, which both exceeds =
the
core limit and causes dev_pb_get() to reject any later CREATE_CONTEXT call =
that
passes a valid non-zero param_buffer_pages (<=3D 0x800).  Clamping
PVRSGX_PB_DEFAULT_PAGES to pvrsgx_heaps(sdev)->pb_max_pages would avoid thi=
s.

> +
> +	if (!pb)
> +		return ERR_PTR(-ENOMEM);
> +	kref_init(&pb->ref);
> +	pb->sdev =3D sdev;
> +
> +	/* The PB, and what is addressed from its 1 MiB-aligned base, in the VM=
. */
> +	err =3D pvrsgx_kobj_new(sdev, &pb->buf, PVRSGX_KRANGE_3DPARAMS, pages <=
< PAGE_SHIFT, 0, NULL);
> +	if (err)
> +		goto fail;
> +	pb->base =3D kobj_va(pb->buf) & 0xfff00000;
> +	err =3D pvrsgx_kobj_new(sdev, &pb->freelist, PVRSGX_KRANGE_3DPARAMS, FR=
EELIST_BYTES, pb->base,
> +			      NULL);
> +	err =3D err ?: pvrsgx_kobj_new(sdev, &pb->desc, PVRSGX_KRANGE_KDATA,
> +				     sizeof(struct pvrsgx_fw_pb_desc), 0, NULL);
> +	if (pb->desc)
> +		pb->desc->until_restart =3D true;
> +	err =3D err ?: pvrsgx_kobj_new(sdev, &pb->blocks, PVRSGX_KRANGE_KDATA, =
0x10, 0, NULL);
> +	if (err)
> +		goto fail;
> +
> +	pb->pages =3D pages;
> +	pb_init(pb);
> +	pb->fw_gen =3D sdev->fw_gen;
> +	return pb;
> +
> +fail:
> +	pvrsgx_pb_put(pb);
> +	return ERR_PTR(err);
> +}
[ ... ]
> +/* The device's PB, created by the first render context; the device keep=
s one reference. */
> +static struct pvrsgx_pb *dev_pb_get(struct pvrsgx_device *sdev, u32 req_=
pages)
> +{
> +	struct pvrsgx_pb *pb;
> +
> +	mutex_lock(&sdev->pb_lock);
> +	if (!sdev->pb) {
> +		pb =3D pb_create(sdev, req_pages);
> +		if (IS_ERR(pb)) {
> +			mutex_unlock(&sdev->pb_lock);
> +			return pb;
> +		}
> +		sdev->pb =3D pb;
> +		drm_info(&sdev->base, "parameter buffer: %#x pages\n", pb->pages);
> +	} else if (req_pages && req_pages !=3D sdev->pb->pages - PB_EXTRA_PAGES=
) {
> +		/* A size the live buffer doesn't have is refused, not ignored. */
> +		mutex_unlock(&sdev->pb_lock);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	pb =3D sdev->pb;
> +	kref_get(&pb->ref);
> +	mutex_unlock(&sdev->pb_lock);
> +	return pb;
> +}

[Severity: Medium]
What happens if pb_create() fails after allocating pb->buf, or if
pvrsgx_render_ctx_init() fails after dev_pb_get() publishes sdev->pb?

If pb->freelist, pb->desc, or pb->blocks fails to allocate, pvrsgx_pb_put()
drops pb->buf into sdev->graveyard while no render context exists to run a
render job and reap it.  A retry of pb_create() then allocates the new pb->=
buf
after the unreaped one in PVRSGX_KRANGE_3DPARAMS, so pb->base
(kobj_va(pb->buf) & 0xfff00000) no longer matches params_3d.base, which
pb_init() uses to index free-list page numbers.

Similarly, dev_pb_get() assigns sdev->pb with the device's permanent refere=
nce
before pvrsgx_pb_map() and the remaining allocations in
pvrsgx_render_ctx_init() succeed, so a failure there leaves sdev->pb
permanently locked to the failed context's requested page count.

[ ... ]
> +static void rtds_release(struct kref *ref)
> +{
> +	struct pvrsgx_rt_dataset *s =3D container_of(ref, struct pvrsgx_rt_data=
set, ref);
> +	struct pvrsgx_device *sdev =3D s->ctx->sdev;
> +
> +	pvrsgx_kobj_drop(sdev, &s->rtword);
> +	pvrsgx_kobj_drop(sdev, &s->rtdata);
> +	pvrsgx_kobj_drop(sdev, &s->done);
> +	pvrsgx_kobj_drop(sdev, &s->tailptr);
> +	pvrsgx_kobj_drop(sdev, &s->ta40);
> +	pvrsgx_kobj_drop(sdev, &s->ta50);
> +	for (int i =3D 0; i < 2; i++) {
> +		pvrsgx_kobj_drop(sdev, &s->bgblock[i]);
> +		pvrsgx_kobj_drop(sdev, &s->rd[i]);
> +		pvrsgx_kobj_drop(sdev, &s->rd_w8[i]);
> +		pvrsgx_kobj_drop(sdev, &s->rd_w4[i]);
> +		pvrsgx_kobj_drop(sdev, &s->hwsync[i]);
> +		pvrsgx_kobj_drop(sdev, &s->rd_sync[i]);
> +		pvrsgx_kobj_drop(sdev, &s->hwsync_access[i]);
> +		pvrsgx_kobj_drop(sdev, &s->entword[i]);
> +		pvrsgx_kobj_drop(sdev, &s->rgn[i]);
> +		pvrsgx_kobj_drop(sdev, &s->ta88[i]);
> +	}
> +	pvrsgx_context_put(s->ctx);
> +	kfree(s);
> +}
[ ... ]
> +int pvrsgx_ioctl_destroy_rt_dataset(struct drm_device *drm, void *data, =
struct drm_file *file)
> +{
> +	struct drm_powervr_sgx_ioctl_destroy_rt_dataset_args *args =3D data;
> +	struct pvrsgx_rt_dataset *s;
> +
> +	if (args->_padding_4)
> +		return -EINVAL;
> +	s =3D xa_erase(&to_pvrsgx_file(file)->rtds, args->handle);
> +	if (!s)
> +		return -ENOENT;
> +	pvrsgx_rtds_put(s);
> +	return 0;
> +}

[Severity: Medium]
Can a client exhaust the device-wide krange allocators by repeatedly creati=
ng
and destroying RT datasets or contexts without submitting a render job?

pvrsgx_ioctl_destroy_rt_dataset() erases the handle from sfile->rtds
immediately, allowing the client to allocate new datasets past
PVRSGX_MAX_FILE_RTDS, while rtds_release() (and similarly
pvrsgx_render_ctx_fini() and pvrsgx_transfer_ctx_fini()) places all kernel
objects onto sdev->graveyard via pvrsgx_kobj_drop() even when no render job=
 has
ever used them.  Because pvrsgx_kobj_reap() only frees graveyard objects on=
ce
sdev->renders_done advances past o->grave_seq or the GPU resets, creating a=
nd
destroying unused datasets or contexts in a loop fills PVRSGX_KRANGE_TADATA=
 and
PVRSGX_KRANGE_KDATA with unreaped objects and causes -ENOSPC for all client=
s.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D10
