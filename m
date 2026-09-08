Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F3BC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 05:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A8C710E090;
	Tue,  8 Sep 2026 05:59:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M9lp5qUC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85CBF10E090
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 05:59:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D2B2438F9;
 Tue,  8 Sep 2026 05:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028281F00A3A;
 Tue,  8 Sep 2026 05:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788847196;
 bh=eG/ks7iVrBPsCbCRo6evEwdZXlZuMB+Go8ahtIVUagg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M9lp5qUCq042o9n5J/c2b4JtbolAAxlWusvSgmErbB8+RPUjLKNzy2uoyGTf8Q7MP
 fSVmtYt5Eg/Bvf+WzsgfeOnwYei9RaQFs7pLdKLY1mZ8DS4kFkokuIL3n7PZaUhFem
 a1aiIhf75x+By6q8FiNZqB1c+dAryYwmuLWzrk6orYK+G3T2cXA51bTeXJGShw9Dej
 VMCPgAeGheKqDhfrSkY8Ca6+ajhNiKxH4Sxa23S36+ceAOiR2ZaJy9e1AgqJdPHOwi
 AE/S7uxpnPwUheK9dtOOSJccl6Z3VNQzuNywYFQh+vzvCX0F8Td/OT+rNujrtUJ4py
 MIXBCnF1MNcXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Fix wrong plane index in dcn6
 writeback latency loop
To: yaolu@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908055202.141884-1-yaolu@kylinos.cn>
References: <20260908055202.141884-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 05:59:55 +0000
Message-Id: <20260908055956.028281F00A3A@smtp.kernel.org>
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
- [High] Incomplete fix: identical array indexing bugs exist in CalculateSt=
utterEfficiency functions where `stream_descriptors` is incorrectly indexed=
 with the plane index `k` instead of the mapped stream index.
--

commit 9f32a635ed6555b0a150b8f427a0ef1a3afa7d82
Author: Lu Yao <yaolu@kylinos.cn>
Subject: drm/amd/display: Fix wrong plane index in dcn6 writeback latency l=
oop

This commit fixes a loop boundary in
dcn6_calculate_watermarks_and_dram_speed_change_support() by correctly
using the plane index instead of the inner loop variable to access the
stream descriptor.

> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dm=
l2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/sr=
c/dml2_core/dml2_core_dcn6_calcs_dchub.c
> index ba0082e216d59..ba4dad0cfdf4f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn6_calcs_dchub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn6_calcs_dchub.c
[ ... ]
> @@ -1271,7 +1271,7 @@ void dcn6_calculate_watermarks_and_dram_speed_chang=
e_support(
>  			DML_LOG_VERBOSE("DML::%s: k=3D%u, VActiveLatencyHidingUs =3D %f\n", _=
_func__, k, p->VActiveLatencyHidingUs[k]);
>  		}
> =20
> -		for (unsigned int j =3D 0; j < p->display_cfg->stream_descriptors[p->d=
isplay_cfg->plane_descriptors[j].stream_index].writeback.active_writebacks_=
per_stream; ++j) {
> +		for (unsigned int j =3D 0; j < p->display_cfg->stream_descriptors[p->d=
isplay_cfg->plane_descriptors[k].stream_index].writeback.active_writebacks_=
per_stream; ++j) {
>  			double byte_per_pixel_luma_in_buffer =3D 1.0;
>  			double buffer_for_luma =3D (double)p->WritebackInterfaceBufferSize * =
1024.0 / 2.0;

[Severity: High]
This isn't a bug introduced by this patch, but does this fix miss identical
array indexing bugs in the stutter efficiency calculations?

In dml2_core_dcn6_calcs_dchub.c:dcn6_calculate_stutter_efficiency(), the
code incorrectly uses the plane index (k) directly instead of the mapped
stream index:

    for (unsigned int j =3D 0; j < p->display_cfg->stream_descriptors[k].wr=
iteback.active_writebacks_per_stream; j++)

This exact same direct indexing pattern also occurs in:
- dml2_core_dcn5_calcs_dchub.c:dcn5_CalculateStutterEfficiency()
- dml2_core_dcn4_calcs.c:CalculateStutterEfficiency()

When multiple planes exist and are mapped to streams non-linearly (e.g.,
plane 0 mapped to stream 1) while writeback is active, the wrong stream
descriptor is accessed. This causes the driver to incorrectly calculate
TotalActiveWriteback as 0 instead of its true value.

Since stuttering is incorrectly kept enabled when writeback is active,
the display core could fail to meet memory bandwidth deadlines, resulting
in display underflow.

>  			if (p->display_cfg->stream_descriptors[p->display_cfg->plane_descript=
ors[k].stream_index].writeback.writeback_stream[j].pixel_format =3D=3D dml2=
_444_64) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908055202.1418=
84-1-yaolu@kylinos.cn?part=3D1
