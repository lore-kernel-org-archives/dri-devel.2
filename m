Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE630C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F03F10F44A;
	Fri, 24 Jul 2026 16:32:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lpLP0y7F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D3B10F438
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 16:32:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE39340795;
 Fri, 24 Jul 2026 16:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D761F000E9;
 Fri, 24 Jul 2026 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784910746;
 bh=vFgB/mbTrCQnF4Jlx27KFFmnMAy5wlHrb6tQqpdlWD0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lpLP0y7FQtfKlp3ycaapn2zWNQHzc6bBPvePXix0kJ5p7lg2SJIz0abgk6CNKd1D8
 2F+2FmqT1H9W1kaMRvU5pnoqJNt56pPzqUzpV05ntTXqIG7Ff4QsqAeH8Q4+dF7FdG
 EPStZcHqOjQLWpk7EYaQvBVNoVWAT5EkM9eqO/TUvIYhTd3zs9MuO7RxokTwoe7B0p
 hK6vVmY+6i7VRhh6DpRDWf/TbRuRHqORFenSIcwq3oRqa01JErU42NdAzOcIAnCdMU
 /YLoB0fGtbiKntP5JfcY01YwuOBcjlGoCjwrKO8ElilovZgCHi/yGWCFkqdosb/yow
 Wl9d/unqZaa+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/amd/display: Use HDMI FreeSync range from
 common EDID parser
To: "Alex Huang" <Alex.Huang2@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724161713.119382-3-Alex.Huang2@amd.com>
References: <20260724161713.119382-1-Alex.Huang2@amd.com>
 <20260724161713.119382-3-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 16:32:25 +0000
Message-Id: <20260724163226.11D761F000E9@smtp.kernel.org>
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
- [Low] The commit leaves `dc_edid_parser.c`, `dc_edid_parser.h`, and relat=
ed DMCU implementations as dead code in the tree.
--

--- Patch [2]: [PATCH v2 2/4] drm/amd/display: Use HDMI FreeSync range from=
 common EDID parser ---
commit b930a5d2e04e7c446b977172996d0296d4389e57
Author: Alex Huang <Alex.Huang2@amd.com>
Subject: drm/amd/display: Use HDMI FreeSync range from common EDID parser

This commit transitions the detection of HDMI FreeSync on amdgpu to use the
common DRM EDID parser instead of the AMD VSDB parser in the DMUB firmware.
It extends get_amd_vsdb() to copy relevant flags and removes the old parser
helper functions from amdgpu_dm.c.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9c564cd5edeea..fd9bb205c8f08 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -36,7 +36,6 @@
>  #include "dc/inc/hw/dmcu.h"
>  #include "dc/inc/hw/abm.h"
>  #include "dc/dc_dmub_srv.h"
> -#include "dc/dc_edid_parser.h"

[Severity: Low]
This isn't a bug, but by removing the inclusion of dc_edid_parser.h and the
callers to dc_edid_parser_send_cea() and dc_edid_parser_recv_amd_vsdb(),
does this leave the implementation in dc_edid_parser.c as dead code?

It looks like drivers/gpu/drm/amd/display/dc/Makefile still compiles
dc_edid_parser.o, and the related DMCU backend implementations like
dcn10_send_edid_cea() in drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
are now completely unreferenced.

Would it make sense to remove the dc_edid_parser.c file, its header, and
the corresponding backend implementations to avoid compiling unused code?

>  #include "dc/dc_stat.h"
>  #include "dc/dc_state.h"
>  #include "amdgpu_dm_trace.h"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724161713.1193=
82-1-Alex.Huang2@amd.com?part=3D2
