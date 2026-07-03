Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E255C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B35FE10F60D;
	Fri,  3 Jul 2026 03:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="Sh10xoDI";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C121E10F60D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:48 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so419125e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047767; x=1783652567;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4C21vd6TOW9/JoMLq0xfLbPJocFlTioPr7GLhNRTko=;
 b=Sh10xoDIcWLd6ttEuEa11X8ekyY+F4EyjW9jA6D/O8015Tbkzcu36TJ4Uz27cteRRu
 OdIi5cahQYAa8Otq5k7N2bX3cPzahnniNdlNRRceX3NmTxP3/z9q70Ak7MEHzbRrS2aM
 4ww5R7FzzLoARakDJaYuyQuJwCKVSwksOe1RyW4Mzlvj/9++qv2UKXnm0R2JRQ4lGcdF
 VRiEaSTOs7fYcNMn3ye8efgqTvklhgry1G/3j3KXq/nhIrB66Sf5XUagGRepYbN14zjh
 CUOAHNFeb59X1PjCuES5rslNLYq4aSZb4OTykG5PjNT3XhQrozqopEGrbxhNrqtUTGr9
 M3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047767; x=1783652567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F4C21vd6TOW9/JoMLq0xfLbPJocFlTioPr7GLhNRTko=;
 b=GM4WtCMslOXv6Ijrmq632HBua4PkKn7K/N3llMX4SgFIHN2H7IECT0sQLZTToFBD4E
 R32CNFi+4xSU0isUhgRmnaYNZfvpdy+CxEVJkkAkd8CZBMD3nEcqhzR1oXoBTNcn8Xvl
 /bpOrFbnwxObLzEtgqys0LQv9vIBIkSO+m09Cs+nam8RwkcCHqqWmgNDKQTMU2ddfprj
 sGyhdMNU7ScuEzRG/UwrsE/IuXO085FCgsZgcTqt+26NtJoVlnGZc+tMl1BWj/O4e3K4
 bYpvbr7iOxiOwi8ztt8r+/jDBJ2TRiH9j7auVaBPBpHWTqVUkCXR0WB48TMjtz7TjnXe
 I76g==
X-Gm-Message-State: AOJu0Yyf8DfB7Ke1G/+0ebCv6DKO05DIvAAh0nqwRo1khFmKI9p1/Lx5
 txKQq07Xksd7txe/IP96OgBZtLgoCVSpKPvjvQlb5flG99tQtEAA+n+wBmyaaj2nvg==
X-Gm-Gg: AfdE7ckk4qzgiVn8uJA94imDnNSKRjetmBIOLrVHTjhbAzBrYjYnJEMMCVoLOGOHpop
 F/ZoN6RSwLhhZxXjA3vXn+M7W0Zqesw8ldhXIJDwvKyA42JxieZ4SUDj/jWz4oMoytCpANEgunO
 cKT23jmfIfvJN/pVwXjEtJYJ5xYT+IwgEdBJxi32/h3OkkthvFqSLzwxKne42EocOvNthlT2Zya
 W+6qWQHiUdRvunZxZTwlG1mD30AncbJlb860eLFA/UlHHK1XeX3ur7otvLH5wq6+0Qu8ZmBlTVL
 ersmSXQxBLm181FRfyuLUWkl3/9VwvLSPDjRva/iiN7HpXBcOTvqUm2a5n6jYXZ1AVbvzMZefgE
 5LkKWiqUpeBTXTYztkvB8mXY4dBE8rzOS0nV6Ua4aUjAiU4QmsTWe5qzheswZp7IJUeWnNP0aFF
 HGdFG/HlGW5wE9IikSZdPaFpyDj2Zcsa+tdnC+rSWnF3SjKSk7O3aj6RNy
X-Received: by 2002:a05:600d:c:b0:493:b771:ddf9 with SMTP id
 5b1f17b1804b1-493c2b3d048mr94277605e9.1.1783047767064; 
 Thu, 02 Jul 2026 20:02:47 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4a343csm141233875e9.0.2026.07.02.20.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:45 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH v2 10/10] drm/vino: hrtimer-driven software vblank
Date: Fri,  3 Jul 2026 04:02:15 +0100
Message-ID: <20260703030217.2886-11-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030217.2886-1-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
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

The atomic helpers were completing every page-flip immediately via
drm_atomic_helper_fake_vblank(), because the CRTC had no vblank support --
so a compositor got no refresh-rate pacing and updates arrived in bursts.

