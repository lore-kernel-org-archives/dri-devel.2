Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CF7C88E65
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFCD110E8E7;
	Sun, 13 Sep 2026 13:12:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R+/zRLQf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7309E10E8E7
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:12:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDB1560E10;
 Sun, 13 Sep 2026 13:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5371F1F000FF;
 Sun, 13 Sep 2026 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789305154;
 bh=ut0dHxqKw2c4wnSZYx14YkHnMVBxVdZyz7CDlaOvYv4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R+/zRLQfd62WXsVVPaUBW3lcuRmobRDkHV/Yz8Whqbg+nAGmtvdtl3fNGs8VJZfGd
 W/oAiog2uOTpEddRP8n8+BsDTD4DgjDE2zghioaW+GBnKFC1nkowY/D9PzBLEOn7AM
 rWXL/PfzBbgvq63ZpyO3VqbFJUW8KgjoE2xBVcQfMXsY5mdMU01opbII3EQCkvw3IO
 MMZLDQP+nyZNgnRndrrJomPxMpWaL9tRpi5waVm62KO32NIijoV/+Pri7kd9Yy/jR8
 b6dWwMIadikVET/wzhwZXRmxv7wiEP6jMl5wwaDJ+yFTlQP9pA5/kZWXfkT+AMXWAc
 tJfMoZL4rCgnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/qaic: tolerate absent crashdump state during cleanup
To: "Slavin Liu" <bolin.liu@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260913125201.109964-1-bolin.liu@seu.edu.cn>
References: <20260913125201.109964-1-bolin.liu@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 13:12:33 +0000
Message-Id: <20260913131234.5371F1F000FF@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing synchronization for `ssr_crash->dump_info` leads to Use-Af=
ter-Free when accessed concurrently.
- [High] LIFO teardown ordering of DRM managed resources causes a Use-After=
-Free of `ssr_crash` in the workqueue.
- [High] Unchecked dereference of `ssr_crash` in `dbg_xfer_done_rsp` allows=
 a malicious device to trigger a NULL pointer dereference.
- [High] Missing bounds checking on device-provided table entry sizes cause=
s an integer overflow and out-of-bounds write.
- [High] Transient `ERR_PTR` stored in the globally visible `ssr_crash->dum=
p_info` causes an invalid pointer dereference.
- [High] The `ssr_resp` receive buffer is permanently leaked if crashdump c=
ollection is aborted midway.
- [High] Missing synchronization between driver removal and the background =
workqueue leads to a NULL pointer dereference.
--

commit a18c3aaed1362f868bb5aefbf5fef4faf6c47707
Author: Slavin Liu <bolin.liu@seu.edu.cn>

accel/qaic: tolerate absent crashdump state during cleanup

A negative response can be sent before crashdump state is assigned.
If queuing that response fails, cleanup receives NULL. Treat that as
no owned crashdump resources instead of dereferencing it.

