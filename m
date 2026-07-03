Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E00EC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B32A010E5D2;
	Fri,  3 Jul 2026 12:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ETzd7Vpy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E341C10E5D2
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68A926001A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DAB1F00A3E;
 Fri,  3 Jul 2026 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080164;
 bh=fwjG7Ufaa41nImmKQ0Yng040IzFjrHu1EhJsqbaDKDQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ETzd7VpywGNUoCx6KiC+h6+X5783FmoIdvyL8VNP6AjDy8lw7rv1NQZyZulSsOBpZ
 SKkF2frjwWE50oJ0CKOGY2tulpOK6i1Uy/5USX2SRHiIQ64GyNsoOC7/xer/bgqhr6
 QxetzIv9s4Gvzeh5dyZfip8o8krrfe8OfdupKmeZRg6Bm9BhWLR11OWeXNA1jXVuOT
 70Z13GT24PH9yBbyxJucm9jybx0oA4j2UpoCCKmgwSc0o1w6v7kaHLZ7vKHHwYLpRa
 i6p6jRYWGByMK3XD/hN4WBYbIgiDXXnqcPO4fWkhp7FiJrKc5Gap1tKb5OrdiRG88b
 hp5VrC8I+8bJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/14] remoteproc: qcom_q6v5_mss: Switch to generic
 PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260702115835.167602-6-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-6-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:02:43 +0000
Message-Id: <20260703120243.E0DAB1F00A3E@smtp.kernel.org>
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
- [High] Replacing the SCM availability check with a generic PAS check duri=
ng probe breaks the strict SCM dependency for memory protection, leading to=
 a NULL pointer dereference in `qcom_scm_assign_mem()`.
- [High] Missing module reference counting in the generic PAS API exposes c=
lient drivers to a TOCTOU race and use-after-free if the backend module is =
unloaded.
--

commit f9f49708d56de20022405acdb58867dd0cffe7bb
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs

Switch qcom_q6v5_mss client driver over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom=
_q6v5_mss.c
> index ae78f5c7c1b69..96888007faa88 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c

[ ... ]

> @@ -1480,7 +1481,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
>  	}
> =20
>  	if (qproc->need_pas_mem_setup) {
> -		ret =3D qcom_scm_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->m=
pss_size);
> +		ret =3D qcom_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_=
size);

[Severity: High]
Is there a time-of-check to time-of-use race in the generic PAS API that co=
uld
lead to a use-after-free or NULL pointer dereference?

The client driver switches to using the newly introduced generic PAS API
without any mechanism to prevent backend unloads.

Looking at qcom_pas_mem_setup() in drivers/firmware/qcom/qcom_pas.c, the API
locklessly dereferences ops_ptr after checking it, without holding a module
reference or synchronization:

drivers/firmware/qcom/qcom_pas.c:qcom_pas_mem_setup() {
    if (!ops_ptr)
        return -ENODEV;

    return ops_ptr->mem_setup(ops_ptr->dev, pas_id, addr, size);
}

If a privileged user unloads the backend module (like qcom_pas_tee)
concurrently with the client driver starting the remoteproc, ops_ptr could =
be
set to NULL between the check and the dereference.

Does the generic PAS API need module reference counting (like try_module_ge=
t())
or device links to prevent the backend module from being unloaded while in =
use?

>  		if (ret) {
>  			dev_err(qproc->dev,
>  				"setting up mpss memory failed: %d\n", ret);

[ ... ]

> @@ -2077,7 +2078,7 @@ static int q6v5_probe(struct platform_device *pdev)
>  	if (!desc)
>  		return -EINVAL;
> =20
> -	if (desc->need_mem_protection && !qcom_scm_is_available())
> +	if (desc->need_mem_protection && !qcom_pas_is_available())

[Severity: High]
Does this change break the memory protection dependency on the SCM driver?

If desc->need_mem_protection is true, but the SCM driver is not available
(for example, if the OP-TEE PAS backend probes first, or if SCM fails to
probe), q6v5_probe() will now observe qcom_pas_is_available() as true and
incorrectly succeed without deferring probe for SCM.

When the remoteproc is later started, q6v5_xfer_mem_ownership()
unconditionally calls qcom_scm_assign_mem(), which directly dereferences
the uninitialized __scm pointer:

drivers/firmware/qcom/qcom_scm.c:qcom_scm_assign_mem() {
...
    void *ptr __free(qcom_tzmem) =3D qcom_tzmem_alloc(__scm->mempool,
                                                    ptr_sz, GFP_KERNEL);
...
}

Could this lead to a NULL pointer dereference in qcom_scm_assign_mem() on
configurations that use OP-TEE PAS or have SCM probe delayed?

>  		return -EPROBE_DEFER;
> =20
>  	mba_image =3D desc->hexagon_mba_image;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702115835.1676=
02-1-sumit.garg@kernel.org?part=3D5
