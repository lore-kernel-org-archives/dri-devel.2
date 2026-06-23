Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20014CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA8510E0C2;
	Tue, 23 Jun 2026 09:52:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="haT36vcd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA9010E0C2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 09:52:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E75FB416D9;
 Tue, 23 Jun 2026 09:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEAC1F000E9;
 Tue, 23 Jun 2026 09:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782208365;
 bh=UWoD93TWOsJ4wuxuTrdDrUyqXnJhjBCfkC9FIM+NDnE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=haT36vcdLEKE/Y7umgvdRaPSpA6ZqpD2Qa5M/HwOAa2GIQfQWrBafSfm3TxMz/g6l
 gdVFW+fsixuvL+QlvTkLCOHRlGmQ5Y0sqx4EJf30wUJNE6mGOIAgKLoK/bzEhHvhR1
 2rfMEAJBvNyc/qwxVB/jZ+cdg+td7/gIuVSi7cEfID1kyloMqQAz5kKl8m5+vTcge4
 N4oIc+hRLB58swhFQizd4ZR2CXVqZjHpwd076i5Cf01JxOLd2MRFoOSdgdELqYm6Cp
 bWYDJnQSimF3QalO83Dbu6LGcUJ+cMU0CEZSdQXUDB1Ig4O91X9yVc52+VpOmU6fbZ
 TGbpLUZnsmbfw==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND 3/4] drm/dp: Add max bpp delta computation constants
To: "Nemesa Garg" <nemesa.garg@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623094236.1586318-4-nemesa.garg@intel.com>
References: <20260623094236.1586318-1-nemesa.garg@intel.com>
 <20260623094236.1586318-4-nemesa.garg@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:52:44 +0000
Message-Id: <20260623095245.AEEAC1F000E9@smtp.kernel.org>
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
- [Medium] The commit message claims to introduce masks for RGB/YCbCr444 an=
d YCbCr420 and add a 'version_1' suffix to MAX_DELTA_BPP, but these changes=
 are absent from the patch diff.
--

commit c43e818317532135cb07d6c396122c12f12acaca
Author: Nemesa Garg <nemesa.garg@intel.com>

drm/dp: Add max bpp delta computation constants

This commit defines macros used for decoding DSC max bpp delta values from
the sink DPCD. It introduces definitions for delta scaling and shifts for
various formats.

> drm/dp: Add max bpp delta computation constants
>=20
> Define macros used for decoding DSC max bpp delta values
> from the sink DPCD. This includes per-format masks for
> RGB/YCbCr444 and YCbCr420, as well as definitions for delta
> scaling and the YCbCr420 bit shift. Also add version_1 as
> suffix to MAX_DELTA_BPP.
>=20
> v2: Move constants under 0x6E register. [Ankit]
>     Add mask for Native 422 also. [Ankit]
> v3: Rename _DSC_NATIVE4222 to _DSC_NATIVE_YCbCr422. [Ankit]
> v4: Move Version_1 edit ti patch_1. [Ankit]
>     Add shift mask for native also. [sashiko]

[Severity: Medium]
Does the commit message accurately reflect the changes in the patch?

The message states it adds per-format masks for RGB/YCbCr444 and YCbCr420,
as well as a version_1 suffix to MAX_DELTA_BPP. However, the version_1
suffix change was moved to another patch according to the v4 notes, and
the per-format masks are already present in the baseline context of
include/drm/display/drm_dp.h.

Could the commit message be updated to remove the claims about the masks
and the version_1 suffix so it matches the actual patch contents?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623094236.1586=
318-1-nemesa.garg@intel.com?part=3D3
