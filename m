Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB40CD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 18:38:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8AF112976;
	Sat, 30 May 2026 18:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MOZ8DLIy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB47112975
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 18:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9x8OYvKFsNwqjP7jvmqNwZP7haudpAOz0SmRmxXx/PI=; b=MOZ8DLIyyZhL7AE8Bw+fKVJJqr
 2JZCBaA13sKcxtPK7UR3FmZj4J9q1c8IGXziiltxkQxsTGWoSJ1etwOdnLghq63nIH+m+aDnfW/5Z
 2LCzSwDPAixRKAZvJ+2AL6V+TXTF49Aqhkbiq6PtdtYTZHEuZ+eSIvgzF1yEPonW149m1HNmcW8ri
 RugnEUMTtDgw20GfeA1Rd2SkHRidUSvhwdsldR/4qGROd8ry09HICBNlqczHxobACMpWmKXoj2tde
 31XK4K+DVrsq4sG6ajD34JXSCD4zBk0bZySs9Pcq/pfnNk7cSu1kkBd8dq+StvDhnUJ/siSw88v7o
 6oRpkQkQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wTOZS-00ALNh-38; Sat, 30 May 2026 20:38:06 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 30 May 2026 15:37:42 -0300
Subject: [PATCH 1/4] drm/v3d: Wait for pending L2T flush before cleaning caches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-v3d-fix-rpi4-freezes-v1-1-c2c8307da6ce@igalia.com>
References: <20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com>
In-Reply-To: <20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=NLI0v+RttiQPW0DxzyASoDa+lnqiux+q/8Ll8MbHowU=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqGy6IKfrBNgvOxipeVBLlQFNlHTOqR93SY0Fo5
 N/c5SJVKo2JATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCahsuiAAKCRA/8w6Kdoj6
 qhoWB/987vqe5RJXjAq5zqDfNNS0pVHfja98VFCWPzo33F8l6S2jjQrULXwpWXLThlEZDmkHWeY
 sWIDAAowcEyiwiHuELbB8sSKy1SAN54H24uuH1J7LBNHglvkogOo/x4dsH6cNPiH9mqQoz9UGTW
 mP0vcaS1GzI9gH9kweK+nJo5pRkeTgDrKlW6zaymPk5FiwDvtSjEpjehZadSDAz712B0OaZnIlF
 x/58jQse6NH2E+JTSX2y607dnlSF3nvyomKw7eaJlx0xPdHcCTo+GPkoUWK8ERfTxKkWSncK6ib
 uGNliD66G4hK6rk5Fj0nCo1O/jq+YcSKj6KW0Xj1w2hWTH1l
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

v3d_clean_caches() starts the cache-clean sequence by writing
V3D_L2TCACTL_TMUWCF to V3D_CTL_L2TCACTL and then polling for that bit to
clear. It does not, however, check for an L2T flush (L2TFLS) that may
still be in flight from a previous operation.

On pre-V3D 7.1 hardware, kicking off the TMU write-combiner flush while an
L2T flush is still pending can clobber bits in L2TCACTL and cause cache
inconsistencies.

Poll for L2TFLS to clear before writing L2TCACTL on V3D < 7.1, ensuring
any pending flush has completed before a new clean is issued.

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 1ee3c038d5f6..c43d9af41374 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -206,6 +206,14 @@ v3d_clean_caches(struct v3d_dev *v3d)
 
 	trace_v3d_cache_clean_begin(dev);
 
+	/* GFXH-1897: Ensure pending flushes complete before writing L2TCACTL */
+	if (v3d->ver < V3D_GEN_71) {
+		if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
+			       V3D_L2TCACTL_L2TFLS), 100)) {
+			drm_err(dev, "Timeout waiting for L2T clean\n");
+		}
+	}
+
 	V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL, V3D_L2TCACTL_TMUWCF);
 	if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
 		       V3D_L2TCACTL_TMUWCF), 100)) {

-- 
2.54.0

