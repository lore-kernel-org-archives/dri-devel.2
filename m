Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A99CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70EF10E084;
	Fri, 19 Jun 2026 14:05:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NEg20nPz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C554B10E084
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 14:05:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 339F5601E1;
 Fri, 19 Jun 2026 14:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58B01F000E9;
 Fri, 19 Jun 2026 14:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781877924;
 bh=59V/LUzlJYZOQFWGbzUP7JqzlsV003bjTOZZe0K0eAs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NEg20nPzBlLUScDJ2jQrKXeFVFWG0a2lHsZhD59JVfTL7epY/CJcDjrb58T9MLmuk
 V/0jxwpr4jYVrxPNLtXd2jH/lmzwePtKw+ihLGFKr1X2J2kkcL3AwXVDplGGlrOHSV
 r1aQdqCjIf2FD/mhAqG7bgWLNPRjcLT4ahlvGcmMqRrzRv/tUm6IxR2iAbNjZfSsp7
 W+vNtTgVFjPOHv7IBOe6V9OIULr7sImFTWS6iiCXy7gudQzgaQEgTiq7g13BxqEqnP
 +xzwnyzLT7gXTb1H2OIS4afXaTRkmaExrQVNYGkXu9JSbSbTu1j7A6a+SqL1AC3CXB
 cjmKvy/g3BgYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/sysfb: simpledrm: Improve panel-size validation
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260619135847.309664-3-tzimmermann@suse.de>
References: <20260619135847.309664-1-tzimmermann@suse.de>
 <20260619135847.309664-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 14:05:24 +0000
Message-Id: <20260619140524.B58B01F000E9@smtp.kernel.org>
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
- [Low] Uninitialized stack variable `value` is printed in `drm_dbg()` when=
 `of_property_read_u32()` fails.
--

commit a1ba4b62fd041b3fc66d9ae1c41a47b859017d1c
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/sysfb: simpledrm: Improve panel-size validation

This commit validates the panel size from the device-tree node against
the limitations of struct drm_display_mode and fails transparently on
errors without warning.

Cc: stable@vger.kernel.org # v6.4+

> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/si=
mpledrm.c
> index 03bd19fadccd5..5c1db0785d926 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> @@ -200,6 +200,35 @@ simplefb_get_memory_of(struct drm_device *dev, struc=
t device_node *of_node)
>  	return res;
>  }
> =20
> +static u16
> +__simplefb_get_panel_size_mm_of(struct drm_device *dev, struct device_no=
de *of_panel_node,
> +				const char *name)
> +{
> +	int ret;
> +	u32 value;
> +
> +	ret =3D of_property_read_u32(of_panel_node, name, &value);
> +	if (ret || value > U16_MAX) {
> +		drm_dbg(dev, "simplefb: cannot parse panel %s: value %u, error %d\n",
> +			name, value, ret);

[Severity: Low]
Does this code print an uninitialized stack variable when
of_property_read_u32() fails?

If the property is missing from the device tree or another error occurs,
of_property_read_u32() will return a non-zero error code and leave the
value parameter untouched. When this happens, the uninitialized stack
memory will be unconditionally passed to drm_dbg() for printing.

> +		return 0; /* not an error, simply ignore */
> +	}
> +
> +	return value;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619135847.3096=
64-1-tzimmermann@suse.de?part=3D2
