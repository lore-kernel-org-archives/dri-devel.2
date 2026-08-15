Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D984C5B572
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 00:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5974E10F796;
	Sat, 15 Aug 2026 00:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i7gw5nJt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F61310F793
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 00:08:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 889674018F;
 Sat, 15 Aug 2026 00:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E9E1F000E9;
 Sat, 15 Aug 2026 00:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786752525;
 bh=OH0Y4saNg4iMQ2NPzh+/QWV5+c+M4phGdApT9c/DHr0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i7gw5nJtcb+hXDpU4+VC/NVpa3OkKUp4wuZSWJ/Kt8WsxsjFB3Wk2hdAjpiEacMgB
 48D789jVjxsbUGjg4pOHpP8Y81RePYHli4Th/b6+Rzp1nhpoTvtLZv3JxfULtEA6xq
 8Ujtt19DfTd6XGrMtzgL4VxMuC+I8p7zSwYwN54WWPM4JpxaNsvLAaBT1Bx4ood2nk
 vtXeh7VEZej5/+B9DQl3fm1XgDxOiJW+42zrzdaSSN/pLvAy6GSZu7LfE+dIJMnZuf
 YcnrAMve6ZNy8a/ebmUY5VX940xJPUJizqQb8K4kgnDBjOcphOwSUtcdcAUuT2VUVk
 6Lg3JNXVrjygA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] nouveau/gsp: fix vblank interrupts on GB20x
To: "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814235705.59132-6-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
 <20260814235705.59132-6-mohamedahmedegypt2001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 00:08:44 +0000
Message-Id: <20260815000845.41E9E1F000E9@smtp.kernel.org>
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
- [High] NULL pointer dereference in `nvkm_uhead_mthd_scanoutpos` due to mi=
ssing `.rgpos` callback in `gb202_head`.
- [Low] Build failure due to undeclared identifier `r535_head_state` in `gb=
202_head` struct.
--

--- Patch [5]: [PATCH 5/7] nouveau/gsp: fix vblank interrupts on GB20x ---
commit f0249296d0fe470f2e8d8e3f163056c84c1f8f5d
Author: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>

nouveau/gsp: fix vblank interrupts on GB20x

The GSP path programs per-head timing (vblank) interrupts the same way on
every generation. NVD5.0 (GB20x) reworked the FE interrupt frontend
around four message-based kernel vectors and moved RM head-timing
interrupts to the dedicated low-latency vector. This patch selects the
head functions and interrupt handler per generation to fix vblank interrupt=
s.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> index fd473b4d12a82..bc91d46e646d5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
[ ... ]
> @@ -692,6 +692,33 @@ r535_head =3D {
>  	.vblank_put =3D r535_head_vblank_put,
>  };
> =20
[ ... ]
> +static const struct nvkm_head_func
> +gb202_head =3D {
> +	.state =3D r535_head_state,

[Severity: Low]
Does r535_head_state exist? It appears this might cause a build failure
due to an undeclared identifier. The existing r535_head struct uses
gv100_head_state for this field.

[Severity: High]
Is it safe to omit the rgpos callback here?

When userspace queries the head scanout position via NVIF_HEAD_V0_SCANOUTPO=
S,
execution goes to nvkm_uhead_mthd_scanoutpos(), which unconditionally
dereferences head->func->rgpos:

    head->func->rgpos(head, &args->v0.hline, &args->v0.vline);

Without rgpos being set on gb202_head, will this cause a NULL pointer
dereference when accessed from userspace?

> +	.vblank_get =3D gb202_head_vblank_get,
> +	.vblank_put =3D gb202_head_vblank_put,
> +};
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814235705.5913=
2-1-mohamedahmedegypt2001@gmail.com?part=3D5
