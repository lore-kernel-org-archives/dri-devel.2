Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28145C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 23:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDC910E2C4;
	Sun, 20 Sep 2026 23:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YWGT2cfg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA8110E2C4
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 23:02:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 402194074E
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 23:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79471F000FF;
 Sun, 20 Sep 2026 23:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789945342;
 bh=KJuZJlPFVQ47PNxIUEMxDPt2XC76j36WVwiEcIYDtDI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YWGT2cfgEel34pBwAiN+wC4wNJYGULCJf63rlPev7HVPr/EZMoVFa38UFVgV79Iev
 pyEHCPU2ePgstVnqe/Lzmx2Xc3KzfIDCjlZEwFW35XWeMJa23Brw/rLFCkrAHiP8+3
 mSahodT4q22AxwM4cGIzW1CUhG+nBfslOiBmYt2x7ZFTtQjyzSZMLdLA9Hdy7GUZcY
 i71F1ULO5m4/Al12DY9LzNX0t1PsGTlqxtmfwj2204nVEMC6UtP/1BhSvzU5+GvEWz
 g2HUnz/9h2XvpRD9WWbzU++fQtdzCK32SEdpH+cP/ji8Jub9zJ8lYPiZv+FFvyNV2y
 0EG6FTaHDI9kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/18] misc: sram: Enable runtime PM
To: "Linus Walleij" <linusw@kernel.org>
Cc: dmaengine@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, vkoul@kernel.org,
 conor+dt@kernel.org
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-14-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-14-9352be6b86b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 23:02:21 +0000
Message-Id: <20260920230221.A79471F000FF@smtp.kernel.org>
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
- [High] misc: sram: Missing pm_runtime_get_sync() in sysfs read/write paths
- [Medium] misc: sram: Hardware initialization is not restored after runtim=
e resume
--

commit b2dc9fd44cd639efd34dbecb064c4f1f3097e1eb
Author: Linus Walleij <linusw@kernel.org>

    misc: sram: Enable runtime PM
   =20
    Enable runtime PM for generic SRAM devices after probe has initialized
    the SRAM mappings and partitions.
   =20
    This lets SRAM devices with attached power domains be managed through
    runtime PM references from their consumers.

> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> index c8990e83a65a2..7f19dca7b818e 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c

[ ... ]

> @@ -425,6 +426,10 @@ static int sram_probe(struct platform_device *pdev)
>  			goto err_free_partitions;
>  	}
> =20
> +	ret =3D devm_pm_runtime_set_active_enabled(&pdev->dev);

[Severity: High]
Does this code allow sysfs read/write paths to access unpowered MMIO hardwa=
re?

Since runtime PM is now enabled, the SRAM device can be suspended by its
attached power domain. If userspace accesses the exported sysfs bin
attributes, sram_read() and sram_write() perform MMIO accesses without
waking the device:

drivers/misc/sram.c:sram_read() {
	...
	mutex_lock(&part->lock);
	memcpy_fromio(buf, part->base + pos, count);
	mutex_unlock(&part->lock);
	...
}

Will this cause an asynchronous external abort and crash the system if the
hardware is accessed while suspended?

[Severity: Medium]
Will hardware state be lost and not restored on resume?

Earlier in sram_probe(), hardware initialization is performed:

drivers/misc/sram.c:sram_probe() {
	...
	if (config && config->init) {
		ret =3D config->init();
	...
}

If the device is attached to a PM domain that powers it down, waking it up
will turn on the power but will not re-apply the config->init() callback
(such as atmel_securam_wait) because the driver lacks a runtime_resume
callback.

Can this lead to hardware faults or data corruption if the RAM is accessed
before it is ready?

> +	if (ret)
> +		goto err_free_partitions;
> +
>  	if (sram->pool)
>  		dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
>  			gen_pool_size(sram->pool) / 1024, sram->virt_base);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-ux500-powe=
r-domains-v7-1-v3-0-9352be6b86b1@kernel.org?part=3D14
