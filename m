Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E740CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 00:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB10210E25E;
	Thu, 11 Jun 2026 00:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="OoM5B34g";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B9FE10E25E
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781136110; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mTuGGxo3OhrSlrHy63qltSNjAbKwXA8RG7ZKPdsvHXPcR9aD1PX8sWyVkccIkFtlapnL1aDUIkn2cIn7dQZB9KWxau66V4frwv3PfycWnjCKf0KtgOh9dQfy8binzTPccMrouKBTVPYcpZOs218BSwhJ4R0vTWkynLKNBFlqWhE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781136110;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tzMSj5cjQidpv0zF/Q4oyjbLi4Xorc8wR2gOqNma8Y4=; 
 b=js4wRfaXAwFNDOj0fFOR54WvYescTCCSuoPsNYXPhouuwh78G3qEKinSRTxNpdZ5HGfZbnUgu2xvPfMQ/sMimRmi9svQFqDs1qKwkeG9vl8TV4F7I0zSUqfMz5lrZzqkhrTDCRHSQyVS1wOkqplg3/fISesuhM6F3fSTIW8c+J4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781136110; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=tzMSj5cjQidpv0zF/Q4oyjbLi4Xorc8wR2gOqNma8Y4=;
 b=OoM5B34gmoQ1TU7Ynj+HhoyKHvOVco6LC/Pn1AtQYBYzIIgBHEG7hg+9CI0yfcNf
 ObDwJHdfc0FNS8dAJgGQd78gnBbqlpuykcPlCQaHnj0qTB60ACEoIwH9NJKvYYoQHgs
 f9R+0XB7WyizOmPI3egCsvV8DTw7stvREeCmzmi4=
Received: by mx.zohomail.com with SMTPS id 1781136109785375.24266434750245;
 Wed, 10 Jun 2026 17:01:49 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Wed, 10 Jun 2026 17:01:26 -0700
Subject: [PATCH] rust: drm: gpuvm: update DriverGpuVm for DeviceContext
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-gpuvm_device_context_v1-v1-1-01a890b17448@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QqEIBQFfyXuc4LXwmh/ZQlZ7FT3IQttJYj+P
 elxYGYuSoiCRJ/qoogsSbZQgOuK/PILM5SMhcloY7Vlreb9n1c3FtXD+S0cOA+XWTW284anvgW
 DSr1HTHK+5+9w3w9L4e2PaQAAAA==
X-Change-ID: 20260610-gpuvm_device_context_v1-367c21f94e1e
To: Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, samitolvanen@google.com, 
 laura.nao@collabora.com, boris.brezillon@collabora.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1997;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=2zo0nAJbApWHFzHVP/4Qn3FawEkCJQAy+zNNwPSiIsA=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFmav97Ue/BxR+mUsPmF+3HIxPA4X/dvPpQlEvxqxiY/W
 e49kzI6SlkYxLgYZMUUWc7aG/WIV7030p3/vxlmDisTyBAGLk4BmMj2Job/edvkL3bcNVJj+/a7
 pVImViSB7V5tvbZ28BP5b1FRzyvsGBk6sldZmbvqXXr0UnKv12nbPVeTfqacTNSatXTrVk3NWax
 8AA==
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

Since the introduction of DeviceContext, there is no longer a single
driver object type to equate with the GPUVM object type.

Instead of threading DeviceContext through GPUVM, remove the strict
identity between DriverGpuVm::Object and drm::Driver::Object and
instead tighten the requirement that the DriverGpuVm::Object be an
allocatable GEM object associated with the same DRM driver.

Also, make GpuVm::new() generic over DeviceContext so it can accept a
drm::Device<T::Driver, Ctx>.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/kernel/drm/gpuvm/mod.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index ae58f6f667c1..a625fcd9b5f2 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -116,9 +116,9 @@ const fn vtable() -> &'static bindings::drm_gpuvm_ops {
 
     /// Creates a GPUVM instance.
     #[expect(clippy::new_ret_no_self)]
-    pub fn new<E>(
+    pub fn new<E, Ctx: drm::DeviceContext>(
         name: &'static CStr,
-        dev: &drm::Device<T::Driver>,
+        dev: &drm::Device<T::Driver, Ctx>,
         r_obj: &T::Object,
         range: Range<u64>,
         reserve_range: Range<u64>,
@@ -252,10 +252,10 @@ fn raw_resv(&self) -> *mut bindings::dma_resv {
 /// The manager for a GPUVM.
 pub trait DriverGpuVm: Sized + Send {
     /// Parent `Driver` for this object.
-    type Driver: drm::Driver<Object = Self::Object>;
+    type Driver: drm::Driver;
 
     /// The kind of GEM object stored in this GPUVM.
-    type Object: IntoGEMObject;
+    type Object: drm::driver::AllocImpl<Driver = Self::Driver>;
 
     /// Data stored with each [`struct drm_gpuva`](struct@GpuVa).
     type VaData;

---
base-commit: 550dc7536644db2d67c6f8cf525bba682fba08d9
change-id: 20260610-gpuvm_device_context_v1-367c21f94e1e

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

