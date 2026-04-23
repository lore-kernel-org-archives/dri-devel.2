Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858E5F589DB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D9D10F152;
	Thu, 23 Apr 2026 14:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VPqhXwBC";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4966010E2B5
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:21:47 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 667E5838;
 Thu, 23 Apr 2026 16:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776954006;
 bh=k4Kr8v8q1FzJJOLJ0lZjjhg5zxTdGMz2I9k2MPOlTAM=;
 h=From:Subject:Date:To:Cc:From;
 b=VPqhXwBCn99Bs0mPijcUeG2KgW5wpIHlcJ/hEZS5Of8b/JgSLCZft0w+331Sk2PFy
 HxXznzuqB6Hr12qS9jGHD3x0eEQhDGqrAjWMc+XuIOu95lAUJxs6svIiAyln3GlFZU
 hZXcTxzjIH+mQTcH5Xef0R1/X+Ke+TSdqfzMB67s=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v10 00/11] drm: Add new pixel formats for Xilinx Zynqmp
Date: Thu, 23 Apr 2026 17:21:11 +0300
Message-Id: <20260423-xilinx-formats-v10-0-c690c2b8ea89@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANgq6mkC/3XQyWrDMBCA4VcJOtdlFi12T32P0oPWRtDYxQ7GJ
 eTdK6ekhjo6ziB9Qv9FTHHMcRIvh4sY45ynPPRlQHg6CH+0/UdscigLQUASkaBZ8mfulyYN48m
 epyYZ7AA1YcssyqWvMaa83MS39zIf83Qexu/bAzOu21+KQP6nZmygAZfIK5QmOHzNIdpp6N1gx
 /Dsh5NYxZnuigJEtVOoKKiByXirFdmKwptCSDuFi9JBgBQRdNepiiI3hUnvFFkUJrIM4HUwVFH
 Upkja/0gVxRtJmolRM1QU/acgAO4UvdZF6cBop2S1i9kUeqCYtW5EpVobUky+orR3RQNSu1Pat
 W60xXCmnOkqSrcp/KBLV5QA7ExkoyjKB8r1ev0Bc50gVOQCAAA=
X-Change-ID: 20241120-xilinx-formats-f71901621833
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Pekka Paalanen <ppaalanen@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7037;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=k4Kr8v8q1FzJJOLJ0lZjjhg5zxTdGMz2I9k2MPOlTAM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp6irw2cDO8cSi4WZXJsExZqMVHBtFBW7a1WDBa
 CLnNMXzBKGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeoq8AAKCRD6PaqMvJYe
 9X5vD/9+mjfe1eJ7O+OfqWBzusLSa6RXJlTyEM7SWHLTxXQBqA8MJElKGqzWsOe2SF3G8CgnqCB
 dXgrbQLP5GQB/eKAvbltWCtaZoQkaTL+EayvQSMZg6vWIkvukyI134syWdJv6oQfiq7+rLh4Cc1
 0er/hagKhVY9njy8zwjawloAXixehcrtsZ2PP40edqTVXY4TfpHeNFxYekViStGeRUUEgMj7aMW
 W+02fzK7pCHKKYGJaVONlZBVm9lrAFQsmdlIavMLxOOuC82VYKAoOROJQvo9hg3XNSry0Xs4653
 SGjSt+W9DZoiw/gcFBTWhWxeFgoLuNqHn9RPDQi0sjou6g4Oslxoof53C5CTlOARqmtXgReE4Lm
 /O5e83U/tKEGUA7+Gsy7D7/84H875r/32VbP/bxMmclD6iAhGhk1v7F20K6RgM/PoWmG4Ihjr5M
 dU1tkhGv0buOEs/YUz46/s7LVBYswu5NJBMKfDKNQ9C244GKeSN0pl1N+g+Wx5jb3MLSbsPY3lN
 9sCPV1tXx4rXqDQIvm8ysHyts7CU/IEErL653UUTxIehiBXVy1C5dkihTw5tbzQJdLycC8fpx8S
 iCCJkImZYnoYHz6BXkzFmWyql0Nf/3uYu07ZX+gYRH1RSTGSig25XWbc8AKXPE/7J+4qo4YY4cY
 aWLwpjqteaGQiJA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

