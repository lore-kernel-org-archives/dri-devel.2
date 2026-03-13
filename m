Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D203105F783
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 09:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D058310EB56;
	Fri, 13 Mar 2026 09:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="cPa6NVKt";
	dkim-atps=neutral
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net
 [178.154.239.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5487710E0DA
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 09:17:53 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:571a:0:640:23e3:0])
 by forward100a.mail.yandex.net (Yandex) with ESMTPS id 6AD42C01F9;
 Fri, 13 Mar 2026 12:17:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id 3HEusrTGkmI0-oTA9aIN3; 
 Fri, 13 Mar 2026 12:17:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=mail; t=1773393470;
 bh=296Sx8eOcmyen+kU5beNbjuR6rH7VCIG+e4tSjMIXSc=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=cPa6NVKt8iG3PHz9TchJYe5y1/ot+M2RswBlrdx3pkecqLo52GUn6vMSBfRaCZySv
 QTcpW0qyH4BvsRmVCynJhslr1lX03YTJZwca6Mbo6CxpSG4PUpeq0Cs8fZEcIeaWoa
 NbFMDBftw67jzg3FVB44fJSQKT1Gq1jkcwL/Xt1U=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net;
 dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v1 RESEND 2/4] rust: add Work::disable_sync
Date: Fri, 13 Mar 2026 12:16:42 +0300
Message-ID: <20260313091646.16938-3-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260313091646.16938-1-work@onurozkan.dev>
References: <20260313091646.16938-1-work@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add Work::disable_sync() as a safe wrapper for disable_work_sync().

Drivers can use this during teardown to stop new queueing and wait for
queued or running work to finish before dropping related resources.

Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/workqueue.rs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 706e833e9702..6acc7b5ba31c 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -530,6 +530,21 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
         // the compiler does not complain that the `work` field is unused.
         unsafe { Opaque::cast_into(core::ptr::addr_of!((*ptr).work)) }
     }
+
+    /// Disables this work item and waits for queued/running executions to finish.
+    ///
+    /// # Safety
+    ///
+    /// Must be called from a sleepable context if the work was last queued on a non-BH
+    /// workqueue.
+    #[inline]
+    pub unsafe fn disable_sync(&self) {
+        let ptr: *const Self = self;
+        // SAFETY: `self` points to a valid initialized work.
+        let raw_work = unsafe { Self::raw_get(ptr) };
+        // SAFETY: `raw_work` is a valid embedded `work_struct`.
+        unsafe { bindings::disable_work_sync(raw_work) };
+    }
 }
 
 /// Declares that a type contains a [`Work<T, ID>`].
-- 
2.51.2

