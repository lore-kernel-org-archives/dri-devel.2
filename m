Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96C2C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B68B10ED90;
	Fri, 21 Aug 2026 14:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M5cuCUmP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2893810E313
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F3EA61838;
 Fri, 21 Aug 2026 14:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD94C1F000E9;
 Fri, 21 Aug 2026 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323184;
 bh=6iMpQ41ffYwTnrINKjTEkvNlQLSXMHegZOY8SiQiEQA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=M5cuCUmPoEyA6N48p++rZqg09atfAbXXthJutZhIAnpPcEE7A1t7EfZ+rm5Wf8qvs
 xCgJQ5ErBHs1pq8jAUeZynViIcH0RSA1bTsxW3oVizPBJ5zkwWN3T+NTTTxqcOC8cl
 djL7575QiR9S2yLn7gRnZuE42WPtWji2V3ElK5Gp4NtmN7mb6cywQxmgqOpU27YtB0
 2EodMOV9HTpjdZzowjauKHa3mV4E91wAL8x3v66WqQI1LVJsdojiuFLKcLk75XMyfZ
 U24B4McitKnH9qxaroWz/yibBIrzMoF+lTXXD1TWBqBf/A0FlaGYiyLKTg/ESKWF3/
 gy8MXtaxwsR2g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:45 +0200
Subject: [PATCH 09/70] drm/hisilicon: kirin: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-9-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 John Stultz <jstultz@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Xinliang Liu <xinliang.liu@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ywxBtWfMqA0R//5GOlhDjDbf4SY6KGKFlzS8XMIdqWw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSb/5ylZFxS+5PmcK22fHSD6JFu0vbW22uVF26T9k8
 lhLGF92TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInMt2Ws99qjbi/fM9Hmja1X
 HHN2wo31UXzld3Z3c+UFeidNnMX925b1sOGV6XZWhVNbar4/roxnbNhbNu/bt+IrhX8/KUxMLnl
 g8P95+bSyfwsmve8+/0BGsH9W8rK8PyUbazOMXC8+2lKidBIA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The kirin crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: John Stultz <jstultz@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Yongqin Liu <yongqin.liu@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 902c5dace4ff..5f4e738bc94e 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -538,11 +538,11 @@ static const struct drm_crtc_helper_funcs ade_crtc_helper_funcs = {
 
 static const struct drm_crtc_funcs ade_crtc_funcs = {
 	.destroy	= drm_crtc_cleanup,
 	.set_config	= drm_atomic_helper_set_config,
 	.page_flip	= drm_atomic_helper_page_flip,
-	.reset		= drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
 	.enable_vblank	= ade_crtc_enable_vblank,
 	.disable_vblank	= ade_crtc_disable_vblank,
 };

-- 
2.55.0

