Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19403C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BEF410E544;
	Fri,  3 Jul 2026 03:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="EVWRZ7c1";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E720310E544
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:01:30 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493b68b4643so253955e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047689; x=1783652489;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pr/YmJjDdgpK4Qlz5+9N1Q+bYdAf7XuFT6hP4TTZuSg=;
 b=EVWRZ7c1v7V+S3eCnCng6kplipQkqySJnF0Rg4Vk2BHI2YCzOY7aQBWtkIi4rP8C3M
 t41CDfQ/S7VT82nFIosiKNRrekYPjmCsi3QGZxMZJJIkPa/CVztD2StZFG/jpXH3WzGm
 MaaxDDyTrhg0fWzTrxO7GU6v61S8tqnhRz/Pf7R+wAq1Un7LZiD9pndmWhOoGGPV4XCC
 ZcZlje8bymMJujUAKJ99zr5ZzyJmpq7JcdEZnyPdHa/of4XZIMsACgleqU6jReMI4PVr
 QC/0TXWh+1rWuDYnIFZ9adPewBBdBla9v6WVUbLQvqUyvmr2GWeaT+BGs6Uz6l17VkWQ
 fQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047689; x=1783652489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pr/YmJjDdgpK4Qlz5+9N1Q+bYdAf7XuFT6hP4TTZuSg=;
 b=MkACCAnkquHgq/UBYGNCgKKvem2RZWlAczYxDAda7ml+1s9VXxqEzQlQsrqwjYcs1Q
 sF/LE7MQcxxQRDZdTWwCodkpkKpHPewcA44Rdb8c9Dz9p2xHLFZhdBLLliScRWHfBUWS
 oWdWVJhu+Cf3vWfMGKwMs+RfYrk2F0HH6m3UGX2dbHmHlBHXxMqRlYBFT+29dHTVpJnx
 Hw+C1BhNsVM1cbfiSFC6DlqUcxiaexDto+iOiWwF85elMxXpV0O4a/RIROpLCt9VGTWl
 yqUkM2FV1KBHnsG5M4FolTkPB/jTnlyQJRrUHtKzMG309nPIVKEd+xpsvWCQm45UQ+0i
 /mPQ==
X-Gm-Message-State: AOJu0YxVI2N7AH4oeRw9wIBpjJd0oTNQuzam5hN2VQrtzWFhwFaosC54
 CNo8WaTvbOjJusl5apKWnYBtCkLLbd4I6dnJm+McpvMXbaUFzxGEcMKXBHkN+zesYw==
X-Gm-Gg: AfdE7cnwzOj9MrZbtiMopwjZPZUox+bLh3qCrrIVHZtVANqMn5xQVs4gUxNmkd01lno
 oZNemgP6XkqzVSGd4KZvN/NMRQVdvu+byoRwskEgRxdJB0M8oRs4QMfnFg6GyJOAUJESNdKF+Lc
 1Bia5T+j31okFMBtJHVsBdqhl8foBMWVfAQpPxa3vHqNKbxh5f+JUkrTNoptSkc16VorMOhqyP4
 SP2d1HQ1CliqGQb0SWI2VSKVn3+r5D0dTtDsSVdI1IVh0mEm76NtSE2dKW6G1X2Vhu6V1qRxl5s
 qwKLZy7kHV662jvi/nd2vJSNzm+xDpmDAlNdMy7lclmFhECDUNNnCMKQp5AkvkyqEqSGKLI6IjY
 xouwjvmMFBkNfezcBJrHXGY7Pmg6gX6JUEuo+VEdVZ3MVZffa1+8ifo7R9htbHtHb1UPD+YHSF0
 q+eGHJvVw7uR8HhsyhbgVIJOIGjwgVQeUdFXaM+fiMjnbF13FVCh1VwN5d
X-Received: by 2002:a05:600c:34c8:b0:493:a5f9:d345 with SMTP id
 5b1f17b1804b1-493c3cf0a35mr114126905e9.26.1783047688971; 
 Thu, 02 Jul 2026 20:01:28 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:27 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH v2 00/18] rust: drm: safe KMS mode-object layer + evdi
 bindings
