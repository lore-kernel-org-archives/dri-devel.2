Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED6C606A336
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HpmPQ1jz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D685E1127BE;
	Fri, 13 Nov 2026 20:26:23 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 406401127B8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:26:18 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-8b3a332105bso13472167b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601577; x=1795206377; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w+kCu6WK7U+ZujxNB+KRdzvyXNVntn6A2ePv72/M09g=;
 b=HpmPQ1jzu8qsdWfR4aJQ+YuIpIoyBO8u03fX2XBk0Zg8f73cC1dW5kJ39Bwmfln+BG
 C3C1G2IPzDeT3sTrNykUK/zexeDSWaDCSRp2NRzbGKXMFMsZa0Qkw3Eu2pRK9nLeZ1pw
 76RxXhGv94AZLFgm2aR3Hm4CIHtL3G3RE/UgaAVTlpBkDFrx1WtKHB99toGwsLKeiN4y
 oTV/IlvLk4vEvOqr9ntAX/xghtP92qz6g4O9+DV3zsDmpnw2fK9rmb9To27g2z5fjLhv
 q93cIc44NR6bNzqPbrKts1Yluem1NJQ9Tl/BEdlq2WXiE5Y8OtWzOjz8DoROt8kE3iqj
 L2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601577; x=1795206377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w+kCu6WK7U+ZujxNB+KRdzvyXNVntn6A2ePv72/M09g=;
 b=dAJDFYnwqnt8jyqVMPsrP+TQD0n8bxHblfhoONaGNATpjTngdL2sntWnji/4T41keX
 E7+OiGAJWC/DA6iCSVwU7/kaDj8BHtvzCLzgoqElWVeTrvV3fLoCCJhGqVl6PRdG6HHC
 gEyzI6HJAxyZ2DIwRgNZ9KT8TrBMX2cfeJRwJX2fi1Z6PaLftXL7yYtElBAay0rWI9ak
 2QYxdJH2/xV9qBOxcLloz91twcQh4J6DhwXsUKMDxiFjoCPRA7imjqaGVAp1bOzXKfCW
 EA+HGpu5WpzX9Lz51g9zd0WFfdkeOOeEnZ59Uy6Lc2agQZLuVvwyicUMkASqesxVT0up
 Xjow==
X-Gm-Message-State: APuU4Z8ek6p0dGL5PYZRYtO2yysCx8kKvf3tN80i4Tk9VNOOWCq/eFye
 kV7oG1JXf+JQDURlew9BFougI3PGCcHRGIYqV67vX/JhpbaYh3/wqwrpfvyd2p2iA5c=
X-Gm-Gg: AYBFou0lZxrUOZ4ReNpTqZu5x3/OAGRo/bZWVw/lZviWzMT1vUkP2NqbVQnfY4heLbh
 N72LKOGZz7TqXS4+d0A6WfUK1+Jo6urJboro2igdWlZdGfIMqMIGBAKWTnSDoyWV7CKaqWLO0fl
 a/puYR6ZuBrZ2v43u+Zy1Ah1fJxhHYiNiLycqPWhDxbjDMXMBzqI8fs3kPEUWVwZVVtqC0ZVKWs
 1y2I4APXVyqBoyQPiqaQRVgCHguBMXwNBMdTEEL8XRjOkZPc0WopFO2vBEUq+1Yq21VKLZ/FG4m
 R+hB9z3Uz2rqS/vtY6yQ0OTE0LHxFu49lWoPnUuVALqHrGSZH9q87UAghVBPR+h+vOXzp5ZmlkO
 v/bziWQRlfZW0VzK4iG8Ems3S64xsaDyr4DH8deSyartHebkdC/a+bcCibX7+py2ec5K5aRuQH6
 P0OvOLXE71vU0lCGMP1q0UQ5uLNXwLEcD10DNEuqq0rn1pXazZKSUWpHcKL/PB9aBQPgh9UXunP
 U5O7m1sXXDQW4EkvEX95Lah6j5lD/85219Nwx9dVJhAETYWw/3u1ZXRKOqKZco8jmSK3YmDHsrY
 dzurDZYGj2wn6D/xtR8qTvNCe8vo5tHbM5yGQghach+3KrNHatypIepW8UYgwIZJUxo=
X-Received: by 2002:a05:690c:6e85:b0:8b1:46a1:28c7 with SMTP id
 00721157ae682-8b4aa22f3a9mr24460357b3.12.1794601577013; 
 Fri, 13 Nov 2026 12:26:17 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:fd83:f7ad:7c00:7806])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa9549fasm28932227b3.21.2026.11.13.12.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:26:16 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH 4/10] drm/gma500: calculate the cache-flush count only when
 needed
Date: Fri, 13 Nov 2026 17:26:11 -0300
Message-ID: <20261113202612.15372-1-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
References: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Do not divide by clflush_add when the CPU has no CLFLUSH support. The
cache-line size is initialized only on the CLFLUSH path. Calculate the
iteration count inside the conditional block that actually uses it.
This is independent of the directory-entry mapping lifetime fix.

Fixes: 8c8f1c958ab5 ("gma500: introduce the GTT and MMU handling logic")
Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index de2dd41ad23884afa486162d3fe8f9c3a4149684..34ae0f125b83380b735ae454c775775cd74d0f62 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -265,7 +265,7 @@
 	struct psb_mmu_pt *pt = kmalloc_obj(*pt);
 	void *v;
 	uint32_t clflush_add = pd->driver->clflush_add >> PAGE_SHIFT;
-	uint32_t clflush_count = PAGE_SIZE / clflush_add;
+	u32 clflush_count;
 	spinlock_t *lock = &pd->driver->lock;
 	uint8_t *clf;
 	uint32_t *ptes;
@@ -289,6 +289,7 @@
 		*ptes++ = pd->invalid_pte;
 
 	if (pd->driver->has_clflush && pd->hw_context != -1) {
+		clflush_count = PAGE_SIZE / clflush_add;
 		mb();
 		for (i = 0; i < clflush_count; ++i) {
 			psb_clflush(clf);
