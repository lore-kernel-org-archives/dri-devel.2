Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711ADC61DC4
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91DA10ED88;
	Wed, 26 Aug 2026 16:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="rbnT1239";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B072310ED88
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:41:29 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso9451055e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762488; x=1788367288;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4V2qWTIy9upPrwYp43xXrz2kFXEg2TQMUb90MextArg=;
 b=rbnT1239aPelut0Lgi2eqekERpUfPHXw5Uf6JM6ui1zpc99EqYZ0gGqikeZLyNlxfh
 ETxa1JBo2CPuZwfaaOfS4r6XefjlXuOVsDXpBoW1Iaehwtv5/aho3+JFdXF56EsjcKnf
 ABQJo8Oex5HfYENQadrbZ5lP6Ab5ESsTlSxlcj8jBL3HWCsmXbxwBy1Rn+jDY48QVrdq
 +pZW7GRGHnW4HDOpbEB5KYcNpVy8RxZrTM3lg0j1GsgQEIzWDuhqnjBnt0JPWGTO6fUk
 AdARmyIsJn+HyzCJN5gTtC4iI8bTE/yQ96VpARX91ERUQ3LgcE3Bc9epLK/q3e5/x/wi
 +PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762488; x=1788367288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4V2qWTIy9upPrwYp43xXrz2kFXEg2TQMUb90MextArg=;
 b=IIjPJyv5n+ArtOGMMpmy5rxnbZzhDBY50aPjZRQL7Ua9IvTqRzJFNhTW+EEMjGZmH/
 Xky7gJHj4pRb8ejcYUQpxEi+hjiDanlR3EkSP1sTi6Ce9XLabmPyRiP2cRMfSKEYsyum
 n1G3SaaELYdAT04KgiUVh3TgQsSBTkC+L8ev/yyQlPjF/AFFC4EcQZ9wDek8a9KiLp4X
 lhbeARzsJVNCb2tmSiev7IDQ42FF1db9bs2b159rSitlT3XytXstORebK7UfXw0X/YKd
 Ngl+HDMGNM48A0A6v0L4UVaIPZSUyAbN+fPZcl8jzNacNMvVIp8NKRJ46cua+rxvlV1P
 3whg==
X-Gm-Message-State: AFuF++l0DbQHx44NemEhnxFff0QCrLCCfvEdXwGQXgGTw0ZSJqVUA7fU
 sCXWm6TNFRTNEYUE8xUjyMaDVzdsm0sJXo+TqHH3Y5p8f4etfAkiGaaMPYe2az+zDBtp8UVmZDj
 xLlrdr4lZ
X-Gm-Gg: AR+sD12dFFUUbBrjYRtglQ917HeE9Hj0FCd1J1K5tljzFYXHfAFoSFvcKxWb/iw9rbk
 jwYBMeKCjappKuwlKSqoJDddDvQ9+4vJdBO1ArHcTvkuC9Hw6CeqfSTT8lG7GsRP9LZOeS/dW45
 ul53eJB2o83aCgLFiKMQNeL4PMI3Z5ZGVx/jORF4t80q0u39pl9nVQ10FSXJKku5yQJsLnO/hrd
 KrRY7diD5iX469HeTVTT5EgCQjpmz1yLGSC3uI8kifW1SL4Bb0AAFh11d41+7YT4J5QybYl9tvG
 4/TsYIAeQo/htsqMb41lFjm8Sn/1bCa/ts2XeIS6D2LTSM3/jOar3iVyBfD0tAUnqdEgRMr51GM
 dtVDmlRw8hQsfiCZ1imuu7GgxyH9AyyIjHAhbVp3C+044KP0PfBx5TyKL8LjLmHp8U3WGmy+x78
 yhdLUSjcl9mdy/3U6nuYmGbgZt+3jJsfNljEjxqQazhuQrMiRji85FZ6LMoZ6EHbCJuSarYWiME
 LePdYEn0yfW7FIU0WPbRBUXtkzAShlMUEa25z5yXImCQDw=
X-Received: by 2002:a05:600c:34c3:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-499dc720bd2mr92288185e9.10.1787762487943; 
 Wed, 26 Aug 2026 09:41:27 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5721a0sm21769715e9.4.2026.08.26.09.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:41:26 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v3 13/13] Documentation/gpu: document the Vino driver
