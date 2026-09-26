Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9045C98338
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E7A10E2AB;
	Sat, 26 Sep 2026 15:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MPxq46lK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4329710E19A
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 15:59:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B4ED43751;
 Sat, 26 Sep 2026 15:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FDD1F000FF;
 Sat, 26 Sep 2026 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790438376;
 bh=XYQJa2E3cJQmnwaeOV96VoLUSycnxX9pOu9PV3S3f2k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MPxq46lKoqcC0WNjF4+sMnDORXPr9mnGsDXclRGKoKU0AfmwjbLHvw/FuhQ6s01Cd
 DQuUwljp30ttdxgd6nBaQo2a2/AnbBnX4uM9swY8os/rCWXaVQxqCX/AFQuhYoPjtq
 K3R/9NvCula8Lzto2XEGnZGbcbXFkv9DSI7ucWYlyDl+VFODjzKS11gEbAaKgnvgNq
 zCOOtJlt4MHLmQTbZ8XSn6R9a/BCp/1bi6Dlha/Ws6GNzuSduhR6Wh1HEHZYMMVriH
 3f7sP7C3rZUUpky0tFkdBAK5Xx+GBK5ix3hWFZ73Jw5tj5v6t/n9CtIR0KaabyjlZ4
 Qvo+PFNQau2Jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] media: iris: migrate firmware loading to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
To: "Mukesh Ojha" <mukesh.ojha@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260925155737.4161358-4-mukesh.ojha@oss.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <20260925155737.4161358-4-mukesh.ojha@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 15:59:35 +0000
Message-Id: <20260926155935.D7FDD1F000FF@smtp.kernel.org>
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
- [High] firmware: qcom: pas: missing qcom_pas_metadata_release() leaks TZ/=
DMA memory
- [Medium] devres: memory leak due to repeated devm_qcom_pas_context_alloc(=
) on fw reload
--

commit bb3acb8beaa539b1cfa0975914c1f8fd75747e36
Author: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

media: iris: migrate firmware loading to qcom_mdt_pas_load() and qcom_pas_p=
repare_and_auth_reset()

iris_load_fw_to_memory() calls qcom_mdt_load() which bundles metadata
init, memory setup, and segment loading with no PAS context, and
iris_fw_load() calls qcom_pas_auth_and_reset() which skips the shmbridge
prepare step required before TrustZone authentication.

> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/m=
edia/platform/qcom/iris/iris_firmware.c
> index 21cdf1c398357..e73a5dd98b88c 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
[ ... ]
> @@ -134,21 +131,20 @@ static int iris_load_fw_to_memory(struct iris_core =
*core)
>  	core->iris_firmware_data =3D core->iris_firmware_desc->firmware_data;
> =20
>  	fw_size =3D qcom_mdt_get_size(firmware);
> -	if (fw_size < 0 || res_size < (size_t)fw_size) {
> +	if (fw_size < 0 || resource_size(&res) < (size_t)fw_size) {
>  		ret =3D -EINVAL;
>  		goto err_release_fw;
>  	}
> =20
> -	mem_virt =3D memremap(mem_phys, res_size, MEMREMAP_WC);
> -	if (!mem_virt) {
> -		ret =3D -ENOMEM;
> +	core->pas_ctx =3D devm_qcom_pas_context_alloc(dev, IRIS_PAS_ID, mem_phy=
s,
> +						    resource_size(&res));

[Severity: Medium]
Will this leak device-managed memory when firmware is reloaded?

If the hardware system error recovery path is triggered (for example,
iris_sys_error_handler() calls iris_core_deinit() followed by
iris_core_init() and iris_fw_load()), devm_qcom_pas_context_alloc() is call=
ed
again unconditionally. This overwrites core->pas_ctx without freeing the old
devres allocation.

> +	if (IS_ERR(core->pas_ctx)) {
> +		ret =3D PTR_ERR(core->pas_ctx);
> +		core->pas_ctx =3D NULL;
>  		goto err_release_fw;
>  	}
> =20
> -	ret =3D qcom_mdt_load(dev, firmware, fw_name,
> -			    IRIS_PAS_ID, mem_virt, mem_phys, res_size, NULL);
> -
> -	memunmap(mem_virt);
> +	ret =3D qcom_mdt_pas_load(core->pas_ctx, firmware, fw_name, NULL);

[Severity: High]
Does this sequence leak DMA or TrustZone memory buffers allocated for firmw=
are
metadata?

When qcom_mdt_pas_load() is called, the underlying PAS subsystem allocates a
DMA buffer for the metadata and stores it in the PAS context. The PAS API
contract dictates that callers must subsequently call
qcom_pas_metadata_release(core->pas_ctx) to free this memory.

Looking at iris_fw_load(), this step appears to be completely omitted on bo=
th
success and error paths before the function returns. Because the DMA
allocation is tied to the SCM device (not devres-managed for the iris
driver), repeated firmware loads due to probe/unbind cycles or hardware
errors could permanently exhaust restricted DMA or secure memory pools.

>  err_release_fw:
>  	release_firmware(firmware);
> =20
> @@ -166,7 +162,7 @@ int iris_fw_load(struct iris_core *core)
>  		return ret;
>  	}
> =20
> -	ret =3D qcom_pas_auth_and_reset(IRIS_PAS_ID);
> +	ret =3D qcom_pas_prepare_and_auth_reset(core->pas_ctx);
>  	if (ret)  {
>  		dev_err(core->dev, "auth and reset failed: %d\n", ret);
>  		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925155737.4161=
358-1-mukesh.ojha@oss.qualcomm.com?part=3D3
