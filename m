Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F761C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4E610E700;
	Mon, 29 Jun 2026 07:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="uyWKnZ8s";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EvpsmjAo";
	dkim-atps=neutral
X-Greylist: delayed 545 seconds by postgrey-1.36 at gabe;
 Mon, 29 Jun 2026 01:11:24 UTC
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87E010E68C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 01:11:24 +0000 (UTC)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailflow.phl.internal (Postfix) with ESMTP id 8828F13806BE;
 Sun, 28 Jun 2026 21:02:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Sun, 28 Jun 2026 21:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1782694938; x=1782698538; bh=2JPnAbSDSmP8R/2CHZgsM
 EyB0GwqJMdGStmyXvvIbKk=; b=uyWKnZ8sM2kF7JVjZNOZ6lpyuEPgcBS+mNiaA
 kGPioTOHuBjj2HzFRVcWJpMWCnWS5PSQeTmCHMgNsHz+A9lcFaRz6+2tRfQBG8hn
 jADSlKjP/jHFFSqnaHCug7TAecNQONPo2SLGVjyUre09RPE4PM9Kh3XKIImqdkcE
 o7/fuN9SyBTaoxu4+VKiCA+UUAYxaOF+A1/uk80gInjo2G1l8OcPn37G8eCvfDpm
 Zlzcim9t4zrHrNTVRFZHhNqv1bVvHcL61zQ1fBTrUY3DoS+jSliVECk2OI6HV60r
 HSuz+51XfkVyK29mjexI4bHy+OdgfphnVQNwqb5ztE1XabFXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1782694938; x=1782698538; bh=2JPnAbSDSmP8R/2CHZgsMEyB0GwqJMdGStm
 yXvvIbKk=; b=EvpsmjAocUkqiH9+9DrXE2mympg7jlM8HuIphHkuPHf11wS23D7
 aQqOb//mCqRTV68gCADfAVrmErGW5RkQdSmmPV0dA6EfYL/3kWw5RJBBsfxBAJu5
 I4U4WIzIuc3z65Qeynp7SBvNH3nMKVyrK2lb+3XgDCtLQOIhZ7Is/EiUhna9BDGc
 goirzz+JYT843567bVs9/btTm9qd81Vq/3tNBxjMtGPrchJvwb7BWHGbYwTaYrf2
 SPQKitLArQ268o4IUFqsT74O6sooUPNqNjS1qLq0QkFoSQp9NjD10F1/9QkJfXf3
 2rQ7KxP1VYe+RRV8+TymOst+NhVSmA0tXqA==
X-ME-Sender: <xms:GcRBanWoVN9b9lai5ip4o0PhDua66np0l0HOgR4gfnPy2CYvq3rcCw>
 <xme:GcRBagCO4vm9BzFCB-lpqEOOjwXzMp-G54TT-7XDFjsZa7E0QGFKq8UleCB6YUuTu
 _3JqRpnAvrMWyS2s1e_GSVDAg8F_aaabzQbEuw-6-qVNchcnsJipNU>
X-ME-Received: <xmr:GcRBakFyEaKmUi_AMb7SaHMkVRHJ9pvMLUYlW02R7jEVbM4OhOZWTpOb>
X-ME-Proxy-Cause: dmFkZTFZ0MrejrSakGhMZyGJjgcyNi0pz52z8jBRQcYsmKJHHD9cRTvLY/eQT1b+flwFVz
 vnuTAbmCksKvejlljOfJMZ4UR1KI1VN/a8SXaY0iDleWMeNHEvRRkjHi9ZUDEFOp7Rubhr
 SPEOi8AfHDMZxc6IP1iXjCkKI6kpZYgyg8zZADwBIZ+ojG+yykPyAEccHHkVnezmARnkBO
 4IJFqri2/R17xf6WqnfAh1eYa9NPDd1WigKFuxrvD+hul6G9KY+x2AvQbgjlaLHlyN6Oc9
 P+8OqKyxVxsYMwMXXYgBcsekkwEoZFdPyHBnIeNUvtI10WIga+SZ1Uo4gQDzroGgo7w3p1
 QpQ5MjE36pp1Yr/Mi1bpS5R/wDeEonyKb3QCff17C+VrCiZxNLSQe7puk1Gt1hFvR+eMuV
 hDCTyjkvqAJNAEmSxe6j1RGge6KKdut+yM/xZ2Sz7dZ3m+Ijtwi+8rgB9YFoftf8zcmjxF
 3PM9dJfZo2mnzWUK2gDk4QGmb26TAvLbP5k3eAhoCGONaVUEBp8B8bJKuFwHtWA0Tz99mA
 Obh7nlydLI/gRSaRZgGqJPfXgHYDeLZym8++MIqiNv9m5PscL+tnU8GKOB2MlamMcE2b9G
 q4Lbf2jn8SNhmVqNHj4DBMUjgLPibQTmqZZ/aMMepvDZD1u+z/36rYNTUhEg
X-ME-Proxy: <xmx:GcRBap7yy9cpiiRnYw04bXY0A2LaHPdra1c6LT6g5HGr11T8gydTxA>
 <xmx:GcRBail6Hj9LZToq5YsZ46TM0WbEjejx2xsR-fWPLxCRD8RECmzXvA>
 <xmx:GcRBas7a-53zov6Is8Ptwzqjq9CRQMqpOejE-AGd9hldoDcawpfGbQ>
 <xmx:GcRBarQV10B2F4bL-BN9K8CeOVLVjG52_XJ88ypYNtJK-EieI1Ld9A>
 <xmx:GsRBatEbO6eEPZRBYr0xTqnco5rRpMdJOpi2NlKc8DYqbcy4Th_f0J2z>
Feedback-ID: i9dce4b48:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jun 2026 21:02:15 -0400 (EDT)
From: Baran Tuna <barant@fastmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, simona@ffwll.ch, airlied@gmail.com,
 tzimmermann@suse.de, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 Baran Tuna <barant@fastmail.com>, Baran Tuna <barantbsd@airmail.cc>
Subject: [PATCH] drm/atomic: Add missing drm_debugfs_info.data initializer
Date: Mon, 29 Jun 2026 04:02:10 +0300
Message-ID: <20260629010210.513454-1-barant@fastmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:39 +0000
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

The drm_atomic_debugfs_list doesn't initialize drm_debugfs_info.
This triggers missing-field-initializers warning when building with W=2.

Initialize the field explicitly with NULL.

Signed-off-by: Baran Tuna <barantbsd@airmail.cc>
---
 drivers/gpu/drm/drm_atomic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 080aec5a9774..8ca1e21fbf69 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -2132,7 +2132,7 @@ static int drm_state_info(struct seq_file *m, void *data)
 
 /* any use in debugfs files to dump individual planes/crtc/etc? */
 static const struct drm_debugfs_info drm_atomic_debugfs_list[] = {
-	{"state", drm_state_info, 0},
+	{"state", drm_state_info, 0, NULL},
 };
 
 void drm_atomic_debugfs_init(struct drm_device *dev)
-- 
2.54.0

