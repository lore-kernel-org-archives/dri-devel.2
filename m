Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067E610A3D81
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C46C410E99B;
	Thu, 26 Mar 2026 12:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="kRQJ3uFG";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1549F10E9A7
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 12:32:33 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-486fcc05b20so5635375e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 05:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774528352; x=1775133152;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=44Rl4IuwAjVXDZrVO8Bc7181pdJEclCn1gduNsTGsBw=;
 b=kRQJ3uFGDbXohs/hom0LL5NtWYzVP5Y1d0f8hVgrtq7zJdBcgDp62FBYtWn438KGeh
 zyEjRLMTdwNw9nPmgqhWMd7RWTeFWQCTlkEhB89rSNJ/w11MkBh6nCXD5ybMy/AUCH3/
 xqti+IygqUPRTZTufmVnyUII7j7S46p2xM6jV0cA23IBzdq5QENwkdLxAtHi94O9z0ED
 ghi3Jk/I82SIz8mRPBcEPuymHwrAjtNAKNrFzARcpDbOgUOpfcd23Q94wgsjiDVrF1qX
 k2uHn59iiqDfaWPHFNMwQm9GrU+m/XaAEPjAkyyjRGzBlNUGxbX32wq1ojJASUKzNXK/
 tIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774528352; x=1775133152;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=44Rl4IuwAjVXDZrVO8Bc7181pdJEclCn1gduNsTGsBw=;
 b=IlpUHEivtlvNtHU6KQo1SB2KBO4dk5auV0y1aprRPlGUv04oZfRIKkLXubyyWXfT1F
 HayhPhuBWTYTVYQF0nksYzvHGDhiEJtBBNydUhSq36uN9tAQFNI52ESsR0T9tLXPooXi
 5u45uF9A5PXmgasra3PEEaKukfPGYpwpndU8Y2YBJASRv8iF4HoMV0CuZWHJji2+9aou
 VyD1sAh4lru4bpSSBJAeYlHFj3XiEylMDhuNGpCzt/nynsttNxT2ilQCJXz/UN5duO+V
 tdQHqn3gvj5q0AHRtQ5B8lzzA/Lee2KelYXSntdEYvOQ5BYuSFlQ2HiDzrkWowT3FsGg
 NYCA==
X-Gm-Message-State: AOJu0YwESdIaIVkGes+Tk4rVl872RWwbue+BZaAlwQsmg0MpYE2Rk7lS
 hYPH+mmQwrzmfqv6jtLIOA36NQYhJdzsgJsBShtpkUDHZgc364c0rzcE7I/TDvP4xl06r4Yaihv
 uPXjVJ07CuVO6cA==
X-Received: from wmcq12.prod.google.com ([2002:a05:600c:c10c:b0:487:247f:cb9e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5296:b0:483:7783:537b with SMTP id
 5b1f17b1804b1-4871605bde7mr108915255e9.24.1774528351509; 
 Thu, 26 Mar 2026 05:32:31 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:31:58 +0000
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Mime-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-gfp64-v2-2-d916021cecdf@google.com>
Subject: [PATCH v2 2/4] iwlegacy: 3945-mac: Fixup allocation failure log
From: Brendan Jackman <jackmanb@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Stanislaw Gruszka <stf_xl@wp.pl>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, 
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, kasan-dev@googlegroups.com, 
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"
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

Fix 2 issues spotted by AI[0]:

1. Missing space after the full stop.

2. Wrong GFP flags are printed.

And also switch to %pGg for the GFP flags. This produces nice readable
output and decouples the format string from the size of gfp_t.

[0] https://sashiko.dev/#/patchset/20260319-gfp64-v1-0-2c73b8d42b7f%40google.com

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index c148654aa9533..88b31e0b9568c 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -1002,9 +1002,9 @@ il3945_rx_allocate(struct il_priv *il, gfp_t priority)
 				D_INFO("Failed to allocate SKB buffer.\n");
 			if (rxq->free_count <= RX_LOW_WATERMARK &&
 			    net_ratelimit())
-				IL_ERR("Failed to allocate SKB buffer with %0x."
+				IL_ERR("Failed to allocate SKB buffer with %pGg. "
 				       "Only %u free buffers remaining.\n",
-				       priority, rxq->free_count);
+				       &gfp_mask, rxq->free_count);
 			/* We don't reschedule replenish work here -- we will
 			 * call the restock method and if it still needs
 			 * more buffers it will schedule replenish */

-- 
2.51.2

