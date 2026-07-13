Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E29C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175D210E956;
	Mon, 13 Jul 2026 12:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VaL99/VO";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F1010E956
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:10:29 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-84862b0d5aeso3049423b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944629; x=1784549429; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0g+WRe3x8NF1Lsmp6BpHJTM0uwdyJj9zKy0hm9x5WoY=;
 b=VaL99/VOgkLOTh4Uy6yZm0qlB2aR1IbQBMQp4FTAk1Ja8aoEhtvfzcTHOYNHYrxB+d
 kWk32jVQY0dwCmXozPgQNdkLXuSHob0Omtb/fp/9kPFxeDQZWt7INeRco6pPFm4TTQLP
 MKY4UohcGhHY7u2a8gKjxTM9GeC5xn2oavGkiyjPKCVscxnrmm84d9YyujwAPy3NPM05
 B5d22NjIInRcchSvIX+KQaLBWjxd0nGoINVEy7Uz0uOUr0V11PJw0WzM30e7yyl6LjMo
 8BQC/ipxtrNiIW7rF4zetgUrZXlC637LuNBepyh8tG4vvnayV6NhWX0YdfwoHrvCuUcG
 /RfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944629; x=1784549429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0g+WRe3x8NF1Lsmp6BpHJTM0uwdyJj9zKy0hm9x5WoY=;
 b=MsdXCJXsuk2/wSSNnKQOZ6EKfmbVKsixoCvhAO0sGhYLJ5G5gcOG26UCFYyksoUjnW
 S4dkuTYq20lyBDFNL/a8VMyI+khtQZRUUtGgQnESu1aHFFK6EKhlOogjQNQ9xHCs2EpU
 vJV/z9X61hi+5bVf6qoX7Nt36nY7ELLI5de1WbvR9ZX7dwHI11n/aSQ2/Vu3SAODH0Fz
 ZgNdiIft1qIpwEa0U/sEzBWtf9NnkSwF/l8UoDquOXPlBH0CGwlbWdcD4E3sPzLoY3Bm
 AevNDyzdLDTztVChw981nOF4X3dx/LMnYqjXAm2JW4Yx84rnRd+Tl87LYiUDkMcqTavN
 nrig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0AWvk6aOrfkvZ7TD4wBuYfPJWWtb4g8UioTyNiLUH9+5i/k3LBd8qQwUBChf/bekto/sI3g2XfaA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwQV1dzZgn5fZNn9Z3+tuDkwf7NO7nG6GJxR64iqi/Pu4sJler2
 eeL9jca6xSu/N3XJ1rfOKLlTMClJBvcfzA2T9nR9A5QZ0o6yG3PVV+l4
X-Gm-Gg: AfdE7cmbkP/dQdAaorXnr8YMJZv3HhDXuWu3SbIA9JqZw4jadt8uxTcoHG01xSa0u46
 DrQqJA7FEH6587yhNcIPU/2XdfGOyR41eG2skP0AvH5duCzJL5KRVM2kQ1wzWTSF7VjEIdMMTGw
 nNmcclkRDMq+SCVDGl1+qMtYjQsd4E0MAcfYC2XUwCZnDm39P60V2tbYq0y/E+aBGNJzO1IO0Tx
 kzDYk4cE3UwGZJRprJsR48TEksLlaZ7loA9iLxKrSzgNdE9hlZ4knHkohmHOoiryQqMZwqU2UFQ
 77pycu3U/oNS7FlphhMGmTwLSoTq3lq1rIcRXaXUuWtOj5DD46ey97KFzRq9mWWS7U8mDr7oMFD
 utm61sTq24jbSImyklWxgUsP6AXhd5beUPhyJuBVw6U0iRLZjSjbgzw9LnIOqIB04XoXDhtfX5R
 U//NpyKmCAJ4ndF6my22mN
X-Received: by 2002:a05:6a21:6088:b0:3bf:9fc0:f6c2 with SMTP id
 adf61e73a8af0-3c1109ec872mr8713076637.11.1783944629120; 
 Mon, 13 Jul 2026 05:10:29 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:10:28 -0700 (PDT)
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
Subject: [PATCH v7 09/19] media: meson: vdec: Fix vp9 header update failure on
 invalid payloads
Date: Mon, 13 Jul 2026 17:37:04 +0530
Message-ID: <20260713120840.17427-10-linux.amoon@gmail.com>
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

Ensure vp9_update_header() returns an explicit error code on invalid or
malformed buffer payloads instead of silently returning zero.

When v4l2-compliance injects short, empty, or uninitialized test buffers,
the validation logic catches the out-of-bounds size anomalies, but
returning 0 tricks the calling esparser infrastructure into treating
it as a successful 0-byte header conversion. This causes the hardware
decoder engine to stall out, resulting in subsequent stream-on timeouts
and failure marks inside v4l2-test-buffers.cpp.

Fix this by returning -EINVAL across all validation and bounds check
failures to force immediate core framework buffer drops. Additionally,
tighten array pointer checks, secure the mag_ptr bounds loop, and
convert the superframe parsing indexer into an explicit if/else block
for readability.

Cc: Nicolas Dufresne <nicolas@ndufresne.ca>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/staging/media/meson/vdec/esparser.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index 959673742e699..edbfc829e2da8 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -97,11 +97,15 @@ static int vp9_update_header(struct amvdec_core *core, struct vb2_buffer *buf)
 	unsigned char *old_header = NULL;
 
 	dp = (uint8_t *)vb2_plane_vaddr(buf, 0);
+	if (!dp)
+		return -EINVAL;
+
 	dsize = vb2_get_plane_payload(buf, 0);
 
-	if (dsize == vb2_plane_size(buf, 0)) {
-		dev_warn(core->dev, "%s: unable to update header\n", __func__);
-		return 0;
+	if (dsize <= 0 || dsize > vb2_plane_size(buf, 0)) {
+		dev_warn(core->dev, "%s: invalid payload size %d\n",
+			 __func__, dsize);
+		return -EINVAL;
 	}
 
 	marker = dp[dsize - 1];
@@ -109,13 +113,16 @@ static int vp9_update_header(struct amvdec_core *core, struct vb2_buffer *buf)
 		num_frames = (marker & 0x7) + 1;
 		mag = ((marker >> 3) & 0x3) + 1;
 		mag_ptr = dsize - mag * num_frames - 2;
-		if (dp[mag_ptr] != marker)
-			return 0;
+		if (mag_ptr < 0 || dp[mag_ptr] != marker)
+			return -EINVAL;
 
 		mag_ptr++;
 		for (cur_frame = 0; cur_frame < num_frames; cur_frame++) {
 			frame_size[cur_frame] = 0;
 			for (cur_mag = 0; cur_mag < mag; cur_mag++) {
+				if (mag_ptr >= dsize)
+					return -EINVAL;
+
 				frame_size[cur_frame] |=
 					(dp[mag_ptr] << (cur_mag * 8));
 				mag_ptr++;
@@ -140,7 +147,7 @@ static int vp9_update_header(struct amvdec_core *core, struct vb2_buffer *buf)
 
 	if (new_frame_size >= vb2_plane_size(buf, 0)) {
 		dev_warn(core->dev, "%s: unable to update header\n", __func__);
-		return 0;
+		return -ENOMEM;
 	}
 
 	for (cur_frame = num_frames - 1; cur_frame >= 0; cur_frame--) {
-- 
2.50.1

