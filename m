Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2F1C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E78A10E82C;
	Mon, 14 Sep 2026 13:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VnzI4iHe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD3210E82C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:05:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9EB7E43360;
 Mon, 14 Sep 2026 13:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEE91F00893;
 Mon, 14 Sep 2026 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789391151;
 bh=UhPEOJqTs67Eeq+UZJa/bD+StAhuLkJTTyYWTn19uuA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VnzI4iHeUgg0N3Zlpp8CcIfKABJP5hZrrr2Yr8tbSini3wPSABfTADmzwrA+aAGki
 +u1B/DnCjVfKfDaZOHwrTyuaG13LnVsa2nCVmquUiIelzXcyplMRw9Bkbiu1AnVANf
 gIxxJ0p5TsZHMsY93qfITigK5nculRkySUl1l0RlolkGytnE7f+t7HcrhDU7kn015g
 WuxKTNGie/2G+zyhqbml+6aZx9TgfgDnd6e5y2n/4D4ETBzI9HJAVOx50eobvrQGuj
 IUvEpXbDtA71dXav9SAin3+u3WCDvVefFVabjsPIaoZwNauyjyaMCNcD+56q6+n4Mo
 RToqzRWQvPrZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] firmware: qcom: scm: pass qcom_scm through the
 exported API
To: "Albert Esteve" <aesteve@redhat.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260914-scm-device-api-v1-2-3573e2596c51@redhat.com>
References: <20260914-scm-device-api-v1-0-3573e2596c51@redhat.com>
 <20260914-scm-device-api-v1-2-3573e2596c51@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:05:50 +0000
Message-Id: <20260914130551.4AEE91F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] NULL pointer dereference in fastrpc_rpmsg_probe() when allocating =
memory for SDSP_DOMAIN_ID on systems without the qcom,vmids property.
- [High] SMP initialization is unconditionally disabled on Qualcomm ARM32 p=
latforms.
- [Low] Unupdated caller of `qcom_scm_io_writel()` in the USB EUD driver.
- [Low] Unupdated caller of `qcom_scm_mem_protect_video_var()` in the Iris =
media driver.
--

commit 9df6c4c915fd9c1b7019af817a1a3e4285555806
Author: Albert Esteve <aesteve@redhat.com>

firmware: qcom: scm: pass qcom_scm through the exported API

This commit modifies the exported SCM calls to take an explicit struct qcom=
_scm
handle instead of using a global singleton. Subsystems and device drivers a=
re
updated to recover the instance via dev_get_drvdata() or qcom_scm_get() bef=
ore
calling SCM APIs.

> diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
> index eca2fe0f4314b..c4e7aab77bc99 100644
> --- a/arch/arm/mach-qcom/platsmp.c
> +++ b/arch/arm/mach-qcom/platsmp.c
> @@ -355,9 +355,10 @@ static int kpssv2_boot_secondary(unsigned int cpu, s=
truct task_struct *idle)
> =20
>  static void __init qcom_smp_prepare_cpus(unsigned int max_cpus)
>  {
> +	struct qcom_scm *scm =3D qcom_scm_get();
>  	int cpu;
> =20
> -	if (qcom_scm_set_cold_boot_addr(secondary_startup_arm)) {
> +	if (!scm || qcom_scm_set_cold_boot_addr(scm, secondary_startup_arm)) {

[Severity: High]
Does this code unintentionally disable SMP on all Qualcomm ARM32 devices?

Because qcom_smp_prepare_cpus() is called early in the boot process (from=20
smp_prepare_cpus()), before do_initcalls() probes the qcom_scm platform dri=
ver,
qcom_scm_get() will unconditionally return NULL here.

This causes the (!scm) condition to short-circuit to true, skipping the SCM
call and executing the error path which clears the cpu_present mask for all
secondary CPUs.

[ ... ]
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 90fd669636ec1..e8ff9d4b03957 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -2569,13 +2574,17 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
e *rpdev)
>  				"qcom,vmids", &vmids[0], 0, FASTRPC_MAX_VMIDS);
>  	if (vmcount < 0)
>  		vmcount =3D 0;
> -	else if (!qcom_scm_is_available())
> -		return -EPROBE_DEFER;
> +	else {
> +		scm =3D qcom_scm_get();
> +		if (!scm)
> +			return -EPROBE_DEFER;
> +	}
> =20
>  	data =3D kzalloc_obj(*data);
>  	if (!data)
>  		return -ENOMEM;
> =20
> +	data->scm =3D scm;
>  	if (vmcount) {
>  		data->vmcount =3D vmcount;
>  		for (i =3D 0; i < data->vmcount; i++) {
> @@ -2592,7 +2601,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  		if (!err) {
>  			src_perms =3D BIT(QCOM_SCM_VMID_HLOS);
> =20
> -			err =3D qcom_scm_assign_mem(res.start, resource_size(&res), &src_perm=
s,
> +			err =3D qcom_scm_assign_mem(scm, res.start, resource_size(&res), &src=
_perms,

[Severity: High]
Can this result in a NULL pointer dereference in qcom_scm_assign_mem() when
allocating TZ memory?

If the "qcom,vmids" DT property is missing, vmcount defaults to 0 and the
"else" block above is skipped, leaving the scm pointer as NULL. Later in
fastrpc_rpmsg_probe(), for the SDSP_DOMAIN_ID domain with a reserved memory
region, this code unconditionally passes the NULL scm pointer to
qcom_scm_assign_mem().

Inside qcom_scm_assign_mem(), the NULL pointer is immediately dereferenced
during the memory allocation call:=20
qcom_tzmem_alloc(scm->mempool, ...)

[ ... ]
> diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmw=
are/qcom/qcom_scm.h
> index 5747bd191bf15..9c513fe6f0ea9 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
[ ... ]
> -int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
> -int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
> +int qcom_scm_io_readl(struct qcom_scm *scm, phys_addr_t addr, unsigned i=
nt *val);
> +int qcom_scm_io_writel(struct qcom_scm *scm, phys_addr_t addr, unsigned =
int val);

[Severity: Low]
Are there unupdated callers of qcom_scm_io_writel() that will cause a build
failure?

The enable_eud() and disable_eud() functions in drivers/usb/misc/qcom_eud.c
appear to call qcom_scm_io_writel() without the newly required struct qcom_=
scm
pointer as the first argument.

[ ... ]
> -int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
> +int qcom_scm_mem_protect_video_var(struct qcom_scm *scm, u32 cp_start, u=
32 cp_size,
>  				   u32 cp_nonpixel_start, u32 cp_nonpixel_size);

[Severity: Low]
Could this signature change also cause a build failure?

The iris_set_cp_prot() function in drivers/media/platform/qcom/iris/iris_fi=
rmware.c
appears to still call qcom_scm_mem_protect_video_var() without the newly
required struct qcom_scm pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-scm-device=
-api-v1-0-3573e2596c51@redhat.com?part=3D2
