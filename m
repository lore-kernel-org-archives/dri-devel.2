Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403C606A334
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=is2ZO7df
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCDF610EA47;
	Mon, 16 Nov 2026 14:49:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5067A10EA46;
 Mon, 16 Nov 2026 14:49:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C67946501;
 Mon, 16 Nov 2026 14:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23901F000C6;
 Mon, 16 Nov 2026 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794840571;
 bh=PxVOi7tPmLo7n67xVcopT5WRl6oeAOApaY8g9JY/xHc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=is2ZO7dfjhQ0v8Isxdm3msTG1tx7FjnwWuEG2Lq83BkCcHl9vBE93KUS9Fs50fFU4
 rUXaftyCpAdNpuKDWKsfvF+OYEza40a6V5KEtM/Spks/e2OP3U14nddt67ZbQPHZSy
 qIaoVN8lIfMIJyPO8x1YGGMnJNaz6xVraji0jIIYsyV1d4nbCmX5NjOqsdiQRLeHw6
 GXWg+Gl0tcPKba7Np8VbB+bBZUBG5mT4c0ibEOO2Q1QVOao/S2RiiwopacI7+W1NGF
 buzYJJj6wu6YKZb1IEcT8OVEa19OqI/mAsXNVLC9o7SgGtWQvMwGxABXUF5j+FFwyF
 AY36v5a7x8ztw==
Message-ID: <sashiko-outbox-217194@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [REGRESSION] i915: UHBR training fails with TB5 dock after
 1fd440de4e02; source FFE update skipped?
To: "Frederik Schwan" <frederik@tty42.de>, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <aveDNRBLx1a-9hRQ@mail.tty42.de>
References: <aveDNRBLx1a-9hRQ@mail.tty42.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 14:49:29 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/i915/dp: raw email report in changelog, sign-off mismatch,
  and Fixes tag
--

commit 4c3a78dc876392e84ec307e2257c7451d9a82be2
Author: Frederik Schwan <frederik@tty42.de>

> i915: UHBR training fails with TB5 dock after 1fd440de4e02; source FFE up=
date skipped?
>
> Hi everyone,
> I just upgraded my system to 7.3.x and found a regression with my noteboo=
k/dock setup.
> 3x 4k displays are hooked to the dock, 2 by DP and one through USB-C (I g=
uess that DP-alt mode then).
>
> Until 7.2 all displays worked. With 7.3 all displays work until kernel sw=
itches from fbdev (?) after
> which the 2 DP displays have no signal anymore but the USB-C one still wo=
rks.
>
> Bisect:
>
> # bad: [c03c1a14507dfaf8b856c2608f9ac216021fc222] Linux 7.3
> # good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
> git bisect start 'v7.3' 'v7.2' '--' 'drivers/gpu/drm/i915/display' 'drive=
rs/gpu/drm/display'
> # good: [bbf51a67d1fe895f3d27402d2560259a619b6dba] drm/i915/dp_link_caps:=
 Use max common lane count from link_caps
> git bisect good bbf51a67d1fe895f3d27402d2560259a619b6dba
> # good: [d6a1bc7c9b4ce71674a633242251d8a804ced82d] drm/i915: Throw away t=
he BIOS fb if has the wrong depth/bpp
> git bisect good d6a1bc7c9b4ce71674a633242251d8a804ced82d
> # bad: [f0cabcc880aba3f05ca59d735f6d166b7fceca80] drm/i915/fbc: No surfac=
e size restrictions from LNL onwards
> git bisect bad f0cabcc880aba3f05ca59d735f6d166b7fceca80
> # good: [b0b6d44646dc7750df4f052d17688fb7e7569a74] drm/dp_tunnel: Add UHB=
R tunneling support
> git bisect good b0b6d44646dc7750df4f052d17688fb7e7569a74
> # bad: [662560bad9be29c3e1a2668806392d2ed9a743d6] drm/i915/bw: Fix spelli=
ng mistake "threshod" -> "threshold"
> git bisect bad 662560bad9be29c3e1a2668806392d2ed9a743d6
> # good: [47fff2b1749e9ba5dfab7528960555cc865360b5] drm/i915/dp: Disable U=
HBR link configs with 1/2 lanes
> git bisect good 47fff2b1749e9ba5dfab7528960555cc865360b5
> # bad: [8b9bc7786adef4e2df3a23293c0682efac6dcc83] drm/i915/dram: Interpre=
t 0xF populated-channel count as 16
> git bisect bad 8b9bc7786adef4e2df3a23293c0682efac6dcc83
> # bad: [1fd440de4e02efab97874bbda0a4daf59d228fa3] drm/i915/dp_tunnel: Add=
 UHBR tunneling support
