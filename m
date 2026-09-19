Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C971CC982D7
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 17:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D344E10E43E;
	Sat, 19 Sep 2026 17:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="au+one7x";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521F710E43E
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 17:17:43 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3a02551822eso332586a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 10:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789838263; x=1790443063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H22gG3gfK534GA7eikUt6vOg1Uc/mcVXz/VN/miRKww=;
 b=au+one7xZpijm1AwMzFGLdDyQdLtHEBD5jdXihECmRd2qFmDhlNyOwAv2ZzgvInk+2
 rPUduyWLBHC+5oqghGqScg/kExdAT29UkQYQphfrvkeOHD4LFrTAh6O/HdcgOKgVWwsg
 Leh7irzqK62MKThcHUjfaaeRrVZSL3V63HZh7zQxjbIjrcPGZ6/zFvqTNlS8R6ivb3Qv
 p0c6O4iNBnekJXIITpu8e8rmDRi/Ls7jGY48MGw39sYigFQ3VtdwOq/bgbfFrxK/yPTZ
 zk6PbPtYuWB1JpRXz1/uJiLFqXF2ZlIxskchiDO4SKpZTwWUs5kjnYWqp010VmyJldMp
 Yktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789838263; x=1790443063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H22gG3gfK534GA7eikUt6vOg1Uc/mcVXz/VN/miRKww=;
 b=EvYBmYGR42DYsSVdZpjt8QX78UT/vhFkrk/22rls4tBEDwLoxIiKEK77NDqW2PtRiF
 AX7b7b1mtdRwPEWjIDhKwmRoexzJdDb/chLYk2521HeigPGkxiMxBHqtYYxr/D52740c
 QsdGhWeXXgxWowCFR6MmtK/07G0WJShERLdN0+9jpef6ieRJmcqZ+WJHqDsxQgWJfWLk
 uqDppt6A+JSd+SaXgeAHnlo7HMZySGLf2LXfKZaXDzH1VyrleCuhmp96FXHO9rnI/0GV
 XFIRNG9FYO+M1VU2P3Z/B7kmcM2Ju7bCMPKq4+1pRG6wv5Uvtlof5EP2EvvYiB2sGB9G
 MWMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVR5rEr9UTrtc15GcBUHGcVEKHm4T7AusGjWNcOKRIvnyEDtp3iK4YglnkmcS4GbxLCxD6MJnTsrw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nJ9jKUIngIGvx44asCg+c2ibirDtv1Sk3KHiteeRZk9WSZUXFE
 sWvhMJRZsxsL68olMKBKTbAWhHh1x2c2dtai6/DnaFuuQxqx+BMwsIc/
X-Gm-Gg: AYBFou0eUYK06XryqaY0xnPdsj+EV4QdJ72ETIp4DvrqSajexNyGlL6aohzgEcZLlqK
 XLxyk6wvvDbbuHnPtIUBvWEDiXvHMR/NQKWYqi1seP4qEJmWahVDieaLFabhMF/LUkiXVJ8oiK/
 hhA6cHDnsZKtJVgHxQdVE9Zu42jA3WzTeTgAWwOqlDjAV8XDyDUfMbhtpRmHAkEEQ7OIqUK0QG/
 4Zy1DIz+vegr3H/bHzyJVwjhmM+ncIGGySyukeyRhkJPvS2f0cXSXFjrd0Oh1osLTOlM2AmQMxB
 G4UQJh39c9Qz9XkRZc3FuIU4RDWc17cs1A8bIbx9GATbMVoqrkQcWXEqYhwdEOAE33agT6anVv+
 voZ262m0okAr6Hu0ax2ra8LqNvFBJzZsw+EO938pQ3P4rDCYWX9VKDvWRjQ5yJzQ2Gim0DffaNt
 rr5q6xy9TF9HgxyhnWE766P3eGJ8ciYo/cdxxASeqG7T29oA4M+Y57EH++Cn4dkVHO
X-Received: by 2002:a17:90a:e7c7:b0:3a0:25f0:d89b with SMTP id
 98e67ed59e1d1-3a025f0de30mr1987486a91.50.1789838262634; 
 Sat, 19 Sep 2026 10:17:42 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55e71a4sm6919949c88.13.2026.09.19.10.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 10:17:41 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Guangshuo Li <lgs201920130244@gmail.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Chris Wilson <chris@chris-wilson.co.uk>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/i915: fix mock ring memory leak on context allocation
 failure
Date: Sun, 20 Sep 2026 01:17:10 +0800
Message-ID: <20260919171710.3699710-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

mock_context_alloc() creates ce->ring before allocating and pinning the
context timeline. mock_ring() initializes the ring reference count and
returns the initial reference to the context.

If intel_timeline_create() fails, mock_context_alloc() returns without
dropping the ring reference. The same leak occurs when
mock_timeline_pin() fails after the timeline has been created. Since
context allocation did not complete, CONTEXT_ALLOC_BIT is not set and
the later context teardown does not release the ring.

Drop the initial ring reference with kref_put() on both failure paths.
When the reference count reaches zero, intel_ring_free() releases the
ring VMA and frees the ring allocation. Clear ce->ring after dropping
the reference to avoid retaining a stale pointer.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 75d0a7f31eec ("drm/i915: Lift timeline into intel_context")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/i915/gt/mock_engine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/gt/mock_engine.c b/drivers/gpu/drm/i915/gt/mock_engine.c
index 79741f043f03..fa4368730d33 100644
--- a/drivers/gpu/drm/i915/gt/mock_engine.c
+++ b/drivers/gpu/drm/i915/gt/mock_engine.c
@@ -170,6 +170,8 @@ static int mock_context_alloc(struct intel_context *ce)
 
 	ce->timeline = intel_timeline_create(ce->engine->gt);
 	if (IS_ERR(ce->timeline)) {
+		kref_put(&ce->ring->ref, intel_ring_free);
+		ce->ring = NULL;
 		kfree(ce->engine);
 		return PTR_ERR(ce->timeline);
 	}
@@ -178,6 +180,8 @@ static int mock_context_alloc(struct intel_context *ce)
 	if (err) {
 		intel_timeline_put(ce->timeline);
 		ce->timeline = NULL;
+		kref_put(&ce->ring->ref, intel_ring_free);
+		ce->ring = NULL;
 		return err;
 	}
 
-- 
2.43.0

