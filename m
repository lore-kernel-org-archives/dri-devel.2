Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EA8C5B569
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 234E710E647;
	Mon, 10 Aug 2026 06:37:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PE1Jo4OS";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E195F10E088
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 21:10:42 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cacf197759so11473565ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 14:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786223442; x=1786828242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6hwMQ2HMVOe/ZrnavsLxJJgOKuAnP/w9GzcsAMiyxO4=;
 b=PE1Jo4OS/TB/1huSea82t2wcTgOuKeAljtlmgNaIZG1B50wih8E8UP1XbyFH+Q7vpk
 7Z7louzpaKJbM0pNeOJtw+jmDFac77We8RVGOQ2iGs5Y8NmJqBlNbdHyNVzuz85g36Xh
 cdOS2DDKZwGddT3pLtlbciPGkWXvFy2mi6Kaoq1tGidKEfpTz905ZmlYaoQZfIN6uEL1
 d/aFGU7Axj/qm79HQV8LaFaeeSPeJDgqJs/xen0t685/71TsYFgU/yWmH27YlmITrMfy
 epp1TSSz+tSUfc6+vqNbTFW8V7WznI2CP/rGxKtLoGo+rwjtT6PybUEVlxX12kbUpM//
 3wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786223442; x=1786828242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6hwMQ2HMVOe/ZrnavsLxJJgOKuAnP/w9GzcsAMiyxO4=;
 b=NkN4CmhCkArcQC7RMISCSvXa7vupLvwM98Ns3gVLX7Phk0MYfU6BCn/QNjD4EmfNz9
 74X5pOdRtEUiNYwjH6MyTEKc4KG1ri5MuaSXFuSD6keRK9Jl4OvFmKBupVky5vKpEUow
 mLoAHEhPMxATQEwt1N7ZT8qaIe4NQ97w4dYAVLfOqc8v9oJh7v515UlP99bxrAaHwa2i
 CQNH04b8oZNHEy9z57bLtkhrgPWqcP6eF+pcOHTswCw8hCqBvr4ZjFjP0+JPd71Vx6h5
 Ku6ShBgjfqEvFLF0OGwlZf8MIfPiXsvx9nPtwnk6PNaEwaWMqv1DUI40ipIkNYpQVO7d
 g5JA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUiyQXjpIXoa/+d/CRPjz1LiSMlZlmHfDhSEsqX2y8/JureTnuo65JZAqt3D3GYbDR0u7RAHDoZnI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8Nyw7p4MlXDK535lZ9wh9hq/XXtIukpZVO8LtA3TMQxGDLJ+G
 BgHteX+IwdB1ojOzrPC12RAx6pgIJHRdxhinVBsPn64kA/lqBoEXBv6F
X-Gm-Gg: AR+sD13WITNqE50fgZCpWAfdkqD9TB8a1pNRbUt8LXebW9AFJOQV4KbbkEtA7sGtu5Q
 Jhi+24z+uLDuWsMyWB3VJIHqtqutVWqPECVV/cJf/IOWxMPdnwCi20PzhSf+VcJ3aaHmfQCUUeu
 dAlS7FYKx8kVuWAPA4WaeQUjFYvbVmCq6nsu7Mc/sOVkuqxk0ywd+3cw3Hg292ai/doE9T5CoHK
 9Ql1c8rkMqAlrZ74wXxlpKnvdkmBCkwTT8ItINzRXhA2P9R4ZTjl+89JvSH4j/GiSJGs0e5qrau
 IytrmqZv7KPIA87bdQMRwXMN7Z+3DVSSzG00tw3DYsWHg7ZjTQX/z3BrT2c8oxHAkmYYkDey1S5
 aUnXjBE/r7X8ile0N6+zDdGwq/TbcqnRS/JJMye0sOdg3/Nn7+LsgibWhJE2A92azWhmgPLUEBN
 O8Cnf4bxLlm6610lV1SRFfgGCu8EuN85mDmg5zFqJir9LbxPOcK+M79+qJ0mOx00qGf6f947Fkt
 Qa8n5F7e6Q=
X-Received: by 2002:a05:6a20:4322:b0:3c3:b57b:6285 with SMTP id
 adf61e73a8af0-3cbc01b4a9bmr11804825637.13.1786223442339; 
 Sat, 08 Aug 2026 14:10:42 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec5aac2sm25713133eec.30.2026.08.08.14.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 14:10:41 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH 4/5] drm/amdgpu/aca: Add missing NULL check for banks
 parameter in aca_banks_add_bank
Date: Sat,  8 Aug 2026 21:08:51 +0000
Message-ID: <20260808210852.2938-5-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
References: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

aca_banks_add_bank() verified that the 'bank' parameter was non-NULL,
but passed 'banks' directly into list_add_tail(&node->node, &banks->list)
and incremented 'banks->nr_banks' without validating whether 'banks' was
NULL.

Add a NULL check for 'banks' to prevent a kernel NULL pointer
dereference if an invalid pointer is passed by a caller.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 1cddacb7c554..47f3bcd5de0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -49,7 +49,7 @@ static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank *bank)
 {
 	struct aca_bank_node *node;
 
-	if (!bank)
+	if (!banks || !bank)
 		return -EINVAL;
 
 	node = kvzalloc_obj(*node);
-- 
2.54.0