Add new DRM pixel formats and add support for those in the Xilinx zynqmp
display driver.

All other formats except XVUY2101010 are already supported in upstream
gstreamer, but gstreamer's kmssink does not have the support yet, as it
obviously cannot support the formats without kernel having the formats.

Xilinx has support for these formats in their BSP kernel, and Xilinx has
a branch here, adding the support to gstreamer kmssink:

https://github.com/Xilinx/gst-plugins-bad.git xlnx-rebase-v1.18.5

New formats added:

DRM_FORMAT_Y8
- 8-bit Y-only
- fourcc: "GREY"
- gstreamer: GRAY8

DRM_FORMAT_XYYY2101010
- 10-bit Y-only, three pixels packed into 32-bits
- fourcc: "YPA4"
- gstreamer: GRAY10_LE32

DRM_FORMAT_P230
- Like NV16, but with 10-bit components
- fourcc: "P230"
- gstreamer: NV16_10LE32

DRM_FORMAT_T430
- 10-bit planar 4:4:4, with three samples packed into 32-bits
- fourcc: "T430"
- gstreamer: Y444_10LE32

XVUY2101010
- 10-bit 4:4:4, one pixel in 32 bits
- fourcc: "XY30"

Some notes:

I know the 8-bit greyscale format has been discussed before, and the
guidance was to use DRM_FORMAT_R8. While I'm not totally against that, I
would argue that adding DRM_FORMAT_Y8 makes sense, as:

1) We can mark it as 'is_yuv' in the drm_format_info, and this can help
   the drivers handle e.g. full/limited range. Probably some hardware
   handles grayscale as a value used for all RGB components, in which case
   R8 makes sense, but when the hardware handles the Y-only pixels as YCbCr,
   where Cb and Cr are "neutral", it makes more sense to consider the
   format as an YUV format rather than RGB.

2) We can have the same fourcc as in v4l2. While not strictly necessary,
   it's a constant source of confusion when the fourccs differ.

3) It (possibly) makes more sense for the user to use Y8/GREY format
   instead of R8, as, in my experience, the documentation usually refers
   to gray(scale) format or Y-only format.

I have made some adjustments to the formats compared to the Xilinx's
branch. E.g. The DRM_FORMAT_XYYY2101010 format in Xilinx's kmssink uses
fourcc "Y10 ", and DRM_FORMAT_Y10. I didn't like those, as the format is
a packed format, three 10-bit pixels in a 32-bit container, and I think
Y10 means a 10-bit pixel in a 16-bit container. Xilinx also has
XV15/XV20 formats, of which XV15 already exists in the kernel as P030,
and XV20 is added here as P230.

Generally speaking, if someone has good ideas for the format define
names or fourccs, speak up, as it's not easy to invent good names =).
That said, keeping them the same as in the Xilinx trees will, of course,
be slightly easier for the users of Xilinx platforms.

Note: Earlier versions of the series had DRM_FORMAT_Y10_P32, which is
now DRM_FORMAT_XYYY2101010, DRM_FORMAT_XV15, which is now removed as
P030 already exists. DRM_FORMAT_P230 used to be DRM_FORMAT_XV20, and
DRM_FORMAT_T430 used to be DRM_FORMAT_X403.

[1] https://lore.kernel.org/all/20250109150310.219442-26-tzimmermann%40suse.de/
[2] git@github.com:tomba/kmsxx.git xilinx
[3] git@github.com:tomba/pykms.git xilinx
[4] git@github.com:tomba/pixutils.git xilinx

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v10:
- Rename DRM_FORMAT_XV20 to DRM_FORMAT_P230 to be aligned with DRM_FORMAT_P030
- Rename DRM_FORMAT_X403 to DRM_FORMAT_T430
- Link to v9: https://lore.kernel.org/r/20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com

