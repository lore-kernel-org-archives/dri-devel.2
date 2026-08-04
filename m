Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67A7C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:52:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B5B10E012;
	Tue,  4 Aug 2026 20:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tm+mUZ3e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7DF310E012
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:52:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B0DE600AA;
 Tue,  4 Aug 2026 20:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA561F000E9;
 Tue,  4 Aug 2026 20:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785876756;
 bh=wf9bh4U4LwAMpUW+lANZbLmawOMBY/azGMD32V1oY0M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tm+mUZ3eSJVFAhioCaEepFwidSrlJwFOoT+C5TlyH8PkJlaRuXLawr+sDSBFqTvbK
 paiBUm8CNOLuvrw1r7e8Lcg0fBnwAZzGbVpSJimUWMFyLAb3lpznXRRSynmuFi0kfJ
 zmzYCrUcj1z8SZUN/Y+JOt41/taCRtkirhDPpIlyQjI/Q2/lWlZWvmyTZxoie1o2H3
 lJkxp2rJ8dVJ3RAq9NvyadsYof1P+FX39o+kKCt7DGNU0Tv9P7Uy9f78VU0N/EcOHf
 6mRycDi4aKqWD52r8RtVNunIDzX8kiO9a/ic+/6o9eSVAGfBykBv5KS//qLBy5AOts
 F6Q7NPu77rg8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] drm/vkms: rename struct vkms_color_lut::base to y
To: "Leandro Ribeiro" <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804203351.148521-7-leandro.ribeiro@collabora.com>
References: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
 <20260804203351.148521-7-leandro.ribeiro@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 20:52:35 +0000
Message-Id: <20260804205236.BEA561F000E9@smtp.kernel.org>
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
- [Critical] vkms_composer_worker accesses the global crtc->state asynchron=
ously, creating a Use-After-Free (UAF) vulnerability.
- [High] vkms_atomic_check incorrectly divides gamma_lut length by sizeof(p=
ointer) instead of sizeof(struct) on 32-bit systems.
--

--- Patch [6]: [PATCH 06/11] drm/vkms: rename struct vkms_color_lut::base t=
o y ---
commit 89753bc7023e7c4dac9293962b90fb28fe7958fd
Author: Leandro Ribeiro <leandro.ribeiro@collabora.com>

drm/vkms: rename struct vkms_color_lut::base to y

This patch renames the base field in struct vkms_color_lut to y to prepare=
=20
for the addition of an x field in future commits. It updates all usages of=
=20
the field across the driver's tests, composer, and LUT initialization code.=
=20
There is no intended functional change.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c

[ ... ]

> @@ -641,7 +641,7 @@ void vkms_composer_worker(struct work_struct *work)
>  		s64 max_lut_index_fp;
>  		s64 u16_max_fp =3D drm_int2fixp(0xffff);
> =20
> -		crtc_state->gamma_lut.base =3D (struct drm_color_lut *)crtc->state->ga=
mma_lut->data;
> +		crtc_state->gamma_lut.y =3D (struct drm_color_lut *)crtc->state->gamma=
_lut->data;

[Severity: Critical]
This isn't a bug introduced by this patch, but does accessing the global
crtc->state asynchronously here create a use-after-free vulnerability?

If userspace submits rapid non-blocking atomic commits, crtc->state can be=
=20
swapped by drm_atomic_helper_commit() and its previous gamma_lut blob freed=
=20
while vkms_composer_worker() is still executing.

Could this lead to the worker dereferencing the freed gamma_lut->data point=
er=20
later in apply_lut_to_channel_value()?

>  		crtc_state->gamma_lut.lut_length =3D
>  			crtc->state->gamma_lut->length / sizeof(struct drm_color_lut);
>  		max_lut_index_fp =3D drm_int2fixp(crtc_state->gamma_lut.lut_length - 1=
);

[ ... ]

While reviewing the gamma LUT handling, I also noticed the following in
vkms_drv.c:vkms_atomic_check():

> 		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut *)
> 		    > VKMS_GAMMA_LUT_SIZE)
> 			return -EINVAL;

[Severity: High]
This is a pre-existing issue, but does vkms_atomic_check() incorrectly divi=
de=20
by sizeof(struct drm_color_lut *) instead of sizeof(struct drm_color_lut)?

On 32-bit systems where pointers are 4 bytes, a 256-entry LUT evaluates to =
a=20
length of 512, which exceeds VKMS_GAMMA_LUT_SIZE (256) and rejects valid=20
atomic commits with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804203351.1485=
21-1-leandro.ribeiro@collabora.com?part=3D6
