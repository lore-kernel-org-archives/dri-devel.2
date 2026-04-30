Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D5BCCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC4010E403;
	Thu, 30 Apr 2026 00:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Jdzfvloy";
	dkim-atps=neutral
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 808EF10E419
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 00:17:20 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so263516a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508240; x=1778113040;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AKT3S9H4WnE844AHNhHBE43WHE6sUwgR8j1cxMy99NI=;
 b=b6XCSPi9hEi5mII0MjSokLF/fVU6WbOb5pChAer5JmPHNlY0+s8rx8Paok9Tehvs5+
 +oZcht/q0d00d126DX4ZZPKVhAqT2w6Rhx1QCyYwq4bdZXToY88I934s3SX0D4RoLwN5
 jdC7Yvhxikiv6Iqgnbf0QqREgBKyama3vxk8MC2oQCovfrHV4rYH/qMvJ0DIq94n5G3y
 mLJ0XZoST1n8py7IHQNilT4HbRbGcsSiQNJvIrpXJL69UzgWxSsdPCOpgmunh0qrPTvo
 k5Gz72cxTSa9x3wMKxSQE5tX+PQ/mkqkXbnCRErzlpRpaF7SMuVmWU0ehFVsGFdg0jXC
 ZRgw==
X-Gm-Message-State: AOJu0YwIl8amiITYFbliq2e3ya4RRaS1UnvspQHNWG5KN6O+KacvDzZf
 +o4DGrXNkndKLQ/WsOSxxysIrMn1MeybZW/GSBcpfMlZjRVPrXt6/cYxhr87W7fJCuUqZEyBUpg
 3hbpk2y+LA6+/BNQNZOIfbkrdv0CgAzCTqNAd7S5iU9bTrDTmD1Mjld3Vj81K0eKsMivNc3G4zA
 2N7ZIY1wDgQsf/8gY0V08e8/3r7FA15WVZUSmNJIqrLPgDK+Y48ZLzAKbT8kvU29Cyr3pJ0lIAK
 FamtEoVEiSuPkiUggPf8SkYwUqk
X-Gm-Gg: AeBDies3Cc8QYKz0Qf0olWvtE2Rq7QZXJOGQ/l/J+0vhllJyvq/PHkFAQPpGL6wV8PX
 BgeIcIA/rsWLaWUeqslvbGg3fOCbLudS2+tA5ctmW7QME3DWK6bAQweMd2n62m3o795A4O19u2D
 0GoPVFQhb1fUMPNBeV/qmnrLdYgKkD+Il07npH7qzgl6MFn7SCmUCWyivyuxglJuTZaoF4rWnk0
 K0FeCXip+jmwcfbhpi9QrkY95syY74/c9r2PMATR+PUGEygcqo/NPd+rZxLsMjeGe73Ym2jtTq8
 JxbYFNxDzke/nOnP67KqTzQzRI54ESxYJS/Ti09SqEyhL+xcflSBeqc26Sv9ZwJShHEvqc3eCqc
 8CH/uMc4AFI0aOt6Qkun0utdIVJY9xcsa8m1Ey8vZdoMkosQVNWBh+jQpK1BeVgDhg4gmSQi9xe
 E5Um9j+SQNpytdWCJxHCue+GBchDoP256TvFYyDvsZRxuGsMlDKqZjoHDYWX6LaMCAz9ycIK0X
X-Received: by 2002:a17:90b:4a51:b0:35f:ba8e:150d with SMTP id
 98e67ed59e1d1-364c312dcc8mr455891a91.14.1777508239961; 
 Wed, 29 Apr 2026 17:17:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2b9889391d5sm2987805ad.30.2026.04.29.17.17.19
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Apr 2026 17:17:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2eaed3d96d7so451947eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1777508238; x=1778113038;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AKT3S9H4WnE844AHNhHBE43WHE6sUwgR8j1cxMy99NI=;
 b=JdzfvloysxBtSY67PuNtebYlcUOSmt3/iZQJPrG3pPUtJMBGXFCBTSumD1S3aCtI1q
 pkXxkSp8meLKMxK+V4ye7JOZk5+qre6qOpGJZTxaFQfumJZ9imbez6j6fEESthUVVoZX
 bkoMSY3oKMgTytlP4BM7v+qlIjrlDV3fZClM4=
X-Received: by 2002:a05:7300:ad10:b0:2d8:c484:6b6c with SMTP id
 5a478bee46e88-2ed3f868055mr228426eec.25.1777508237884; 
 Wed, 29 Apr 2026 17:17:17 -0700 (PDT)
X-Received: by 2002:a05:7300:ad10:b0:2d8:c484:6b6c with SMTP id
 5a478bee46e88-2ed3f868055mr228413eec.25.1777508237239; 
 Wed, 29 Apr 2026 17:17:17 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c0ce05bsm4173885eec.26.2026.04.29.17.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:17:16 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH 4/4] drm/vmwgfx: Change ttm refs for dumb buffers.
Date: Wed, 29 Apr 2026 17:19:12 -0700
Message-ID: <20260430001913.482967-4-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430001913.482967-1-maaz.mombasawala@broadcom.com>
References: <20260430001913.482967-1-maaz.mombasawala@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Preserve a ttm reference during dumb buffer creation. This keeps the dumb
buffer valid for framebuffer usage and fixes all igt tests that use dumb
buffers.
One tricky case arises in the igt test vmw_prime@tri-map-dmabuf, in which
the gem buffer backing the dumb buffer is prime transferred and the
vmw_surface which is referenced from the prime handle. In this case a
reference to the gem object from the surface remains persistent and causes
a memleak.
Fix it by using a separate refcount_release() callback for the dumb buffer
surface which puts the gem reference.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 31 ++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index b2d3927b5567..c600983aa571 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -2220,6 +2220,31 @@ static SVGA3dSurfaceFormat vmw_format_bpp_to_svga(struct vmw_private *vmw,
 	}
 }
 
+static void vmw_dumb_srf_refcount_release(struct ttm_base_object **p_base)
+{
+	struct ttm_base_object *base = *p_base;
+	struct ttm_prime_object *prime;
+	struct vmw_user_surface *user_srf;
+	struct vmw_surface *srf;
+	struct vmw_bo *vbo;
+
+	*p_base = NULL;
+	prime = container_of(base, struct ttm_prime_object, base);
+	WARN_ON_ONCE(prime->dma_buf != NULL);
+	mutex_destroy(&prime->mutex);
+
+	user_srf = container_of(base, struct vmw_user_surface, prime.base);
+	srf = &user_srf->srf;
+
+	vbo = srf->res.guest_memory_bo;
+	if (!vbo)
+		return;
+
+	BUG_ON(!vbo->is_dumb);
+
+	drm_gem_object_put(&vbo->tbo.base);
+}
+
 /**
  * vmw_dumb_create - Create a dumb kms buffer
  *
@@ -2327,12 +2352,12 @@ int vmw_dumb_create(struct drm_file *file_priv,
 	 */
 	struct vmw_user_surface *usurf = container_of(vbo->dumb_surface,
 						struct vmw_user_surface, srf);
-	usurf->prime.base.refcount_release = NULL;
+	usurf->prime.base.refcount_release = vmw_dumb_srf_refcount_release;
 err:
 	if (res)
 		vmw_resource_unreference(&res);
-
-	ttm_ref_object_base_unref(tfile, arg.rep.handle);
+	if (ret)
+		ttm_ref_object_base_unref(tfile, arg.rep.handle);
 
 	return ret;
 }
-- 
2.54.0

