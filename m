Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357D1CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 19:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AB010E57F;
	Wed,  6 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XN3iL33f";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E78610E57A;
 Wed,  6 May 2026 19:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kbh8Dx9ZT2NXbhoJFJ29DLjgkN9Znn/NHozEGfNgbuY=; b=XN3iL33fQkmeLlBxvghctZ+bqz
 9FOKDeb0obBCi1nino56lSN2l1+pweE6+P9mxTUR0XimiRwkbODoq4UoSrhhkysTVr8+BUqBeJ1fg
 JX9SRFWv/m1v7kzBVG36lH2qVjWxPqGaHA0dxWxkcdtYmuBBOXwEI+Dqo5iznmNu4UNrUZy4C6prN
 /RUHcLJRC+P9hrK056WZ754uFYW54bTpDsf9TZ2sdSv3r+J+DyhBVAbwzCAgHFcpCuYhd687k0tuJ
 pcYm0QFEUe13/qR8VQzzurJ2BvVz68/Sn3Acb8J1jmSVgJa+sDg37OU67UytMUvUUAgHfu2IWiBbF
 dP2RhuiQ==;
Received: from [186.208.73.228] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKhjJ-0072Pg-PM; Wed, 06 May 2026 21:16:21 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 pekka.paalanen@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: [PATCH v2 0/5] better LUT segmentation for EOTFs
Date: Wed,  6 May 2026 16:11:47 -0300
Message-ID: <20260506191606.15022-1-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

With an external HDR monitor, we can see gradient banding around the sun
in the intro of Ori and the Will of the Wisps game on steamOS/Gamescope.
Gamescope uses AMD predefined transfer functions for degamma,
shaper/pre-3D-LUT and blend/post-3D-LUT plus CRTC regamma, however, only
degamma block has hardware curves. Shaper, blend, regamma predefined TFs
are software-computed by AMD color module into PWL LUTs. In addition, we
cannot use hardware curves on PRE_DEGAM with subsampled format, so that,
predefined TFs are also translated to LUTs in this situation, using
GAMCOR block instead. For this translation, the driver originally used
the same helper for EOTFs and inverse EOTFs, even though they differ in
input domain, number of regions and number of TF points per region.

Baring this in mind, patch 1 maps degamma predefined curves as LUT using
GAMCOR block for AMD driver-specific property that are still in use by
current gamescope. This was inspired by a similar patch from Harry for
colorop [1]. Patch 2 reverts commit 8b89acc0b2ba ("drm/amd/display:
Remove unused cm3_helper_translate_curve_to_degamma_hw_format") to
reintroduce cm3_helper_translate_curve_to_degamma_hw_format() and patch
3 wire it up for encoded -> linear-light LUTs (degamma/blend). With 16
samples per region across 12 regions for blend LUT (where hardware
fixed-function curves are not available and predefined TFs are
software-computed into LUTs), banding becomes almost imperceptible.

Patch 4 and 5 increase precision in the brightest half, where PQ/SRGB
EOTFs are steeper, by enabling up to 256 samples per region and halving
the per-region point count across 9 regions (128 in [0.5, 1], 64 in
[0.25, 0.5], …). This better matches the shape of PQ/SRGB EOTFs.
Although patches 4 and 5 seem conceptually correct to me, I couldn't see
clear improvement in the bright end with or without them.

This series targets DCN3+ hw families. With this series:
- degamma and blend LUTs use
  cm3_helper_translate_curve_to_degamma_hw_format(): encoded input,
  non-zero end slope, up to 256 points linearly interpolated between
  adjacent TF pts, fitting [0,1] encoded input range.
- shaper and regamma LUTs continue using
  cm3_helper_translate_curve_to_hw_format(): linear-light input, zero
  end slope, 16 points per region across 32 regions.

[1] https://lore.kernel.org/dri-devel/20260330153451.99472-8-harry.wentland@amd.com/

[v1] https://lore.kernel.org/dri-devel/20260414220237.184289-1-mwen@igalia.com/
Changes:
- new patch for GAMCOR usage in case of degamma predefined TF with subsampled formats
- fix misleading information regarding degamma hw curves (Kruno)
- clarify LUT segmentation choice using 8-bit sRGB as a reference (Kruno)

Best Regards,

Melissa

Melissa Wen (5):
  drm/amd/display: use GAMCOR for degamma private props in subsampled
    format
  Revert "drm/amd/display: Remove unused
    cm3_helper_translate_curve_to_degamma_hw_format"
  drm/amd/display: use a separate helper to translate degamma curves
  drm/amd/display: support up to 256 samples per region in degamma/blend
    LUT
  drm/amd/display: use halving distribution for PQ/sRGB linearizing LUT

 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  16 +-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 184 ++++++++++++++++++
 .../display/dc/dwb/dcn30/dcn30_cm_common.h    |   4 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  10 +-
 4 files changed, 204 insertions(+), 10 deletions(-)

-- 
2.53.0

