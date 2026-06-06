Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61B8CD6E75
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 05:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF460112D26;
	Sat,  6 Jun 2026 05:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U4Jsu2w7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D08112D26
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 05:12:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1AF1C600AE;
 Sat,  6 Jun 2026 05:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC861F00893;
 Sat,  6 Jun 2026 05:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780722746;
 bh=6bYQrmPqAxPat8JflIcElg4C3oQrSvT37xLjto40jzM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U4Jsu2w7bQvNYQcDWBps7oHnWdZV0lzTC/Y6Y/7x8Ss06MkTpJSEjvPMmWNQv4Yql
 uO4SlsouEMbQ3j7h8gNMZ7bnwIQb6IwVkb/hJt5SWTXSW/eO/Oh7u+2r4AUMwMrKOb
 /OBS3dcVSqa0Zzx6Kxpac1Iu4FVVmICqkutpw37A/gdndzJIcFI0ZldEu3mlko2SUE
 jPgGzkoSVAHh+xDY+nz1uzy/EvLVprZDDHtihf/thrB3uwZvIE5gvNCsM4Pxmmwep0
 pxOKd17TDI7AxL5pSYPKwb2heJ1BB2AZ7TSP50VKsqetgIbi30YP+BTEb1A1EBp7sT
 XHMOSs9AjiEig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/14] video: backlight: lm3533_bl: Improve logic of
 sysfs functions
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260606045738.21050-12-clamor95@gmail.com>
References: <20260606045738.21050-12-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 05:12:25 +0000
Message-Id: <20260606051226.4AC861F00893@smtp.kernel.org>
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
- [High] sysfs show functions `show_als_en` and `show_linear` return premat=
urely when the tested bits are set, breaking the sysfs read and returning a=
n empty/uninitialized buffer.
--

commit 549a7f316072e9f93bfcd3d182e73739a35c0c7a
Author: Svyatoslav Ryhel <clamor95@gmail.com>

video: backlight: lm3533_bl: Improve logic of sysfs functions

Simplify the sysfs logic of properties by switching to macros and proper
regmap helpers.

> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backligh=
t/lm3533_bl.c
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c

[ ... ]

> @@ -85,88 +87,68 @@ static ssize_t show_als_channel(struct device *dev,
>  	return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
>  }
> =20
> -static ssize_t show_als_en(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> +static ssize_t show_als_en(struct device *dev, struct device_attribute *=
attr,
> +			   char *buf)
>  {
>  	struct lm3533_bl *bl =3D dev_get_drvdata(dev);
>  	int ctrlbank =3D lm3533_bl_get_ctrlbank_id(bl);
> -	u32 val;
> -	u8 mask;
> -	bool enable;
>  	int ret;
> =20
> -	ret =3D regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
> +	ret =3D regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
> +			       CTRLBANK_AB_BCONF_ALS(ctrlbank));
>  	if (ret)
>  		return ret;

[Severity: High]
Does this error check prematurely exit the function when the bit is set?

regmap_test_bits() returns 1 if the specified bit is set. If the bit is set=
,=20
the if (ret) condition evaluates to true, causing the function to return 1
immediately instead of formatting the buffer.

This could break the sysfs API contract and return a single null byte to
userspace instead of the expected string. Should this check be if (ret < 0)
instead?

> =20
> -	mask =3D 1 << (2 * ctrlbank);
> -	enable =3D val & mask;
> -
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
>  }

[ ... ]

> -static ssize_t show_linear(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> +static ssize_t show_linear(struct device *dev, struct device_attribute *=
attr,
> +			   char *buf)
>  {
>  	struct lm3533_bl *bl =3D dev_get_drvdata(dev);
> -	u32 val;
> -	u8 mask;
> -	int linear;
> +	int ctrlbank =3D lm3533_bl_get_ctrlbank_id(bl);
>  	int ret;
> =20
> -	ret =3D regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
> +	ret =3D regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
> +			       CTRLBANK_AB_BCONF_MODE(ctrlbank));
>  	if (ret)
>  		return ret;

[Severity: High]
Could this have the same issue as show_als_en() above?

When the linear mode bit is set, regmap_test_bits() returns 1, triggering
this error path and returning 1 directly instead of calling scnprintf().

> =20
> -	mask =3D 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
> -
> -	if (val & mask)
> -		linear =3D 1;
> -	else
> -		linear =3D 0;
> -
> -	return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
> +	return scnprintf(buf, PAGE_SIZE, "%x\n", ret);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606045738.2105=
0-1-clamor95@gmail.com?part=3D11
