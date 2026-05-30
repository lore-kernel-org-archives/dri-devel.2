Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB75CD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 13:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65619112B6C;
	Sun, 31 May 2026 13:59:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qce3qvBR";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F0FE112742
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 09:44:43 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2bd2051167eso73301305ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 02:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780134283; x=1780739083; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Je0r03zFWDk/tHsmcp50GPWfnKiSAfNBSvNM4tTawBM=;
 b=Qce3qvBRh6kWBpqEONR4QTJnUjl4puqeS8xr/+K2WhYH3rQaz0zNOawgQy5Hz95xm9
 A0hFmNtcaEtHZ4jH/vZ3nclKyGRc5X1UIqxJSS1s2Ad1fwsLrafSsMoxpufc+Cv6oAV5
 3tLNtbaiXqeVSZCh2UkSyoKbM0l0Iekvaq7vQUy32N30MA9dkQ4CXjSAGt7fixNesbrD
 w5i3OM9QapQO5MkD55IxFtCeFUHNI89bfT+XyyncMKAG7M/r5g/KdgO6w9Sm6u4zeqp3
 F+2JBjvDhUuF/uFLDYVykrWWonIACuMlY3g3HRpFTak9kW1ftPz0f2HOWNTGUZhF3fj9
 MJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780134283; x=1780739083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Je0r03zFWDk/tHsmcp50GPWfnKiSAfNBSvNM4tTawBM=;
 b=eRzVikzp5OoVf22MRj4EIgzEEve2I7inhwt56OT4X2mYQBEhnoaWEKGpxNRQNAjoa5
 6Vrv5t2hValJTWNEicqeLz8Aw3xW0YC43xuNsj5+2aqYdtpGiD5aoOJbVQ2Mb0U4bshg
 wWHhJVmFI8OF7hvtFYXCFgrcWRB/68FYItAqO0EQgN+QIgXDqut/cUUQw1x0rSFgKwch
 eKcGwqIHh0UjFN8UxXKcdUgUM7eoRvwUmf+93bmAcQZ+PySUdSoMgbi9bm18CD7PD8ad
 RP0MgC1tZ95B+ZtVbYO68wu9V4zv/Ey1lYRaRxqRFWkd/GC+9FhHvWTJ+ol2GSsC+OFc
 BmOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Qce8Dt3RawQ2Jn/e0bp+jQSto0vGu23zUDlwqLdrj/hl3fJUH80EQKKeEfc4ofeRzsLkoWDepCyY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0HrYpXsepy253hYGgoFb/fMQevEAlkGDS81dfwveobDDLB+m0
 Kcd/I3Uv78Cws3WGY95aqfzISw1ZbgDy/91KJ0pKIgGk4x1oI8TYXZxC
X-Gm-Gg: Acq92OHukabPiBeuHNyqz4Ey1NNshZoQ/ZLD6zoJxoJKjL6GFibdks3vbc1pLV4h682
 8+zcU/nwrtdpHEmCS1FJ+meVB3SHkZwfTO0uAXYj8qtwb6kUqqDRInVtWaUoSrKhtI5XFbO0vN6
 kBvGrZ+hQ9UMS4QAy5oAIkDiOiPuYiptzIUGCP/QdIl3dnUvTEHHDxoxRtBoevBhQcYmM1fkZpV
 uW2k8spdHLosZj99hQfRhLQ5SKnkbG98NVTdwlirDeeLAbXnqLLvgGHV+aMZKOIdyX+ye7pASkd
 Dh9fKtOxX8/5SK+opkd6f2hUJ127BB9tlMIPtx3VtaU5kXfwvrxxR2aKJFFainphYzFzYXW6hOQ
 l/by+rITr9WjkO0+CR3vsCjr8TAhzEdfW2pImfhnf7w3scJgLODed+qE6ePH1nqtqyYX1zkDIij
 YetH85ht9IlEBzFTqEa0Lc7FaBx8GduZ1ETRlvLCPwCg==
X-Received: by 2002:a17:903:2450:b0:2bc:e2ed:fd03 with SMTP id
 d9443c01a7336-2bf368a3dabmr36524785ad.39.1780134283084; 
 Sat, 30 May 2026 02:44:43 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e700csm61529945ad.10.2026.05.30.02.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 02:44:42 -0700 (PDT)
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
 Maxime Jourdan <mjourdan@baylibre.com>, Hans Verkuil <hverkuil@kernel.org>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v6 4/8] media: meson: vdec: Condition buffer flushing on queue
 type in start_streaming
Date: Sat, 30 May 2026 15:12:50 +0530
Message-ID: <20260530094326.11892-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260530094326.11892-1-linux.amoon@gmail.com>
References: <20260530094326.11892-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:31 +0000
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

When vdec_start_streaming() fails, the error path clears buffers from both
the source and destination queues unconditionally. If one queue was already
streaming successfully from a prior invocation, flushing its buffers behind
its back leaves videobuf2 deadlocked waiting for completions.

Fix this by only sweeping buffers from the specific queue type container
that failed to initialize.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel.org/
Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/vdec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 8a5bf1a96830..698a95566ad2 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -386,15 +386,15 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	sess->status = STATUS_STOPPED;
 	mutex_unlock(&core->lock);
 
-	while ((buf = v4l2_m2m_src_buf_remove(sess->m2m_ctx)))
-		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
-	while ((buf = v4l2_m2m_dst_buf_remove(sess->m2m_ctx)))
-		v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
-
-	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+	if (q->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		sess->streamon_out = 0;
-	else
+		while ((buf = v4l2_m2m_src_buf_remove(sess->m2m_ctx)))
+			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
+	} else {
 		sess->streamon_cap = 0;
+		while ((buf = v4l2_m2m_dst_buf_remove(sess->m2m_ctx)))
+			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
+	}
 
 	return ret;
 }
-- 
2.50.1

