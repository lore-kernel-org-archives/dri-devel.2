Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77701C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A27898A4;
	Mon, 31 Aug 2026 16:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DzaOkmhP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B43898A4
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:51:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C67CA60120
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2AC1F000E9;
 Mon, 31 Aug 2026 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788195093;
 bh=BJUp6e5sVHJ9iSV7I2ckO+GzS808TS6mrnE4weziDcc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DzaOkmhPb+naPiMkU5CVBr4UNPwU2M/vU8+ojfK0uhBNi6a7WYZU/2W1cZm1LA9es
 HGvWPg634ZVJcmsGsMl69ttOme/yql5p8MOK8CUTZn56Jrs+E+r93hRMy3uYKU0dJ7
 ouPNAcuRAAJnvn72fjRsCnElhUECJ20FsOv8BcA0V3HRt1OMCQTj3RnxKkteDKURVM
 m9bWVqEqyQPpCScAFjV4D5Hw21DA5AxHgXKW9EKTdvfTztTKFctsJOm4N2N94CRqsF
 ljcpuHVAbwcj4Y6rwI/l7YtfcE2Ahn2kY5JN3I19CQm/5VWoabj3K+GqUElEZAQ7Pb
 HvpHEsFDoyxFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] drm/amd/pm: Check SMUv13.0.6/12
 metrics integrity
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-482-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-482-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:51:32 +0000
Message-Id: <20260831165133.5F2AC1F000E9@smtp.kernel.org>
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
- [High] The patch corrupts the metrics cache on failure by overwriting it =
with poisoned data without invalidating the cache timestamp, allowing subse=
quent callers to read poisoned data as valid.

Pre-existing issues:
- [High] The return value of `smu_v13_0_6_setup_driver_pptable()` is ignore=
d, which can lead to zero-initialized clock frequencies being used as valid=
 DPM levels if the metrics table fetch fails.
--

commit 6701a9c70e1205aa9e17d45906aef05c0bfc8e8f
Author: Lijo Lazar <lijo.lazar@amd.com>

    drm/amd/pm: Check SMUv13.0.6/12 metrics integrity
   =20
    Check if data fetch is proper by matching the first few bytes against
    0xFFs. If 0xFFs, that means data couldn't be read properly.
   =20
    [ Upstream commit 6fc63d80c01a480e3d2c98620f07d46e5bcfc85a ]

> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 285cf79796939..c47beb75377ec 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -768,6 +768,10 @@ int smu_v13_0_6_get_metrics_table(struct smu_context=
 *smu, void *metrics_table,
>  		amdgpu_asic_invalidate_hdp(smu->adev, NULL);
>  		memcpy(smu_table->metrics_table, table->cpu_addr, table_size);
> =20
> +		if (!memchr_inv(smu_table->metrics_table, 0xff,
> +				min(16, table_size)))
> +			return -EHWPOISON;
> +

[Severity: High]
Does this error path leave the metrics cache poisoned?

If a caller (e.g., smu_v13_0_6_get_pm_metrics()) fetches the metrics table =
with
bypass_cache =3D true, and the fetch fails this new integrity check, it will
return -EHWPOISON. However, smu_table->metrics_table will already be overwr=
itten
with the poisoned (0xff) data, while smu_table->metrics_time remains unchan=
ged.

If a subsequent caller (e.g., smu_v13_0_6_get_gpu_metrics()) then requests
metrics with bypass_cache =3D false within the 1ms window of the old timest=
amp,
will it skip the fetch, copy the poisoned data, and return success?

>  		smu_table->metrics_time =3D jiffies;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but can the ignored return value of
smu_v13_0_6_setup_driver_pptable() cause zero-initialized clock frequencies=
 to
be used as valid DPM levels if the metrics table fetch fails?

Looking at smu_v13_0_6_set_default_dpm_table(), the return value of
smu_v13_0_6_setup_driver_pptable() is ignored:

drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c:smu_v13_0_6_set_defaul=
t_dpm_table() {
    ...
	smu_v13_0_6_setup_driver_pptable(smu);
    ...
}

If the metrics table fetch fails (e.g., due to the new integrity check retu=
rning
-EHWPOISON), setup_driver_pptable() returns an error without populating the
pptable structure.

Because the return value is ignored, the caller iterates over the
zero-initialized pptable and populates the DPM clock tables with 0 MHz:

drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c:smu_v13_0_6_set_defaul=
t_dpm_table() {
    ...
	for (j =3D 0; j < ARRAY_SIZE(dpm_map); j++) {
		...
		dpm_table->count =3D levels;
		for (i =3D 0; i < dpm_table->count; ++i) {
			dpm_table->dpm_levels[i].value =3D
				dpm_map[j].freq_table[i];
			dpm_table->dpm_levels[i].enabled =3D true;

		}
		...
	}
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-482-sashal@kernel.org?part=3D1
