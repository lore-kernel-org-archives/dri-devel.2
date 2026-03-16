Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AE8F3380E
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B2710E54B;
	Tue, 17 Mar 2026 08:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OBLbdcc0";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E50E10E4FE
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 12:08:40 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-35a1f549e7eso2056973a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773662920; x=1774267720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/HmswETn8XM8b74AAva4wxSUFI8VgvK+V0Z0VnScGU=;
 b=OBLbdcc0KCdoi7Qq23UKrC2RluvCMBKtdybiCBFgA4nPkjWsTxlLwc6Bn/U7iXll4p
 S9ki7Ps5eilzJYHN5KnSvkJ2WgmCaysXgfp+rS2g5h+Tp4izCeno9pDaszD7KKtugpFZ
 I7jbyrGtBihrIPTSbpzK9i0F6elaXhwIzYbp9478t+mIhoecXLB1WvPPERUaSTrgLGo1
 i1NtdunIoveMZlMX0/uVgg65kSHtHzZjfcx+qnq2hW/F9Fhd5K8r4O3JKNh71kWRMOoD
 icfNZNhCxPyxIy/UScYlrna/vGjArz01VFjXRsf8zy3SCBW1aamtnbnOCVEBX9l0YwXK
 /J0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773662920; x=1774267720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B/HmswETn8XM8b74AAva4wxSUFI8VgvK+V0Z0VnScGU=;
 b=CxNglfLSPA1cmIi69VjSWFwB/IuWPafVkX51GWolc68RJfCRabKHZtEvCb70Izlwaa
 /eUvJHaCaWFROAvUKN15swbPWSsKL39Pb78Hqw/+yOcOtWKpUscVi3i8Dn45Cye5Q7Na
 8wMqhf3wPkDfHhEMMurLK7uIf74RQIuksJ/qd8jgNt2DYFe9iTiq2Qu5xKoGpx4wc4td
 dNhlB1HIpiHcq2KFuMQhQfyj48d96RCSiD4XXJ3kx7kV/WaqPzvjLetxPXKsCbtdCtb4
 NwpYuEhlQw74LLKSGAoKoTMnBHh7vwCjCgoRaU5okIp0dh4NXW4kcHQK+QH4l4oJea4L
 1CUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlHNh3BIfdiiXsYmZ96DluFtFMYsdtF7X6duNOB1qJfgzOHcOGyX3rlTJCdFelB8qZbi+cc1uz2C0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlxMXEOdL9srlin9fV9Lug6XLKIDf9+ty6AhSnOGtCWH/Y5oop
 XtJ/j7ZEM6WM4a2kll4XnFI+5+Q35eKP1v1ap8wpASCtoU+NLoV1gI4Q
X-Gm-Gg: ATEYQzwib4/CK1uBZT5vp5rnIA6BvPHG1OKtaPpIzvWGAZAfodcL/YhxugFAyCCQNm3
 NcGdz4Hqv92lIcDn/rzc/iV7pfeN36fwKneWVmQH+q4Wwtsf/eQW5nWBd+3yKmxm7NGqUztGygY
 07onaGpjbk4n3bAT0w97psNmHU9AZSeVg7nUPLylE00SD/Tpgjn5gwzR5w6vheIQcgl4i94MJ4l
 9st4pYMLS4K6Obp+3cdSfb09IDjOfGeOOH5o3nwb1JuqSUp2vDqxctaXnBr4Lq2oY513oSlYx8C
 mhUNQl9MY8MewqLLoqcerdC1jnKnpgkhN7fJ96gWFmqaLknsTLJhUmGvG/P5GlEP5Wa8pfAcLxs
 EGT/QS2A4JJHmrVY5xc30T1YorRGtX/XMG8Gn073uF1e+HGdU03B6OoKAZMJo0Wg96hytXL7JJP
 tDJ7d08cu+8jfppWKgOGXBsYJW17/WZZGPJUglaaoqSa5egwPwkYLF
X-Received: by 2002:a17:90b:510b:b0:33b:b078:d6d3 with SMTP id
 98e67ed59e1d1-35a21fd68f4mr11272122a91.23.1773662919828; 
 Mon, 16 Mar 2026 05:08:39 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net
 ([2001:288:7001:1099:c21f:f7d6:f4bc:6198])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35b9e36f45asm3240083a91.3.2026.03.16.05.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 05:08:39 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Gary Guo <gary@garyguo.net>,
 John Hubbard <jhubbard@nvidia.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>, Timur Tabi <ttabi@nvidia.com>
Subject: [PATCH v2 1/2] gpu: nova: rename drivers to use kebab-case convention
Date: Mon, 16 Mar 2026 20:08:19 +0800
Message-ID: <20260316120820.2117081-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260316120820.2117081-1-yphbchou0911@gmail.com>
References: <20260316120820.2117081-1-yphbchou0911@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:02:43 +0000
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

Rename nova-core driver from "NovaCore" to "nova-core" and nova-drm
driver from "Nova" to "nova-drm" to follow kernel naming conventions
before these names become UAPI (e.g. exposed via driver_override).

Also fix the nova-drm driver description from "Nvidia Graphics" to
"NVIDIA Graphics and Compute".

Link: https://github.com/Rust-for-Linux/linux/issues/1228
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Acked-by: Timur Tabi <ttabi@nvidia.com>
---
 drivers/gpu/drm/nova/driver.rs     | 6 +++---
 drivers/gpu/drm/nova/nova.rs       | 2 +-
 drivers/gpu/nova-core/nova_core.rs | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index b1af0a099551..e3de04f358f0 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -32,11 +32,11 @@ pub(crate) struct NovaData {
     major: 0,
     minor: 0,
     patchlevel: 0,
-    name: c"nova",
-    desc: c"Nvidia Graphics",
+    name: c"nova-drm",
+    desc: c"NVIDIA Graphics and Compute",
 };
 
-const NOVA_CORE_MODULE_NAME: &CStr = c"NovaCore";
+const NOVA_CORE_MODULE_NAME: &CStr = c"nova-core";
 const AUXILIARY_NAME: &CStr = c"nova-drm";
 
 kernel::auxiliary_device_table!(
diff --git a/drivers/gpu/drm/nova/nova.rs b/drivers/gpu/drm/nova/nova.rs
index 8893e58ee0db..1fd454c7e0df 100644
--- a/drivers/gpu/drm/nova/nova.rs
+++ b/drivers/gpu/drm/nova/nova.rs
@@ -10,7 +10,7 @@
 
 kernel::module_auxiliary_driver! {
     type: NovaDriver,
-    name: "Nova",
+    name: "nova-drm",
     authors: ["Danilo Krummrich"],
     description: "Nova GPU driver",
     license: "GPL v2",
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index c1121e7c64c5..90e98380687b 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -22,7 +22,7 @@
 
 kernel::module_pci_driver! {
     type: driver::NovaCore,
-    name: "NovaCore",
+    name: "nova-core",
     authors: ["Danilo Krummrich"],
     description: "Nova Core GPU driver",
     license: "GPL v2",
-- 
2.48.1

