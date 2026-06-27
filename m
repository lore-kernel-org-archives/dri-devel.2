Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6899C43327
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C8210E4E9;
	Sat, 27 Jun 2026 13:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VdC/GR/a";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC19510E4DB
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C26E64401F
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729921F000E9;
 Sat, 27 Jun 2026 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782567751;
 bh=RwQW0t+wjP08WlM2W25gfDO8uENvKErpPc9RvElmC1I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VdC/GR/a79m/WTy3PljOMDuwOyYCnQX+GHEWOjynkX5m6Bh5JFYQCMITm4OlW7YJ/
 o3011KedREtdeIOhiR4+5NmJ1A8W1V3pq9S98sflWju0RKil8ms+X2TfUxnwzw8G0s
 YLqi2Ecg/vSU3hBassJIr2jgrRpg3scTq1d6y6T7EsdoWfGO4FqV1h0OhUtbO3MUru
 j0IJhYITK0TwliJIppbmamKuah7Q4+q6ssBsdGNeAe0apd2huo1a9g8QGfxxuI5wid
 NUZka8KHUhma1nziSEE6vJUr6RAl2OYYkbDTxdaOzjsUbxh/7Q8XKy4+IoaYbxBRI+
 1Pvxd8ARVowPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/14] remoteproc: qcom_wcnss: Switch to generic PAS
 TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133440.692849-7-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-7-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:42:31 +0000
Message-Id: <20260627134231.729921F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The generic PAS API functions in qcom_pas.c suffer from a TOCTOU r=
ace condition when reading the global ops_ptr, leading to a potential NULL =
pointer dereference.

Pre-existing issues:
- [High] Missing cleanup of SMD and Sysmon subdevices on wcnss_probe() erro=
r paths leads to resource leaks and Use-After-Free vulnerabilities.
- [High] Removing iris before deleting rproc in wcnss_remove() creates a Us=
e-After-Free race condition.
- [High] Missing reinit_completion() causes spurious success on subsequent =
remoteproc starts or stops.
- [High] Infinite polling loop in wcnss_configure_iris() can cause kernel h=
angs.
--

commit f90353d8289b80221557c481e264c0861b3fde18
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs

This commit switches the qcom_wcnss client driver to use the generic PAS TZ
APIs. This allows support for multiple TZ implementations like QTEE or OP-T=
EE.

> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wc=
nss.c
> index 4add9037dbd5a..0dbdd18ab3dd9 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -257,7 +257,7 @@ static int wcnss_start(struct rproc *rproc)
>  	wcnss_indicate_nv_download(wcnss);
>  	wcnss_configure_iris(wcnss);

[Severity: High]
This is a pre-existing issue, but can the infinite polling loops inside
wcnss_configure_iris() cause a hard kernel hang if the hardware is wedged?

Inside wcnss_configure_iris(), we poll hardware registers without a timeout:

drivers/remoteproc/qcom_wcnss.c:wcnss_configure_iris() {
    ...
    while (readl(wcnss->pmu_cfg) & WCNSS_PMU_IRIS_RESET_STS)
        cpu_relax();
    ...
    while (readl(wcnss->pmu_cfg) & WCNSS_PMU_IRIS_XO_CFG_STS)
        cpu_relax();
    ...
}

Could this lead to a denial of service if the register returns 0xffffffff or
remains unresponsive?

> =20
> -	ret =3D qcom_scm_pas_auth_and_reset(WCNSS_PAS_ID);
> +	ret =3D qcom_pas_auth_and_reset(WCNSS_PAS_ID);

[Severity: High]
Does this new qcom_pas_auth_and_reset() call introduce a race condition?

Looking at the generic PAS API implementation in qcom_pas.c:

drivers/firmware/qcom/qcom_pas.c:qcom_pas_auth_and_reset() {
    if (!ops_ptr)
        return -ENODEV;

    return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
}

Since ops_ptr is checked and then dereferenced without READ_ONCE() or locks,
could a concurrent backend module unload set ops_ptr to NULL between the ch=
eck
and the dereference, causing a kernel panic?

[Severity: High]
This is a pre-existing issue, but does wcnss_start() risk spurious success
on subsequent starts if a previous wait timed out?

There is a call to wait_for_completion_timeout(&wcnss->start_done, ...) rig=
ht
below this in wcnss_start(). If it times out, but a delayed ready interrupt
later calls complete(&wcnss->start_done), the next wcnss_start() could
instantly succeed without actually waiting for the firmware.

Should reinit_completion() be called before initiating the wait in both
wcnss_start() and wcnss_stop()?

>  	if (ret) {
>  		dev_err(wcnss->dev,
>  			"failed to authenticate image and release reset\n");

[ ... ]

> @@ -557,10 +557,10 @@ static int wcnss_probe(struct platform_device *pdev)
> =20
>  	data =3D of_device_get_match_data(&pdev->dev);
> =20
> -	if (!qcom_scm_is_available())
> +	if (!qcom_pas_is_available())
>  		return -EPROBE_DEFER;

[Severity: High]
This is a pre-existing issue, but do the error paths in wcnss_probe() leak
the SMD and Sysmon subdevices?

In wcnss_probe(), qcom_add_sysmon_subdev() allocates memory and registers a
notifier to a global chain. If a subsequent step like qcom_iris_probe()
fails, the error path jumps to remove_iris or detach_pds:

drivers/remoteproc/qcom_wcnss.c:wcnss_probe() {
    ...
remove_iris:
    qcom_iris_remove(wcnss->iris);
detach_pds:
    wcnss_release_pds(wcnss);

    return ret;
}

This path fails to call qcom_remove_sysmon_subdev() and
qcom_remove_smd_subdev(). Could this leave the sysmon object in the global
notifier chain, leading to a use-after-free when the notifier triggers?

[Severity: High]
This is a pre-existing issue, but does wcnss_remove() have a use-after-free
race condition by freeing the iris object before stopping the remoteproc?

drivers/remoteproc/qcom_wcnss.c:wcnss_remove() {
    ...
    qcom_iris_remove(wcnss->iris);
    rproc_del(wcnss->rproc);
    ...
}

Because rproc_del() hasn't stopped the remoteproc yet, userspace could
concurrently trigger wcnss_start(). Since wcnss_start() checks
if (!wcnss->iris), which passes because the pointer is freed but not nulled,
it then calls qcom_iris_enable(wcnss->iris) on freed memory.

Should rproc_del() be called before qcom_iris_remove() to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133440.6928=
49-1-sumit.garg@kernel.org?part=3D6
