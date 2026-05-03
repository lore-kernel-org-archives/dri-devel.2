Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49179CD3430
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CBD910E973;
	Tue,  5 May 2026 07:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pI//y/az";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF6A310E16C
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 03:45:41 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-365212191f6so342993a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 02 May 2026 20:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777779941; x=1778384741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SI2MBPlJf9O7ukydYqfXIQUzeildkAOurtWd8SQi+24=;
 b=pI//y/az09OvWTAVBRVXwpH6H4OEt9QCCGL+3fWU1VEfJxivkPeZXCSljNH8IDgTOP
 zstjhYN1B/1IU/OIhzHuQTVo0obJR4wD4VC4o2EMao5Qfu5xeHwerDD/qUruuAEWs2hC
 IYTqZ9qVv5iiDyEdVh1/jpN2OTYEsnCg/cCmQ3JuouWu2P345ftKv2DXztK7BCx03tWU
 zsfutVL9ob0/lnjBdAwlovQfRP6wOfyJSqPC68RcEywagEP8vCMon3gy5jpUz5KgeaJ+
 Wh9BOk7lEJz3CT08xvtMUokySrE4w+5XMJ2F8kpIyZHKO5aTbvfaVW991mQX3lPqt9kF
 ed4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777779941; x=1778384741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SI2MBPlJf9O7ukydYqfXIQUzeildkAOurtWd8SQi+24=;
 b=tMpprv+0LB6MpkFypXb7HvAUiAtgga4IzLFJzBMSZWXvIGV9DGucUPzzEM/MW47clO
 LBoqHNh5ViHo15aeItrIQy79kEJ5fUg62rOFGCDnBG96ygGrXzy3hqUOEaKoWSZ9QVZB
 nduMMTXrL3dPbCOjlgsTWvSXfxvNkslpbIL4c/bmwTq2fa1j63X6qt/qCRgUbmKatxOu
 6r2DEf/XtsAdjkYmw+xuog8+3DsdaGb4WvwN0wKxL2ZJz3bR9UUHWUjfZNgoAv/If/O7
 V0QKthJVpn8J/XmBtLyosiv8in9FrIGpiTjgZIJX4BR6bXRurE3ezIHs4OqZHm0nUOC6
 6DBg==
X-Gm-Message-State: AOJu0YwExNoR1z0uvyDCAzoObPaRlTcfoRVcxqdP8gpYGizRG9tPkcSE
 q4rnebR1cwBa+7aVaGgw4qmBvyDOAay/NH4kXcaxpxfFwtDQIlnG2EaJ884z/jC3bkxcpJBN
X-Gm-Gg: AeBDieuxpxHU6svS+fAQUZE9rgt7lXLUf6FnVRqXDfOyD9xTNqCIkgm63dX6UXuZJ7e
 +4Q++vbodt2MYZ3ufJN9kgO+4DOXsoAvYExsxZNhBFDNWzbmEMbcCO1Zd8SIW3AcGU1cUo83Cn5
 SOVJAGRrulCfa/8SOf9bwP0iJScY8gapwPTI0BRVqZEBWdY9jMylacz0ydq6/D9OCrSbh/Sp8+P
 fSF5vylRTBE08wM0yZA8wDLobwcvTNq08XzIqPjnxgTNP1jutD+tRIH/Mla/poW+Kiz+fY1SzMC
 idvfLO9CGiZCN+LnF1fAA0R4Yckj+rjnREepao5Vb3Fnr9kCVYGY+zUWLoMeNgo5AEFWKD0H6Cy
 AS+rIE2fLy1ZXd3ipz4z+4QTV5swvG3cM2PidoZ5X34jWgqKm9bdt2WpyQnqSOlY31+K+WBEKk+
 7+1YXcVq9Lof+p77M6WY6Ej4NIjBrRbPANVwmFBIAp+aYmBXXMfC2ANuVWu/x6m9b2
X-Received: by 2002:a17:90b:5887:b0:35e:581c:6bca with SMTP id
 98e67ed59e1d1-3650cd25673mr5014165a91.3.1777779941198; 
 Sat, 02 May 2026 20:45:41 -0700 (PDT)
Received: from jester ([159.192.33.28]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364bdf54203sm10082989a91.7.2026.05.02.20.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 20:45:40 -0700 (PDT)
From: Jonas Emilsson <jonas.emilsson@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jonas Emilsson <jonas.emilsson@gmail.com>, Imre Deak <imre.deak@intel.com>,
 Lyude Paul <lyude@redhat.com>, stable@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: [PATCH] drm/dp_mst: Handle torn-down topology gracefully in
 drm_dp_mst_topology_queue_probe()
Date: Sun,  3 May 2026 05:45:33 +0200
Message-ID: <20260503034533.1023686-1-jonas.emilsson@gmail.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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

A hotplug or link-loss event can tear down the MST topology
(setting mgr->mst_state = false and mgr->mst_primary = NULL) concurrently
with a caller invoking drm_dp_mst_topology_queue_probe(). Since the check
is already performed under mgr->lock, the condition is not a programming
error but a valid race -- the topology was valid when the caller decided
to call this function, but was torn down before the lock was acquired.

Replace the drm_WARN_ON() with a graceful early return. This eliminates
spurious kernel warnings and the resulting compositor crashes observed
when connecting/disconnecting DP MST monitors, while keeping the correct
behavior of doing nothing when MST is not active. A drm_dbg_mst() trace
is added so the skipped probe remains observable under MST debug logging.

The existing WARN_ON(mgr->mst_primary) in drm_dp_mst_topology_mgr_set_mst()
already catches the case where the topology is initialized twice, so no
diagnostic coverage is lost.

Fixes: dbaeef363ea5 ("drm/dp_mst: Add a helper to queue a topology probe")
Cc: Imre Deak <imre.deak@intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Jonas Emilsson <jonas.emilsson@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index 8757972e8..0cb341ce1 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3738,8 +3738,10 @@ void drm_dp_mst_topology_queue_probe(struct drm_dp_mst_topology_mgr *mgr)
 {
 	mutex_lock(&mgr->lock);

-	if (drm_WARN_ON(mgr->dev, !mgr->mst_state || !mgr->mst_primary))
+	if (!mgr->mst_state || !mgr->mst_primary) {
+		drm_dbg_mst(mgr->dev, "queue_probe skipped: topology torn down\n");
 		goto out_unlock;
+	}

 	drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);
-- 
2.51.2

