Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60462C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB70210F66B;
	Fri,  3 Jul 2026 07:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="pyCAMLny";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7AE510E4A9
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:05:42 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-73b7c3791dbso841340137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782993942; x=1783598742; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Xv536fNaoYEArBq1hqEwEiGIOw+jADuSEkc+GlzLZk=;
 b=pyCAMLnyG4ouN8kJTFzC9IK9/FYu7RdFbyWOAnl/4CybYs6SullfHK1WwKjATogI6m
 hy1sas1D/l1AnzQv/wgaTo6Fuc4sbAN2mIUJJugWFcoWSG9HitnQ9UXKqoNQ0iWGoJtw
 QyZkYyqHQDfKUPnCLolNXfPFsil6CPLx3siVBk/MpPDQvZ8ma2tpk0nSIsOb1lKVP/Jf
 Y74WqCByoV8EoAIFU/NabTifcmOBzOQ6bh3l+Mip0lMkbxCmu7NdR/Jrn8GsbG26YI0r
 4QTkKN2R+wE8w+hjoLoEOVucpOloGrLg9ObgFcEaMFGD9+woSXPtIHBNZ4/ho2ghoAyz
 pnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782993942; x=1783598742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Xv536fNaoYEArBq1hqEwEiGIOw+jADuSEkc+GlzLZk=;
 b=nfP2X21rDcrw4IxRtwtp4fCDyZ8HLNkHmsMZ0eLVACTN2sMFpA758JVgIWCEr+AOA5
 jLiHTT9eRB/IKhi8LCrw80Z3+SDQ96THF7gbSFlBslveMt2Ozdl/AitMOzj+13BVUKxx
 ACDup7Vr1r1dapZN6xKFv8zDtIs/MdHLj5ZfXThFRxNnuVUkqUKswt9hNuba7fnyU3RF
 m6xTS8HeQUWXnhIz7gRUwagh+FcNbrbcWWAtktRLLxuqV4PwVvVe6tw6E8CKA/nPMk82
 mV/LEt3Zlkod7GaJJ+tvL5RuWFRivWCO2J+XzkHz4SZffSL85Q1KzVu2mkxo/kFFXIhn
 BljQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoazCH2J5jTvbSQmOm9/ycQly2yb6cXiLHffVtyLTpt7hTe4SlTvm96lzwUAdOjGkUIz01wTkeSTlw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJEHM1G3hGGO73AaPJNF4iExbb6NNju0zxGqFqqfUxnwZ9zz3Z
 ZjT60YMxi7UQ2hVzuG718zh5jYuJ79fI9nL1X1LgaxeKNX3Wei1KwCsLxVVAcaqZAHk=
X-Gm-Gg: AfdE7cml9lwKD/jJ3Z7mKAcHwn5lEoWzrKMM4KfmMOMMT4t9m7lFr2Rmi8Vj/CRSRdL
 X1U5wnPmHg8tlI22kciooR1qBZD4Z463g+m2Iy7uG3xyvkACmGj3ghj5pV6VPvgIubSBa594WSl
 wCw/gg3RuMT872Sq+d0GbUYi/sTQPfR/G4LOE2VfCzDVtTUHWKoWXvX74gYB2PHgeScTLUUYZHF
 TUuUAjMpcZ7SWHVoCFzDMTb79G8gXdzpwrxCqB3IKhuK3lAMi1Fs2VHunFIb5O95ddYcVpViWwe
 szKbAbagY/gIHOpWb971ES/ESSuz5ihZQMlsUq865ryhvMH8ACC1QTICxw2fLNjljDBIBfAf7UV
 O6Wf52+pWpm79iBbcO4s9FzVm52HdDaFp9VkNFTS7JZDwxmWZCwOGDJryUGeAbbY8BhiAr5bkjE
 KRVse5kcWlIlQ3wtY=
X-Received: by 2002:a05:6102:441c:b0:729:1a8d:b2d9 with SMTP id
 ada2fe7eead31-73da9cf0b77mr2617416137.22.1782993941774; 
 Thu, 02 Jul 2026 05:05:41 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1caf43casm1182470137.11.2026.07.02.05.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:05:41 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH v2 1/5] drm/nova: use `zerocopy` in firmware.rs
Date: Thu,  2 Jul 2026 09:03:20 -0300
Message-Id: <20260702120324.40388-2-niyudi.honda@gmail.com>
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

In firmware.rs, replace the following `transmute` traits with their
`zerocopy` equivalents:

- `transmute::FromBytes` -> `zerocopy::FromBytes`

Update call sites accordingly.

Note that the module `elf` is untouched, as the bindings generated by
bindgen do not implement `FromBytes` for the structs.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 drivers/gpu/nova-core/firmware.rs                  | 10 +++-------
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  4 +++-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index a94820a3b335..80ce0df244a8 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -11,8 +11,7 @@
     device,
     firmware,
     prelude::*,
-    str::CString,
-    transmute::FromBytes, //
+    str::CString, //
 };
 
 use crate::{
@@ -347,7 +346,7 @@ fn no_patch_signature(self) -> FirmwareObject<F, Signed> {
 
 /// Header common to most firmware files.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 struct BinHdr {
     /// Magic number, must be `0x10de`.
     bin_magic: u32,
@@ -363,9 +362,6 @@ struct BinHdr {
     data_size: u32,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
-unsafe impl FromBytes for BinHdr {}
-
 // A firmware blob starting with a `BinHdr`.
 struct BinFirmware<'a> {
     hdr: BinHdr,
@@ -381,7 +377,7 @@ fn new(fw: &'a firmware::Firmware) -> Result<Self> {
 
         fw.get(0..size_of::<BinHdr>())
             // Extract header.
-            .and_then(BinHdr::from_bytes_copy)
+            .and_then(|b| BinHdr::read_from_bytes(b).ok())
             // Validate header.
             .filter(|hdr| hdr.bin_magic == BIN_MAGIC)
             .map(|hdr| Self { hdr, fw })
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index d9fafd2eea5b..66b9f4d1b41c 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -25,6 +25,8 @@
     },
 };
 
+use zerocopy::FromBytes as _;
+
 use crate::{
     driver::Bar0,
     falcon::{
@@ -150,7 +152,7 @@ pub(crate) fn new(
         let hdr = fw
             .data()
             .get(0..size_of::<BinHdr>())
-            .and_then(BinHdr::from_bytes_copy)
+            .and_then(|b| BinHdr::read_from_bytes(b).ok())
             .ok_or(EINVAL)?;
 
         let desc = {
-- 
2.34.1

