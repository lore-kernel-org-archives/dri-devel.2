Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4D8CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 19:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D78B10E9C6;
	Thu,  8 Oct 2026 19:17:50 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 905EB10E997
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 19:17:48 +0000 (UTC)
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowADHzz1W7MdqTWwRCg--.14045S2;
 Fri, 09 Oct 2026 03:17:43 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/omap: hdmi: fix runtime PM leak in hdmi_pll_enable()
Date: Fri,  9 Oct 2026 03:17:45 +0800
Message-Id: <20261008191745.2809272-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADHzz1W7MdqTWwRCg--.14045S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWDXw17Ww1kCw4ktr4UCFg_yoW8Wr4Upr
 WSqa4jvrykJr47trsrAFnxZFya93yakrWfGr97Cas3ua1rAa4rtr4rAryF9F4v9rykAa13
 Krn7Gay3CryYyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUklb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JV
 WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_
 Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
 42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU59o2UUUUU
 U==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQOA2rHpl2cVQAAsR
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

hdmi_pll_enable() acquires a runtime PM reference with
pm_runtime_get_sync() and then returns the -ETIMEDOUT error from
hdmi_wp_set_pll_pwr() without releasing it.  The callers of
dss_pll_enable() (hdmi4.c, hdmi5.c, dpi.c and dsi.c) do not call
dss_pll_disable() when enabling fails, so the reference is never
dropped and the HDMI device can no longer be runtime suspended.

Release the runtime PM reference and undo the dss_ctrl_pll_enable()
call on that error path.  Also drop the reference with
pm_runtime_put_noidle() when pm_runtime_get_sync() itself fails.

Fixes: 86c9305c864c ("drm/omap: HDMI PLL: use runtime pm")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/omapdrm/dss/hdmi_pll.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
index eea719243eaf..9b900fc88f5f 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
@@ -43,13 +43,19 @@ static int hdmi_pll_enable(struct dss_pll *dsspll)
 	int r;
 
 	r = pm_runtime_get_sync(&pll->pdev->dev);
-	WARN_ON(r < 0);
+	if (WARN_ON(r < 0)) {
+		pm_runtime_put_noidle(&pll->pdev->dev);
+		return r;
+	}
 
 	dss_ctrl_pll_enable(dsspll, true);
 
 	r = hdmi_wp_set_pll_pwr(wp, HDMI_PLLPWRCMD_BOTHON_ALLCLKS);
-	if (r)
+	if (r) {
+		dss_ctrl_pll_enable(dsspll, false);
+		pm_runtime_put_sync(&pll->pdev->dev);
 		return r;
+	}
 
 	return 0;
 }
-- 
2.25.1

