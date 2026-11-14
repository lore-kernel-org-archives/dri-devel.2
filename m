Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42506606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRrsAZXm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D1010E66C;
	Sat, 14 Nov 2026 02:24:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8476510E4EF;
 Sat, 14 Nov 2026 02:24:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 510EB4163C;
 Sat, 14 Nov 2026 02:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E571F000C4;
 Sat, 14 Nov 2026 02:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794623073;
 bh=i7fzNIxHYV7a0QHk9/AuIapy2fOGPDBd54DindQ0wRo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QRrsAZXmlXrmgJeqLGA4zmEFJ4HNmT8rTD7lTz8mJvkBzpMEZ5FyMyNbIRDHSUwx0
 /JZcQFL5ZwAml8dg3fQm87oFd0dk5YTtOPgb5jzxwUT0H7aScG1qX8df0runy0Zb0x
 tVn6S+ljPFVlauUpKOfpSKWE1lKYrgdjJ7kWiivoQYwFoN0lstWXpZvPv5R5oknflb
 YmCxpc3S9iGWWF+GrXkUq1Sz95xNRQFJLlPIqAGA31/EohQ3eB3+ICRwLH42g1Wqmw
 qzTO8yBSoB8duCCztwyC7NG8sPCIhr83j7rXCEk8W0P2P1ysN/KXvTJWRq3cCrUON5
 U7VcrklgARq8w==
Message-ID: <sashiko-outbox-214052@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] drm/i915/vrr: Allow VRR with the pipe joiner
To: ElXreno <elxreno@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114014335.2132756-8-elxreno@gmail.com>
References: <20261114014335.2132756-1-elxreno@gmail.com>
 <20261114014335.2132756-8-elxreno@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 02:24:32 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/i915/vrr: use of handle instead of real name in
  Signed-off-by trailer
- [High] drm/i915/vrr: NULL deref in intel_crtc_needs_joined_update() on
  DDB change
- [High] drm/i915/vrr: broken VRR push sequencing on joined pipe DDB
  updates
--

commit 9fa0dc648f78658da0255782a3558fb950bbaa59
Author: ElXreno <elxreno@gmail.com>

