Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92313C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:59:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E939010E629;
	Wed, 26 Aug 2026 16:59:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eShmyIdY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B17310E629
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:59:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E0EC433EE;
 Wed, 26 Aug 2026 16:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63521F000E9;
 Wed, 26 Aug 2026 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787763571;
 bh=7b3TmpfZWtXghaVxBNkm9OuG0Dlt3EOBe0tJ/ZTOHC4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eShmyIdYWQBeSD3p484f0JAeklOMUse7WHzoTfyZOdDjeFPtCftxL76NuTufipJjb
 T9YywA2DwciGpSXWgFj69i/kDQBWpvt0Af/I+WUkdfAU20SRYeXM+DEwvAjLbmaD/W
 Aycq8r/0iEiU7n1iGCbh7dEB91sIZTKAvBqxeLAvj3gJlj8tLfMje99jUFgaYsfwCM
 GkqAZteWeNPpFAsxl8Gs+szs1N0vScBdqV98zzbKwh9n0w5RFs9J4IRIouhdCWmsmd
 2wOpDjVScHgN9auUzwIOLKezLJMOeQOuV+33IRi7vJYGMuiaYkU9G/U/91t9rmKqv0
 7ZkjopM7RuFtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/13] drm/vino: add the KMS device and the atomic path
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260826163913.7052-9-mike@fireburn.co.uk>
References: <20260826163913.7052-1-mike@fireburn.co.uk>
 <20260826163913.7052-9-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 16:59:31 +0000
Message-Id: <20260826165931.B63521F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Operations that sleep (Mutex locks, GFP_KERNEL allocations, and vm=
ap) and long synchronous memory copies are performed within DRM atomic comm=
it callbacks.
- [High] Page flips are permanently lost if an older frame is still pending=
, causing the screen to freeze on stale frames.
- [High] atomic_check reads shared global state without global atomic track=
ing, allowing concurrent commits to overcommit the dock's pixel bandwidth.
--

commit b222a22b8b0ea906ee63e26872096f97f4fb7ece
Author: Mike Lothian <mike@fireburn.co.uk>
drm/vino: add the KMS device and the atomic path

This commit adds the KMS side of the sink, including the DRM driver, GEM
and file types, CRTCs, planes, and connectors. It introduces atomic
callbacks to record desired state and workers to handle scanout, formatting,
and KMS limits checking.

