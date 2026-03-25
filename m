Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37AE1093168
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA63F10E7EA;
	Wed, 25 Mar 2026 14:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YZkbyyY5";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DCF010E7E5
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 14:02:03 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D47D326D2;
 Wed, 25 Mar 2026 15:00:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774447244;
 bh=fqZPKR6Q6KDELjHOU7Q0Pc/YYU4uMflGIOIilashYFo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=YZkbyyY5TdXh7ZoEaxlwC0XkQ93rTqb8rxcrJkjJQ7MegugMoqyZlrdWNRJ3QulEV
 ge1DZzc/piE3afNporXjtOGQeX0ycmU3uBGMm4sINSlY7IQJvSwtyw6MI/fzW0Ip0Q
 Bx0lsZz8i8rWom+DrXuzMWnGHcsxwpDP7DAP79x0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 25 Mar 2026 16:01:33 +0200
Subject: [PATCH v9 10/11] drm: xlnx: zynqmp: Add support for X403
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-xilinx-formats-v9-10-d03b7e3752e4@ideasonboard.com>
References: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
In-Reply-To: <20260325-xilinx-formats-v9-0-d03b7e3752e4@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=883;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=fqZPKR6Q6KDELjHOU7Q0Pc/YYU4uMflGIOIilashYFo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpw+rN2iDYDg4w/tOHRba5V1wo6y9obEniMtkMH
 du9w8agTxyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacPqzQAKCRD6PaqMvJYe
 9eySD/4ieq+ip6Q+9yWuULJYRON00QTjPQBw8pe4fJNdhUJj7d1qXkWDv7NIAsz9HgPDfxe5C6P
 0y4mNqlIN/md70P8g+0pEvEJEne5sduWO4WT1x3+JSXPwZ43KdcLqTfHgvW9pUKtxpLxPQn9ZG3
 uxZ7yxaYXf2WXTCsoAwxZWlq9p7gOlGeYUHvYJdB8FTdSpxAxEbhTOLRUtkHhRftASEDFlEQd74
 QUpVkz8zhk20S9+BB0uzfmQ7OdJUcG0Aj+g/nhmkYwHgakhIlMTJ3+hYnQgFypOtt7+KQXe7iwz
 rVih55r6DmWEWGQ+8Z/Su2PDPzlSjM4WsjWpDN2dDV94IwOyyGSRmD4Hwh/2SKa2sIH0BDfLofm
 w/pA1wLqwuUj10Wv7qTwBQKc2xcgLEZAsYslFMLEVUwwh9BoSNr5/jg9zakFgZ6dgTHiYoH9ZXa
 kwyk94fWQ6NazK3B8pt98aTHizKGdjUZ06EBT+WMdYVBQCbglhB1mukJe1H573mXuQr7+rH/wyV
 04ODQPmCCcmnZQPL4QSjr2WDx0YInDReqEVd9BsKMtWJbGR6yIoevNTWQ7R0J0KG86jSdK+Qw9z
 DfS4J+ZKtHDLCycp+tGzZPwqCRJGaLJOs2x9dBylpu55o5LtA5+ctJeCOE07TRk+oNjbBw1VJfm
 oiCe5893KMP1zcg==
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

Add support for X403 format.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Vishal Sagar <vishal.sagar@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 99bc68481020..eed0215ba7c7 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -317,6 +317,11 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YONLY_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_X403,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV24_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0

