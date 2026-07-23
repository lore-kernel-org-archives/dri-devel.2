Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C65BC531CF
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF68610E580;
	Thu, 23 Jul 2026 13:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=u-bordeaux.fr header.i=@u-bordeaux.fr header.b="aC9fw73w";
	dkim-atps=neutral
X-Greylist: delayed 515 seconds by postgrey-1.36 at gabe;
 Thu, 23 Jul 2026 10:15:02 UTC
Received: from v-zimmta03.u-bordeaux.fr (smtp.u-bordeaux.fr [147.210.215.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC2AD10F06B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:15:02 +0000 (UTC)
Received: from v-zimmta03.u-bordeaux.fr (localhost [127.0.0.1])
 by v-zimmta03.u-bordeaux.fr (Postfix) with ESMTP id 389AB180416F;
 Thu, 23 Jul 2026 12:06:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u-bordeaux.fr;
 s=2025032601; t=1784801185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=21cItyY5SVbKTkz7hNyqC7CX0qWcyQCvSirRm3tfbcY=;
 b=aC9fw73w0HBXPs4WYeNh203bQTTWdi1HkXTtcvRAiYMH/6LH3DPT6bXirMcC0UB1A1nk6p
 Cj9VLwLdNHtAtEQcHo7/I828DZeUT0G87J7q1vFbBMoEcFKowFHCish1pnYdXyvnaYC5BZ
 snAWnaE/0xxwBbdfd9RuXmz+BA8V4LdY16z+WOw71Nqzj4F8Kod1FcCOjBRkFl0wnyVaua
 KQR5UWZOMTNNuKItY5jbo5Shd8NoCfsZLPAZOITVoPP3ssq/LzdjDiKuWPffATErAYNGb+
 NSvpX0t/iCHKV2vw8+q9JQ2/1axaGVOFM0EZRJXlRaxqRBQqhSSlLCqr4pRKcQ==
Received: from [147.210.8.222] (callisto.labri.fr [147.210.8.222])
 by v-zimmta03.u-bordeaux.fr (Postfix) with ESMTPSA id C9C58180416B;
 Thu, 23 Jul 2026 12:06:24 +0200 (CEST)
Message-ID: <1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux.fr>
Date: Thu, 23 Jul 2026 12:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>
From: Emmanuel Fleury <emmanuel.fleury@u-bordeaux.fr>
Subject: [PATCH] drm/nouveau: Fix NULL pointer dereference in
 nouveau_fence_sync() when prev->cli == NULL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:26:48 +0000
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

I ran several times into a kernel oops caused by a NULL pointer dereference
in nouveau_fence_sync(). The variable "prev" may be non-NULL while
"prev->cli" is NULL, leading to an unconditional dereference of
"prev->cli->drm".

Prevent the dereference by checking "prev->cli" before accessing
its "drm" field while preserving the existing logic.

Fixes: 1f9910b41c857 ("nouveau/fence: handle cross device fences properly")
Signed-off-by: Emmanuel Fleury <emmanuel.fleury@u-bordeaux.fr>
---
  drivers/gpu/drm/nouveau/nouveau_fence.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c 
b/drivers/gpu/drm/nouveau/nouveau_fence.c
index edbe9e08ba0f..90e6e89c0911 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fence.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
@@ -374,7 +374,7 @@ nouveau_fence_sync(struct nouveau_bo *nvbo, struct 
nouveau_channel *chan,

  				rcu_read_lock();
  				prev = rcu_dereference(f->channel);
-				local = prev && prev->cli->drm == chan->cli->drm;
+				local = prev && prev->cli && prev->cli->drm == chan->cli->drm;
  				if (local && (prev == chan ||
  					      fctx->sync(f, prev, chan) == 0))
  					must_wait = false;
-- 
2.53.0

