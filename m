Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC424C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 17:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D8F10E0AA;
	Sat,  4 Jul 2026 17:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LJvqkoQ5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E023310E0AA
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 17:54:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 67A9D413F3;
 Sat,  4 Jul 2026 17:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F31A1F000E9;
 Sat,  4 Jul 2026 17:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783187679;
 bh=TTCEcJbsnW1OHFIrYYO1zur5oJD73kSga1ofZlJEFxM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LJvqkoQ5L63J0A7YBACoKFgEywWEuU69T5WxTAVK1j0L/copEiAR8/88ImBzN+8k8
 T8oH370G3fasW0fgh+bkfIRDQCy/Q8z4j8U3KMr1MS/x6p5e/oNZGhv5Qv4JijOcWr
 asYF36LHz2eLknEonoNNAX+6qMPdWiuiZ3MaQOEAzQB5FpI+ORQJ3vb8BJ3ZbDFAIT
 M9UKFVzMPAjG0SbtFYCCfkpD2Vz/8yLeFfXZgiLOkfI1Ox4VazRF9podD1RnbtrWVh
 ZT3ZSxf9myCr1hOYefFnEdJT0Q4pbnObkxbJ+fETHKA/1sbWto1RbdFVyPxtz1Ffj2
 nCLita2/uqqWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260704174113.255485-1-lgs201920130244@gmail.com>
References: <20260704174113.255485-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 17:54:38 +0000
Message-Id: <20260704175439.1F31A1F000E9@smtp.kernel.org>
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

New issues:
- [Low] Empty remove callback left in the driver.

Pre-existing issues:
- [High] Missing module reference pinning for I2C adapter leads to invalid =
text execution on module unload.
--

commit 7124bfd2ca52b03e9596ef39d9090b280144457a
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2

This commit removes an extra i2c_put_adapter() call from the HDMI v2 remove
callback. It relies on the common devm action to release the adapter device
reference, fixing a double put issue.

> mtk_hdmi_common_probe() gets the DDC adapter with
> of_find_i2c_adapter_by_node() and registers a devm action to release the
> adapter device reference with put_device().

[Severity: High]
This isn't a bug introduced by this patch, but does this missing module
reference pinning for the I2C adapter lead to an invalid text execution
on module unload?

If the I2C adapter driver module is unloaded, the module's .text section
is freed because the mtk_hdmi driver only holds a device reference (via
of_find_i2c_adapter_by_node()) and not a module reference.

If an EDID read is triggered after the I2C adapter module is unloaded,
drm_edid_read_ddc() calls i2c_transfer(), which dereferences the stale
hdmi->ddc_adpt->algo->master_xfer pointer, causing a kernel panic.

Should the driver use of_get_i2c_adapter_by_node() and pair it with
i2c_put_adapter() in the devm action instead?

> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/med=
iatek/mtk_hdmi_v2.c
> index d9316d30fd5f7..ce6cb952dc683 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
[ ... ]
>  static void mtk_hdmi_v2_remove(struct platform_device *pdev)
>  {
> -	struct mtk_hdmi *hdmi =3D platform_get_drvdata(pdev);
> -
> -	i2c_put_adapter(hdmi->ddc_adpt);
>  }

[Severity: Low]
Does this leave an unnecessary empty remove callback in the driver?

Since the only statement from mtk_hdmi_v2_remove() is being removed,
could this empty function and its assignment in the platform driver
struct be removed entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704174113.2554=
85-1-lgs201920130244@gmail.com?part=3D1