Date: Fri,  3 Jul 2026 04:00:47 +0100
Message-ID: <20260703030123.2814-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260617150232.2210-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
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

v1 of this series took the "raw C KMS + Device::as_raw() escape hatch"
route because Lyude Paul's safe Rust KMS mode-object layer wasn't
landable yet. Both Danilo and Miguel pushed back on that in review: work
on the safe abstractions instead, coordinate with Lyude. This v2 does
that -- and in the meantime upstream itself moved: drm::Driver's base
trait now requires a Kms associated type routed through exactly that safe
layer, so the v1 approach doesn't compile against current drm-next at all
any more. Posting the real port is the only way to keep a KMS driver
building.

  1/18 rust: drm: kms: forward-port the safe mode-object layer
  2/18 rust: drm: kms: adapt the port to current drm-next
  3/18 rust: drm: kms: break the Driver* trait well-formedness cycle
  4/18 rust: drm: kms: build the kernel crate clean under -Znext-solver
  5/18 rust: drm: expose <drm/display/drm_hdcp.h> HDCP 2.2 messages
  6/18 rust: drm: kms: add a Framebuffer::vmap() guard
  7/18 rust: drm: kms: add safe accessors for common state and modes
  8/18 rust: drm: tyr: add the Kms associated type
  9/18 rust: drm: add drm_event delivery
 10/18 rust: drm: allow drivers to declare ioctls from their own uAPI module
 11/18 rust: platform: add runtime platform device creation
 12/18 rust: drm: framebuffer: geometry accessors, refcounting, byte-slice vmap
 13/18 rust: i2c: add adapter-provider (bus controller) registration
 14/18 rust: add sysfs device attribute groups
 15/18 rust: drm: support hardware cursor planes (sleepable event delivery)
 16/18 rust: drm: add CRTC gamma LUT and plane rotation property
 17/18 rust: drm: kms: add connector detect() and mode_valid() hooks
 18/18 rust: drm: kms: add plane damage-clip accessors

Patches 1-4 are a from-scratch forward-port of Lyude's rvkms-slim safe
KMS mode-object layer (CRTC/plane/connector/encoder/vblank/atomic state)
onto her newer rust-stuck typestate Device design, which isn't in mainline
yet either -- see the companion "rust: sync/drm: locking and
DRM-registration prerequisites" postings this depends on. It's a
mechanical type-level port with one real problem: the ported mode-object
traits are mutually recursive in a way the (then-current) trait solver
can't evaluate without unbounded memory. Patch 3 pins the associated-state
types to break the infinite projection regress; that trades it for a
coinductive cycle the old solver still can't resolve, which patch 4 fixes
by scoping -Znext-solver to the kernel crate only (core/alloc stay on the
old solver, since core.o ICEs under -Znext-solver on this toolchain).
rust/kernel.o then builds clean, safe KMS layer included.

Patches 5-7 are what vino needed once it started using the ported layer:
patch 5 re-adds the HDCP 2.2 message-ID header v1 carried; patch 6 adds a
Framebuffer::vmap() RAII guard; patch 7 adds safe accessors for the handful
of raw drm_kms fields and helpers a real driver reaches for
(drm::Device::hotplug_event(), CRTC-state mode(), plane-state
crtc_w()/crtc_h(), DisplayMode geometry getters, connector EDID modes) so
vino needs no raw escape hatch at all. v1's Device::as_raw() escape hatch
is dropped entirely.

Patch 8 is base drift: tyr predates the Kms associated type becoming
required and needed PhantomData<Self> added, same as nova already had.

