Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1E606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bLk6X6NO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5750110EF0B;
	Tue, 24 Nov 2026 07:41:27 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 603F410EED1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:41:17 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cc4aa18f9afso1628455a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 23:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795506077; x=1796110877;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=74TXVSiLNJEh4EdaGe7nzkm4UiqpR2QLi5goWWiHysE=;
 b=bLk6X6NO21ss9bD9QWipz8m3hTsN5rfLhF9TC8reiBjvj7S8ajMm2Wh4TZSUpLEtxC
 laoiN/FfRp48kmRR6Pn7rHJu3rY/bm1CaUTW99MGUuPv/2b9m1am1GBAZVYUx632U1nF
 Ac1RRlTlx1i/BtsgoSqYC0dBT4xnHs2E1vUYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795506077; x=1796110877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=74TXVSiLNJEh4EdaGe7nzkm4UiqpR2QLi5goWWiHysE=;
 b=VY4E7aEpHJil//Yrvh9OJkRbBo1p1AUd22nMyDoEMh7fp7a9z/Sjrzn8b68P9wptYs
 hUhGcEEHrJt9mtdo+UNL41MMeFbW5q15Z3WRz3VCt0HCYcqDd4dZYgA4469D0rCW6LIn
 dFS7yb7nExNfQx02M6f1J701MRXj7xFcL6knvXpr8FthG/amS0pJ5rOSU8OwulZgSlgw
 6D93eioQzSpFwx66F/9kwAOqPLAfMnFOOU4lPun+8L3KjKbB+AglA44J9zpeUNz2SsI2
 EP9XARD/xsYrGOovGHnRCS+m7RlPsgJIbByrzKlRv7eAaMgba0MSJdukly2T3GhjYSEa
 yt6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEErI+OkYT9iCC2OVGwHTWEglnOOeDuDwNZfGKW64vtt0dZdSQbBFAy5kQjPn/lxXGTEFvA3FVm5v4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Ebag+HjPctXjbZOwS5R3P+9rxNNwsdQVocWQClRjEo6gATLvy
 4fqxmYYGYPVbwZ3hl4I6Ey015fklwPwAN6JSzCHZtakcQyfnA9bygXdqU//ogiDB5A==
X-Gm-Gg: AZFdTZf81MqvpjnFE4R1CuSNViOWKpwtHLA2AjGdfpkrOVVBArx0XnWU075czfZAkdL
 p0PYZBwfyPee0AevJz+swh6HyaOhy/MCuT5amKctcyyS8u1pxJ1H7h80s01lHxLpFA9/xIQVDis
 dE5HcCjFmFp2JTdmRJMibpOc2IC9x5JhIcGYKL587N/J2F8RGfUPxB4wae9E8mlBCHq4ZyQ8bbb
 JuVlBeQLh4FQlgAc6qtzdgcpbJ/C5yFAa4QcASeGZGmAMoTBSIZpjMYlbaSBOJ/gsCVr+wZW0v/
 GFaNbydt0OYMxz1cF8/Zlw3osJvpJ1H+oT2MTjl0HdB6oRZDVT9DFRSTkE5/dmvwgsHckaqJ7Hg
 gpVZhQbSHYWsOXoMuvmxzezwxGEpnKsMrWLEVfKE73BlYY3OvPK3NXYKR/Vz6cCcGjKsuS++de8
 hcZSJi9NyGpMCffern4CVr67C72UKUygETwd1TvEHFF0S8/f1+l5UUFfzE3Sdhd+XAzuTV30ktH
 hCpo/85h76YWwdgCFlH/A5TbUxitYN3wwOabKW5OqnekpRY5Ps51p5hM0rRrQY1BUsQrf3ymcJh
 ROak/NA66PUki7glVkZnkr+UcnCt65lnAluf9xzzhjZeWLUYTrhndBRYNqf2
X-Received: by 2002:a17:90b:3d90:b0:3b3:ff70:4d0d with SMTP id
 98e67ed59e1d1-3b41c8d49b7mr11902997a91.14.1795506076825; 
 Mon, 23 Nov 2026 23:41:16 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:8f32:8910:4727:ea03])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3b44b7a8c64sm9100767a91.3.2026.11.23.23.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 23:41:16 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH RFT v3 4/5] drm/imx/dc: plane: Switch to
 drm_fb_dma_get_gem_clipped_addr()
Date: Tue, 24 Nov 2026 15:39:32 +0800
Message-ID: <20261124074041.115251-5-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124074041.115251-1-wenst@chromium.org>
References: <20261124074041.115251-1-wenst@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The hardware is programmed with clipped source and destination dimensions,
but the framebuffer address is calculated using drm_fb_dma_get_gem_addr(),
which uses the full source dimensions. This will not match the source
offset if the top and/or left sides are clipped.

Switch to the new drm_fb_dma_get_gem_clipped_addr(), which provides the
buffer address starting at the clipped boundary.

Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
Cc: <stable@vger.kernel.org> # Needs drm_fb_dma_get_gem_clipped_addr()
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/imx/dc/dc-plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/dc-plane.c
index 62dd0576fadc..35eb5039f5ac 100644
--- a/drivers/gpu/drm/imx/dc/dc-plane.c
+++ b/drivers/gpu/drm/imx/dc/dc-plane.c
@@ -65,7 +65,7 @@ static int dc_plane_check_max_source_resolution(struct drm_plane_state *state)
 static int dc_plane_check_fb(struct drm_plane_state *state)
 {
 	struct drm_framebuffer *fb = state->fb;
-	dma_addr_t baseaddr = drm_fb_dma_get_gem_addr(fb, state, 0);
+	dma_addr_t baseaddr = drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
 
 	/* base address alignment */
 	if (baseaddr & 0x3) {
@@ -146,7 +146,7 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 	src_w = drm_rect_width(&new_state->src) >> 16;
 	src_h = drm_rect_height(&new_state->src) >> 16;
 
-	baseaddr = drm_fb_dma_get_gem_addr(fb, new_state, 0);
+	baseaddr = drm_fb_dma_get_gem_clipped_addr(fb, new_state, 0);
 
 	fu_ops = dc_fu_get_ops(dplane->fu);
 
-- 
2.56.1.809.ga0b61035b5-goog

