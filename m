Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB0B60A2610
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3PiB7ry
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2F110F802;
	Tue, 10 Nov 2026 16:04:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CFE810F7FA
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:04:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46D6F44F77;
 Tue, 10 Nov 2026 16:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F406D1F008A6;
 Tue, 10 Nov 2026 16:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794326640;
 bh=9fqunV2bHcQ74ymLiN1q549Tt2WC7GvlPGz3NdIupa0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=A3PiB7ryvxIUENu7e5fCLtbFzQQK7hpIsW5Wvt/v8n79wtHdMz2Qjn6L+FRFMP/jy
 ZUWOFZdTRCYO0hgvfqfc8EWksI4xKhlmSvCCQwiyx7T4H0lISkkBelUOU74S+Sv6Qe
 Qt5B4K/ff7AirKD6EDNIU5IPJlDTZxT6EMawqMxmXfz+nHGCwE4IXxptr41H+6bSuk
 CP6AH6OX3+dmWj1t3OqlI/FK+AICeCU2FApba8JODNRbIYp6C5UHc8Y7ppKW+j4QEf
 eemIZPY+sQ9W4gz6XYXLu8ThAHdlWdccYTiuJafuXl840475U54OmdhgyDVOnlR6BR
 1oKf3g2acMenQ==
Message-ID: <sashiko-outbox-207338@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/28] drm/panthor: Skip devfreq when no OPP table is
 present
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-11-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-11-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:03:59 +0000
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
- [Medium] drm/panthor: panthor_devfreq_init() leaves fast_rate at 0 on
  early return
--

commit f3bfa3d1d539b4b1bfaa2d96f490e98746dad160
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Skip devfreq when no OPP table is present

This commit skips devfreq initialization on Mali v15 AM systems when no OPP
table is present, guards the devfreq helpers against a NULL devfreq
instance, and falls back to clk_get_rate() when querying the current
frequency without devfreq.

> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/=
panthor/panthor_devfreq.c
> index 2249b41ca4afe..d1814b5197221 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c

[ ... ]

> @@ -164,6 +165,19 @@ int panthor_devfreq_init(struct panthor_device *ptde=
v)
>  	 */
>  	table =3D dev_pm_opp_get_opp_table(dev);
>  	if (IS_ERR_OR_NULL(table)) {
> +		/*
> +		 * On v15 GPUs, frequency scaling is handled outside of panthor
> +		 * by the AM_GOVERNOR block, so the GPU DT node may not provide
> +		 * an OPP table. In such cases, do not initialize devfreq for
> +		 * panthor.
> +		 */
> +		if (panthor_hw_is_gen5_am(ptdev->base.dev) &&
> +		    PTR_ERR(table) =3D=3D -ENODEV) {
> +			drmm_kfree(&ptdev->base, pdevfreq);
> +			ptdev->devfreq =3D NULL;
> +			return 0;
> +		}

[Severity: Medium]
As reported by Steven Price on RFC [1], does returning early here leave
ptdev->fast_rate at 0?  ptdev->fast_rate is only populated later in
panthor_devfreq_init() via dev_pm_opp_find_freq_floor(), and
panthor_gpu_show_fdinfo() unconditionally prints it:

drivers/gpu/drm/panthor/panthor_drv.c:panthor_gpu_show_fdinfo() {
	...
	drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
	drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n",
		   panthor_devfreq_get_freq(ptdev));
}

On v15 AM systems without an OPP table, reading fdinfo will report
"drm-maxfreq-panthor: 0 Hz" alongside a non-zero current frequency,
breaking userspace GPU utilization calculations that divide cycle counts
by drm-maxfreq-panthor.

[1] https://lore.kernel.org/r/dc038a81-3c59-49d5-ab8a-29202c7ce935@arm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D10
