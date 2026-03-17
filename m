Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5FDFF6E82
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 21:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E3010E680;
	Tue, 17 Mar 2026 21:32:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="C/YHnEIg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C479710E680
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773783161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QouNEtmlaggCaQo2P5IO63zf/LsG/YgCtk54rapeiQI=;
 b=C/YHnEIgeTJscGNfVcAWbXVO7q90aVC97xQ3+Zl4Rq6LsryK8qLk38DWPcf4ph37VNX5QN
 ej+JH4EVuuGDyPByOcSKyxbF1Qd0tsVE2bk9AJOHQ5X2/i1uK6Gjp9/Jc+qa2zQfEuo1ZJ
 GLqsKbdt7aN1SYj69flQ926yljW9jgM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-3AwmOY-QP06Fu3U4XIjoXg-1; Tue,
 17 Mar 2026 17:32:39 -0400
X-MC-Unique: 3AwmOY-QP06Fu3U4XIjoXg-1
X-Mimecast-MFC-AGG-ID: 3AwmOY-QP06Fu3U4XIjoXg_1773783157
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD5F119560B5; Tue, 17 Mar 2026 21:32:36 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.64.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F8C41800576; Tue, 17 Mar 2026 21:32:34 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 nouveau@lists.freedesktop.org, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "Alice Ryhl" <aliceryhl@google.com>,
 "Shankari Anand" <shankari.ak0208@gmail.com>,
 "David Airlie" <airlied@gmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Asahi Lina" <lina+kernel@asahilina.net>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v5 3/4] rust/drm/gem: Add DriverAllocImpl type alias
Date: Tue, 17 Mar 2026 17:28:32 -0400
Message-ID: <20260317213003.606088-4-lyude@redhat.com>
In-Reply-To: <20260317213003.606088-1-lyude@redhat.com>
References: <20260317213003.606088-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: ur83gfPlNa8g2Ul1xx3H_pwXQ-uTpIpExcPJegpohBM_1773783157
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This is just a type alias that resolves into the AllocImpl for a given
  T: drm::gem::DriverObject

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/drm/gem/mod.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index b4199945db378..ad74c5159f725 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -33,6 +33,11 @@
 /// [`DriverFile`]: drm::file::DriverFile
 pub type DriverFile<T> = drm::File<<<T as DriverObject>::Driver as drm::Driver>::File>;
 
+/// A type alias for retrieving the current [`AllocImpl`] for a given [`DriverObject`].
+///
+/// [`Driver`]: drm::Driver
+pub type DriverAllocImpl<T> = <<T as DriverObject>::Driver as drm::Driver>::Object;
+
 /// GEM object functions, which must be implemented by drivers.
 pub trait DriverObject: Sync + Send + Sized {
     /// Parent `Driver` for this object.
@@ -42,12 +47,12 @@ pub trait DriverObject: Sync + Send + Sized {
     fn new(dev: &drm::Device<Self::Driver>, size: usize) -> impl PinInit<Self, Error>;
 
     /// Open a new handle to an existing object, associated with a File.
-    fn open(_obj: &<Self::Driver as drm::Driver>::Object, _file: &DriverFile<Self>) -> Result {
+    fn open(_obj: &DriverAllocImpl<Self>, _file: &DriverFile<Self>) -> Result {
         Ok(())
     }
 
     /// Close a handle to an existing object, associated with a File.
-    fn close(_obj: &<Self::Driver as drm::Driver>::Object, _file: &DriverFile<Self>) {}
+    fn close(_obj: &DriverAllocImpl<Self>, _file: &DriverFile<Self>) {}
 }
 
 /// Trait that represents a GEM object subtype
-- 
2.53.0

