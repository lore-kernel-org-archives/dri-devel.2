Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5C4106B53F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F77710E0A6;
	Wed, 25 Mar 2026 14:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kSb8hMGg";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B51810E0A6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:01:53 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B67FD10BE;
 Wed, 25 Mar 2026 15:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774447233;
 bh=LD2CybU1z3jPpsgDt2dZl+d0WdRNuezVNGYgJdxz5Ak=;
 h=From:Subject:Date:To:Cc:From;
 b=kSb8hMGgq6nMF0gIda6mbeYkbrh584sTNjR7B/e8WB9GlvczSfnvVSm9j6SRVKOCD
 n052KfNCQLuy8bpIiVwbdI/d/PRezgioVosIaLP1A+Yn6Z+twMhvk/QsZ0CIiK+qMP
 d7EmxHK6R6L2PDcNf+8NhFF6r0gEZXaUeFsPktQs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v9 00/11] drm: Add new pixel formats for Xilinx Zynqmp
Date: Wed, 25 Mar 2026 16:01:23 +0200
Message-Id: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALTqw2kC/3XQy2rDMBAF0F8JWtdlZvSyuup/lC5kPRpBYxc5G
 JeQf6+ckhqqaHmHmQNzL2wOOYWZvRwuLIclzWkaSzBPB+aOdvwIXfIlMwISiATdmj7TuHZxyid
 7nruo0QAqwp5zVo6+cohpvYFv7yUf03ye8vfNX3Cb/lIE4j+1YAcdDJGcRKH9gK/JBztP4zDZ7
 J/ddGKbuNBdkYAoK4WKggo4aWeVJNtQ+K4QUqXwohjwEAOCMkY2FLErnFSliKJwIssBnPKaGor
 cFUH1R7IoTgtSnDgqDg1F/SkIgJWitnZRDKDVIEWzF70r9EDRW7sBpeytjyG6htLfFQVIfaX0W
 7vBFmPQZcc8UK7X6w/0/pLPnQIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6695;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=LD2CybU1z3jPpsgDt2dZl+d0WdRNuezVNGYgJdxz5Ak=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpw+rHCHAJjSXGM/ajXUfKyp45eyF0JiuCoPsxv
 UxZ2hpvbwCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacPqxwAKCRD6PaqMvJYe
 9bLCD/0aekdS4Ao1vRQACisOri9eHHv0UKAlJ1jR6iOGwJkNiqq9dRSS1shwIu+ckGkZQouvwBU
 tq5ppI41nO+FYpcT/1JA/AXhkSKY3tHBQeMa6Vz1qM3q9lPZFddMqii9NntvvdV5iEFPwMJ/rrQ
 ep64eYGhm/gp/RBRCXwGdXP9gQzl2hHLuOmg6xSNmbyGWpn2pX34hDyP5Nb2g0OZqywRFpI2UVV
 KzK4DFaaxqZo+LRgwSxXPQboRNpQvihBkWD0MneuCkJBuNpPh5wrLhHySMN1S8F/ut0lnrkiXv4
 8fcDF/fiWfu8ujLH4Yl7GICljpGIDil4tE7l27amBb9dcYEIE1UeweuMIum9Bvgsq83vS3GGOqZ
 U/E7MfnxpBSkvVL6e50ZWgj6MNP48TP+RPvUFs4X+jixTbe1FWUhuMwoKKyn0FOxE7ZIWY5Ywh3
 hEt4o3csWTqR69Jkxf0q6AHhVIFmHy6Mz+kxGma/tffkY4yXo50Yw42G7tAGbqhnvB4ylWc2k7k
 I0ILozZCUEVCvZMzAYNoFvP0hF28oetXyw7vCelXn6Q0uea2enk3KG8M+NYf8KR1cVqnOarAsC5
 56h5m2Hp3ySAGNaGC33WS377T8R7bVxyF3cy8thoSGGMJto935q+up2VLSpqUpOn1GIBlBDoOTY
 /0KczdMTp6cR7QA==
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

DRM_FORMAT_XV20
- Like NV16, but with 10-bit components
- fourcc: "XV20"
- gstreamer: NV16_10LE32

DRM_FORMAT_X403
- 10-bit planar 4:4:4, with three samples packed into 32-bits
- fourcc: "X403"
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
Y10 means a 10-bit pixel in a 16-bit container. Xilinx also has XV15
format (similar to XV20, but 2x2 subsampled), which already exists in
the kernel as P030.

Generally speaking, if someone has good ideas for the format define
names or fourccs, speak up, as it's not easy to invent good names =).
That said, keeping them the same as in the Xilinx trees will, of course,
be slightly easier for the users of Xilinx platforms.

Note: Earlier versions of the series had DRM_FORMAT_Y10_P32, which is
now DRM_FORMAT_XYYY2101010, and DRM_FORMAT_XV15, which is now removed as
P030 already exists.

[1] https://lore.kernel.org/all/20250109150310.219442-26-tzimmermann%40suse.de/
[2] git@github.com:tomba/kmsxx.git xilinx
[3] git@github.com:tomba/pykms.git xilinx
[4] git@github.com:tomba/pixutils.git xilinx

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
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
      drm/fourcc: Add DRM_FORMAT_XV20
      drm/fourcc: Add DRM_FORMAT_Y8
      drm/fourcc: Add DRM_FORMAT_XYYY2101010
      drm/fourcc: Add DRM_FORMAT_X403
      drm/fourcc: Add DRM_FORMAT_XVUY2101010
      drm: xlnx: zynqmp: Use drm helpers when calculating buffer sizes
      drm: xlnx: zynqmp: Add support for P030 & XV20
      drm: xlnx: zynqmp: Add support for Y8 and XYYY2101010
      drm: xlnx: zynqmp: Add support for X403
      drm: xlnx: zynqmp: Add support for XVUY2101010

 drivers/gpu/drm/drm_fourcc.c       | 25 +++++++++++++++--
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 56 +++++++++++++++++++++++++++++++++++---
 include/uapi/drm/drm_fourcc.h      | 27 ++++++++++++++++++
 3 files changed, 101 insertions(+), 7 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20241120-xilinx-formats-f71901621833

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

