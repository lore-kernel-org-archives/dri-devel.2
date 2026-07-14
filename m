Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87631C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB09010E65E;
	Tue, 14 Jul 2026 13:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HiYI8UOI";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A4710E65E
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:27:36 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-84a2dcede83so1303888b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784035656; x=1784640456; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8LdAoJKwXyAPy2Oxe1p5of7f27uz/x1w5QiaYqvn624=;
 b=HiYI8UOIErp7iKUOGCXdauVFRAx/MK6zpXrEe53jGEmP9dWwTh5ebPNCS/XjpWqOsM
 +9eWb59XXKI7Mp+EU18XzQ78iY1KRlvxu4lBCeR3Lf8uMFOaFiNiQHMmrhjwanVellmq
 9pvnYFxHexRQe3G97PePnQAaKek20OBcs59w5rtTFRVPNFtyaE7aPC4hQ5dF/nQvh5Uj
 n1Fd4KgpEtRg21BoiYKo54tkfw/4vw3CmvyUCEYXsd4jT9gkAs23wnEiRmUzX+hl3fx6
 xoJ4e/inFDPuJwU0BVySCaHasLj9jUfs/sED4WP8UfqqO3xOkwWPAjJoDjUHwWqFhDhM
 H0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784035656; x=1784640456;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8LdAoJKwXyAPy2Oxe1p5of7f27uz/x1w5QiaYqvn624=;
 b=VGpH3lYryUwJ1KrYladfN5FcboPqx6twIyHfemgv/xpSk4RA1RTaLiupFweeLuUeu0
 XCQNMZcPQBRw+LH/2znbnKdgUxkxFArH3J4BTpjv6kQB73BhDC7WcHDXChGxZsHSW4QF
 s4s6sJeq/nKMM/R4jqcqTEm1Ren78xRUyCbyqmDuNP/HXoni/A3PZ6mrO6+5Uvh0TSff
 zpXG7EfOjR8ZSduzLdd2+52hfHruNcDkkOhWq11srw2gX+Fv6eN74n8VIfvAKdXv9TGV
 PfPudHkBdR0p50Z16+DHUTHdiRCKAcfRMUpP1k59bawkFUtPk8d3sfllnhq5kA2v7cGQ
 0j5g==
X-Gm-Message-State: AOJu0YzTuyoowTnCxdGaNNkK4giNVSlq+ODtAxu6ASBOTL1f/OB50uUz
 aQ8+7L24kbVEJtNI1RtGRV2JdA0USSxxnaKLMDaVSfGEcG3Sg7HdD7V4
X-Gm-Gg: AfdE7cl0usSYwGuWmTLd8QU5bpQi/C8GsxeF1CwO8Y+vKv5r0jOfnBO5KLom9GIl/jo
 ad+d8F8+aMydRyKWKAbcLNds1RQm4FCSJLQ/7NIKeIvoz8rGUhySh4rQPRF5FRdCXTe7u8UvXO2
 FB7U4xMOSgF4y0uvI/ZdJ2f8TStXEiGDvYaXDY5DH3jZL5DBWAAdxCNLVpMeBhcDjszSIjB19Ji
 U2A0aLN9tYIWm1XI6iZPHQ69PI6Cmo+1h7ZpmLh+EjjZRDIicW3CuIrXWFKZOugVzOcsp9I2CNz
 DUkaUuORKHOOskNnvZOxGDpwN7xwlGHzhbkWnUD3t3hehIiLxjdpxnNyDbmOPvsGmcMwzJDXQ3S
 kk0kVwAJuGwJ8/wKfgx4tr8DG9nYE9e9aBztRmLFNso6We8ZKdSWX/VaO4WCt1U0qe+2lsS6q1m
 +by0yfbWQXPa6GE7y1
X-Received: by 2002:a05:6a00:3005:b0:848:76af:db34 with SMTP id
 d2e1a72fcca58-848897b575dmr13368022b3a.76.1784035655743; 
 Tue, 14 Jul 2026 06:27:35 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f819a92sm1513008b3a.52.2026.07.14.06.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:27:35 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v3] drm/prime: use dma_buf_fd_install() to preserve export
 tracing
Date: Tue, 14 Jul 2026 21:27:27 +0800
Message-Id: <20260714132727.200995-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4ccf4ae5-ccd7-4bec-836a-fcebfa271c96@amd.com>
References: <4ccf4ae5-ccd7-4bec-836a-fcebfa271c96@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

drm_gem_prime_handle_to_fd() open-codes fd reservation and install
using get_unused_fd_flags() + fd_install() directly.  This bypasses
the DMA_BUF_TRACE() call that dma_buf_fd() emits, so observability
tools relying on the trace_dma_buf_fd tracepoint silently miss all
DRM PRIME exports.

Replace the bare fd_install() with dma_buf_fd_install(), which wraps
fd_install() together with DMA_BUF_TRACE(), restoring full tracepoint
coverage.  No functional change; the fd lifecycle (get_unused_fd_flags
→ work → install) is already correct.

Note: this patch depends on dma_buf_fd_install() introduced in
"dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds"
[1].

[1] https://lore.kernel.org/dri-devel/20260714114654.3885457-2-shoubaineng@gmail.com/

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Baineng Shou <shoubaineng@gmail.com>
---
 drivers/gpu/drm/drm_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 9b44c78cd77f..fe3436d1235d 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -524,7 +524,7 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
 		return PTR_ERR(dmabuf);
 	}
 
-	fd_install(fd, dmabuf->file);
+	dma_buf_fd_install(dmabuf, fd);
 	*prime_fd = fd;
 	return 0;
 }
-- 
2.34.1

