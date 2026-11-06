Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B0606A32D
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Baf3HT0E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF3B10E36B;
	Fri,  6 Nov 2026 09:28:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E7C10E36B
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:28:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC0E860621;
 Fri,  6 Nov 2026 09:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1F61F008A4;
 Fri,  6 Nov 2026 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793957301;
 bh=J5ommp0udEAye7SJoJfI7ofpdDIV9msIw502l4dpgGE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Baf3HT0EECO1wI0qJ5GCSWHWN0TSvcrYA24z1jRuUuhN6hup7rS/QbzHxJPQHTskL
 AwWN3BiZx53mMHsJAAOat6JELngrIdoQLGG+TZuKZqysYoaHE7D7j8SPDrAKN3KmIM
 ssGg3C6wshkgAraWB1InpfQH0ZQwZIhzcJMutDwrv3K8wmPMZMDhBsslopbVktDZz3
 TVB1AOm56jg0bQMrQjXMEX0q42CUlYuwOtL6GLZqyUnEFPKhRUqFVsm2z7Tj6h04e2
 v645zfLAGMopAVCFOv2W1kN8LBTJFCAHKkxj0rXEgDTaOw9/UbiyAjfUoeRVxlcCBo
 z7/iv0KCtrn5g==
Message-ID: <sashiko-outbox-201107@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: Fix firmware reference leak in vc4_hvs_bind()
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106092016.2282805-1-vulab@iscas.ac.cn>
References: <5f80ac77-c1f4-42cc-bdcd-e4222f72d853@igalia.com>
 <20261106092016.2282805-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:28:20 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/vc4: resource leak and NULL pointer dereference in
  vc4_hvs_bind() [1]
--

commit 17330184776a3fb8ffab5b0b09aa15bba8f8bd33
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/vc4: Fix firmware reference leak in vc4_hvs_bind()

This commit moves the rpi_firmware_find_node() and rpi_firmware_get()
calls in vc4_hvs_bind() below the devm_clk_get() lookups so the firmware
reference is not leaked when clock acquisition fails.

> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index b1fb096858ccc..537aaa9921293 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -1677,15 +1677,6 @@ static int vc4_hvs_bind(struct device *dev, struct=
 device *master, void *data)
>  		struct device_node *node;
>  		unsigned int max_rate;
> =20
> -		node =3D rpi_firmware_find_node();
> -		if (!node)
> -			return -EINVAL;
> -
> -		firmware =3D rpi_firmware_get(node);
> -		of_node_put(node);
> -		if (!firmware)
> -			return -EPROBE_DEFER;
> -
>  		hvs->core_clk =3D devm_clk_get(&pdev->dev,
>  					     (vc4->gen >=3D VC4_GEN_6_C) ? "core" : NULL);
>  		if (IS_ERR(hvs->core_clk)) {
> @@ -1700,6 +1691,15 @@ static int vc4_hvs_bind(struct device *dev, struct=
 device *master, void *data)
>  			return PTR_ERR(hvs->disp_clk);
>  		}
> =20
> +		node =3D rpi_firmware_find_node();
> +		if (!node)
> +			return -EINVAL;
> +
> +		firmware =3D rpi_firmware_get(node);
> +		of_node_put(node);
> +		if (!firmware)
> +			return -EPROBE_DEFER;
> +
>  		max_rate =3D rpi_firmware_clk_get_max_rate(firmware,
>  							 RPI_FIRMWARE_CORE_CLK_ID);
>  		rpi_firmware_put(firmware);

[Severity: High]
This problem wasn't introduced by this patch, but can vc4_hvs_irq_handler()
dereference a NULL vc4->hvs pointer after component unbind [1]?

vc4_hvs_bind() allocates hvs and registers vc4_hvs_irq_handler() with
devm_kzalloc() and devm_request_irq() tied to the component platform
device rather than the aggregate DRM lifetime.  When the component
unbinds (for example on aggregate probe deferral), vc4_hvs_unbind() sets
vc4->hvs to NULL while the devres-managed IRQ handler remains registered:

drivers/gpu/drm/vc4/vc4_hvs.c:vc4_hvs_irq_handler() {
	...
	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
	...
	status =3D HVS_READ(SCALER_DISPSTAT);
	...
}

If an interrupt fires after unbind, HVS_READ() dereferences
vc4->hvs->regs, causing a NULL pointer dereference, and a subsequent
re-bind leaks devres allocations and fails in devm_request_irq() with
-EBUSY.

[1] https://sashiko.dev/#/bug/linux-4ad12be9-d1a5-441d-9845-195d42c3f880

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106092016.2282=
805-1-vulab@iscas.ac.cn?part=3D1
