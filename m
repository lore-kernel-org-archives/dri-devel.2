Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5247ACD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:17:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46C210EEAB;
	Wed, 17 Jun 2026 08:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xzdhr+fl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6361510EEAB
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:17:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C5C941734;
 Wed, 17 Jun 2026 08:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F7F1F000E9;
 Wed, 17 Jun 2026 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781684222;
 bh=XC9wtXc5Er7eDX8M6LwgMZHUngAB2v3QW5QAOnwsr1E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xzdhr+flD7l1F+1PeVPRwP4b5Upo2SLH6g7rJLu6m6oTmvlCBml6yREwZtcrjPcpB
 PbUMNM9Kp5QsKPtC+mlN4SeKJxNBguxg05UxUhAajYuWPSgEKYagUNH91TDt86ur0e
 H8lvJbPdHtMc3zzf/f4a0pU4Q+nVFONSLyqgzQzmXekHtlbCRJQ2sIDCiSYBY5Kk4o
 vgNqiomA7DSkEC8+7fWLJ4HhSNr14dyjRQhY1nkgP75oiZeopvb9lAfPYUZrhU1Q+B
 sziP7bjaNeAusXM3JVStmmV3j6nasjmqnzXmnHQQQzGKXpCyqO2i8BrsOWsgP5hY8+
 wVY4lub8a6SJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/14] video: backlight: lm3533_bl: Implement
 backlight_scale property
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260617080031.99156-14-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-14-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 08:17:01 +0000
Message-Id: <20260617081701.E6F7F1F000E9@smtp.kernel.org>
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
- [Medium] Race condition in `store_linear` leading to hardware and softwar=
e state mismatch.
--

commit 52a62eb2455ff3beba4492c4d5e3f63ad2e5e71d
Author: Svyatoslav Ryhel <clamor95@gmail.com>
video: backlight: lm3533_bl: Implement backlight_scale property

This commit implements the backlight_scale property for the lm3533_bl drive=
r.
It describes whether the backlight operates in linear or non-linear mode
based on the device state.

> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backligh=
t/lm3533_bl.c
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

[Severity: Medium]
Could this allow the hardware state and the software property to diverge
during concurrent writes?

Since kernfs does not serialize concurrent writes to sysfs files, if two
threads write contradictory values at the same time, the regmap updates and
the bd->props.scale updates could interleave. This might result in the
hardware being configured in one mode while bd->props.scale incorrectly
reports the opposite mode.

Would it make sense to protect this update sequence with a lock to ensure b=
oth
the hardware and software properties are updated atomically?

> +
>  	return len;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617080031.9915=
6-1-clamor95@gmail.com?part=3D13
