Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562D4C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1C310E3DA;
	Thu, 27 Aug 2026 10:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VumWBotO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C4710E3DA
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 10:38:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D64F40B0B;
 Thu, 27 Aug 2026 10:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7341F000E9;
 Thu, 27 Aug 2026 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787827095;
 bh=14SXuqBi2l5N9KDABxIxwW9mInaJ7u437NFkNP3R+BM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VumWBotOITJeBmKflkQx7Lp+5ABtfrMmXwdpImkyvkBDz/MwDFu2kg8yjgRwDM3ch
 mcmmopuILByeDnUsBhQtId32gXcG6p7LImxfHuRoqNEUp1cbADFqyM7W0q17IP/lS3
 1USr1YR12wKjER66x81c+IB8iRtLUutGHkCnNLySWfmo8A/RKlEqWAYTzHjKAD+z6J
 PMTE+JIbBSoN5nbJxea37FUko+7ztYbTzQryNeT9ETO4rLQh6J/0oaL1L1VEg0ftzp
 FKC1O2vm8DMlPyfGstZ2X9azVcIl21vTBWMDRpz3umQzv1jPj7qp+CnOcIiEUmzPxi
 JWTeec9h09iPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] accel/ivpu: Validate firmware log buffer metadata
To: "Dawid Osuchowski" <dawid.osuchowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827102339.281799-3-dawid.osuchowski@linux.intel.com>
References: <20260827102339.281799-1-dawid.osuchowski@linux.intel.com>
 <20260827102339.281799-3-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 10:38:14 +0000
Message-Id: <20260827103814.DB7341F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Unsafe printing of firmware-controlled string without length bound=
s could lead to out-of-bounds read.
--

commit fd0e38bea76a0e3e0f409139f3cf70f7ae5a79ea
Author: Magdalena Schulfer <magdalena.schulfer@intel.com>

accel/ivpu: Validate firmware log buffer metadata

The tracing log headers parsed by fw_log_print_buffer() reside in
DMA-shared BOs that the NPU firmware can write to. This commit mitigates
a TOCTOU vulnerability by snapshotting the header size and size fields
before validating them.

> diff --git a/drivers/accel/ivpu/ivpu_fw_log.c b/drivers/accel/ivpu/ivpu_f=
w_log.c
> index 716467aa31567..4f9055aa9d33f 100644
> --- a/drivers/accel/ivpu/ivpu_fw_log.c
> +++ b/drivers/accel/ivpu/ivpu_fw_log.c
[ ... ]
> @@ -39,26 +46,32 @@ static int fw_log_from_bo(struct ivpu_device *vdev, s=
truct ivpu_bo *bo, u32 *off
[ ... ]
> -	*out_log =3D log;
> -	*offset +=3D log->size;
> +	desc->log =3D log;
> +	desc->header_size =3D header_size;
> +	desc->size =3D size;
> +	*offset +=3D size;
> =20
>  	ivpu_dbg(vdev, FW_BOOT,
>  		 "FW log name \"%s\", write offset 0x%x size 0x%x, wrap count %d, hdr =
version %d size %d format %d, alignment %d",
> -		 log->name, log->write_index, log->size, log->wrap_count, log->header_=
version,
> -		 log->header_size, log->format, log->alignment);
> +		 log->name, log->write_index, size, log->wrap_count, log->header_versi=
on,
> +		 header_size, log->format, log->alignment);

[Severity: High]
This isn't a bug introduced by this patch, but since this commit aims to
secure the untrusted log header, is it safe to print log->name using %s?

The name array (16 bytes) in struct vpu_tracing_buffer_header is controlled=
 by
the firmware. If the firmware fails to null-terminate it, printing it with =
%s
in ivpu_dbg() will cause an out-of-bounds read. This could leak adjacent
memory into the kernel log or trigger a panic if the read crosses into
an unmapped page.

Could we bound the length by using %.16s instead?

A similar issue also exists in fw_log_print_buffer(), where log->name is
repeatedly passed to drm_printf() using %s without length limits.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827102339.2817=
99-1-dawid.osuchowski@linux.intel.com?part=3D2