> diff --git a/drivers/accel/qaic/qaic_ssr.c b/drivers/accel/qaic/qaic_ssr.c
> index 418f14936f9a0..3eba7b1846b20 100644
> --- a/drivers/accel/qaic/qaic_ssr.c
> +++ b/drivers/accel/qaic/qaic_ssr.c
> @@ -195,7 +195,11 @@ struct dump_file_meta {
> =20
>  static void free_ssr_dump_info(struct ssr_crashdump *ssr_crash)
>  {
> -	struct ssr_dump_info *dump_info =3D ssr_crash->dump_info;
> +	struct ssr_dump_info *dump_info;
> +
> +	if (!ssr_crash)
> +		return;
> +	dump_info =3D ssr_crash->dump_info;
> =20
>  	ssr_crash->dump_info =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does this clear the pointer =
and
proceed to free the structure locklessly?

A concurrently executing MHI asynchronous callback qaic_ssr_mhi_ul_xfer_cb
reads the pointer without locks:

drivers/accel/qaic/qaic_ssr.c:qaic_ssr_mhi_ul_xfer_cb() {
    ...
    dump_info =3D ssr_crash->dump_info;
    if (dump_info) {
        dump_info->read_buf_req_queued =3D false;
        return;
    }
    ...
}

Can this lead to a use-after-free write if the asynchronous callback races =
with
the worker thread cleanup?

>  	if (!dump_info)
>  		return;

[Severity: High]
This is a pre-existing issue, but does free_ssr_dump_info() permanently leak
the ssr_resp receive buffer if crashdump collection is aborted midway?

A single MHI receive buffer is allocated and temporarily stored in
dump_info->resp while crashdump collection occurs:

drivers/accel/qaic/qaic_ssr.c:ssr_worker() {
    ...
    dump_info->resp =3D resp;
    ...
}

When the structure is freed, the pointer is lost:

drivers/accel/qaic/qaic_ssr.c:free_ssr_dump_info() {
    ...
    kfree(dump_info);
}

Does this drop the pointer without requeuing or freeing it?

[Severity: High]
This isn't a bug introduced by this patch, but does the LIFO teardown order=
ing
of DRM managed resources cause a use-after-free of ssr_crash in the workque=
ue?

The workqueue is registered for DRM managed destruction first:

drivers/accel/qaic/qaic_drv.c:create_qdev() {
    ...
    qdev->ssr_wq =3D qaicm_wq_init(drm, "qaic_ssr");
    ...
}

The struct is registered later, meaning it will be freed before the workque=
ue
is flushed and destroyed:

drivers/accel/qaic/qaic_ssr.c:qaic_ssr_init() {
    ...
    ssr_crash =3D drmm_kzalloc(drm, SSR_MHI_BUF_SIZE, GFP_KERNEL);
    ...
}

During the teardown flush, the worker dereferences the already-freed ssr_cr=
ash
object:

drivers/accel/qaic/qaic_ssr.c:ssr_dump_worker() {
    struct ssr_crashdump *ssr_crash =3D container_of(work,
                                                   struct ssr_crashdump,
                                                   work);
    ...
}

[Severity: High]
This is a pre-existing issue, but is there an unchecked dereference of
ssr_crash in dbg_xfer_done_rsp()?

If memory allocation fails during probe, qdev->ssr_mhi_buf is left as NULL.
If a malicious device sends an unsolicited response, it unconditionally
dereferences it:

drivers/accel/qaic/qaic_ssr.c:dbg_xfer_done_rsp() {
    struct ssr_crashdump *ssr_crash =3D qdev->ssr_mhi_buf;
    ...
    dump_info =3D ssr_crash->dump_info;
    ...
}

Could this allow a misbehaving or compromised endpoint device to trigger a
NULL pointer dereference?

[Severity: High]
This isn't a bug introduced by this patch, but does the missing bounds
checking on device-provided table entry sizes cause an integer overflow?

In alloc_dump(), the device-controlled lengths are accumulated without over=
flow
checks:

drivers/accel/qaic/qaic_ssr.c:alloc_dump() {
    ...
    while (tbl_sz_lp < dump_info->tbl_len) {
        ...
        dump_size +=3D tbl_ent->len;
        ...
    }
    ...
}

This can cause an undersized allocation. Later, an out-of-bounds copy occurs
using the original lengths:

drivers/accel/qaic/qaic_ssr.c:ssr_copy_dump() {
    ...
    memcpy(dump_info->dump_addr + dump_info->dump_off, data, len);
    ...
}

Can a compromised endpoint device exploit this to cause a heap buffer overf=
low?

[Severity: High]
This is a pre-existing issue, but does assigning an error pointer to
ssr_crash->dump_info cause an invalid pointer dereference?

If alloc_dump_info() fails, it temporarily exposes an ERR_PTR to a shared
global state accessible by concurrent interrupt handlers:

drivers/accel/qaic/qaic_ssr.c:dbg_xfer_info_rsp() {
    ...
    ssr_crash->dump_info =3D alloc_dump_info(qdev, debug_info);
    if (IS_ERR(ssr_crash->dump_info)) {
        ...
    }
    ...
}

If qaic_ssr_mhi_ul_xfer_cb() executes concurrently, it checks if (dump_info=
),
which evaluates to true for an ERR_PTR, and attempts to dereference it. Can
this lead to a kernel panic?

[Severity: High]
This isn't a bug introduced by this patch, but is there missing synchroniza=
tion
between driver removal and the background workqueue?

When the driver is removed, it zeroes out the MHI device pointer while
background workqueue tasks that depend on it may still be executing:

drivers/accel/qaic/qaic_ssr.c:qaic_ssr_mhi_remove() {
    ...
    mhi_unprepare_from_transfer(qdev->ssr_ch);
    qdev->ssr_ch =3D NULL;
}

A concurrently executing worker attempts to queue a buffer using the NULL
pointer:

drivers/accel/qaic/qaic_ssr.c:dbg_xfer_info_rsp() {
    ...
    ret2 =3D mhi_queue_buf(qdev->ssr_ch, DMA_TO_DEVICE, debug_rsp,
                         sizeof(*debug_rsp), MHI_EOT);
    ...
}

Can an administrator unbinding the driver while the device is actively send=
ing
events trigger a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913125201.1099=
64-1-bolin.liu@seu.edu.cn?part=3D1
