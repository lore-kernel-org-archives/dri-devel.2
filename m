Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7068010A3D8C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 12:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD60410E97B;
	Thu, 26 Mar 2026 12:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="EEvb1ne1";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CDD610EA01
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 12:32:34 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-48544725bdeso17378215e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774528353; x=1775133153;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=DCR1+XiCejEoTZukOGzTXx300luMCdEPMVOduAGAhwQ=;
 b=EEvb1ne1z2Wr5Btsec81XclUeC/t7ZhXFrGPj45DtKB6wE58t85PjR8NlJ4FRCU7Zv
 0OCAVv9MilPRXvfRm2mquCvDF+vuVbpN2DCrtMp0TOLea8EhO0CMjDWrsKLxNGBExlDa
 tezuMOuGoUATnB3fQejcEc+xyDHB5hGMVcdj/dgsyF+0da6c7SSb0YdLm3LtnHWQX+yP
 Nw/Yceudx3McbiNYbWs3w0gzQsaxNmpo09TX11P++OYV90ipeybOYa5ef+GjcN2TgREG
 TEAFBx6kgAnRyc0DD/gH/QGQqgH/I2qDpa6UySCZiNJRbfEUSSU7m9pEtxP0n2c2VWN4
 yfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774528353; x=1775133153;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DCR1+XiCejEoTZukOGzTXx300luMCdEPMVOduAGAhwQ=;
 b=VeEk3OZ1+4wbl6bsNKcbDJ+BbIQ7p4Kb8cO1z9KFx52bkv0lbjZ+uYlm62ywKlRJpN
 FEOe/vonW8jxh+kfXBZvZuBP4VX9QJ5yXZuQnuCdbSaUAEcEOgzfKFCoh5CoXpxUAuJ+
 JlxgF84vp0V8bw9sz70m141kfbUx9UbYuHkpOhI1ajiVkB2urdbPEtAADOKuLT6S6aZF
 86ofLmNBU2mlDbwaNOLaZ0/984vjL194Yyf0OSiEn4sq5smM2H2el459kFV+XCVk358K
 OZOkS4a5ENPPHvJpq4hMqJPiL536Ad0zElX6p1haKSmqHYo3JMdKuCjm6Jfb78y1Zez7
 e0kA==
X-Gm-Message-State: AOJu0YzlNRwCwvW83XTtgmKGYwzfQxJTjpBO2UmvwVK303ENC7OxExzp
 NpfInekIylChpS8nxiAO5HG4RTvwOxjib5yEhL4f4pjo1G0G/Eh6kSSo26tDLbNfkc02WDCIncM
 p+LkCUEgk/mN1lw==
X-Received: from wmoo19.prod.google.com ([2002:a05:600d:113:b0:487:238e:327b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1d:b0:486:ffa3:592 with SMTP id
 5b1f17b1804b1-48716071b2amr111318865e9.24.1774528352832; 
 Thu, 26 Mar 2026 05:32:32 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:31:59 +0000
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Mime-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-gfp64-v2-3-d916021cecdf@google.com>
Subject: [PATCH v2 3/4] mm/kfence: Use special gfp_t format specifier
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
 mm/kfence/kfence_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 5725a367246d9..10424cd25e5a6 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -263,7 +263,7 @@ static void *test_alloc(struct kunit *test, size_t size, gfp_t gfp, enum allocat
 		break;
 	}
 
-	kunit_info(test, "%s: size=%zu, gfp=%x, policy=%s, cache=%i\n", __func__, size, gfp,
+	kunit_info(test, "%s: size=%zu, gfp=%pGg, policy=%s, cache=%i\n", __func__, size, &gfp,
 		   policy_name, !!test_cache);
 
 	/*

-- 
2.51.2

