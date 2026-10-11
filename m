Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CFCCA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 07:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36AC910E0D8;
	Sun, 11 Oct 2026 07:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nWyR6RLQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C6E10E0D8
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 07:58:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4C0940F0C;
 Sun, 11 Oct 2026 07:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1751F0089B;
 Sun, 11 Oct 2026 07:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791705491;
 bh=Nq66WkdXCCBxaAJhgDgwbvleAO4PPadPzOoCv8NlTUs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nWyR6RLQnsXwazYbXy6J9L/fJ1HNp+cgmWtH9/ddG2xfcUA3mgqkSPlfJfl8OflM0
 AAbHfdzK7w3NIBBTDDG/WC8ruiAQ5g1C7I40a7QurMzT/ALJkf4GXg5+8m/9aSipWX
 LDfdIr5dOW/J5aoR6MKxhkK83bertcOoB06IMeyUf4J21ZQNvJapNRm9Pe9lZOIC+4
 qEgGFWMEaDoyGFPllO4laYAGDdVSnN4u9wLMFVEfFFLmTYLMU3B4gdqa1DFIprzhOX
 0fXOtxfihSPVYJfkuQMPMUGTdgDf7cVR1SZDaIorA0NVb5ePvQy/J0s51MbYGr0rU5
 OC5QwfdKc94KQ==
Message-ID: <sashiko-outbox-167111@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Initialize missing TD-LUT programming
 inputs
To: "Avi Weiss" <thnkslprpt@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261011074510.2495683-1-thnkslprpt@gmail.com>
References: <20261011074510.2495683-1-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 07:58:11 +0000
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
- [High] amd/display: Implicit cast of unsigned int to bool in is_gfx11 bre=
aks GFX12
--

commit 6cadd8de043129ed240d5c445ed5c65b848832cc
Author: Avi Weiss <thnkslprpt@gmail.com>

drm/amd/display: Initialize missing TD-LUT programming inputs

This commit aligns the mode programming path with the mode support path by
explicitly initializing tdlut_mpc_width_flag and is_gfx11 inputs in
dml_core_mode_programming() for DCN401 sources.

Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")

> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dm=
l2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2=
_core/dml2_core_dcn4_calcs.c
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn4_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn4_calcs.c
> @@ -11052,6 +11052,8 @@ static bool dml_core_mode_programming(struct dml2=
_core_calcs_mode_programming_ex
>  		calculate_tdlut_setting_params->cursor_buffer_size =3D mode_lib->ip.cu=
rsor_buffer_size;
>  		calculate_tdlut_setting_params->gpuvm_enable =3D display_cfg->gpuvm_en=
able;
>  		calculate_tdlut_setting_params->gpuvm_page_size_kbytes =3D display_cfg=
->plane_descriptors[k].overrides.gpuvm_min_page_size_kbytes;
> +		calculate_tdlut_setting_params->tdlut_mpc_width_flag =3D display_cfg->=
plane_descriptors[k].tdlut.tdlut_mpc_width_flag;
> +		calculate_tdlut_setting_params->is_gfx11 =3D dml_get_gfx_version(displ=
ay_cfg->plane_descriptors[k].surface.tiling);

[Severity: High]
This problem wasn't introduced by this patch, but it appears this copies an
existing bug from dml_core_mode_support() into dml_core_mode_programming().

Looking at dml_get_gfx_version(), it returns an unsigned int 12 for GFX12
swizzle modes. When this result is assigned directly to the boolean field
is_gfx11, it will evaluate to true because any non-zero integer is true in =
C.

Could this cause GFX12 hardware to incorrectly use GFX11 TD-LUT pitch
alignment (like 256B instead of 128B), leading to display corruption?

Would it be better to use an explicit equality check here and in the mode
support path, such as:
is_gfx11 =3D (dml_get_gfx_version(...) =3D=3D 11);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011074510.2495=
683-1-thnkslprpt@gmail.com?part=3D1
