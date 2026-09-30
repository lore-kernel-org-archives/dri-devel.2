Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E87CA5FAB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D40410E22D;
	Wed, 30 Sep 2026 03:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SfZuxcY3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DAE10E22D
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 03:53:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9010B60239;
 Wed, 30 Sep 2026 03:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AFB1F000FF;
 Wed, 30 Sep 2026 03:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790740437;
 bh=m/7GWi3VdTSb2QMfP2Tvj/XMfmDfViidMc120nGzp8E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SfZuxcY3324hVU9jsDssfxjB0E1pofRq2k7HpLhCSYAL9gMlVAWvVLsIkAV1QqcbD
 /vFLsQZ54UBP9Si4+qIJNxDmfb5nKwQwtNymCWTWfOfQlywhHpXcV9+OIB5Y6FQsys
 cR8ZwXlQrRgjaczzDLYSJwEAN7NQ9CLvfML84EhLBeOvRurcHr1ZpkHSH4UUjNXNyN
 SLsaF/YcO9f7P9QD7Sa8vzN8HcIStzmSsUQPxju0Mf+lQzGsTJm6rYUJqv35VJUtOz
 KYp/AdS7PrfWVLYXrfFCnikcXNxlyRVa/TU/hymbBzRKZ0q8r5KI2JkFrSKiubHZ8v
 1pdmErpoZm9Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 03/20] accel/amdxdna: Add CERT firmware version support
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930033233.1727265-4-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20260930033233.1727265-1-yidong.zhang@amd.com>
 <20260930033233.1727265-4-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 03:53:56 +0000
Message-Id: <20260930035357.25AFB1F000FF@smtp.kernel.org>
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
- [Low] amdxdna: redundant entry in npu3_cert_feature_table
--

commit 3d4c843c0c43dded98465c96cc3cb5ac8f46a7fb
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Add CERT firmware version support

This commit adds support for querying and validating CERT firmware versions
on AIE4 platforms. It introduces mailbox opcodes, unifies firmware version
storage, and provides host queue protocol validation against driver
capabilities.

> diff --git a/drivers/accel/amdxdna/npu3_regs.c b/drivers/accel/amdxdna/np=
u3_regs.c
> index 8d287ef32fff7..31208c42ad5ff 100644
> --- a/drivers/accel/amdxdna/npu3_regs.c
> +++ b/drivers/accel/amdxdna/npu3_regs.c
> @@ -42,6 +42,12 @@ static const struct amdxdna_fw_feature_tbl npu3_fw_fea=
ture_table[] =3D {
>  	{ 0 }
>  };
> =20
> +static const struct amdxdna_fw_feature_tbl npu3_cert_feature_table[] =3D=
 {
> +	{ .major =3D 1, .min_minor =3D 0 },
> +	{ .features =3D BIT_U64(AIE4_HSA_COMMAND), .major =3D 1, .min_minor =3D=
 0 },

[Severity: Low]
Is this first entry without any features intentional?

When aie_check_protocol_impl() iterates through this table, both entries=20
match major =3D 1 and min_minor >=3D 0, so it will process both. The first=
=20
entry will perform a no-op bitwise OR on the feature mask=20
(aie->feature_mask |=3D 0) before the second entry applies the=20
AIE4_HSA_COMMAND feature.

This isn't a functional bug, but seems like a redundant configuration that=
=20
could be simplified by removing the first entry.

> +	{ 0 }
> +};
> +
>  static const struct amdxdna_dev_priv npu3_dev_priv =3D {
>  	.npufw_path             =3D "npu.sbin",
>  	.certfw_path            =3D "cert.sbin",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930033233.1727=
265-1-yidong.zhang@amd.com?part=3D3
