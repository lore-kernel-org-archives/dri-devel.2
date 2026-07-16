Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDC6C44518
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99C710F356;
	Thu, 16 Jul 2026 16:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ORJH/E3V";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F53710F353;
 Thu, 16 Jul 2026 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=D3WVSl0cn+GOIKUPYVB3+ziUrywvK4pXRs/fw6orwj8=; b=ORJH/E3VFX9KVugAOCwJ3F3WYK
 OzqSs/aYA1vBHq0hjMJuQ6MjnR0ftWx9k0Rt30w9nhblHldhVUh/sa5OIz1MaUOkL1pvWT4VOLGok
 9VfOlg9l2zdtqPDa0xzqfo35T+f2jfM/9GvcWTMNa/ymTNEZLsl7y+0T1lcV4vR9ZhgkvOeBLewSi
 tdZ4Q202oDuSLk6cslz8nVKc0zEf2HVyMlIgWMmCqkQ3kJ4eIkogN3Ti4GBiTdNIMDcftVxhpm7a0
 Lvbf/rB3Gqlf2Za5SLZj5Gsw3LIr7HHn4JWnsUa64R6Q1tYVLQwsFm9t5+Zm3OvZpnqKnpegBlV9W
 FriMX8ig==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkObO-00G01i-BS; Thu, 16 Jul 2026 18:06:22 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>, kernel-dev@igalia.com,
 Louis Chauvet <louis.chauvet@bootlin.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2 07/20] drm/atomic: Print the color pipeline as part of
 the CRTC state print
Date: Thu, 16 Jul 2026 18:03:04 +0200
Message-ID: <20260716160556.227556-8-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716160556.227556-1-mwen@igalia.com>
References: <20260716160556.227556-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Print the value of the color pipeline in the CRTC state as part of the
CRTC state print.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/drm_atomic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index c41759aedc6f..76c7665b3c4c 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -554,6 +554,8 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
 	drm_printf_indent(p, 1, "plane_mask=%x\n", state->plane_mask);
 	drm_printf_indent(p, 1, "connector_mask=%x\n", state->connector_mask);
 	drm_printf_indent(p, 1, "encoder_mask=%x\n", state->encoder_mask);
+	drm_printf_indent(p, 1, "color-pipeline=%d\n",
+			  state->color_pipeline ? state->color_pipeline->base.id : 0);
 	drm_printf_indent(p, 1, "mode: " DRM_MODE_FMT "\n", DRM_MODE_ARG(&state->mode));
 	drm_printf_indent(p, 1, "background_color=%llx\n", state->background_color);
 
-- 
2.53.0

