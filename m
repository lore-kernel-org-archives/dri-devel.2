Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F145CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9195C10EB3F;
	Tue, 16 Jun 2026 18:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M+tMfpwG";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF6010E66E
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 22:01:21 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-7e87602f26aso33239957b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781560880; x=1782165680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FIyvWCdTdGpwmgLj68ZKIBwap2l4YcZzm7SxNeqPKYk=;
 b=M+tMfpwGogj7NvGsbJQQCdSVBgYfwY6sYFBDWVGvjBK5Gfz/950+3Oo+I7wjJ8eVfl
 3zMx/V6m15sTkT8uH7rq81dfakZPpRURicZPy5DYnp19vX8CiqHMypqLzPlNLZrGyqoS
 1xMBywnE3OoRyYtwytLVJHZsF/+0FZg5AtAQ8rQPWkX7bi79dwUYKTXa42hBzfG+3w0x
 ZCcu+qSySPpN4bBwguR2Oote0u2PDl1IcBXiOAn4WaA+YDYpWtl3mfr1ejEUHLEecPFn
 TCiS8nL6RMFpUoLN80p6/oTjFHbqSJ68781lXED9SXNZmeNf+fBx7pxooMpo0GO8MZBv
 0A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781560880; x=1782165680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIyvWCdTdGpwmgLj68ZKIBwap2l4YcZzm7SxNeqPKYk=;
 b=Lm5Np2y09s73ToDnD14TBOvI22ASTHOb4+pDkM+EGWw0x7mz3WWTC/wwDR9djK621z
 yTlDYuubsi19qGlcN3oObny6e+1pgLEH35xxV+xvnJ7ZqokruBcj9on2IPHiTb1spZBf
 y0nWb3MaIRlk121aFtdPiTGAyIW1be2XHPVHGX3FbQi7sfiZ5Gao6pTgZDmA4gDLi3i4
 y3ddTP7Y+Yd5N4arzMQ6eUiZcoExL+xE8w1fxYmivKqo0Fa08GsKo+zOB0LBCGDDNGcg
 ZWvN6kwMwwVOjYn80NDSy7F9ZH3WvHTroMeae1KckXJnBKlJQAz7LKqhGuEX9fQwLLye
 cfZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8k7Cfj6pVZOKftw646iHQoRDyznzqQikJ1DXlP4D4Eb1ujg42L7byvx78tj8X9xCZfy2jfWPNW3wU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8wtkZW7OMBT15XdunDtqJa+O6h+0mWqMJzb5qkNrKibqTxWb4
 o1DsoB2VabpQuBZZG0Nmsyu+6BfBLooQgT3c1DDuOa+ozFYx0gMksrIy
X-Gm-Gg: Acq92OFyDcsedqyDGJNoc0SC4bN7+pU4rZaOh7XmEBfkniSR9yBIHtDqUfpiJOPsE9v
 SQ6nqkt4sOYbln965s76MQ62piXNvzWWb87/AOhqQ+1MqkqDIONU7jv1SNVS4M7NyemtQLfruaR
 QZVY8sA41c2HijWy5HbhHBGFA1Q7jTLCEOgfuSxodQoGA1J3ITxtIj3rH/MydsPp58NVFtkJ9YB
 d1otrX9CEQ5pPJLPfKYuejMb9Rn3fF9abb5t6d9iyToii0KoZ7ZuySPg/rssdYV4IB9bYGc1S3r
 A67tYrEsUcp1B+vL4lE0kemC149CO+/drdCK1VCC3ot0Hk494Z9ZFINtsfnMKgRWUqUqJGzocR0
 idF1n4F9ip8P7ctsAMsDYKbuEtGi40iU+fTkzDQzk1HcpOVRmSTN12TSJRpXM2a5HzW5ZYCN4Uq
 mquCwZpIXAGX7ZhgBxJVt2uY4o/PDqziExxzz5oyr4/aUzy8t5TByrdZqXtN1SpFV+Th+u3rMqW
 lSQmg==
X-Received: by 2002:a05:690c:4a09:b0:7b6:783f:2122 with SMTP id
 00721157ae682-7fce389261bmr12809317b3.9.1781560877980; 
 Mon, 15 Jun 2026 15:01:17 -0700 (PDT)
Received: from ljh-System-Product-Name.tail61485f.ts.net ([203.246.85.145])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7fcd2c87028sm6021997b3.27.2026.06.15.15.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 15:01:17 -0700 (PDT)
From: JaeHoon Lee <dlwognsdc610@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, JaeHoon Lee <dlwognsdc610@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/v3d: reject an invalid indirect CSD buffer handle
Date: Tue, 16 Jun 2026 07:00:48 +0000
Message-ID: <20260616070048.1590551-1-dlwognsdc610@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:17:58 +0000
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

v3d_get_cpu_indirect_csd_params() does not check the result of
drm_gem_object_lookup().  A bogus indirect CSD handle from userspace
makes it store NULL in info->indirect; when the CPU job runs,
v3d_rewrite_csd_job_wg_counts_from_indirect() dereferences it through
v3d_get_bo_vaddr() and oopses the kernel.  Any unprivileged client can
trigger this.

Reject the NULL handle with -ENOENT, as every other GEM lookup in this
driver does.  v3d_cpu_job_free() drops the reference under a NULL check,
so the error path leaks nothing.

Fixes: 18b8413b25b7 ("drm/v3d: Create a CPU job extension for a indirect CSD job")
Cc: stable@vger.kernel.org
Signed-off-by: JaeHoon Lee <dlwognsdc610@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ee2ac2540ed5..05f98379c1a4 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -605,6 +605,8 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	       sizeof(indirect_csd.wg_uniform_offsets));
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
+	if (!info->indirect)
+		return -ENOENT;
 
 	return 0;
 }
-- 
2.43.0

