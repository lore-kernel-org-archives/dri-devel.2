Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBD3F9EDC5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2926E10E9DF;
	Wed, 22 Apr 2026 12:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Q4pCkfPU";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 074F910E9E9;
 Wed, 22 Apr 2026 12:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776861359; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jbajX/vy5W+wbLab0aolJ8UjGZcOqzSC/I5BRI9iDjgZ+0nmWWaIrV2Rb/Rz7SRgL/XdrSJB6MxGX+rzXms8btD1KbYtuEgml+xLk6J71jWnIlrAOhVZMvt5QvZjSefiyt2qq8kl2n1gZ4mPahzrfP9Ki4GXCsCdekhXNIm1eqI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776861359;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=D1AqcgSA0t2cNb738fE4oVFHqUU80ZER1l31sqHNos8=; 
 b=P7BsjDQfqgdzVG7VfJ2EaZPBSaa45+8iRB8hfWolDOq/td3zwF4wflzeJVR1gw1U5bbrulqROJv51ClNvuQULuY8Jio1gI0ePwnwssxIwLiOPR95SkrhfkmJwiMDEc4FcCRej4feLuGGFhCMZKZPw586l6RoTC/h1AiABuqUhFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776861359; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=D1AqcgSA0t2cNb738fE4oVFHqUU80ZER1l31sqHNos8=;
 b=Q4pCkfPUl3KcMacJC59qXrzvZ03rG06FCdXhk01m7OK0Siagzpf1BNFRBFoc54T5
 SS1jqLPtkd53uQKF/qI7MEu/LaK1C9bFpp83e45DXeETy3waPY34W/Bf1DST1LWhKpe
 GJtJpdHdy6A8jsfkAHeSL/QRYWrc92XswIaFVWaY=
Received: by mx.zohomail.com with SMTPS id 1776861358716268.8573147783461;
 Wed, 22 Apr 2026 05:35:58 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 22 Apr 2026 14:35:31 +0200
Subject: [PATCH v8 1/2] drm/connector: Fix epoch_counter docs to reflect
 reality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-hot-plug-passup-v8-1-5cfae6ba4119@collabora.com>
References: <20260422-hot-plug-passup-v8-0-5cfae6ba4119@collabora.com>
In-Reply-To: <20260422-hot-plug-passup-v8-0-5cfae6ba4119@collabora.com>
To: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, 
 Daniel Stone <daniel.stone@collabora.com>, 
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

Since the very day epoch_counter in drm_connector was introduced, its
documentation was not accurate. It claims it's used to detect "any other
changes [...] besides status", when in reality, it's used to detect
changes including status, as a status change also increases the epoch
counter.

Adjust the documentation to rectify this discrepancy.

Fixes: 5186421cbfe2 ("drm: Introduce epoch counter to drm_connector")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 include/drm/drm_connector.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 3e422a4f2e72..446385a12f4b 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2264,7 +2264,10 @@ struct drm_connector {
 	 */
 	struct mutex edid_override_mutex;
 
-	/** @epoch_counter: used to detect any other changes in connector, besides status */
+	/**
+	 * @epoch_counter: Used to detect changes in connector. Increased when
+	 * the connector, including its status, is changed.
+	 */
 	u64 epoch_counter;
 
 	/**

-- 
2.53.0

