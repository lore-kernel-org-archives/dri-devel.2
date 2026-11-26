Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C53606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PUsNZmNL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593A0112627;
	Thu, 26 Nov 2026 16:59:33 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701A411260A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:59:27 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso4548008f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795712366; x=1796317166; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b8av+eY3oOx9LPXN2r0kBM2LQdWTcF/2mS6LBsVDb0A=;
 b=PUsNZmNLCGub1HeIu54Is52yTX96FYhT2gz+8L3HtKHPKJO2wEd79n95fbSCFVHsZo
 zQyHNrfn5lgqyL6Z63O8uJqilMatG5CMCxqDxwIZapM11rEsCqmMxl4vp0FWrG/YTbWx
 rEiE7BuNOJFzCqKck2T02y9ieDOQTE2TUxpDk4+QYdxgdNjsk5ckkRJJjERu9owSCjpV
 h0FNKwJCHTxWaCgfsjaqeHwzmw0ek5xk8GBwANwSSWPby+Al0aAPL8J0EQuHRFFAdbLR
 u25xtUgTjzV+Jw8JxoCr8MoNiifmKrF3MJthHf1u9aqBjl6zchwAQ0AmqO6KK4o/MM1+
 8ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795712366; x=1796317166;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b8av+eY3oOx9LPXN2r0kBM2LQdWTcF/2mS6LBsVDb0A=;
 b=dpGAylPbicp+LyBUXZJQrcOj5o5kf8fZ3x76srsu3XMSZap8FqCgfeqfm8IHhMDt5q
 GkvmM7tr2J+JlDYn3C6s3b68K223cOGSL2YAcNmgBwFEL20Zdipn8VswLde6e+rQQsB+
 suaAHIDZUQ6cI5EG0fzitdnunevshbh0i5S7B7HS7LdultKf8Nl6xOL0i3xQV6mvIlr6
 psvXvvcjaU+FnmVjhSVryWUeV/tKZsUjjVYqVE75JBJ7QX2Lmt3Z0H9ndB0WAPo4Fi6A
 RgwkiwrzzRbh6qgxEelIpvTLm/Lc9RvcBn4B+4DVxCde641RiSywf+h9hW1qrp/FgzJz
 2VbQ==
X-Gm-Message-State: APuU4Z/6KwCdMiOQ7/AMqmwWq2hTRXJJLF2XJpcrRG8ti3m/N1Hm8oBF
 tT4OCb4Ev7idgQulRlt/J8dyvQJMDMCZXER+5uyQCNwK6Z1+pdfmnqWC
X-Gm-Gg: AZFdTZdb1rH2kpsZk6RtwljaR3DEB5rMqULF2+V4E1HdjyAh6+6kQNLNj7HNne4ccu0
 VofUibmqZrAQen5qMaXwhrliiuyGaZBWOHRL1GLLx1diEFVifoVQgSVZWCTZ+/WBlMcLYhQ6qjj
 hS76WDbbfVtDSFE4rA9PM+BrANzQcWJo9iW1nH0+qbcNlLQW9/C8sLLRQShMazuyMSwssnq2Of0
 Z18ajRLDKzWYTTksVBI3tgxBwbiaijArYExRkJAPCAA3ITsFnzRAEAGMw+EHBle94RDmralMCmI
 XiHjhM72BVGYQuKXY8QV4nsHJW0p99yBHdDpb1yT2GomElYrYQvqO3PhMriHQD40bjWVUnNOFXS
 TVS4EyGfVevhKSkl1+lAuRAgOM8p24ONBZFqtdZ3ge1DYz/BqhL7EGD2n8v9qbB7BYsPT6GEuu7
 25LOwQJN0w24ybDRPDqiRqQpp4MB34j2O35t3HEk7pyyRr/pjpg+RH/tgZxG9G7miJAsLnbAlE4
 32nmJVLnAGWBBXTJm7vCa3O5RQVXVWYjNAjdt+eHkn/uMxFAKvxc157GzpFoLSV9MoevrO8Xbeo
 /MX0FzcrOYWqUqpXeZsWNUiHTzPk7bs1Dl81AQ==
X-Received: by 2002:a05:6000:2f87:b0:4a6:bc53:246b with SMTP id
 ffacd0b85a97d-4abb5144ebdmr41390317f8f.30.1795712365536; 
 Thu, 26 Nov 2026 08:59:25 -0800 (PST)
Received: from [10.56.169.198] ([95.179.249.152])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b70c05b9desm17700731f8f.54.2026.11.26.08.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 08:59:25 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Date: Thu, 26 Nov 2026 17:59:03 +0100
Subject: [PATCH v2 1/2] drm/vkms: skip a blend that cannot change the frame
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-composer-fastpath-v2-1-292ed6d4c4d6@gmail.com>
References: <20261126-composer-fastpath-v2-0-292ed6d4c4d6@gmail.com>
In-Reply-To: <20261126-composer-fastpath-v2-0-292ed6d4c4d6@gmail.com>
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

