Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D47606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 04:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k+OkfuHL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D6F10E0B0;
	Sun, 22 Nov 2026 04:53:29 +0000 (UTC)
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1961D10E0B0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 04:53:23 +0000 (UTC)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3425098ae4bso3369171eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 20:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795323202; x=1795928002;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C7Bdw0hKj9JbfhPi9A4wuP68QPesnRTG6G8CMRtqhng=;
 b=k+OkfuHLBaHMNF97cYgQU2JnxmJAcVEv2iBks2vJ6Ee1IpW8Y7mV27srNSURDOf7zH
 EHHgEWROOA8UQwzLRJ5Movy5Mt9IMgBRciG88V/zJU+P++2GOWs4vPRma2hO3GzDIqah
 bN6sFcBfB5+MhYFSKL7yv/sx+30bS8mli1fjBHOI/CzLiXSQB4gQVUCrz5uIgY5oDypf
 G6Euw7Yauh5m86+7czKdWm29Moxw4ILfxG+mp29EA0v/rA9LtEhTYszgYNyIThUBLD1Y
 Zxz9/BgFnzVqHoExrmv7/9YVE/vP8AexZl4I7RKRarFRL1Vz2nlOYSgHinBn2V0m6Lmu
 aQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795323202; x=1795928002;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C7Bdw0hKj9JbfhPi9A4wuP68QPesnRTG6G8CMRtqhng=;
 b=WXDKCC8YK7Uv27JdrAX5ZHZ6+j5+DpgPb/z219gzVi1gBSeSQZVD2RuYEmwabDHt1T
 9xY9yoJWjx//cRBJpvgM2tMrnx+SRTwe8S9oiPxAnYSTph4BWZ8XVBE5pULYDmlsSNcW
 nDek6WJ2EfoYUHnzFBbMc3UTfUzhRCjrN5YO+jY8mDHdCBVeEMLxK/2wUJC1GZNQ3b2o
 d9hezBaczNmscibp2ma6hOfEhlWS6bBc5rsRaV8h24O0BRpSrrPhy1n5zQj8Fz8uXEs6
 pyQRR7OXtVgL7o5xw3/koxYfo5eErYuPZ1FskCgiR8OYQSPDi1lmf7A7PcujEU9x2SN5
 kc0w==
X-Forwarded-Encrypted: i=1;
 AL+hErETzy+6Yb7wEeDalkhjWzvCDMuyyM6C9QU6ymokN6nrNP2hIXBur9pxBcARBu6mr0DFwrjEAzbD4Oc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/v56VM05FGPtKV8sElI+dJITTH66ZCiFH/2lRvunyZ6f6tsptF
 TexY41u9uvrmom5Bp0S+gJML5PDz+YE2DB/FPwtE+5mJ7IIJiziHqYl1Z1Zos+hw1QSwXNZMaHm
 5M+G3o8PsNA==
X-Received: from dlbsj12.prod.google.com
 ([2002:a05:7022:f90c:b0:1b2:4b7e:5356])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2319:b0:1b3:a8fc:6306
 with SMTP id a92af1059eb24-1b55247e725mr8008573c88.6.1795323201686; Sat, 21
 Nov 2026 20:53:21 -0800 (PST)
Date: Sat, 21 Nov 2026 20:53:15 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261122045319.18651-1-irogers@google.com>
Subject: [PATCH v2 0/2] drm/amdgpu: Initialize r in VM and TTM buffer helpers
From: Ian Rogers <irogers@google.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

1. Set r =3D 0 in the 'else if (!bo)' branch of amdgpu_vm_bo_update().
2. Set r =3D 0 right after the while loop before 'error:' in
   amdgpu_ttm_clear_buffer().

Build-tested with LLVM=3D1 W=3D1 (-Werror) and -Wconditional-uninitialized;
not runtime-tested on AMDGPU hardware.

v2:
  - Keep 'int r;' uninitialized at declaration in both functions so
    future missing-assignment paths are not masked; instead set 'r =3D 0;'
    inside 'else if (!bo)' in patch 1/2 and directly before 'error:' in
    patch 2/2 (Christian K=C3=B6nig).

v1: https://lore.kernel.org/r/cover.1795106955.git.irogers@google.com

Ian Rogers (2):
  drm/amdgpu: initialize r in amdgpu_vm_bo_update()
  drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()

 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
 2 files changed, 3 insertions(+)

--=20
2.56.1.750.gf70dc682cf-goog

