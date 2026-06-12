Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA28CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 06:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0BF310F299;
	Fri, 12 Jun 2026 06:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eSlGRjp+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAE510F299
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 06:43:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA375403C6;
 Fri, 12 Jun 2026 06:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2801F000E9;
 Fri, 12 Jun 2026 06:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781246592;
 bh=Jt8Uq7HNTTi6GllHQeTQSn2ucjpjbo/GPqNvbcMDeSQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eSlGRjp+rpr72XYUgRDRyAK6J1+eaCdAaA4iof0gVIZSrO5x1NH6FyDLEcpGcuBK5
 atiwuT0ThiKjKNmHBxwDppau6GG7WSeQNPpgClTdJNw8b3Dnc/Ldtg2Q5/wtXeBE6r
 AI8vHU6BZW1nB626cW/6/F2gf3O4EaZQ0OGAY6kx+99CGv0yxYnmYPdTx5NXe//sT0
 ZV10tnk94nin4dhPsfR4+WSANThHL9wlkg/7g+6piN3ksCB/4uYga+QHoxGv6D/7BU
 6RAg2ZSYwTNlBEVVjQG2FQ6qjHCujyAHOYXQvTWSriIWCotsNdiWRRr7oDBNE9zS9I
 o1bPMGGqBGOkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] gpu: host1x: Add Tegra264 support
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260612-t264-host1x-v1-4-8d934987de67@nvidia.com>
References: <20260612-t264-host1x-v1-4-8d934987de67@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 06:43:11 +0000
Message-Id: <20260612064312.2F2801F000E9@smtp.kernel.org>
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
- [Low] The macro `HOST1X_UCLASS_INDOFF_RWN_READ_V` is missing due to a cop=
y-paste error that instead incorrectly duplicates the definition of `HOST1X=
_UCLASS_INDOFF_INDROFFSET_F(v)`.
--

commit bc3ed2efd3fa7eeadce14ecd91452f9ad7d9471e
Author: Santosh BS <santoshb@nvidia.com>

gpu: host1x: Add Tegra264 support

Add device data and chip headers for Tegra264.

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
This isn't a bug, but it looks like HOST1X_UCLASS_INDOFF_INDROFFSET_F is
accidentally duplicated here instead of defining the macro wrapper
HOST1X_UCLASS_INDOFF_RWN_READ_V for host1x_uclass_indoff_rwn_read_v.

> +static inline u32 host1x_uclass_load_syncpt_payload_32_r(void)
> +{
> +	return 0x4e;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-t264-host1=
x-v1-0-8d934987de67@nvidia.com?part=3D4