Changes in v9:
- Drop DRM_FORMAT_XV15 as DRM_FORMAT_P030 already exists
- Rename DRM_FORMAT_Y10_P32 to DRM_FORMAT_XYYY2101010
- I kept the Reviewed-bys related to the above, although one could say
  renaming the format names is a substantial change. Ping me if you want
  me to drop the Rb and re-send.
- Link to v8: https://lore.kernel.org/r/20260128-xilinx-formats-v8-0-9ea8adb70269@ideasonboard.com

Changes in v8:
- Expand the "drm/fourcc: Add DRM_FORMAT_Y8" commit description to
  explain the rationale
- Add comment to "drm: xlnx: zynqmp: Add support for Y8 and Y10_P32"
  explainig the Y-only matrix
- Remove extra blank line
- Link to v7: https://lore.kernel.org/r/20251201-xilinx-formats-v7-0-1e1558adfefc@ideasonboard.com

Changes in v7:
- Added Reviewed-bys
- Rebased on v6.18
- Link to v6: https://lore.kernel.org/r/20251001-xilinx-formats-v6-0-014b076b542a@ideasonboard.com

Changes in v6:
- Added tags for reviews
- Rebased on v6.17
- Link to v5: https://lore.kernel.org/r/20250425-xilinx-formats-v5-0-c74263231630@ideasonboard.com

Changes in v5:
- Add comment about Y-only formats, clarifying how the display pipeline
  handles them (they're handled as YCbCr, with Cb and Cr as "neutral")
- Clarify X403 format in the patch description
- Set unused Y-only CSC offsets to 0 (instead of 0x1800).
- Add R-bs
- Link to v4: https://lore.kernel.org/r/20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com

Changes in v4:
- Reformat the drm_format_info entries a bit
- Calculate block size only once in drm_format_info_bpp()
- Declare local variables in separate lines
- Add review tags
- Fix commit message referring to Y10_LE32 (should be Y10_P32)
- Link to v3: https://lore.kernel.org/r/20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com

Changes in v3:
- Drop "drm: xlnx: zynqmp: Fix max dma segment size". It is already
  pushed.
- Add XVUY2101010 format.
- Rename DRM_FORMAT_Y10_LE32 to DRM_FORMAT_Y10_P32.
- Link to v2: https://lore.kernel.org/r/20250115-xilinx-formats-v2-0-160327ca652a@ideasonboard.com

Changes in v2:
- I noticed V4L2 already has fourcc Y10P, referring to MIPI-style packed
  Y10 format. So I changed Y10_LE32 fourcc to YPA4. If logic has any
  relevance here, P means packed, A means 10, 4 means "in 4 bytes".
- Added tags to "Fix max dma segment size" patch
- Updated description for "Add warning for bad bpp"
- Link to v1: https://lore.kernel.org/r/20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com

---
Tomi Valkeinen (11):
      drm/fourcc: Add warning for bad bpp
      drm/fourcc: Add DRM_FORMAT_P230
      drm/fourcc: Add DRM_FORMAT_Y8
      drm/fourcc: Add DRM_FORMAT_XYYY2101010
      drm/fourcc: Add DRM_FORMAT_T430
      drm/fourcc: Add DRM_FORMAT_XVUY2101010
      drm: xlnx: zynqmp: Use drm helpers when calculating buffer sizes
      drm: xlnx: zynqmp: Add support for P030 & P230
      drm: xlnx: zynqmp: Add support for Y8 and XYYY2101010
      drm: xlnx: zynqmp: Add support for T430
      drm: xlnx: zynqmp: Add support for XVUY2101010

 drivers/gpu/drm/drm_fourcc.c       | 25 +++++++++++++++--
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 56 +++++++++++++++++++++++++++++++++++---
 include/uapi/drm/drm_fourcc.h      | 28 +++++++++++++++++++
 3 files changed, 102 insertions(+), 7 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20241120-xilinx-formats-f71901621833

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

