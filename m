Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584C2C4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 18:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA01A10E083;
	Sun, 19 Jul 2026 18:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a6aO5Pv0";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1743D10E084
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 18:00:14 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cae1a3a744so70788105ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784484013; x=1785088813; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OjFgwGrb1ClX/kve0vswPTA8/2SHmC5jDANL46Jtr8I=;
 b=a6aO5Pv0X4jui6zdr3KXmuVGA9oIWrRXeLj+hwAsP1ajfyVZX9jYcI0ZCK6ASpvk7i
 5+eyoWc7cwfP0JJtzVGSkXrcGZR7I3KF5NvB9EkVQcgoeaoGu7ScrUk3lg7fwEWZSAKr
 CSF2rgMmlHE31z7PLxg3XDwOxTeY3uyRlBytmwQIsaomIE+GbZQ09VBFiadvfdtfHq5Z
 tvz0Ji9POSFruSmn0ijIlOLdW950WDZs3CuPTxbIc3moa3clo75+9ja3DL8nVw6+1Rj7
 0Rsqd0nT2yQXYd5iPFC1mja95HuU38AuA02BRVaFa9vWNs+bLBxEqH+bDpcVdiAXWdWV
 F5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784484013; x=1785088813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OjFgwGrb1ClX/kve0vswPTA8/2SHmC5jDANL46Jtr8I=;
 b=OsjSZXc5wevz+ztIo5WVsK6PPL92ZkMIu7pzQlOnyKK+MVZxZLc/X7Qra/H8qkK2LY
 vSBJmgRD0NBRYkXEBJVUWdVnla9OWH1QGlFK54QQ99akAqU9Jyl/XjvE7MUVgazcqyMR
 gYD2Bq+yyCr1vVMGd7Nrq0xTu5MkYp0YQ79yu7EHLsBO+3ez3hp7Pp/xWF0+FTkrKiWq
 dbsyO3orfL1KMP+1XIQj3NF++vrlB1GF/J5opHw5n/yVRrnxmDzFyA50X1LXx56EQ295
 jBI0whr2VJpjCDeXitdmmbaXuPFTaC3eYCey2nog+BwnWf6pzTnZiasd1aZH6kJDH1xx
 fPUg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rox85VonMPzJvLsWY6cVx8Q+YjvKn0DjHp79JIOdx2TAZ171cUeIDzHFTP15zdQf52PYBOatkvsqV4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7x7kGJww1t05Jv7uoF6ob3nM6H+Uxp86J3GsJ8NCZZ9awb8nB
 nuVK4dOG5/HQMjOHUmeG2kSjj5DPprHG8HB2P1ynGnToYe0xWYlZpl6G
X-Gm-Gg: AfdE7clYkR5ulTFJOkn9bORD7knNkzsI/JhXe+BdA8UVoB5vgfvOlNY89eTydBL8tnD
 NEgwKu3sajI2bFEW/l41RnBqfoRcGm7uAbx3mkjV9C3NQmHmIFClpqul3NjnyZ5ivcutmxqd0gB
 1FM9n+GPPVbR02/3zG9whRYZ+M3KQBWbuRivYuTYyOe+wbIqDRL4ARqfLU5SZLOgNFm1LffqJ9S
 +j7BWbKdyyM++CejvVkaA5Jwo0cSFVoIlZjQRsnqg2Pymt9g/WBZFPK2Z/y7S6zbncYjusPEbgV
 l47oh+Qycv2RmK0DFgCb5Datk/F/o8jRtcfMU8sLYBciHzCO3kn3GuMxtRCG3W1JBiR8YQmk/Xt
 5fgyfoAg0yaJDkrBXqysClqT2ZH3x+O06aw+LxP0otb4SHZxfZX2103zikma0opDhGQ==
X-Received: by 2002:a17:903:988:b0:2cc:f5aa:9513 with SMTP id
 d9443c01a7336-2cf34821a87mr130472895ad.10.1784484013524; 
 Sun, 19 Jul 2026 11:00:13 -0700 (PDT)
Received: from ap.. ([182.213.254.91]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34769bd6sm43511065ad.74.2026.07.19.11.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 11:00:13 -0700 (PDT)
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
Subject: [RFC PATCH net-next 03/13] net: core: add XDP_MODE_HW offload hook
 for knod
Date: Sun, 19 Jul 2026 17:58:47 +0000
Message-ID: <20260719175857.4071636-4-ap420073@gmail.com>
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

Route XDP program install/uninstall to the knod accelerator when a
device is attached, so BPF programs run on the accelerator instead of
the host.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
(cherry picked from commit 9689730acf7d6e4d34cd677e4615be10856c709c)
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7c21bc0a1e34..5ba1c969029b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10334,7 +10334,7 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 		return -EBUSY;
 	}
 
-	if (dev_get_min_mp_channel_count(dev)) {
+	if (dev_get_min_mp_channel_count(dev) && mode != XDP_MODE_HW) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory provider");
 		return -EBUSY;
 	}
-- 
2.43.0