> drm/i915/vrr: Allow VRR with the pipe joiner
>
> VRR has been limited to the fixed refresh rate timing generator with
> the joiner, as the transcoder level VRR operations were not sequenced
> against the pipe level updates of the joined pipes. That keeps VRR
> away from every mode that needs the joiner, such as 3840x2400@240 on
> the eDP panels of current 18" laptops.
>
> The transcoder is now programmed only by the joiner primary, and on
> the MMIO path all joined pipes are armed inside one vblank evasion
> critical section, with the push sent at its end. Take that path for
> VRR with the joiner and let VRR through.
>
> A commit whose new state has VRR enabled with the joiner does not use
> the DSB. The push must not be sent before every joined pipe has been
> armed, but each pipe runs its own DSB and nothing orders them against
> each other. Leaving the push to the DSB of the primary, on the
> grounds that it is committed last, is not enough. The secondary's DSB
> waits for the safe window after it has armed (DSB_OPCODE_WAIT_VBLANKS
> with the safe window chicken bits, then the wait in
> intel_dsb_wait_for_delayed_vblank()). When the primary's push ends
> the safe window before the secondary's DSB gets there, that DSB waits
> for the safe window of the next frame, and it is still busy when
> intel_dsb_wait() gives it 1 ms after the flip of the primary has
> completed:
>
>  [CRTC:271:pipe B] DSB 0 timed out waiting for idle (current head=3D0x100=
, head=3D0x0, tail=3D0x140)
>
> That is what a port which only skips the push on the secondaries
> gives, 13 times in 27 minutes of desktop use on Arrow Lake. The DSB
> of a secondary can't check on the push either: commit c3571a239e10
> ("drm/i915/vrr: Check that the push send bit is clear after delayed
> vblank") notes that reading TRANS_PUSH from it ends in a DSB response
> timeout.
>
> The LUT load has the same ordering problem: a colour DSB either sends
> the push itself or has to be ordered against the push that the CPU
> sends, on each pipe. So no colour DSB is prepared for such a commit
> either, and the LUTs are loaded the way they are without one: ahead
> of the commit when they can be preloaded, by the vblank worker after
> it otherwise, in which case the commit takes the per pipe critical
> sections, or with MMIO inside the critical section on the platforms
> with double buffered LUTs. The commit that turns VRR off has no VRR
> push to order and keeps its colour DSBs, which are then started from
> inside the joined critical section.
>
> One thing changes for joined modes even while VRR is off, as it
> follows vrr.in_range: the sink is told to ignore the MSA timing
> parameters during link training, as for any other mode within the
> VRR range.
>
> intel_vrr_compute_config() does not ask for LRR with the joiner, and
> DC balance is kept off, each with a FIXME. The vblank delay fastset
> that reuses the LRR code is not touched: where it applies (inherited
> state, or the always on VRR timing generator) it still writes the
> transcoder timings from every joined pipe, with identical values.
>
> Signed-off-by: ElXreno <elxreno@gmail.com>

[Severity: High]
Documentation/process/submitting-patches.rst requires a real full name in
the Author header and Signed-off-by trailer rather than a single-word handle
or nickname.

> diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i=
915/display/intel_vrr.c
> index 668c495e74075..6543c140e2b58 100644
> --- a/drivers/gpu/drm/i915/display/intel_vrr.c
> +++ b/drivers/gpu/drm/i915/display/intel_vrr.c
[ ... ]
> @@ -495,21 +499,11 @@ intel_vrr_compute_config(struct intel_crtc_state *c=
rtc_state,
>  	crtc_state->vrr.in_range =3D
>  		intel_vrr_is_in_range(connector, drm_mode_vrefresh(adjusted_mode));
> =20
> -	/*
> -	 * Allow fixed refresh rate with VRR Timing Generator.
> -	 * For now set the vrr.in_range to 0, to allow fixed_rr but skip actual
> -	 * VRR and LRR.
> -	 * #TODO For actual VRR with joiner, we need to figure out how to
> -	 * correctly sequence transcoder level stuff vs. pipe level stuff
> -	 * in the commit.
> -	 */
> -	if (crtc_state->joiner_pipes)
> -		crtc_state->vrr.in_range =3D false;

[Severity: High]
Can allowing vrr.enable on joined pipes trigger a NULL pointer dereference
in intel_crtc_needs_joined_update() when another pipe's modeset changes the
DDB allocation of only one of the joined pipes?

On DISPLAY_VER >=3D 13, PIPE_A uses DBUF_S1|DBUF_S2 while PIPE_B shares
DBUF_S3|DBUF_S4 with PIPE_C. If PIPE_A and PIPE_B are joined with VRR
active and an atomic commit enables or disables PIPE_C,
intel_joiner_add_affected_crtcs() runs before watermark calculation when
neither PIPE_A nor PIPE_B is in the atomic state. Later,
intel_compute_global_watermarks() -> skl_compute_wm() -> skl_compute_ddb()
-> skl_crtc_allocate_ddb() adds only PIPE_B to the atomic state because
PIPE_A's DDB slices and entry did not change. During commit,
intel_update_crtc() calls intel_crtc_needs_joined_update(), which loops over
intel_crtc_joined_pipe_mask(new_crtc_state) and dereferences NULL for
PIPE_A:

drivers/gpu/drm/i915/display/intel_display.c:intel_crtc_needs_joined_update=
() {
    ...
	for_each_intel_crtc_in_pipe_mask(display, pipe_crtc,
					 intel_crtc_joined_pipe_mask(new_crtc_state)) {
		const struct intel_crtc_state *old_pipe_crtc_state =3D
			intel_atomic_get_old_crtc_state(state, pipe_crtc);
		const struct intel_crtc_state *new_pipe_crtc_state =3D
			intel_atomic_get_new_crtc_state(state, pipe_crtc);

		/* The DSB and the flip queue do their own vblank evasion */
		if (new_pipe_crtc_state->commit_type !=3D INTEL_COMMIT_MMIO)
			return false;
    ...
}

[Severity: High]
When a joined pipe's DDB allocation changes while VRR is enabled, does
falling back to per-pipe updates in skl_commit_modeset_enables() break VRR
push sequencing?

In intel_crtc_needs_joined_update(), a changed wm.skl.ddb on any joined pipe
returns false so skl_commit_modeset_enables() commits the pipes one at a
time, while intel_vrr_send_push() unconditionally returns early when
intel_crtc_is_joiner_secondary(crtc_state) is true:

drivers/gpu/drm/i915/display/intel_display.c:skl_commit_modeset_enables() {
    ...
			intel_update_crtc(state, crtc);

			if (!skl_ddb_entry_equal(&new_crtc_state->wm.skl.ddb,
						 &old_crtc_state->wm.skl.ddb) &&
			    (update_pipes | modeset_pipes))
				intel_crtc_wait_for_next_vblank(crtc);
    ...
}

When the joiner secondary is committed first and its DDB changed,
intel_update_crtc() arms the secondary without sending a VRR push, and
skl_commit_modeset_enables() immediately waits for the next vblank before
updating the primary pipe, stalling until VMAX and latching the secondary a
frame ahead of the primary. Conversely, if skl_ddb_allocation_overlaps()
orders the joiner primary before the secondary, the primary sends its push
and waits for vblank in the first pass, and the secondary's subsequent
update never receives a push at all.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114014335.2132=
756-1-elxreno@gmail.com?part=3D7
