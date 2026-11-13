Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963B606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CgidWxKN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD92D10EBFC;
	Fri, 13 Nov 2026 07:54:07 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE9010EBFC
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 07:54:01 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cdb9d5c1c8eso681539a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794556441; x=1795161241; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I/Osil3p9tI+TJ45W4tyUJkbTxb/QirMyt7rDHJX8Ic=;
 b=CgidWxKNX9Ial94gT3KAopNeUZHK+QTxKj2d1tZGZbRjpm5Kp6wR0oZJL6mJoHpvMD
 vZKnwjSxF0jOAuYTJIQC2VZrx5jjXRGZVX5CigIrbHOy6Ynz5NVq9tg7qF/TV/SzMQmA
 on7HAWt0sSS9+rXcwGtOGhyN1ZWoMOARZyccJohyeSIrJDMJdOsTgMt92ddo2Hu2qDFP
 pSoPlDJMEyrHUM0M0OhWk6eW/B1yRrT0mg4yvoc9CQJd1YsenaFy3H/25ko2a4x8bHgX
 Cs/y8IqrBI4VrXI5ajlNcAOenmVxuO4cyFY9Bcw12kRwTNGwtP25KEsPwmnD5b9azi07
 yPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794556441; x=1795161241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I/Osil3p9tI+TJ45W4tyUJkbTxb/QirMyt7rDHJX8Ic=;
 b=iq2zUWeAJGcx4UP0sS1UdmDIxjOSs9uJlp6Aa4ZmPASCITPEnZ9xtGjSQ7FVfM+/QG
 Epf/kyETkO+XeBnRNGEg9IDQL/nukkpBhSIkd5j1SmO6Ya0ioRIdL8CfxHm6wMFsTU8V
 gGKrSYCMKqVsU9W8cTK6326Kh5syPJA5U9YnXJaPBAHm2ieVaVWNnEMX1vUBvw1vNYt9
 xKpyzYdXYLpCPFwYm11tz9YrW/qZhfUD+x0Sv/K0wulZh2QiXvwfm4Wm0iNU4Y5v6RIP
 g0Aw2+6vYBmzwhHdlKymJrrrouNpok+f4IbRHwQMjQ/63J/LO3WG9L/s5nCupBedM7qE
 hIxg==
X-Forwarded-Encrypted: i=1;
 AL+hErHAcnaGdd/VABJfYOPNr/aKSWj81GsVlS3gFFS9EKfFLJEnX5BFIIxREEXMUXr8jhjdZy6zyM77AoI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+jJQZZDaarDtZ6Hv3s+98d/3EB3FbwAMzHJj9+7ADqtwT//vN8
 iTZ04hqXLvd/3OlCz6iJEE3oGLp1OpwGMft/MSpx6W9WvUGpq7wwbSER
X-Gm-Gg: AYBFou1I2Txz+/J79Q0MhDm/yP2Ja+dgh3XxoYvkc5b30GE3Tfwe+u2aOSgPy02U1So
 F4I5cgptoIXp5iPxAQ1uWEIuQEFt9AhGP3FPeoQbUZ62WqZYA/SMthkn/KvJokvjSz4NIa9o6uO
 rIabh54bJ9krAzCNPZG54UXhZdINVNYIhUrcG89lLAu8kmY2jihtRMW+5HKPzlkj1WBKxB+UNff
 K7e13iLrqCOZPBIqIA07svjuQfN7NNqJAPE2+1kzU5RfDYnFegRDiJA0fiXg2hlWvIb9QGyV2KA
 pfIJ/rHiHxHw18AcAcW1fopbBdy6L3ch+Hux+ZBjPWaaDyK57TxQfuIWNlkaZTVNz121ClVchvm
 wpuUeQcotfD+qkcZA/xRtxBd4YOOx10xDlO3OiBYqkjTTUQsvC1C9WFYhiL2N8Bp4NgrosB6Zp8
 arYAUjlgTDMwhkPjXH+d763ld686my99oROzBMgsK+k2cNh4HUBhCcFG0XzOMLk44FJ6DDyd2qL
 jDcSmJPCO101lGavhyAMLqpf4dcfK7+wPb/qCKq3fCPxCx370esWGk8QRuiJYm4pHhT0RpBtOAp
 kvwEQtIoo5MLymKV9CY+ki0E0GvzO+SE3Bg=
X-Received: by 2002:a17:90b:1b01:b0:3ab:2d46:1dd6 with SMTP id
 98e67ed59e1d1-3b1b087a23amr1392750a91.4.1794556441256; 
 Thu, 12 Nov 2026 23:54:01 -0800 (PST)
Received: from localhost ([176.210.133.73]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3b708adsm993234a91.4.2026.11.12.23.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 23:54:00 -0800 (PST)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, vladazaharova2018@gmail.com
Subject: [PATCH v7 4/4] Documentation: nova: remove completed GSP log buffer
 task
Date: Fri, 13 Nov 2026 14:53:17 +0700
Message-ID: <20261113075317.934264-5-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113075317.934264-1-vladazaharova2018@gmail.com>
References: <20261113075317.934264-1-vladazaharova2018@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GSP-RM log buffers are exposed in debugfs, and with gsp_keep_logs
they also survive a failed probe.

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
2.56.0

