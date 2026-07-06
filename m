Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F37C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99D810E23A;
	Mon,  6 Jul 2026 09:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HlxWdpUh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA3CF10E23A
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:55:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2652160018;
 Mon,  6 Jul 2026 09:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8461F00A3A;
 Mon,  6 Jul 2026 09:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783331745;
 bh=l5OIFrcqupCLq1dpOF23c/hiLfDgrMyF8pQaQRz1Ye8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HlxWdpUh20G2TI6uvBjTP/M8ucCzWEWAJ/eV0sm335k6OvdQTtPaNuvOA0Fj4+YrQ
 6XaO7mkhiya1wTMVDbvpVoU0hK7uzA70GVQi2uOM3nPle1yDoUrleRu/9MbkPXi0QI
 cCHFFzCdiU1nG7Cx3zCNRv+Yb8OrCEwWIqOJ7GxlV88mwWymBl3B8FfSF/attVfyrz
 7Z9K+uJp2FrS/2WcxI+5tG3m9R7Zvs4GmOonR/TbLj8/x5WoLAtQp5jDDZT/XR4EqG
 k9GXjbSs3lMReDV0tCh7MSP04dvqqGV6bUcTsaiJVTaLrq6GlnvYRvK6ZwJdjHHZOk
 x7gIAXI03/xHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau: validate MXMS descriptor bounds
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706093949.82126-1-pengpeng@iscas.ac.cn>
References: <20260706093949.82126-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:55:45 +0000
Message-Id: <20260706095545.AE8461F00A3A@smtp.kernel.org>
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
- [High] Missing validation of the ACPI WMI evaluation output can cause a N=
ULL pointer dereference.
--

commit d046b4257d93287fd7148175e8bfb0fc2ce27ed6
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

drm/nouveau: validate MXMS descriptor bounds

This commit adds bounds checking for MXMS descriptors. It retains the provi=
der
buffer size with the MXMS data, validates fixed headers, and verifies
descriptor arrays against the remaining buffer size.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/mxm/base.c
> index 26ec50b66e667..ad74a216a201d 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c

[ ... ]

> @@ -188,6 +201,8 @@ mxm_shadow_wmi(struct nvkm_mxm *mxm, u8 version)
>  	if (obj->type =3D=3D ACPI_TYPE_BUFFER) {

[Severity: High]
This is a pre-existing issue, but can wmi_evaluate_method() return success
while leaving retn.pointer as NULL?

If the BIOS WMI implementation returns void, obj (assigned from retn.pointer
just before this block) would be NULL. Does this code risk a NULL pointer
dereference around line 197 when accessing obj->type in mxm_shadow_wmi() in
base.c without verifying the pointer first?

A similar condition appears to exist around line 153 in wmi_wmmx_mxmi() whe=
re
retn.pointer is also dereferenced without validation.

>  		mxm->mxms =3D kmemdup(obj->buffer.pointer,
>  				    obj->buffer.length, GFP_KERNEL);
> +		if (mxm->mxms)
> +			mxm->mxms_size =3D obj->buffer.length;
>  	}
> =20
>  	kfree(obj);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706093949.8212=
6-1-pengpeng@iscas.ac.cn?part=3D1
