Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70E6C44506
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 733DD10F27A;
	Wed,  8 Jul 2026 19:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gZvMbGPF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8318810F27D;
 Wed,  8 Jul 2026 19:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D3WVSl0cn+GOIKUPYVB3+ziUrywvK4pXRs/fw6orwj8=; b=gZvMbGPF6me5G0VdRAg+nS0I3J
 GBm2450CRN4dE9fHdxvKjxepdlYFMYpz4BvBuSjVd4H5QTbnH05vdeneHm6j7frXfkc9SGY9wjenH
 Ca7xOoiah/6lkcAjyTwwCk8SfqrtahIphcF6iyFtd/025twmfWDZyosW1/LeAGtmC4GyiKC5r8Y6Q
 IniiXtVqG54huJf4IJseqSguKhy53d1bJCrEHESLMLplJqRm0i6mIUDPLBOwJdQVpyvyrC7wEb+Pq
 1CAkA15Htx5uLOiXEFdBL82xYfEIapc8qQdkhTFNGAdDc9h2l9XZI80EcTM3mjqU9fPufiOo3zqjM
 r7Kymz0Q==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whYBg-00BtrH-S5; Wed, 08 Jul 2026 21:44:05 +0200
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
 John Harrison <John.Harrison@Igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Louis Chauvet <louis.chauvet@bootlin.com>,
 dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 07/19] drm/atomic: Print the color pipeline as part of the
 CRTC state print
Date: Wed,  8 Jul 2026 21:37:22 +0200
Message-ID: <20260708194343.2578387-8-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708194343.2578387-1-mwen@igalia.com>
References: <20260708194343.2578387-1-mwen@igalia.com>
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

