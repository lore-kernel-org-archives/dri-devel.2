Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21075CD6E75
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 716B2112D2B;
	Sat,  6 Jun 2026 05:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V1be7EkD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DABD112D2B
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 05:16:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 13F11600BB;
 Sat,  6 Jun 2026 05:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863691F00893;
 Sat,  6 Jun 2026 05:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780722975;
 bh=Wb86LIcW+yhIiS+7sG8Qz8KjwaGsiHYLAC4YUvLIZMU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V1be7EkDRyMKntKdr8vZgEj84Dk5Y3Ontbmj43lmnP+LMpeQ1t6AD8I2meaJa55G/
 oqjNgBuCyxiPHJJp+5I25qk+Xp48EP4XgnfskVR+gX+K3k2KgLMz6YjpSBQZxYLA6U
 LBfqqN8WtTuQ35SsINTWoeohpYWtAZdkY2R5uDZZ+Jk24JMy56tC9CEl83ALJxP9uu
 zy8Gq25Tv0+d8CFdufKl9Jbo8fH96s1cJ2n2U/DpE2+Kz0Hu1pEMlnCwfFPx5LLHQo
 uDT0uEqyz5H+Z4g5K1x2kATJ/2FE7AzS0eEzNUkTOyqmLtbUMpR92j9dXoT6B6rgRZ
 abMCa7vXIvqKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/14] video: backlight: lm3533_bl: Set initial
 mapping mode from DT
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260606045738.21050-13-clamor95@gmail.com>
References: <20260606045738.21050-13-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 05:16:15 +0000
Message-Id: <20260606051615.863691F00893@smtp.kernel.org>
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
- [High] Sysfs show functions `show_linear` and `show_als_en` incorrectly h=
andle the boolean return value of `regmap_test_bits()`, causing them to ret=
urn early without formatting output when the bit is set.
--

commit be155a9e9c191a4d2a13bb2df4a54c1332803f87
Author: Svyatoslav Ryhel <clamor95@gmail.com>

video: backlight: lm3533_bl: Set initial mapping mode from DT
   =20
Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured.

> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backligh=
t/lm3533_bl.c
> index 9ad7ea1bbbccb..4f8cde9f290d0 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c

[ ... ]

I noticed a regression in show_linear() and show_als_en() (modified by the
patch 'video: backlight: lm3533_bl: Improve logic of sysfs functions' in
this series) where regmap_test_bits() is called to check if a specific
bit is set:

drivers/video/backlight/lm3533_bl.c:show_als_en() {
	...
	ret =3D regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
			       CTRLBANK_AB_BCONF_ALS(ctrlbank));
	if (ret)
		return ret;

	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
}

[Severity: High]
Does this code handle the boolean return value of regmap_test_bits()
correctly?

Since regmap_test_bits() returns 1 if the bit is set, this error check
triggers when the bit is set and returns 1 directly instead of formatting
the string.

Returning 1 from a sysfs show function signals to the sysfs core that 1 byte
was written to the buffer. Because the sysfs buffer is zero-initialized pri=
or
to the call, doesn't this return a null byte (\0) to userspace instead of t=
he
expected string "1\n"?

The same pattern appears in show_linear():

drivers/video/backlight/lm3533_bl.c:show_linear() {
	...
	ret =3D regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
			       CTRLBANK_AB_BCONF_MODE(ctrlbank));
	if (ret)
		return ret;

	return scnprintf(buf, PAGE_SIZE, "%x\n", ret);
}

[Severity: High]
Will this also fail to format the output string and return a null byte to
userspace when the feature is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606045738.2105=
0-1-clamor95@gmail.com?part=3D12
