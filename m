Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B449FC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E871E10E5DB;
	Fri,  3 Jul 2026 12:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EfKUOVj0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 900AE10E5CC
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1328E60051
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED1C1F00A3A;
 Fri,  3 Jul 2026 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080162;
 bh=ngbaX6nb7qeIqecPaG/6U3S4pSgG4sMXCj/beQUNCp8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EfKUOVj0/iaqZhFmmBxDaGExiB4KSwAN2vaaw+njpsNa8xmJcYE11YJUKDQeDT1kk
 pXB3+1KVNDvQItuDwLRSb4YdV149uXrlIGRkQazUg27ZF40taO01CyAAZbEPesBVna
 Su0oFIuJnkfkNhGRPHAFuFCTGsb1PrDYupAgojDvfUlTsrIDCAozJdL4CFijkyoUzz
 YB6ytnRXMOGjqT/Rns3YSB+iji88TKDQSIawOPOKBoZK4CVxAxsZXcqjp3yJEPZjOe
 aqYtjbjwjQVuNN2gxZJKhzJENEGChGDOGPA6ilEFi+/lEU9PNzR6ZrRV+ckITn66Yq
 4WMYNQZOVkCIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/14] media: qcom: Switch to generic PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260702115835.167602-10-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-10-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:02:42 +0000
Message-Id: <20260703120242.6ED1C1F00A3A@smtp.kernel.org>
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
- [High] Calling qcom_scm_mem_protect_video_var() after changing the availa=
bility check to qcom_pas_is_available() causes a NULL pointer dereference o=
n non-SCM platforms.

Pre-existing issues:
- [High] The iris driver misses the mandatory qcom_pas_is_available() check=
, failing to defer probe and missing an smp_load_acquire() memory barrier w=
hen accessing the generic PAS API.
--

commit d77a18836b2d6ae833e5833c165d79299ffd8a66
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

media: qcom: Switch to generic PAS TZ APIs
   =20
Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/m=
edia/platform/qcom/iris/iris_firmware.c
> index 1a476146d7580..ea9654dd679e1 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c

[ ... ]

> @@ -80,7 +81,7 @@ int iris_fw_load(struct iris_core *core)
>  		return -ENOMEM;
>  	}
> =20
> -	ret =3D qcom_scm_pas_auth_and_reset(IRIS_PAS_ID);
> +	ret =3D qcom_pas_auth_and_reset(IRIS_PAS_ID);

[Severity: High]
This is a pre-existing issue, but it seems the iris driver is missing a che=
ck
for qcom_pas_is_available() during probe to defer if the backend isn't read=
y.

Because it misses the qcom_pas_is_available() check, it misses the mandatory
smp_load_acquire() memory barrier.

When userspace opens the device, iris_fw_load() invokes
qcom_pas_auth_and_reset(). This function performs a plain lockless load of
ops_ptr.

Is it possible for a weakly ordered architecture to observe a non-NULL ops_=
ptr
but uninitialized function pointers within the ops structure here, causing
a kernel panic?

>  	if (ret)  {
>  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>  		return ret;
> @@ -94,7 +95,7 @@ int iris_fw_load(struct iris_core *core)
>  						     cp_config->cp_nonpixel_size);
>  		if (ret) {
>  			dev_err(core->dev, "qcom_scm_mem_protect_video_var failed: %d\n", ret=
);
> -			qcom_scm_pas_shutdown(IRIS_PAS_ID);
> +			qcom_pas_shutdown(IRIS_PAS_ID);

[Severity: High]
If the PAS backend is non-SCM (like OP-TEE), the SCM driver will not be pro=
bed.

Since qcom_scm_mem_protect_video_var() is still called unconditionally just
before this error handling block, will it dereference a NULL __scm pointer
(__scm->dev) and crash the kernel?

>  			return ret;
>  		}
>  	}
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media=
/platform/qcom/venus/firmware.c
> index 1de7436713ed9..3a38ff985822f 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c

[ ... ]

> @@ -218,7 +219,7 @@ int venus_boot(struct venus_core *core)
>  	int ret;
> =20
>  	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> -	    (core->use_tz && !qcom_scm_is_available()))
> +	    (core->use_tz && !qcom_pas_is_available()))
>  		return -EPROBE_DEFER;
> =20
>  	ret =3D of_property_read_string_index(dev->of_node, "firmware-name", 0,

[ ... ]

> @@ -259,7 +260,7 @@ int venus_boot(struct venus_core *core)
>  						     res->cp_nonpixel_start,
>  						     res->cp_nonpixel_size);
>  		if (ret) {
> -			qcom_scm_pas_shutdown(VENUS_PAS_ID);
> +			qcom_pas_shutdown(VENUS_PAS_ID);

[Severity: High]
Similar to the iris driver, the availability check was changed to
qcom_pas_is_available(), but qcom_scm_mem_protect_video_var() is still call=
ed
unconditionally when cp_size > 0.

Will this also result in a NULL pointer dereference on non-SCM platforms?

>  			dev_err(dev, "set virtual address ranges fail (%d)\n",
>  				ret);
>  			return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702115835.1676=
02-1-sumit.garg@kernel.org?part=3D9
