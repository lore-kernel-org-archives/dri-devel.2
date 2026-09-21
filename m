Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8CAC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C8E10EACE;
	Mon, 21 Sep 2026 16:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y1ANDHZS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87DC810EACD
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:18:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0DCA360120;
 Mon, 21 Sep 2026 16:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC441F000FF;
 Mon, 21 Sep 2026 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007493;
 bh=3Mzm1NdvJ2CU0gwE18PKJjyrDjH8Ci9FODjFLDkZa3Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y1ANDHZSLr+wXmLqzT/nzYiOn+6PdEhbEffWdKwpGFfPoKTmkOynNnWqsZwcym/zs
 w8s4Y9zVAJFO5rHhx+EicNjNnn7I62/KTxVAsuKpYDhE9q8uguuXOSTBzVOEBrrwyi
 QFBQYDBTC9drQqEj+8YG/rX2+BZ4ZckILeL8As/789wBfJAya154RpeOwlu9KCP1GB
 sS5eZ9TLGmtJCA4okBBEBrLA5IB3IrScwwFx58bFn8VuOYz/NYiZLy1aiormXb8utR
 fO8FjPVzXoH4yzrFtdxue/0c2aMeYvBfCyFVfOM5Em9FynMSVdTV3EB5IWw0S2dgFI
 WLh8kxLIkUagw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 15/25] drm/edid: Parse QMS flag from HDMI SCDS
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-15-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-15-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:18:13 +0000
Message-Id: <20260921161813.9CC441F000FF@smtp.kernel.org>
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
- [Medium] drm/edid: redundant VRR parsing has off-by-one length checks ski=
pping valid EDID data
--

commit 5e1483c916355c112a6de67649f48244b2260d1e
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/edid: Parse QMS flag from HDMI SCDS

This commit adds support for parsing the Quick Media Switching (QMS) flag
from the HDMI Forum EDID extension. It adds the definition to the EDID
header file and parses it into the qms_capable member of drm_hdmi_info.

> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index cc6f2ba8c9f4d..5a7d3b7e65daa 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
[ ... ]
> @@ -6318,6 +6318,7 @@ static void drm_parse_vrr_info(struct drm_display_i=
nfo *info, const u8 *hf_scds)
>  	if (pld_len < 9)
>  		return;
> =20
>  	info->hdmi.cinema_vrr =3D !!(hf_scds[8] & DRM_EDID_CINEMA_VRR);
> +	info->hdmi.qms_capable =3D !!(hf_scds[8] & DRM_EDID_QMS);

[Severity: Medium]
Does this off-by-one bounds check skip valid EDID data?

Looking at drm_parse_vrr_info(), it returns early if the payload length is
less than 9. This means it silently skips parsing the valid QMS and CinemaV=
RR
flags at hf_scds[8] for sinks whose payloads are exactly 8 bytes long.

For comparison, the pre-existing drm_parse_hdmi_gaming_info() function
correctly parses this exact same payload byte using:

    if (cea_db_payload_len(db) < 8)
        return;

Could we update the pld_len check in drm_parse_vrr_info() to < 8 so that it
matches the bounds logic in drm_parse_hdmi_gaming_info() and doesn't break
QMS/VRR limit detection for those sinks?

> =20
>  	if (pld_len < 10)
>  		return;
[ ... ]
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index b147b8474f1a9..c97cf0625fda5 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -386,6 +386,9 @@ struct drm_hdmi_info {
> =20
>  	/** @cinema_vrr: The sink supports "CinemaVRR" */
>  	bool cinema_vrr;
> +
> +	/** @qms_capable: The sink supports Quick Media Switching */
> +	bool qms_capable;

[Severity: Medium]
Does the cinema_vrr field duplicate the existing vrr_cap.cinema_vrr field?

This isn't a bug introduced by this patch, but having a duplicate field can
create desynchronized state when parsed. Would it be better to consolidate
this redundant VRR parsing altogether?

>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D15