Patches 9-18 are new in v2: generic bindings a *second* DRM driver needs
beyond the safe KMS layer. Alongside vino we are rewriting DisplayLink's
out-of-tree evdi module in Rust (it presents virtual displays whose
scanout is pulled by a userspace daemon over a drm_event + ioctl ABI), and
patches 9-15 are the seven things it needs that the layer did not provide,
none of them evdi-specific:

  9/18  drm::event -- a safe EventChannel/EventPayload for delivering
        drm_events to a userspace client, with the receiver drm_file only
        ever touched under the device event_lock so a send can't race a
        file close (the classic NULL/UAF flush bug). event_lock() moves to
        the core drm::Device since events are DRM-core, not KMS.
 10/18  declare_drm_ioctls_ext! -- declare_drm_ioctls! resolves argument
        types and numbers from the in-tree kernel::uapi crate, which an
        out-of-tree driver with its own ioctl range can't extend; the _ext
        variant takes the type and number per entry instead. The original
        macro is untouched.
 11/18  platform::RegisteredDevice -- the provider side of the platform
        bus (create/register a platform_device at runtime), so a virtual
        driver can spawn its own devices; platform.rs previously only bound
        to existing ones.
 12/18  Framebuffer geometry accessors, reference counting (ARef via
        drm_framebuffer_get/put helpers) and FramebufferVmap::as_bytes(),
        so a driver can hold a flipped-in framebuffer and read its pixels
        back without unsafe -- what evdi's GRABPIX does.
 13/18  i2c::BusController/BusAdapter -- the controller (provider) side of
        the I2C bus, so a driver can present a virtual bus and service the
        transfers; i2c.rs previously only registered I2C client drivers.
        Both evdi and vino use it for their DDC/CI channel.
 14/18  sysfs::DeviceAttributes/AttributeGroup -- expose sysfs control files
        on a root device with name-dispatched show/store; evdi uses it for
        its /sys/devices/evdi/{count,add,remove_all} card-lifecycle files.
 15/18  hardware cursor support -- rework drm::event to guard the receiver
        with a mutex so a GEM handle for the cursor bitmap can be created
        for the client (sleepable), plus plane position/hotspot and
        framebuffer format/handle accessors; both evdi and vino advertise a
        cursor plane.

