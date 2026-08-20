Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19491C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67FD710EE13;
	Thu, 20 Aug 2026 08:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="miZ8Hjqx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C391010EE13
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:41:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 04AFE60AA9;
 Thu, 20 Aug 2026 08:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A401F00A3D;
 Thu, 20 Aug 2026 08:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787215272;
 bh=/C4qfiniu2JtCFxkMv/cMtWoGSeTa8fU6oqEWrEQjXs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=miZ8HjqxJRqouuasmVucreX0AxVhrRdvXevkBe1vJFsdrr7yQyTQyUABe2VHs1T4H
 bPXvF0wnNzgfq3qaScdNP4RSbrdb05J068ynmlbY/vvH68cv/lRw0Ngi6YTPnsggk5
 HOQ7Bqfku+0ba0r32jopWmEbfGXx99tgS6t58WHALRDo8OTGkqsAntpTyFCr1Q3+Xo
 lMJ6tXh4K2PbL3jrYP3Vt8UCb1qmR/xgIPpKOHtvhVrcDS1xgW9ryAmnDlVFu9UUkL
 TYVnxlxWK6D3is4yJOBQNl5P0OlcUVhxpdHlODfoSnp8AIZgNBTTfRFRgYw7UGNR64
 TSC8e62XyZj1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vkms: Fix gamma_lut size check
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820083123.544655-2-oushixiong1025@163.com>
References: <20260820083123.544655-1-oushixiong1025@163.com>
 <20260820083123.544655-2-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 08:41:12 +0000
Message-Id: <20260820084112.86A401F00A3D@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but the vkms_compose=
r_worker accesses the currently committed CRTC state (crtc->state) asynchro=
nously without locks, leading to a Time-of-Check to Time-of-Use (TOCTOU) ra=
ce condition and Use-After-Free (UAF).
--

--- Patch [1]: [PATCH] drm/vkms: Fix gamma_lut size check ---
commit a52b4df7305f28acb171652e76fbc632383dbfb6
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/vkms: Fix gamma_lut size check
   =20
The gamma_lut size check in vkms_atomic_check() uses
sizeof(struct drm_color_lut *) instead of sizeof(struct drm_color_lut).
On 64-bit both happen to be 8 bytes, so the check works by accident.
On 32-bit sizeof(pointer) is 4 bytes while sizeof(struct drm_color_lut)
is 8 bytes, which would incorrectly reject valid 256-entry LUTs.

> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_=
drv.c
> index 5a640b531d88f..2db3971f72c31 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -112,7 +112,7 @@ static int vkms_atomic_check(struct drm_device *dev, =
struct drm_atomic_commit *s
>  		if (!new_crtc_state->gamma_lut || !new_crtc_state->color_mgmt_changed)
>  			continue;
> =20
> -		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut *)
> +		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut)
>  		    > VKMS_LUT_SIZE)
>  			return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but since we are looking at the
gamma_lut, is it possible for vkms_composer_worker() to hit a use-after-free
when accessing the LUT blob data?

In drivers/gpu/drm/vkms/vkms_composer.c:vkms_composer_worker():

	if (crtc->state->gamma_lut) {
		s64 max_lut_index_fp;
		s64 u16_max_fp =3D drm_int2fixp(0xffff);

		crtc_state->gamma_lut.base =3D (struct drm_color_lut *)crtc->state->gamma=
_lut->data;
		crtc_state->gamma_lut.lut_length =3D
			crtc->state->gamma_lut->length / sizeof(struct drm_color_lut);

The worker accesses the currently committed CRTC state (crtc->state)
asynchronously without locks, rather than using its own atomic state snapsh=
ot.

If userspace rapidly issues atomic commits that update or remove the CRTC's
gamma LUT, couldn't a concurrent atomic commit swap crtc->state and free
the LUT blob while the worker is executing?

This seems like it could create a large use-after-free window during the
blending phase in compose_active_planes(), or a direct NULL pointer
dereference in the setup phase.

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820083123.5446=
55-2-oushixiong1025@163.com?part=3D1