Implement VblankSupport for VinoCrtc backed by a per-CRTC hrtimer that
fires once per frame (from the mode's framedur_ns) and drives
drm_crtc_handle_vblank(). The CRTC now enables/disables vblank around
scanout (drm_crtc_vblank_on/off) and arms the page-flip completion event
to the next vblank in atomic_flush (drm_crtc_arm_vblank_event via the safe
PendingVblankEvent::arm()), so flips are paced to the display's refresh
rate. The timer free-runs once started and is cancelled when the CRTC is
dropped at teardown.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 drivers/gpu/drm/vino/drm_sink.rs | 146 +++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vino/drm_sink.rs b/drivers/gpu/drm/vino/drm_sink.rs
index ee04a5af9f7d..ce04c8b65461 100644
--- a/drivers/gpu/drm/vino/drm_sink.rs
+++ b/drivers/gpu/drm/vino/drm_sink.rs
@@ -39,21 +39,32 @@
 //! its content-protection channel for vino (see `docs/BLOCKER.md`), so `atomic_update`
 //! never gets past the first `bulk_send`.
 
+use core::sync::atomic::{AtomicBool, AtomicI64, AtomicPtr, Ordering};
 use kernel::{
     bindings, drm,
     drm::kms::{
         self,
         connector::{self, Connector, ConnectorGuard, ModeStatus, Status},
-        crtc::{self, CrtcAtomicCommit, RawCrtc as _, RawCrtcState as _},
+        crtc::{self, AsRawCrtc as _, CrtcAtomicCommit, RawCrtc as _, RawCrtcState as _},
         encoder,
         modes::DisplayMode,
         plane::{self, PlaneAtomicCommit, RawPlaneState as _},
+        vblank::{RawVblankCrtcState as _, VblankGuard, VblankSupport, VblankTimestamp},
         KmsDriver, ModeConfigGuard, ModeConfigInfo, ModeObject as _, NewKmsDevice, Probing,
     },
     i2c,
     error::code::EINVAL,
+    impl_has_hr_timer,
+    interrupt::LocalInterruptDisabled,
     prelude::*,
-    sync::{aref::ARef, new_mutex, Mutex},
+    sync::{aref::ARef, new_mutex, new_spinlock, Arc, ArcBorrow, Mutex, SpinLock},
+    time::{
+        hrtimer::{
+            ArcHrTimerHandle, HrTimer, HrTimerCallback, HrTimerCallbackContext, HrTimerPointer,
+            HrTimerRestart, RelativeMode,
+        },
+        Delta, Monotonic,
+    },
     types::ForLt,
 };
 
@@ -417,11 +428,69 @@ fn probe(dev: &NewKmsDevice<'_, Self, Probing>) -> Result {
 
 // ---- CRTC -----------------------------------------------------------------
 
+/// A software vblank source: an hrtimer that fires once per frame and drives
+/// `drm_crtc_handle_vblank()`, so the atomic helpers pace page-flips against a real vblank
+/// (via `drm_crtc_arm_vblank_event()` in [`VinoCrtc::atomic_flush`]) instead of completing them
+/// immediately with a fake vblank. The timer free-runs once started; `enabled` gates delivery so
+/// DPMS off/on is a flag flip. Cancelled when the owning [`VinoCrtc`] is dropped at teardown.
+#[pin_data]
+pub(super) struct VblankTimer {
+    #[pin]
+    timer: HrTimer<Self>,
+    /// The `drm_crtc` to deliver vblanks to (set when vblank is first enabled).
+    crtc: AtomicPtr<bindings::drm_crtc>,
+    /// One scanout frame in nanoseconds (from the mode's `framedur_ns`).
+    interval_ns: AtomicI64,
+    /// Whether vblanks should currently be delivered (toggled by enable/disable_vblank).
+    enabled: AtomicBool,
+    /// Whether the free-running timer has been started yet.
+    started: AtomicBool,
+}
+
+impl VblankTimer {
+    fn new() -> impl PinInit<Self> {
+        pin_init!(VblankTimer {
+            timer <- HrTimer::new(),
+            crtc: AtomicPtr::new(core::ptr::null_mut()),
+            interval_ns: AtomicI64::new(16_666_666), // ~60 Hz until a mode sets it
+            enabled: AtomicBool::new(false),
+            started: AtomicBool::new(false),
+        })
+    }
+}
+
+impl HrTimerCallback for VblankTimer {
+    type Pointer<'a> = Arc<Self>;
+
+    fn run(this: ArcBorrow<'_, Self>, mut ctx: HrTimerCallbackContext<'_, Self>) -> HrTimerRestart {
+        let crtc = this.crtc.load(Ordering::Relaxed);
+        if !crtc.is_null() && this.enabled.load(Ordering::Relaxed) {
+            // SAFETY: `crtc` is the `drm_crtc` stored in `enable_vblank` while the device is live;
+            // the timer is cancelled (its handle dropped) before the crtc is freed at teardown.
+            unsafe { bindings::drm_crtc_handle_vblank(crtc) };
+        }
+        let interval = this.interval_ns.load(Ordering::Relaxed).max(1_000_000);
+        ctx.forward_now(Delta::from_nanos(interval));
+        HrTimerRestart::Restart
+    }
+}
+
+impl_has_hr_timer! {
+    impl HasHrTimer<Self> for VblankTimer {
+        mode: RelativeMode<Monotonic>, field: self.timer
+    }
+}
+
 #[pin_data]
 pub(super) struct VinoCrtc {
     /// Which display head (0-based) this CRTC drives. Used for diagnostics; the mode-set/DDC CP
     /// messages this CRTC sends are not yet head-differentiated on the wire (see the module doc).
     head: u8,
+    /// The software vblank source for this CRTC.
+    vblank: Arc<VblankTimer>,
+    /// Keeps the timer running; dropping it (at CRTC teardown) cancels the timer.
+    #[pin]
+    vblank_handle: SpinLock<Option<ArcHrTimerHandle<VblankTimer>>>,
 }
 
 #[derive(Clone, Default)]
@@ -436,20 +505,25 @@ impl crtc::DriverCrtc for VinoCrtc {
     type Args = u8;
     type Driver = VinoDrmDriver;
     type State = VinoCrtcState;
-    type VblankImpl = core::marker::PhantomData<Self>;
+    type VblankImpl = Self;
 
     fn new(
         _device: &drm::Device<Self::Driver, drm::Uninit>,
         head: &u8,
     ) -> impl PinInit<Self, Error> {
-        try_pin_init!(VinoCrtc { head: *head })
+        try_pin_init!(VinoCrtc {
+            head: *head,
+            vblank: Arc::pin_init(VblankTimer::new(), GFP_KERNEL)?,
+            vblank_handle <- new_spinlock!(None),
+        })
     }
 
-    /// The display is turning on (scanout begins). Pushes a live mode-set CP message for the
-    /// negotiated mode and brings the monitor out of DPMS standby -- both no-ops until CP
-    /// engages (the wall).
+    /// The display is turning on (scanout begins). Enables vblank pacing, pushes a live mode-set CP
+    /// message for the negotiated mode and brings the monitor out of DPMS standby -- the latter two
+    /// no-ops until CP engages (the wall).
     fn atomic_enable(commit: CrtcAtomicCommit<'_, Self>) {
         let crtc = commit.crtc();
+        crtc.vblank_on();
         let head = crtc.head;
         let data: &VinoDrmData = crtc.drm_dev();
         let new = commit.take_new_state();
@@ -475,12 +549,70 @@ fn atomic_enable(commit: CrtcAtomicCommit<'_, Self>) {
     /// no-op until CP engages.
     fn atomic_disable(commit: CrtcAtomicCommit<'_, Self>) {
         let crtc = commit.crtc();
+        crtc.vblank_off();
         let head = crtc.head;
         let data: &VinoDrmData = crtc.drm_dev();
         data.update_gamma(None);
         let _ = data.set_vcp(super::cp::VCP_POWER_MODE, super::cp::POWER_OFF);
         pr_info!("vino: KMS CRTC disable -- head {head} display OFF (scanout stopped)\n");
     }
+
+    /// Arm the page-flip completion event to be sent by the next vblank tick, so userspace is paced
+    /// to the refresh rate rather than signalled immediately.
+    fn atomic_flush(commit: CrtcAtomicCommit<'_, Self>) {
+        let crtc = commit.crtc();
+        let mut new = commit.take_new_state();
+        if let Some(pending) = new.get_pending_vblank_event() {
+            match crtc.vblank_get() {
+                Ok(vbl_ref) => pending.arm(vbl_ref),
+                // Vblank couldn't be enabled (e.g. mid-teardown): fall back to sending now.
+                Err(_) => pending.send(),
+            }
+        }
+    }
+}
+
+impl VblankSupport for VinoCrtc {
+    type Crtc = VinoCrtc;
+
+    fn enable_vblank(
+        crtc: &crtc::Crtc<Self::Crtc>,
+        vblank_guard: &VblankGuard<'_, Self::Crtc>,
+        _irq: &LocalInterruptDisabled,
+    ) -> Result {
+        let data: &VinoCrtc = crtc;
+        // Track the mode's real frame duration so the tick matches the negotiated refresh rate.
+        let fd = vblank_guard.frame_duration();
+        if fd > 0 {
+            data.vblank.interval_ns.store(fd as i64, Ordering::Relaxed);
+        }
+        data.vblank.crtc.store(crtc.as_raw(), Ordering::Relaxed);
+        data.vblank.enabled.store(true, Ordering::Relaxed);
+        // Start the free-running timer the first time vblank is enabled.
+        if !data.vblank.started.swap(true, Ordering::Relaxed) {
+            let interval = data.vblank.interval_ns.load(Ordering::Relaxed);
+            let handle = data.vblank.clone().start(Delta::from_nanos(interval));
+            *data.vblank_handle.lock() = Some(handle);
+        }
+        Ok(())
+    }
+
+    fn disable_vblank(
+        crtc: &crtc::Crtc<Self::Crtc>,
+        _vblank_guard: &VblankGuard<'_, Self::Crtc>,
+        _irq: &LocalInterruptDisabled,
+    ) {
+        let data: &VinoCrtc = crtc;
+        data.vblank.enabled.store(false, Ordering::Relaxed);
+    }
+
+    fn get_vblank_timestamp(
+        _crtc: &crtc::Crtc<Self::Crtc>,
+        _in_vblank_irq: bool,
+    ) -> Option<VblankTimestamp> {
+        // Let DRM estimate the timestamp from the mode timings.
+        None
+    }
 }
 
 // ---- Planes: primary (scanout) + cursor -------------------------------------
-- 
2.55.0

