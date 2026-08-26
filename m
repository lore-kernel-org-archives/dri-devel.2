Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C57C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0310210ED75;
	Wed, 26 Aug 2026 16:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="qUewXsvj";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01C5810ED75
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:39:29 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49b0dd3c9a0so589525e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762367; x=1788367167;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aHwEIe3ApZAukwk8cJYOHMlUqzV23ND3olo6PKKeC74=;
 b=qUewXsvj+jWMTpY6JNsFTZyzdDS2FNx1/qnWsMJTeETnMqA9KBqQPU0xlVcEHZFAxe
 ns1YbbDwPApjvd0TC8gmXSTpa8OcxZ43lbHCn2sAUUQs2q+e+kQ++E/dMR8jia3TC0mY
 YbTMbog0jl7XUS3VBTA5BK0C+rqRZ6pqyOjfRF091fVFdtQzcfZO+e9z9Eh0bswSNaK/
 nbBH/ip0kTA56b8hqllBzstm56NP5vT3s7o9OOVgpBLCUYW9aToB/B5qa5utX6rsA3sz
 mukOJxsJfUzJ1pco3JcLERwjWcj7ZkIANzNP0bxe8L0L+/0KvCeajZ8oHiUdP7eOSaQD
 Pe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762367; x=1788367167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aHwEIe3ApZAukwk8cJYOHMlUqzV23ND3olo6PKKeC74=;
 b=Q+ZxCbU77RoeHxO7a7U1R7SF7ZmsWIzP9Bwx87mcwtxvakT9Ru7lU6ZLxk6ZGEbHxA
 i8aNKxAbCjIYPhZUO7qu9DHbZ1CzW5pngzryXift4Bbry5x1XwocUegJj4GlsDFjsTGo
 LDPX0NDKO2rnWCwzywfvumIWVgPm5UmbLCBV3QpwPP/A+yD+0NP1VhT+hXgpjEr5/vK1
 /xa4GkEc9xVAygNSDf/XCLjEACsKNIMdxOR9Rq5Ea088ExfLsaGMmObA5Gn+gbZiLgaT
 wgU9pjNft5OnmJy5OPULjaj2AplVJkPMmUOqPazZAjBYsKwSjJA6xrgqswukneycMBpR
 zn9g==
X-Gm-Message-State: AFuF++n4z698OZAUBdeBS+FoZ6kaERoOKEOXcFVvI2eSduksMu1vEf+r
 E+j4cdy9qnNHiIeXR1fEJvfIm+Uo0/EZqzuF9HuELGnCbZzI8XkUfsLqmay9QJN+wH6ty46N5Cg
 obmVGttMq
X-Gm-Gg: AR+sD13SWXh/lNKvUDZ5iHin+yjBaGH5lZ6CqdEaLkhSILXRvk9jIW7Ic+lQuaaLELg
 fK3Dx8HVwu1mQSmhF3wl92IA0iYf5bcYWgjcIfcb3HF982N5R8k7PocKPiz9MMEQF5U0KywWRvH
 AgApyI3wdr+gyQooT9cShXP0cfGnGwrE9lmM1y3K7Ea5tADj45ZlKoONtaKM9j025b1HsOqjpym
 TWawvvOV6ca890CF3ptdzZKQUTezOIhc9qOYHCfV9UVGpnaEn13gBfau0AWHE/shJFRHk2IBocf
 4jH63gKrDCs7S5GtHX3lrQpovVYQABjhm3JteAjtII6XUMLN1JlAacsNJRIzUs/PiQFdDFvlGHf
 EzebPYYoGLPvzYM+5LQBsy5KDB3xbeva/+8tMe9PFWE0Ueiq0ctC/OeQ60UnNEMfvWx108QDPws
 7+zDkLg8Ofz2P/UJjlkutXGFt99ilwBZvtYSwNNWpqCyXbwY0r+d/Xrd4R5A+ck9sC6fyD1c7+G
 +LX1wEWJ5DlYmGfhlAYLNoblFUAKouy35nP
