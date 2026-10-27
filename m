Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D5606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=h1JW2PLH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E4D10F835;
	Tue, 27 Oct 2026 21:18:11 +0000 (UTC)
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com
 [209.85.222.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1FA10E4A7
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 21:17:56 +0000 (UTC)
Received: by mail-qk1-f225.google.com with SMTP id
 af79cd13be357-93f3c89594cso15451785a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793135876; x=1793740676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zsNgHJ8iAmtzJGTNqienx9MClbhu9el8HYv2/8DaD5k=;
 b=Mhs18eYjR7Wgbmor5lPdv5NITAWts+LDruxPlsgEdWmCGSaM/QCMgLeBik0bOAnH0V
 2afW4qM228uV3UseTV30IKze5HmJ11aHjw5J9vsgjq1ahDuOZSlkQsJGSbPWdmkZ77A3
 ncKr1RDGXVpQFWAwhove/UN9oijj76hGhNtXzqeal+qE6B1mrZ5HHXgbxqN+J7ZigVH3
 mpgPLdM6Ec5COHPZBnHtfX5z4MKwIeoCZ26CHn4x9yuzNu6lJHBqDAfNG+CveZ7iv5D0
 PAip65rJ9C+WNCT+0sbCS5vB4Xdq1E3oQEOkLTeVh3NeLb5LNasPd2iHOGZEopzY8Pzx
 8z6A==
X-Gm-Message-State: AFq9FYK1XpIP+JlUcuWNpCqfPRuxVbXb9ABKjBz6fBvEO3uKTWQOWKQ1
 2hVIlHB46QZJbYrzmrUlaxE8YGlwUABYJUA7BdcwNraXU5CQ2LhRngIeqZGub5XYu326uaSap8h
 QNpWTPm1YsYSKz2JBFLA5K2ohnG2Z9cxHzexU64ZF57vdbloQHNj5+J1zzpE2AkIsKrXG9nBRmW
 SOMLn3gyydYRRMhgeirBglANEj7BopCk25p2RHP/VECHm/UT0Ybb+EQJRyg+seZi2Ut+O6NoXj4
 HOTdeRKZXi4U9a35g7j
X-Gm-Gg: AYBFou3Vm4eaKE8coGadg+1+Y/7v7DnZprRTEIWgphFCbJcOzlcn8hNpE7+ksgKsGYR
 JqX20rnbNYHg9R9OCFuiYpSXwufKmmx0dz8JLYmG/U0XolxyeUstGtcKIeCY02GazKNDJFILL8+
 0QW2DZEiWytklmar2WowXcVfLUd+gF3PfOgJydtpUFTwpNBSRQV/QODay2GL7ZNM9YRe5dKPMux
 CTRHucOky+WKVQY6tzazaLsDn9bHUvjGgCXVKi4ioFuSoe2baMhdNh9njF/8U8rJTyciCnQzS1P
 JdrutbwFbHAPk98mH8ySSW+g8g3ZMRykIIwfxPKsFZuSc4VVeVrz5A2BoIb5MLh5MZsOIDxz6eM
 1dhSyX/rg6+3kMFT2zwqNkBJNgmMOCGrxMw04AC7oZiOcQdzUwyfTIccjNojZGNdss2xT+LlIs3
 hvcz+9rsHvOdpoPiDk5LCPO7hzfOeullYk
X-Received: by 2002:a05:620a:6606:b0:93e:4ede:893c with SMTP id
 af79cd13be357-94408a26c19mr30290685a.14.1793135875744; 
 Tue, 27 Oct 2026 14:17:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-940f0a75ea7sm152406085a.16.2026.10.27.14.17.54
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2026 14:17:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so499093eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793135874; x=1793740674;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zsNgHJ8iAmtzJGTNqienx9MClbhu9el8HYv2/8DaD5k=;
 b=h1JW2PLHUFeWDOr4AFhJViZMn/JaB8km/BKHnFfbRaQygARHWXNmlLF79fK38xJjwF
 qwndh0H54Rxg4+vNZ7PLUOHKKVcMEa9pWwoCwQRPbsujKGFxd0OXknnkM4NFBp9uGZXN
 B3Wul6ij9pFRfNZCyc0O/YCWF8x4GY817sAc8=
X-Received: by 2002:a05:693c:6010:b0:35d:8c3a:38a8 with SMTP id
 5a478bee46e88-36a20404e36mr915140eec.39.1793135873810; 
 Tue, 27 Oct 2026 14:17:53 -0700 (PDT)
X-Received: by 2002:a05:693c:6010:b0:35d:8c3a:38a8 with SMTP id
 5a478bee46e88-36a20404e36mr915043eec.39.1793135872129; 
 Tue, 27 Oct 2026 14:17:52 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 14:17:51 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 maaz.mombasawala@broadcom.com, yunfeng.li.nb@gmail.com, tomas@slax.org,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 6/6] drm/vmwgfx: reserve cursor MOBs before unpinning them
Date: Tue, 27 Oct 2026 17:17:29 -0400
Message-ID: <20261027211729.646988-7-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027211729.646988-1-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vmw_cursor_mob_destroy() unpins cursor MOBs when discarding an image from
the plane's cache or destroying the cursor plane. It calls ttm_bo_unpin()
without reserving the BO, although TTM requires its reservation to be held
when changing pin counts and LRU membership.

KMS clients issuing repeated nonblocking cursor updates can exhaust the
cache and reach this path. On a lockdep-enabled kernel this triggers
reservation assertions in ttm_bo_unpin() and ttm_resource_unevictable().

Reserve the MOB around ttm_bo_unpin(), then release the reservation before
dropping the BO reference.

Fixes: 485d98d472d5 ("drm/vmwgfx: Add support for CursorMob and CursorBypass 4")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index 9e8ea9e07f40..b678e5b68db7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -166,10 +166,17 @@ static u32 vmw_cursor_mob_size(enum vmw_cursor_update_type update_type,
 
 static void vmw_cursor_mob_destroy(struct vmw_bo **vbo)
 {
+	int ret;
+
 	if (!(*vbo))
 		return;
 
+	ret = ttm_bo_reserve(&(*vbo)->tbo, false, false, NULL);
+	if (WARN_ON_ONCE(ret))
+		return;
+
 	ttm_bo_unpin(&(*vbo)->tbo);
+	ttm_bo_unreserve(&(*vbo)->tbo);
 	vmw_bo_unreference(vbo);
 }
 
-- 
2.53.0

