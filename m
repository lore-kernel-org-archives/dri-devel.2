Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2A6606A68D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wfQ4mZS4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6A510FA25;
	Wed, 25 Nov 2026 08:43:16 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B88810F0D3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 22:28:52 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-99e1babd683so2878536241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795559331; x=1796164131; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6iPTSYDTRHq+nKGXWvP+CNmSyTGeAgnIA+1IHwqX79w=;
 b=wfQ4mZS42SkoGgogxx7uVxlvPHyXtsNhefpE9EEy7FULQqLIHVnYSKuV5ziKHC1yHj
 22MebAXdtQrs7Ltx5/aYHXMNkzpiWadRxqNJr1v8afdsmQZgsTN19siw8m6WU0UleX8j
 /pUkdBeVKUuXpdI7M6uIaroWWys3XfeLHuP+GsTKqHhsCyxVK+e9Ga9B2mLbr4PsKv+2
 iKCE1FRzAtVRFnssCi4jMYtuJszSZbrAb52/ZgM+gukp8QPfps1rWeuclhunPHF9KJti
 tkB5pRtR95duKSE5JNfOOQ9hm0XaBcvaH2pI0y1q6+zFwVqEDO8k9KhDVCjGW0ZvHFn6
 yXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795559331; x=1796164131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6iPTSYDTRHq+nKGXWvP+CNmSyTGeAgnIA+1IHwqX79w=;
 b=cBqcXH66vDWZhyoz+lVUIKHUrOuRbVdCmQR2p+7TMwtFSZd1KcxvdoKOau2Cbgi3a7
 9zWNgFCLOq9JkgdUb2hUMzX+2XGxNsNuMY8Yatsyrz8Wn0HUQk4RAjs1/73I/sRDMtUm
 8dOkuUEzkUblx6yCygYNP9TV6IjYyYcto0rHx2armv1Nx1LIwAip+GRKOqMjp57t/yEG
 VTADpIHW4EMQcP+Hnd/Eqi/E13Uh+a7MsfmuVUG5cFxiqo9xKz6bWjx0aeEgFFlxP+YS
 28KwjKTed/FmMp5w048KGlTF9eHpLySp9JNtVNbfgAc2GZWp8M3gUutB4ihbXLzfDl58
 u33g==
X-Gm-Message-State: APuU4Z9MbYz+9CmuacvQuI9Fy+l7LUDxgedqWclg8iBqf5p42ZhgXwzV
 JoO5VITesm4MePeP3Q611Ku986Tke/EtWsCkLkKlJ0WK9gvNJqvo79yC
X-Gm-Gg: AZFdTZc1k9dxvPFzygj0eW6a3ErnPCKJ/GQ5sM2XLXxkOHnSZ13ObCd133xfW5mVhKE
 rqHvtS+BDferaU+gbCh3aRgR+XTczjb1O6C0CbmvavPwysk7gScX5Ab+Uq7sNFaoyI4GlK/Wpz3
 L0d7TMjTW7AKzvL++6BHULV07K9JngquS4lVowZ1yN0rGLllUaiGA/CRu10qD724PpuzdqSAIc7
 /K47JAkeaIU/wZv9CqZYX3Uet0dcyTUb5zKSt+9CO60QMf5K3z6ntFU0T1KJY6UnjKBfTQ/FMsu
 iDxJBBm1JGUCZIiGllliYXkG71rRe5lsRf00w0KGD21cIDkCqWgn6ff3tdIxlavgsmF7PmyGZzl
 ASDx9y1vJuQAdrKc+I/qQdShWwElJ8h9uNHBErZAw3zGRrB2L+6JU32PUXuBPOELax3403ixjFp
 ajKOeQsd7/n8jRE4+lP4MKE3hAI9IgFg+QMyJ2lMX2yER9rG4QWbod8MTbu76CGwjF3zrCnDaba
 D7g1vVM80eDn5qUADmtEbDFRp2PVfkOfqRvy+BQArF3V+E7b3kriO00ZsH9ITfN1Pokqy2Ii3vx
 09tAhxn5NaCoXE5cw4tJSE7MszrbTf+OJASMG0nPbaYdkw==
X-Received: by 2002:a05:6102:f84:b0:7d2:754c:23e4 with SMTP id
 ada2fe7eead31-7d7395f4a94mr8694784137.24.1795559330812; 
 Tue, 24 Nov 2026 14:28:50 -0800 (PST)
Received: from eduapps.lan ([2804:f04:9074:7a00:92e6:2643:ce63:2792])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d6e822a085sm16403831137.10.2026.11.24.14.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 14:28:50 -0800 (PST)
From: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
To: nat@pixelcluster.dev,
	arunpravin.paneerselvam@amd.com
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
Subject: [RFC PATCH 0/2] drm/ttm: fix excessive idle memory retention
Date: Tue, 24 Nov 2026 19:28:10 -0300
Message-ID: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I started looking into this after my Intel Xe desktop with 32 GiB of RAM
would eventually freeze following repeated graphics allocations (A test
program allocated around 12 GiB without freeing up). In a
separate test, a standalone kernel module exercised the TTM page pool
directly. On unpatched 7.4-rc4 in a single-node QEMU guest, 768 MiB
remained in the pool 60s after the module returned its pages.

Patch 1 adds a 5s timeout after the last page return. It can
stand on its own and drains the idle pool. In QEMU, the pool was empty
at the eight-second sample. The trade-off is that the next burst may
have to allocate and prepare those pages again.

Patch 2 builds on the timeout and keeps a 128 MiB reserve per NUMA node
to reduce that trade-off. With both patches, the same 768 MiB test left
128 MiB in the pool at the 8s and 60s samples. The
shrinker can still reclaim the reserve under memory pressure.

In a separate QEMU benchmark with a 750ms timeout, the median time to
allocate 128 MiB after expiry was 185ms after a full drain and 0.45ms
with the reserve. A 768 MiB request took 1.13s after a full drain and
0.95s with the reserve. The unpatched kernel kept the entire pool and
reused those 768 MiB in about 2ms. These tests measure idle retention
and allocation latency in QEMU.

The test files can be downloaded at https://codeberg.org/EduApps-CDG/linux-ttm-pool.
It includes 2 C files (one for test and another for benchmark), my logs,
some build/test helping bash scripts and the compiled binary I'm using
on my machine right now.

Feedback and change requests are welcome.

Eduardo P. Gomez (2):
  drm/ttm: reclaim pooled pages after a period of inactivity
  drm/ttm: retain a reserve during idle pool reclaim

 drivers/gpu/drm/ttm/ttm_pool.c | 92 +++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 7 deletions(-)


base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.55.0

