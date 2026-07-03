Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28255C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A36710F623;
	Fri,  3 Jul 2026 03:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ud59aVZw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFFE10F623
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:21:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9605343874;
 Fri,  3 Jul 2026 03:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507781F000E9;
 Fri,  3 Jul 2026 03:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783048898;
 bh=g1NJzCOgMggn74MYQY32KCxvw+KcBgumCaa+sViDKqU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ud59aVZwH+j0I3jc/f3Nn8h0Po3APlZKOEDhbMuWwPf828iiZPgA9bliwb6eGfqKV
 vzLNhdO79IUZv9UQAGPB4vN2WjxDpJzP+Q5TK9uJoTt3f8MVHIqelk8zhp2gtUa3qf
 N5gPP7oF2jaLjgPNV2GIcY4xXk2hsCPHrmKO4cCqX08+sFvkm1NFBxg6wBnYVRxBGt
 DfNjHvO7AIEf42KPsu+wW54rNOSY08xN8JTwliSc6wlHqytESu7XxmqoE2gDM7i24Y
 eiPlzceXXVScaa18Zx3Noad8/FXDxT+Km6lFhbkFbbi0zbT2+SRrmPMaVnDOE8VZMx
 SoZnVVtSZCQnQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 10/10] drm/vino: hrtimer-driven software vblank
To: "Mike Lothian" <mike@fireburn.co.uk>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260703030217.2886-11-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
 <20260703030217.2886-11-mike@fireburn.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 03:21:38 +0000
Message-Id: <20260703032138.507781F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The software vblank hrtimer free-runs indefinitely at ~60Hz even=
 when the display is disabled (DPMS off), causing continuous power drain.
--

commit a169dcaae3d3a68e1d3207b3eca11363159c01a8
Author: Mike Lothian <mike@fireburn.co.uk>

drm/vino: hrtimer-driven software vblank

The atomic helpers were completing every page-flip immediately via
drm_atomic_helper_fake_vblank(), because the CRTC had no vblank support.
This patch implements VblankSupport for VinoCrtc backed by a per-CRTC
hrtimer that fires once per frame to pace page flips.

> diff --git a/drivers/gpu/drm/vino/drm_sink.rs b/drivers/gpu/drm/vino/drm_=
sink.rs
> index ee04a5af9f7d5..ce04c8b65461c 100644
> --- a/drivers/gpu/drm/vino/drm_sink.rs
> +++ b/drivers/gpu/drm/vino/drm_sink.rs
[ ... ]
> @@ -417,11 +428,69 @@ fn probe(dev: &NewKmsDevice<'_, Self, Probing>) -> =
Result {
[ ... ]
> +impl HrTimerCallback for VblankTimer {
> +    type Pointer<'a> =3D Arc<Self>;
> +
> +    fn run(this: ArcBorrow<'_, Self>, mut ctx: HrTimerCallbackContext<'_=
, Self>) -> HrTimerRestart {
> +        let crtc =3D this.crtc.load(Ordering::Relaxed);
> +        if !crtc.is_null() && this.enabled.load(Ordering::Relaxed) {
> +            // SAFETY: `crtc` is the `drm_crtc` stored in `enable_vblank=
` while the device is live;
> +            // the timer is cancelled (its handle dropped) before the cr=
tc is freed at teardown.
> +            unsafe { bindings::drm_crtc_handle_vblank(crtc) };
> +        }
> +        let interval =3D this.interval_ns.load(Ordering::Relaxed).max(1_=
000_000);
> +        ctx.forward_now(Delta::from_nanos(interval));
> +        HrTimerRestart::Restart

[Severity: Medium]
Will this timer continue to free-run indefinitely at ~60Hz even when the
display is disabled?

When the display is turned off, disable_vblank() merely clears the enabled
flag, but VblankTimer::run() unconditionally returns HrTimerRestart::Restar=
t.
Since the timer is only started once in enable_vblank() and is only cancell=
ed
when the CRTC object is dropped, it appears this creates continuous backgro=
und
wakeups on an idle system, which can prevent the CPU from entering deep sle=
ep
states.

Could the timer self-terminate when the enabled flag is false, and be
restarted by enable_vblank() to avoid draining power during DPMS off?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703030217.2886=
-1-mike@fireburn.co.uk?part=3D10
