Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B29C88E6B
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5251C10E9F6;
	Sun, 13 Sep 2026 20:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kA2EDqPR";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AF2210E38F
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 22:09:55 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so379935e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789164594; x=1789769394; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dk8RJ/gWGUzJZL37Z13wVy/RHkm1H9VT60iwGnpNGc4=;
 b=kA2EDqPRh8vCDwQ77PT5lzj1ogJopYxvY48BxrDNVbTYAFKFnyNS1Ye49D/z5F++pR
 LzO3hLZR6pWd8dinP1Wr5UOt+nYIb1b6lbpEJLEd5UL3XzXwKxcsqxwIn3pVNKbwNqg1
 JDB5f/PiEPkh0x0GzCYLedxlvLWJvNl7y1cuI8K7an1fhl1Dt8CN2Zcm5EdBBJNFlMuo
 LEB2LvsSJKVpzmbc3ik0glCGDr8IQbrtzrigjkeCUGjyl9/ieUVuxGo55d4VCG/5hcvX
 PIMv3+xIp7csYh98CvOhyZRPyBjakYePT1H0VhoeJsvRBwoKTjx+VEb8cR1cj6M5d34t
 jdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789164594; x=1789769394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dk8RJ/gWGUzJZL37Z13wVy/RHkm1H9VT60iwGnpNGc4=;
 b=RTsWRVKGEkfv1+FFpr3jThB4cQliOEXjMIWyICK4PUndKLniyJ+CFXdy+lEKuixfEJ
 ffaYtYcWVJERc1FUJFOKYhzQRvR7fFuXDZyJuxPTR8NLhqxWEjmkJkUxrGZnBM4+aINg
 Cg/RCxdqkXUdSToKL8OLdn/msrbXDnmFMBfnxOqUIcM/KHLD0B9Qz1AraMeYHoodTgdf
 YXpeuU+5Yg9kS3FxGE97o4VusKaNTwaOrgZzAuQ4i4rITsXatitdm1KR2WEdNBlleTJp
 8Dl6Id4NuPYzcZlj9zT3qMmR624t/9yvrw8L/wAKuSgGqbRAz0Lc/SB0EataeLg+5Sx2
 q6cA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxP1Lr9UdFcLwvzl0o+UFhIhEuPR/sH4DjY1RWEA/S9W4Of9tIGYKDYip0wnI3OdKxcvRESvynl00w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kbqigzEB0/hZjc4WxINEqlww2PGAm9IQLigV1x8ayBQJU3rRVr
 Fw2SPpKQd4LGa09yo+5WuiOI+JkNg0X+9fhIpsMNvVaiZvweYFaUtC4z
X-Gm-Gg: AYBFou0IK4XM0qkcnis268IhMIl6X5O0QudAuFS9gZkCFHKrlPf0odkQZird3jK2T1a
 hcQrLTtTjQUgaalMqYIDa1n2Dce6wJlYfxu2Yt6m6Q7Ge12jJ6cIdkLMlfGD5GPaOwL0kiXyaKx
 /M8HQjAuq5jcjoSyVxXz5dapbCXnik0OGzm2b+39Uv+7JcPFpZmy3ckhcS8OW+sY1VO7/7w77vI
 fvzVE6apgONOSV+T7FW9fFJkluY/znxCsdtLOGSDotLTyoeSvJdG7PFPgSfVEP6Y0SDLxgpiSOF
 D8bnAHcypgubBIKaYztpSon7l4XsZnNGVhrQ5T+ABtQIBcouMO7TvAYVUh9USAlBuPhMj+5aw44
 hxdDMaGfK4VKKYi9Z9+Li3GALV4+w0bp5cQs8vzURuoRukGB1vCPsNRG2nqqf2UCtJtYWnsoMwU
 FWvWedxgReIkYji3rsPmKRg7rEPVgN9ScXrWEQWFipziy10FZ5cnodtKKvMmSx+D0/fHiRnKgzd
 /ZvURDkH+558j+rhMrFATqZmWRobcjikMI9ExqtrcruMJ+pGnlDU35l2aQKQNjJCpXO2oPqyA0x
 7yh+X+0iNB9ru9942QAiuu3ncETOPuFwd4EdvZMkj4cydL4=
X-Received: by 2002:a05:600c:3f16:b0:49d:25b0:cc60 with SMTP id
 5b1f17b1804b1-49e6cc13c99mr904955e9.29.1789164593578; 
 Fri, 11 Sep 2026 15:09:53 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e69f02c92sm33383385e9.2.2026.09.11.15.09.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Sep 2026 15:09:53 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <nat@pixelcluster.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup/dmem: Fix eviction helper reference in
 dmem_cgroup_try_charge()
Date: Sat, 12 Sep 2026 00:08:33 +0200
Message-Id: <20260911220833.6958-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

The kernel-doc comment of dmem_cgroup_try_charge() refers to
dmem_cgroup_evict_valuable, which does not exist. The name is
dmem_cgroup_state_evict_valuable. Say dmem_cgroup_state_evict_valuable.

Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/cgroup/dmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 4683f3d6802268ddad40bd5d9e10305fc4dfddc5..13dbd083f6dedf83002ee7e7912e1f983e3594f0 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -706,7 +706,7 @@ EXPORT_SYMBOL_GPL(dmem_cgroup_uncharge);
  *
  * When this function fails with -EAGAIN and @ret_limit_pool is non-null, it
  * will be set to the pool for which the limit is hit. This can be used for
- * eviction as argument to dmem_cgroup_evict_valuable(). This reference must be freed
+ * eviction as argument to dmem_cgroup_state_evict_valuable(). This reference must be freed
  * with @dmem_cgroup_pool_state_put().
  *
  * Return: 0 on success, -EAGAIN on hitting a limit, or a negative errno on failure.
