Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A844110A3D8D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFEDB10E94F;
	Thu, 26 Mar 2026 12:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="JU/1jyB8";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F18310E99B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 12:32:35 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-486fc42c83aso7335105e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 05:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774528354; x=1775133154;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=PnUmSvdGrdA8wXtaJVKX+3lGQinclElGewhzWnJqPks=;
 b=JU/1jyB8Cjk8GIwIyYdEPEcxPsZ/N2KjNzfiYBaXYUOHPD7s9AnIw8JjbNyOV3UMZu
 6XBP9CfqFP8KHm+FRCgEml6wF87htmTHmq8jJycaG1n8ILNl+1ui9zqMLxQY4AZ8Pvs6
 sh97IOXi2dzz+/6MyeeJu8Pialm1hKjf68kdakmWTE6lf+bGuZ8O4z3sRnjb02BPOK+C
 c07l5zZYYKjf+e43CA39PTAdp3F5Dv3mdxj1bDRQIUvTStKfBbdMtB21XJSqVQ5tbicv
 uEkXnraJt30MSGFOhXhpuqGQimeYPzusT/kGpeLrq6BwY4wack5m8ZSgbzxYpbANYb6x
 iKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774528354; x=1775133154;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PnUmSvdGrdA8wXtaJVKX+3lGQinclElGewhzWnJqPks=;
 b=H4QTPodCI0oVLcg2mxY2aThw3Oc05q4XPOB8aKKRfGm6p8XX9M2Z3HjjWgGREfBppO
 gU4VYGboyS6fRYoeK8hiRoHigNY7M6olTB/68b1K6QuiMeW/5Ru+NX0SAf5T4mX5lKAu
 NcDoFN0iLHbXRQ68HnnOxM9ReJDKxcRS2oaaRe7pphGjKwR/HuRopWzSNKYUXzrwBAZ2
 CiipF7vXZXTBt2Zr9695p5wbLbJgsQyDzoRlfjLuUHEPy0qsQUKUlists1n3AWRxgqTN
 F0f3tQaeGhVYjer9x9YfV6i+pHKgMK7PQFmZJMk2JYkTDkwBE8LsTz7XDMWyS1gHGe31
 MykQ==
X-Gm-Message-State: AOJu0Yw6hvXp+WA1PlrnjnCNcjM9i1D8TGIAIjDbEWkvMtQJ64aT0aX6
 IQKopqXxDQkwrEL04ydtjsWGGmj9tOtL4/oyR1JlroBFt+6ZloQ1HEwFZYI6mS28laMUoDvzEp0
 x8jrdOoryX8pR3w==
X-Received: from wmbjr7.prod.google.com ([2002:a05:600c:5607:b0:485:3682:6cf6])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f95:b0:486:f308:94ec with SMTP id
 5b1f17b1804b1-4871606d88cmr107670785e9.24.1774528353854; 
 Thu, 26 Mar 2026 05:32:33 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:32:00 +0000
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Mime-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-gfp64-v2-4-d916021cecdf@google.com>
Subject: [PATCH v2 4/4] net/rds: Use special gfp_t format specifier
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

%pGg produces nice readable output and decouples the format string from
the size of gfp_t.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 net/rds/tcp_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
index 49f96ee0c40f6..ffe843ca219c7 100644
--- a/net/rds/tcp_recv.c
+++ b/net/rds/tcp_recv.c
@@ -275,7 +275,7 @@ static int rds_tcp_read_sock(struct rds_conn_path *cp, gfp_t gfp)
 	desc.count = 1; /* give more than one skb per call */
 
 	tcp_read_sock(sock->sk, &desc, rds_tcp_data_recv);
-	rdsdebug("tcp_read_sock for tc %p gfp 0x%x returned %d\n", tc, gfp,
+	rdsdebug("tcp_read_sock for tc %p gfp %pGg returned %d\n", tc, &gfp,
 		 desc.error);
 
 	if (skb_queue_empty_lockless(&sock->sk->sk_receive_queue) &&

-- 
2.51.2