Patches 16-18 round out the KMS feature set with more generic mode-object
support the pre-safe-KMS vino driver had that the ported layer didn't:
patch 16 a CRTC GAMMA_LUT (drm_crtc_enable_color_mgmt + a gamma_lut()
state accessor) and a plane rotation property
(drm_plane_create_rotation_property + rotation()/placement accessors);
patch 17 optional connector detect()/mode_valid() hooks (report hotplug
state, prune modes the driver can't drive), gated in the vtable like the
plane/CRTC optionals; patch 18 the RawPlaneState::damage_merged() and
for_each_damage_clip() accessors over drm_atomic_helper_damage_merged() /
drm_atomic_helper_damage_iter() so a driver can repaint only the region(s)
a client marked dirty. All three are generic KMS, not vino-specific.

vino uses patches 1-8 and 16-18; 9-15 are included here (rather than a
separate series) because they are small DRM/platform/i2c/sysfs binding
additions of the same kind and share this series' base. The evdi driver is
posted as a separate companion series ("[RFC PATCH] drm/evdi: a Rust EVDI
virtual display") -- a second, working consumer of these same bindings.

Known gaps, not fixed here: the connector layer has no detect_ctx()/
writeback support; no per-plane alpha/blend-mode property yet.

The primary consumer is drm/vino, posted alongside ("[RFC PATCH v2 00/9]
drm/vino: DisplayLink DL3 dock driver"). Source:
  https://github.com/FireBurn/vino-scripts
  https://github.com/FireBurn/linux/tree/vino
  https://gitlab.freedesktop.org/FireBurn/linux/-/tree/vino

Changes since v1:
 - Dropped the raw C KMS approach (FEAT_MODESET/FEAT_ATOMIC, drm_edid.h,
   drm_blend.h, Device::as_raw()); replaced by the safe KMS layer
   (patches 1-4), Framebuffer::vmap() (6) and safe accessors (7).
 - Kept the HDCP header (patch 5).
 - Added the evdi/vino bindings (patches 9-18): drm_event delivery,
   out-of-uAPI ioctls, platform-device creation, framebuffer accessors,
   i2c adapter-provider, sysfs attributes, hardware cursor, CRTC gamma /
   plane rotation, connector detect()/mode_valid(), and plane damage-clip
   accessors.

Mike Lothian (18):
  rust: drm: kms: forward-port the safe mode-object layer onto the
    typestate device
  rust: drm: kms: adapt the port to current drm-next
  rust: drm: kms: break the Driver* trait well-formedness cycle
  rust: drm: kms: build the kernel crate clean under -Znext-solver
  rust: drm: expose <drm/display/drm_hdcp.h> HDCP 2.2 message
    definitions
  rust: drm: kms: add a Framebuffer::vmap() guard
  rust: drm: kms: add safe accessors for common state and connector
    modes
  rust: drm: tyr: add the Kms associated type
  rust: drm: add drm_event delivery
  rust: drm: allow drivers to declare ioctls from their own uAPI module
  rust: platform: add runtime platform device creation
  rust: drm: framebuffer: add geometry accessors, refcounting and a
    byte-slice vmap
  rust: i2c: add adapter-provider (bus controller) registration
  rust: add sysfs device attribute groups
  rust: drm: support hardware cursor planes with sleepable event
    delivery
  rust: drm: add CRTC gamma LUT and plane rotation property bindings
  rust: drm: kms: add connector detect() and mode_valid() hooks
  rust: drm: kms: add plane damage-clip accessors

 drivers/gpu/drm/tyr/driver.rs      |    1 +
 rust/Makefile                      |    6 +-
 rust/bindings/bindings_helper.h    |   11 +
 rust/helpers/drm/atomic.c          |   32 +
 rust/helpers/drm/drm.c             |    3 +
 rust/helpers/drm/framebuffer.c     |   13 +
 rust/helpers/drm/vblank.c          |    8 +
 rust/kernel/drm/device.rs          |   31 +-
 rust/kernel/drm/driver.rs          |    8 +-
 rust/kernel/drm/event.rs           |  216 +++++
 rust/kernel/drm/ioctl.rs           |   86 ++
 rust/kernel/drm/kms.rs             |  432 +++++++++-
 rust/kernel/drm/kms/atomic.rs      |  865 +++++++++++++++++++
 rust/kernel/drm/kms/connector.rs   | 1109 +++++++++++++++++++++++++
 rust/kernel/drm/kms/crtc.rs        | 1152 ++++++++++++++++++++++++++
 rust/kernel/drm/kms/encoder.rs     |  409 +++++++++
 rust/kernel/drm/kms/framebuffer.rs |  217 +++++
 rust/kernel/drm/kms/modes.rs       |  151 ++++
 rust/kernel/drm/kms/plane.rs       | 1230 ++++++++++++++++++++++++++++
 rust/kernel/drm/kms/vblank.rs      |  461 +++++++++++
 rust/kernel/drm/mod.rs             |    1 +
 rust/kernel/i2c.rs                 |  192 +++++
 rust/kernel/lib.rs                 |    1 +
 rust/kernel/platform.rs            |   77 ++
 rust/kernel/sysfs.rs               |  245 ++++++
 25 files changed, 6930 insertions(+), 27 deletions(-)
 create mode 100644 rust/helpers/drm/atomic.c
 create mode 100644 rust/helpers/drm/framebuffer.c
 create mode 100644 rust/helpers/drm/vblank.c
 create mode 100644 rust/kernel/drm/event.rs
 create mode 100644 rust/kernel/drm/kms/atomic.rs
 create mode 100644 rust/kernel/drm/kms/connector.rs
 create mode 100644 rust/kernel/drm/kms/crtc.rs
 create mode 100644 rust/kernel/drm/kms/encoder.rs
 create mode 100644 rust/kernel/drm/kms/framebuffer.rs
 create mode 100644 rust/kernel/drm/kms/modes.rs
 create mode 100644 rust/kernel/drm/kms/plane.rs
 create mode 100644 rust/kernel/drm/kms/vblank.rs
 create mode 100644 rust/kernel/sysfs.rs

-- 
2.55.0

