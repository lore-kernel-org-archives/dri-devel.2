Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49014C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F7910E5CF;
	Fri,  3 Jul 2026 12:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UkrumL1J";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAA510E5BB
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2D8441A66
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E85B1F00A3A;
 Fri,  3 Jul 2026 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080160;
 bh=tNDlnGSQRBRdimSo4nNCsWu0+EmCopOMoPyOI4HkfuI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UkrumL1JdGxvpxirZJt/CSwXKk+Jy6oOTdcqxAIOE7TReNDRDhf0Cmc3/Cy/Udf7b
 c67ClLTQpjadszXT0OZzdEgbadAn+62N6FzCKD30yOGJz+tSavaNwq473kkrtC2ygH
 lSxU+7zt0bLdp+sEqZBdGII7tygluJ4UZeJCK+NclxxuNRqyFOyEAlI1w18BINYYbO
 SvcIpA8tgluJieu75A8S7IBaOxzJKFxI05+gzCZGu63aqLguSWfgRiVjVZEMN/lpyE
 HR1n0PlZ1SJoEsrGPGez+rPysChAt/FRBh2PasR1jq3JTYXvXRTFLZ3yEdGdCLaGHg
 /TGlBHZDDbt9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/14] remoteproc: qcom_wcnss: Switch to generic PAS
 TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260702115835.167602-7-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-7-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:02:39 +0000
Message-Id: <20260703120240.4E85B1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The generic qcom_pas API lacks synchronization against concurrent =
registration and backend unregistration, leading to TOCTOU races and Use-Af=
ter-Free.
- [High] Blindly trusting param[1].u.memref.size from the second TEE invoca=
tion in qcom_pas_tee_get_rsc_table() leads to an out-of-bounds read and ker=
nel memory leak.

Pre-existing issues:
- [High] The wcnss_probe() function fails to clean up sysmon and smd subdev=
ices on error paths, leading to memory/socket leaks and dangling pointers i=
n a global notifier chain.
--

commit f9552b7475ea1af7226f210e3b4d0e315d46e17d
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs

Switch qcom_wcnss client driver over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

> Switch qcom_wcnss client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.

[Severity: High]
Is there an out-of-bounds read and kernel memory leak in the OP-TEE PAS
service?

In drivers/firmware/qcom/qcom_pas_tee.c:qcom_pas_tee_get_rsc_table(), a
shared memory buffer is allocated based on the size from the first TEE
invocation. In the second TEE invocation, the TEE can modify
param[1].u.memref.size.

The function then blindly trusts this size:

    *output_rt_size =3D param[1].u.memref.size;
    rt_buf =3D kmemdup(rt_shm_va, *output_rt_size, GFP_KERNEL);

Can a compromised TrustZone environment return an increased size, causing an
out-of-bounds read from the originally allocated buffer?

> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wc=
nss.c
> index 4add9037dbd5a..0dbdd18ab3dd9 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
[ ... ]
> @@ -257,7 +257,7 @@ static int wcnss_start(struct rproc *rproc)
>  	wcnss_indicate_nv_download(wcnss);
>  	wcnss_configure_iris(wcnss);
> =20
> -	ret =3D qcom_scm_pas_auth_and_reset(WCNSS_PAS_ID);
> +	ret =3D qcom_pas_auth_and_reset(WCNSS_PAS_ID);

[Severity: High]
Can this introduce a TOCTOU race window?

If multiple PAS backends probe concurrently, qcom_pas_ops_register() in
drivers/firmware/qcom/qcom_pas.c performs a lockless read-modify-write of
ops_ptr:

    if (!qcom_pas_is_available())
        smp_store_release(&ops_ptr, ops);

This allows one backend to silently overwrite another.

Additionally, when this driver calls qcom_pas_auth_and_reset(), it lacks
RCU or try_module_get() protection:

    if (!ops_ptr)
        return -ENODEV;

    return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);

If the backend module is unloaded concurrently, ops_ptr is unregistered and
the module memory is freed, leaving this driver to dereference a dangling
function pointer. Is there a way to serialize these registrations and
protect the backend access?

[ ... ]
> @@ -557,10 +557,10 @@ static int wcnss_probe(struct platform_device *pdev)
> =20
>  	data =3D of_device_get_match_data(&pdev->dev);
> =20
> -	if (!qcom_scm_is_available())
> +	if (!qcom_pas_is_available())
>  		return -EPROBE_DEFER;

[Severity: High]
This is a pre-existing issue, but does wcnss_probe() fail to clean up
subdevices on error paths?

Earlier in wcnss_probe(), qcom_add_sysmon_subdev() and qcom_add_smd_subdev()
are called. If qcom_iris_probe() subsequently fails (e.g., returning
-EPROBE_DEFER because regulators are not ready), the error path jumps to
detach_pds:

    if (IS_ERR(wcnss->iris)) {
        ret =3D PTR_ERR(wcnss->iris);
        goto detach_pds;
    }

And the cleanup path skips subdevice removal entirely:

    remove_iris:
        qcom_iris_remove(wcnss->iris);
    detach_pds:
        wcnss_release_pds(wcnss);

Since qcom_add_sysmon_subdev() allocates memory, creates a QMI socket, and
registers a notifier on the global sysmon_notifiers chain, does this leak
these resources on every probe deferral?

Furthermore, sysmon->dev caches the platform device pointer, which becomes
a dangling pointer if the device is ultimately removed. Could this lead to
a use-after-free when sysmon_notify iterates over the leaked notifiers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702115835.1676=
02-1-sumit.garg@kernel.org?part=3D6
