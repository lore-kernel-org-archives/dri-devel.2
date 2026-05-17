Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212D6CD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 13:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B0110E042;
	Sun, 17 May 2026 13:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=berkoc.com header.i=@berkoc.com header.b="KhR5E3Lh";
	dkim-atps=neutral
Received: from mail-01.1984.is (mail-01.1984.is [185.112.145.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8711310E042
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 13:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=berkoc.com; 
 s=1984;
 h=Subject:Cc:To:From:Message-ID:Date:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D9kECFUMtuKh0TE7iHonFkqbM5K+lBf35nG9AQ8cfUI=; b=KhR5E3LhqCJewlgXOx6eBv3ByC
 QDm/vd+N7NB9IxWiSkrQluzZKyxuvdHvf3LbrYEgjLbqJmtamfZ0933twJSyx9Q65FlDCtxLi54r1
 VPkV0vLnFJmX40/1K0wRUZ/NIrFx/CFyLp61nCmdfPhlkloUcRVgLDrf4WKNv0mQK1fn3dC3lM/yq
 XCSYYfP11otwHj0gv01sekNqSC+Jk2tOCJpvkZTWakS90x7HyaIrMfBxtZLiBooDi5gV6ewhPeYsV
 LbROp7LmgYQQH0pTnntLMpqOH/1OIuoqVRwxMaqCOrbrhCyoLSZyBmDw+7gKZHc4R96zGrukkMIBh
 7EcrVIsQ==;
Received: from localhost by mail-01.1984.is with utf8esmtp (Exim 4.96)
 (envelope-from <me@berkoc.com>) id 1wOb9H-00FziQ-2K;
 Sun, 17 May 2026 13:03:23 +0000
Date: Sun, 17 May 2026 15:03:09 +0200
Message-ID: <28e476e896dafdd31518dc5360ab7766@berkoc.com>
From: Berkant Koc <me@berkoc.com>
To: dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>, Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mgag200: reject pixel clocks outside PLL range
X-Authenticated-User: me@berkoc.com
X-Sender-Address: me@berkoc.com
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

Commit 877507bb954e ("drm/mgag200: Provide per-device callbacks for
PIXPLLC") split the PLL compute code into per-model source files. The
g200se variant kept the existing permitteddelta sanity check and
returns -EINVAL when no register combination matches the requested
pixel clock within tolerance, which lets atomic_check reject the mode.

The matching helpers in g200wb, g200eh, g200er, g200ev, g200eh3 and
g200ew3 omit that check. When the search loop finds no candidate, m,
n, p and s stay at their initial zero values and the function still
returns success. atomic_update then programs those zero values into
the PIXPLLCM/N/P registers, which yields a corrupted output clock on
the affected models.

Apply the same permitteddelta test (clock * 5 / 1000, matching the
g200se reference) in all six helpers so that out-of-range modes are
rejected during atomic_check instead of producing garbage register
writes during atomic_update.

Fixes: 877507bb954e ("drm/mgag200: Provide per-device callbacks for PIXPLLC")
Cc: stable@vger.kernel.org # v6.1+
Signed-off-by: Berkant Koc <me@berkoc.com>
---

Build-tested with CONFIG_DRM_MGAG200=m, allmodconfig defaults; no new
warnings. checkpatch.pl --no-tree clean (0 errors, 0 warnings).

 drivers/gpu/drm/mgag200/mgag200_g200eh.c  | 8 +++++++-
 drivers/gpu/drm/mgag200/mgag200_g200eh3.c | 8 +++++++-
 drivers/gpu/drm/mgag200/mgag200_g200er.c  | 8 +++++++-
 drivers/gpu/drm/mgag200/mgag200_g200ev.c  | 8 +++++++-
 drivers/gpu/drm/mgag200/mgag200_g200ew3.c | 8 +++++++-
 drivers/gpu/drm/mgag200/mgag200_g200wb.c  | 8 +++++++-
 6 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh.c b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
index d2aa931f579d..2387ff87550a 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200eh.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200eh.c
@@ -51,13 +51,14 @@ static int mgag200_g200eh_pixpllc_atomic_check(struct drm_crtc *crtc,
 	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
 	long clock = new_crtc_state->mode.clock;
 	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
-	unsigned int delta, tmpdelta;
+	unsigned int delta, tmpdelta, permitteddelta;
 	unsigned int testp, testm, testn;
 	unsigned int p, m, n, s;
 	unsigned int computed;
 
 	m = n = p = s = 0;
 	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
 
 	for (testp = 16; testp > 0; testp >>= 1) {
 		if (clock * testp > vcomax)
@@ -82,6 +83,11 @@ static int mgag200_g200eh_pixpllc_atomic_check(struct drm_crtc *crtc,
 		}
 	}
 
+	if (delta > permitteddelta) {
+		pr_warn("PLL delta too large\n");
+		return -EINVAL;
+	}
+
 	pixpllc->m = m;
 	pixpllc->n = n;
 	pixpllc->p = p;
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
index 7bea7a728f56..322e93982ea2 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200eh3.c
@@ -26,13 +26,14 @@ static int mgag200_g200eh3_pixpllc_atomic_check(struct drm_crtc *crtc,
 	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
 	long clock = new_crtc_state->mode.clock;
 	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
-	unsigned int delta, tmpdelta;
+	unsigned int delta, tmpdelta, permitteddelta;
 	unsigned int testp, testm, testn;
 	unsigned int p, m, n, s;
 	unsigned int computed;
 
 	m = n = p = s = 0;
 	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
 	testp = 0;
 
 	for (testm = 150; testm >= 6; testm--) {
@@ -59,6 +60,11 @@ static int mgag200_g200eh3_pixpllc_atomic_check(struct drm_crtc *crtc,
 			break;
 	}
 
+	if (delta > permitteddelta) {
+		pr_warn("PLL delta too large\n");
+		return -EINVAL;
+	}
+
 	pixpllc->m = m;
 	pixpllc->n = n;
 	pixpllc->p = p;
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200er.c b/drivers/gpu/drm/mgag200/mgag200_g200er.c
index 8fa8fe943abf..e180db21902b 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200er.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200er.c
@@ -69,13 +69,14 @@ static int mgag200_g200er_pixpllc_atomic_check(struct drm_crtc *crtc,
 	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
 	long clock = new_crtc_state->mode.clock;
 	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
-	unsigned int delta, tmpdelta;
+	unsigned int delta, tmpdelta, permitteddelta;
 	int testr, testn, testm, testo;
 	unsigned int p, m, n, s;
 	unsigned int computed, vco;
 
 	m = n = p = s = 0;
 	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
 
 	for (testr = 0; testr < 4; testr++) {
 		if (delta == 0)
@@ -110,6 +111,11 @@ static int mgag200_g200er_pixpllc_atomic_check(struct drm_crtc *crtc,
 		}
 	}
 
+	if (delta > permitteddelta) {
+		pr_warn("PLL delta too large\n");
+		return -EINVAL;
+	}
+
 	pixpllc->m = m;
 	pixpllc->n = n;
 	pixpllc->p = p;
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ev.c b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
index 3fadbeb10af9..0e882872e968 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200ev.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200ev.c
@@ -57,13 +57,14 @@ static int mgag200_g200ev_pixpllc_atomic_check(struct drm_crtc *crtc,
 	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
 	long clock = new_crtc_state->mode.clock;
 	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
-	unsigned int delta, tmpdelta;
+	unsigned int delta, tmpdelta, permitteddelta;
 	unsigned int testp, testm, testn;
 	unsigned int p, m, n, s;
 	unsigned int computed;
 
 	m = n = p = s = 0;
 	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
 
 	for (testp = 16; testp > 0; testp--) {
 		if (clock * testp > vcomax)
@@ -89,6 +90,11 @@ static int mgag200_g200ev_pixpllc_atomic_check(struct drm_crtc *crtc,
 		}
 	}
 
+	if (delta > permitteddelta) {
+		pr_warn("PLL delta too large\n");
+		return -EINVAL;
+	}
+
 	pixpllc->m = m;
 	pixpllc->n = n;
 	pixpllc->p = p;
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
index e387a455eae5..da8f2a66cde3 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200ew3.c
@@ -33,13 +33,14 @@ static int mgag200_g200ew3_pixpllc_atomic_check(struct drm_crtc *crtc,
 	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
 	long clock = new_crtc_state->mode.clock;
 	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
-	unsigned int delta, tmpdelta;
+	unsigned int delta, tmpdelta, permitteddelta;
 	unsigned int testp, testm, testn, testp2;
 	unsigned int p, m, n, s;
 	unsigned int computed;
 
 	m = n = p = s = 0;
 	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
 
 	for (testp = 1; testp < 8; testp++) {
 		for (testp2 = 1; testp2 < 8; testp2++) {
@@ -68,6 +69,11 @@ static int mgag200_g200ew3_pixpllc_atomic_check(struct drm_crtc *crtc,
 		}
 	}
 
+	if (delta > permitteddelta) {
+		pr_warn("PLL delta too large\n");
+		return -EINVAL;
+	}
+
 	pixpllc->m = m;
 	pixpllc->n = n;
 	pixpllc->p = p;
diff --git a/drivers/gpu/drm/mgag200/mgag200_g200wb.c b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
index d847fa8ded8c..ca4775173ff0 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200wb.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200wb.c
@@ -49,13 +49,14 @@ static int mgag200_g200wb_pixpllc_atomic_check(struct drm_crtc *crtc,
 	struct mgag200_crtc_state *new_mgag200_crtc_state = to_mgag200_crtc_state(new_crtc_state);
 	long clock = new_crtc_state->mode.clock;
 	struct mgag200_pll_values *pixpllc = &new_mgag200_crtc_state->pixpllc;
-	unsigned int delta, tmpdelta;
+	unsigned int delta, tmpdelta, permitteddelta;
 	unsigned int testp, testm, testn;
 	unsigned int p, m, n, s;
 	unsigned int computed;
 
 	m = n = p = s = 0;
 	delta = 0xffffffff;
+	permitteddelta = clock * 5 / 1000;
 
 	for (testp = 1; testp < 9; testp++) {
 		if (clock * testp > vcomax)
@@ -81,6 +82,11 @@ static int mgag200_g200wb_pixpllc_atomic_check(struct drm_crtc *crtc,
 		}
 	}
 
+	if (delta > permitteddelta) {
+		pr_warn("PLL delta too large\n");
+		return -EINVAL;
+	}
+
 	pixpllc->m = m;
 	pixpllc->n = n;
 	pixpllc->p = p;
-- 
