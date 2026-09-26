Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9D7C9832A
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8497210E25D;
	Sat, 26 Sep 2026 15:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RYXHLKjT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5EC10E19A
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:59:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7669F40E4E;
 Sat, 26 Sep 2026 15:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250F71F000FF;
 Sat, 26 Sep 2026 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790438375;
 bh=aWxiqlwIxXYpoyfxQ2PFS3pT9LPsWFBZoXY1Jfeh55E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RYXHLKjTgrG1WjjlC+huhlDZhcmkf1tzdNXPOrB9hkgBiDX/iP/80dzQ2efIEvQhY
 HXgXrSSdO7h3MiYZ2B5tDNcgp01YjEeKd4+hV9Gi7m/PeY9wdDvFuN6hM8yMRTFUG7
 ZWkVnWaKr42M0IezKEpArsyIvymLRJe5Re76qMsKMX5tfJEpTznhskXKhjlNRZKffg
 +o+6d878Tsw9g1orQylIUk4nRF09RbIMnEW2YbT2Q/3/EjfRhuOlfPYMu6lTlVyo2e
 N/GPj367v+wow1aRf2vaePVkI+h16jcYuNuKADXDQLftDGfmP1/abss8eLSGsUX8Nj
 F26EZtfu6hLaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] media: venus: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260925155737.4161358-5-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-5-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 15:59:34 +0000
Message-Id: <20260926155935.250F71F000FF@smtp.kernel.org>
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
- [High] media: venus: devm_ allocation in venus_load_fw() causes leak on e=
rror recovery
--

commit 8d4223f26ac66cddad9e1923272c5c9297949631
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

media: venus: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_=
prepare_and_auth_reset()

This commit migrates the firmware loading for the TrustZone path to use the
new PAS context allocation and loading functions. It threads the PAS context
from venus_load_fw() through to venus_boot() where authentication occurs.

> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media=
/platform/qcom/venus/firmware.c
> index 3a38ff985822f..4ea4c7769ac3d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c

[ ... ]

> @@ -117,21 +116,19 @@ static int venus_load_fw(struct venus_core *core, c=
onst char *fwname,
>  		goto err_release_fw;
>  	}
> =20
> -	mem_va =3D memremap(*mem_phys, *mem_size, MEMREMAP_WC);
> -	if (!mem_va) {
> -		dev_err(dev, "unable to map memory region %pa size %#zx\n", mem_phys, =
*mem_size);
> -		ret =3D -ENOMEM;
> -		goto err_release_fw;
> -	}
> -
> -	if (core->use_tz)
> -		ret =3D qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
> -				    mem_va, *mem_phys, *mem_size, NULL);
> -	else
> -		ret =3D qcom_mdt_load_no_init(dev, mdt, fwname, mem_va,
> +	if (core->use_tz) {
> +		core->fw.pas_ctx =3D devm_qcom_pas_context_alloc(dev, VENUS_PAS_ID,
> +							       *mem_phys, *mem_size);

[Severity: High]
Does this devm allocation leak memory during firmware error recovery?

Looking at the firmware recovery path, when a firmware crash occurs,
venus_sys_error_handler() repeatedly invokes venus_boot(), which then calls
venus_load_fw().

Because devm_qcom_pas_context_alloc() attaches the allocation to the device=
's
lifecycle, it is only freed when the device is unbound. Each recovery cycle
will allocate a new PAS context and overwrite core->fw.pas_ctx without free=
ing
the previous one. This could lead to unbounded memory consumption and an OOM
crash if an attacker or stream continuously triggers firmware crashes.

> +		if (IS_ERR(core->fw.pas_ctx)) {
> +			ret =3D PTR_ERR(core->fw.pas_ctx);
> +			core->fw.pas_ctx =3D NULL;
> +			goto err_release_fw;
> +		}
> +		ret =3D qcom_mdt_pas_load(core->fw.pas_ctx, mdt, fwname, NULL);
> +	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925155737.4161=
358-1-mukesh.ojha@oss.qualcomm.com?part=3D4
