Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FBDC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 04:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9342610E7E8;
	Wed, 23 Sep 2026 04:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZR0vr4gL";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8566F10E7E8
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 04:56:26 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso321033b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790139386; x=1790744186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qra++7QT1u/2cZF1D+tg8w8VOq0NYWF4+x38DgQtB7M=;
 b=ZR0vr4gL6ugON3z8Vy9FH9Z9SKzdxqrF4WlfmjR5FC/ZveiUrM+uZutpwj+ZB4Dk37
 boPIfysz/qc3puxIRtEEXl2yZRxHozneiZqGueIovFGZc7Qceoudm4pLGyi0fB+FAah4
 vGRIIOdQmVRj2hXCxz/ArSHVNfoviN6k0LCGAxbTJEYeyoxpLl5pB19dZ7GIgebrzIFN
 V9a7/InlmvN/pPgPbhgQECZuOnIkf/Ri2C5n1/AY/I1xF7czIpVpIo7hsUShAnwYaOxa
 POm8NR2Jkg8AqgeZfF6to/16Y9zBfdFVCC3AOQxht1bUc9IKGPF21dlmnPttXibqP/zw
 xEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790139386; x=1790744186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qra++7QT1u/2cZF1D+tg8w8VOq0NYWF4+x38DgQtB7M=;
 b=iVN3cNsvyM6SVo6ci3/cMWSwUu3yhaYJvJM9y8dfoSaJpaW3DOI9x3OyzunnZTLZss
 9C+uoD+DeF97EBa11uL2h2UcJoVrm3hTm+At+5pgxZ0Qskf0neZavYe39x+UAqasOhm5
 qoSX64xUdFv3LMBcjw665StAha9KBcG91enOKtEYV/PXjz+Nbv3qrl4eyLFk7rDwmAxH
 oqZHkD8Wkv/vW1UeaqthYeuKAmVvk9t8cZ6gsUeIIrTuoPfAV4LVsJjQtR58NcX3cSHo
 2gvEr2nUm2CMOG3lNeZiQX3LSSwHLFiRwpHZBCU9HKYnmePTh2THuqnuIFBwEk2T8sil
 Yh2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqI5+mlnOo+uPgGKYeGzuT1gifWEJQKt4MZaoAEhqScdwUAX0wUZrmlPMkMv4wd6JqshAUxbbBO7M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kE6Wko1aGvC5AJQGxFyv+xJOImYzr26fL1Kd/jzbEubdcoILDH
 thhTR610bXjUK7qeLdlwsiuYZ2d81Jo1i2yuFnXMiQi5/5RuAIKrehpn
X-Gm-Gg: AYBFou36qiYqEalCRj5o5TI6F557ySI/Tdsj53KA0/r38cqOmtk0taNbCUsoIC25jOE
 9pxrGvpBDMa1uJnfinGZAa8zKSW1N11i11BF1jkakPwe24AWurN7smD778PIhW7u1UPdc7zukdp
 O/p2K0z5S9C+QdCNAGU1f8XdCpmIDXxfGD7FH+p4/nr5rl5rvnRLcylRBGDg+2uzAtEq/kk30Cq
 0DUNgXOmVAr+sdhIDiY6iCM+OBMS0eQQvfxYkP9L8njqVHJYBwaKmUIx/grYvmz5pcsEBGl/K5Y
 ssBvBmkiCcjl0QTtWFBVbWzQvME3zovb84aJ7kCKLMCAzJvpjczmenbVfZ+cfQ27AZrWBP9RuDP
 HcIOlXTkutx0HuQuob+yD8pwGknODtKQcgEXouPjZljdALFKs3m35QXlsCt3qisDuobwlShfj4V
 VeyYNykKtcccvb/wb1dXHU8NbMY3is/zBmYLXQSIUqNxV5fw5Pwno1uxGvxvNy6OfA3vSU5imJu
 viv
X-Received: by 2002:a05:6a00:2354:b0:87c:d00a:f350 with SMTP id
 d2e1a72fcca58-87d1d6c1be0mr1485300b3a.48.1790139385958; 
 Tue, 22 Sep 2026 21:56:25 -0700 (PDT)
Received: from localhost ([95.190.82.222]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1cec2d34sm664129b3a.14.2026.09.22.21.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 21:56:25 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v5 3/3] Documentation: nova: remove completed GSP log buffer
 task
Date: Wed, 23 Sep 2026 11:55:51 +0700
Message-ID: <20260923045551.229259-4-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923045551.229259-1-vladazaharova2018@gmail.com>
References: <20260923045551.229259-1-vladazaharova2018@gmail.com>
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

Exposing the GSP-RM log buffers through debugfs is implemented, and with
the gsp_keep_logs module parameter they now also survive a failed probe,
which was the part of the task that was still missing.

Assisted-by: LLM
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 Documentation/gpu/nova/core/todo.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index a01c362b1be0..28fc7329d56b 100644
--- a/Documentation/gpu/nova/core/todo.rst
+++ b/Documentation/gpu/nova/core/todo.rst
@@ -141,18 +141,6 @@ Implement support for instmem (bar2) used to store page tables.
 GPU System Processor (GSP)
 ==========================
 
-Export GSP log buffers
-----------------------
-
-Recent patches from Timur Tabi [1] added support to expose GSP-RM log buffers
-(even after failure to probe the driver) through debugfs.
-
-This is also an interesting feature for nova-core, especially in the early days.
-
-| Link: https://lore.kernel.org/nouveau/20241030202952.694055-2-ttabi@nvidia.com/ [1]
-| Reference: Debugfs abstractions
-| Complexity: Intermediate
-
 GSP firmware abstraction
 ------------------------
 
-- 
2.55.0

