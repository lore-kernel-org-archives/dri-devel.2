Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54283C4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 18:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE8E10E07D;
	Sun, 19 Jul 2026 18:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cBenB01J";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA7510E088
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 18:00:38 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2caf228a910so73166495ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784484037; x=1785088837; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gQVLUSh0YdJH3i5yQlMay6TXyEhugldDrvm9uMupsBE=;
 b=cBenB01JzHdJTigxhO00qvy6kzT2/rXV3L68oTRp3VJW3CMxGCKaHYYC5MrZVZXY4N
 XGH3Cye+3nQ93noxvsQBT6acLzk/92fWoX+dMEObuG6bBpmI/zQ5cPoN0N7+dRSFQ5yt
 glX17T7W4Wc0UwXvkzFkp+tcxVM1a5dQWqPoTGcp/Im8M7eIdH6cUZ5eCt29xqUfBSxo
 qZwaqBbDcIvqwOVv3bmY/wQ35Dg+zC4ISuQMRSTQ4xd0AFHz3W9ABbj5gRKuoSlTwYSt
 4AT/EAlAxw76ntWsijoIa3O43YkSAXjWAAwTU1jRrwOuR9Rq+GVzoA+0mD02S8at703L
 9NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484037; x=1785088837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gQVLUSh0YdJH3i5yQlMay6TXyEhugldDrvm9uMupsBE=;
 b=kixLN/ggrizW2F9rC3HO1H2nVpP6izM2p4LF7YA9vvUwmZlJf4hNp+zZ3yt4MAOegD
 T06mwJURfjv4ZRPu1LtBnF3AQzUmxxTUZqD43olrNVmQs48MeF4uMRCpHIS4+H4bAUOH
 xmbqp7tusQbvQH/DrxviULk6GosQrVJKSBE4qNf/MP3YMabFByhKW8knStbryZhqNB6b
 793fFGhEIapcpUU0yJscWWzw57dU1mJ6VyNgR8jRhClAt656Dx4kuG/v7QJyi1t2ZP3Z
 Bp+s4EXyeZx2p1jSKSHSIkMedAorGrt+40hyGsNXnq4jRzHtwl5zoCbC/PLka+qFeN7k
 ijEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdKN5znfrN+zBB4V7YPvrYTsD63VA79FcnzbJEBDf3QoWPZPOrxI8T+1R0tgNeHQvCcibuA615+mc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyag7Ss9XiMBrGC8DWgwGIcDlipqMwkACg83HtPDRrMS3s0Zty5
 v318AeC1gTwbNH3tduaVTVxehlU9rzBusrYd362aT1Kr7VsPRnWZtO2z
X-Gm-Gg: AfdE7cm1n5wm+xyUtGTNJU/i9V39k6D5Ak/tLD45JaUGF6jZKpG6B35qu5/lIacJ6px
 2At+LXoH0B1OCG9nPiBQqjPL9H2cCjEr/jbZLZb+kxVONj+GB1H23WBekbmGMnWNk4cvSvRhkYF
 aBCUniB7WymT8IlUzOB8EMtjMJgB8dgcFv0u/fcjgcoP2ff2SmC9AFfFzU6S5xubtTDRE+3MmAM
 yNGhNQrVLbqCopKl9uUztC8ky9TJF0NU8obpeHBq2dcoqk+TflfWioalh9ZgqHRnCHd9YFS0fpq
 KOzY/wJKLCj0fKSydnP0jqfrgW2/mfqzpt+zcKfSynp7gQWLRipfAnk+N3ze3njFeCcfuobut7d
 pWC9Uho3lIzAk8kW2WV3w5h8jpPOb2u0hlQajlOi/mF+pg9QeLXoOX2/06qWjZ2yO9g==
X-Received: by 2002:a17:902:fc44:b0:2cc:b480:28ba with SMTP id
 d9443c01a7336-2cf34a25ab6mr120497085ad.44.1784484037543; 
 Sun, 19 Jul 2026 11:00:37 -0700 (PDT)
Received: from ap.. ([182.213.254.91]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34769bd6sm43511065ad.74.2026.07.19.11.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:00:36 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Alexei Starovoitov <ast@kernel.org>, amd-gfx@lists.freedesktop.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>,
 Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Borkmann <daniel@iogearbox.net>, David Airlie <airlied@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, dri-devel@lists.freedesktop.org,
 Eduard Zingerman <eddyz87@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Hoyeon Lee <hoyeon.rhee@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, linaro-mm-sig@lists.linaro.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rdma@vger.kernel.org, llvm@lists.linux.dev,
 Mark Bloch <mbloch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Michael Chan <michael.chan@broadcom.com>,
 Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org,
 Nick Desaulniers <ndesaulniers@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Sumit Semwal <sumit.semwal@linaro.org>, Taehee Yoo <ap420073@gmail.com>,
 Tariq Toukan <tariqt@nvidia.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: [RFC PATCH net-next 05/13] bpf: offload: allow PERCPU_ARRAY maps for
 offloaded programs
Date: Sun, 19 Jul 2026 17:58:49 +0000
Message-ID: <20260719175857.4071636-6-ap420073@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719175857.4071636-1-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
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

The knod BPF offload keeps hot per-CPU statistics in a PERCPU_ARRAY
map that is mirrored into accelerator memory and aggregated back on the
host.  Permit this map type on the offload path.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
(cherry picked from commit c447c9012940d48c1ec20a8ebac8d779e7d5a6fa)
---
 kernel/bpf/offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0d6f5569588c..36e747a12cbe 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -510,7 +510,8 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 	if (!capable(CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
 	if (attr->map_type != BPF_MAP_TYPE_ARRAY &&
-	    attr->map_type != BPF_MAP_TYPE_HASH)
+	    attr->map_type != BPF_MAP_TYPE_HASH &&
+	    attr->map_type != BPF_MAP_TYPE_PERCPU_ARRAY)
 		return ERR_PTR(-EINVAL);
 
 	offmap = bpf_map_area_alloc(sizeof(*offmap), NUMA_NO_NODE);
-- 
2.43.0

