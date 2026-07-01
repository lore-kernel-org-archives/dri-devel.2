Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D512EC44500
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7209010F1CA;
	Thu,  2 Jul 2026 07:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="OqeLqi7P";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A6210E0A3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:41:25 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8424b00710aso686143b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782927685; x=1783532485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGgdNIxUjLSQ4UNZW/FdSoJV4OLj/5NQZw2raQ+vfnI=;
 b=OqeLqi7PGJhVTPvddICbzxZGK+syav9PSllo1lnARyrcVgKUV3HTUVOd4VchVrPOMY
 fUVFsbS/90Im//fEUfWQdj+1ZJivRmRNgwy3stWOxDCQ1Rzab0KeGbbKauv5v4TI5z0H
 FqTsdJH9j/G88NmFWx/TLgJKdTQHOfkW4466FKKgqsLv/CCRoFvIUGl6R0hEkoZFDAih
 cPcD3NI2qxx3ahTAx/2+7xir+hQAa55DtpEEt66i8uyI0cGAek6w5itoUeL1DrsIZ6xl
 O8mscI66PD3ANbWg7tDy+uvMVe2Fg565NlT5CqW56jnfXVF+K7NorCrzClMpnwmnlG7l
 patA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782927685; x=1783532485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UGgdNIxUjLSQ4UNZW/FdSoJV4OLj/5NQZw2raQ+vfnI=;
 b=hi8xzqhGOxQKxXlhJ6ycydiosvdOZXdBdwlPnEsFJzoYe5YQMygt4Dy+ppdPRkkr1w
 EpqeapOIq2e0MYP/aUAAwVWIREOCF9koWsVKVRJn4Ql4hV7gr7Mf3gw7uj30dSfZ3ZVY
 qOsRxUq6TR65QmLflqAQI4Iicnwpw7U1kPURTNrJV3Qab3VR7Rvup1fp485G2l4maMgT
 jY5PAa+QYgsBClFbigT//AvjOypatqfil0s+Jm3DWzFt2bPqSe9u+yLsq5t0TH69OmMI
 FK4N/jPvcPqfb/YzqK5d4TqolwIg56z2Nlm8Z5M8KiHqjzxPv32Ttd38AzJgf3dcoAxc
 TWQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrE3Zfp1EpEuwGK29dV03zAeu7gLe9zlOXb16pGWNTM5fnvpo9E5q8fgdfmWBkyA2nrZb/8XpS+LhI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx64mYq9uIF6P6pcInbwlVUGhsFZeR2T0RjpTtZjNrBxg8vGaal
 UOKe0V0jqt0gKqEWMgTr0WB7Dmk/ZvBFH+Kbp1vXW3SROe+8X/4/5Mq5dcIFESe3qL8=
X-Gm-Gg: AfdE7cn0SWRojtt54alGDllGjc2oJHxb/8raMPIUl0M5f43/04FErVdNqyGKc9ZFsz+
 gDw8zIoi4Ov4ap+P4cQIzo9xFclk+lauD9yzCz/1VT7ijWvkT29sjzEs+zVk0LP5MDWlr0M4KSv
 r/SGcsiLKXRPu9aV2kPj9woGDPmqvrMr1UPjAzbuA4z7Py0poy1Mqz9Rf71Ah45xzCHKAdvbRDE
 bOrYc6XV0/9fl/cy6FQZNt+dX91h3H2u+gSlYbtsTJSUiC7YPFFkn+KLfN8buFeQTloKx/Uzwmn
 KU3ESNSktNKsABLIVIP5YwcFq8bLIG3rmJ4dPxyYbkB7SrYFDUFUAFFr+saOQ3CjnqCotItaqFw
 rFvbWfx0RxX2O1Y1uzRy+xQrkRSs5D4QKr+sy3WAi9UDUxaqQMRVCqviKN+LIPOrk09MgkOGti/
 u3gp8oeGoDIRUbhRPmUzH71R4qcg==
X-Received: by 2002:a05:6a00:806:b0:847:7a61:e692 with SMTP id
 d2e1a72fcca58-847c5141198mr1623689b3a.41.1782927684998; 
 Wed, 01 Jul 2026 10:41:24 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb6dc4d0sm150943b3a.3.2026.07.01.10.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:41:24 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH v2 4/5] drm/nova: use `zerocopy` in bootloader.rs
Date: Wed,  1 Jul 2026 14:40:55 -0300
Message-Id: <20260701174056.12604-5-niyudi.honda@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701174056.12604-1-niyudi.honda@gmail.com>
References: <20260701174056.12604-1-niyudi.honda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

