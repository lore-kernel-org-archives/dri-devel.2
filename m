Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1382E1061B17
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 17:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7332510E557;
	Mon, 30 Mar 2026 17:52:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PpWKh4rR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7665B10E63A
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 17:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9BpczLQFYeQoOjynUwNMH2f1dtK+EYppE6GoXY6Zo60=; b=PpWKh4rRltZplvwOLKajaqUUZK
 pTTCJQpojGIu/yXYwY269+FG86tsJZuIPFSh9E+WNfuH77ktNJy5tx6yptsFtU73BdQtLaOx4JkcR
 GwA2wQfetBx3QYqkpqJRBSXTXurE4Q4KRbZ9GDtkldFnf/zH5bewTrteLMvSqFPmdKiSxCXrZI0x9
 Yf6HF4Imf6OS6idmyhnh715d/uEdGobouidPtmMxKktjDCyWiMKOJgLarZW2qQm30bJMTThHpWjcM
 ViVHGWg1Kh9C0voT4+SEE5LSgCb9qwGhhoFAh+GyvXpfpuo7b7THigAkaJyspZMzeHo9CEPtTLzwC
 LKPaVq7A==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w7GmS-00961G-OG; Mon, 30 Mar 2026 19:52:05 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 30 Mar 2026 14:51:44 -0300
Subject: [PATCH 2/6] drm/vc4: Fix memory leak of BO array in hang state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-vc4-misc-fixes-v1-2-92defc940a29@igalia.com>
References: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
In-Reply-To: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=E4x0vtpcuWFOSWU8xQM26GIb4IN9G3SdhcPQ6UHAq/g=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBpyrg45O0MIQYcCTvv3Yic7wgdIZNkFDxJPafbu
 9LrZWv9/eCJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCacq4OAAKCRA/8w6Kdoj6
 qj4MB/9AEUQbGRC/xPtezOKAHo4At9hxAGN48pvPBRhQbTfhdWb80VmMJvs+bggysrd6EtWpyxD
 lhzviIc6csa+/cSVSxSOKCzz5+fx5srfWrNdj0fMM6oGUXwW9Ss9UrXrJtNOYdO5FRQ2jHXrpDV
 EA0QjlPO8vsyX9OIHzgR9+lTBxfBNSK+W93c2Vl6hPJpJsNv0nmz3ombWFKhFIJI0nFcT1Gd/GM
 r3awbEbpcGRysYbxv3HvXzwYyxYx+DIYNA7bEnP1aRNFQ0WzqyCdJi+t4cMui1kUOoaUV8MI2Pf
 lB7lPXP3ULILuq8iOLj53DQb0DVoZacBZToqfeI0eTgaNwS3
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

The hang state's BO array is allocated separately with kzalloc() in
vc4_save_hang_state() but never freed in vc4_free_hang_state(). Add the
missing kfree() for the BO array before freeing the hang state struct.

Fixes: 214613656b51 ("drm/vc4: Add an interface for capturing the GPU state after a hang.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 2d3df5e621c1a2192656efd6fc8940ebb1ce991f..248c47665a193fa639a481f97ac2af634f415384 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -62,6 +62,7 @@ vc4_free_hang_state(struct drm_device *dev, struct vc4_hang_state *state)
 	for (i = 0; i < state->user_state.bo_count; i++)
 		drm_gem_object_put(state->bo[i]);
 
+	kfree(state->bo);
 	kfree(state);
 }
 

-- 
2.53.0

