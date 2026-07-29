Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B092C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 05:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A129810E9C5;
	Wed, 29 Jul 2026 05:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kl1tAJyR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D18B10E9C5
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:41:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 987EB60A5E;
 Wed, 29 Jul 2026 05:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C271F000E9;
 Wed, 29 Jul 2026 05:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785303706;
 bh=+9feoyrHz6tl7F7DK9YjlyRKk10f+atcIu5+cdCEkKc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kl1tAJyR2DGvwERP/xcXYfYGaDcxXwKwHCU1u7hR/x/wH3dg60EiP97eWYyzrk7S+
 LFGWx4C8ZUEYPnXf0baF/13f3Vh/ZhaexGWYl4tFV6CS79xsqM4jh9HIZq46cXeU6A
 qxZjJI3kg13NBx6REVGK+KKOEKloraPRwFlQtH5ASHiS7klV6ad1X8FrOSmB7RSSRC
 wJTHXrlybRiqTXF8VSKAx3rnFRW1hRcm5SeboQUKiyWGHgZCMez5PnUzwjo+8KzgmG
 SzX2H64jcLyCIO+vtN9PvQxsxotA6sIu2RJPsuWs8RYeumHiU2VymR7fCd+uRnQS2L
 OUpanmU92XjrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/ssd130x: Scale ssd133x per-channel contrast by
 brightness on init
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729053054.29374-2-amit.barzilai22@gmail.com>
References: <20260729053054.29374-1-amit.barzilai22@gmail.com>
 <20260729053054.29374-2-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 05:41:45 +0000
Message-Id: <20260729054146.23C271F000E9@smtp.kernel.org>
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
- [High] The generic backlight update function corrupts the white balance o=
n ssd133x panels by only updating contrast channel A.
--

--- Patch [1]: [PATCH 1/2] drm/ssd130x: Scale ssd133x per-channel contrast =
by brightness on init ---
commit 2b92cd2c08daa2f9c52218a1668057ae50f9c448
Author: Amit Barzilai <amit.barzilai22@gmail.com>

drm/ssd130x: Scale ssd133x per-channel contrast by brightness on init
   =20
This patch extracts the SSD133X A/B/C channel contrast calibration into
ssd133x_set_contrast() which scales each channel by the requested brightnes=
s.

> Extract them into ssd133x_set_contrast(), which scales each channel by a
> requested brightness via ssd130x_scale_contrast(), instead of writing the
> calibration unconditionally.  This makes the sequence readable, avoids
> repetition, and is a prerequisite for wiring up an ssd133x backlight
> controller that dims while preserving the white point.

[Severity: High]
This isn't a bug introduced by this patch, but does the generic backlight
update function corrupt the white balance on ssd133x panels by only updating
contrast channel A?

The commit message notes this is a prerequisite for a proper ssd133x backli=
ght
controller, but currently ssd130x_probe() unconditionally registers the
generic backlight controller for all devices:

drivers/gpu/drm/solomon/ssd130x.c:ssd130x_probe() {
	...
	bl =3D devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
					    &ssd130xfb_bl_ops, NULL);
	...
}

When the backlight is enabled or updated via sysfs, ssd130x_update_bl()
blindly writes the unscaled brightness to 0x81 (SSD13XX_CONTRAST). On ssd13=
3x
panels, this maps to SSD133X_CONTRAST_A (Red):

drivers/gpu/drm/solomon/ssd130x.c:ssd130x_update_bl() {
	...
	ret =3D ssd130x_write_cmd(ssd130x, 1, SSD13XX_CONTRAST);
	if (ret < 0)
		return ret;

	ret =3D ssd130x_write_cmd(ssd130x, 1, ssd130x->contrast);
	...
}

This leaves channels B and C untouched at their initialization values,
destroying the white balance.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729053054.2937=
4-1-amit.barzilai22@gmail.com?part=3D1
