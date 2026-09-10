Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A48C79FBB
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA40110F0E8;
	Thu, 10 Sep 2026 23:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="D5FUsM20";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D233C10F0E8
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 23:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789081320; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Vct1JUYy56GduX2B1Kf34yaSQbpxCJclzCyeoETz/PKJ/Ai+wgzNvTe+nbzUIZhJUWaRiPQWus5giBOHj+juyBxzLwEO2J5RYqRAZ5DGxtfrR3ngb7RD4NY0p/qW6mZf5IWOhpJWJgSdNTJliWOSYCwgpxftzWJXMC7BjBiqBWE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789081320;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YPcNiTNd+EFqHZBOKeezkN1gDau+W9MRCDQDDa3NZpM=; 
 b=NZDDrs924TpWiX428fioqCGIRkD9dKyLfbwsI8fxAoxv90PlMhzMDIi04JCx+7yfwsHti46SmQVXCH36xJn9v6Swi9vhNykxHTXD2NjZ/fL5Xv6BDxwiIIBXz2l7CXNA1Vuog02v+eNSu8BEWbeQlMdy8/s9r/q7bBNG7IfayJU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789081320; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=YPcNiTNd+EFqHZBOKeezkN1gDau+W9MRCDQDDa3NZpM=;
 b=D5FUsM200wVutwLdYXdllYKdOkVp0LvgDVJtIHg8qxI6KW7KD/jexLhrtBum55Pz
 gu+F3TyjwpPN+yoWjdufMZlJHJ/lw6ygjzWUqglCxinLeJE9NpMNO3Cp/4qetq1eUQD
 Ahxar1QWroU+r9q8U3f+nO35lR8tw7KQOqAzbZGM=
Received: by mx.zohomail.com with SMTPS id 1789081319983511.92469138538536;
 Thu, 10 Sep 2026 16:01:59 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 10 Sep 2026 16:01:36 -0700
Subject: [PATCH] drm/tyr: reduce size of doorbell array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-b4-doorbell-v1-1-f3ca2f501600@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBN0EMGuEi20xhoQDYUIwrsnL
 d/i/xcaVaYGs3ih0s2NSx7Qk4Dt9PkgyfswoEKrnFYyGLmXUgOlJBGNszZ65dHBKK5KkZ//tqy
 9f5QsxNRdAAAA
X-Change-ID: 20260910-b4-doorbell-224966fa0a29
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, gary@garyguo.net, 
 boris.brezillon@collabora.com, laura.nao@collabora.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=EysiNMAymz+CEI4gdX9gD9dZg1YUoVzI7UUvFIg8T1A=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFmLze6GpCndzdO5o9N06p/WRmH9HWYq70JXdik/PPah5
 lzbrL8hHaUsDGJcDLJiiixn7Y16xKveG+nO/98MM4eVCWQIAxenAEzksDLDP434b2qp5dsC5l5J
 9zc03lPLZPP7xyH3ikWsL53Wz8tr02T4w/1iZbn8rpS7U15ntITduViS/kGX40nJTlGT8uzH4bO
 PsgMA
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

Currently the number of doorbells is set to 64 which is an architectural
maximum for the Mali GPU major v10 supported by Tyr. Since each doorbell
needs a 64 KiB page, the doorbell array alone would need 4 MiB of register
memory. Since the doorbell array starts at offset 0x80000, its exclusive
end would be 0x480000, but the rk3588 device that Tyr is compatible with
only provides a 2 MiB iomem region in total.

Reduce the number of doorbells so that they fit into the rk3588 iomem
region. This is consistent with Panthor’s doorbell id assignment.
Doorbell 0 is the global doorbell. Panthor assigns the remaining doorbells
to the active command stream group (CSG) slots. The number of slots is
capped at 16 (MAX_CSG_PRIO + 1). Therefore Panthor uses a maximum of 17
doorbells. The 17 doorbell pages span 0x110000 bytes. Since the doorbell
array starts at offset 0x80000 its exclusive end is 0x190000 and so fits
within the 2 MiB register region.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/regs.rs | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 0c419c4e1186..68701c39aee2 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -1802,7 +1802,10 @@ pub(crate) mod doorbell_block {
     use crate::driver::TyrRegisters;
 
     /// Number of doorbells available.
-    pub(crate) const NUM_DOORBELLS: usize = 64;
+    /// The architectural maximum is 64 but this full array does not
+    /// fit in the 2 MiB iomem region. Panthor currently uses a maximum of
+    /// 17 doorbells so do the same here.
+    pub(crate) const NUM_DOORBELLS: usize = 17;
 
     /// Doorbell block stride (64KiB).
     ///

---
base-commit: 73e5616f3d197c1af5a04a481fe0f13aa3913bd1
change-id: 20260910-b4-doorbell-224966fa0a29

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

