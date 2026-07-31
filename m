Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E3AC55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5601D10F3DA;
	Fri, 31 Jul 2026 20:12:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IP1cFUOC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABFD10F3C7
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 20:12:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 354DF60A6C;
 Fri, 31 Jul 2026 20:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02A01F00AC4;
 Fri, 31 Jul 2026 20:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785528728;
 bh=2eQgVJkPT8NVfMQWvpqrdCU2+xR7t2iMDAP115Cfn1k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IP1cFUOC80MU72nHW3cA/OPgkmBsZjsbfwq3xuHvgckagliihvJZDkPJ9V99j1Ddh
 IVAjKQ7UNB/C6E3pXJx6IuRf30N32LADV0OUl6CKC6iEz+32zWIdshYFdVFwosZxkS
 proK1rBNupCVSXb/y8MKBM5ww2ayOY0DxzOaOm4hYcDhjma8sfk1a+e1GRy21WrigJ
 5Vbr8BQNPbHNKstHKQdu+78hWwIQqQMifPPmg5xHb4CfK8HmJRWl3XPKdzakJTGB3d
 d6Q99bPYUGZa9ppp9UgvobWC6jv+4kOn/+/SRIGnPcw4zg0xsq8z1iLoB5vY0wDedQ
 /Nwo3XmLaWecA==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH 4/6] drm_hyperv: Remove support for synth video
 protocol of old Hyper-V hosts
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-scsi@vger.kernel.org
In-Reply-To: <20260730201123.1767-5-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
 <20260730201123.1767-5-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 20:12:08 +0000
Message-Id: <20260731201208.A02A01F00AC4@smtp.kernel.org>
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

New issues:
- [Low] The static inline function `hv_drm_version_ge()` and the `synthvid_=
version` field in `struct hv_drm_device` are left behind as dead code.

Pre-existing issues:
- [High] Timeout of VMBus resolution request leaves the channel open, allow=
ing delayed responses to corrupt memory and desynchronize wait completions.
--

--- Patch [4]: [RESEND PATCH 4/6] drm_hyperv: Remove support for synth vide=
o protocol of old Hyper-V hosts ---
commit 942daa19258c15938630a14160717e1dd6e0fbc1
Author: Michael Kelley <mhkelley58@gmail.com>

drm_hyperv: Remove support for synth video protocol of old Hyper-V hosts

This commit removes support for older synthetic video protocols, as running
Linux on Hyper-V hosts earlier than WS2016 and Windows 10 is no longer
supported. It simplifies the protocol version negotiation to only request
the WIN10 version.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index f0ef627b4898a..cea1ea2595cd6 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c

[ ... ]

> @@ -581,11 +570,9 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
> =20
>  	hv->screen_depth =3D SYNTHVID_DEPTH_WIN8;
> =20
> -	if (hv_drm_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
> -		ret =3D hv_drm_get_supported_resolution(hdev);
> -		if (ret)
> -			drm_err(dev, "Failed to get supported resolution from host, use defau=
lt\n");
> -	}
> +	ret =3D hv_drm_get_supported_resolution(hdev);

[Severity: Low]
Since the only caller to hv_drm_version_ge() and the only reader of=20
hv->synthvid_version are removed by this patch, should both the static=20
inline function in hyperv_drm_proto.c and the struct field in=20
hyperv_drm.h be removed as well to avoid leaving dead code behind?

> +	if (ret)
> +		drm_err(dev, "Failed to get supported resolution from host, use defaul=
t\n");

[Severity: High]
This is a pre-existing issue, but I wanted to ask about the error
handling here.

If hv_drm_get_supported_resolution() times out waiting for a response,
the code logs an error but execution continues without closing the
channel or returning an error.

If the host sends a delayed response later, wouldn't it trigger
hv_drm_receive_sub() and asynchronously overwrite hv->init_buf while
subsequent requests are actively building a new request in that shared
memory? It looks like this might also spuriously trigger complete(&hv->wait)
and desynchronize the state.

Could this timeout be handled by returning an error or resetting the
channel to prevent data corruption?

> =20
>  	if (!hv->screen_width_max) {
>  		hv->screen_width_max =3D SYNTHVID_WIDTH_WIN8;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730201123.1767=
-1-mhklinux@outlook.com?part=3D4
