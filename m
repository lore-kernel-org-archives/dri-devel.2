Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95231C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592A410E22B;
	Wed, 23 Sep 2026 22:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MQW2YFty";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A93B10E177;
 Wed, 23 Sep 2026 22:21:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F412D4023A;
 Wed, 23 Sep 2026 22:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953501F000FF;
 Wed, 23 Sep 2026 22:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790202093;
 bh=HnpSOg48K9AyG/QV+c/oO3ibbB0Xil2A4DY+Ahe8o+M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MQW2YFtyGm+yTls87ESx/JD72pVtNWeslnz22zFvE8TNH++BtsSsMzQk80JbyJ6Kh
 /lBPi16q9k8u/x3cGI9kvtoztZVdSfqoFMASPnH3umVKaGXkecaZsUtGeGYpivu4j0
 2AB2yziTpSBCZZdHQvQf4S6Cw9x3MW4Gy6mAy0lYe6PoiA4aBLf+QnVcok1sZyeR5A
 qsooyFQsQeW06JYaq7Kj6jsng3e93eNxljzXWmaiolgQeEtTBLfPHMkpWTLa9Bjo/p
 bstWjUGv/IriXJqo+z8iYr8uOY1y/fqeFfPWLkkIxehnxOQRoF1fgU6dZq5l1uSESp
 3i2hEg+yb8K5Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] drm/i915/dp: Ignore inconsistent TMDS limits on an
 Anker DP branch
To: "Conor Svensson" <conor10@gmail.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260923221018.42133-1-conor10@gmail.com>
References: <20260923221018.42133-1-conor10@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:21:33 +0000
Message-Id: <20260923222133.953501F000FF@smtp.kernel.org>
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
- [Low] drm/i915/dp: incomplete downstream ports signature match
--

commit 025075775ae9b93d6ea2089caff0dfbc102027cd
Author: Conor Svensson <conor10@gmail.com>

drm/i915/dp: Ignore inconsistent TMDS limits on an Anker DP branch

This commit adds an experimental workaround to clear derived TMDS limits
for a specific Anker DP branch device that reports inconsistent capabilities
when hotplugged, which can cause the loss of native modes.

Link: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/17180

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 0cd5e6b5034cf..beba989860056 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
[ ... ]
> +static bool
> +intel_dp_has_anker_tmds_mismatch(struct intel_dp *intel_dp,
> +				 const struct drm_edid *drm_edid)
> +{
> +	static const struct drm_dp_dpcd_ident branch =3D {
> +		.oui =3D { 0x90, 0xcc, 0x24 },
> +		.device_id =3D { 'S', 'Y', 'N', 'A', 'b', 0x10 },
> +		.hw_rev =3D 0x10,
> +		.sw_major_rev =3D 0x06,
> +		.sw_minor_rev =3D 0x05,
> +	};
> +	static const u8 downstream_ports[] =3D {
> +		0x0a, 0x42, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +	};
[ ... ]
> +	return !memcmp(&intel_dp->desc.ident, &branch, sizeof(branch)) &&
> +		!memcmp(intel_dp->downstream_ports, downstream_ports,
> +			sizeof(downstream_ports)) &&

[Severity: Low]
Does this comparison in intel_dp_has_anker_tmds_mismatch() strictly validate
the entire downstream port state as intended?

Because the local downstream_ports array is defined with only 8 elements,
sizeof(downstream_ports) evaluates to 8. However, intel_dp->downstream_ports
is a 16-byte array (DP_MAX_DOWNSTREAM_PORTS).

This partial match could theoretically trigger the quirk on a different dev=
ice
that shares the same firmware and first 8 bytes of port capabilities but
differs in the remaining 8 bytes, which seems contrary to the deliberately
narrow intent described in the commit message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923221018.4213=
3-1-conor10@gmail.com?part=3D1
