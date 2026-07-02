Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C6AC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E94710F67C;
	Fri,  3 Jul 2026 07:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="pT6Y0ydl";
	dkim-atps=neutral
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3B610E4A9
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:05:57 +0000 (UTC)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-966d70b9e1cso1013321241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782993956; x=1783598756; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGgdNIxUjLSQ4UNZW/FdSoJV4OLj/5NQZw2raQ+vfnI=;
 b=pT6Y0ydlIARskgr1RNjxbnRZ/5D60xkOQhP21Wlv/KfOe3L2InTAVoAQTSWBmxkRnW
 osQodml6KWfh9ZpdGY8fFHk4IuK1oq/L+qylu5xcqhMXdqjPZvgkVF1HrOy0/GsoiriC
 IEZZym9VbOkhx5bFX1nalflp5sYGy2UyVU/NqJxrNHalJ7xCnrCPfFHTh9LoPXDzprQC
 +o1Wp33wbg9vpb3Nx/CzTZ5Z1RXJaVZfbH8gnUPEhC/UIWYbcoGnyaoqaeHcT2OlMlCh
 eu8f3GWpCkw/bIUNS+LGYoGfv5rUGp/ixoIb5DtE97zfZjobst08caaMJjq1fRCN6Dqj
 XN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782993956; x=1783598756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UGgdNIxUjLSQ4UNZW/FdSoJV4OLj/5NQZw2raQ+vfnI=;
 b=eLhRR1sJuGx4RKnSQvstGyuXzlP2iSpF/0RlEN57I6GbU4WsJoI5R18d5reUIJUmnw
 r4wEFEQbNMLQBeRDK6UwBgM5/aTTvnJ91bECN6Pdlacfvhd/gWkg7/bodG/PJQ46C9TP
 oFvrawZ4HfIyFyesR5cS4OwA1LCRzXVpQ/mdTk+KU2D/725yzBN5jTq/h0iASf3f6m78
 LHKsC0m2ADBPGmj8lDdSFrOgKeWVCyUJaf3QnYs69BHEOXK50Fy2ev73UCBPVXkk2u6i
 MF4ZzaIdRV4zyaiP8deXEDJBHx7BXceB2qGtzHXhfJS8oVlWWuR/+IsPZ1eCrY92IvSr
 POcg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlrkeZudfnMRHwfLWxpBhjU4VuHsShW3L3dISE1toMg6POBsPgHhX8BJyVgHve6bV3xia6JHaVxb4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3EVgTpwRRX3q3pq2f4/oTZLN8+IrhD3kRsr99EjuZ0Nj+6Mx7
 I1bYsN+cOrYcKazaIEQ9UD1QbCwWLH6r6/TNVRHqHxsYnn8G9ksKW2Sc84GxShxUvNg=
X-Gm-Gg: AfdE7clVxADTESfJ5lR6FELrPn/WjQxHQwJCLcVVgTzX4oeJKDVujv/IVzXUv16LeSb
 Jk1l/q0ZFSvSMIY5Nr+aoyl57QzpYcSrAtC80J3u9qg8C7ELfoiCEtca3ULVhwHBv1pLVqfNu5h
 MmvTHeQKwDgvleAyu+z2d+TYsJwMP/IPVMUc6hdgmZN86SN0mXshZkvjDMJX8E/ZGyQeQ1scISG
 IpFXA46uvJsnplay9IqOSNJA9MOw56LNSCLrLfEDEIuBWDm2gbU4pGmsyq+xn+X9kmu9ykarnh4
 Zwu3twmQvuI5NBxD9ky27KizYqaJo+KDHomHUhGcBqPvv4rYxrg2Hgb0nfBD+5K8hgk4PhIYEZD
 t/b52KkgAqTPLkkEqkaunBEylmMW7llTo/zTdrVSbrDYYUEXf1bu3TrxJNCyYxbVBjJhrpATTot
 537tlBVHg1nvT3QBQ=
X-Received: by 2002:a67:e95b:0:b0:73e:8694:c6da with SMTP id
 ada2fe7eead31-73e8694ccf7mr500231137.24.1782993956039; 
 Thu, 02 Jul 2026 05:05:56 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1caf43casm1182470137.11.2026.07.02.05.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:05:55 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH v2 4/5] drm/nova: use `zerocopy` in bootloader.rs
Date: Thu,  2 Jul 2026 09:03:23 -0300
Message-Id: <20260702120324.40388-5-niyudi.honda@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702120324.40388-1-niyudi.honda@gmail.com>
References: <20260702120324.40388-1-niyudi.honda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

From: Pedro Yudi Honda <niyudi.honda@usp.br>

In firmware/fwsec/bootloader.rs, replace the following `transmute`
traits with their `zerocopy` equivalents:

- `transmute::FromBytes` -> `zerocopy::FromBytes`
- `transmute::AsBytes` -> `zerocopy::IntoBytes`
- add `zerocopy::Immutable` where necessary

Update call sites accordingly.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 .../gpu/nova-core/firmware/fwsec/bootloader.rs | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index 66b9f4d1b41c..03d3090bd9ef 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -18,15 +18,9 @@
         Alignable,
         Alignment, //
     },
-    sizes,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    },
+    sizes, //
 };
 
-use zerocopy::FromBytes as _;
-
 use crate::{
     driver::Bar0,
     falcon::{
@@ -57,7 +51,7 @@
 ///
 /// Most of its fields appear to be legacy and carry incorrect values, so they are left unused.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 struct BootloaderDesc {
     /// Starting tag of bootloader.
     start_tag: u32,
@@ -73,15 +67,13 @@ struct BootloaderDesc {
     /// Size of data section in the image. Unused as we build the data section ourselves.
     _data_size: u32,
 }
-// SAFETY: any byte sequence is valid for this struct.
-unsafe impl FromBytes for BootloaderDesc {}
 
 /// Structure used by the boot-loader to load the rest of the code.
 ///
 /// This has to be filled by the GPU driver and copied into DMEM at offset
 /// [`BootloaderDesc.dmem_load_off`].
 #[repr(C, packed)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, IntoBytes, zerocopy_derive::Immutable)]
 struct BootloaderDmemDescV2 {
     /// Reserved, should always be first element.
     reserved: [u32; 4],
@@ -120,8 +112,6 @@ struct BootloaderDmemDescV2 {
     /// Arguments to be passed to the target firmware being loaded.
     argv: u32,
 }
-// SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
-unsafe impl AsBytes for BootloaderDmemDescV2 {}
 
 /// Wrapper for [`FwsecFirmware`] that includes the bootloader performing the actual load
 /// operation.
@@ -160,7 +150,7 @@ pub(crate) fn new(
 
             fw.data()
                 .get(desc_offset..)
-                .and_then(BootloaderDesc::from_bytes_copy_prefix)
+                .and_then(|b| BootloaderDesc::read_from_prefix(b).ok())
                 .ok_or(EINVAL)?
                 .0
         };
-- 
2.34.1