> diff --git a/drivers/gpu/drm/vino/drm_sink.rs b/drivers/gpu/drm/vino/drm_=
sink.rs
> index 0000000000000..86708db89699a
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/drm_sink.rs
[ ... ]
> +    fn get(
> +        &mut self,
> +        fb: &kms::framebuffer::Framebuffer<VinoDrmDriver>,
> +    ) -> Result<Arc<SourceBinding>> {
[ ... ]
> +        let binding =3D Arc::new(
> +            SourceBinding {
> +                framebuffer: ARef::from(fb),
> +                mapping: fb.owned_vmap::<VinoObject>()?,
> +            },
> +            GFP_KERNEL,
> +        )?;

[Severity: High]
Does this code sleep in an atomic context?

DRM CRTC and plane atomic callbacks execute in an atomic context during
non-blocking commits, where sleeping is strictly forbidden. This performs
a GFP_KERNEL allocation and maps memory with fb.owned_vmap(), both of
which can sleep.

> diff --git a/drivers/gpu/drm/vino/drm_sink/dispatch.rs b/drivers/gpu/drm/=
vino/drm_sink/dispatch.rs
> index 0000000000000..bd759ad4bc992
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/drm_sink/dispatch.rs
[ ... ]
> +    pub(super) fn queue_scanout(
> +        &self,
> +        dev: &VinoDrmDevice,
> +        fb: &kms::framebuffer::Framebuffer<VinoDrmDriver>,
> +        mut frame: PendingScanout,
> +    ) {
[ ... ]
> +        let coalesce =3D {
> +            let pending =3D self.pending_scanout.lock();
> +            pending[connector].as_ref().is_some_and(|queued| {
> +                queued.w =3D=3D frame.w
> +                    && queued.h =3D=3D frame.h
> +                    && queued.rotation =3D=3D frame.rotation
> +                    && self.keyframe_pending.load(Ordering::Acquire) & (=
1u32 << connector) =3D=3D 0
> +            })
> +        };
> +        if coalesce {
> +            vino_debug!("vino: socket {socket} flip coalesced before sna=
pshot\n");
> +            return;
> +        }

[Severity: High]
Can this early return cause the display to permanently freeze on stale fram=
es?

If pending[connector] contains an unclaimed frame (making coalesce true),
this discards the new frame before taking a snapshot. The scanout worker
will only encode and scan out the older pending frame. If the compositor
goes idle and stops submitting frames, the worker will repeatedly process
the old frame and arm the settle_repaint timer with it, losing the most
recent updates.

[ ... ]
> +        let (mut surface, binding, idx) =3D {
> +            let mut pool =3D self.shadow[connector].lock();

[Severity: High]
Could this Mutex lock cause a deadlock or panic when called from the
atomic commit path?

This acquires a sleeping Mutex (shadow.lock()), which is unsafe in
atomic context.

[ ... ]
> +        let r =3D snapshot_to_shadow(
> +            self.geometry(),
> +            &mut surface,
> +            &binding.mapping,
> +            source_w,
> +            source_h,
> +        );

[Severity: High]
Is it safe to perform a synchronous memory copy of up to 14.7 MB here?

Executing a long synchronous memory copy in the non-blocking atomic
commit callback can lead to system instability, as atomic contexts
should be kept as short as possible.

> diff --git a/drivers/gpu/drm/vino/drm_sink/limits.rs b/drivers/gpu/drm/vi=
no/drm_sink/limits.rs
> index 0000000000000..96d2d8dcf8c29
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/drm_sink/limits.rs
[ ... ]
> +    pub(super) fn other_connectors_rate(
> +        &self,
> +        state: &kernel::drm::kms::atomic::AtomicStateMutator<VinoDrmDriv=
er>,
> +        connector: usize,
> +    ) -> u32 {
[ ... ]
> +        let timings =3D *self.last_timing.lock();
> +        let mut total: u32 =3D 0;
> +        for (i, t) in timings.iter().enumerate() {
> +            if i =3D=3D connector {
> +                continue;
> +            }

[Severity: High]
Does reading shared global state here without global DRM atomic tracking
allow concurrent commits to overcommit the dock's pixel bandwidth?

Because this state is protected only by a local spinlock rather than being
part of the global DRM atomic state machine (e.g., via a drm_private_obj),
concurrent commits to different connectors will not serialize against each
other. Each commit will see the other connector's old bandwidth and succeed,
potentially bypassing hardware limits and causing a blank display.

> diff --git a/drivers/gpu/drm/vino/drm_sink/mode_objects.rs b/drivers/gpu/=
drm/vino/drm_sink/mode_objects.rs
> index 0000000000000..d3ec818ec1daa
> --- /dev/null
> +++ b/drivers/gpu/drm/vino/drm_sink/mode_objects.rs
[ ... ]
> +    fn atomic_check(check: CrtcAtomicCheck<'_, Self>) -> Result {
[ ... ]
> +        let others =3D data.other_connectors_rate(&state, connector);
> +        let combined =3D new_rate.saturating_add(others);

[Severity: High]
Could this call read a stale bandwidth value from other connectors?

As noted in limits.rs, this reads shared global state without global
atomic tracking, which might allow concurrent commits to overcommit
the display bandwidth.

[ ... ]
> +    fn atomic_update(commit: PlaneAtomicCommit<'_, Self>) {
[ ... ]
> +        data.queue_scanout(
> +            dev,
> +            fb,
> +            PendingScanout {
> +                connector,
> +                rotation,
> +                clips,
> +                nclips,
> +                w,
> +                h,
> +                shadow_idx: 0,
> +                shadow_generation: 0,
> +            },
> +        );
> +    }

[Severity: High]
Does calling queue_scanout() from this atomic callback invoke operations
that are unsafe in atomic context?

VinoPlane::atomic_update() executes in an atomic context during
non-blocking commits. However, queue_scanout() acquires a sleeping
Mutex, allocates with GFP_KERNEL, maps memory, and performs large
synchronous memory copies.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826163913.7052=
-1-mike@fireburn.co.uk?part=3D8
