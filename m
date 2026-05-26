Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1212BCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 12:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4972110E467;
	Tue, 26 May 2026 12:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="JAFLi05R";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A0BA10E36E;
 Tue, 26 May 2026 12:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779799180; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J5/aXeNJoNsDMUc12mPOt7oD9wPgqnulbGv4fiAGFXNsaJ7oWxqb6L+NKAl0blAS59PmRxpujfkU9MFu70HBoIq8aNE5rSbsTeUFpCSB0dOTJvQaxjjtSpkRkbjmzRfJ8jIpLmrzTuGZEuAdscfVmZne00n6yvcV3KxJXfLJXiA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779799180;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=04M/WlycYK2BomwyYt5pQqBLOPMQe9a34LpIH8MaIEU=; 
 b=JckxsRybezqKmYa5A5i1IZtYZ9nHr/NP/mBoB3QR4MfC2F0tXucbH5IrvtBdl0mXTcKZwPDl9aOW/ia0Z+og4uVZ+9DoFwrGHnniKJ5KG4sCkpl5hFV0hfHzusX+zPFyHNe/DL8TP5b64jXvTQmEB4zsv1dclXjvQabVSoz4WZg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779799180; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=04M/WlycYK2BomwyYt5pQqBLOPMQe9a34LpIH8MaIEU=;
 b=JAFLi05Rpxen1OrN1yMwV9pChMTJg5qvUeZPqmZ0Fh/yKvEQI1Lmp0Iq2WLWP8Sb
 L0xHRnqpc6FlF5QgmNTC0eSwYcs4u76FiPKnrh/GjNHHrNNvJAEV5MC6CxoTKAdu8Y4
 lkWGBwJmyDfmhASCAalWcMFc7OaGERqyfYXcExwc=
Received: by mx.zohomail.com with SMTPS id 1779799179666381.80891477192324;
 Tue, 26 May 2026 05:39:39 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 26 May 2026 14:39:10 +0200
Subject: [PATCH v10 1/2] drm/connector: Fix epoch_counter docs to reflect
 reality
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-hot-plug-passup-v10-1-f62351a9ea3e@collabora.com>
References: <20260526-hot-plug-passup-v10-0-f62351a9ea3e@collabora.com>
In-Reply-To: <20260526-hot-plug-passup-v10-0-f62351a9ea3e@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>, Daniel Stone <daniels@collabora.com>, 
 Ian Forbes <ian.forbes@broadcom.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
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
Reviewed-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 include/drm/drm_connector.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 5ad62c207d00..abd58e98e4aa 100644
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
2.54.0

