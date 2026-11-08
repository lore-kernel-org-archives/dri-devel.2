Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B14606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R8Ub8cdV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7864610E826;
	Sun,  8 Nov 2026 19:33:30 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02ECA10E826
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 19:33:24 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so1327055e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 11:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794166403; x=1794771203; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eVRDROiDIUNDs50key7MrVecbdDqxRi5PolkiFkUUc0=;
 b=R8Ub8cdVBCRsXEwCVZ7Kf40U1lYZ5VUTCGc07itl/Vz+Wfj1VZ2W4+7uo2zoNuwYVs
 GN9ET/+MySJ69YZpsFGGm0LZZNzAcDIDBq0jpgBivwMSPqfCrdzPe5yVAJAy903rYjKW
 M+D4ItKPgkPcXE1UVpHm/ldKVYWaoLSbIDJeSXaR9BSzVPgR/ytuuy5/c4FFOc3hU6OZ
 qKCHOo/gIk4ePeW1ZNRKV9Jd/adbl+l6ovtD7kgvW9N3q2wT9/c8AOAKlQ+9aD08slY1
 0Gf/VRxd8N07FK8XK5KcH9beiHSTLsB1UNf/311XLmjOSFPKOA3h9HmU8qCdYwbhn/vT
 iERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794166403; x=1794771203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eVRDROiDIUNDs50key7MrVecbdDqxRi5PolkiFkUUc0=;
 b=jYBm6V0MS0XFq/uTTv8lu/UYx6er03wlVwefI6M49CdoKmuqQ0Xz7Weq52+SwyWOVJ
 ZUQ37yeH68S6t6vxDGZjqzToWRtrdbG4XJe6Iou3HyfWNIHmHbFiSwlmJehNNEwtugdW
 apbrEQkOz3JXUVWQufSVGiEMQ1NtWOUi3FrCsvLYRkyqVJ7Kdh7eC8/2HTu9G/iWCD/I
 H4JKtCkcmHW5239xd8iqNqFrKlzqamFwgqDvkFqIm1ccqcE8K6G7dpfqisGSp7nQz3v2
 Sb47jJ6oN7VSgbWG5uUHGz8SA54ZY4WNs6RkroV5hHhvEAPQnYYKLAwyLzYxbx2WW03x
 T5Dg==
X-Gm-Message-State: APuU4Z+p7ZARCh4vIrXg8mLHlLGsQraAWnV48V+v3RlC/AZI4QlFFAIM
 mXG9//QrhqJphfC7DL25w2CDIjZDwpkixKui55z+LIyM6roc27iwziDZ
X-Gm-Gg: AYBFou16D7jeN8gLsn65K61qEs/mR41vd8Yq9SNtGZvWV0h/PEQH0KE3yG2FrnCsccj
 5nnn76QbHxQ0qqVf4SM217EhVUvPkU4u5grgx1Bm7cfFF1twWnd7QQq2STbIxL0NvG1ZmJKO5AO
 VbZk4vbSUthgejkN4ips0KMIlFpnMc0f4GUYm1prhp3Joyf9m5FzKMblieAXbjEDP9Da75YV7Q+
 wjjvYBp745/TpznHvPsSUdQ/y7b5B3jUi/cSkQ9KYp2vsEQmxjtdtNXJlpITbrG4mj5uJwErbCT
 HSAxR0sbCCMdTOObvFNy2sS9azT0EJcOEFri+/LJ7/pAvLr/HKUASwptcFc+jejhNmZec2WjyHS
 SKddjOTHSV6zINUHEf6POf1ztf2pxj/oEecLxPIE3PQWVX86aenwRKcxXb864TgVpJpg+SYDWDo
 ZUpXP3VZobAHI8a/yHa24uGaZ6f5ndPYrmfE5ERHcsJ0z9DrpibsKsBqggW4+QmKkDvX6U1k3Qm
 Q5z9hQNYLGvij3v/o4Wy/tH6FKvTW9WKan0LDJOhXwYiPaOar5wjA5x/PSsiQlcy+6rKtdpkSYT
 SBx+OK9J6o5faGy/gjnA75l8k0zLRxG3Nv2eQPY5ZtKL4LCcBOXEuvBU0sp3eTly
X-Received: by 2002:a05:600c:19c9:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4b963c855cfmr39830655e9.22.1794166403387; 
 Sun, 08 Nov 2026 11:33:23 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cbfa121sm105422115e9.1.2026.11.08.11.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 11:33:22 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Sun, 08 Nov 2026 19:33:09 +0000
Subject: [PATCH 1/4] drm/vkms: use the gamma LUT of the state being
 composed
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-lut-v1-1-f762d70ae4cd@gmail.com>
References: <20261108-lut-v1-0-f762d70ae4cd@gmail.com>
In-Reply-To: <20261108-lut-v1-0-f762d70ae4cd@gmail.com>
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
2.55.0

