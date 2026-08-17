Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8CFC5DF7A
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:15:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC0810E847;
	Mon, 17 Aug 2026 15:15:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BTTAmIaY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2A410E83B
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=HOaK+9ew2fQUD/uuOJbHniUuJxdRpWSyxFk/GCwKvzk=; b=BTTAmIaYgmiTOrDVsYrGpCjTeu
 6AyOiR1KFS2CULS8zoCGl5bpwSpfF+aIx4k+TszOW8Mu66Gl6o7a5V5VFZY5XWPkvoXOqaS8pBVZD
 okfj1wMaW1eCPU9yUCQhLZxNKjL/mu928Gbr1gzDXEag2YRVfu6SrQFKpa6Zk+YyVwoya8l7b1+Qr
 f+nneli4Zsr6ezZb0XLb2HnYBSWfPdRpjt9HbllINesA7cqW4omb2YOdcHU9h0tmFj2Djqj+f0hH8
 3H/GYxyuPw78TJs2Tcwx217D3AMTzyKryyc3ozSUL4dK03VqU/3wmmZhZcvMYBtdky3z73+EIeV7k
 CMqx89hQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wvz41-004eWD-9u; Mon, 17 Aug 2026 17:15:49 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 17 Aug 2026 12:15:32 -0300
Subject: [PATCH 2/6] drm/vc4: Hold a runtime PM reference while allocating
 the binner BO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260817-vc4-irq-cleanup-v1-2-ee6c592b3836@igalia.com>
References: <20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com>
In-Reply-To: <20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com>
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Iago Toral <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=DGfWyN0zxC2G4pGaxeh0EcpblIAeHh8a0hPqD9C0bbY=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqgyWdT6K1HZfnVIW5pn44sNU6In8uVTpb6vjog
 EJs3YDvj8WJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaoMlnQAKCRA/8w6Kdoj6
 qqf4B/9+tJ7nFLhjzOQHgq0Die7NaUSkj0vYTs1Jos126hltl/W/+LVGVpzfNXic0RG79tbBh6D
 FIqYrFf5ggpcnlBSELAZjgB9BE4IyRDmEVzE3ZfH/uK0ERslULM77afUtwlIgMijnWYvctWVfzN
 43yMIyYjcfc8TfcQjj/dl1y6Wsd22zegh/0W6SYAQ2fkUon/RBzM61OtddpZSeC32UQfMMVEyuB
 e6OyntKrz6Zob5el/9vmYdujVlfRlF2vemIZZkzG7KY/MakkTNmTwaW38x8jOrvMAAyhetOqCa/
 Lzd5Mj6S6UnL2SijnIad3MbOGn9c20JNFmgLgsV11NmNl+kn
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
index b943a003bcbc..9aa8985e0428 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -305,11 +305,15 @@ static int bin_bo_alloc(struct vc4_dev *vc4)
 
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
@@ -325,6 +329,7 @@ int vc4_v3d_bin_bo_get(struct vc4_dev *vc4, bool *used)
 
 complete:
 	mutex_unlock(&vc4->bin_bo_lock);
+	vc4_v3d_pm_put(vc4);
 
 	return ret;
 }

-- 
2.55.0

