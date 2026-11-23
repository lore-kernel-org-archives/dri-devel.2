Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF6606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MVPfbzAj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A855A10EF67;
	Mon, 23 Nov 2026 16:21:08 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3FE10EF80
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:21:03 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-491971ac844so3229202f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795450861; x=1796055661; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YzubQEnjwJsrBu2RrZ0qMrb2/G0AODdy9U67Pg3rZzU=;
 b=MVPfbzAjKY+A8PhacmcWA+Tjme5Y2DUdRT//SOLwn0QjGG4T9aLIZpNO5+woB5f/y4
 6C+I/yMHO0gjKiLPZZHsttOTW80drJZqGsLpjmPxO2H6BkemRZ84sWMYD4jeSlDY1hh4
 HTIv3GXGUDo8giSV4o9xp5GWqknMtlnkK0MtCsGWJNEr9dvCOzSvaGlqBaOJGN6URL32
 deiwgxdMGxHx/ucKMFC1SOHLq3b4/ug1hmW2sPVDvt4n7rpGvXANuyG2zgpmrvuzCJO+
 Nu7EMCrJ/4WtpPYyTvL660eKRojjEMlXM8svLsBcAQlGkp4RDw4Ti28ISP1avk6lsOGK
 6wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450861; x=1796055661;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YzubQEnjwJsrBu2RrZ0qMrb2/G0AODdy9U67Pg3rZzU=;
 b=nxF4kC+0iChbaB4bqNwQuoqwD+9AGvHbUvghdb7efk/CuVOhxC2uCQJTj60RMr/OwU
 ukD37arwZaZ6X9MaOohUutt/51XR0SLYyzq4XiGK/WoeNbxcxUTajFd9SSbR7leAAqP6
 Xd0zhUQNAHFRYu1JSm7GMA65EjKwXdZEbpCCQvfwG231CrcuESwL1hWiIEol4ftLqZGc
 kt+JOK/57AL8pPwRZ+/BgH39aeJwhVg62cUKoV6jMskLcmCPvibBCOv1ueuDhPC/TRf0
 se9k4pb3AdVfif9rLDUW785boXYmf0+kDjPOBoALysWir3gjBMr3xMqt5HPh0cVfovjq
 kpLg==
X-Gm-Message-State: APuU4Z+zYOJ35SqaKHf+DOMm0S5ZY5Bow4w+/7QbmZZDIkZCBlQO5UFQ
 yQ0EOOwSfp/1ZCYqgwxKU7DC+vrQeXI6ITM6k5BScISBRWRNgZXFLlfO
X-Gm-Gg: AZFdTZcHWymQY8hOtwI2VDVK6/JINoCSV8u+EQ61zcsZd0U4eoxRFjptxJyqN28yASy
 +jeq49VRHbIwCeSLJsyfEhL+lDdlaWed0O3WRNwQsID8yHn6QboUzuTmLL2N0b6uRyVNNpWEaq9
 9/Fq5TBocPxA8xUOMjk8JjZx8wBQdTFI+rH1w7b8sKUrVtiYSuBut1wYShNpVTd788OV1Ddp/8V
 hQASCrYSSklCjY0R5zBG0Yy2kLeW+dzN7KQZlwko0xnsrjLtSI2jXyr6f/3/291NfRb9DGcO1NK
 UBUwwp2+3uq/jSoDlugDB7GfyjPwWBy6EnkEa4n6C2QxntEQ8wGfHk+FTrD8YAKIUsHGryv33gk
 YCR9L5SOzcM/DbAnvKm8yVvDKVeuaZeyJoO4ZxiFh1t6dvLZptPCUcAiO/tYtNCoUZFyWIjtOvA
 3PZ/h2eTWKz5Zk9ePFvszP2TVh3NuebtyApmkI6SY0m3VxhFv5rOrkpnGm/Kl2IgGV8pqrnAbVi
 8uBWyZkmME/POHbBS6ilKZpgPBrShAF138i9dyXyFmofqcKe8qDvq8e0oNK5ctJzwwmt+Q5nRVN
 0QhNowvj/1IoPRA5iFMkg9+BMd1XJZRo/m2bwIDNxJ42B8d7L2xUSQqtCLJ85g==
