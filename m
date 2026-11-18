Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D3606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRGYCugk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E5D10E54D;
	Wed, 18 Nov 2026 23:46:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2D4310E54D
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:45:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16457642F7;
 Wed, 18 Nov 2026 23:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6EB1F000CA;
 Wed, 18 Nov 2026 23:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795045553;
 bh=525xpOc+MNjdMiMGdoDEn/uRURItOu5YR9dnZDJsb6U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VRGYCugkl3eRQ/CE1463FA7h8ABBQVvLbfwuMwkTLM0y1ecZsCqT1+DcseMx0JfcH
 UD13NxUr3T2JBBH1EvvPKXw/dI2Z5FrPFRcoLMhLwqLyFXZVmj3kLpVQq9FVvS3dv2
 OE5Xx14wXrZ84NMOdv3MuuX0lCO9l9O7yfqh0v+eZCVGh18+aIvu6J/YkALnCfg1lW
 VmnaWeuRcvBpYtwIJ3hgd8GW5c0kMzno2zXqUwHV1it9ppHEahVf/SM/iElDG2Xfok
 cYwG6/CzBYcZX+pBJySgQTYNmigO/rSogwq2HZyAsAbokEBUTLNYdfzvIBEOHRTjRc
 N8WfUVaMHQRGw==
Message-ID: <sashiko-outbox-222210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/15] accel/amd-ai-engine: Add AMD AI Engine device driver
To: "Gregory Williams" <gregory.williams@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118233211.4121361-13-gregory.williams@amd.com>
References: <20261118233211.4121361-1-gregory.williams@amd.com>
 <20261118233211.4121361-13-gregory.williams@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:45:53 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] accel/amd-ai-engine: memory leak and lifetime bug in
  aie_part_create()
- [Low] accel/amd-ai-engine: dead code, unused exports, and missing
  accel integration
--

commit 9d0271621aaf2e78655cf01aa521aa41dffc506a
Author: Gregory Williams <gregory.williams@amd.com>

accel/amd-ai-engine: Add AMD AI Engine device driver

This commit adds the initial AMD Versal AI Engine platform driver under
drivers/accel/amd-ai-engine, including device probing, column resource
tracking, and partition request and release APIs.

> diff --git a/drivers/accel/amd-ai-engine/Kconfig b/drivers/accel/amd-ai-e=
ngine/Kconfig
> new file mode 100644
> index 0000000000000..7f32928cb20f2
> --- /dev/null
> +++ b/drivers/accel/amd-ai-engine/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config DRM_ACCEL_AMDAIE
> +	tristate "AMD Versal AI Engine"
> +	depends on ARM64 || COMPILE_TEST
> +	depends on ZYNQMP_FIRMWARE
> +	depends on DRM_ACCEL
> +	help
> +	  This option enables support for the AMD AI engine driver.
> +	  One AMD AI engine device can have multiple partitions (groups of
> +	  AI engine tiles). AMD AI engine device driver instance manages
> +	  AI engine partitions. Applications access its partitions through
> +	  AI engine partition device instance.
> +
> +	  If unsure, say N.

[Severity: Low]
Why is this driver placed under drivers/accel/ with a dependency on
DRM_ACCEL when it does not register a drm_device with DRIVER_COMPUTE_ACCEL
or expose any userspace interface across the series?

Also, aie_partition_request() and aie_partition_release() in
ai-engine-dev.c are exported with EXPORT_SYMBOL_GPL() without any in-tree
callers in the series, and aie_resource_check_region() in ai-engine-res.c
is never called.

> diff --git a/drivers/accel/amd-ai-engine/ai-engine-part.c b/drivers/accel=
/amd-ai-engine/ai-engine-part.c
> new file mode 100644
> index 0000000000000..f80a6fa433aa1
> --- /dev/null
> +++ b/drivers/accel/amd-ai-engine/ai-engine-part.c

[ ... ]

> @@ -0,0 +1,77 @@

[ ... ]

> +void aie_part_release(struct aie_partition *apart)
> +{
> +	struct aie_device *adev =3D apart->adev;
> +
> +	list_del(&apart->node);
> +	aie_resource_put_region(&adev->cols_res,
> +				apart->range.start.col -
> +				adev->range.start.col,
> +				apart->range.size.col);
> +	device_unregister(&apart->dev);
> +}
> +
> +static void aie_part_release_device(struct device *dev)
> +{
> +	(void)dev;
> +}
> +
> +/**
> + * aie_part_create() - create AI engine partition instance
> + * @adev: AI engine device
> + * @start_col: start column of AI engine partition
> + * @num_col: number of columns of AI engine partition
> + *
> + * Return: created AI engine partition pointer for success, and PTR_ERR
> + *	   for failure.
> + */
> +struct aie_partition *aie_part_create(struct aie_device *adev,
> +				      u8 start_col, u8 num_col)
> +{
> +	struct aie_partition *apart;
> +	struct device *dev;
> +
> +	apart =3D devm_kzalloc(adev->dev, sizeof(*apart), GFP_KERNEL);
> +	if (!apart)
> +		return ERR_PTR(-ENOMEM);
> +
> +	apart->adev =3D adev;
> +	mutex_init(&apart->mlock);
> +	apart->range.start.col =3D start_col;
> +	apart->range.size.col =3D num_col;
> +	apart->range.start.row =3D adev->range.start.row;
> +	apart->range.size.row =3D adev->range.size.row;
> +
> +	/* create partition device */
> +	dev =3D &apart->dev;
> +	dev->parent =3D apart->adev->dev;
> +	dev_set_name(dev, "aiepart_%u_%u", apart->range.start.col,
> +		     apart->range.size.col);
> +	dev_set_drvdata(dev, apart);
> +	dev->release =3D aie_part_release_device;
> +
> +	if (device_register(&apart->dev)) {
> +		dev_err(adev->dev, "failed to register partition device\n");
> +		put_device(dev);
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	return apart;
> +}

[Severity: High]
Does allocating apart with devm_kzalloc(adev->dev, ...) and using a no-op
dev->release callback leak struct aie_partition across runtime partition
request and release cycles?

Every call to aie_partition_release() (as well as the device_register()
error path in aie_part_create()) drops the reference on apart->dev without
freeing apart, leaving it allocated on adev->dev's devres list until the
parent driver unbinds.  In addition, tying a structure that embeds a
reference-counted struct device to parent devres frees apart on parent
unbind even if external references to apart->dev are still held, causing a
use-after-free when the last reference is dropped.

Allocating apart with kzalloc() and freeing it with kfree() in
aie_part_release_device() would tie its lifetime to apart->dev;
aie_partition_release() in ai-engine-dev.c would then also need to save
apart->adev in a local variable before calling aie_part_release(apart) so
that mutex_unlock(&adev->mlock) does not dereference apart after
device_unregister(&apart->dev) frees it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118233211.4121=
361-1-gregory.williams@amd.com?part=3D12
