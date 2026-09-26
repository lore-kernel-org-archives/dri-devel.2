Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C94CC9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3488610E19A;
	Sat, 26 Sep 2026 15:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oU92YD6t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 014FF10E13E
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:59:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D8E2B41FB5;
 Sat, 26 Sep 2026 15:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9170E1F000FF;
 Sat, 26 Sep 2026 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790438373;
 bh=Bz/09MLUrUGCknk+CG1a39i/DK8GWKbl2Ld9fWZUFlI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oU92YD6tJxpTdPWB5imPDu7oA9fhpiYf10b596i7eSyFPDr5c5FH2Vc/4NRLIC38q
 1SY7l0xSpGU/FFAUfmfcyQ2aFy+f9rB4BErD6Czd4TgggexkQjnW3QkQIR5QVFo0vI
 2PvZlzKRzWSkVVsPzGTNH+yGOyzHDVvRQ3lw1w2hiZlgfPQRLv8ffq0OR7k7akz7RE
 IZ1OQ0lUuismt4ANRjIsUyODFVCmLxwNpU352kyWeWPVoC4VD7ImtDeuBOxjPb1n/l
 Qo818bg6ZCp2tdjDH9J5zjk83dGqBNmTzfxeryLnWKZhZOnGA7sebN9KGvtqTbOXch
 71NxPQLuiCt8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] wifi: ath12k: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260925155737.4161358-7-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-7-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 15:59:33 +0000
Message-Id: <20260926155933.9170E1F000FF@smtp.kernel.org>
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
- [High] leak: devm_qcom_pas_context_alloc memory leak in recovery loop
- [High] leak: TrustZone memory leak via missing qcom_pas_metadata_release
--

commit 8e4c5b119cfde717dbade4e353783f865e47fb32
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

wifi: ath12k: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_=
prepare_and_auth_reset()

ath12k_ahb_power_up() and ath12k_ahb_load_auth_shared_fw() call
qcom_mdt_load() for SCM-authenticated paths and then
qcom_pas_auth_and_reset() which skips the shmbridge prepare step
required before TrustZone authentication.

> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless=
/ath/ath12k/ahb.c
> index 85360365aa4b2..6f0ad29a83f85 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c

[ ... ]

> @@ -424,14 +425,20 @@ static int ath12k_ahb_power_up(struct ath12k_base *=
ab)
>  		ATH12K_AHB_UPD_SWID;
> =20
>  	/* Load FW image to a reserved memory location */
> -	if (ab_ahb->scm_auth_enabled)
> -		ret =3D qcom_mdt_load(dev, fw, fw_name, pasid, rproc_info->mem_region,
> -				    rproc_info->mem_phys, rproc_info->mem_size,
> -				    NULL);
> -	else
> +	if (ab_ahb->scm_auth_enabled) {
> +		ctx =3D devm_qcom_pas_context_alloc(dev, pasid,
> +						  rproc_info->mem_phys,
> +						  rproc_info->mem_size);

[Severity: High]
Is it safe to use a devm-managed allocation here?

Since ath12k_ahb_power_up() is called dynamically during normal device
operation, such as in firmware crash recovery loops, and the platform device
does not unbind during this process, does this permanently leak a
struct qcom_pas_context on every power-up cycle?

> +		if (IS_ERR(ctx)) {
> +			ret =3D PTR_ERR(ctx);
> +			goto err_fw;
> +		}
> +		ret =3D qcom_mdt_pas_load(ctx, fw, fw_name, NULL);

[Severity: High]
Does this code leak TrustZone memory?

qcom_mdt_pas_load() allocates firmware metadata inside TrustZone. The
caller is typically required to invoke qcom_pas_metadata_release() to
free this secure memory after authentication is complete or on error.

Without a call to qcom_pas_metadata_release() here or later in the
function, is this secure memory permanently lost on every firmware load?

> +	} else {
>  		ret =3D qcom_mdt_load_no_init(dev, fw, fw_name, rproc_info->mem_region,
>  					    rproc_info->mem_phys, rproc_info->mem_size,
>  					    NULL);
> +	}

[ ... ]

> @@ -1012,14 +1020,19 @@ static int ath12k_ahb_load_auth_shared_fw(struct =
ath12k_base *ab,
>  	ath12k_dbg(ab, ATH12K_DBG_AHB, "loading firmware %s, size %zd\n", fw_na=
me,
>  		   fw->size);
> =20
> -	ret =3D qcom_mdt_load(ab->dev, fw, fw_name, pasid, rproc_info->mem_regi=
on,
> -			    rproc_info->mem_phys, rproc_info->mem_size, NULL);
> +	ctx =3D devm_qcom_pas_context_alloc(ab->dev, pasid,
> +					  rproc_info->mem_phys,
> +					  rproc_info->mem_size);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	ret =3D qcom_mdt_pas_load(ctx, fw, fw_name, NULL);

[Severity: High]
Similar to the question above, is a call to qcom_pas_metadata_release()
needed here to prevent leaking TrustZone memory after the shared
firmware is loaded and authenticated?

>  	if (ret) {
>  		ath12k_err(ab, "failed to load RO firmware %s: %d\n", fw_name, ret);
>  		return ret;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925155737.4161=
358-1-mukesh.ojha@oss.qualcomm.com?part=3D6
