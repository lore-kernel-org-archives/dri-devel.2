Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAD606A324
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMy0oZJk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEA7811270B;
	Fri, 30 Oct 2026 10:28:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504E311270C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:27:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C24696061A;
 Fri, 30 Oct 2026 10:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52A51F0093A;
 Fri, 30 Oct 2026 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356073;
 bh=ALFcEyRPTf7cvwVXvg60ATQfpRyrOoNNv4QnFFUcE8o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SMy0oZJkcjs3u9GJ67ePHkfBXiPrywvIq5Uyx6RmQ2T0HhgFGzzvBqZIykCjWdTEm
 lgxEyp/5bnafxzVq1tpbXSuR96370Sk4bkoKoR8wuqUbFMTkhk9hCwA52gSPWLgkjI
 scctUeG2GEo8/yWVHgbaecFducPjI7hXwZsz5NaYWyA6QnxfcWOdKIs/SplT7lP4B9
 FKIfjJVl6qockMjeWLkRBd1Y+ds2h5aUNynC35RVKFdh+5pY/LL2ai0sliNr11TIdL
 Q7Y6XzFhAPIcJrfak5ad7VnWSvGnKOhyS29ENo2UWxk04+R8KiDAUGz8A2uZyZr07L
 fKJkT+vnsMw6A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 11:27:34 +0100
Subject: [PATCH v7 02/16] drm/solomon: ssd130x: Drop the init-only
 assumption in ssd130x_crtc_create_state()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-reset-state-flag-v7-2-4e55eaeae683@kernel.org>
References: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
In-Reply-To: <20261030-drm-reset-state-flag-v7-0-4e55eaeae683@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1361; i=mripard@kernel.org;
 h=from:subject:message-id; bh=OxfYEuitawviViOrDlDI8bSVA28qVxksy6YOiUTMG/Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPCiVaJWz23/lxbkbZM77e5ANORk0Hak3X8T5V4uBUq
 DvzrbWtYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzkz0bGhtsqGoedZuoU5wtP
 Yy4MTr/6xlnR964U93HW3o1uB9qXcPUcYjweJZj935/v8JatMbKBjHVaU6pE0j4dtHD3reuZlLa
 kP4a/Rsmh6+iFq9fUYuMEWGcbFt2YXHV6/uZ535Qq9hmeXAUA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ssd130x_crtc_create_state() implementation warns when the CRTC
already has a state, assuming that atomic_create_state would only ever
be called at initialization time to allocate the initial state.

However, atomic_create_state is documented to have no side effect and
can be called at runtime, so that assumption doesn't hold and the WARN
is a side effect in itself.

Let's drop the WARN, along with the comment documenting that
assumption.

Fixes: 1345de7fe9114 ("drm/solomon: ssd130x: Convert to atomic_create_state")
Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

To: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 4901a1835f44..a6dbefb37b2c 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1755,11 +1755,8 @@ static int ssd133x_crtc_atomic_check(struct drm_crtc *crtc,
 }
 
-/* Called during init to allocate the CRTC's atomic state. */
 static struct drm_crtc_state *ssd130x_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct ssd130x_crtc_state *ssd130x_state;
 
-	drm_WARN_ON_ONCE(crtc->dev, crtc->state);
-
 	ssd130x_state = kzalloc_obj(*ssd130x_state);
 	if (!ssd130x_state)

-- 
2.55.0

