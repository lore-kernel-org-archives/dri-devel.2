Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7E5C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3DAA10F7DC;
	Fri,  3 Jul 2026 12:02:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NtlJVJ/d";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC7110E5D2
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A62C66001A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0901F000E9;
 Fri,  3 Jul 2026 12:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783080165;
 bh=QbLUGBS95aP0k92mAqYDrzKiUj+NhDylLq6C1ijqZr4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NtlJVJ/dStjGNun3lBk8xkMxjFF4VIV6lrE8k70HxSIFSYwh/pULiIBkaXQCYEZtl
 AQU+lIWw/bzRWmonQdX2skejmvSa64LnHBEHC0WfbafbIfy1M9uxxnZzRKcDz9XwGR
 0qAbMpPk7pb+dRz6gD9fkS08Sm1+AmUpmkYnNqKNptkrnFBRf9HsF/jRFsnbjNzBK0
 1/TteWMhgDac224XF7nnrqsZQWluJxyDo/6HZHxf8x6OQH7x3RE/S6NnrWNPRAxh1h
 qrAXujFBumfJCVHuEoyo8vj6aYS1mJVCG6wzfSSNq6BPdAeoPCnNxwwwEH6QDNcTts
 t/Ul4A8r6MO1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/14] remoteproc: qcom_q6v5_pas: Switch over to
 generic PAS TZ APIs
To: "Sumit Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260702115835.167602-5-sumit.garg@kernel.org>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-5-sumit.garg@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 12:02:44 +0000
Message-Id: <20260703120245.2B0901F000E9@smtp.kernel.org>
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
- [High] Unconditional call to SCM-specific qcom_scm_assign_mem() causes NU=
LL pointer dereference with non-SCM backends.
- [High] Missing module reference counting in the generic PAS API introduce=
s a Use-After-Free and race condition.

Pre-existing issues:
- [High] Asynchronous pm_runtime_put() is canceled during device removal, l=
eaving hardware powered on.
- [High] The DTB firmware buffer is leaked on the successful boot path.
- [High] The DTB PAS backend authentication session is not shut down if sta=
rting the main image fails.
--

commit 5fe417b2557886cf59a2b2dcdc429ef1c4165522
Author: Sumit Garg <sumit.garg@oss.qualcomm.com>

remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
   =20
Switch qcom_q6v5_pas client driver over to generic PAS TZ APIs. Generic PAS
TZ service allows to support multiple TZ implementation backends like QTEE
based SCM PAS service, OP-TEE based PAS service and any further future TZ
backend service.

Since qcom_q6v5_pas depends on MDT loader for PAS firmware loading, it
has to be switched over to generic PAS APIs in this commit to avoid any
build issues.

> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom=
_q6v5_pas.c
> index 808e9609988d3..9eb1c4f6c2ab4 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c

[ ... ]

> @@ -247,7 +248,7 @@ static int qcom_pas_load(struct rproc *rproc, const s=
truct firmware *fw)
>  	return 0;
> =20

[Severity: High]
This is a pre-existing issue, but does this leak the dtb_firmware buffer
on the successful boot path?

If the loading process succeeds, the function returns 0 without releasing
the buffer allocated earlier by request_firmware(). Since the remoteproc
core only automatically frees the main firmware buffer, wouldn't the
auxiliary dtb_firmware buffer be left allocated every time the remote
processor boots?

>  release_dtb_metadata:
> -	qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +	qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  	release_firmware(pas->dtb_firmware);
> =20
>  	return ret;

[ ... ]

> @@ -352,9 +353,9 @@ static int qcom_pas_start(struct rproc *rproc)
>  unmap_carveout:
>  	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
>  release_pas_metadata:
> -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> +	qcom_pas_metadata_release(pas->pas_ctx);
>  	if (pas->dtb_pas_id)
> -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
> =20
>  unmap_dtb_carveout:
>  	if (pas->dtb_pas_id)

[Severity: High]
This is a pre-existing issue, but does the error rollback path miss shutting
down the DTB PAS backend?

