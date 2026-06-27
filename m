Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE9DC43327
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB8810E20B;
	Sat, 27 Jun 2026 13:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VcZT8YMy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58B5F10E17E
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00AED43BE1
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79111F000E9;
 Sat, 27 Jun 2026 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782567745;
 bh=9ZoFkrRu89ENeWhXeVVbp2Khs9DZ4Qnzol8VG4feq8k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VcZT8YMyHU5qmKWAK+CDWjrbKaSOictOuqf8bzjz3P1V9DQPF7rTF6VGxida7Lc5o
 ct71ns5n9HupQ9cGGWRiOYV53DxkHPz8x9KEIheDv0jbDpjOvheplTNn5qw/vM+Bvb
 +ShhhbAONuMnnJ+ksEnFEYLmnQgr9WPK+aR2iW9aQI/13fOnhDDoh7Pr9C6jlOM+mw
 pM0EMQUlCJ4Z48v9kXBunWUEQrX2IQhg88swb43HI1SMr7cK3Asy6lsyZ8VFwS8FJ3
 MLR5XItgYhN74e7purIsoU9XgmN32C6sFWKTNkLK6Zwja3pd87+kV4vuMyMU+EGwVo
 hk20t6YDjGmYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/14] media: qcom: Switch to generic PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133440.692849-10-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-10-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:42:25 +0000
Message-Id: <20260627134225.A79111F000E9@smtp.kernel.org>
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
- [High] Calling `qcom_scm_mem_protect_video_var()` without ensuring SCM is=
 available causes a NULL pointer dereference.
- [High] Transition to generic PAS API introduces a Use-After-Free race con=
dition due to missing module reference management.
--

commit c3e79e117e7109763310cc691fd2c7bcd036f2c0
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

media: qcom: Switch to generic PAS TZ APIs

Switch qcom media client drivers over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media=
/platform/qcom/venus/firmware.c
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

[Severity: High]
By replacing qcom_scm_is_available() with qcom_pas_is_available(), we no
longer guarantee that the SCM driver has probed.

However, later in this function (and similarly in iris_fw_load), we still
unconditionally call the SCM-specific API:

drivers/media/platform/qcom/venus/firmware.c:venus_boot() {
    ...
    ret =3D qcom_scm_mem_protect_video_var(res->cp_start,
                                         res->cp_size,
                                         res->cp_nonpixel_start,
                                         res->cp_nonpixel_size);
    ...
}

If a non-SCM backend like OP-TEE is used, will this cause a NULL pointer
dereference in qcom_scm_call() because the global __scm pointer was never
initialized?

drivers/firmware/qcom/qcom_scm.c:qcom_scm_mem_protect_video_var() {
    ...
    ret =3D qcom_scm_call(__scm->dev, &desc, &res);
    ...
}

[ ... ]

> @@ -236,7 +237,7 @@ int venus_boot(struct venus_core *core)
>  	core->fw.mem_phys =3D mem_phys;
> =20
>  	if (core->use_tz)
> -		ret =3D qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> +		ret =3D qcom_pas_auth_and_reset(VENUS_PAS_ID);

[Severity: High]
Does switching to the generic PAS API introduce a use-after-free race
condition if the backend module is unloaded concurrently?

Looking at the generic PAS implementation:

drivers/firmware/qcom/qcom_pas.c:qcom_pas_auth_and_reset() {
    if (!ops_ptr)
        return -ENODEV;

    return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
}

If the generic PAS backend is built as a module and unloaded by userspace
right after the ops_ptr check passes, could ops_ptr->auth_and_reset jump to
unmapped memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133440.6928=
49-1-sumit.garg@kernel.org?part=3D9