X-Received: by 2002:a05:600c:4505:b0:499:593b:a15b with SMTP id
 5b1f17b1804b1-499dc6e9935mr70406525e9.1.1787762367315; 
 Wed, 26 Aug 2026 09:39:27 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5721a0sm21769715e9.4.2026.08.26.09.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:39:25 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/13] drm/vino: add the USB transport
Date: Wed, 26 Aug 2026 17:37:27 +0100
Message-ID: <20260826163913.7052-3-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826163913.7052-1-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
MIME-Version: 1.0
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

The dock exposes control on a bulk pipe pair, video on one or two further
bulk endpoints, and an interrupt endpoint the dock pushes on. A dock
generation differs in how many of those it has and in whether video shares
the control pipe, so the transport takes the endpoint numbers as data
rather than deciding them.

Add the link: a bound-interface wrapper that opens those pipes, submits
video as a queue of pipelined URBs, and reports a stall as a stall rather
than retrying into a wedged dock.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 drivers/gpu/drm/vino/usb_link.rs | 250 +++++++++++++++++++++++++++++++
 1 file changed, 250 insertions(+)
 create mode 100644 drivers/gpu/drm/vino/usb_link.rs

diff --git a/drivers/gpu/drm/vino/usb_link.rs b/drivers/gpu/drm/vino/usb_link.rs
new file mode 100644
index 000000000000..04b9131d05ed
--- /dev/null
+++ b/drivers/gpu/drm/vino/usb_link.rs
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! The dock's USB endpoints, and the I/O handle every transfer goes through.
+//!
+//! [`Endpoints`] is resolved once against interface 0's descriptor and direction/type-checked, so
+//! the rest of the driver names an endpoint by what it is rather than by a bare address. A
+//! [`UsbLink`] can only exist while the device's [`usb::IoWindow`] is open, so a transfer cannot
+//! outlive the binding.
+
+use super::*;
+
+/// The dock's endpoints, resolved once against interface 0's descriptor and validated for
+/// direction and transfer type by [`usb::Interface::endpoint`].
+///
+/// Resolving up front means the rest of the driver names an endpoint by what it *is* rather than
+/// by a bare address, so a bulk-OUT transfer cannot be aimed at the interrupt-IN status endpoint.
+/// The whole set is [`Copy`] (each entry is an address plus a max-packet size), so it can be
+/// carried by value in a [`UsbLink`] rather than borrowed.
+#[derive(Clone, Copy)]
+pub(crate) struct Endpoints {
+    /// EP02: host->dock control-plane bulk writes.
+    pub(crate) ctrl_out: usb::Endpoint<usb::BulkOut>,
+    /// EP84: dock->host control-plane bulk replies.
+    pub(crate) ctrl_in: usb::Endpoint<usb::BulkIn>,
+    /// Per-connector video bulk-OUT endpoints, from [`DockProfile::video_endpoints`].
+    pub(crate) video: [usb::Endpoint<usb::BulkOut>; drm_sink::MAX_CONNECTORS],
+}
+
+impl Endpoints {
+    /// Resolves every endpoint the driver uses against `intf`'s active alternate setting, and
+    /// returns how many connectors the device actually backs.
+    ///
+    /// The control endpoints and the first video endpoint are required. The rest are not: a dock
+    /// in a known family with fewer outputs simply does not expose the later ones, and the count
+    /// that does resolve is the connector count. Taking it from the device is the difference
+    /// between supporting such a dock and refusing to bind to it, because a profile can only
+    /// describe the variants someone has tested. Navarro repeats addresses across connectors
+    /// (0/2 share `0x08`, 1/3 share `0x0a`), so this counts entries rather than distinct
+    /// endpoints, and the profile's own count remains the upper bound -- four resolvable entries
+    /// on a two-connector Ridge dock still means two connectors.
+    pub(crate) fn resolve<Ctx: device::DeviceContext>(
+        intf: &usb::Interface<Ctx>,
+        profile: &DockProfile,
+    ) -> Result<(Self, u8)> {
+        let mut video = [intf.endpoint::<usb::BulkOut>(profile.topology.video_endpoints[0])?;
+            drm_sink::MAX_CONNECTORS];
+        let mut connectors = 1u8;
+        for (slot, addr) in video
+            .iter_mut()
+            .zip(profile.topology.video_endpoints)
+            .skip(1)
+        {
+            let Ok(ep) = intf.endpoint::<usb::BulkOut>(addr) else {
+                break;
+            };
+            *slot = ep;
+            connectors += 1;
+        }
+
+        Ok((
+            Self {
+                ctrl_out: intf.endpoint::<usb::BulkOut>(EP_CTRL_OUT)?,
+                ctrl_in: intf.endpoint::<usb::BulkIn>(EP_CTRL_IN)?,
+                video,
+            },
+            connectors.min(profile.topology.connectors),
+        ))
+    }
+}
+
+/// A live USB transfer handle: an [`usb::Io`] token proving I/O is currently permitted, plus the
+/// resolved [`Endpoints`].
+///
+/// Obtaining one requires the device's [`usb::IoWindow`] to still be open, so a transfer cannot be
+/// issued after `disconnect()` has closed it. Carrying the endpoints in the handle also keeps raw
+/// endpoint addresses out of transfer call sites.
+pub(crate) struct UsbLink<'a> {
+    window: &'a Arc<usb::IoWindow>,
+    io: usb::Io<'a>,
+    pub(crate) endpoints: Endpoints,
+}
+
+impl<'a> UsbLink<'a> {
+    /// Opens a link on `window`, failing with `ENODEV` once the window has been closed.
+    pub(crate) fn open(window: &'a Arc<usb::IoWindow>, endpoints: Endpoints) -> Result<Self> {
+        Ok(Self {
+            io: window.enter()?,
+            window,
+            endpoints,
+        })
+    }
+
+    /// Opens the persistent EP84 control-plane reader.
+    pub(crate) fn ctrl_in_queue(&self, depth: usize, buf_len: usize) -> Result<usb::BulkInQueue> {
+        usb::BulkInQueue::new(
+            self.window,
+            &self.io,
+            &self.endpoints.ctrl_in,
+            depth,
+            buf_len,
+        )
+    }
+
+    /// Opens the pipelined EP02 control-plane writer.
+    pub(crate) fn ctrl_out_queue(&self, depth: usize, buf_len: usize) -> Result<usb::BulkOutQueue> {
+        usb::BulkOutQueue::new(
+            self.window,
+            &self.io,
+            &self.endpoints.ctrl_out,
+            depth,
+            buf_len,
+        )
+    }
+
+    /// Returns the canonical queue slot for `connector`'s physical video endpoint.
+    ///
+    /// A dock profile may repeat an endpoint address for multiple physical connectors (Navarro
+    /// uses EP08 for connectors 0/2 and EP0a for 1/3).  Those connectors must share one
+    /// persistent queue: separate queues could submit interleaved URBs to the same pipe.
+    pub(crate) fn video_pipe_index(&self, connector: usize) -> Result<usize> {
+        let endpoint = self.endpoints.video.get(connector).ok_or(EINVAL)?;
+        self.endpoints
+            .video
+            .iter()
+            .position(|candidate| candidate.address() == endpoint.address())
+            .ok_or(EINVAL)
+    }
+
+    /// Opens the pipelined video writer for `connector`'s physical video endpoint.
+    pub(crate) fn video_queue(
+        &self,
+        connector: usize,
+        depth: usize,
+        buf_len: usize,
+    ) -> Result<usb::BulkOutQueue> {
+        let ep = self.endpoints.video.get(connector).ok_or(EINVAL)?;
+        usb::BulkOutQueue::new(self.window, &self.io, ep, depth, buf_len)
+    }
+
+    /// The underlying I/O token, for the paths that open a persistent queue.
+    pub(crate) fn io(&self) -> &usb::Io<'a> {
+        &self.io
+    }
+
+    /// Writes a control-plane message to EP02.
+    pub(crate) fn ctrl_send(&self, data: &[u8], timeout: Delta, gfp: Flags) -> Result<usize> {
+        self.io
+            .bulk_send(&self.endpoints.ctrl_out, data, timeout, gfp)
+    }
+
+    /// Reads a control-plane reply from EP84.
+    pub(crate) fn ctrl_recv(&self, data: &mut [u8], timeout: Delta, gfp: Flags) -> Result<usize> {
+        self.io
+            .bulk_recv(&self.endpoints.ctrl_in, data, timeout, gfp)
+    }
+
+    /// Reads the standard two-byte status word for a video endpoint.
+    ///
+    /// Bit zero is `ENDPOINT_HALT`.  This is deliberately read-only: it distinguishes a dock
+    /// which has stalled the pipe from one which is merely returning NRDY without perturbing the
+    /// endpoint's host or device sequence state.
+    pub(crate) fn video_endpoint_status(&self, connector: usize) -> Result<u16> {
+        let address = self.endpoints.video.get(connector).ok_or(EINVAL)?.address();
+        let mut status = [0u8; 2];
+        self.control_recv(
+            0x00, // USB_REQ_GET_STATUS
+            0x82, // device-to-host, standard, endpoint
+            0,
+            u16::from(address),
+            &mut status,
+            timeout(),
+            GFP_KERNEL,
+        )?;
+        Ok(u16::from_le_bytes(status))
+    }
+
+    /// Sends the standard endpoint-halt clear without running Linux's host endpoint reset helper.
+    ///
+    /// Navarro uses this only during cold setup, before any video URB has touched the endpoint, so
+    /// the host sequence state is already its enumeration value. The working DLM wire transaction
+    /// is two raw `CLEAR_FEATURE(ENDPOINT_HALT)` requests 12.647 ms apart followed by its vendor
+    /// commit 143 us later. `usb_clear_halt()` adds an xHCI endpoint reset after the request; that
+    /// made each Vino operation return about 18 ms late and changed this transaction's ordering.
+    pub(crate) fn clear_video_halt_wire(&self, connector: usize) -> Result {
+        let address = self.endpoints.video.get(connector).ok_or(EINVAL)?.address();
+        self.control_send(
+            0x01, // USB_REQ_CLEAR_FEATURE
+            0x02, // host-to-device, standard, endpoint
+            0,    // USB_ENDPOINT_HALT
+            u16::from(address),
+            &[],
+            timeout(),
+            GFP_KERNEL,
+        )
+    }
+
+    /// Recover a video endpoint the dock has stalled.
+    ///
+    /// Unlike [`Self::clear_video_halt_wire`], this runs the full `usb_clear_halt()`, which resets
+    /// the host side's data toggle as well as sending `CLEAR_FEATURE`. That reset is exactly what
+    /// a real stall needs and what the cold-setup path deliberately avoids: after a stall the host
+    /// and device sequence state have diverged, and sending the bare request leaves every later
+    /// transfer failing.
+    ///
+    /// Nothing else clears a stalled pipe, so without this one stall is permanent -- and on a dock
+    /// whose video shares the control endpoint it takes the control plane down with it.
+    pub(crate) fn clear_video_halt(&self, connector: usize) -> Result {
+        let ep = self.endpoints.video.get(connector).ok_or(EINVAL)?;
+        self.io.clear_halt(ep)
+    }
+
+    /// Issues a control OUT transfer on EP0.
+    pub(crate) fn control_send(
+        &self,
+        request: u8,
+        request_type: u8,
+        value: u16,
+        index: u16,
+        data: &[u8],
+        timeout: Delta,
+        gfp: Flags,
+    ) -> Result {
+        self.io
+            .control_send(request, request_type, value, index, data, timeout, gfp)
+    }
+
+    /// Issues a control IN transfer on EP0.
+    pub(crate) fn control_recv(
+        &self,
+        request: u8,
+        request_type: u8,
+        value: u16,
+        index: u16,
+        data: &mut [u8],
+        timeout: Delta,
+        gfp: Flags,
+    ) -> Result {
+        self.io
+            .control_recv(request, request_type, value, index, data, timeout, gfp)
+    }
+
+    /// Selects an alternate setting on the driver's own interface.
+    pub(crate) fn set_alternate_setting(&self, alternate: u8) -> Result {
+        self.io.set_alternate_setting(alternate)
+    }
+}
+/// EP84 (dock-to-host) transfer size.
+///
+/// Replies larger than one transfer are delivered as consecutive fragments.
+pub(crate) const EP84_BUF: usize = 4096;
