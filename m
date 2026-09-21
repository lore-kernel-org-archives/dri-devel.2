Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C54DC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D29D10E463;
	Tue, 22 Sep 2026 08:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nrcHFDT3";
	dkim-atps=neutral
Received: from mail-pz2-f25.google.com (mail-pz2-f25.google.com
 [74.125.228.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA00510E34F
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:16:06 +0000 (UTC)
Received: by mail-pz2-f25.google.com with SMTP id
 41be03b00d2f7-cc1cebad4aeso2571492a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790014566; x=1790619366; darn=lists.freedesktop.org;
 h=message-id:date:content-transfer-encoding:content-type:mime-version
 :cc:to:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sp7CkkCFTfRQKPl6kzZrbuCRgTVE+fbWFxi07HmMuWo=;
 b=nrcHFDT3192U/96+Bpv0MRuOAO7LiwNK63FBerpxAjKlf+FO4DsbM8cuJgOo5KBn8K
 1I/h308CTJtvtuZjAs1ns3FBwbPZCpJY9cv6G/QkysgM/KfNdEVKNRESao+yF6BqItmi
 u5vpe0KgKCpAf5HkRc2ziTFnB1SZBnI/8cEpnEpxYs7cvWQxzv5/7CWPPglADiHJ4pS8
 5+rZYXhme/fWYGx63Uh3H/+pOf5ZMT1HtFCrpQKm8BQ35ngdFpWmnt3zqqHCPKR6Zmbs
 cvvb5f4b1GYxutoelvMjn57M6dsU4Pe3mH8b3fQn/2wZV8BiEN1agElqj1+ou4sD3pHk
 pgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790014566; x=1790619366;
 h=message-id:date:content-transfer-encoding:content-type:mime-version
 :cc:to:subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sp7CkkCFTfRQKPl6kzZrbuCRgTVE+fbWFxi07HmMuWo=;
 b=IC0DO4Q60WqkBxgkBKCZsuSCk9J/9M5zxeTaLr1LT5ahAvdMnzYohCHOR5yxEDw3VU
 3TbE7VJspCNImjiDjob6j7kURAHdHBkR7P3O2QA6LbFzqWR3l2ZBmVxaoP+Bcc/3IoZv
 Eveg5+bXR+Uwmmn0QbvhRwHnZJWt/vJXf8yoDNElPtyhA9+dM6PQP5WunLaF4ky27F5m
 83qYPKo5LwRRBPTgIZrPoVLpPQgtUYokBGC1hgqGh1KE8H7irZv8uNgbs8vYpvMi+rmK
 9gCepdM4AMq4JagXBDNt6TJU/9tNaT7xaSUMwdekzytPdz9emZCyDJJ8zVxFAxfiF1cI
 NQYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3aWgZyxBGaHmoKHeKHyan2ShzwAA9tsN4JNnU3K0wQyhHfwmiNkqg1xcDvbc9k9uzlVhchuoJmaA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNlyrYTqUlcWMQG/0u/ofyRCgOsPrKe8sWjdCogCKSLm4n+DVH
 WfV63Kq6RHW/BLVpL70S5Wf7DxKqBPjtXQ33Gt/zjlRbyZeTFNthw8dm
X-Gm-Gg: AYBFou21gtWeFjEgkQeIldkzCKSaBshwBZvLKobhX2Ezgg3DnTB8HGT9ik6h14AWxv0
 xZPSqHvxt9vdRX52crH3SEhOsNwONUkzJz8xC0SvvU35zuxWm2ayR0n8d1d6fek6BTona1KSkYH
 nM8gWncNmwiStimpUShj/RapRQIuXw9f0gzkc0xBCR1yseTYpoKAYf6usGe3D6MMCcV9W+DuL/O
 5tyu3aKU3lzlZ+yxH2PxOkzj3DkwaPdHCrw3NgcQKJy/PEVeqPxUMmrTuFCgyuQKU4xZ/TYuzow
 N8/MGS5leBXwy2+YkLV7/t/RI1sF41xnMt91Vu4fT9aca41/AnyoktgW4xRA1KgjquHkmAsdz32
 xRMmnh7iXn5qwahLJeyqkXFt4tXAFnS1Qvqjbe8LKHPUI+wb4ymlFrREeV93/MNbwqBW8uBWFGG
 brKCM+xeQ1ORxQOTjQ8KaJ8ep/vERwaMLyigk3t7KVT1gVfm+elSFHpyhEH9z2OVW0UMtIxPvLk
 +qiA5/YDgEtN5Nxd3wZW6o=
X-Received: by 2002:a05:6a20:1605:b0:3dd:a197:cf26 with SMTP id
 adf61e73a8af0-3dda197d7dcmr12001110637.74.1790014565989; 
 Mon, 21 Sep 2026 11:16:05 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc72ae8eae3sm3902549a12.14.2026.09.21.11.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 11:16:05 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
Subject: [PATCH] drm/tegra: initialize channel context before publishing it
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Sep 2026 03:15:59 +0900
Message-ID: <179001455907.44752.8291506500067688174.idr-bug-37@gmail.com>
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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


tegra_drm_ioctl_channel_open() stores a new context in fpriv->contexts
before setting context->client and initializing context->mappings.
Another thread sharing the DRM file can guess the context ID and issue
CHANNEL_MAP before CHANNEL_OPEN returns. For example, the first allocated
ID in an empty context array is 1. The mapping path can then dereference
an uninitialized client pointer or use the mappings array before it has
been initialized. CHANNEL_CLOSE can also free the context before the open
path finishes writing those fields.

Initialize the fields before xa_alloc() makes the context visible to the
other channel ioctls.

Fixes: d7c591bc1a3f ("drm/tegra: Implement new UAPI")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Found during source review at mainline
5dd1818b15d98d4a20806cd00b1b40320b06004f. The affected source is unchanged
at 93f51579e7df248780214094418f205253383cc5.

The modified uapi.o compiled in an x86 allmodconfig build. I have not
tested this on Tegra hardware and do not have a runtime sanitizer trace.
This concerns the UAPI guarded by CONFIG_DRM_TEGRA_STAGING.

 drivers/gpu/drm/tegra/uapi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/uapi.c b/drivers/gpu/drm/tegra/uapi.c
index c0ac6b45f..1dec2f0ab 100644
--- a/drivers/gpu/drm/tegra/uapi.c
+++ b/drivers/gpu/drm/tegra/uapi.c
@@ -135,14 +135,14 @@ int tegra_drm_ioctl_channel_open(struct drm_device *drm, void *data, struct drm_
 		}
 	}
 
+	context->client = client;
+	xa_init_flags(&context->mappings, XA_FLAGS_ALLOC1);
+
 	err = xa_alloc(&fpriv->contexts, &args->context, context, XA_LIMIT(1, U32_MAX),
 		       GFP_KERNEL);
 	if (err < 0)
 		goto put_memctx;
 
-	context->client = client;
-	xa_init_flags(&context->mappings, XA_FLAGS_ALLOC1);
-
 	args->version = client->version;
 	args->capabilities = 0;
 
