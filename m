Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95646FA0C2C
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 05:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099F210E0DA;
	Wed, 15 Apr 2026 05:41:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BADYS6s9";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0914610E0DA
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 05:41:07 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so28330555ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 22:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776231666; x=1776836466; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tunBQlCi4LkJrjuRpI6SbvkfyuiW6qh1ym4H60f4yAo=;
 b=BADYS6s9ZPBtJZfUuuaJnWCx2xs1bikCTYRFXWww9eut0je1U01K2FAQKnlnTCaXwv
 c6Dw2yhq0BjaWZ3E5CLcG0xteIucaDdHaHy3hAvvDeJvfl+Vu+d4AwQFQONAKGy7YvJj
 EbWj/iBbdbmEGchjUjDvGSEGD6tTr+EmjmiTtTTrUqfEbSLHwMgKbNk8HXsiTaCMMmKs
 u9qmtn7VKVi2q/33AX7AN4UGW2hwpHLapDpp528tjQbQpANhRxbOHCfx/jTIHUGVoAe1
 YRt76ZOSTsIU2Y+/dvouS+ogEEFZS8vceL0XcIUANfonFszUZqwmnn6NgMO7SV+H157a
 OKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776231666; x=1776836466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tunBQlCi4LkJrjuRpI6SbvkfyuiW6qh1ym4H60f4yAo=;
 b=tTRsIujdFJJd0svJgf1JM2vw+cXM27X7A/ZVpxrEoexaToJUsrtG2MTO0bptrKwyfL
 PcoQwiTWFZX/opdPqrFOO8KdB9fsM8CDx6FfQ1CABgr7lI6hfCG+ex8pi9wvwTY4VQCi
 SzaF4SSz+VQj/0iTXOJSn9Y02qgAXFwsufxk324L7NWN4XKvxrs10a6NqgnB/60Z9TQg
 LrZ7sHPwzvMVnvBm1K/4PDcvtjBMk6+Z2/BHMTzlsr+sqDFW4NaVKL7ZXpu4k4iGZHTM
 ws9J4rMN0RF0T+4+4BmQh1BaOymn3ycF2+c2HAa2X1Qwn62p1n5Pq7ZB9aq1cOnK4EnD
 6vWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Saohfm2+vV/aHfqjHB7+8DhIDPwsX9H3jLa2j4FFoyxNfs2lSu8JlhjtW8wXbcJi9qcxqqqOicSc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwC+aHc7iCCBBAwMIvlPWj9RhpGCjxmYsRrcH20V1dcAAgyof1N
 mJse9yAbmG0jZecXPQJvj0WI5cehSs1VVIYYS0Nw4rkDnKpEoYoE98lA
X-Gm-Gg: AeBDievKL32eUxYrwe8XgzrwZayR+kvPzc775/dZoZdFu5PkyKClVMcTPGonFtVFB8D
 pafiNU5XVo+SyZ+V26WG1S5GYHpNac68klZLCnnhjKI62DbKRozYzh3jhPIv699f81TZyEVvQUc
 SyCZAKb1Pj2ixwnLMwWoHNMrakPe5fzYs9FXcxH69ltM1+AtJ/yl5QMu/JyVrGgBs1ZDuYteyLx
 sdodkJnivLfQT5sQTEtbCWo02ndH9zo4E974+LT+JOey3WBOQCRLlz16aKk++bf3yUrszUD6Cpe
 L/518EkRhxLe+T8nvomdxF0448wBXMMxMp+1K4401NzF9qstb4GDmVpiUAt1c7iSjZZ3broSDwJ
 MiGASZk9NROB9d7WUXvYhfWomBDha6Oe1UAB0wH5xxe8OjAOOHYDtf4CHupNx9XCogi5xFh0D3r
 j/kK1FAZglynkb8GyJaCKi/EdtmAm7324DklsE/bq9h+o=
X-Received: by 2002:a17:902:ea05:b0:2b4:5f96:184d with SMTP id
 d9443c01a7336-2b45f961f07mr100131135ad.5.1776231666456; 
 Tue, 14 Apr 2026 22:41:06 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4780f0258sm7973305ad.5.2026.04.14.22.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 22:41:05 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH] dma-buf: fix stale @lock references in struct dma_buf
 documentation
Date: Wed, 15 Apr 2026 13:41:01 +0800
Message-Id: <20260415054101.535520-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Xiang Gao <gaoxiang17@xiaomi.com>

The kernel-doc comments for vmapping_counter and vmap_ptr in struct
dma_buf reference "@lock" as the protecting lock, but struct dma_buf
no longer has a "lock" member. The mutex was removed in favor of using
the dma_resv lock exclusively. The implementation correctly uses
dma_resv_assert_held(dmabuf->resv) in dma_buf_vmap() and
dma_buf_vunmap(), so update the documentation to reference @resv
instead.

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 include/linux/dma-buf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 133b9e637b55..ef6d93fd7a2c 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -322,13 +322,13 @@ struct dma_buf {
 	 * @vmapping_counter:
 	 *
 	 * Used internally to refcnt the vmaps returned by dma_buf_vmap().
-	 * Protected by @lock.
+	 * Protected by @resv.
 	 */
 	unsigned vmapping_counter;
 
 	/**
 	 * @vmap_ptr:
-	 * The current vmap ptr if @vmapping_counter > 0. Protected by @lock.
+	 * The current vmap ptr if @vmapping_counter > 0. Protected by @resv.
 	 */
 	struct iosys_map vmap_ptr;
 
-- 
2.34.1

