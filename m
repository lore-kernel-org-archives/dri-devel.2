Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75110C88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A4510E2B9;
	Tue, 15 Sep 2026 16:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W2t5bnOX";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A19C10E2B9
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:37:50 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633ece3so403060f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789490269; x=1790095069; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uyYww1vw22YFRnFO2kz8YhlMFLNE8VmPnf3mijbwEdw=;
 b=W2t5bnOX8n8Xsi6Y3RNKEZj5Dh3C2NLtL+iza8LQzAIxdyeQDX6/Wyox36RydKzY8k
 oyKHTCCef9FgXFYqA6tavR0WhGo5OIC6VXsIAlAXLffS2cS8H7TujGO1JyoIrDtwF2Rk
 W4gKNKA5ZZYaqUV0twfOdtSIVnRcfJvX0DJwWgk9pB0upCASwa9aw/9/Mh99L9tlW0H8
 pfWby6TgGPAbvN8cfslIb+FKOwtk9nm82eH1wqZaxjQ1cclULmKawFQrvVMzna8izu8x
 6X53iRU9Nn0k1r0VBzkoCs5ehgzF8NccW+K31V6dU9q1/p6CfXTWJobpJ3VF/wCy3JJK
 5YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789490269; x=1790095069;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uyYww1vw22YFRnFO2kz8YhlMFLNE8VmPnf3mijbwEdw=;
 b=JcSe59niKWZ3WBtRPLUTVXb2cQohe3puUtQuSPZpWj6DuWPsFaD3tRJzTM+6t301go
 Y3uioH1c4aXKIucey6Z9QGTs0Kw5vyKpCNRkfK8yBIIrIWLzjm0XSObw3neeEKFskxob
 mwSnjSATABO0xNu0kbGac9KBxj1ckmdJvjgaE3D1Ph1RzpQ3/VjKdVIl7ritoPQu90mT
 tAfLV5SgbhzecMQDFBkxKQ2AZBXhtwyl9BR3LIs5bKu9XkRAuPYoYVfWagL4Mg5TmC2k
 PkkJH9aJ+1q8onHwsd+27Eq2YRCwaNhtDnzlAku+fqNnqiNjGcKT4W/r/98bdEJ3QGsC
 fzQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwK7k027zBwSgci32yhVjccFFIqNRiEGqcDQQIFU6bmnzCq5wGaWcu166d0IS5EdSDtW2E/m4VKo5g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ncf1sd9Tg11Og5Fi6GceeL7agBzYgZ84+NO4xO7/tzaBLR9Wob
 HfbrJZelwYKqE+eYdOF0vOW6SyJ2usSAjSRqxpkl9qaR4bDMu/cOHr5Z
X-Gm-Gg: AYBFou1ynOmwU8/RcHzsRSnNtbJWxAIrQHmBmTkXBJF/Lr+9U4jq1wZqw79aJac5iaq
 JayGMSuVXIjL+bcZQJxw4VGQ/qN8clw+6Xtgvqv6I0bOFzZynAOZYfYVP0/jpr2Y5Wc9u/aqG0A
 Hfvjd49ArDGgvfp9264flFOcE0D+1i8yNKYVJPuG+5v4w54LL4azjYwO5DkrS8fjRnumTGPdkNe
 zXzmPsdDrJ+ybNoTTOjzHUlZdg4Y4B41Eau95/USsesjQMRWK/4ftmQZUvTqW7ORHKusqe0u6f+
 MQI5X15NCWSsmwN5omO2fXjIVjkyxrvbIZkxtNR1zpTJ72WD/5BPHAX2v7KB3jxQ1gm7PXzi0+o
 5Ue6V0sKjYljeSpmq7c3OptdXAgxOZrVpxtlIXyuZ6wPd03X4/cNXlQ1F3c3ec3iaR9fz9eeS02
 eHMna/wNrxgLdgo1m3zAvX1zcB7dYCTVqn7p0nS6z5aS1AgLKfnXG0y0bDj2RgVAEiz7Fs+sycT
 2FU+Q==
X-Received: by 2002:a05:6000:310f:b0:486:e9b7:cb9 with SMTP id
 ffacd0b85a97d-4870a9dd928mr2076898f8f.45.1789490268678; 
 Tue, 15 Sep 2026 09:37:48 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fa70sm256434f8f.9.2026.09.15.09.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:37:47 -0700 (PDT)
Date: Tue, 15 Sep 2026 19:37:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: Yang Wang <kevinyang.wang@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Kevin Wang <kevin.wang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/pm: delete a stray tab
Message-ID: <aql0WF8CnlzgS4nz@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

This tab was accidentally added in commit 6c9e0328d1de ("drm/amd/pm:
refactor PPT limits by controller and power source").  Delete it.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a29e76b03476..6beafabf1306 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3077,7 +3077,7 @@ static int smu_v13_0_0_set_ppt_limit(struct smu_context *smu,
 				return ret;
 			}
 		}
-			return smu_v13_0_set_ppt_limit(smu, limit_type, limit);
+		return smu_v13_0_set_ppt_limit(smu, limit_type, limit);
 	} else if (smu->od_enabled) {
 		ret = smu_v13_0_set_ppt_limit(smu, limit_type, msg_limit);
 		if (ret)
-- 
2.53.0

