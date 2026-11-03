Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF4606B6C3
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VacgjoIf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DFD710E7A1;
	Tue,  3 Nov 2026 08:46:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC3010E7A1
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 08:46:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7919C609D1;
 Tue,  3 Nov 2026 08:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089061F00A15;
 Tue,  3 Nov 2026 08:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793695566;
 bh=Y/vSTCEZYfMmXeBQR4sO8qHXZ4SF8C1Y86ksXX3BhUs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VacgjoIf4WlBOQnNgIVxviVZeKm2CHqxhPDcCgiuZCGkICrZE0TzHtSr7S3PjOpjU
 +3k4n91j5R94d6KTahOYisqMMtD/8H2SjjCQod39tkbH8NL9li/0p038HPPkFVYGSC
 fFfZNCejGjImhSk4shGE2wgpy1FQ9oDuhg6ImzHg8x4MGRZ5HKcY2cqlLmRq1fsMas
 enHQ/rM/84Z1eiFZnMBBtcllRGoFNMQ1tTf4eVOzThcX44gt4wHCii9vikWRwDbX97
 IQNK4Buucatov5lkK+f/+L8PIu0SawZaVVheiVZKuYUpXmOOcbKcEDbbqzSLybt5SC
 wEX2aO9omfo9A==
Message-ID: <sashiko-outbox-194867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] drm/imagination: Limit access to the META
 firmware interface
To: "Alexandru Dadu" <alexandru.dadu@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103-prep-meta-fw-arch-independent-v3-4-563dbaf1b779@imgtec.com>
References: <20261103-prep-meta-fw-arch-independent-v3-0-563dbaf1b779@imgtec.com>
 <20261103-prep-meta-fw-arch-independent-v3-4-563dbaf1b779@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:46:05 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/imagination: inverted layout_mars_value check in layout_is_mar=
s()
--

commit 4207fc7502d043d11f6874d92c1ba51c38ade0fe
Author: Alessio Belle <alessio.belle@imgtec.com>

drm/imagination: Limit access to the META firmware interface

This commit isolates access to the META firmware interface behind the
generic firmware processor table in struct pvr_fw_defs, removes
pvr_fw_meta.h, and renames pvr_rogue_meta.h to pvr_rogue_meta_internal.h.

> diff --git a/drivers/gpu/drm/imagination/pvr_fw_startstop.c b/drivers/gpu=
/drm/imagination/pvr_fw_startstop.c
> index 98ca2692239d0..ab637ba7d108c 100644
> --- a/drivers/gpu/drm/imagination/pvr_fw_startstop.c
> +++ b/drivers/gpu/drm/imagination/pvr_fw_startstop.c

[ ... ]

> @@ -199,6 +197,30 @@ pvr_fw_start(struct pvr_device *pvr_dev)
>  	return err;
>  }
> =20
> +static inline bool layout_is_mars(struct pvr_device *pvr_dev)
> +{
> +	u64 layout_mars_value =3D 0;
> +
> +	if (PVR_FEATURE_VALUE(pvr_dev, layout_mars, &layout_mars_value))
> +		return false;
> +
> +	return layout_mars_value =3D=3D 0;
> +}

[Severity: High]
As reported by Sashiko on v2 [1], does layout_is_mars() invert the check on
layout_mars_value when PVR_FEATURE_VALUE() succeeds?

Prior to this change, pvr_fw_stop() checked:

	if (PVR_FEATURE_VALUE(pvr_dev, layout_mars, &layout_mars_value) =3D=3D 0)
		layout_mars =3D layout_mars_value > 0;

In layout_is_mars(), when PVR_FEATURE_VALUE() returns 0 (feature present),
it evaluates layout_mars_value =3D=3D 0 instead of layout_mars_value > 0.

On cores with the layout_mars feature enabled (layout_mars_value > 0),
layout_is_mars() will return false, causing pvr_fw_stop() to poll
ROGUE_CR_SIDEKICK_IDLE and ROGUE_CR_SLC_IDLE (which are already powered
down by the firmware on MARS cores) and skip polling ROGUE_CR_MARS_IDLE
before asserting ROGUE_CR_SOFT_RESET. Should this return
layout_mars_value > 0 instead?

[1] https://lore.kernel.org/r/20261029-prep-meta-fw-arch-independent-v2-4-b=
9f5d69b7a52@imgtec.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-prep-meta-=
fw-arch-independent-v3-0-563dbaf1b779@imgtec.com?part=3D4
