Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFA2CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379F010E4A7;
	Mon, 12 Oct 2026 04:32:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D90910E43F;
 Mon, 12 Oct 2026 04:32:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E730A4012D;
 Mon, 12 Oct 2026 04:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B4B1F0089B;
 Mon, 12 Oct 2026 04:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791779527;
 bh=XGQ68oNB5we3OjdwQzJ8BF70ccdImpPjGh2tdMeQjuU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ka+cQEX92k/Bw3U/2kL9i6gVVTBNUTQVJG5LKGmTK1KxmG76bIXCHPp99GWujQ+nu
 yYCpdARZhMDy6TOgbWOBX4LjOGJg57iOWbRz85xdoTDOFb3bSmVg45WtcOFCT8nm7D
 /BHK73cGR6XGIyF87bAZW6WUYKmnYJTUkAcVbP6SS/fcCI/ODbgwargFiu1DMt+ZjD
 dbRNB5C0O4Avu+FvcqRv/Vgneba+4tlSDqlI1yr7C8Z1uZ/HPqui0jE+46EnCGSTHQ
 LxhkMnoXdN/PEPYohjXBLsBdLIt8Yxd/TikKS4RLKbmG4yXypPMXQFjuBMzxNcsokK
 zg55Y2iBYFBug==
Message-ID: <sashiko-outbox-167603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/56] drm/drm_scdc_helper: Add SCDC helper funcs for
 FRL
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-5-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-5-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:32:07 +0000
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
- [Low] drm/display: Unnecessary I2C read in drm_scdc_disable_frl()
--

commit 4f7a237d2d408c021d966e908effa3af04d82b79
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/drm_scdc_helper: Add SCDC helper funcs for FRL

This commit introduces SCDC register definitions and helper functions
to configure and monitor FRL (Fixed Rate Link) link training between
the source and sink.

> diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/=
display/drm_scdc_helper.c
> --- a/drivers/gpu/drm/display/drm_scdc_helper.c
> +++ b/drivers/gpu/drm/display/drm_scdc_helper.c
[ ... ]
> +int drm_scdc_disable_frl(struct i2c_adapter *adapter)
> +{
> +	u8 config;
> +	int ret;
> +
> +	ret =3D drm_scdc_readb(adapter, SCDC_CONFIG_1, &config);
> +	if (ret)
> +		return ret;
> +
> +	config &=3D ~SCDC_FRL_RATE;
> +
> +	return drm_scdc_writeb(adapter, SCDC_CONFIG_1, config);

[Severity: Low]
Is this read-modify-write sequence strictly necessary here?

The SCDC_CONFIG_1 register contains only SCDC_FRL_RATE (bits 0-3) and
SCDC_FFE_LEVELS (bits 4-7). Since FFE levels are only meaningful when FRL is
enabled, preserving them during disable is likely unnecessary.

Given that reading over the slow I2C DDC bus adds measurable latency, and
drm_scdc_config_frl() successfully treats the register as fully known by
issuing a direct write without a preceding read, would it be better to just
issue a direct write of 0 to clear the register entirely?

> +}
> +EXPORT_SYMBOL(drm_scdc_disable_frl);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D4
