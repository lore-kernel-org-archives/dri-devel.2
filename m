Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD009CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 19:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F7E610EE5B;
	Wed,  6 May 2026 19:16:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Qysju8df";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBF510EE5B;
 Wed,  6 May 2026 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5/g3EAyfaYbUL97qua9zDHOZMKJVs1Avdo3ROu5paOo=; b=Qysju8dfnB7+8SKrk63CmMlKMA
 0GCRNYZo8ETYYdgpKCexem55mwTYdFSKtWZh8s8PwtBRxPg+2GrD1QjJjqvwyBMh+4s/fkMEWyzO3
 VPE8VuuI0z6pUQ7lSBNKY/nzb4VS4HmgAJS+LuZgPFHb8jLYoZOkiea7FJ0P+4nUkDZhXyB3+pQSG
 fKdd3vJkKWoUoWWYl9g0xx9K1pPon+ECN1uRJ1njGj2Kj2h7xOVot6XTBjwhnFlTIcShaO2bl3g0x
 GG2F4x2Zlm3imtJYFo2XmcdtTS3lv84kMgpSQpNB8MrL9EnJh8yvkW9crXsd/BjLnRe9racuLCo+B
 Dg/YolWA==;
Received: from [186.208.73.228] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKhjX-0072Pg-Cz; Wed, 06 May 2026 21:16:35 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 pekka.paalanen@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: [PATCH v2 3/5] drm/amd/display: use a separate helper to translate
 degamma curves
Date: Wed,  6 May 2026 16:11:50 -0300
Message-ID: <20260506191606.15022-4-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506191606.15022-1-mwen@igalia.com>
References: <20260506191606.15022-1-mwen@igalia.com>
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

In newer DCN families, there is no hw predefined curves for shaper,
blend and regamma. When userspace sets pre-defined curves for these
blocks, the driver uses AMD color module to program predefined curve as
LUT. However, it was using the same LUT segmentation for EOTF and
inverse EOTF by using the same color management helper. This is causing
banding on blend when PQ predefined curve is set. Besides that, degamma
predefined HW curve cannot be used with subsampled 4:2:0/4:2:2 formats
as it affects the linearity of color space in which HW scaler operates.

To mitigate banding when using the blend block and better support
subsampled format on degamma, use different translation helpers when
linearizing and delinearizing.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index fd42f0afc3a9..9dfbb68d503b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -493,9 +493,8 @@ bool dcn32_set_mcm_luts(
 	if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
 		lut_params = &plane_state->blend_tf.pwl;
 	else if (plane_state->blend_tf.type == TF_TYPE_DISTRIBUTED_POINTS) {
-		result = cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
-								 &plane_state->blend_tf,
-								 &dpp_base->regamma_params, false);
+		result = cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->blend_tf,
+									 &dpp_base->regamma_params);
 		if (!result)
 			return result;
 
@@ -551,9 +550,8 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
 	if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
 		params = &plane_state->in_transfer_func.pwl;
 	else if (plane_state->in_transfer_func.type == TF_TYPE_DISTRIBUTED_POINTS &&
-		cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
-							&plane_state->in_transfer_func,
-							&dpp_base->degamma_params, false))
+		cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->in_transfer_func,
+								&dpp_base->degamma_params))
 		params = &dpp_base->degamma_params;
 
 	dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
-- 
2.53.0

