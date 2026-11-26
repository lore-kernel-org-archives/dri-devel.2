Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549B3606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SzVz+l58
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B580A11255C;
	Thu, 26 Nov 2026 15:47:38 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62BDD10E23D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 15:47:32 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-491971ac844so6379142f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795708051; x=1796312851; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b8av+eY3oOx9LPXN2r0kBM2LQdWTcF/2mS6LBsVDb0A=;
 b=SzVz+l58HajZ7sc5b+EVcuHHXFAuD51T145d2tb3pEdiyC/HTlCN/RgurKlWng93tH
 uPsLlCsTO2U+sJeNxzQU9+SvX3ON1B69o1dIY6tPWL3VvE+s17QvTJqao/fMhy08ovKq
 Wb3vCNkftg6i5Sx1imwFHoRkfhQzAXq3CitQ41mN8X3/dbnkBqLKIenkfvBxQcGq0z2k
 dhLrCsLVDCm68wk2PsbTDk/IdqglT710ZAzcaPpJukdh7JkkG+xBPYgopDODK2Xt9jxf
 q3q0F39cd7fAjgOZcqvPXz0g2bJloVkWZ1XdutNjQO29uh60xTJX1ItOdDfpy5LFRSGH
 z1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795708051; x=1796312851;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b8av+eY3oOx9LPXN2r0kBM2LQdWTcF/2mS6LBsVDb0A=;
 b=K3gn5W2Ime1ZagMp2pX4P2BUdWBK9cByUgHRHc5AQix59Oke6IlSGEpwfkQdwd/yya
 A6G8fT+WP6LQ1hjLSujYiWRWWy8+wDkaek9cv68W1MXsTDgPb3+SvCHjbCS1HonV9iWm
 Z8NFIVr2+oMXtZ5DMCVq1D+LXW1ZWW6z0gT5gljKMKgaWfKlt1rdIYfuUdXy/t2SUKsb
 HHAwhaJ10IZW6sDOOEP3am04C7IIF8WYZZisw3K8kDbcsL7t2gMA7p3P470fD7QLrsjT
 lW9CohEGgy4k+zXJXZzUAcjtYpeU9xnneSSZayMLrz3YCMyI0SAEMw7ST2V1HLNkndrQ
 FbaA==
X-Gm-Message-State: APuU4Z89Ab0CXN+sW9n5WA4AmmyoA+fh78XdtBHrXxuQG10Mz+7sVlX8
 2kB2ygc6+lhailP8+LGXabuxuCKTcJcW+TdBZtUULxmcwqNuhH5HFFmG
X-Gm-Gg: AZFdTZfDthx/zzz0q6Wyd6IKbuCZYawJSqjaWcHoCSDhoTSOuRBQjzNya1Ww1le/5xl
 7LqqzmXo1Z4Lb1TrvPII6qJXifL1JT7DJsFwjR7gsrFgI/kHXHB98wHBdxDqIXdbcwW/D1EZWsq
 K7zpEzlodJAXbVCRfk8a8EXTZClBbPlliUa/hr2g8hy1/lb4iD1PuyvsAJWaj00gOIj3l1Rj1j6
 3X/uU9oDOBgNO3ji7NXvVK7DjLcqzNPcsqm0y3TYfKYspQM6obtBVTbE+I4tgB6Dj6rfSzl085F
 l5JK7Dnr1fwlMv1GYouTsZ76XgWFlMCH8e11iNl+53PQhyYJnWbJtZ3HVnZ7RVH+ATKR1u6CNdW
 exYBLCoib5AaXbAftr7p+sHf1LGZZZznlRC9eVFFNiebZL+bWjSQZZ5bTW+O+NvvEP3JzD/ww+z
 BANQLS3pVyK5gBbZKbxFTksljReYUoVX1zhz+YCznLkHwsTthkESeki7AH61DGAf4yUgl0vgAmJ
 oyn7GnwrL4yFeBt3H9/fBZizX2NpS8N6lPZCTGxK/KfE8Lr0wt9aKlg3PLIj1fU+cBilT/8BpHr
 3IDH9AhAwQA2xHksdhcvxueDuMPNFWpp3BTN1w==
X-Received: by 2002:a05:600c:4584:b0:4bb:5de1:e90f with SMTP id
 5b1f17b1804b1-4bb88819bcdmr430968735e9.31.1795708050657; 
 Thu, 26 Nov 2026 07:47:30 -0800 (PST)
