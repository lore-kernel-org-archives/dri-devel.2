Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79298FF885E
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 08:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE6C10E17E;
	Sun, 26 Apr 2026 08:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RyH05gSQ";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E865710E17E
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 08:23:02 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2aaed195901so39696515ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 01:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777191782; x=1777796582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W1qEqq8PLZmBKEBDQMcGtLZPtyhcLKjlPNm9SyBR/+E=;
 b=RyH05gSQHRm6SCZSLiw3fDZaIzkDKGjFz+jSv069X0KRrYxNFEdjFls6C6kjXA5lu/
 wNHngaJZ8aHlZKZ4wu1pmsDUTrUQ/1oV2HumJAtU+fTXPH3V4JqMmTKnHdz4JQLZEp9o
 wwbyhfY0PQY9CPM7fgZ3DYfaWpMuJgt9tRoKGYbFMATDdxyWL/DYwpMENtzEl7wOA+wl
 Hy0NrDqBef0sEyTt/sqRtmaoDA27NOc6m8WiVdjdsvDFMgWKQuBGKrjjPRuoPt2fQC0w
 m0YVDVFyL0yU53yv0oNicsfehfztB+I8SqvNvku4fqlmgUmYn7gK6YiQzP3Q2rX2Rmzc
 iStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777191782; x=1777796582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W1qEqq8PLZmBKEBDQMcGtLZPtyhcLKjlPNm9SyBR/+E=;
 b=dKIKvS0O3IFcVqiG9P8nNgApYYsYUAC5oDM73D7VxsDY1lZvf6uyPHZbXFXfBIohVS
 GApWXxAbc/vRwnoxkJ3UaCk36+AtDsLqV/ZWsql/TaEiJNOrdWYvltOeW+ENxHtgLnyI
 SjoPA+ZO3sANU1j7lZdOYYdk0EKdSeZjy8b3ADuIDtFdeIjGCkVg4TRegHemZ/nT6tqw
 zlv8yz+zbjlfjo0J8U+6VVYzED3ac+uEcohi8vxUUIVs3KOsgUY6y1YUKMqgz1IB2SM8
 A5hnC6KSv67iWM7mmX7LYC7LvF3AAV1hFg5V5Q/h3w3gZIrnA6mybwGZdDSUMZ6/AZbO
 iTYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+n3rfPhab9KtJnX4KLFaFuqGubf078vvpetzUuoYEW8m68Mmxv43HCydkMo9MFfCjTXEMr1vyrj0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxeukJtiC/n78uzaKVkEyD9rL6YLV/m18svKnQgtE13KedDsyWp
 n2vYDRoHX6wWODmQyMPffVMy68gALxy7R6ZFMfsi1IhK3Kn4PnjOUBQk
X-Gm-Gg: AeBDietOShYRlzEIsAmgyFI8BySObwCnZDZYgP5Zptjw0PKyANZfGvwUPOZDyHprauo
 vGnstpGTs0hPF20zYt7P6eEw3p+7pnTcr0nxsga40Si+VGRyqFRTiH+vJyfH9bxuvdVkgJjv+UA
 NZs5ujNC9OsO2vU/+7aRl5s5wU08houfKjtht+M7BApYF0PoKgUkkVruWR1myvQ5u3EMFjB+ti7
 XqOx93M6wzjWNTKtK8gQuCahMxT5UyOdwARsBjgMgF+jzUw7mmi9Xk+7mEOCVf6sEcBM3loBN6n
 6B4uG9+UXdRJwg1YzQ9dcwP4kPUFj9XB/eGmdWvMC0hWD/6hWTa3c3QwcAqOGoNwILLMQqp/GIK
 ETVPqmbXbosVbvpW5/WzwRpVoB+brtpgS6ZAJxfYbB6IcKbsVoJxw/Udm9gxUm11r/rwRLP/ZON
 IpU2ZGu/azqrM8l4cRLqAdyNz8f5pFwL2hmtU8osg91bX453HME+rrmLoAuWSJgbBQEWTSFpr6A
 1Dtfj1ufzRPQxs=
X-Received: by 2002:a17:903:b8f:b0:2b0:7225:d2c0 with SMTP id
 d9443c01a7336-2b5f9fb9d4cmr376823945ad.30.1777191782308; 
 Sun, 26 Apr 2026 01:23:02 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com
 ([106.51.164.157]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0dafcsm284770165ad.52.2026.04.26.01.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 01:23:02 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dakr@kernel.org, aliceryhl@google.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, daniel.almeida@collabora.com, lina+kernel@asahilina.net,
 j@jananu.net, mkchauras@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH V1 2/2] drm: Make CONFIG_RUST_DRM_GEM_SHMEM_HELPER selectable
 from menuconfig
Date: Sun, 26 Apr 2026 13:52:34 +0530
Message-ID: <20260426082234.2026908-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426082234.2026908-1-mkchauras@gmail.com>
References: <20260426082234.2026908-1-mkchauras@gmail.com>
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

CONFIG_RUST_DRM_GEM_SHMEM_HELPER doesn't have a description leading to
not show up as a selectable menu item in menuconfig. Along side it's not
dependent on rust.

Fix this by making CONFIG_RUST_DRM_GEM_SHMEM_HELPER dependent on
CONFIG_RUST and give it a description string so that it can be selected
from menuconfig.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 drivers/gpu/drm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 8f5a8d3012e4..89adb700d710 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -269,8 +269,8 @@ config DRM_GEM_SHMEM_HELPER
 	  Choose this if you need the GEM shmem helper functions
 
 config RUST_DRM_GEM_SHMEM_HELPER
-	bool
-	depends on DRM && MMU
+	bool "Rust GEM shmem helper functions"
+	depends on DRM && MMU && RUST
 	select DRM_GEM_SHMEM_HELPER
 	help
 	  Choose this if you need the GEM shmem helper functions In Rust
-- 
2.53.0

