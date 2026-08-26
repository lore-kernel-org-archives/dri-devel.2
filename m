Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A609EC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FAC10ED93;
	Wed, 26 Aug 2026 16:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QeaxRFAu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EBDB10ED93
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:59:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EBA9D60AAA;
 Wed, 26 Aug 2026 16:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DBB1F000E9;
 Wed, 26 Aug 2026 16:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787763577;
 bh=4o6pbz+/ccVn8d6xZInLSKlsoqpI1XH9LvdE6TguUT8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QeaxRFAuhiXNQiSoETzP3/eAP2PiHu27pEbJu9Nc6j03GSmz5Q1aQ0kqh1OhJFHrJ
 erlGXsXjTMjekjrt57v4lnMVSdcH+BRJqsRIDSQPqN1SCY6p8YNXyOpfyw0usPyeEH
 YglIaSabL/AxpNZyfTgrO4FfUWZnl0dI6E/AWGmIilWBThZytvVG5gnqfmoUDGGyBn
 47WRjyISkN8Q7UpPN7w3CFtuakW0vlBLZoj+TlpgM8zM12wvT4z9NqWSfU5VQSPXdB
 tksMwgomn0q81wmae9addQn/BmmIzS41oDAJC7wTPOGHH9Wy0mASLGI+TolJuMkkqo
 6XW7JXbLxxAFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/13] drm/vino: add the dock activation and scanout path
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260826163913.7052-10-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
 <20260826163913.7052-10-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 16:59:37 +0000
Message-Id: <20260826165937.73DBB1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Sleeping functions are called in the atomic commit path (`atomic_u=
pdate`), causing "scheduling while atomic" panics.
- [High] Global encode workqueue is never destroyed, leaking kernel threads=
 on module unload.
- [High] Permanent endpoint wedging due to unhandled queue transmission err=
ors during activation and keepalive.
- [High] Missing bracket unwind and `programmed_timing` cleanup on partial =
dual-wake failures.
- [High] Race condition in workqueue completion prevents `ShadowSurface` re=
cycling, causing massive per-frame memory reallocations.
- [High] Global EDID target variables are mutated without synchronization, =
causing dropped monitors during concurrent modesets.
- [High] Lockless checks in `activate_head` allow concurrent execution, lea=
ding to hardware sequence corruption and AES desynchronization.
- [High] Global `video_staging` Mutex is held across synchronous USB operat=
ions, causing severe cross-monitor starvation.
- [High] Incorrect bitmask check for reflection flags treats reflected mode=
s as identity, corrupting display updates.
- [Medium] Unhandled USB receive errors cause a 64ms CPU busy-wait loop in =
control message routines.
--

commit 75ffbefbbe278fc4d8fd7640be258d86e92c774e
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: add the dock activation and scanout path

Add the dock-facing half of the sink, bringing up a connector's downstream
sink through a sequenced stream brackets, carrier frames, and mode sets.

> diff --git a/drivers/gpu/drm/vino/drm_sink/activation.rs b/drivers/gpu/dr=
m/vino/drm_sink/activation.rs
> new file mode 100644
> index 0000000000000..e505d80ed80d8
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/drm_sink/activation.rs

[ ... ]

> +            self.send_stream_open(dev, connector_index)?;
> +            // A stream that is being opened here starts its ring and it=
s frame counter from the
> +            // beginning, whatever the connector reached before. Arming =
the prologue already resets
> +            // this, but an activation that is retried arms once and pre=
sents several times, so a
> +            // connector could open a stream and immediately tell the do=
ck it was filling a later
> +            // slot with a later frame number -- and the dock scans out =
a slot nothing wrote.
> +            self.scanout_seq.lock()[connector_index] =3D 0;
> +        }
> +        let startup =3D arm.is_some();
> +        let seq0 =3D self.scanout_seq.lock()[connector_index];
> +        let started =3D Instant::<Monotonic>::now();
> +        let mut repeat =3D 0u32;
> +        // Presentations that named a ring slot, which is what the frame=
 counter counts. See
> +        // `names_ring_slot`.
> +        let mut named =3D 0u32;

[Severity: High]
Does this code race to update the sequence numbers?

If two threads concurrently execute submit_prompt_training() due to the
lockless activate_head() invocation, won't they interleave CP control
messages and perform concurrent overlapping read-modify-write operations on
scanout_seq?

[ ... ]

