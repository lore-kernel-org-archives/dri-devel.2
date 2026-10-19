Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB14CCF2E5
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C793F10E146;
	Mon, 19 Oct 2026 14:33:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E42F710E146
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:32:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A03CB439D2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1241F000C6;
 Mon, 19 Oct 2026 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792420377;
 bh=iWYODvfr6mv8WaruTb0w8mCTbxwEz1PkNlRQgrPr9p4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nDYtDn7V3M6r2NCUq+/t0c8kCgTw6iQ6xqISNo6Kt6Vnzzp+bVVgerqZc2SmpmoKP
 qQ5jWrAi96x5TNCf5dol5LcUEhDpFSD4rTo07Eh4hQze6AwB9Nsp1w8S5ASQCr34Xj
 WEZVGSyG5+GGVT0fvxuf2nwvZDd+S4HyYXdgagT47C256LAMJWqyERu1nCsBkbioeJ
 ComMdRlwYWkssaqyqGlFjfptY/2u0JrgBZmWIw+8dyN0CuBw61UQ3TOtzjUQKYfwU7
 2fEXqUrkhAyguG4cJVjcfiM5y5qIaymnbaOH68trGalQDHTdl8b1i9y0sMCy8Wp+ao
 3TXpFMSD+8dmA==
Message-ID: <sashiko-outbox-177425@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/amd/pm: derive stable PPT limits from
 PPTable
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019135441.1420968-82-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-82-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:32:56 +0000
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
- [Medium] drm/amd/pm: aldebaran_get_power_limit() sets non-zero default on=
 secondary die
--

commit e12c0e27cabe98103b51eb24b3ca4cb7b2a3ede8
Author: Yang Wang <kevinyang.wang@amd.com>

drm/amd/pm: derive stable PPT limits from PPTable

This commit updates the power limit query handlers for Sienna Cichlid,
Navi10, Arcturus, and Aldebaran to derive platform default, minimum, and
maximum PPT limits from the driver PPTable rather than mutable PMFW
runtime state.

> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 18d5d07045098..9e67e57d70b75 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1281,8 +1281,12 @@ static int aldebaran_get_power_limit(struct smu_co=
ntext *smu,
> =20
>  	if (current_power_limit)
>  		*current_power_limit =3D power_limit;
> -	if (default_power_limit)
> -		*default_power_limit =3D power_limit;
> +	if (default_power_limit) {
> +		if (pptable)
> +			*default_power_limit =3D pptable->PptLimit;
> +		else
> +			*default_power_limit =3D power_limit;
> +	}

[Severity: Medium]
On Aldebaran multi-die GPUs, could this cause the secondary die to report a
non-zero default power limit in hwmon (power1_cap_default)?

Earlier in aldebaran_get_power_limit(), both the SMU_MSG_GetPptLimit query
and the pptable->PptLimit fallback are guarded by aldebaran_is_primary(smu)
(from commit 076f55a45e9e ("drm/amd/pm: Only primary die supports power
data")):

	/* Valid power data is available only from primary die.
	 * For secondary die show the value as 0.
	 */
	if (aldebaran_is_primary(smu)) {
		ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit,
					   &power_limit);

		if (ret) {
			/* the last hope to figure out the ppt limit */
			if (!pptable) {
				dev_err(smu->adev->dev,
					"Cannot get PPT limit due to pptable missing!");
				return -EINVAL;
			}
			power_limit =3D pptable->PptLimit;
		}
	}

Similarly, aldebaran_set_power_limit() rejects changes on the secondary
die:

	/* Power limit can be set only through primary die */
	if (aldebaran_is_primary(smu))
		return smu_v13_0_set_power_limit(smu, limit_type, limit);

	return -EINVAL;

Because smu->smu_table.driver_pptable is allocated and populated on all
dies via aldebaran_init_smc_tables() -> smu_v13_0_init_smc_tables() and
aldebaran_store_powerplay_table(), pptable is non-NULL on the secondary
die.

When smu_late_init() -> smu_get_asic_power_limits() calls
aldebaran_get_power_limit(), *default_power_limit was previously set to
power_limit (0 on the secondary die), whereas now it will be set to
pptable->PptLimit without checking aldebaran_is_primary(smu). Should the
pptable->PptLimit assignment for default_power_limit also be gated on
aldebaran_is_primary(smu)?

> =20
>  	if (max_power_limit) {
>  		if (pptable)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-82-sashal@kernel.org?part=3D1
