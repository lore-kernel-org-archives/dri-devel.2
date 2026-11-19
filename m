Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947160A2625
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LTxIE/2J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8AE10F000;
	Thu, 19 Nov 2026 17:07:14 +0000 (UTC)
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E674E112670
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:07:08 +0000 (UTC)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-383f2d05c73so3881103eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795108028; x=1795712828;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4HXYvdAAUg6PhdIi6P7o7bJNHIqooKYEpFbbw0vh7ik=;
 b=LTxIE/2JsH7lz7TfJljoCrWJwcYpH2Q6YYuPG4kQ4vTIB3+3fO7jaRwgWbFLLyAUuZ
 oyZZwgxt0L7a4WsyaNwocm0vAU8AuRx7IhmFJo5N6SEnh3Vj0tKoTmQH2v1F4yn3tKqS
 dukFv5SnE7/KIC5Wjt738EFeiONEcFcv2BnWeOPJeklK7btAwOS30AXksR1grm2e6U7o
 MdQgXotb/1EcgYqYU1uKTBScYeL4c5m3uruMnDKpC7ruH/TJfzqaxuZt6BnoYBDBCAEj
 k08rQqCEZ5KH4grgoxPRHAE7q2u1bddvFkITj445wBlCRTvHyX0aopYJr2Dqgy6ib/8b
 sxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795108028; x=1795712828;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4HXYvdAAUg6PhdIi6P7o7bJNHIqooKYEpFbbw0vh7ik=;
 b=ly2BMOY/xe8zYNt2VImka2ywxsO3yQzxSrAMD5TchueSC+lsaEv1cUK9z9uM6DCGNQ
 TEAtFeyLobz9S9wd9G7v/XRXsep0mNRN59xtQBDq6Osr/a165GcFDxph4A/luo09aawo
 osNIROxHGpsaM++tqN5EYxmBJ155WZSGqzvVxCI40JpOV48XG8oBBJW6Nt9L8fc9PG1Z
 /ARtWg/oGt0nUQtKQp8UWmvcCQu+qYGBQBLYFg0PZJQxBhCUstlG8NNGg4ph8es/9y0c
 cDbnKYEJmJ8AZU21iF4FrrGzXuIrPu0rTkShilg/xRIxwBxAFMJRklMZ1ZoR7gt3oH9F
 T2xQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGMoXH5Blp2sAsZdNWljIETl/bLWJbHv6C7V3nr64EP3refw1aob4+bCfHKGz1M9MMyRXlKYpRsg6Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9SXwxGwyFbjUTxvhBuWdTeoDvH5WuZGG3azqAHiSmDN9zG4PyL
 xyYNN6aoq37t1SCFsbEm+/EJvCy11ISUgAiOlZSplSd/0Xg2747q6FYcOesN+Oiw8JK3nLE+7MZ
 5xPeIOprRjg==
X-Received: from dycc23.prod.google.com ([2002:a05:693c:60d7:b0:383:9f52:e550])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:894c:20b0:381:2f5d:a696
 with SMTP id 5a478bee46e88-382815231femr6073879eec.34.1795108027821; Thu, 19
 Nov 2026 09:07:07 -0800 (PST)
Date: Thu, 19 Nov 2026 09:07:03 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <cover.1795106955.git.irogers@google.com>
Subject: [PATCH 0/2] drm/amdgpu: Initialize r in VM and TTM buffer helpers
From: Ian Rogers <irogers@google.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Two fixes in drm/amdgpu for uninitialized return-value regressions
found via Clang -Wconditional-uninitialized on an x86_64
allyesconfig build:

1. Initialize r = 0 in amdgpu_vm_bo_update().
2. Initialize r = 0 in amdgpu_ttm_clear_buffer().

Build-tested with LLVM=1 W=1 (-Werror); not runtime-tested on
AMDGPU hardware.

Ian Rogers (2):
  drm/amdgpu: initialize r in amdgpu_vm_bo_update()
  drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.56.1.708.g77570a6a1d-goog

