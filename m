Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B3DCDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DBD10E59F;
	Mon, 22 Jun 2026 09:20:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X9TAW8jU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9042F10E59F
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:20:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EA4660051;
 Mon, 22 Jun 2026 09:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9726E1F000E9;
 Mon, 22 Jun 2026 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782120007;
 bh=kKAilk5qqpVBiLafXwXmFXLvRZnfG5Wodfnp1sUTTcs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X9TAW8jUH94AzJ0mbUMqzmdOKtQUqj7q+11M/ZhPa7joU85xT79fVCLYMxHI3ov26
 dQkjjcT9VaBfaogvFhsGB7tUBxhLSw6qooQKdJYc/wnNOVlG5nqX6+vyuKUmRl62+/
 6AJm6AjgDcjALfwQzKxDjz5sVTu9pmRnJ/04FpY0PtcIO0OiX7XyzqHofz8gEuE4O9
 dFoHV2SI5mxTwgkCM0sowkJxO7IbCn3fbR3Nvjpw17VMdssvOE0MNHi8Trc4rFqCUb
 Mz+eQQFrXr3qlf7lxKRYB3hq2k1zFK5f5106etyAiW3i994RWM2bhfHo5hdA/XVbTh
 3Qr+RmSgogLJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <1782119053308910.17261.seg@mailgw.kylinos.cn>
References: <20260622035454.28003-1-zenghongling@kylinos.cn>
 <1782119053308910.17261.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 09:20:07 +0000
Message-Id: <20260622092007.9726E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of the RPC message buffer in r535_gsp_rpc_push() when =
an error occurs while sending large payloads.
- [High] Malformed GSP firmware messages cause a NULL pointer dereference v=
ia nvkm_gsp_rm_ctrl_rd().
--

commit f3a9eeee67cd9b42fd2bbb4cf7eff6681fafba12
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage

This commit cleans up the usage of IS_ERR_OR_NULL in
r535_bar_bar2_update_pde() by using IS_ERR() instead, matching the
actual return value contract of nvkm_gsp_rpc_get() which never returns
NULL.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
> index fae08ac3b18c7..9cd68f8622d36 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c
> @@ -55,7 +55,7 @@ r535_bar_bar2_update_pde(struct nvkm_gsp *gsp, u8 page_=
shift, u64 pdbe)
>  	rpc_update_bar_pde_v15_00 *rpc;
> =20
>  	rpc =3D nvkm_gsp_rpc_get(gsp, NV_VGPU_MSG_FUNCTION_UPDATE_BAR_PDE, size=
of(*rpc));
> -	if (WARN_ON(IS_ERR_OR_NULL(rpc)))
> +	if (WARN_ON(IS_ERR(rpc)))
>  		return -EIO;
> =20
>  	rpc->info.barType =3D NV_RPC_UPDATE_PDE_BAR_2;

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this cleanup,
I noticed another IS_ERR_OR_NULL usage in r535_gsp_rpc_rm_ctrl_push() that
causes a NULL pointer dereference.

When a malformed GSP firmware message is received:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_msgq_recv() {
    ...
	if (WARN_ON(rpc->length > max_rpc_size))
		return NULL;
    ...
}

This NULL propagates to r535_gsp_rpc_rm_ctrl_push():

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/ctrl.c:r535_gsp_rpc_rm_ctrl=
_push() {
    ...
	rpc =3D nvkm_gsp_rpc_push(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV, repc);
	if (IS_ERR_OR_NULL(rpc)) {
		*params =3D NULL;
		return PTR_ERR(rpc);
	}
    ...
}

Does PTR_ERR(rpc) evaluate to 0 here when rpc is NULL? If so, this erroneou=
sly
signals success to callers like nvkm_gsp_rm_ctrl_rd(), which will then
blindly dereference the NULL pointer. Could this be handled differently so
an error code is returned instead?

[Severity: High]
This isn't a bug introduced by this patch, but looking at r535_gsp_rpc_push=
(),
could there be a memory leak of the RPC message buffer when an error occurs
while sending large payloads?

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_rpc_push() {
    ...
	if (payload_size > max_payload_size) {
    ...
		while (remain_payload_size) {
			u32 size =3D min(remain_payload_size,
				       max_payload_size);

			next =3D r535_gsp_rpc_get(gsp, NV_VGPU_MSG_FUNCTION_CONTINUATION_RECORD,=
 size);
			if (IS_ERR(next)) {
				repv =3D next;
				goto done;
			}
    ...
		if (!IS_ERR(repv))
			kvfree(msg);
	} else {
    ...
done:
	mutex_unlock(&gsp->cmdq.mutex);
	return repv;
}

When IS_ERR(next) is true during chunking, the execution jumps to the done
label, bypassing the kvfree(msg) cleanup logic. The caller function then se=
ts
its pointer to NULL on error, losing the reference to the original msg
buffer. Does this result in a resource leak on this error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622035454.2800=
3-1-zenghongling@kylinos.cn?part=3D4
