Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61980606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzGs2VFQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE67F10E43D;
	Sun, 22 Nov 2026 17:21:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71A7F10E43D
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 17:21:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00BDF61303;
 Sun, 22 Nov 2026 17:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962521F000D0;
 Sun, 22 Nov 2026 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795368096;
 bh=63y5brT4FV3wITxL0zaLfWFKF23A/ePa7SYb9DYDJho=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=PzGs2VFQ7RI4vRoDDq6U8MAi7jWKkpzV5M7Qv/R0GVp16uv0wlUClEtT/aOZkcnGR
 NnBzyswUM25KjVjVCyDXWTA+kEi2lXWxSvm7QINq6fckTHN3thD6DLPHDTqAuCC1Jc
 WE1UOwCfuFoReN/Z/VhnK7j3brl2vAiRUZNHmBvpZpjbhQRSIwYbNruAfP8TcLo7Kc
 B4+SjcfdNTgOZrc/wnbrh6AXaJqY/ePi2tJ9ddLJF8PfbIbmrPcWucy2R5PG8qGoAZ
 AHtZrVl7fPs21CEVLI+e4OAz1LfLAEvJeLwxJSw/VByhabvTq/XInM1d9xcrYNU9Ac
 eyfh0P7gzhiDA==
Message-ID: <sashiko-outbox-228139@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/dp: allow dual-link clock for 30-inch Apple
 Cinema HD
To: =?utf-8?b?UGV0dGVyIFNramVsc2LDpms=?= <skjelsbaek@gmail.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261121090949.12290-1-skjelsbaek@gmail.com>
References: <20261121090949.12290-1-skjelsbaek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 17:21:36 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/dp: drm_dp_downstream_max_tmds_clock() uses sink EDID for
  DFP limit
--

commit 3f7cc9438aa51a2bb27f49e36ae50fec8c07ea94
Author: Petter Skjelsb=C3=A6k <skjelsbaek@gmail.com>

drm/dp: allow dual-link clock for 30-inch Apple Cinema HD

This commit returns a 300 MHz maximum downstream TMDS clock in
drm_dp_downstream_max_tmds_clock() when an Apple Cinema HD Display
(APP 0x9221) is attached to a DVI downstream port without detailed
capability information.

> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index a2959db1d956e..09e82a6d7f6ab 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -1388,8 +1388,15 @@ int drm_dp_downstream_max_tmds_clock(const u8 dpcd=
[DP_RECEIVER_CAP_SIZE],
>  			return 300000;
>  		return port_cap[1] * 2500;
>  	case DP_DS_PORT_TYPE_DVI:
> -		if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE)=
 =3D=3D 0)
> +		if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] &
> +		     DP_DETAILED_CAP_INFO_AVAILABLE) =3D=3D 0) {
> +			if (drm_edid &&
> +			    drm_edid_get_panel_id(drm_edid) =3D=3D
> +			    drm_edid_encode_panel_id('A', 'P', 'P', 0x9221))
> +				return 300000;
>  			return 165000;
> +		}

[Severity: Medium]
Should drm_dp_downstream_max_tmds_clock() derive the branch device's
downstream port limit from the attached sink's EDID panel ID?

drm_dp_downstream_max_tmds_clock() reports the capability of the DP-to-DVI
branch adapter (stored in intel_dp->dfp.max_tmds_clock by
intel_dp_update_dfp()), not the monitor.  If the APP 0x9221 display is
connected through a single-link DP-to-DVI adapter that lacks
DP_DETAILED_CAP_INFO_AVAILABLE, this returns 300 MHz and exposes the
268 MHz 2560x1600 native mode that the single-link adapter cannot drive,
while any other dual-link DVI monitor on the Apple dual-link adapter
remains capped at 165 MHz.

Could the quirk instead identify the branch adapter itself via its DPCD
branch descriptor (DP_BRANCH_OUI / DP_BRANCH_ID)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121090949.1229=
0-1-skjelsbaek@gmail.com?part=3D1
