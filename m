Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB25C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4E8B10E95F;
	Mon, 13 Jul 2026 12:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RsF85VDy";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA06610E962
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:12:04 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso45631995ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944724; x=1784549524; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yPxreeozyC9OlzBX8SeJZagWhfw9u0AGRhVPID7x7h0=;
 b=RsF85VDyhjZom//9oz1rx59zF/cMZXCvFewGcjfDKSC68qCWuHir/uQskXscieeKmk
 AU4spzU9s+wAENmOgePsngO98w+bOO1VoccILWxThIb7YHN6FwgI+LS1DL0dvRFJtdX0
 8WE+5P+LXb+5ddGwylFQlxUDJUNMXx5//2GpHxFT/DJW6wlhE8NQy1vHJhlXPK/VbG67
 WcN20hIr93a2VrcQ17hBMXTL2G8oL/cJeM2ZbEEvCCLac0vxq9b1PmNPXBjszdMFKEyb
 8h1RF94G5DaRWUwG6wkQ3Z+qRSpcs7uPd/B+UFm6aDHvgi4sMri+Yf2QzD+/kf4sCJtx
 Pdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944724; x=1784549524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yPxreeozyC9OlzBX8SeJZagWhfw9u0AGRhVPID7x7h0=;
 b=fQSJDuSWZkw6U2Cz6a3+NCBPF8OZQVzBCrBDLUbZQKG7e3A8Na6vWss1rd7QySEq+S
 d0hHz23zhQUniy6nc9AwyXPWA4SuuMXHm9P7mNCUZ+qNZkk/auTlYm5INGZu2xpRdxcw
 V85kL9iYkmpLgXetxvMQ7KfNalAvJTuSB1MB+mkHismck2+KaQ5FE/wuKRWvJN0dU4mq
 1rhpamBUFxp0omb3f3lbLqZQKPSZ0BcEHMOy9wE+MDhr+0jk4Jt95qWpgiO/vp4neXL7
 /xnMFDlIvkgY2VY5DRjX7h1AXwzw29skdw2pjNJnGqOisjUPF9RGuUoQ8lDyQoYK5xJS
 YCsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKlNzFMK5u86V28bfSmE9fvBTxRRPfrBIeiQSJNZ0nEv87oFEkO1gYaoPSgH7upxHgjn+jaGnKIAc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFIqam/ENR4XjLbqPNF3c13lEmtmOa7MsK22chudztKEpBf6a+
 LX1V3A3jnZxgylEohsKPlVHJwkhU9wklpxiXUFHcVxElfHXXkilDwi5f
X-Gm-Gg: AfdE7cngMMxL56nxliDU/O6E4gKk4oanCr7FRjs8jrJhjop51ms0qABqwhV+ru8DLT+
 DeHXMVD5dRACpN3Fosh0/5O6DNLnkNXq+7urIjOZUM3Dcnr1qhgO7NvKuRTtKpPtn3w8S4QKPSn
 wjadxtxbLFOxE8YFzr37spVA3TvJgRKkZHdSz8qbIsxBMV1ZWayTbSFqneHh2OZti11FJX6gnr7
 EMBye+7ZON8tlSfEIkEIJHv+0alKAnpqQsPpj55dR7TT3VM1JxGAzZncDbiWfAuuRb9voU9+wxc
 04PVdIpOonnuRzfUfjKCqhspxgCp0ffNDY+8kiSBdMvVUhqGJ+apqD5/mxjq7SbHsbPac5uJ5Gr
 8gRysYjK7XHWJPq3kU6CXN0sXDDGXxLQoPd2zaMhGs6vUtXBPa/J6v47s09zAKaiBt5ptjCqMgC
 hhR47VuA0vGqyNbLNkC6QvKVbRl+PkI8c=
X-Received: by 2002:a17:90b:4cc7:b0:36b:b903:994 with SMTP id
 98e67ed59e1d1-38d13768de2mr15332791a91.4.1783944724165; 
 Mon, 13 Jul 2026 05:12:04 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:12:03 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>,
 Nicolas Dufresne <nicolas@ndufresne.ca>
Subject: [PATCH v7 18/19] media: meson: vdec: Increase VIFIFO buffer size to
 32 MiB
Date: Mon, 13 Jul 2026 17:37:13 +0530
Message-ID: <20260713120840.17427-19-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713120840.17427-1-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
MIME-Version: 1.0
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

During 4K video playback, the hardware Elementary Stream Parser (esparser)
can rapidly push massive burst data payloads into the Video Input FIFO
faster than the VPU decoding block can consume it. This causes a buffer
overflow when stream usage breaks past the allocated hardware boundary:

[ 1852.587956] meson-vdec ff620000.video-decoder: VIFIFO usage (16779003) > VIFIFO size (16777216)

When this overflow happens on Amlogic SoCs, it triggers an invalid memory
state, leading to stream corruption and fatal kernel panic lockups within
videobuf2 error rollback handling routines.

Double the parsed bitstream swap exchange memory pool (SIZE_VIFIFO) from
16 MiB (SZ_16M) to 32 MiB (SZ_32M). This provides a larger canvas window
to cushion high-frequency frame reordering spikes and prevents the VPU
from crashing on demanding modern streams.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index d33cbebc4453b..824e2f156adeb 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -29,8 +29,8 @@ struct dummy_buf {
 	struct list_head list;
 };
 
-/* 16 MiB for parsed bitstream swap exchange */
-#define SIZE_VIFIFO SZ_16M
+/* 32 MiB for parsed bitstream swap exchange */
+#define SIZE_VIFIFO SZ_32M
 
 static void vdec_free_canvas(struct amvdec_session *sess);
 static void vdec_reset_timestamps(struct amvdec_session *sess);
-- 
2.50.1