Received: from [10.56.169.198] ([95.179.249.152])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b3a7sm683201895e9.3.2026.11.26.07.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:47:30 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Thu, 26 Nov 2026 16:47:07 +0100
Subject: [PATCH 1/2] drm/vkms: skip a blend that cannot change the frame
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-composer-fastpath-v1-1-aa7458d84a7b@gmail.com>
References: <20261126-composer-fastpath-v1-0-aa7458d84a7b@gmail.com>
In-Reply-To: <20261126-composer-fastpath-v1-0-aa7458d84a7b@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

A single full-screen plane no longer goes through fill_background() and the
line blend: read it straight into the output line.

Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 44 ++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 7a6a7875520c..4e2dd568bc3e 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -452,13 +452,15 @@ static void clamp_line_coordinates(enum pixel_read_direction direction,
  * @crtc_x_limit: width of the output buffer
  * @stage_buffer: temporary buffer to convert the pixel line from the source buffer
  * @output_buffer: buffer to blend the read line into.
+ * @blend_direct: false to read the line straight into @output_buffer
  */
 static void blend_line(struct vkms_plane_state *current_plane, int y,
 		       int crtc_x_limit, struct line_buffer *stage_buffer,
-		       struct line_buffer *output_buffer)
+		       struct line_buffer *output_buffer, bool blend_direct)
 {
 	int src_x_start, src_y_start, dst_x_start, pixel_count;
 	struct drm_rect dst_line, tmp_src, src_line;
+	struct line_buffer *read_buffer = blend_direct ? stage_buffer : output_buffer;
 
 	/* Avoid rendering useless lines */
 	if (y < current_plane->frame_info.dst.y1 ||
@@ -542,12 +544,43 @@ static void blend_line(struct vkms_plane_state *current_plane, int y,
 	 * buffer [1].
 	 */
 	current_plane->pixel_read_line(current_plane, src_x_start, src_y_start, direction,
-				       pixel_count, &stage_buffer->pixels[dst_x_start]);
+				       pixel_count, &read_buffer->pixels[dst_x_start]);
+
+	if (!blend_direct)
+		return;
+
 	pre_blend_color_transform(current_plane, stage_buffer);
 	pre_mul_alpha_blend(stage_buffer, output_buffer,
 			    dst_x_start, pixel_count);
 }
 
+static bool compose_direct(const struct vkms_crtc_state *crtc_state)
+{
+	const struct vkms_plane_state *plane;
+	const struct drm_rect *dst;
+
+	if (crtc_state->num_active_planes != 1)
+		return false;
+
+	plane = crtc_state->active_planes[0];
+	if (!plane)
+		return false;
+
+	dst = &plane->frame_info.dst;
+	if (dst->x1 != 0 || dst->y1 != 0 ||
+	    dst->x2 != crtc_state->base.mode.hdisplay ||
+	    dst->y2 != crtc_state->base.mode.vdisplay)
+		return false;
+
+	if (plane->frame_info.fb->format->has_alpha)
+		return false;
+
+	if (plane->base.base.color_pipeline)
+		return false;
+
+	return true;
+}
+
 /**
  * blend - blend the pixels from all planes and compute crc
  * @wb: The writeback frame buffer metadata
@@ -579,6 +612,7 @@ static void blend(struct vkms_writeback_job *wb,
 
 	int crtc_y_limit = crtc_state->base.mode.vdisplay;
 	int crtc_x_limit = crtc_state->base.mode.hdisplay;
+	bool direct = compose_direct(crtc_state);
 
 	/*
 	 * The planes are composed line-by-line to avoid heavy memory usage. It is a necessary
@@ -588,11 +622,13 @@ static void blend(struct vkms_writeback_job *wb,
 	 * algorithm for a specific format, into the staging buffer.
 	 */
 	for (int y = 0; y < crtc_y_limit; y++) {
-		fill_background(&background_color, output_buffer);
+		if (!direct)
+			fill_background(&background_color, output_buffer);
 
 		/* The active planes are composed associatively in z-order. */
 		for (size_t i = 0; i < n_active_planes; i++) {
-			blend_line(plane[i], y, crtc_x_limit, stage_buffer, output_buffer);
+			blend_line(plane[i], y, crtc_x_limit, stage_buffer,
+				   output_buffer, !direct);
 		}
 
 		apply_lut(crtc_state, output_buffer);

-- 
2.56.1

