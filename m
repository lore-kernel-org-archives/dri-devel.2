Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E9DCDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E81110E4CA;
	Mon, 22 Jun 2026 07:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TrMFtab3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E041810E4CA
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:05:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A541D404D4;
 Mon, 22 Jun 2026 07:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C501F000E9;
 Mon, 22 Jun 2026 07:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782111943;
 bh=VNr2kMcS63Kfa6/RJUT/pS+jcnBmTYd/r8tSTzYy1as=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TrMFtab32SLFRfqB9/6ecPr/r//jhrVUCjCPiEJMx8s7rKB3m/eNz+xps1Bt7kGnD
 ulCOy0+RzoQ1h/RVjL0qAFpVwNqAlTLRThLTfYUiIT6EDSqrYgmrEFxCBR0dezqF1n
 oOnpI3ox8nRDPUBEH3TaNF8b52DzBwozOaTSjRJWCphg/0FS1Z4vdoMmsAZHgLVYB8
 VwohgWYV2tt7qQUBx4C+5L8TshV9DGmpmA41p/YCYXgaw5pcfDsBI36ibz1uaPeUX5
 3AsujIlK4llBm1Xz/btFrNbadiXohSY0cJMTMDPv+37zCZB+pW51y1QYIEe3pAL38H
 YLW20Pj87PbzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/7] gpu: host1x: Add Tegra264 support
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260622-t264-host1x-v2-4-ff7364d9ff7b@nvidia.com>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
 <20260622-t264-host1x-v2-4-ff7364d9ff7b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 07:05:42 +0000
Message-Id: <20260622070543.58C501F000E9@smtp.kernel.org>
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
- [Low] In `hw_host1x10_uclass.h`, the macro definition following `host1x_u=
class_indoff_rwn_read_v` incorrectly redefines `HOST1X_UCLASS_INDOFF_INDROF=
FSET_F` instead of defining `HOST1X_UCLASS_INDOFF_RWN_READ_V`.
--

commit 6528bd5a94c6539553c675b4b4c0ced0e30024a6
Author: Santosh BS <santoshb@nvidia.com>

gpu: host1x: Add Tegra264 support

This commit adds device data and chip headers for Tegra264.

> diff --git a/drivers/gpu/host1x/hw/hw_host1x10_uclass.h b/drivers/gpu/hos=
t1x/hw/hw_host1x10_uclass.h
> new file mode 100644
> index 0000000000000..abe83e67fa837
> --- /dev/null
> +++ b/drivers/gpu/host1x/hw/hw_host1x10_uclass.h
[ ... ]
> +static inline u32 host1x_uclass_indoff_indroffset_f(u32 v)
> +{
> +	return (v & 0xffff) << 2;
> +}
> +#define HOST1X_UCLASS_INDOFF_INDROFFSET_F(v) \
> +	host1x_uclass_indoff_indroffset_f(v)
> +static inline u32 host1x_uclass_indoff_rwn_read_v(void)
> +{
> +	return 1;
> +}
> +#define HOST1X_UCLASS_INDOFF_INDROFFSET_F(v) \
> +	host1x_uclass_indoff_indroffset_f(v)

[Severity: Low]
Does this code accidentally redefine HOST1X_UCLASS_INDOFF_INDROFFSET_F?

It looks like this might be a copy-paste error where
HOST1X_UCLASS_INDOFF_RWN_READ_V should have been defined instead, calling
host1x_uclass_indoff_rwn_read_v().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-t264-host1=
x-v2-0-ff7364d9ff7b@nvidia.com?part=3D4
