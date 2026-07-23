Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDA4C531CF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14BE10F114;
	Thu, 23 Jul 2026 13:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UM0lpC/e";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5AD610F112
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 13:27:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E7B7429EA;
 Thu, 23 Jul 2026 13:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD461F000E9;
 Thu, 23 Jul 2026 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784813245;
 bh=uXcAuDSzcoX5kjG13BU6vcAGl2fR4wrvy7AqBNHYWzY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UM0lpC/ebYdbnitj3kFOCxykEBqBXX6nlrp+GwPJp4WczR/S0x5xEsyqD1Isw/Gax
 hwTCYYGT5lXHD8vsUtwZfDlsyLxBNLo1eVik/9xRUW6i6nIy2WDsBRWCdISF1og/T/
 wXpZzEO2qyY7LeKW13+COTzR45Ei/RclDPRcVBWIlpUabKyu24doJLemRXC0Qv4TSM
 k/+KNdI3vns5ur+8zqNc5ci/bV0QqX5ISwl89wX9Saz8/IvklDdbW52+uPrs+wByR/
 K8u5ioS/SN6zC+efSGpkB8MxSBDo+NOxI5j4PC3LwK17ysbjdNw6aQBaj25V1C7N4E
 g3VziOlLVTmVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] drm/bridge: lt9611: Remove redundant dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723131649.134127-4-panchuang@vivo.com>
References: <20260723131649.134127-1-panchuang@vivo.com>
 <20260723131649.134127-4-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 13:27:13 +0000
Message-Id: <20260723132725.2DD461F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Devm-managed IRQ can fire while regulators are disabled during pro=
be error path, causing an interrupt storm.
--

--- Patch [3]: [PATCH 03/10] drm/bridge: lt9611: Remove redundant dev_err()=
 ---
commit 31b83af0309fdf55db58f4bc292c02026a269afc
Author: Pan Chuang <panchuang@vivo.com>

drm/bridge: lt9611: Remove redundant dev_err()

This commit removes a redundant dev_err() message on failure to request
the devm-managed IRQ, as the core already logs detailed error messages
on failure.

> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/br=
idge/lontium-lt9611.c
> index b6a368f712853..05950cbc0a90f 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
[ ... ]
> @@ -1156,10 +1156,8 @@ static int lt9611_probe(struct i2c_client *client)
>  	ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
>  					lt9611_irq_thread_handler,
>  					IRQF_ONESHOT, "lt9611", lt9611);
> -	if (ret) {
> -		dev_err(dev, "failed to request irq\n");
> +	if (ret)
>  		goto err_disable_regulators;

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
interrupt storm in the error handling path for this IRQ request.

If a subsequent initialization step fails (for example, if
lt9611_attach_dsi() returns -EPROBE_DEFER), the probe function jumps to
err_disable_regulators:

err_disable_regulators:
        regulator_bulk_disable(ARRAY_SIZE(lt9611->supplies),
                               lt9611->supplies);

Because the IRQ is managed by devres (devm_request_threaded_irq()), it
remains active until the probe function returns and the devres cleanup
runs.

If the IRQ fires during this window while the regulators are disabled,
lt9611_irq_thread_handler() will attempt to communicate with the unpowered
device via I2C to read and clear the interrupt flag:

lt9611_irq_thread_handler() {
        ...
        regmap_read(lt9611->regmap, 0x820f, &irq_flag3);
        ...
}

Since the device is unpowered, the read will fail, the interrupt will not
be cleared in hardware, and the handler will still return IRQ_HANDLED.

Will this cause the interrupt controller to immediately re-trigger the
handler, leading to a soft or hard CPU lockup?

While lt9611_remove() correctly calls disable_irq() before disabling
regulators, is a similar disable_irq() call needed in this probe error
path before regulator_bulk_disable()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723131649.1341=
27-1-panchuang@vivo.com?part=3D3
