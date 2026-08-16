Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A405C5DF77
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 06:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6AE510E66C;
	Mon, 17 Aug 2026 06:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LYvY28Iq";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A05A710E1D0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 16:59:05 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2caced6038eso29136685ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786899545; x=1787504345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W/bWkRDD/8tCi2rYvKnRL86bl2Ul1nCW6kBe/h7DI90=;
 b=LYvY28IqORKGs+wN/MQYEmUODJ8ehr1V8TS0niKiVVbKRFMJso/Bs3P870P/joO/+n
 zmdtTa6LqErSh8KX4fYNf8hp4nOERv4oUmXjNQuTTTtn/Ze+n6M9LubCykII2KiIWsjn
 dqWHPoBMy+HflKPlOgQquCAyaR+cF50qqHeC5Ix7iM2d7HcBxF2b1hjenKApr4VSOK1l
 D0m8s2Lc7JxR84haZc6/I9SQDtIA0wXTQFksTvvMXe0vbHhXwK7DbuiAgAPa9P8S15wC
 YvzHb5QoRbs5ybDCThCR5Nd+O8Vgvohg1N6EeP8LaVPYl2Ji7H5ZXqIllWiQ22M4Unm2
 zUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786899545; x=1787504345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W/bWkRDD/8tCi2rYvKnRL86bl2Ul1nCW6kBe/h7DI90=;
 b=EuIAG1Z3b4IE9SpUzBOSqR2il2x2BsWvI7YgEU6nnV4nXqBWtzacsdSHKXczpdgGwM
 JpgBFfZYxTvu3S7TIg3MnBdGVn8Xr6NDP4HIAPYSoMvUW8vrNpxVaqJAUY0O5eGzlCoP
 0f/O3e/yOFfWOuhnTKH3WieVX3up5yeIIUb1lBLl0H2SOZx3fjUMjFX3ezWAFd062GQ+
 pXGgNSQlP3QOHJ1Gxe7lWPgmpOwQX2sucqory4g6a2zEjeKG5FfWw5UpXGdVZMDhekA5
 uSekxCE9g5qlGo9dqpNK0I6VInvgTUQtVGfQjDZ/SkfqcfTLJ0Ygd2iA4RtVvjmI3OxU
 CaTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkU7pAANhLNevaroB6aj60aRv9sB2aAZuGvWLiiJAY91eK1Oxdc9OYfyYKMBwZgSnnQZOJmjc1x3g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxqYL8werOnmPFZMkZ6ycpUrW1vNQL/qFpDsj5EjnkHsW+QLxtF
 ZIMLvd62re8OloqzaeaZxJstFouZXY8bSMnhSmNjvSWP31QqiDzX3WY=
X-Gm-Gg: AR+sD13p2ULIGRM8io39d5g2NtYdD0p00IX8thtXhht5MM66hvmpyE/go3Tvw/y+psu
 koOGT9gnXFcIAAwgggxslu8ZS3B+/nZ9/fM7WIrqkX5kbitJgipH1tHGexmDj0pg3HAm4zfjxwu
 jUxLTipU/9wZEgxHQWjsZ3fCdx9PY9f9tfOEog5gemGeLemDblmR492eXp+1FI3SoE8LbRDnf4M
 dVQdPLg3AixG2ucOQzJi39mIj17ul+ZXsyIAyNP9MZcMvyXJeFEvTLPoSAh8Eh+VkCzyx2WlQAT
 RS65J/7FIxDNIKZfb90mVH+K8uD6bKBTroWE5ffMzjY68H9oHzf5q4mc4n4jnYLNn2zhCuomHtr
 OJy2v3XB5Q8ZTW6m8QHmsDqVmgRYrxSYV2kw7r3WgGXqI8AKPAqZq3AsdDYOrm2AsDZ695uZXzH
 NcV0KU3If7jCbwfL8OzLLqhzfz4Ws/86UrX1OSkKmkcN0If64rZClEXx2E+PgosAc6DB7kcc1N4
 Po/8A32ZUvB51UhyF5jaiCElu/XKKnCFl8U8cw+pbyXi7mf4EfFQg==
X-Received: by 2002:a17:902:db03:b0:2d3:c3b:c7cc with SMTP id
 d9443c01a7336-2d37f5d0f8fmr268465995ad.3.1786899545109; 
 Sun, 16 Aug 2026 09:59:05 -0700 (PDT)
Received: from
 codespaces-a1fa80.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([23.97.62.128]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320ea2fe8f1sm28362823eec.23.2026.08.16.09.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 09:59:04 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] drm/gem: Handle shadow plane state allocation failure
Date: Sun, 16 Aug 2026 16:58:52 +0000
Message-ID: <20260816165852.44558-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 06:55:17 +0000
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

Allocate the new shadow plane state before destroying the existing
state, so that an allocation failure leaves the current state intact.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/gpu/drm/drm_gem_atomic_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index abef865c5..24a0b9398 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -308,14 +308,16 @@ EXPORT_SYMBOL(__drm_gem_reset_shadow_plane);
  */
 void drm_gem_reset_shadow_plane(struct drm_plane *plane)
 {
-	struct drm_shadow_plane_state *shadow_plane_state;
+	struct drm_shadow_plane_state *shadow_plane_state = kzalloc_obj(*shadow_plane_state);
+
+	if (!shadow_plane_state)
+		return;
 
 	if (plane->state) {
 		drm_gem_destroy_shadow_plane_state(plane, plane->state);
 		plane->state = NULL; /* must be set to NULL here */
 	}
 
-	shadow_plane_state = kzalloc_obj(*shadow_plane_state);
 	__drm_gem_reset_shadow_plane(plane, shadow_plane_state);
 }
 EXPORT_SYMBOL(drm_gem_reset_shadow_plane);
-- 
2.53.0

