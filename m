Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38504CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 04:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79BA110E453;
	Mon, 22 Jun 2026 04:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a8SstM+u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A4110E453
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 04:07:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E68324322E;
 Mon, 22 Jun 2026 04:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5971F000E9;
 Mon, 22 Jun 2026 04:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782101278;
 bh=3zjXoVpOVbXZJ0xbX6Cq7WZ14E/imG4WLyqFoNMDMxE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a8SstM+uYss+EeX7q/S2jAVGNiWqg/32IED/IGa3uba9ViipiONET90jux4tj1O/x
 iAnskq7+HriARbCqvWl7zByDKkQXl/KAGfv8l7Sk1ZN3jzWx7dtIEo2h8h5HMDWw94
 DBFJAZK3oSgNWPz99rqkQBuZY8GEmqsb5nhPPmuK0y1MNO9YWGaAC7hEGZLTdcah0t
 0GXTbWGkFUk7v/dUc0amoNKSrxZjMQtvyYe4tmb0SPRbo9CoakNIP/AzY//0fze/0n
 Ukuuu6kOSM/CcmH3TMwuVy40Wcool4ZLCNxQZZhs2XUqhBu/gQ842AA4Vd1/ypVqAa
 sjLq/92E7BHSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622035454.28003-5-zenghongling@kylinos.cn>
References: <20260622035454.28003-1-zenghongling@kylinos.cn>
 <20260622035454.28003-5-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:07:58 +0000
Message-Id: <20260622040758.AB5971F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Large GSP RPC messages are leaked when an error occurs during chun=
ked transmission.
--

commit fa8eea5c56bcb72beec86aeaab70f0ec3eed80b9
Author: Hongling Zeng <zenghongling@kylinos.cn>

nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage

r535_bar_bar2_update_pde() calls nvkm_gsp_rpc_get() which never
returns NULL, only valid pointers or error pointers. Clean up by
using IS_ERR() instead, matching the actual return value contract.

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
This is a pre-existing issue, but while looking at the GSP RPC handling, I
noticed a potential memory leak in r535_gsp_rpc_push().

When transmitting large GSP RPC payloads (where payload_size is larger than
max_payload_size), the original large message buffer (msg) can be leaked if
an error occurs.

If an error occurs during the chunking process, such as failing to allocate
a smaller chunk, the code jumps to the done label:

drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_rpc_push() {
    ...
		next =3D r535_gsp_rpc_get(gsp, NV_VGPU_MSG_FUNCTION_CONTINUATION_RECORD, =
size);
		if (IS_ERR(next)) {
			repv =3D next;
			goto done;
		}
    ...

The same happens if there's a timeout or error from r535_gsp_rpc_send():

			repv =3D r535_gsp_rpc_send(gsp, next, NVKM_GSP_RPC_REPLY_NOWAIT, 0);
			if (IS_ERR(repv))
				goto done;
    ...

Also, if r535_gsp_rpc_handle_reply() returns an error, the code skips the f=
ree:

		/* Wait for reply. */
		repv =3D r535_gsp_rpc_handle_reply(gsp, fn, policy, payload_size +
						 sizeof(*rpc));
		if (!IS_ERR(repv))
			kvfree(msg);
	} else {
    ...
done:
	mutex_unlock(&gsp->cmdq.mutex);
	return repv;
}

Since the done label only drops the mutex and returns, doesn't this
permanently leak the msg buffer on any of these error paths?

Could this exacerbate memory pressure or lead to out of memory conditions if
large RPC transmissions repeatedly fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622035454.2800=
3-1-zenghongling@kylinos.cn?part=3D4
