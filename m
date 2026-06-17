Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDDECD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:03:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB75E10EA4B;
	Wed, 17 Jun 2026 15:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="c6KGoKl9";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8300610EA4B
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:03:15 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-68bd9fce347so10457464a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781708594; x=1782313394;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RPM0l7cGbbSYD6UImT0eFYRpGfGHF1+7B3QhvofMf/o=;
 b=c6KGoKl9zQK7cH5C7IYoYRW8nptwxgfF1LL/OAxlSYe2qMqaRRUYOPIZlHJ26CilcU
 7YHda9Ea8TvheucWoP7+pjHdjs93yod5wB1Ni9yzHpWOx+myBotH9jzhuE5Gu4o8f6WM
 X1KoUqR2YMNGIfcoHilD4JfGqGb3PqYxvTeCfQMMFRCvfx2/MSaurvxPFprsfGdGq/0d
 I/xf735QmO2pU+HH6xQ4tH46J/BSX6bqaIb/UY1XtK7xh1CeLNGinG61BGa/Qyo3YIBh
 zurS7n3VR6SjeOpPz0eDeHXu+Ui1YrvTAWv4pAmJToM6Xl9IQOZBLwF9uygkTqjoYakF
 LpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708594; x=1782313394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPM0l7cGbbSYD6UImT0eFYRpGfGHF1+7B3QhvofMf/o=;
 b=C8jcCXxgTgDzX7vf9uAjK7tJlPrBpbgywp2Dn+y+94ymtDUcV5QCZ1mrJaDZE4Jq1D
 D6vH63WPV7g7r4Ah5MynA0Zql2ktzYJHSCCouVTZ+ZrkR0MqhL2K2L26iAOxIWRIZexg
 6nWo+VjYaZeRadHUib6HJGm9Jt+/xBLjXBZc6kXUqN1Gi7Kx9uYQc3g6HMW2gf28k33Y
 3Rhdes8x4onibaivSb9XbvdJdIEcrjJASC8UArZCBPM3972AGUiku8+6ni5py3lAu7YS
 mHV6JjwglH/j226Rga/uKqr9iQjnT3UJ6sHzwUAl5meI2VuIxImE+ikljjFx9VXOHlaY
 wXJw==
X-Gm-Message-State: AOJu0Yzg6iqxudxRdMOngP2dL6lBDPJfaEW0DO8o20M78T2ha7YQ2Rze
 VpGUx+LRKcj7WtYmExOVhqS9GOTma5xxog/mrPMI+fr++GMRdm9CxL6IYrIpWihqqT/VeRYjYWy
 z56Xeu+Ny
X-Gm-Gg: Acq92OFWldp9tmwxIJO8I/WPHuSPdEfo56tKVNnNElA9y/yjhY3Go7RcbhLTrt0R/k1
 a2HXkvOSHZAXMKbFQ8+dE2ONzn+71aoGCwIRE5G36wfS1L5QymQuSf01uYArlJ4BqoPidfc33nf
 9MxIxUiKzTbvGFlJ3tu0vpUmlJRqNR8EGbBkM/7U9rdWbzTEJSrxSYC9YNS+yE0LPxGI7A2B906
 A+BkBm8CZEjBnFsGqIwXLDn32crNmQU9l1IbktgQHYz4Nr4Z1oHCElFoR4JEHhpjFFjKlsJXl81
 Vo5bY+Vs1eelD9Rej9jG/+pq8BoAjcikDQu1Bwg4AP6Abkii3Ie3+6fPjEvlRXUkhk2DmDlsAX6
 Q15WkUI0VRLf1ts/7roO/nets2OSSkoYdOF6hjSa+lmx/i2VRBkOlMfo8i/H6UZnd0D0gSpx7kw
 GVI3J9dxfm7zmPgeHQ99l5sHUFLBm1DKOIhE/hF0/04CfwiaaPmvlGh6FO
X-Received: by 2002:a17:906:8464:b0:c03:ff6c:5cf1 with SMTP id
 a640c23a62f3a-c05a4c03ee8mr167079666b.10.1781708593864; 
 Wed, 17 Jun 2026 08:03:13 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-462236047c8sm10065491f8f.10.2026.06.17.08.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:03:13 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: drm: unplug the device on Registration drop
Date: Wed, 17 Jun 2026 16:02:58 +0100
Message-ID: <20260617150303.2259-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.54.0
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

`Registration::drop` called `drm_dev_unregister()`, which is only safe
when no userspace clients still hold the device open. For a DRM device on
a hot-removable bus (e.g. a USB dock) the device can disappear while a
compositor holds its `card`/`render` node, and tearing it down with
`drm_dev_unregister()` leaves that fd pointing at freed device state — a
use-after-free on the next ioctl/mmap.

Use `drm_dev_unplug()` instead: the hot-unplug-safe superset. It sets
`dev->unplugged` (so the DRM ioctl/mmap paths return -ENODEV to held
fds), drains in-flight `drm_dev_enter`/`drm_dev_exit` critical sections
via SRCU, unregisters the minors, and unmaps userspace mappings. For a
permanent device it behaves like `drm_dev_unregister()` plus the harmless
unplugged flag at the very end of its life, so it is safe unconditionally.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/kernel/drm/driver.rs | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 25f7e233884d..aa86ba136b03 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -135,7 +135,15 @@ pub trait Driver {
 
 /// The registration type of a `drm::Device`.
 ///
-/// Once the `Registration` structure is dropped, the device is unregistered.
+/// Once the `Registration` structure is dropped, the device is unplugged (which also
+/// unregisters it). [`drm_dev_unplug`] is the hot-unplug-safe teardown: it sets the device's
+/// `unplugged` flag (so the DRM ioctl/mmap paths return `-ENODEV` to any process still holding
+/// an open `card`/`render` node, rather than dereferencing freed device state), drains
+/// in-flight `drm_dev_enter`/`drm_dev_exit` critical sections, unregisters the minors, and tears
+/// down userspace mappings. For devices on a removable bus (e.g. a USB dock) this is required
+/// for safe removal; for permanent devices it is a harmless superset of `drm_dev_unregister`.
+///
+/// [`drm_dev_unplug`]: https://docs.kernel.org/gpu/drm-internals.html
 pub struct Registration<T: Driver>(ARef<drm::Device<T>>);
 
 impl<T: Driver> Registration<T> {
@@ -197,7 +205,9 @@ unsafe impl<T: Driver> Send for Registration<T> {}
 impl<T: Driver> Drop for Registration<T> {
     fn drop(&mut self) {
         // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The existence of this
-        // `Registration` also guarantees the this `drm::Device` is actually registered.
-        unsafe { bindings::drm_dev_unregister(self.0.as_raw()) };
+        // `Registration` also guarantees that this `drm::Device` is actually registered.
+        // `drm_dev_unplug` is the hot-unplug-safe teardown (it calls `drm_dev_unregister`
+        // internally after marking the device unplugged) — see the type's documentation.
+        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };
     }
 }
-- 
2.54.0

