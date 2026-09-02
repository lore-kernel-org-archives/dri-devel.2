Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87688C624DD
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE0F10F40D;
	Thu,  3 Sep 2026 07:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AT/0USLC";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4D0210F1B1
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:29:09 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8534d507f59so1242360b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 02 Sep 2026 05:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788352149; x=1788956949; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9LT2CNvhu8gQBvTvgavkp0Ba+ivwSZKXt+qQbPlYvMs=;
 b=AT/0USLCkZd5RS+mrW98ySv9caP0KLutBK1Ib7tCjAXGZY+1Wzx7iy29zAQEBoPkwQ
 zUl5zQFwbSify+4WoaH7m197qN1ri38+GzF5xRua9w1zA4LTZee0OmOZOXIoPzqMtNwj
 jG540dUnX72IhN3vSOGfCl2PCERbdzFEv4J8HBe4swKbe6ViSG+3nYkq+PUYK3eaVQSS
 TdDo4jAf6rSZc9Shlp+9JOFaqPOX4NmRNr/2c4O+Shnh08Kb4euauRhNqXpVEVmVGRpv
 Zq8TNCmy7K014QA45I76eqYRrHp1AjkfgYVJB0baz/5e7NQJBJwrTmLnORvAFzVheLgw
 Rmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788352149; x=1788956949;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9LT2CNvhu8gQBvTvgavkp0Ba+ivwSZKXt+qQbPlYvMs=;
 b=fGl7fjogKU0Udsv68XYXfdFeFCPPNjXEApuyntqoFQtVoBOneKYGrrvnKVHYzIH5Qb
 s9YbuzFB8zeGGFBVbYyGoO5q1lOoRz0VzljYUzWqUcAyomm+Ikb7KGm3S19khbkn7AzA
 ENCTgx5Pp7kn5Ciw2J6RijqOhdkRLtUk82+5RwSOgWxH7CEtWwEtor7UxakdGdb5Ini7
 nFvz3QziEFumixLMrXl9DzyNBSBstkHzF1KP5uSxwK3C3MB9xUvlaH/xQQ8cgL0AxSqp
 qrQZhIoVukRNLSm1BNEAhcJv4UIz705ZsE9wNVeg6yswFUZSqDQVXsSwubF1u74GdvAS
 1vZA==
X-Gm-Message-State: AFuF++lW7+1c458aM2SVPJfr482DBklKa/s0E8+cBGiR4OMMUig7EWje
 sBYifIqDPrT+o0gzpyzGxEuuk7xR8UkuBEXmb4ZhY85090UFClkU7yLX
X-Gm-Gg: AR+sD13VRVZcgKAaLwgjUYi2ZiHOf5ZBT0vlasxVz3VKLtJ5XifjI37BpztsKwyULLy
 RgkuUddCS1NAHC52M6vBE5E6APn/uHXDl3bBqYUK16tDS9Aot7wuudVufe4GzA9HAMV91NfNv8T
 Vt5AfpRN7JPMmRqIoqzhNpW7qYIsnl2CrPRf2cTyvyDrjwXnP6g2OnDf7BSKBSOoK6q3rwb2f1c
 EXtwFunuJVvssPiAru9zIiDb5ZHYR1it4NmS0tnXpPbec318XWkeRWhct0nQu0sCdBZwuSVkmSN
 qCAVAy43IFHeos5ldWyWX5My0gV7Z61ptFFxwEtjCwHTlEmgInpTRHnWMiD2E8s0hB8DYu4K39U
 dNJFHfCWThBJ2L7N+A88UEEm2Jmq9hJm6wpG4EW1+JiIV8zrSnvbn5UmWk7mq+SejAB5v2y7rl/
 qU7Y5p2sv4UFSFWahkGlxnRjkIMVk4m2iRUPLAGsR39OuA9tPrDRFxqwd/KJ4=
X-Received: by 2002:a05:6a20:7284:b0:3d2:2afa:d7d with SMTP id
 adf61e73a8af0-3d9afd1db2fmr6185663637.18.1788352149101; 
 Wed, 02 Sep 2026 05:29:09 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.37])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc34d03b5a8sm944767a12.26.2026.09.02.05.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 05:29:08 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 02 Sep 2026 20:28:42 +0800
Subject: [PATCH v2 1/2] drm/panthor: Treat a zero-length VM_BIND op as a no-op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-drm-gpuvm-zerorange-v2-v2-1-da63269c6ec4@gmail.com>
References: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
In-Reply-To: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788352136; l=2156;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=U0Dzb5dFYo2WQuk1534RF6VPlhwKL3gXFahBxN4rUAo=;
 b=h8iTCkrFYjTCEkw5/NfJU9Dawfua/i6v+p4HcQQK8G93JF8Z82hyY8PAApUtztu2Aa07UMjqa
 rd5H/DsmVsrCwAt6S35BaWA/H4uYZhu7y/j56TXO0hJGG0VDn2fG5tV
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

panthor_vm_bind_exec_sync_op() short-circuits a zero-length operation: it
returns 0 immediately when op->size is 0. The asynchronous VM_BIND path
has no equivalent guard.

An async MAP or UNMAP with size == 0 is not rejected: only alignment is
checked in panthor_vm_bind_prepare_op_ctx() and IS_ALIGNED(0) is true, so
the op is queued and panthor_vm_exec_op() calls drm_gpuvm_sm_map() /
drm_gpuvm_sm_unmap() with a zero range. A zero-length map into unmapped
space then reaches drm_gpuva_insert(), where the GPUVA interval-tree last
key addr + range - 1 underflows to addr - 1 and a malformed node whose end
lies below its start can be inserted, corrupting the augmented interval
tree.

Mirror the synchronous path and treat a zero-length map or unmap as a no-op
in panthor_vm_exec_op(), before any lock is taken or the GPUVA tree is
touched. This also keeps the async path robust if the core drm_gpuvm range
validation is tightened to reject a zero range, which would otherwise make
panthor_vm_bind_run_job() flag the VM unusable on the resulting -EINVAL.

Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index e592a8ebb478..93542f59cb5e 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2591,6 +2591,15 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 	if (op_type == DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY)
 		return 0;
 
+	/*
+	 * A zero-length map or unmap is a no-op. The synchronous bind path
+	 * already short-circuits it in panthor_vm_bind_exec_sync_op(); mirror
+	 * that here so an asynchronous zero-length op does not fail and flag the
+	 * VM as unusable.
+	 */
+	if (!op->va.range)
+		return 0;
+
 	mutex_lock(&vm->op_lock);
 	vm->op_ctx = op;
 

-- 
2.34.1

