Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C838CD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C101110EA17;
	Wed, 10 Jun 2026 15:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K6GfTQFt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410C710EA17
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:24:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0A1440774;
 Wed, 10 Jun 2026 15:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85AE1F00893;
 Wed, 10 Jun 2026 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781105090;
 bh=ZxkPqI2LQUiNR8MU0eFZsdjqi3F9qAbIjRkJlveZHkQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K6GfTQFtdtKvp597owoT4LShZFFC0QbxcmpV8vPg+u7XBVASZcgjBKe4b9Z1/DDVM
 O71BI5Zj6XYLXs5hMGQaWs4eEaUCJTTUaEyTonHPVaqMy0ylHQE+ae0LQYEmYmxZuJ
 lj7AgP4QMSnX3664ECjHGYH1999/1/4S+xiB5l67VoR2K6TT1rbpJDll80H1ARcgO7
 n0TlVH51Ijr1GfghetJxojypoiM3FfWQU1dCZUxKKv/raufreXz+1e34U86eypmhsH
 IIFmKwEv0sC7bc9ADDDeGPFCy0pWdDhISQI6AEKaF5BEo9FCoa1iAWC3PrO1GcSBVv
 jwZFW2wx+OZdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH resend 2] gpu/trace: TRACE_GPU_MEM should depend on DRM
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <600d327c8fc37decc1acaccc96439825d12c57e3.1781104422.git.geert+renesas@glider.be>
References: <600d327c8fc37decc1acaccc96439825d12c57e3.1781104422.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:24:50 +0000
Message-Id: <20260610152450.B85AE1F00893@smtp.kernel.org>
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
- [Medium] Adding `depends on DRM || COMPILE_TEST` to the `bool` config `TR=
ACE_GPU_MEM` restricts it to `n` when `DRM=3Dm`, preventing manual selectio=
n and causing an unmet direct dependency warning when selected by `DRM_MSM`.
--

commit 0cbe66fe073574dbd85dfed2b1c566d5b58e1668
Author: Geert Uytterhoeven <geert+renesas@glider.be>

gpu/trace: TRACE_GPU_MEM should depend on DRM

This commit adds a dependency on DRM for the TRACE_GPU_MEM configuration
option to prevent prompting users about this functionality when configuring
a kernel without DRM GPU support.

> diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
> index cd3d19c4a201c..7f405ce7df5a0 100644
> --- a/drivers/gpu/trace/Kconfig
> +++ b/drivers/gpu/trace/Kconfig
> @@ -2,6 +2,7 @@
> =20
>  config TRACE_GPU_MEM
>  	bool "Enable GPU memory usage tracepoints"
> +	depends on DRM || COMPILE_TEST

[Severity: Medium]
Will this dependency cause issues when CONFIG_DRM is built as a module?

Because TRACE_GPU_MEM is a bool config, if CONFIG_DRM=3Dm and COMPILE_TEST=
=3Dn,
the dependency expression evaluates to m, which restricts the bool to n.
This makes it impossible for users to manually enable the tracepoints when
DRM is built as a module.

Additionally, since tristate drivers like DRM_MSM use select TRACE_GPU_MEM,
building them as modules will force this bool to y, which exceeds its
dependency limit of m. This triggers an unmet direct dependencies warning
in Kconfig.

Would it be better to use depends on DRM !=3D n || COMPILE_TEST here?

>  	default n
>  	help
>  	  Choose this option to enable tracepoints for tracking

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/600d327c8fc37decc1a=
caccc96439825d12c57e3.1781104422.git.geert+renesas@glider.be?part=3D1