> git bisect bad 1fd440de4e02efab97874bbda0a4daf59d228fa3
> # first 'bad' commit: [1fd440de4e02efab97874bbda0a4daf59d228fa3] drm/i915=
/dp_tunnel: Add UHBR tunneling support
>
> I collected logs as well with `drm.debug=3D0x10e log_buf_len=3D32M thunde=
rbolt.dyndbg=3D+p`:
>
> good: v7.2-rc1-263-gb0b6d44646dc.log
> bad: v7.2-rc1-268-g1fd440de4e02.log
> patched: patched.log
>
> #regzbot introduced: 1fd440de4e02efab97874bbda0a4daf59d228fa3
> #regzbot title: i915: UHBR training fails through TB5 dock when source FF=
E updates are skipped
>
> I was desperate and thought I'd give it a quick try with help of Codex wh=
ich ended in a rabbit whole of DP protocol investigation for me :).
> We came up with a patch which I tested successfully.
>
> I've attached the patch and the "report" codex created in case you're int=
erested.
>
> Best regards,
> Frederik
>
> UHBR link training uses intra-hop AUX replies at the DPRX address even
> when LTTPRs are present. However, intel_dp_set_signal_levels() only
> programs the source transmitter when intel_dp_phy_is_downstream_of_source=
()
> identifies the receiver being trained as directly downstream of it.
> With LTTPRs present, this check rejects DP_PHY_DPRX.
>
> As a result, UHBR training updates the requested FFE presets in the DPCD
> training set but does not apply them to the source PHY. This causes
> UHBR20 and UHBR10 training failures on a Meteor Lake system connected to
> a ThinkPad Thunderbolt 5 Smart Dock 7500. Enabling UHBR tunneling exposed
> the existing assumption in the source signal-level update path.
>
> Always update the source signal levels during UHBR training. Preserve
> the per-PHY check for 8b/10b training, which trains downstream receivers
> individually.
>
> With this change, the affected system completes four-lane UHBR20
> training, including channel equalization, interlane alignment and CDS.
>
> Fixes: 1fd440de4e02 ("drm/i915/dp_tunnel: Add UHBR tunneling support")
> Signed-off-by: Frederik Schwan <freswa@archlinux.org>
> Assisted-by: Codex:gpt-6

[Severity: Low]
Should the Fixes tag reference a421d8a99216 ("drm/i915/dp: rewrite DP 2.0
128b/132b link training based on errata") instead?

Commit 1fd440de4e02 ("drm/i915/dp_tunnel: Add UHBR tunneling support") only
enabled 128b/132b link rates over DP tunnels and exposed this issue on
Thunderbolt 5 docks.  The bug in intel_dp_set_signal_levels() when training
128b/132b links with LTTPRs was introduced by a421d8a99216 ("drm/i915/dp:
rewrite DP 2.0 128b/132b link training based on errata"), which switched
intel_dp_128b132b_lane_eq() to concurrent intra-hop AUX mode passing
DP_PHY_DPRX without updating intel_dp_set_signal_levels() to program the
source PHY for UHBR links, and citing 1fd440de4e02 ("drm/i915/dp_tunnel:
Add UHBR tunneling support") could prevent backports to stable kernels with
non-tunneled UHBR and LTTPR configurations.

In addition, the subject line is phrased as a bug-report question rather
than an imperative patch subject with the "drm/i915/dp:" prefix, the first
half of the commit message retains the conversational email report, raw git
bisect output, and regzbot directives, and the Author email address
(<frederik@tty42.de>) does not match the Signed-off-by address
(<freswa@archlinux.org>).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aveDNRBLx1a-9hRQ@ma=
il.tty42.de?part=3D1
