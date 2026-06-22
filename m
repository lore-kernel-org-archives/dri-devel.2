Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB187CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A1810E540;
	Mon, 22 Jun 2026 08:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DX1xqPp/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7C010E540
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:36:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 81AB46001A;
 Mon, 22 Jun 2026 08:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE1F1F00A3A;
 Mon, 22 Jun 2026 08:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782117404;
 bh=BdDrnGi78sfw/s22MNfFZjD9Pme2k/sUYscnurMjEdk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DX1xqPp/F4n5cGFq56Sdq7r7/S/FdUQjQdkj0JPBhQ9Pyku+zrg0n+09K5IYzWWMu
 1ET9H9TxF8SY4Ekn7YbmP6EAvLvB2/oDGOAmpO4cS9uVyEuS5VIcEOHqd3XcH5kwvN
 /5PjfnrN846fKCoJqlnaOSkVCTuXDzfKEQuq7APUQbqfmV0Lnk+s05Ak6ZSUQ5xhu9
 icqqD3AM6RxBu6WVm6UlgXL7vo2WXX7Ise8v1ths3sO12UMlCGzvZ9OLshhTpdfBW4
 GaXHzKIZaYddQs80+PeJHvPHRVAL62e7RkMJh2/O9yPHiacCAAxY6ZhVZHBBgexw7z
 jEKN9DgJjV34w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] nouveau/gsp: Cleanup IS_ERR_OR_NULL in
 nvkm_gsp_rpc_rd()
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622081136.61695-6-zenghongling@kylinos.cn>
References: <20260622081136.61695-1-zenghongling@kylinos.cn>
 <20260622081136.61695-6-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:36:43 +0000
Message-Id: <20260622083644.1CE1F1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer underflow in `r535_gsp_msgq_recv_one_elem` due to miss=
ing lower bounds check on `rpc->length` causes massive out-of-bounds memory=
 copy.
- [Critical] A Time-of-Check to Time-of-Use (TOCTOU) double-fetch vulnerabi=
lity in `r535_gsp_msgq_recv` allows a malicious GSP firmware to cause a ker=
nel heap buffer overflow.
- [High] NULL pointer dereference when `r535_gsp_msgq_recv()` encounters an=
 invalid RPC message size.
- [High] Out-of-bounds memory reads due to unvalidated array counts from fi=
rmware in `r535_gsp_intr_get_table` and `r535_gsp_get_static_info_fb`.
--

commit 88b24214ef8688e688f55f1aef5cd0f776cdce80
Author: Hongling Zeng <zenghongling@kylinos.cn>
Subject: nouveau/gsp: Cleanup IS_ERR_OR_NULL in nvkm_gsp_rpc_rd()

This commit cleans up the error checking in nvkm_gsp_rpc_rd(). Since
nvkm_gsp_rpc_get() returns only valid pointers or error pointers, the
code is updated to use IS_ERR() instead of IS_ERR_OR_NULL() to match the
actual API contract.

> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h b/drivers/=
gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> index 64fed208e4cf8..a061779e0107b 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> @@ -293,7 +293,7 @@ nvkm_gsp_rpc_rd(struct nvkm_gsp *gsp, u32 fn, u32 arg=
c)
>  {
>  	void *argv =3D nvkm_gsp_rpc_get(gsp, fn, argc);
> =20
> -	if (IS_ERR_OR_NULL(argv))
> +	if (IS_ERR(argv))
>  		return argv;
> =20
>  	return nvkm_gsp_rpc_push(gsp, argv, NVKM_GSP_RPC_REPLY_RECV, argc);

[Severity: High]
This isn't a bug introduced by this patch, but if r535_gsp_msgq_recv()=20
returns NULL when rpc->length exceeds max_rpc_size, doesn't this bubble up=
=20
through nvkm_gsp_rpc_push() and nvkm_gsp_rpc_rd()?=20

If callers like r535_gsp_get_static_info() only check IS_ERR(), won't they=
=20
dereference NULL?=20

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c:r535_gsp_get_static_i=
nfo() {
    ...
	rpc =3D nvkm_gsp_rpc_rd(gsp, NV_VGPU_MSG_FUNCTION_GET_GSP_STATIC_INFO, siz=
eof(*rpc));
	if (IS_ERR(rpc))
		return PTR_ERR(rpc);

	gsp->internal.client.object.client =3D &gsp->internal.client;
	...
	gsp->internal.client.object.handle =3D rpc->hInternalClient;
    ...
}

Should r535_gsp_msgq_recv() return an error pointer like ERR_PTR(-EIO)=20
instead of NULL to match this API contract?

[Severity: High]
This is a pre-existing issue, but does r535_gsp_intr_get_table() properly=20
bound its iteration over ctrl->tableLen?=20

If a faulty firmware provides a count larger than=20
NV2080_CTRL_INTERNAL_INTR_MAX_TABLE_SIZE, won't this loop read out-of-bound=
s=20
into adjacent memory?=20

Similarly, does r535_gsp_get_static_info_fb() need to verify=20
info->numFBRegions against the fbRegion array bounds before iterating?

[Severity: Critical]
This isn't a bug introduced by this patch, but is there a missing lower=20
bounds check for rpc->length in r535_gsp_msgq_recv()?=20

If rpc->length is 0, len evaluates to 0 for continuation records in=20
r535_gsp_msgq_recv_one_elem(). Doesn't len - sizeof(struct nvfw_gsp_rpc)=20
then underflow, causing a massive out-of-bounds memory copy?

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msgq_recv_on=
e_elem() {
    ...
	if (info->continuation)
		memcpy(buf, mqe->data + sizeof(struct nvfw_gsp_rpc),
		       len - sizeof(struct nvfw_gsp_rpc));
    ...
}

[Severity: Critical]
This is a pre-existing issue, but does r535_gsp_msgq_recv() safely handle=20
rpc->length from shared memory?=20

It appears the firmware-provided rpc->length is read directly from mqe->dat=
a=20
three times. If a malicious firmware increases this value after the bounds=
=20
check and allocation, but before info.gsp_rpc_len =3D rpc->length, couldn't=
=20
r535_gsp_msgq_recv_one_elem() cause a heap overflow when copying up to=20
info.gsp_rpc_len bytes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622081136.6169=
5-1-zenghongling@kylinos.cn?part=3D5
