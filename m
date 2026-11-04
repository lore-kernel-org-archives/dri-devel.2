Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11E606A329
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zyPaXlBp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7011E10FA21;
	Wed,  4 Nov 2026 07:53:03 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF7110FA27
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:52:57 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so151778f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793778775; x=1794383575; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OWS8erEqBwwq3aHveLY854LGBihUxBRE7Vkb4G0BYjg=;
 b=zyPaXlBpo2Xlp1nmdQqJZH1P7pUn4YTxt3K1jl4laZ80j9Udo1xx6dUiP3u5PBs59Q
 PbfCVcRzDZK3L4C753ns/NTvgKpuSF9pdeX6WSrfgO4TO/PPOfcU4oGgMWwi0/XKyDK9
 lJ5oGvfSZYGrZVNlgt/CRcd++S9esajpwwitvV3X3N0vQOZctLd3FO5LJp/DfZlWr+8h
 X5Dc6K6LOL5aH2sGm2SkBmMVgK4wpLujW/I8TWPTxtTKhoU4yQxbOx15sYJ5ewVdN9R/
 jhY9iImxFgp3Mf8D24VvO4ECnArInSxyeFMwRHC+qHoE1CL9dqmjbkLvdIf5poGikmv/
 TgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793778775; x=1794383575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OWS8erEqBwwq3aHveLY854LGBihUxBRE7Vkb4G0BYjg=;
 b=hPlkWiC3WsgjWeHeaZ4XmZsOfwhLwUW9CUfxV24uaie14qvYylWdQHYX9NQLzzM6E/
 CHEEvMxS56r7WYH1ZJU28Hubb/yzaQP02J0T61Rw4b3/aCR4qrxWP8d5NV5MUme/TRVq
 QkfB6vxjCRDHOY6/fetEnGphobvqzbopiK/ZqtgOJYbvqnvAh9j+lBoFqJUzlp/MAxAr
 oSsL7QDJmtqZsOKVmytYxOhwQ3oNJW2G9jTnL1srlN4dooaxlhlVrbJBRmpPQ+Fpk9cg
 CmV2PE3AGDXo1ibMyRlynp03vXG43VA63aNTwy6+XXqNVtuzmHqBvR39/XfHIsIbsk0j
 VD2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByLdyoTY+PuL8Fsyfv3gehvHnHmY2P8mHeJWQo36TYk7/25sXLkwNM0AtSLBRi/orfnMEfuvP4ZjKw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/FCj7sS1shZsVN9U+geNopbzyMHKHQdu27352sxU2dUtQP8bag
 Brhzod8vzCZUyBR5jz0vIgF2QGdoYRbVUfqn6tT4VU9kBCtQEpZHibhe
X-Gm-Gg: AYBFou0U8zr2tIaVPJF6qB9EBF6BKYjy+7LLflR8HD4wGO8k29MDGsaHpeFTI2Xblt3
 6SNVaphKOtMesUCEyWiBgy8PqdyuAfQRuPs7Em3gBBkLCoZm46Pgbqiw0pOD4vHxUfttf6brafe
 H3qDq+DdoIAFMJVswuyzGPChPPha9AD6IA00QcYUdQa5YlFN181prz6pXgjbphsCqlkEuYC3CIk
 LWteirqzOQHY6BcwfD30FhKEOP0o7Z9P8v/MzixPA4/BXqtUso0FHxkZMDkFavRvucW1NLUBwfn
 eKPBaQ9GOHnqX+3tSRXL+AaFQU7M8NKrdpcK0ztswBZOq33zGhmy1OvBCHGO8HS4ewyysdQtE/r
 RXS5Fp6e1SH9wGI7ywpCTQBJ7d9QCxuEnoN+aGL8JeHBUakWAlQTo0NzeRPNdkWBz5z6s+Xy3pF
 EdFo9Kyw0w8F61cRuUqa2GblFUR9QsIDjmhExa9V0YANisC7eNfX6LXAXcztF5RA1+FcG1YNexd
 msvfxBf9rGq+4J8wWobEOELfJXIj4fajP6wJSkLU53TQDflJKw3/jETNbwnUDXVhamJJKf0es55
 c0iD2zyn/xT1ZmRcREy3XX99NR4o1RXH6dDCG8UVTg/sQn59BcZz0/D1Sc2mK1gORnbLn556oqv
 gRiW/apX0VWX6vLB9zJcy6w+CKX8HqpDoz8blNKZZ8eGfDaGADvvk
X-Received: by 2002:a5d:538d:0:b0:487:197a:5c1f with SMTP id
 ffacd0b85a97d-48e6e4f8ebcmr26263132f8f.49.1793778775414; 
 Tue, 03 Nov 2026 23:52:55 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda207d8sm2200785f8f.52.2026.11.03.23.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:52:53 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 04 Nov 2026 08:52:41 +0100
Subject: [PATCH v2 3/3] drm/panthor: Bump the driver version to 1.10
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-panthor-fault-info-v2-v2-3-673b31f3840c@igalia.com>
References: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
In-Reply-To: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 Paul Toadere <paul.toadere@arm.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

VM_GET_STATE now reports the last VM fault and GROUP_GET_STATE reports
the fatal error of each queue. Bump the driver version so userspace
can detect this.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index fb5fdf848dec..139654628ec4 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1803,6 +1803,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
  * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
  *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
+ * - 1.10 - extends VM_GET_STATE with the last unhandled VM fault
+ *        - extends GROUP_GET_STATE with the fatal error of each queue
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
@@ -1816,7 +1818,7 @@ static const struct drm_driver panthor_drm_driver = {
 	.name = "panthor",
 	.desc = "Panthor DRM driver",
 	.major = 1,
-	.minor = 9,
+	.minor = 10,
 
 	.gem_prime_import_sg_table = panthor_gem_prime_import_sg_table,
 	.gem_prime_import = panthor_gem_prime_import,

-- 
2.56.0