X-Received: by 2002:a05:6000:29cc:b0:4a9:32c9:a6c with SMTP id
 ffacd0b85a97d-4abb43deca6mr14713618f8f.50.1795450861461; 
 Mon, 23 Nov 2026 08:21:01 -0800 (PST)
Received: from [10.56.169.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110ba3sm18863696f8f.35.2026.11.23.08.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:21:00 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Mon, 23 Nov 2026 17:20:26 +0100
Subject: [PATCH RESEND 1/4] drm/vkms: use the gamma LUT of the state being
 composed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-lut-v1-1-5556c89a2ebd@gmail.com>
References: <20261123-lut-v1-0-5556c89a2ebd@gmail.com>
In-Reply-To: <20261123-lut-v1-0-5556c89a2ebd@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Arthur Grillo <arthurgrillo@riseup.net>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Oarora Etimis <oaroraetimis@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The worker can fall behind a commit, so crtc->state may be newer than the
state the frame is built from, and the frame would mix planes of one state
with the LUT of another. Take the LUT from crtc_state->base.gamma_lut.

Clear lut_length and channel_value2index_ratio in the else branch as well,
so that gamma_lut is either complete or entirely empty. Nothing reads them
while base is NULL - apply_lut() returns on that - but the next patch
decides whether to rebuild its table from lut_length alone, and a non-zero
length next to a NULL base would have it build from a NULL LUT.

A zero-length blob takes that branch too. It used to leave lut_length at 0
and channel_value2index_ratio at drm_fixp_div(-1, 0xffff), which nothing
read either.

Fixes: db1f254f2cfa ("drm/vkms: Add support to 1D gamma LUT")
Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 0fc915a954ba..1d5658bbd493 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -609,6 +609,7 @@ void vkms_composer_worker(struct work_struct *work)
 							  struct vkms_crtc_state,
 							  composer_work);
 	struct drm_crtc *crtc = crtc_state->base.crtc;
+	struct drm_property_blob *gamma_lut = crtc_state->base.gamma_lut;
 	struct vkms_writeback_job *active_wb = crtc_state->active_writeback;
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
 	bool crc_pending, wb_pending;
@@ -625,19 +626,22 @@ void vkms_composer_worker(struct work_struct *work)
 	crtc_state->frame_end = 0;
 	crtc_state->crc_pending = false;
 
-	if (crtc->state->gamma_lut) {
+	/* crtc->state may be newer than the state this frame is built from. */
+	if (gamma_lut && gamma_lut->length) {
 		s64 max_lut_index_fp;
 		s64 u16_max_fp = drm_int2fixp(0xffff);
 
-		crtc_state->gamma_lut.base = (struct drm_color_lut *)crtc->state->gamma_lut->data;
+		crtc_state->gamma_lut.base = (struct drm_color_lut *)gamma_lut->data;
 		crtc_state->gamma_lut.lut_length =
-			crtc->state->gamma_lut->length / sizeof(struct drm_color_lut);
+			gamma_lut->length / sizeof(struct drm_color_lut);
 		max_lut_index_fp = drm_int2fixp(crtc_state->gamma_lut.lut_length - 1);
 		crtc_state->gamma_lut.channel_value2index_ratio = drm_fixp_div(max_lut_index_fp,
 									       u16_max_fp);
 
 	} else {
 		crtc_state->gamma_lut.base = NULL;
+		crtc_state->gamma_lut.lut_length = 0;
+		crtc_state->gamma_lut.channel_value2index_ratio = 0;
 	}
 
 	spin_unlock_irq(&out->composer_lock);

-- 
2.56.1