> +            let wire_len =3D arm_slice.len()
> +                + opener_slice.len()
> +                + report_slice.len()
> +                + params_slice.len()
> +                + image_len
> +                + trailer.len();
> +            {
> +                // One writer owns a shared pipe for the whole frame; se=
e `own_pipe`.
> +                let _pipe =3D self.own_pipe();
> +                let mut staging_slots =3D self.video_staging.lock();
> +                let staging_slot =3D &mut staging_slots[connector_index];
> +                if staging_slot.is_none() {
> +                    let mut staging =3D KVec::new();
> +                    staging.resize(xfer, 0, GFP_KERNEL)?;
> +                    *staging_slot =3D Some(staging);
> +                }
> +                let staging =3D staging_slot.as_mut().ok_or(kernel::erro=
r::code::ENOMEM)?;
> +
> +                let mut queue_slot =3D self.video_q[pipe_i].lock();

[Severity: High]
Does holding this global Mutex stall all other monitors?

In submit_prompt_training(), the global video_staging.lock() is acquired to
obtain the staging buffer. But instead of extracting the buffer, the lock is
held for the duration of the while wire_off < wire_len loop below.

Since the loop synchronously calls queue.send() with a timeout, won't this
indefinitely block any other connector attempting to render a frame in
encode_and_send_haar() (which also requires video_staging.lock()) until
this sequence finishes?

[ ... ]

> +                    // DLM's mixed transport: prologue chunk zero is rea=
ped below, then the rest
> +                    // and all ordinary frames are pipelined.
> +                    queue.send(dev.io(), dst, crate::timeout())?;

[Severity: High]
Could this leave the video queue stuck in an error state permanently?

If queue.send() returns a transient USB transport error during
submit_prompt_training(), the ? operator bubbles it up without calling
retire_failed_video_queue().

Unlike the main encode_and_send_haar() scanout path, this fails to clear the
USB halt condition, which wedges the endpoint for all subsequent frames.

[ ... ]

> +        let (sent, started) =3D match timeline {
> +            Ok(state) =3D> state,
> +            Err(e) =3D> {
> +                for connector in 0..MAX_CONNECTORS {
> +                    if sent & (1u32 << connector) !=3D 0
> +                        && self.modeset_active[connector].load(Ordering:=
:Acquire) =3D=3D keys[connector]
> +                    {
> +                        self.modeset_active[connector].store(0, Ordering=
::Release);
> +                    }
> +                }
> +                // The choreography opens every activating connector's b=
racket well before it sets a
> +                // mode, so unwind on `valid` rather than `sent`: a conn=
ector that failed before its
> +                // mode set is still open on the dock.
> +                for connector in 0..MAX_CONNECTORS {
> +                    if valid & (1u32 << connector) !=3D 0 {
> +                        self.unwind_bracket(dev, connector as u8);
> +                    }
> +                }
> +                return Err(e);

[Severity: High]
Does this error path fail to clean up programmed_timing?

In activate_dual_wake(), when timeline returns an Err, the code correctly
calls unwind_bracket() but forgets to clear programmed_timing before unwind=
ing.
Could this desynchronize the link state?

> +            }
> +        };
> +        if sent.count_ones() < 2 {
> +            for connector in 0..MAX_CONNECTORS {
> +                if sent & (1u32 << connector) !=3D 0
> +                    && self.modeset_active[connector].load(Ordering::Acq=
uire) =3D=3D keys[connector]
> +                {
> +                    self.modeset_active[connector].store(0, Ordering::Re=
lease);
> +                }
> +            }
> +            return Ok(false);
> +        }

[Severity: High]
Is this missing a bracket unwind and programmed_timing cleanup?

When sent.count_ones() < 2 (e.g. one connector failed earlier), the code
resets modeset_active and returns Ok(false). However, unlike activate_dock_=
wide
and the Err(e) branch above, it doesn't call unwind_bracket(dev, connector)=
 or
clear programmed_timing.

Does this leave the dock hardware in a partially open bracket state?

> diff --git a/drivers/gpu/drm/vino/drm_sink/cp_session.rs b/drivers/gpu/dr=
m/vino/drm_sink/cp_session.rs
> new file mode 100644
> index 0000000000000..36b3a46026a55
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/drm_sink/cp_session.rs

[ ... ]

> +        let mut reply =3D KVec::from_elem(0u8, 4096, GFP_KERNEL)?;
> +        let deadline =3D Instant::<Monotonic>::now() + Delta::from_milli=
s(64);
> +        let mut matched =3D 0usize;
> +        let (mut reaped, mut undecodable) =3D (0u32, 0u32);
> +        let (mut seen_id, mut seen_sub, mut seen_counter) =3D (0u16, 0u1=
6, 0u16);
> +        loop {
> +            let got =3D if let Some(q) =3D link.ep84_q.as_mut() {
> +                match q.recv(dev.io(), &mut reply, crate::cp_reply_timeo=
ut()) {
> +                    Ok(Some(n)) =3D> n,
> +                    Ok(None) =3D> 0,
> +                    Err(_) =3D> break,
> +                }
> +            } else {
> +                dev.ctrl_recv(&mut reply, crate::cp_reply_timeout(), GFP=
_KERNEL)
> +                    .unwrap_or(0)
> +            };

[Severity: Medium]
Will this loop spin indefinitely on USB receive errors?

In send_cp_reply(), if dev.ctrl_recv() encounters a transport error, it is
masked by unwrap_or(0). This results in got =3D 0, which bypasses the break
condition inside match q.recv and immediately loops again to evaluate the
64ms timeout deadline.

Could this cause the kernel thread to busy-wait in a tight loop without
yielding the CPU when the device stops responding?

> diff --git a/drivers/gpu/drm/vino/drm_sink/presence.rs b/drivers/gpu/drm/=
vino/drm_sink/presence.rs
> new file mode 100644
> index 0000000000000..6e58f5729223c
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/drm_sink/presence.rs

[ ... ]

> +    pub(crate) fn reengage_connector(
> +        &self,
> +        io: &BoundInterface<'_>,
> +        connector: u8,
> +    ) -> Result<bool> {
> +        let socket =3D connector + 1;
> +        self.set_self_blanked(connector as usize, false);
> +        // A connector that is not answering is exactly a connector that=
 may be sitting in an open
> +        // bracket, where the dock has disengaged its EDID handler and e=
very probe below would go
> +        // unanswered. The state is the dock's and it survives a re-enum=
eration, so a fresh session
> +        // cannot know it is owed: assert the closed state rather than i=
nfer it. A connector already
> +        // closed ignores this.
> +        self.close_bracket_before_probe(io, connector);
> +        self.edid_target.store(connector as u32, Ordering::Release);
> +        *self.edid_caught.lock() =3D None;

[Severity: High]
Is it safe to mutate these global EDID variables without synchronization?

In reengage_connector(), self.edid_target and self.edid_caught are modified.
Since this is invoked from close_blank_bracket() during activate_head(), it
can run concurrently for two independent connectors via separate scanout
workers.

If Thread B overwrites Thread A's edid_target, won't Thread A's incoming
EDID response on the shared CP session be misattributed to Thread B,
causing dropped monitors during concurrent modesets?

[ ... ]

> +        let mut reply =3D KVec::from_elem(0u8, 4096, GFP_KERNEL).ok()?;
> +        let deadline =3D Instant::<Monotonic>::now() + Delta::from_milli=
s(64);
> +        let got =3D loop {
> +            let n =3D match link.ep84_q.as_mut() {
> +                Some(q) =3D> match q.recv(dev.io(), &mut reply, crate::c=
p_reply_timeout()) {
> +                    Ok(Some(n)) =3D> n,
> +                    Ok(None) =3D> 0,
> +                    Err(_) =3D> return None,
> +                },
> +                None =3D> dev
> +                    .ctrl_recv(&mut reply, crate::cp_reply_timeout(), GF=
P_KERNEL)
> +                    .unwrap_or(0),
> +            };

[Severity: Medium]
Is it possible for this loop to busy-wait and flood the USB subsystem?

Similarly to send_cp_reply(), if the fallback dev.ctrl_recv() is used in
send_presence_probe(), any transport error is swallowed by unwrap_or(0). The
loop will continue to spin until the 64ms deadline expires.

> diff --git a/drivers/gpu/drm/vino/drm_sink/scanout.rs b/drivers/gpu/drm/v=
ino/drm_sink/scanout.rs
> new file mode 100644
> index 0000000000000..2edd29cffaf6b
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/drm_sink/scanout.rs

[ ... ]

> +    data.last_frame.lock()[connector_index] =3D Some(Instant::<Monotonic=
>::now());
> +    let returned =3D Arc::into_unique_or_drop(src).map(|src| {
> +        let mut src =3D core::pin::Pin::into_inner(src);
> +        ShadowSurface {
> +            w: source_w,
> +            h: source_h,
> +            pixels: core::mem::replace(&mut src.pixels, KVVec::new()),
> +            hashes: core::mem::replace(&mut src.hashes, KVVec::new()),
> +            band,
> +        }
> +    });

[Severity: High]
Does this fail to recycle the ShadowSurface buffer pool?

In run_pending_scanout(), Arc::into_unique_or_drop(src) expects a strong_co=
unt
of 1. But because of the race condition in EncodeChunk::run(), the backgrou=
nd
thread might still hold its reference.

If into_unique_or_drop() fails, the large memory buffers (up to 15MB) are
dropped instead of returning to the pool. Could this cause heavy continuous
GFP_KERNEL churn and potential OOMs?

[ ... ]

> +pub(super) fn snapshot_to_shadow(
> +    geometry: crate::video::haar::Geometry,
> +    slot: &mut Option<ShadowSurface>,
> +    source: &kms::framebuffer::FramebufferVMapOwned<VinoObject>,
> +    w: usize,
> +    h: usize,
> +) -> Result {

[ ... ]

> +    let mut fresh =3D false;
> +    if !matches!(slot, Some(s) if s.w =3D=3D w && s.h =3D=3D h) {
> +        let mut pixels: KVVec<u8> =3D KVVec::new();
> +        pixels.resize(need, 0, GFP_KERNEL)?;
> +        let mut hashes: KVVec<u64> =3D KVVec::new();
> +        hashes.resize(tiles_x * tiles_y, 0, GFP_KERNEL)?;
> +        let mut band: KVVec<u8> =3D KVVec::new();
> +        band.resize(band_len, 0, GFP_KERNEL)?;

[Severity: High]
Can this sequence trigger a scheduling-while-atomic panic?

When VinoPlane::atomic_update executes data.queue_scanout(), it synchronous=
ly
calls snapshot_to_shadow() from within the atomic context. Here,
snapshot_to_shadow() dynamically allocates large KVVec buffers using
GFP_KERNEL, which is a sleeping allocation.

Does this break the DRM subsystem requirement that atomic commit paths must
not sleep?

[ ... ]

> +pub(super) fn read_cursor_bgra(
> +    fb: &kms::framebuffer::Framebuffer<VinoDrmDriver>,
> +    w: usize,
> +    h: usize,
> +) -> Result<KVec<u8>> {
> +    let vmap =3D fb.vmap::<VinoObject>()?;
> +    let view =3D vmap.view();
> +    let pitch =3D vmap.pitch();
> +    let row =3D w.checked_mul(4).ok_or(EINVAL)?;
> +    let len =3D row.checked_mul(h).ok_or(EINVAL)?;
> +    let mut out =3D KVec::new();
> +    out.resize(len, 0, GFP_KERNEL)?;

[Severity: High]
Does this code call a sleeping function inside an atomic context?

In VinoPlane::atomic_update, the atomic commit path acquires a sleeping Mut=
ex
(plane.cursor_last.lock()) and calls read_cursor_bgra(). Here in
read_cursor_bgra(), it allocates with GFP_KERNEL. Since the DRM subsystem
forbids sleeping inside atomic_update callbacks, could this cause deadlocks=
 or
scheduling-while-atomic panics during cursor updates?

[ ... ]

> +fn encode_queue() -> Option<&'static workqueue::Queue> {
> +    static ENCODE_WQ: kernel::sync::SetOnce<workqueue::OwnedQueue> =3D k=
ernel::sync::SetOnce::new();
> +    if let Some(q) =3D ENCODE_WQ.as_ref() {
> +        return Some(q);
> +    }

[Severity: High]
Does this code leak the workqueue threads when the module is unloaded?

ENCODE_WQ is statically allocated using kernel::sync::SetOnce. In Rust, sta=
tic
variables do not automatically run Drop destructors. Without a module-level
teardown mechanism, doesn't the unbound workqueue remain in the system
forever, permanently leaking resources?

[ ... ]

> +impl WorkItem for EncodeChunk {
> +    type Pointer =3D Arc<EncodeChunk>;
> +
> +    fn run(this: Arc<EncodeChunk>) {
> +        if let Ok(strips) =3D encode_coords(this.geometry, &this.src, &t=
his.coords) {
> +            *this.out.lock() =3D strips;
> +        }
> +        // Complete unconditionally. On failure `out` stays short and th=
e joiner detects that by
> +        // length -- but it must never be left blocked on a completion t=
hat cannot fire.
> +        this.done.complete_all();
> +    }
> +}

[Severity: High]
Can this complete_all() call race with the scanout thread's Arc recycling?

If this.done.complete_all() is signaled before the background workqueue thr=
ead
returns and drops its Arc<EncodeChunk> reference, the waiting scanout thread
might wake up immediately.

[ ... ]

> +    if data.modeset_active[connector_index].load(core::sync::atomic::Ord=
ering::Acquire) !=3D want {
> +        // A failed command-worker activation leaves the desired generat=
ion intact. This worker is
> +        // sleepable, so retry the same transaction before submitting it=
s pending framebuffer.
> +        let timing =3D cached.ok_or(EINVAL)?;
> +        data.activate_head(dev, connector, &timing, want)?;

[Severity: High]
Can this lockless check cause concurrent hardware programming?

If the command worker processes KmsCmd::ModeSet and calls activate_head(), =
and
the deferred scanout worker evaluates this lockless modeset_active !=3D want
check, both threads might enter activate_head() simultaneously.

Without a per-connector lock preventing both from executing the hardware
transaction, won't this result in scrambled hardware programming and AES
decryption failures?

[ ... ]

> +    // Full keyframe vs damage delta. A mode-set requires a keyframe; ro=
tation/reflection remains
> +    // conservative because the content shadow is deliberately stored in=
 unrotated framebuffer
> +    // space. For identity rotation, compare the actual framebuffer inst=
ead of trusting optional
> +    // FB_DAMAGE_CLIPS: KWin commonly changes framebuffer objects withou=
t publishing that blob.
> +    let kf_bit =3D 1u32 << connector_index;
> +    let identity =3D rotation.angle() =3D=3D plane::Rotation::ROTATE_0
> +        && !rotation.contains(plane::Rotation::REFLECT_X | plane::Rotati=
on::REFLECT_Y);

[Severity: High]
Is this bitmask check for reflection flags correct?

In encode_and_send_haar(), the identity fast-path evaluates
!rotation.contains(plane::Rotation::REFLECT_X | plane::Rotation::REFLECT_Y).
Because contains() returns true only if ALL specified bits are present, a p=
lane
with only REFLECT_X or only REFLECT_Y evaluates to false, making identity =
=3D true.

Doesn't this bypass the conservative full-frame update for single-axis
reflections, passing unreflected framebuffer damage coordinates to
damage_strip_coords() and corrupting the display updates?

> diff --git a/drivers/gpu/drm/vino/drm_sink/stream.rs b/drivers/gpu/drm/vi=
no/drm_sink/stream.rs
> new file mode 100644
> index 0000000000000..1adb37de980e0
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/drm_sink/stream.rs

[ ... ]

> +    pub(super) fn send_stream_open(&self, dev: &BoundInterface<'_>, conn=
ector: usize) -> Result {
> +        let bit =3D 1u32 << connector;
> +        if self.stream_open_pending.load(Ordering::Acquire) & bit =3D=3D=
 0 {
> +            return Ok(());
> +        }
> +        let Some(open) =3D self.build_stream_open_buf(connector)? else {
> +            self.stream_open_pending.fetch_and(!bit, Ordering::Release);
> +            return Ok(());
> +        };
> +        let pipe_i =3D dev.video_pipe_index(connector)?;
> +        let mut queue_slot =3D self.video_q[pipe_i].lock();
> +        if queue_slot.is_none() {
> +            *queue_slot =3D Some(dev.video_queue(connector, 8, VIDEO_XFE=
R)?);
> +        }
> +        let queue =3D queue_slot
> +            .as_mut()
> +            .get_mut()
> +            .as_mut()
> +            .ok_or(kernel::error::code::ENODEV)?;
> +        queue.send(dev.io(), &open, crate::timeout())?;

[Severity: High]
Does this error path also skip retiring the failed video queue?

If queue.send() fails in send_stream_open(), the error is propagated without
resetting the queue state, leading to the same permanent endpoint wedge
mentioned above.

[ ... ]

> +    pub(crate) fn send_video_keepalive(&self, dev: &BoundInterface<'_>) {
> +        if self.uses_arm_burst() || self.shutting_down.load(Ordering::Ac=
quire) {
> +            return;
> +        }

[ ... ]

> +            let Some(queue) =3D queue_slot.as_mut().get_mut().as_mut() e=
lse {
> +                continue;
> +            };
> +            if queue.send(dev.io(), &report, crate::timeout()).is_ok() {
> +                self.last_video_at.lock()[connector] =3D Some(Instant::<=
Monotonic>::now());
> +            }
> +        }
> +    }

[Severity: High]
Is it safe to ignore queue.send() errors here?

By ignoring the error in send_video_keepalive(), the broken queue state
is left active. When the next foreground frame tries to use this queue, it
will fail since retire_failed_video_queue() was never invoked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826163913.7052=
-1-mike@fireburn.co.uk?part=3D9
