Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F6BC43327
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D43E10E4DF;
	Sat, 27 Jun 2026 13:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lrBpzjvz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B2D10E4DB
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DFD460051
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 13:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC9C1F000E9;
 Sat, 27 Jun 2026 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782567753;
 bh=rh60Je7YIvQw0mGlqyT/jE4x8/MvVrvMXA6kHD1g3Ho=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lrBpzjvzyzQNH6fMN4HIbMOvIL4PZeLPAN0rlkXn5L3Xhux3DVxLSw9a2RgQ07rXq
 DYb4Gza0+jaLYT7Y1F5LMcGNYAWgddMPo+TkSifoA9xw6SAhmPlJDuMN6/OKKzax+u
 HNC2tldRJCWZ9HJ1D+eTqCTkLxQaKY4CZKqo9THXZ8REZFZfr3pT5IRNjadDOvRFMM
 w9vhVS+AYe9qFMWT8O+OmuX7hu/IiLM001EUnw3P15OnpjTcLN8PP5EBIbH+kOZw23
 eGUvrzaSmjRw3Cp0yYlvZ35PXq/sLL69eTmy/MbWnVBEy+p6W6J+JsJ0b8ecCYq7aA
 Vfv1hEUz4w+Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/14] remoteproc: qcom_q6v5_pas: Switch over to
 generic PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626133440.692849-5-sumit.garg@kernel.org>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-5-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 13:42:32 +0000
Message-Id: <20260627134232.EAC9C1F000E9@smtp.kernel.org>
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
- [High] Removing the `qcom_scm_is_available()` check in `qcom_pas_probe()`=
 exposes the driver to a NULL pointer dereference in `qcom_scm_assign_mem()=
`.

Pre-existing issues:
- [High] `pas->dtb_firmware` is leaked on the success path because `release=
_firmware()` is never called.
- [High] If `qcom_pas_start()` fails after authenticating the DTB PAS, it n=
ever invokes `qcom_pas_shutdown()` for the DTB PAS, leaving it permanently =
running/authenticated in TrustZone.
--

commit 410365720c51e458aee76cb1ae2177033dc208d2
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs

This commit switches the qcom_q6v5_pas client driver over to use generic PAS
TZ APIs. This allows support for multiple TZ implementation backends, and
updates the MDT loader PAS dependencies to prevent build issues.

> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom=
_q6v5_pas.c
> index 808e9609988d3..9eb1c4f6c2ab4 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
[ ... ]
> @@ -225,9 +226,9 @@ static int qcom_pas_load(struct rproc *rproc, const s=
truct firmware *fw)
>  	pas->firmware =3D fw;
> =20
>  	if (pas->lite_pas_id)
> -		qcom_scm_pas_shutdown(pas->lite_pas_id);
> +		qcom_pas_shutdown(pas->lite_pas_id);
>  	if (pas->lite_dtb_pas_id)
> -		qcom_scm_pas_shutdown(pas->lite_dtb_pas_id);
> +		qcom_pas_shutdown(pas->lite_dtb_pas_id);
> =20
>  	if (pas->dtb_pas_id) {
>  		ret =3D request_firmware(&pas->dtb_firmware, pas->dtb_firmware_name, p=
as->dev);
[ ... ]
>  		ret =3D qcom_mdt_pas_load(pas->dtb_pas_ctx, pas->dtb_firmware,
>  					pas->dtb_firmware_name, pas->dtb_mem_region,
>  					&pas->dtb_mem_reloc);
>  		if (ret)
>  			goto release_dtb_metadata;
>  	}
> =20
>  	return 0;

[Severity: High]
This is a pre-existing issue, but does this code leak the DTB firmware buff=
er
on the success path?

If request_firmware() successfully allocates pas->dtb_firmware, it doesn't
appear to be freed with release_firmware() here before returning 0, nor
is it released anywhere in the teardown callbacks like qcom_pas_stop() or
qcom_pas_unprepare().

Could this lead to memory exhaustion if the remoteproc is repeatedly started
and stopped via sysfs?

> =20
>  release_dtb_metadata:
> -	qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +	qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  	release_firmware(pas->dtb_firmware);
> =20
>  	return ret;
[ ... ]
> @@ -307,7 +308,7 @@ static int qcom_pas_start(struct rproc *rproc)
>  		if (ret)
>  			goto disable_px_supply;
> =20
> -		ret =3D qcom_scm_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
> +		ret =3D qcom_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
>  		if (ret) {
>  			dev_err(pas->dev,
>  				"failed to authenticate dtb image and release reset\n");
> @@ -326,7 +327,7 @@ static int qcom_pas_start(struct rproc *rproc)
>  	if (ret)
>  		goto release_pas_metadata;
[ ... ]
>  unmap_carveout:
>  	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
>  release_pas_metadata:
> -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> +	qcom_pas_metadata_release(pas->pas_ctx);
>  	if (pas->dtb_pas_id)
> -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +		qcom_pas_metadata_release(pas->dtb_pas_ctx);

[Severity: High]
This isn't a bug introduced by this patch, but if a failure occurs after the
DTB PAS is successfully authenticated, could this strand the TrustZone stat=
e?

If qcom_pas_prepare_and_auth_reset(pas->dtb_pas_ctx) succeeds, but a
subsequent step like qcom_mdt_pas_load() fails, the code jumps to the
release_pas_metadata label.

The error unwind doesn't seem to invoke qcom_pas_shutdown(pas->dtb_pas_id)
for the DTB PAS, which might leave the DTB PAS session permanently active in
TrustZone until the next reboot.

> =20
>  unmap_dtb_carveout:
>  	if (pas->dtb_pas_id)
[ ... ]
> @@ -743,7 +744,7 @@ static int qcom_pas_probe(struct platform_device *pde=
v)
>  	if (!desc)
>  		return -EINVAL;
> =20
> -	if (!qcom_scm_is_available())
> +	if (!qcom_pas_is_available())
>  		return -EPROBE_DEFER;
> =20
>  	fw_name =3D desc->firmware_name;

[Severity: High]
By changing this dependency check from qcom_scm_is_available() to
qcom_pas_is_available(), is it possible to encounter a NULL pointer
dereference later in the probe sequence?

If the OP-TEE PAS backend is registered, qcom_pas_is_available() returns tr=
ue,
allowing probe to proceed even if the qcom_scm driver is deferred or
unavailable.

Later in the sequence, the code calls:

qcom_pas_probe()
  qcom_pas_assign_memory_region()
    qcom_scm_assign_mem()

If qcom_scm_assign_mem() is called unconditionally when region_assign_count=
 > 0,
it will attempt to use the __scm pointer to allocate TrustZone memory, which
might be NULL if the SCM driver isn't available.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626133440.6928=
49-1-sumit.garg@kernel.org?part=3D4
