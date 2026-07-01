Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE8DC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8705210F1B6;
	Thu,  2 Jul 2026 07:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="EVYic/H6";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0854D10E0A3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:41:12 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-847921eed4aso775225b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782927671; x=1783532471; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Xv536fNaoYEArBq1hqEwEiGIOw+jADuSEkc+GlzLZk=;
 b=EVYic/H6HIr0suDFFfNoHMGk7EhHkINLkWZwHcB3wvUdE9SZO8ze+IwT2gOLrxT9BB
 99RLFjR1wgGCRD4Oy7/oddNM4KDwrkgh4BIZqYsrFOOi+YuqNmCgYEo2b3WBKsmkIPJA
 jMxtMG8M/saINRTcUtVXfN5MhrXK7ISi9A7bmESyWuiGRw5boSvir+raX+6E81cBXAbE
 ppHBom6hvkBvUODgghnJlrpY1GmaftzTOffO+t8IwhNOT2NSuVYZ+HvahDdkiQwg7kvK
 O65d2a1dBfwcFqssOjxzwFi8XmR6Za+9IBe0yREpgnGdS+8sYVUqIcp+CFLG20oAMpCr
 nQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782927671; x=1783532471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Xv536fNaoYEArBq1hqEwEiGIOw+jADuSEkc+GlzLZk=;
 b=EgHf5a5fjiNGtWDK8wjmc5/D6KRI7KiHA3bhWSC/nA6yuzDcni3U4QUaydicOgwh6E
 F49f4VZubmglzv+FBrybdPGsvlHfZuknH5eXaL2ep6a2XjvxvgaXKd3h+ExSMIQU4e73
 Pb8vwNz15TJtGeMZiLo0iWlX28Ti3HNzNn9RwB70GG8Wilpspwdak+rGskXCFHptQpP0
 MpB7TQULGqqRJy+7n0DkVJnCGYD6l5GY5fHnvf+rMVKh64UzloG/yl07QsWrdcCKQAcl
 YKeBj6elCQQBAMpMRne7FbezrpFNAYuM6p+ABcrIqo7v7Ym8PeDq0jdfLpxFvMAoqe6z
 csUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9o5ZUDjyIjrREZFDtONgZFqIuOjmNfFFmBmOlXR6RqAoSpH8kckSgP09msWokaJNNTeNwbZH5Nlyg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxF3GbfafOTODfyESpEtb5D6V82sfRgbYhELgmyIM001TRfVc8C
 J7o9EiEShgSJ88DgI/NqydiuxExl+gROuZUDOu4iA1ehgaHjaFlgDJ13x8GHSetAInM=
X-Gm-Gg: AfdE7ck+qJsflcCZSVMe7hLWnFBxjSBE7SJGoNlJmzxNFvnqKoQw+Zcv/J9el4MxfFH
 9cHWJ3/6XB80vzsAjN4UpkAFI60IkhSTNGX106+zp/kZH6j0BQwOB9dvrJF2rhxYpy7CrGoGk3T
 8eW+DfrrIhvrSh0eFVCWowCBHL/7/NgqxtqPbucuYJFtaDaa3Pui8UlBTSiQlKRFsOeU+QH1rm4
 4I5G/B8zY4CXSJizbFTy4BiVzUMhYL9V1q1Wvlc85OY6nzIdyfXDLeHYkVDKVCWGSh5Zy39lA7I
 IOHCHQ1JQblSPGsQnpHQjpaedMPUpTWzAWg8tq3Vr6kTfBciwr/lCUdfka/P5V8XPL0FJRpMIeF
 iOhrQxnhmXNAL55eqPI3zPXUQTEAsFrLZLFeV1o09nXNr+Qmo+1JaSG/hvdQkbpNX2T3Qe//mdb
 EDT4AEvA7lT9Jy/JM=
X-Received: by 2002:a05:6a00:1787:b0:847:7f38:27c2 with SMTP id
 d2e1a72fcca58-847c516d6demr1852632b3a.50.1782927671425; 
 Wed, 01 Jul 2026 10:41:11 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb6dc4d0sm150943b3a.3.2026.07.01.10.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:41:11 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH v2 1/5] drm/nova: use `zerocopy` in firmware.rs
Date: Wed,  1 Jul 2026 14:40:52 -0300
Message-Id: <20260701174056.12604-2-niyudi.honda@gmail.com>
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