Date: Wed, 26 Aug 2026 17:37:38 +0100
Message-ID: <20260826163913.7052-14-mike@fireburn.co.uk>
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

Describe how a dock is identified and placed by family rather than by
product ID, what the driver implements in-kernel in place of EVDI and
DisplayLinkManager, and the module parameters an unfamiliar dock or a
converter with broken DDC may need.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 Documentation/gpu/drivers.rst |   1 +
 Documentation/gpu/vino.rst    | 254 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                   |   1 +
 3 files changed, 256 insertions(+)
 create mode 100644 Documentation/gpu/vino.rst

diff --git a/Documentation/gpu/drivers.rst b/Documentation/gpu/drivers.rst
index 20d2c454aa1d..4b524d6980c4 100644
--- a/Documentation/gpu/drivers.rst
+++ b/Documentation/gpu/drivers.rst
@@ -17,6 +17,7 @@ GPU Driver Documentation
    tve200
    v3d
    vc4
+   vino
    vkms
    bridge/dw-hdmi
    xen-front
diff --git a/Documentation/gpu/vino.rst b/Documentation/gpu/vino.rst
new file mode 100644
index 000000000000..98e82297a82a
--- /dev/null
+++ b/Documentation/gpu/vino.rst
@@ -0,0 +1,254 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==========================
+Vino DisplayLink DL3 driver
+==========================
+
+Vino is a Rust DRM/KMS driver for DisplayLink DL3 USB display devices. Three
+hardware families are supported: Ella (DL-3x00 silicon, e.g. the HP 3005pr),
+Ridge (DL-6xxx silicon, e.g. the Dell Universal Dock D6000) and Navarro
+(DL-7000 silicon, e.g. the DL-7400 quad-display docks). Each family has a
+profile carrying the endpoints, strip geometry, connector count, link limits
+and pacing of its hardware; the rest of the driver reads those values rather
+than branching on the model.
+
+Device identification
+=====================
+
+The driver binds to a DisplayLink *function*, not to a list of product IDs: any
+device with vendor ``17e9`` exposing an interface of class ``0xff``, subclass
+``0``, protocol ``0x03`` (a DL3 display function; ``0x00`` is the older ``udl``
+hardware), plus that device's USB DFU interface. This matches what the vendor's
+own udev rules key on, and means a dock nobody has tested is offered to the
+driver rather than ignored.
+
+Which family a device belongs to is then read from the device itself. Every
+DisplayLink dock carries a sixteen-byte vendor descriptor, type ``0x40``, in
+its ordinary configuration descriptor, holding the running firmware version and
+an eight-character platform name -- ``NavaDock``, ``RidgeDoc`` and so on. It is
+read with a standard ``GET_DESCRIPTOR``, needing no session and no crypto, so
+identification happens at probe.
+
+A device whose identity names a family the driver cannot drive is declined by
+name, so its owner gets a log line and something worth reporting instead of a
+driver guessing at an unknown wire format. A device whose identity cannot be
+*read* falls back to a small product-ID quirk table, so a transient descriptor
+failure does not cost a known dock its displays.
+
+The number of connectors comes from how many of the family's video endpoints
+the device actually exposes, bounded by the profile. A dock in a known family
+with fewer outputs is therefore driven with the outputs it has.
+
+The driver owns the USB device and implements the dock's initialization,
+HDCP 2.2 authentication, encrypted control protocol, downstream monitor
+management, mode programming, cursor updates, video compression, and USB
+submission in the kernel. It does not use EVDI or a userspace display daemon.
+
+Configuration
+=============
+
+The driver is selected by ``CONFIG_DRM_VINO``. It requires Rust, USB, DRM,
+MMU support, the Rust DRM shmem helper, and the kernel crypto primitives used
+by HDCP 2.2.
+
+``CONFIG_DRM_VINO=m`` builds ``vino.ko``.
+
+Verbose protocol and scanout diagnostics are disabled by default. Pass
+``debug=1`` when loading the module to enable them::
+
+    modprobe vino debug=1
+
+Errors, connection changes, and session state remain visible without this
+parameter.
+
+The remaining module parameters are for recovery and diagnosis:
+
+``edid_override``
+  Bitmask of connectors whose EDID the dock cannot read -- typically a monitor
+  behind a DP-to-HDMI converter that mangles DDC -- and which are described by
+  DRM's own EDID override instead.
+
+``force_flash``
+  Write the packaged dock firmware even when the dock already runs that version
+  or newer. See `Firmware updates`_.
+
+``rtc_utc_offset_minutes``
+  Local offset from UTC, in minutes east, used when synchronizing a Navarro
+  dock's real-time clock.
+
+``trace_crypto``
+  Discloses the ephemeral control and video keys of one session so that a
+  ``usbmon`` capture can be decrypted. For protocol work only.
+
+The optional ``CONFIG_DRM_VINO_KUNIT_TEST`` setting builds the driver's KUnit
+suite. It is intended for development kernels and is disabled by default.
+
+KMS model
+=========
+
+A dock exposes independent display connectors: two on the D6000, four on the
+DL-7400, where they are multiplexed over two video endpoints. Each has:
+
+* one primary plane using ``DRM_FORMAT_XRGB8888``, and ``DRM_FORMAT_XRGB2101010``
+  as well where the dock's link carries ten bits per channel;
+* one cursor plane using ``DRM_FORMAT_ARGB8888``;
+* one CRTC, encoder, and connector;
+* a downstream EDID channel; and
+* a bulk-OUT video endpoint, which two connectors may share.
+
+Atomic commits record the latest desired state and wake an ordered,
+device-owned control queue. Blocking USB transactions are never issued from
+the atomic callback. A transient control failure retains the desired
+generation and retries it; a newer atomic state always supersedes an older
+retry.
+
+The primary plane supports the four DRM rotations and both reflection axes in
+all valid combinations. Rotated and reflected frames are conservatively sent
+as full updates. Their independent codec strips are still encoded in parallel;
+identity scanout additionally supports damage updates and encoded-strip reuse.
+
+Mode validation
+===============
+
+A mode reaches the dock as a timing plus two control words describing its sync
+polarity and its CTA video identification code. Those words are taken verbatim
+from decrypted vendor captures for the timings a capture covers -- 1920x1080 at
+60 and 120 Hz, and 2560x1440 CVT-RB at 60 and 120 Hz -- and derived from the
+mode's own sync flags and VIC otherwise, so a monitor's native timing is driven
+rather than approximated.
+
+A mode is refused when it exceeds the ceilings its dock's profile names: the
+highest pixel clock a single connector may carry, an optional refresh-rate cap
+where the vendor driver is known to clamp, and the dock-wide pixel budget. The
+budget is shared, so the atomic check enforces the combined rate of the
+connectors a commit leaves enabled, while mode validation refuses only a single
+mode too large for the whole dock.
+
+Framebuffer ownership and damage
+================================
+
+The dock cannot scan out a GEM object directly. Vino therefore copies changed
+strips from the shmem framebuffer into driver-owned snapshots before the
+atomic commit completes. The compositor may reuse its source buffer after
+that snapshot without racing the encoder.
+
+Each head retains at most four validated, owned shmem mappings, matching a
+typical compositor swapchain. Repeated flips reuse those prepared mappings;
+round-robin eviction and DPMS teardown keep pinned memory bounded. This is the
+USB-display equivalent of preparing buffers before submission and requires no
+driver-specific userspace API.
+
+Encoding and USB submission run asynchronously on per-head workers. Damage is
+tracked against the last frame successfully submitted to the dock, not merely
+against the previous atomic commit. This preserves changes when commits are
+coalesced or a transfer fails.
+
+A strip whose content changes is charged one transmission for each buffer the
+dock rotates through, plus one, and remains selected until that debt is paid.
+One presentation reaches exactly one of those buffers, so a strip delivered to
+only some of them would leave the panel alternating between old and new
+content. A surface with no change and no debt outstanding sends nothing.
+
+The video path keeps a bounded, persistent USB request ring. The first
+presentation after a mode change carries the decoder arm sequence and the
+opening frame in one USB request, as required by the receiver.
+
+Control and authentication
+==========================
+
+One per-device session owns the HDCP and encrypted-control counters, keys,
+nonces, EP02 submissions, and EP84 replies. The control queue serializes
+transactions so a KMS update cannot interleave with a heartbeat or monitor
+operation.
+
+Initial transport, authentication, and encrypted-control setup is retried after
+transient failures. Once authentication has succeeded, a timeout while
+discovering one downstream monitor does not discard the live session. That
+head remains disconnected until the bounded runtime re-engagement path
+obtains a valid EDID.
+
+HDCP message identifiers and HDMI mode matching use the DRM display helpers.
+AES, AES-CMAC, SHA-256, HMAC-SHA256, and RSA operations use kernel crypto
+interfaces. Session material is stored per device and is not exposed through
+a driver-specific userspace API.
+
+Colour management
+=================
+
+The CRTC advertises ``CTM`` and a 256-entry ``GAMMA_LUT``, and both are applied
+in software during encoding. A dock has no colour hardware to program, so a
+compositor correcting through those properties -- as GNOME's Night Light and
+KDE's Night Colour do -- would otherwise have nowhere to put the correction on
+this output while native outputs are corrected normally.
+
+Colour depth and HDR
+====================
+
+On a dock whose silicon carries ten bits per channel, each connector also
+advertises ``max bpc``, ``Colorspace`` and ``HDR_OUTPUT_METADATA``. The wire
+format is one codec parameterised by sample depth rather than two: an HDR
+frame differs from an SDR one only in how deep its samples are, in the escape
+ceilings the entropy coder is allowed to reach, and in the transfer function
+and colorimetry stated in the mode set.
+
+The link's depth is taken from ``max bpc`` together with the PQ transfer
+function the compositor attached, not from the committed framebuffer's format:
+driving a ten-bit link from an eight-bit surface is ordinary, and a sample is
+widened into the deeper link after it is decoded. A ten-bit connector costs the
+dock a third more bandwidth per pixel, so the shared budget is priced at the
+deepest connector in use, and where a pair of modes does not fit at ten bits
+the depth gives way rather than the mode -- a compositor handed ``EINVAL``
+disables the output instead of asking for a shallower link.
+
+Firmware updates
+================
+
+A dock reports the firmware it is running in a vendor descriptor, and the
+vendor's ``*-release.spkg`` packages state the version they carry. If the
+kernel firmware loader can supply a package that is newer than what the dock
+is running, vino writes it over USB DFU before opening a control session.
+
+Two deliberate paths exist alongside that. ``force_flash=1`` writes the
+packaged image even when the dock already runs that version or a newer one,
+which is how a dock left in a bad state is recovered. The
+``/sys/class/firmware/vino-<dock>/`` upload interface takes an image from
+userspace and writes whatever version it is, which is the only way to re-flash
+the running version or to go back to an older one. Both refuse an image that is
+not a DisplayLink package or is for another dock family: the DFU interface
+supports no upload, so the running image cannot be read back and there is
+nothing to restore from.
+
+Monitor handling
+================
+
+EDID reads are tunneled through the dock's encrypted control protocol. An
+unsolicited downstream event schedules a fresh presence probe. Removal,
+reattachment, and a connector powered down by userspace are tracked separately
+so a deliberate power transition is not reported as a physical unplug.
+
+The initial driver does not register a virtual I2C adapter for DDC/CI monitor
+controls.
+
+Disconnect
+==========
+
+USB I/O is guarded by a revocable I/O window. Disconnect closes that window
+before workers and request queues are drained, preventing new transfers from
+starting during teardown. The owned DRM registration, timers, work queues,
+frame snapshots, and USB queues are then released by their Rust owners.
+
+Testing and validation
+======================
+
+With ``CONFIG_DRM_VINO_KUNIT_TEST=y``, the protocol and codec have KUnit
+coverage for cryptographic known-answer tests, captured control-message
+vectors, mode profiles, decoder-arm framing, codec boundaries, damage
+selection, USB record construction, and serial-versus-parallel output for all
+rotation and reflection combinations.
+
+A focused compile check is::
+
+    make LLVM=1 rust/kernel.o drivers/gpu/drm/vino/vino.o
+
+External-module ``modpost`` also needs a completed kernel build with a
+matching ``Module.symvers``.
diff --git a/MAINTAINERS b/MAINTAINERS
index 79ccf112fabd..1b0d496897ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8541,6 +8541,7 @@ DRM DRIVER FOR VINO DISPLAYLINK DL3 DEVICES
 M:	Mike Lothian <mike@fireburn.co.uk>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
+F:	Documentation/gpu/vino.rst
 F:	drivers/gpu/drm/vino/
 
 DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
