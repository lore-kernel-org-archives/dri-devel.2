Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507DDFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F01888D18;
	Mon, 27 Apr 2026 18:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="EhOVsVWF";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFD610E2CD
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=8uk42A4yXsNle0cIaMJqk2h78jAEvcYyuc0vBtfkAOA=; b=EhOVsVWFOlmux3YsotUSsjPwTE
 oSYzv4ZWYUsPRYnQcpYUoFM19PxXg0tNe+/pnd8FVBZCbT0vHsTEsGxO8lC+oTYukH0+eql7B1Njr
 nVma8DhFOkqmI/H7vOtiP6K4+Wk/oNIYXP8kWrtmcfImwZ61QCaDHGQtaLImVRSjhMW19JuVFxLdP
 +U6f3Q5uhBWB8t/0rrEk2x9XbFBZjXAf7czrXGD3NifDPNgbnFZj45G/6Ri9ufGs9mqxfw9qY9JJ6
 imNzvqARInJh+bu9mKbMFcUq1OtIBKr+Bp/IdAysHmC6kq1RtU6fhLEZ4zzexu9B6xdPq12yEujpU
 Z0882SIA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1wHQwl-0000000HayN-2NSj; Mon, 27 Apr 2026 18:44:43 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2] drm/tegra: dp: fix kernel-doc warnings in dp.h
Date: Mon, 27 Apr 2026 11:44:42 -0700
Message-ID: <20260427184442.693768-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
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

Use correct kernel-doc format and add missing nested struct entries to
eliminate kernel-doc warnings:

Warning: drivers/gpu/drm/tegra/dp.h:28 Incorrect use of kernel-doc format:
 * tps3_supported:
Warning: drivers/gpu/drm/tegra/dp.h:54 struct member 'tps3_supported'
 not described in 'drm_dp_link_caps'
dp.h:73: warning: Function parameter or struct member 'apply_training'
 not described in 'drm_dp_link_ops'
dp.h:73: warning: Function parameter or struct member 'configure'
 not described in 'drm_dp_link_ops'
dp.h:160: warning: Excess struct member 'cr' description in 'drm_dp_link'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2: rebase & resend

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/tegra/dp.h |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- linux-next-20260427.orig/drivers/gpu/drm/tegra/dp.h
+++ linux-next-20260427/drivers/gpu/drm/tegra/dp.h
@@ -26,7 +26,7 @@ struct drm_dp_link_caps {
 	bool enhanced_framing;
 
 	/**
-	 * tps3_supported:
+	 * @tps3_supported:
 	 *
 	 * training pattern sequence 3 supported for equalization
 	 */
@@ -62,12 +62,12 @@ void drm_dp_link_caps_copy(struct drm_dp
  */
 struct drm_dp_link_ops {
 	/**
-	 * @apply_training:
+	 * @apply_training: apply the link training
 	 */
 	int (*apply_training)(struct drm_dp_link *link);
 
 	/**
-	 * @configure:
+	 * @configure: configure the DP link
 	 */
 	int (*configure)(struct drm_dp_link *link);
 };
@@ -113,6 +113,8 @@ struct drm_dp_link_train {
  * @max_lanes: maximum number of lanes supported on the link
  * @caps: capabilities supported on the link (see &drm_dp_link_caps)
  * @aux_rd_interval: AUX read interval to use for training (in microseconds)
+ * @aux_rd_interval.cr: clock recovery read interval
+ * @aux_rd_interval.ce: channel equalization read interval
  * @edp: eDP revision (0x11: eDP 1.1, 0x12: eDP 1.2, ...)
  * @rate: currently configured link rate
  * @lanes: currently configured number of lanes
@@ -126,10 +128,6 @@ struct drm_dp_link {
 
 	struct drm_dp_link_caps caps;
 
-	/**
-	 * @cr: clock recovery read interval
-	 * @ce: channel equalization read interval
-	 */
 	struct {
 		unsigned int cr;
 		unsigned int ce;
