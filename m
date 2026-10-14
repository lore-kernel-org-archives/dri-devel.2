Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2D3CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE52810EA79;
	Wed, 14 Oct 2026 15:46:37 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31BCF10EA79
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:46:31 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cd5d2dafeccso1737065a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 08:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791992791; x=1792597591; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MZIBM6OQ5GTAEXrN98yT6rtm+n99DbEWIcKJB9r7iPc=;
 b=JMrwkvvBQ0KIFHvmfzCLMvH+mDC2JzuFzhPvMAk22/cRH4tpJLoM+L/g4IxJLt4U9U
 1nPAOf7zFgQ++NhI2M9o91RTZlIkTSbHFo4UYxuoM0S2J4k1kHrV1ICKJIclLz6qgaQF
 4foiUc4jtLYi1L+H84XF9bA3O2v8YF1EsMTpF3TYSOFaijGHXsrqsfZajI4TWqLYLiSF
 UUDe1MuA88bu5T1reFHUiL3HLczLKbWXMmcegq3KvbPPmkdw+3Axhsq+6+aFVF82k2Lc
 a+y9nz32DkW27f3Ppna1yGIM7UGNZrADu37RfBGzCEBeRvDY0eaU7rc81mUgIdPdDsHg
 CJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791992791; x=1792597591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MZIBM6OQ5GTAEXrN98yT6rtm+n99DbEWIcKJB9r7iPc=;
 b=E6ga4++zwl47/m7td0B2HPLxzfhhSm7S1g/TgMVzxGrEQfip+gS9UiuUnGZ53rdZdd
 6bu9Jgl1CjIapXz3eEzOq241ppRK5Wjx0KeDV/jAM0xfQ/v1AyiUDf8PXX0d+PqE3QAQ
 BSbuds7BBrMIe1WD7OWSHxMRY4qFI9iIKlM9KFv5NuEfr95zlnH7v8tyF1a12b+qgk1M
 6Eea95BY/a6sOYLjlVddZK5DioDUB/CV7KIEdLv+eqUxeEUqXaL4Qw2Ch96aTGl4fWlZ
 sRrrkSZ9qQ053HKe96AHMznw1d7PGZ5Uml1/RgOGcuW1EUrMHSjMGFD62woWhX5175Op
 3wNw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMk+20h5Pi20m27zZDVUkOXbTbqqwDUF0UvyKepmacfZEIzIjlZiBIO5sNKflNFApUc/G5LswtdZY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK9KQWi0AQJr22di7QiHG8k0P1WdwwFf8bXU0oTzr/VaZ3E9NsV
 wZ1PGgE80zc5bHcutI8H6v4o/aqJehCdQ1kXg83L2abcXJDIosnyKIX3
X-Gm-Gg: AYBFou0X5YpcY0v3+omnBVq4gOYICWVYpgQxMkXWH+/4nabUU8ucOw8Q6ZInPvdUPco
 afOyTbfMkZ3x2uJhGWC0EGBWBaBPFz19pLr/r9ZJduuSYvNYXJB5EDeU8tL24KABbTP5cjfuFHb
 N2pFlBSCVx7q2AOYfDV3qqEFqxs17hTf5VVWqeY9scHR9oi0Tt16i+VFUuD24nKFOe8kVCz/Rmm
 CQOjUPA94q8/XUEB44McHOQnrZCPRtNp5PhS5zGI51W+xnxZJRvk9Q1twAMhGQzGTQtDGRhUMOL
 1f2RkTU5XXrATDqaHUyM9nj04X0J1aupRoDlQ794AidE/e4uP7rRh5S70WHBZ1k7nacku7tBUka
 pG4K1Nssc8u4PH5RaDiFr1Y1junCcJwRYaX/8MpITSqXdtYqTAux+mLbMQsaTvKkz+iOhfoOg4H
 c+eqL6+Ja380Vv2rHKMK1oD0jG5/MXsIxiJIH+pYoa8J/5YuAxeBqqrobec9un3o2oEMBOhvryv
 Vho
X-Received: by 2002:a05:6a21:6813:b0:3e1:bb35:476c with SMTP id
 adf61e73a8af0-3e1bb354babmr5956800637.72.1791992790646; 
 Wed, 14 Oct 2026 08:46:30 -0700 (PDT)
Received: from localhost ([37.22.102.248]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d80511db9sm1300598b3a.56.2026.10.14.08.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 08:46:29 -0700 (PDT)
From: Vladislav Zaharov <vladazaharova2018@gmail.com>
To: dakr@kernel.org,
	jhubbard@nvidia.com
Cc: acourbot@nvidia.com, aliceryhl@google.com, ttabi@nvidia.com,
 gary@garyguo.net, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Vladislav Zaharov <vladazaharova2018@gmail.com>
Subject: [PATCH v6 3/3] Documentation: nova: remove completed GSP log buffer
 task
Date: Wed, 14 Oct 2026 22:45:54 +0700
Message-ID: <20261014154554.231015-4-vladazaharova2018@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014154554.231015-1-vladazaharova2018@gmail.com>
References: <20261014154554.231015-1-vladazaharova2018@gmail.com>
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
2.56.0

