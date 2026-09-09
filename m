Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0EAC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D72E10F1A3;
	Wed,  9 Sep 2026 13:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X2bhPCG3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD4E10F18E
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:54:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86F8E6020A;
 Wed,  9 Sep 2026 13:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D19F1F00A3A;
 Wed,  9 Sep 2026 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788962095;
 bh=+q1Se3dbJUmLNuot7rhv4SeuRLZSVDWdZ/YT25NWXdo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X2bhPCG3/+wvofmQj2GeHQYlBFgwogs05/Kieu1RHnDxc1HwaraorETjf7LVBYvwv
 Day/W+ofr5tUmYzC61YSbLn/nZGUyrV3W4+xWiCscQTF5lr8lmDXr3bBuhXjMA5VLa
 nTxBkGG6DDOIxjhuQ2p7m6+2N629Cs+bhMtNGswnmMbLlUXb8GwCRt+8Q4B7oi0ooD
 riRCB4xzqN+/Zg/AL5dCK+80qDuZ5t5/boz1ZaYiVKjklxOtiBMFrG83Ddq8ypmEC0
 HwLpGkIqRwjxe+v4qx369OMbBHxt80mWe2EvLZaFRXCigThiQ4Yhde+MFLgP5fjqCq
 Fm1CFJ9CCIhJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v3] drm/msm: default separate_gpu_kms to auto
 selection
To: "Mahadevan P" <mahadevan.p@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909-separate_gpu_kms-v3-1-eae64dfbb635@oss.qualcomm.com>
References: <20260909-separate_gpu_kms-v3-1-eae64dfbb635@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:54:54 +0000
Message-Id: <20260909135455.1D19F1F00A3A@smtp.kernel.org>
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
- [Medium] Missing `of_node_put()` causes an OF node reference leak in `msm=
_separate_gpu_kms_components()`.
--

commit 46360e93ded31d3fb12ccb01a8d959a4c7390270
Author: Mahadevan P <mahadevan.p@oss.qualcomm.com>

drm/msm: default separate_gpu_kms to auto selection

This commit updates the separate_gpu_kms module parameter to a tristate,
defaulting to an auto-selection mode. It allows the driver to automatically
split the display and GPU devices depending on the hardware topology,
improving support for multi-display platforms.

Link: https://lore.kernel.org/r/20260317-separate_gpu_kms-v2-1-b027ca97b9fe=
@oss.qualcomm.com

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
[ ... ]
> +bool msm_separate_gpu_kms_components(void)
>  {
> -	return separate_gpu_kms;
> +	struct device_node *np;
> +
> +	np =3D of_find_matching_node(NULL, msm_gpu_match);
> +	if (!msm_gpu_node_present(np))
> +		return true;
> +	if (separate_gpu_kms =3D=3D 1)
> +		return true;
> +	if (separate_gpu_kms =3D=3D 0)
> +		return false;
> +	return msm_separate_gpu_kms_auto();

[Severity: Medium]
Does this code leak the device node reference in
msm_separate_gpu_kms_components() in drivers/gpu/drm/msm/msm_drv.c?

The of_find_matching_node() function returns a node with its reference
count incremented. When np is not NULL, the function returns through
multiple paths without calling of_node_put() to release the reference.

>  }
> =20
>  static int msm_drm_uninit(struct device *dev, const struct component_ops=
 *gpu_ops)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-separate_g=
pu_kms-v3-1-eae64dfbb635@oss.qualcomm.com?part=3D1
