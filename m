Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA9606A880
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=phpGmx6K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DDB510E433;
	Wed, 11 Nov 2026 15:05:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1ED10E428
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=eqTabTrB9OoYg0efrBMjeNfUDv69vx59ZAW/onXBCWc=; t=1794409533; x=2109769533; 
 b=phpGmx6K6fAgzjJ7NsRW3W6YZp7wNgZuN1AXoPZrQKTVbd9T/AEM/H1RlsYVidJz+p6O1llcx1l
 yA2lDw+wKcuW9XxcFRBOzzPMJeORxuVPtwTqC990lA8Uw9dTBv81+TpHllxjje/VV6PNt0mhlU4NI
 KqwafdAJfiLWkM13ReTMQ3kMvzz2T0B9UMjLYp/BvnVKxFOEwka+k+lxUpSPtZLcxA0akGQJc9y4n
 d2/UWOxcoS+qJhz+NQoLDNBEbmC8VH6CMi+lj3PJwUo1vMN6IK7FSpfC00b4jncn1tR61aLzX+G2n
 Yp41yGCHUv/+Vh7GsgybyO21g+3W9vx5m/ig==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xR9tC-008sMR-3B; Wed, 11 Nov 2026 16:05:30 +0100
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 11 Nov 2026 12:05:19 -0300
Subject: [PATCH v2 1/4] drm/vc4: Hold a runtime PM reference while
 allocating the binner BO
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-vc4-irq-cleanup-v2-1-aa757bb742f2@igalia.com>
References: <20261111-vc4-irq-cleanup-v2-0-aa757bb742f2@igalia.com>
In-Reply-To: <20261111-vc4-irq-cleanup-v2-0-aa757bb742f2@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Iago Toral <itoral@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=9OY/KFUXb73VPMf96eD4/r0Ovk0LPgxeZeR1dI6TkYY=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq9IQ1ElGOGqC9MXyaQ8XW6sKj4+prlSWqZIr4j
 KLJCr2kU3KJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCavSENQAKCRA/8w6Kdoj6
 qvFIB/48TLopQ6meAlLf3euAOoRmhbsyyy4e8TSY0LOZXXWDUS7GAfWNDYanjujoOBJRXpUE/W/
 79bemA6CDaAAxkKVX8GYWaCIjXHUbxO++zyw0ReWqSvJ0KexTEIkfUgdoAj8go0Af0gvdxhDDD9
 k0Wfkibv7qLGnXfEx1w8Ri7boJlOSklGsSyvjkdLh4FZrFTjOfWxyp8xPVBMS8cNqgMQKMAIASH
 Ysf6i0iDvQPSEbJJgCeEIz+7p+4WCElZf6qg5DM/XU3iK3IiaPwAz1pwF7A3BNYJ8clA15WIOrY
 JX/l/CHbDEnzVPRC3V9lF8kIUprNl7Iosox6lFiyZGS3EkEJ
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

bin_bo_alloc() arms the out-of-memory interrupt once it has allocated the
binner BO, and accessing a V3D register requires the block to be powered.
vc4_submit_cl_ioctl() already holds a runtime PM reference by the time it
reaches vc4_get_bcl(), but vc4_create_bo_ioctl() reaches vc4_grab_bin_bo()
without one, so the write can land on a suspended device.

Take the reference in vc4_v3d_bin_bo_get(), which covers both callers, and
take it before bin_bo_lock so that runtime PM is never waited for with the
mutex held.

Fixes: 35c8b4b2c0fe ("drm/vc4: Allocate binner bo when starting to use the V3D")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index ed3bab119979..2bfb8766d1b6 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -302,11 +302,15 @@ static int bin_bo_alloc(struct vc4_dev *vc4)
 
 int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used)
 {
-	int ret = 0;
+	int ret;
 
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
 		return -ENODEV;
 
+	ret = vc4_v3d_pm_get(vc4);
+	if (ret)
+		return ret;
+
 	mutex_lock(&vc4->bin_bo_lock);
 
 	if (used && *used)
@@ -322,6 +326,7 @@ int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used)
 
 complete:
 	mutex_unlock(&vc4->bin_bo_lock);
+	vc4_v3d_pm_put(vc4);
 
 	return ret;
 }

-- 
2.56.0

