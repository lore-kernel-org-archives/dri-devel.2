Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C0ACDE006
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E2B910F132;
	Thu, 25 Jun 2026 07:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HTr58yUD";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43C1D10E0C4
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:21:10 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4924f8db066so7637585e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782321669; x=1782926469; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TbgHCjopHlS/2Xfh1jkQjyRfQ4ZwvIFloenkAWi04I4=;
 b=HTr58yUDoCrXBJdS3SUqhMyTjkggeh1sqzgWyPd13oXEDvZTGY/FO7HPWF7EF0jMzD
 i7XIL1oBpNg9SB2J9siHWTIAQ3kwFmqzvTWw+5QO2OZ0RdVZlYMSQREI/HQNMWLVrd5q
 XVuT/1+O7vN+nzadZsYLMWwYeJVGGPSnkCjfZsvHspc3HEmNpQj+GvpgcQhMFbya6A4P
 T5MmKVHAsiv5YHyuz7GEIajWkJztema/DashMxT2gdq21q+uJzn0fs7fXBRKERyMszKb
 hFOQz9nttYCbwjo2TcwvODYvO5dvj1IBp0B9WSjDwCTK8FTkdMXEe1s1tlZ7ceyq0qOa
 d36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782321669; x=1782926469;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbgHCjopHlS/2Xfh1jkQjyRfQ4ZwvIFloenkAWi04I4=;
 b=M6W7f7ReDBXIyo3aLnb2zmUB9meQec1MUstYCrm4AyNqCOs+Q+HmFFgfZAsVq3tO6j
 V39+2UcNDJDe7mu095g/liyMII7lISjXMyddIc0UCFnZDkaG/79W93tn+5kWW+YhE/ts
 wKAp2KCwKVp22FxRf2gPnToaOtVr9vY13wtx5LflGZ+OCXmN2I1fHZLLtgCPBbWYs3Dr
 ah7jYRNsOtcE8FWMyRMLWST/CI2bzoR3j5JEoiPuGFIgni/OAspj8uGa5XPAEfYaP43D
 DbZPKCIuX3cQhRhUJzqxwjc4DUx/j2R2lvaF+5oSKOyKWunxb7PqIPt5vnE+AEPUVykJ
 tVjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FH26MkUTVPxwxZkAcKR+rONMEljcc5BZTNWIcE1q4cqIi16mZwd0JC89pRoOiyDkrUB1H+BT2Z3A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxL6TgrWJ1j04wvY1B2kMf8XsBkoJFRAPqjCYTfYGL41zAtCczk
 kPbIT3To00G0pkpWMAjNYoSo/LWuthLBBOqQTadh2mK7zkO3LoZZlYAP
X-Gm-Gg: AfdE7clIMJFw0DOHpmpz6IKRH2eRk1UUMrv+thLrGufGMAzH2MglqpuyLpuaWsUfrg3
 8o9ARdL9VM9GIvDG3CUAVR3AjrpYtmar4bk/Z3XvzOzW44iNjOG+Krgt8GajJmrPyvNi2ctzUYR
 p0UcEQmLboLfb9hkLQMnziNFmMN6GbXBv2rVykdCHrX3u7SJidU3KRRQNFZuCdL9pkF1AzYCTDc
 31O3uGkqTEGIJMEetWTa2ukDeJR/GhztefjJJ0XdRp/Nx8p+d4BHX2n59lN3WiHod7E3zwduqjV
 HzdUxgIruEnNEpbV1K+LqCjLyu6xLN1expe0CeTpQdn16lNdDNRHVEEXa2M6xIhTHSE4+sZ6fJB
 bynuarIpBm8daXzR9TVNL1Wdx31KA4hKkGxzqlFg5fo/187x/cu4s5+Und4TU+9Sb7W00wtt9qi
 iPIgrZ8t8VEzqdGoQfTQGPSwgStA==
X-Received: by 2002:a05:600c:6290:b0:492:463c:48b7 with SMTP id
 5b1f17b1804b1-4925b379813mr131866485e9.22.1782321668471; 
 Wed, 24 Jun 2026 10:21:08 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49264021121sm10826125e9.4.2026.06.24.10.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:21:07 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] drm/amdgpu: reject mapping info for unmapped BOs
Date: Wed, 24 Jun 2026 19:20:29 +0200
Message-ID: <20260624172029.2508-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

AMDGPU_GEM_OP_GET_MAPPING_INFO looks up the BO's VM mapping and then
iterates the valid and invalid mapping lists unconditionally. A GEM BO can
be queried before it has been mapped into the file VM, in which case
amdgpu_vm_bo_find() returns NULL and the list walk dereferences it.

Return -ENOENT for an unmapped BO, matching the VA operation path that
already rejects missing BO-VA state before touching the mapping lists.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 212c14d99..4b2699931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1087,6 +1087,12 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		struct drm_amdgpu_gem_vm_entry *vm_entries;
 		struct amdgpu_bo_va_mapping *mapping;
 		int num_mappings = 0;
+
+		if (!bo_va) {
+			r = -ENOENT;
+			goto out_exec;
+		}
+
 		/*
 		 * num_entries is set as an input to the size of the user-allocated array of
 		 * drm_amdgpu_gem_vm_entry stored at args->value.
-- 
2.54.0

