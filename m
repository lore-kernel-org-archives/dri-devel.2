Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62825D6AAF7
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 18:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C73CE10F314;
	Thu,  2 Apr 2026 18:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WzjNxAxy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62FF110F30F
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w+AFoIjJWMfDl0fLlh7XPv8jCcCk0VbZ9EZRQHANEuA=; b=WzjNxAxycZLVr6X0VIp+rSnudO
 1NHDt7bQH+ZDjXGuM5a1rEDbCq4XkmdDDRiuGzr1Wquynh3U4Y2GSt4sxev5IqV0YKGXU8xmAw24S
 WeIrQUKbsCFJc/hm3PvB8MGmi+FHgm/W6RT7TkO8vtkGXrkpaXwgEbw6qo2jncyRSBx6g/aWGExXp
 +VQlkNEHzKMFSUCZkfMXgltudzLLToKcXprujBM9BMWCR5Ps9/yx6a+e1K1gsH2Fvho3hNz4nHPVx
 qNr0nCAexXfGT8PMopGuxjjG2YHVALa4m2yMbU6bvkuPLBSqeqFwEOhuLjl/AVOhEHY+OyFzHzKSA
 OjeTQ9lg==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w8MuF-00AaZZ-KE; Thu, 02 Apr 2026 20:36:39 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 02 Apr 2026 15:36:07 -0300
Subject: [PATCH v2 7/7] drm/vc4: Use unique fence timeline names per queue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260402-vc4-drm-scheduler-v2-7-d84afd35c602@igalia.com>
References: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
In-Reply-To: <20260402-vc4-drm-scheduler-v2-0-d84afd35c602@igalia.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Melissa Wen <mwen@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=5jH7MmTKGo/9KmRdBsXd6h2WNsUQToXjF7XUWs6rO5g=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpzrcZrI9OzNxdPIXzZLmuUTdzoFNFrQC7JFxyW
 5w2ekhsWrGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCac63GQAKCRA/8w6Kdoj6
 quSqCAC+mFtmOgtAGUg/HIiFJR9KiBhoSyJg/CG0PQrYJuTS/+oSWbTUblU8KF9BoOkArFSxVaL
 KDDIYSHZN62ro7qv3S50FN4Fg3XV6b1/M/NwIetoP1TLAeIzII4K/Y/Z3aayU56SXwphUBTUbve
 rzYujnyTtF0Ethu6nG4eh9gTQhUtSnvt8AYXjOtiroCOdpXb9PKgKldQJ1/FACCxXOk2RaehzL8
 9J4QAoyippHd3TkczD6NQhZf41bkL3tpX4IWWoaGv+Muo0H9gMDvqNnzG3XXs7hZly9c/frxXjn
 8U+mZW+xI/uEWLFVKMwdRQpanxQVn+ibQj7IcvUxFn+oirum
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

Return distinct timeline names ("vc4-bin" and "vc4-render") from
vc4_fence_get_timeline_name() based on the fence's queue, instead of
the generic "vc4-v3d" for all fences. This improves debuggability when
inspecting fence state.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_fence.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_fence.c b/drivers/gpu/drm/vc4/vc4_fence.c
index 12f1649832388d81f1887ae484df7054e0f6010f..1078598311f4283ad4d2acc7c4dd0742c7a13afe 100644
--- a/drivers/gpu/drm/vc4/vc4_fence.c
+++ b/drivers/gpu/drm/vc4/vc4_fence.c
@@ -48,7 +48,16 @@ static const char *vc4_fence_get_driver_name(struct dma_fence *fence)
 
 static const char *vc4_fence_get_timeline_name(struct dma_fence *fence)
 {
-	return "vc4-v3d";
+	struct vc4_fence *f = to_vc4_fence(fence);
+
+	switch (f->queue) {
+	case VC4_BIN:
+		return "vc4-bin";
+	case VC4_RENDER:
+		return "vc4-render";
+	default:
+		return "unknown";
+	}
 }
 
 const struct dma_fence_ops vc4_fence_ops = {

-- 
2.53.0

