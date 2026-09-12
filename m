Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A420C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551F010E9E3;
	Sun, 13 Sep 2026 20:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W0J0iahb";
	dkim-atps=neutral
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57C6C10E374
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:18:51 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-3a2015bbfceso16265771fa.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 00:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789197529; x=1789802329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NgkFZajAQJmzi//1l9aIpRfIFvgCaKKT8i3Z0CDYaWs=;
 b=W0J0iahbJwC7xU4I7maua9OqXmQVDaxk3j2v3CWpMDycBJN5CX2wo1ylpFFyAdrJv6
 Qv8zKMa0yyj4H9fclIAchE2QnG9yNPE+sMUr6BAb7GFrrtvrDULREXUdB4p/dBgu39AH
 48H3GaxQuvCOHp1XnVeEJqsu+QZNkrWVgJA0Og2/YcxZspOR21e1S1oeRR+1wLSF/lCK
 /DPn/5H1KeaSzHOco/n7n6JkuP8UO7y6ygO+jc76RZ46oTeRp078/kjWgsnClL1AtMwN
 Q0hGRs4E24GALKgl+bOQtIfj0dI+mONtcI5srPCkG5H/HlRr4d+gsIV/x9ynIVjTmrkf
 xCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789197529; x=1789802329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NgkFZajAQJmzi//1l9aIpRfIFvgCaKKT8i3Z0CDYaWs=;
 b=jZlmgcgQm0Jl3dHZhBb9NTADvmqEVxlFHqKvyp5Dli/Buvb0z5pRH65fBXFoGV5SlG
 GkESur8l7eUKpfQjszR5LzRcxpi5ubLuzEQ64myGm9gQ30rvSxM/R1744LPp/aRffdxb
 9Tdb3mL2up/cE7U4BZ6o9fniKhNoTc9HGlF3FgARUXJpc84hBzvFJAqiqBDJZrHGvOTl
 2TVaIO7Ccbyvwo154w6Upy2zyQUv/VnhHGzqCk90G/CiVOjjf5KFrViCy+lWji1r+Hon
 7ZzkyZBQinAiKfCZKjzImgiICix5p7jARfNkIu4YzxdfaMI+zSc5LsKDl2AWVuvY3YQV
 uZ9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1+ixOoA26IxcUcRU8f6CNtyfn52FL5zv2JAUMY7U9xU0alQKanZsmyqmK7gaD3w2tpK4TAinckTM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++leLvk4wOy1V3l6GIT1uLmcHzVNxNlyQ2ZK2JEoob7XG8kVx3o4
 6aMAZqW/SD+C/bv+yxs+5e5Ux4gNvx/7W6PY8mfUlRfXt+z0QYtc0anC
X-Gm-Gg: AYBFou0SggHuz1D+Xwpcri74s+6z/wtoankkWa4OgjCOk3ccz2CWS9sLemfBSklS0gP
 kKcwdF1rGF5z0OHGp6CvwA+PKDKRSgOm0RFJYdBPDDMtxI36bhq8T9ErXJyoPZPtr1+X0eBySIg
 YHsQbsaeUaaBU/qcuslSgZmPEI4YuTNYgEThGKgW8anXgGRIhHNs8XlkmQ2HTZ8bp3R7SE7z0cD
 RTVL6pVmyfwbSsHH6BRIXRSLae4vO3m5bg2Hq3lhhK5C9k97Hrv5+hzC+UtCez9nikkpKFnZmBj
 8SPQz9vDp4fp9py10xPxfgv6W1uL0X39AJ3mp+L3cZycwS+4tSGpccpWNPEpZdyhfnXhpAmMm/5
 IdtJ5OYEDwAUyFeL0Foc7Ujssbuhv3PzbyPcBdRlu+jKQM7Y+o1Uh5R6bpWIVoKtklcI0AFIvrg
 pAcvhRGuh4j0J2zcoUX+INPHMSQoXkf8iFIK7BSWi+rM701L21GViLj/YknkqNl8LnEGiPA3ZhA
 ZtQ9A==
X-Received: by 2002:a2e:a596:0:b0:3a4:68f1:8bee with SMTP id
 38308e7fff4ca-3a59108ac42mr14680391fa.6.1789197529066; 
 Sat, 12 Sep 2026 00:18:49 -0700 (PDT)
Received: from localhost ([95.190.112.239]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a04571b0sm1096277e87.13.2026.09.12.00.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 00:18:48 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v3 3/3] Documentation: nova: remove completed GSP log buffer
 task
Date: Sat, 12 Sep 2026 14:18:42 +0700
Message-ID: <20260912071842.622696-4-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912071842.622696-1-vladazaharova2018@gmail.com>
References: <20260912071842.622696-1-vladazaharova2018@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

Assisted-by: Claude:claude-opus-5
Signed-off-by: Vladislav Zaharov <vladazaharova2018@gmail.com>
---
 Documentation/gpu/nova/core/todo.rst | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Documentation/gpu/nova/core/todo.rst b/Documentation/gpu/nova/core/todo.rst
index d5130b2b08fb..cae0578d32f1 100644
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

