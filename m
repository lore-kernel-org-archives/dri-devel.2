Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9167DC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D465410EE04;
	Tue,  7 Jul 2026 15:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V360LBhO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2A910EE04
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:41:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6977F40396
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203B01F000E9;
 Tue,  7 Jul 2026 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783438880;
 bh=gMZ8HKF4xgeHQe6IWef9vtm1IWdXfBF8rc8oh/0sxzI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V360LBhOtYnfsdBncbvGpzNk0hKbphPLTVtiTwgo25KPwss/D9TrP7wSb1EshZ3UD
 Iq2XedvQu1hj8aX3tvybAGMl8nS2LtfYQV2j5SLGbhn38X559angsaf8e1m9+8clGz
 Ey8BIotGtqrHSo9x6PmiXfFO4siVeM80oUjqxwsWqBaWfqLUq352v1nSaVmrVU5CPf
 RT+QKExx2SlgfjIRn62Wz6CYJld34+RUrRcg/Ow0r7FeV66w7IZUrsZYwFz5HD5tUb
 yUKzz+jBHerP8sUnwfFF9yvZbpViYuUqKbwTQrC4Q7oHCaQ+qbk0C7oC8ChA81Nq/M
 nSpZ914EkJREw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/37] drm/bridge: nxp-ptn3460: Switch to atomic
 bridge callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-14-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-14-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:41:19 +0000
Message-Id: <20260707154120.203B01F000E9@smtp.kernel.org>
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
- [High] Memory leak of the dynamically allocated edid buffer in ptn3460_ed=
id_read on the success and drm_edid_alloc failure paths.
- [High] Lockless concurrent access to the bridge's power state (ptn_bridge=
->enabled) causes a TOCTOU race and hardware state mismatch.
--

--- Patch [14]: [PATCH v2 14/37] drm/bridge: nxp-ptn3460: Switch to atomic =
bridge callbacks ---
commit 3ac8d8062ac1622a61e5a518f71eee0beb4385a3
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: nxp-ptn3460: Switch to atomic bridge callbacks

The nxp-ptn3460 bridge uses the legacy non-atomic pre_enable and disable
bridge callbacks.

In order to remove the legacy bridge callback support from the DRM
bridge core, switch to their atomic counterparts and add the bridge
atomic state handlers.

> diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridg=
e/nxp-ptn3460.c
> index 7acb11f16dc19..a9b4ac2defc99 100644
> --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
> +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
[ ... ]
> @@ -163,7 +165,7 @@ static const struct drm_edid *ptn3460_edid_read(struc=
t drm_bridge *bridge,
>  	int ret;
> =20
>  	power_off =3D !ptn_bridge->enabled;
> -	ptn3460_pre_enable(&ptn_bridge->bridge);
> +	ptn3460_pre_enable(&ptn_bridge->bridge, NULL);

[Severity: High]
This is a pre-existing issue, but does lockless access to ptn_bridge->enabl=
ed
create a race condition with asynchronous atomic commits?

If ptn3460_edid_read() starts while the display is off, it saves
power_off =3D true. If an asynchronous DRM atomic commit worker simultaneou=
sly
invokes ptn3460_pre_enable(), it sets ptn_bridge->enabled =3D true and
powers up the hardware.

> =20
>  	edid =3D kmalloc(EDID_LENGTH, GFP_KERNEL);
>  	if (!edid) {
> @@ -182,7 +184,7 @@ static const struct drm_edid *ptn3460_edid_read(struc=
t drm_bridge *bridge,
> =20
>  out:
>  	if (power_off)
> -		ptn3460_disable(&ptn_bridge->bridge);
> +		ptn3460_disable(&ptn_bridge->bridge, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but does this leak the dynamical=
ly
allocated edid buffer?

drm_edid_alloc() duplicates the data into a new container but does not take
ownership of the original pointer. When ptn3460_edid_read() reaches this out
block and returns, the edid buffer allocated via kmalloc() earlier is not
freed. Since this path can be triggered repeatedly via the
DRM_IOCTL_MODE_GETCONNECTOR ioctl, could this eventually lead to memory
exhaustion?

Additionally, following up on the race condition mentioned above, if power_=
off
was evaluated as true before a concurrent atomic commit, this path will call
ptn3460_disable(). That function locklessly modifies ptn_bridge->enabled =
=3D false
and powers down the hardware, causing the display to go blank against the a=
tomic
commit's expectations.

> =20
>  	return drm_edid;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D14
