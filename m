Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083D5C61DBD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 01:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E91710E37E;
	Thu, 27 Aug 2026 01:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l64t5fvn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C6810E37E
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 01:57:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 52A92434B9;
 Thu, 27 Aug 2026 01:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4FB1F000E9;
 Thu, 27 Aug 2026 01:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787795878;
 bh=YQIJdB5+3S9xWxrcls6vYow7p/Lbb/p2k7FrZJOBX+8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l64t5fvnqJALybmsl5WM/vAPxN2f5UQCjvJ3v3ITfl50hfeCxM6Q9JOkjETOFTr6t
 qNTNjksZMZFcuCeN7HihVbMaeAYXNsQLre1H9HvcpbKxWta0aLqzVxfiJ8oQQfANbZ
 OpTwB9ErYtpKGgEpOINGdaJ3YParXJtVtGp9YWr3poLVDRoVcI1Vo568uNMx61eDY8
 A5b4L8NPxIjDjj3KnIho4iVemi2uiJ8mB5WiMFfuLd5aSbzUkxWV3l1q2rsZp1K+aP
 eLfiWxn7cZJl9mPFRDwe3srDGWgin+iZzXF+95K1LESEEr8Q7sC6cWzjP0XrbJ85i1
 zIb8RVg5NJ/Fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nouveau/connector: set no zero sized all displayport on
 nouveau
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827015038.3483865-1-airlied@gmail.com>
References: <20260827015038.3483865-1-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 01:57:57 +0000
Message-Id: <20260827015758.0B4FB1F000E9@smtp.kernel.org>
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
- [High] Enabling `no_zero_sized` globally exposes pre-existing bugs in `dr=
m_dp_i2c_xfer()`, breaking REPEATED START for multi-message transfers (e.g.=
, EDID reads) and causing phantom devices during I2C probing.
--

commit bbcbb4f64ad839a36fe04a07743e9aaa99d1aec1
Author: Dave Airlie <airlied@redhat.com>

nouveau/connector: set no zero sized all displayport on nouveau

This commit removes the architecture generation check for the no_zero_sized
flag on DisplayPort/eDP connectors. It applies the flag unconditionally for
all Nvidia GPUs in nouveau.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index b0b0ad9a0c248..9b9c9ea2bce12 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1404,8 +1404,7 @@ nouveau_connector_create(struct drm_device *dev, in=
t index)
>  		nv_connector->aux.drm_dev =3D dev;
>  		nv_connector->aux.transfer =3D nouveau_connector_aux_xfer;
>  		nv_connector->aux.name =3D connector->name;
> -		if (disp->disp.object.oclass >=3D GB202_DISP)
> -			nv_connector->aux.no_zero_sized =3D true;
> +		nv_connector->aux.no_zero_sized =3D true;
                ^^^^

[Severity: High]
This isn't a bug introduced by this patch, but enabling no_zero_sized
unconditionally for all DisplayPort/eDP connections exposes a pre-existing
bug in drm_dp_i2c_xfer() for multi-message transfers.

When no_zero_sized is true, drm_dp_i2c_xfer() erroneously clears the MOT
(Middle-Of-Transfer) bit at the end of every message rather than only at
the end of the final message.

In drivers/gpu/drm/display/drm_dp_helper.c:drm_dp_i2c_xfer():

	for (j =3D 0; j < msgs[i].len; j +=3D msg.size) {
		...
		if (j + msg.size =3D=3D msgs[i].len && aux->no_zero_sized)
			msg.request &=3D ~DP_AUX_I2C_MOT;
		...
	}

By clearing DP_AUX_I2C_MOT at the end of each message loop, this breaks the
REPEATED START condition required for multi-message I2C transfers (such as
EDID reads), emitting STOP conditions between messages instead.

Additionally, zero-length I2C transfers are entirely bypassed by the loop:

	for (j =3D 0; j < msgs[i].len; j +=3D msg.size) {

When len is 0, this loop is skipped, resulting in no hardware interaction
while still falsely reporting success. This can cause I2C scanning to see
phantom devices at every address.

Does it make sense to fix drm_dp_i2c_xfer() before enabling this flag
globally for all Nvidia GPUs to avoid regressing display detection and I2C
probing on strict monitors?

>  		drm_dp_aux_init(&nv_connector->aux);
>  		break;
>  	default:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827015038.3483=
865-1-airlied@gmail.com?part=3D1
