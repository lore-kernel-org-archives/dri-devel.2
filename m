Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E767CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C02FD10E52C;
	Mon, 22 Jun 2026 08:23:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bO09jtH2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8030E10E537
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:23:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43F5B4169E;
 Mon, 22 Jun 2026 08:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A191F000E9;
 Mon, 22 Jun 2026 08:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782116619;
 bh=54QIKc66Ahp/i/yKG2oo30lo5KXad6dSbMRrZU6DdwM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bO09jtH2MMihkoFIbBSh2FhTrdWF4+UQv6Ft6VvpCSwPuI9s8Tfs1a01hUjol7LCL
 IU4RQq/Fz6Jnghzdb6L4N8XqI9XLY9uMcKVEKd0RUod0MsU8UvAO2txa4FUWXFCGMT
 sGEmALOYbV4lRvyJESfo3NG3BpE73liCDrFUFnI6rxCICRaI7ZRKRBhD37hd6uUdNM
 1M8arTuxpaMDwo+gitfrXBpKi0GcFumBFuzXtj1SF55JdmbfzC0nzH8MZ8MgVFhas8
 LoyhKQMlZN1q/BxIKTVgMy6FAL2BU08yZzcjER35uAQwuf6s0Qlf57owzgQLWMnGUC
 mRBGOStnTXnIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] nouveau/gsp/rm/bar: Cleanup IS_ERR_OR_NULL usage
To: "Hongling Zeng" <zenghongling@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622081136.61695-5-zenghongling@kylinos.cn>
References: <20260622081136.61695-1-zenghongling@kylinos.cn>
 <20260622081136.61695-5-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 08:23:38 +0000
Message-Id: <20260622082339.02A191F000E9@smtp.kernel.org>
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
- [High] Leak of the original RPC message buffer `msg` in error paths of `r=
535_gsp_rpc_push()` when `payload_size > max_payload_size`.
--

commit c9821a8788c2a50e0c5a5dcb65a00cbd271b7c0b
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

[Severity: High]
This is a pre-existing issue, but does r535_gsp_rpc_push() leak the original
RPC message buffer msg on error paths when payload_size > max_payload_size?

In drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/rpc.c:r535_gsp_rpc_push(=
),
when the message is chunked, kvfree(msg) is called on the success path:

		next =3D r535_gsp_rpc_get(gsp, fn, max_payload_size);
		if (IS_ERR(next)) {
			repv =3D next;
			goto done;
		}
...
		repv =3D r535_gsp_rpc_handle_reply(gsp, fn, policy, payload_size +
						 sizeof(*rpc));
		if (!IS_ERR(repv))
			kvfree(msg);
	}
...
done:
	mutex_unlock(&gsp->cmdq.mutex);
	return repv;

If r535_gsp_rpc_get() fails, it jumps to done and returns without freeing
msg. Similarly, if r535_gsp_rpc_handle_reply() returns an error pointer,
msg is not freed because kvfree(msg) is guarded by !IS_ERR(repv).

Since these allocations can be large, can this cause a resource leak if the
RPC communications fail under load?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622081136.6169=
5-1-zenghongling@kylinos.cn?part=3D4
