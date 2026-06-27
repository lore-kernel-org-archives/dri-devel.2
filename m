Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3869FC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DDF10E4E1;
	Sat, 27 Jun 2026 13:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FRJsDjJr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF39210E4DC
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B29B444078
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A631F000E9;
 Sat, 27 Jun 2026 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782567748;
 bh=eKf34vMmv+GKYSnNpZQq7pBjGII5MTvdEfmFaR/JBhA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FRJsDjJrDTTzIgjzk7fYw8fXqGlYy2VLJO8GCuThHiVJzR9iHDXR7djPLDBh1xGOQ
 iy06vd6pT1ZN3wUL29mPlVqvVYSnPhqYDR9N8emFf0A9Qrao7YY0gG6nOlFcOIy/pb
 1qIS35Sh5IZVzcbV5j0Dsl5eFCaUObJiG7L/9IpxGJcAlmUb5l+f8TwoSnTmzcB0Dc
 AeVQQhxswT+bGSHoG2RpLA1/5eNEGNHRQ0SzcMGRhnK6T1fH+drINBfJBtYDomg3fF
 22vgeb0WV8Jqzr2tOGleh1DsiowxiMhkAvO7E8ASbBsg++2Q7INjT0SyWFmKeuXUXn
 VpNOcCCmdse/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/14] remoteproc: qcom_q6v5_mss: Switch to generic
 PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133440.692849-6-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-6-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:42:27 +0000
Message-Id: <20260627134228.66A631F000E9@smtp.kernel.org>
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
- [High] Replacing `qcom_scm_is_available()` with `qcom_pas_is_available()`=
 removes the SCM dependency check, leading to a NULL pointer dereference du=
ring memory protection.
- [High] The generic PAS API removes the hard module dependency on the back=
end provider, exposing client drivers to a TOCTOU race condition and Use-Af=
ter-Free.

Pre-existing issues:
- [High] Missing initialization of `need_pas_mem_setup` makes PAS memory se=
tup silently skipped.
--

commit 286e03507d8f96a33a10d31ad2cb432432734d78
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs

This commit switches the qcom_q6v5_mss client driver to use the generic PAS
TZ APIs. This enables support for multiple TZ implementation backends, such
as QTEE based SCM PAS service and OP-TEE based PAS service.

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

[Severity: High]
This is a pre-existing issue, but I noticed that need_pas_mem_setup is never
populated from the match descriptor in q6v5_probe(). Since qproc is
allocated via devm_rproc_alloc() and zero-initialized, this boolean will
always be false.

Does this prevent qcom_pas_mem_setup() from ever being called even on
platforms that require it?

> -		ret =3D qcom_scm_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->m=
pss_size);
> +		ret =3D qcom_pas_mem_setup(MPSS_PAS_ID, qproc->mpss_phys, qproc->mpss_=
size);

[Severity: High]
Does this new generic PAS API safely handle backend module unloading?

Previously, calling qcom_scm_pas_mem_setup() created a hard symbol
dependency, preventing the backend module from being unloaded. The generic
framework uses a lockless ops_ptr without acquiring module references:

drivers/firmware/qcom/qcom_pas.c:qcom_pas_mem_setup() {
    if (!ops_ptr)
        return -ENODEV;

    return ops_ptr->mem_setup(ops_ptr->dev, pas_id, addr, size);
}

Could the backend module be unloaded after the ops_ptr check but before or
during the mem_setup() call, leading to a use-after-free or NULL pointer
dereference?

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
Is it safe to replace the SCM availability check with the PAS availability
check here?

If need_mem_protection is true, q6v5_mpss_load() will unconditionally call
q6v5_xfer_mem_ownership(), which eventually relies on qcom_scm_assign_mem()
and dereferences the internal SCM structures.

If a non-SCM PAS backend is available but SCM is uninitialized, the PAS
check will succeed here, but the subsequent memory protection operations
will trigger a NULL pointer dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133440.6928=
49-1-sumit.garg@kernel.org?part=3D5
