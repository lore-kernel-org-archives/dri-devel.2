Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87E0CD6E55
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17CDC10E64C;
	Sat,  6 Jun 2026 05:17:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lhr3NnSz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2ED10E64C
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 05:17:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DBD794038A;
 Sat,  6 Jun 2026 05:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F021F00893;
 Sat,  6 Jun 2026 05:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780723021;
 bh=Z+vUT6ASl/W9wavZsQkTnSdOSYy2iux4uoddAcnjSLQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Lhr3NnSzDZWEgupsHqErKRsoj06dqcSRM8Ww2K/3tWesyelVqxQ+TRAt+A1UvdRJq
 mF8V9Whl5zdOiVdMD9P1ylfuARkdAyAEVOFpZuo7zn8uDoQbSF9tmyDU7LddGBDv1h
 qlgxiGDddgmibk5o3VI1SAQ7SpCwK4oDDaem0Bbt5mtRJ/Mn3A5zvTGAAjjB7lFCMT
 pnVuXWISpOWNI8r/rIpZ8OpoMXRVUSZmQ/PkjSBfndUBIeLscrEFH/apR2/Vx01yzY
 lKcdpgqCUVH2blT+PPfRWqhhO1cGgh2RghozsHj2/N6uC2EZ2pkZel3y9y25Yfq50X
 OtcgrMkJqTohg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/14] video: backlight: lm3533_bl: Implement
 backlight_scale property
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260606045738.21050-14-clamor95@gmail.com>
References: <20260606045738.21050-14-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 05:17:00 +0000
Message-Id: <20260606051701.51F021F00893@smtp.kernel.org>
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
- [High] Sysfs show functions `show_linear` and `show_als_en` incorrectly t=
reat a set hardware bit as an error, leaking uninitialized kernel memory to=
 userspace.
--

commit 5b473ee9a07b0b9fd223194515f44e1ffe1b934d
Author: Svyatoslav Ryhel <clamor95@gmail.com>

video: backlight: lm3533_bl: Implement backlight_scale property

Since the device supports linear and non-linear modes, implement the
backlight_scale property to describe this state.

> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backligh=
t/lm3533_bl.c
> index 4f8cde9f290d0..2aa4b86042ff2 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -142,6 +142,7 @@ static ssize_t store_linear(struct device *dev, struc=
t device_attribute *attr,
>  {
>  	struct lm3533_bl *bl =3D dev_get_drvdata(dev);
>  	int ctrlbank =3D lm3533_bl_get_ctrlbank_id(bl);
> +	struct backlight_device *bd =3D bl->bd;
>  	unsigned long linear;
>  	int ret;
> =20
> @@ -153,6 +154,9 @@ static ssize_t store_linear(struct device *dev, struc=
t device_attribute *attr,
>  	if (ret)
>  		return ret;
> =20
> +	bd->props.scale =3D linear ? BACKLIGHT_SCALE_LINEAR :
> +				   BACKLIGHT_SCALE_NON_LINEAR;
> +
>  	return len;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but looking at the adjacent
show_linear() and show_als_en() functions:

drivers/video/backlight/lm3533_bl.c:show_linear() {
    ...
	ret =3D regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
			       CTRLBANK_AB_BCONF_MODE(ctrlbank));
	if (ret)
		return ret;
    ...
}

If the hardware bit is set, regmap_test_bits() returns 1. Since the check is
if (ret), it immediately returns 1 to the sysfs core without calling
scnprintf() to populate the buffer.

Does this cause the sysfs core to interpret this as one byte successfully
written and copy the first byte of the unwritten buffer to userspace, leaki=
ng
potentially uninitialized kernel memory?

Should the check instead be `if (ret < 0)`?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606045738.2105=
0-1-clamor95@gmail.com?part=3D13
