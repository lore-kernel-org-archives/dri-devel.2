Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE922F9D0F6
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 22:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F80A10E0AD;
	Tue, 14 Apr 2026 22:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="oCPZn1XN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FF9410E091;
 Tue, 14 Apr 2026 22:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LgihZrJ1MFUJa6ya7SnfAAsEg6PQX7O+3GxWDzrkKzo=; b=oCPZn1XN48oZwywL5qu77E6V+G
 JVkKuY+EntJiaWSEzg+psia1HiIViGlv3XdwwXvHcGdyxyYePKRFXifRpc1tYmrjweVACdo3exVso
 dVnbx+sddV5hhAhpsIeA9lWWQxzfOkfhuW2nlcg4iL9Qk1OvZ0O2zf23AmNTtoPyOORp0CppEHlHE
 RFCjF3iFZp+d/4mttEcBKc1RtvlSZvuc3Kd5M/OgvBEgBu9bteDhto3TktGa3CCtoFOXYvYniAk2o
 /iqRdjz5t5mJxTAu2Rs+7z24g/Hzm2JbzguP3Tr21moygdRRwuc+AtBo0hKdF/TfVQHwHutqMdp+d
 5V6c6M9g==;
Received: from [186.208.73.228] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wClqX-00G60j-RL; Wed, 15 Apr 2026 00:03:02 +0200
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
Subject: [PATCH 2/4] drm/amd/display: use a separate helper to translate
 degamma curves
Date: Tue, 14 Apr 2026 18:55:01 -0300
Message-ID: <20260414220237.184289-3-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414220237.184289-1-mwen@igalia.com>
References: <20260414220237.184289-1-mwen@igalia.com>
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

In newer DCN families, there is no hw predefined curves. So, when
setting predefined TFs to gamm_corr, shaper, blend and regamma, the
driver resorts to the color modules and program those predefined curves
using LUTs. The driver is using the same LUT segmentation when
translating EOTF and inverse EOTF to hw points by using the same color
management helper to translate curve to hw points, however, LUT
representing EOTF may not follow the same region/segment distributions
of inverse EOTF. This is causing banding on blend when PQ predefined
curve is set. Use different helpers when linearizing and delinearizing.
This is the first step to fix banding but already mitigates the issue by
increase the number of points per segment from 8 to 16.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index b45ceb570a5c..17d54aadb5e1 100644
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