If a subsequent step in qcom_pas_start() fails after the DTB image is
mapped and authenticated, the error path jumps to release_pas_metadata and
unmap_dtb_carveout.

However, it doesn't appear to invoke qcom_pas_shutdown() for the dtb_pas_id.
Could this leave the DTB backend authentication session active and prevent
the subsystem from loading again until the device reboots?

[ ... ]

> @@ -403,7 +404,7 @@ static int qcom_pas_stop(struct rproc *rproc)
>  	if (ret =3D=3D -ETIMEDOUT)
>  		dev_err(pas->dev, "timed out on wait\n");
> =20
> -	ret =3D qcom_scm_pas_shutdown(pas->pas_id);
> +	ret =3D qcom_pas_shutdown(pas->pas_id);

[Severity: High]
Could this lead to memory corruption if the backend module is unloaded?

With the switch to the generic PAS API, struct qcom_pas_ops lacks an owner
field, and the wrapper functions don't take a reference to the backend
module using try_module_get().

If the backend is unloaded concurrently, the global ops_ptr would be
cleared, causing qcom_pas_shutdown() to return -ENODEV instead of shutting
down the hardware.

Wouldn't the remote processor continue executing while its carveout memory
is unmapped and freed by Linux?

>  	if (ret && pas->decrypt_shutdown)
>  		ret =3D qcom_pas_shutdown_poll_decrypt(pas);
> =20
>  	if (ret)

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

[Severity: High]
Can this cause a NULL pointer dereference with non-SCM backends?

By broadening the check to qcom_pas_is_available(), probe can proceed when
backed by non-SCM services like OP-TEE. However, further down in the probe
sequence, qcom_pas_assign_memory_region() unconditionally calls the
SCM-specific qcom_scm_assign_mem() (if region_assign_idx is present).

If qcom_scm did not probe, the internal pointer inside
qcom_scm_assign_mem() would be NULL, leading to a kernel panic when
dereferenced.

>  	fw_name =3D desc->firmware_name;
>  	ret =3D of_property_read_string(pdev->dev.of_node, "firmware-name",

[ ... ]

> @@ -835,16 +836,16 @@ static int qcom_pas_probe(struct platform_device *p=
dev)
> =20
>  	qcom_add_ssr_subdev(rproc, &pas->ssr_subdev, desc->ssr_name);
> =20
> -	pas->pas_ctx =3D devm_qcom_scm_pas_context_alloc(pas->dev, pas->pas_id,
> -						       pas->mem_phys, pas->mem_size);
> +	pas->pas_ctx =3D devm_qcom_pas_context_alloc(pas->dev, pas->pas_id,
> +						   pas->mem_phys, pas->mem_size);
>  	if (IS_ERR(pas->pas_ctx)) {
>  		ret =3D PTR_ERR(pas->pas_ctx);
>  		goto remove_ssr_sysmon;
>  	}
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does the device teardown path
cancel pending asynchronous suspends?

If probe fails and jumps to the teardown labels, qcom_pas_pds_disable()
is called, which drops the usage counter for power domains using the
asynchronous pm_runtime_put(). This is followed shortly by
pm_runtime_disable() in qcom_pas_pds_detach().

Since pm_runtime_disable() cancels pending asynchronous suspend work,
wouldn't this leave the hardware in an incorrect active power state?
Should the synchronous pm_runtime_put_sync() be used instead?

> -	pas->dtb_pas_ctx =3D devm_qcom_scm_pas_context_alloc(pas->dev, pas->dtb=
_pas_id,
> -							   pas->dtb_mem_phys,
> -							   pas->dtb_mem_size);
> +	pas->dtb_pas_ctx =3D devm_qcom_pas_context_alloc(pas->dev, pas->dtb_pas=
_id,
> +						       pas->dtb_mem_phys,
> +						       pas->dtb_mem_size);
>  	if (IS_ERR(pas->dtb_pas_ctx)) {
>  		ret =3D PTR_ERR(pas->dtb_pas_ctx);
>  		goto remove_ssr_sysmon;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702115835.1676=
02-1-sumit.garg@kernel.org?part=3D4
