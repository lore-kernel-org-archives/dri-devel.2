Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D468FC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D43310EA48;
	Tue,  8 Sep 2026 07:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WkOskWRz";
	dkim-atps=neutral
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1318E10E045
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 20:46:30 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-51c0c45c580so43186611cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813989; x=1789418789; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VER40sFOr0PvBhXNUCuY5FdhQBtPHE4tZxDhsZnhadY=;
 b=WkOskWRz4D7RMm9csBXsI9X+TlylcsK3sFcgtNy1Uryz4TkZN3hr/CGq3pGOHznpN+
 1IlXkCyc7jyMLXlI4c71DsL76/UlKaoAPyC8OqEM/h+RBP/Vxv5/EusyMYNaezdhyl0I
 d7wdcOI8Bn21ov0gZhNPURGu3A47nPux37DgiRSAYo3adqYla6RiokRlLyt+WMD+f2lv
 oqlTba/LEaeCZYalLwQlBNYQu471AhcakNr2t5T5hJ/iKd0ZLW0J/1vugxzL2PCy1pxn
 NYEmxRAdiXgyY9qyyjADyGFoqRxRP80YyP1iMUeyAiRmcQ3e/Vj3Fw6txE534/eKGCHh
 0V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813989; x=1789418789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VER40sFOr0PvBhXNUCuY5FdhQBtPHE4tZxDhsZnhadY=;
 b=gEatqXCQGwJX9/MchiU0rG88T/LuBNqLNSxTaZSlib0m9518zdSrDbitu3k954Q5ej
 GsgcewbjQf8dyti5BUyEiBLKxEucGxvC2lNcfDfoG4kKHxFkQAykqS6jP+Gaa1/OfhoB
 179WmnZlPs/BElGZkF+aWySkaxQhjdPM044YlvhBQUWaWr3EtbzSpXrqqIxC7j+hvoz4
 MuWZ1I2K7kWMKvlk5D2tBO0sruWl1EAIHvsFP4KeWHadB0e8YnDw3oa3Bed3aqO9CMk2
 CPG8f7HZsd81m6hiwKnUdHQ+sQUy6PDnrCECmXM+BaphHb8LLk0iqm/EQliw4A6vKDLh
 99DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwC7Zw4d2S913/7gJNMk487xcsqaw6BoYCA/kzHMloZKmtIk5t/p/S6BwCcKy4nx6ltEDovT6RqGY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lItgn2MaHKydJ+Y7mtJGWl6q6nodbajgYS6dY2rWmslxmYvXmV
 eM9ImDsagt/lSJiNzdTky4sS5La5SQatL/M7+mbA00NJu2O5+LFQQwR8
X-Gm-Gg: AYBFou1reshNGAXmhy/+XGUy3E6NU1miQz7Axea8egQIqWK1zsmOFdY1tdCMJ+7AkBG
 6FX2E9zvzDWywmKLxNQ34pXMsBPSAXBHXotFLbj+2tPxaIguS1SdkV9ITPd4isKxAkQeCtpuPpf
 Zptb0fwUgBOdMxgPEDqAKH/PITva7/n2VMKKb9gA7G6N4pMhBsuqOzVVwH+QKTvsNQYKemhRQNO
 eFTo/8WM4OUTJsn92RRvsAcdP4lCm7C49af68lCT2sad8nAdAc9NhckHHK7wvRHIwGGlHdE8QCW
 W45sZbb5mMGA1ym+Ft+EvlC72XXgoWMEiXgbLuJDbSQchrcgh/zg0bE+hZehfSTju//p53YAqkH
 DAhv3jObVrGqcXhOijEKo2u7oInaGSsZl7L4slRXs2L0/QvzVXSjLDf8/VoG1pV5Jcsbe2AKGgd
 JB6LgTv2MAXjrJU/BC/fM4Bpo3SL0tcI9j8S4Fx3n7D6wEQ3TJ
X-Received: by 2002:ac8:594c:0:b0:52f:b1b6:a4aa with SMTP id
 d75a77b69052e-530547fb02fmr294840361cf.4.1788813988866; 
 Mon, 07 Sep 2026 13:46:28 -0700 (PDT)
Received: from linux.. ([8.34.174.240]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53054180b0asm95479811cf.19.2026.09.07.13.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:46:28 -0700 (PDT)
From: Changyul Lee <lcy8047@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] drm/etnaviv: erase context from active_contexts on open
 failure
Date: Mon,  7 Sep 2026 16:46:19 -0400
Message-ID: <20260907204619.645774-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

etnaviv_open() allocates an ID in priv->active_contexts for the new
struct etnaviv_file_private. When etnaviv_iommu_context_init() fails,
the error path frees ctx but does not remove the entry from the
XArray, so the entry keeps a dangling pointer.

Erase the entry before freeing the context on that path.

Fixes: d306788b6e1b ("drm/etnaviv: allocate unique ID per drm_file")

Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 08aca9035fc1..ceb8c00d66c0 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -79,7 +79,7 @@ static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
 					      priv->cmdbuf_suballoc);
 	if (!ctx->mmu) {
 		ret = -ENOMEM;
-		goto out_free;
+		goto out_free_id;
 	}
 
 	for (i = 0; i < ETNA_MAX_PIPES; i++) {
@@ -98,6 +98,8 @@ static int etnaviv_open(struct drm_device *dev, struct drm_file *file)
 
 	return 0;
 
+out_free_id:
+	xa_erase(&priv->active_contexts, ctx->id);
 out_free:
 	kfree(ctx);
 	return ret;
-- 
2.43.0

