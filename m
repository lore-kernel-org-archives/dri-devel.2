Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606ABC531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E9710F241;
	Thu, 23 Jul 2026 22:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ouyJAUe8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6032E10F241
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:33:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0939943D41;
 Thu, 23 Jul 2026 22:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBBD1F000E9;
 Thu, 23 Jul 2026 22:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784846033;
 bh=lPjki70WcJDffDF1FmFSQ3srnaXt2k9oCo3W6tXgeP4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ouyJAUe81xiWA1OlF7e9RssDl2KOp8CabmLGNdCXrhftx3yi7IrIXIWrn/ograG8b
 o1/VSlef2qwCfHffHzyxKpGJsqmrek3S5QQlGCZpsrbOYIVBI3lIa2ydnXIHTyA4FN
 iWzzXPA0xkLjTX5M0dlw1zHghfrucCDKa9xtK1WDVhqpQ9/PzYlCMOsr/JplvAvvU7
 PFbFh6kC+ANi9DR5nV/QR2vxLsDdzPzmpDVn8j98QVmMnZGEgQxXn/ezOeS1AyOYy0
 1ZnvTTbt1X35HKCgM2H+T1k9ud6i4jFy0nBnxcN3vY7rI2CrxszxoxSGAFwVNp93Zk
 9Yy9lUn2FZD3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm: add a EDID_QUIRK_IGNORE_STEREO_FLAG quirk
To: =?utf-8?b?TWljaGHFgiBTem9sYw==?= <undefine@undefine.pl>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723220400.17190-2-undefine@undefine.pl>
References: <20260723220400.17190-1-undefine@undefine.pl>
 <20260723220400.17190-2-undefine@undefine.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:33:53 +0000
Message-Id: <20260723223353.BFBBD1F000E9@smtp.kernel.org>
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
- [Medium] The newly introduced `EDID_QUIRK_IGNORE_STEREO_FLAG` quirk is ne=
ver assigned to any panel in the `edid_quirk_list`, making the added logic =
dead code.
--

--- Patch [1]: [PATCH 1/2] drm: add a EDID_QUIRK_IGNORE_STEREO_FLAG quirk -=
--
commit c12c9b1e2a3442319892a911d6fc20a3c6916841
Author: Micha=C5=82 Szolc <undefine@undefine.pl>

drm: add a EDID_QUIRK_IGNORE_STEREO_FLAG quirk
   =20
This commit introduces a new EDID quirk meant to ignore the stereo flag
for screens that misrepresent certain modes.

> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 07970e5b5f65e..4720217f99bff 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -96,6 +96,8 @@ enum drm_edid_internal_quirk {
>  	EDID_QUIRK_NON_DESKTOP,
>  	/* Cap the DSC target bitrate to 15bpp */
>  	EDID_QUIRK_CAP_DSC_15BPP,
> +	/* Ignore stereo flag of modes */
> +	EDID_QUIRK_IGNORE_STEREO_FLAG,
>  };
> =20
>  #define MICROSOFT_IEEE_OUI	0xca125c

[ ... ]

> @@ -3538,7 +3540,8 @@ static struct drm_display_mode *drm_mode_detailed(s=
truct drm_connector *connecto
>  	if (hactive < 64 || vactive < 64)
>  		return NULL;
> =20
> -	if (pt->misc & DRM_EDID_PT_STEREO) {
> +	if (pt->misc & DRM_EDID_PT_STEREO &&
> +		!drm_edid_has_internal_quirk(connector, EDID_QUIRK_IGNORE_STEREO_FLAG)=
) {

[Severity: Medium]
Is this new quirk missing an entry in the edid_quirk_list[] array?

Because the quirk is internal to drm_edid.c and isn't currently mapped to a=
ny=20
specific vendor or product IDs in edid_quirk_list[], the call to=20
drm_edid_has_internal_quirk() will unconditionally evaluate to false. This =
makes
the newly introduced logic unreachable.

Should a specific display panel be added to edid_quirk_list[] in this patch=
 to
utilize the fix?

>  		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] Stereo mode not supported\n",
>  			    connector->base.id, connector->name);
>  		return NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723220400.1719=
0-1-undefine@undefine.pl?part=3D1
