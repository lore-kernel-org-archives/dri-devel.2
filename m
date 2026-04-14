Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BF5F9D0FA
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 22:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF66210E068;
	Tue, 14 Apr 2026 22:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ZXVxbBvY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F35910E068;
 Tue, 14 Apr 2026 22:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vmzc3dGBR7OvS7grufrui739OmzLyorYPyJ9F2+Wa1U=; b=ZXVxbBvYTZfkzjKCTwkLrab2X6
 LN1C0H5e6/XA6g1LZzvZbZU7weIpyiwNNdS18rMWkrN0BAOiRKBawW6JrLknO1vPOM1N4HtlYzvL7
 jkpxz1c+nR+gtVMYoKF5M9GHf01H8DheQyhyM3tVm0r5Ej3W+LcB7srfs0+QAuydzRlorFH+knd4C
 bYzWigXp4CoWUGGs3WlBEHcJCpc3YfL3vaeEzEkcfZkyCa3bGRFC7eJSjHjcWU+6OrJN3y9dtOH+o
 VvmMlFMsYsFJg5OcyC+tK3AS2LHf2QTLnzf9EAdXaIj+RmMawjbN/Ein/TZggy/eiu2UoZhkvbgQF
 3iPMpCHA==;
Received: from [186.208.73.228] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wClqN-00G60j-TF; Wed, 15 Apr 2026 00:02:52 +0200
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
Subject: [RFC PATCH 0/4] drm/amd/display: better LUT segmentation for EOTFs
Date: Tue, 14 Apr 2026 18:54:59 -0300
Message-ID: <20260414220237.184289-1-mwen@igalia.com>
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

With an external HDR monitor, we can see gradient banding around the sun
in the intro of Ori and the Will of the Wisps game on steamOS/Gamescope.
Gamescope uses AMD predefined transfer functions for degamma,
shaper/pre-3D-LUT and blend/post-3D-LUT plus CRTC regamma, however, only
degamma block has hardcoded curves. Shaper, blend, regamma predefined
TFs are software-computed by AMD color module into PWL LUTs.

For this translation, the driver originally used the same helper for
EOTFs and inverse EOTFs, even though they differ in input domain, number
of regions and number of TF points per region.

This series targets DCN3+ hw families. It was verified with
steamOS/gamescope on DCN301 and DCN321 both HDMI-connected to an
external HDR monitor (Samsung G6 OLED 27").

Patch 1 reverts commit 8b89acc0b2ba ("drm/amd/display: Remove unused
cm3_helper_translate_curve_to_degamma_hw_format") to reintroduce a
degamma-specific helper and patch 2 wire it up for encoded ->
linear-light LUTs (degamma/blend). With 16 samples per region across 12
regions for blend LUT (where hardware fixed-function curves are not
available and predefined TFs are software-computed into LUTs), banding
on Ori becomes almost imperceptible.

Patch 3 and 4 increase precision in the brightest half, where PQ/SRGB
EOTFs are steeper, by enabling up to 256 samples per region and halving
the per-region point count across 9 regions (128 in [0.5, 1], 64 in
[0.25, 0.5], …). This better matches the shape of PQ/SRGB EOTFs.
Although patches 3 and 4 seem conceptually correct to me, I couldn't see
clear improvement in the bright end with or without them.

With this series:
- degamma and blend LUTs use
  cm3_helper_translate_curve_to_degamma_hw_format(): encoded input,
  non-zero end slope, up to 256 points linearly interpolated between
  adjacent TF pts, fitting [0,1] encoded input range.
- shaper and regamma LUTs continue using
  cm3_helper_translate_curve_to_hw_format(): linear-light input, zero
  end slope, 16 points per region across 32 regions.

Screenshots are not available: my available cameras couldn't capture the
banding cleanly againts the HDR monitor.

Let me know your thoughts!

Melissa

Melissa Wen (4):
  Revert "drm/amd/display: Remove unused
    cm3_helper_translate_curve_to_degamma_hw_format"
  drm/amd/display: use a separate helper to translate degamma curves
  drm/amd/display: support up to 256 samples per region
  drm/amd/display: rework segmentation for linearizing LUT

 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 184 ++++++++++++++++++
 .../display/dc/dwb/dcn30/dcn30_cm_common.h    |   4 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  10 +-
 3 files changed, 192 insertions(+), 6 deletions(-)

-- 
2.53.0

