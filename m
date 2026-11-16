Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC4606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=tty42.de header.i=@tty42.de header.a=ed25519-sha256 header.s=dkim header.b=YC6OXZrS;
	dkim=pass (2048-bit key) header.d=tty42.de header.i=@tty42.de header.a=rsa-sha256 header.s=rsa header.b=0yJUBSSc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2910710EA7A;
	Mon, 16 Nov 2026 18:08:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=tty42.de header.i=@tty42.de header.b="YC6OXZrS";
	dkim=temperror (0-bit key) header.d=tty42.de header.i=@tty42.de header.b="0yJUBSSc";
	dkim-atps=neutral
Received: from mail.tty42.de (mail.tty42.de [94.130.190.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53F710EA7A;
 Mon, 16 Nov 2026 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=tty42.de;
 s=dkim; t=1794852484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ReEPD5/jnYV54RpiJTu7aRpiYSs+KaEr/reiZkABHc8=;
 b=YC6OXZrS/vC0p9S+0Cc2aSU2iGNDmJ0pfYj7Ldal7efGcUbOmh7YB3DDmHR0RS4yJ5YLNP
 daLsSVkXMFqO90Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tty42.de; s=rsa;
 t=1794852484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ReEPD5/jnYV54RpiJTu7aRpiYSs+KaEr/reiZkABHc8=;
 b=0yJUBSScawAVMK0HYHbonxHLUcXhc7z7l7Vy/AV9d/Monp5qJNacu1nuy7igjkCqIYiZjj
 QewyNwQHUxRpXManmXxRlhbTB3gzKoDpvEIyYAcuFiC28j1TiUfkekv3cCw/Izn2WvNCmp
 UwcyY0T/Zj+lIaN7pEZTiS/ybmTNl2cY7LshXsrstwgOpIp4n3lmYIxNngTvZmHMWT/Nhh
 CFynzPtopVpFGUsq/ku1+LVBEIp5jfeymHwoEjJ3wRuVgGWTKFXGN/XxTGNubqbL/cdtWu
 41jmhu/lVhJwIxx8k/TO1DWlEMQl/t7ONDOEAe0oSbTGdQhK9grJqbaCbeFwbg==
ARC-Seal: i=1; a=rsa-sha256; d=tty42.de; s=rsa; cv=none; t=1794852484;
 b=cergUCJghJhf1qi5qbSt1t/o3T9V8yT5RqqBHpZ2uoqGICTou07rQ3NNR4O3nBTGZbwFpq
 dIf2dr0jP/21TU7g+0jVz02p/TxH0V/wox6vQi/l4Mjx5VMlm31Ls5zM5ZsgV1grPbcgzk
 UtdAeGeatzTtgmigJy1Vo9u1dd9ckhfCuuAXCGcPvtH+L8IQIZa9Hg5N1oRQ/NsGqJluHJ
 MjTp+DUwm3aigH/9/+0hnJjDlAYR7d7G6e1AOTc2W70zBdKb7bcde+vq3hcYEd2F/nS+bd
 6UYC+E/0MboP8XLNCOJPlnG8WjmZsHfPzMIFzbO0m82dXT4+XkULIXAeHZUY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=tty42.de;
 s=rsa; t=1794852484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ReEPD5/jnYV54RpiJTu7aRpiYSs+KaEr/reiZkABHc8=;
 b=hwbdj/Vs2Skp6xVtDTf4jKvHmrTt1AU+j06LMv9zG23fH9K2n50kRv6dyrahbH5N6+Iict
 ObZvzSq5EkjOedt0daBWH1KtB5+RLJlPfPrudUGoWg5hwiZ6MxWa02EfdADEdPphZBMuCu
 QZrwQ/V6xL3cusPGyloFUx5bCbhVKNkTcBw0UHnw0Vm2H1x9hcIo9b0D9HQc3mO0Ydv5u1
 JFoOkfexzzqHbo0+WGOIVmYsrxrWwoCcPRcwq2IQtOQYTtA1CbNIE4yrdfc9Q4rXge4dPx
 2NcNOAtIJCA1ah8qSHmfP2+kJqnQM0JCECh8wqwA/OeCnMthtElr8tGeMndV6w==
ARC-Authentication-Results: i=1; mail.tty42.de;
 auth=pass smtp.auth=frederik@tty42.de smtp.mailfrom=frederik@tty42.de
Received: by mail.tty42.de (OpenSMTPD) with ESMTPSA id bd94fb67
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 16 Nov 2026 18:08:04 +0000 (UTC)
Date: Mon, 16 Nov 2026 19:08:02 +0100
From: Frederik Schwan <frederik@tty42.de>
To: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 regressions@lists.linux.dev, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [REGRESSION] i915: UHBR training fails with TB5 dock after
 1fd440de4e02; source FFE update skipped?
Message-ID: <avtDzWO1sOXYvxZ2@mail.tty42.de>
References: <aveDNRBLx1a-9hRQ@mail.tty42.de> <avsSK1OE97meC40e@ideak-desk.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yrd7mmhjxv5bd5o5"
Content-Disposition: inline
In-Reply-To: <avsSK1OE97meC40e@ideak-desk.lan>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--yrd7mmhjxv5bd5o5
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="phui4qrrnvy344ws"
Content-Disposition: inline
Subject: Re: [REGRESSION] i915: UHBR training fails with TB5 dock after
 1fd440de4e02; source FFE update skipped?
MIME-Version: 1.0


--phui4qrrnvy344ws
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 04:24:43PM +0200, Imre Deak wrote:
> On Fri, Nov 13, 2026 at 11:08:15PM +0100, Frederik Schwan wrote:
> > Hi everyone,
> > I just upgraded my system to 7.3.x and found a regression with my noteb=
ook/dock setup.
> > 3x 4k displays are hooked to the dock, 2 by DP and one through USB-C (I=
 guess that DP-alt mode then).
> >=20
> > Until 7.2 all displays worked. With 7.3 all displays work until kernel =
switches from fbdev (?) after
> > which the 2 DP displays have no signal anymore but the USB-C one still =
works.
> >=20
> > Bisect:
> >=20
> > # bad: [c03c1a14507dfaf8b856c2608f9ac216021fc222] Linux 7.3
> > # good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
> > git bisect start 'v7.3' 'v7.2' '--' 'drivers/gpu/drm/i915/display' 'dri=
vers/gpu/drm/display'
> > # good: [bbf51a67d1fe895f3d27402d2560259a619b6dba] drm/i915/dp_link_cap=
s: Use max common lane count from link_caps
> > git bisect good bbf51a67d1fe895f3d27402d2560259a619b6dba
> > # good: [d6a1bc7c9b4ce71674a633242251d8a804ced82d] drm/i915: Throw away=
 the BIOS fb if has the wrong depth/bpp
> > git bisect good d6a1bc7c9b4ce71674a633242251d8a804ced82d
> > # bad: [f0cabcc880aba3f05ca59d735f6d166b7fceca80] drm/i915/fbc: No surf=
ace size restrictions from LNL onwards
> > git bisect bad f0cabcc880aba3f05ca59d735f6d166b7fceca80
> > # good: [b0b6d44646dc7750df4f052d17688fb7e7569a74] drm/dp_tunnel: Add U=
HBR tunneling support
> > git bisect good b0b6d44646dc7750df4f052d17688fb7e7569a74
> > # bad: [662560bad9be29c3e1a2668806392d2ed9a743d6] drm/i915/bw: Fix spel=
ling mistake "threshod" -> "threshold"
> > git bisect bad 662560bad9be29c3e1a2668806392d2ed9a743d6
> > # good: [47fff2b1749e9ba5dfab7528960555cc865360b5] drm/i915/dp: Disable=
 UHBR link configs with 1/2 lanes
> > git bisect good 47fff2b1749e9ba5dfab7528960555cc865360b5
> > # bad: [8b9bc7786adef4e2df3a23293c0682efac6dcc83] drm/i915/dram: Interp=
ret 0xF populated-channel count as 16
> > git bisect bad 8b9bc7786adef4e2df3a23293c0682efac6dcc83
> > # bad: [1fd440de4e02efab97874bbda0a4daf59d228fa3] drm/i915/dp_tunnel: A=
dd UHBR tunneling support
> > git bisect bad 1fd440de4e02efab97874bbda0a4daf59d228fa3
> > # first 'bad' commit: [1fd440de4e02efab97874bbda0a4daf59d228fa3] drm/i9=
15/dp_tunnel: Add UHBR tunneling support
> >=20
> > I collected logs as well with `drm.debug=3D0x10e log_buf_len=3D32M thun=
derbolt.dyndbg=3D+p`:
> >=20
> > good: v7.2-rc1-263-gb0b6d44646dc.log
> > bad: v7.2-rc1-268-g1fd440de4e02.log
> > patched: patched.log
> >=20
> > #regzbot introduced: 1fd440de4e02efab97874bbda0a4daf59d228fa3
> > #regzbot title: i915: UHBR training fails through TB5 dock when source =
FFE updates are skipped
> >=20
> > I was desperate and thought I'd give it a quick try with help of Codex =
which ended in a rabbit whole of DP protocol investigation for me :).
> > We came up with a patch which I tested successfully.
> >=20
> > I've attached the patch and the "report" codex created in case you're i=
nterested.
> >=20
> > Best regards,
> > Frederik
>=20
> > From: Frederik Schwan <frederik@tty42.de>
> > Date: Fri, 13 Nov 2026 22:57:12 +0100
> > Subject: [PATCH] drm/i915/dp: Update source FFE presets during UHBR tra=
ining with LTTPRs
> >=20
> > UHBR link training uses intra-hop AUX replies at the DPRX address even
> > when LTTPRs are present. However, intel_dp_set_signal_levels() only
> > programs the source transmitter when intel_dp_phy_is_downstream_of_sour=
ce()
> > identifies the receiver being trained as directly downstream of it.
> > With LTTPRs present, this check rejects DP_PHY_DPRX.
> >=20
> > As a result, UHBR training updates the requested FFE presets in the DPCD
> > training set but does not apply them to the source PHY. This causes
> > UHBR20 and UHBR10 training failures on a Meteor Lake system connected to
> > a ThinkPad Thunderbolt 5 Smart Dock 7500. Enabling UHBR tunneling expos=
ed
> > the existing assumption in the source signal-level update path.
> >=20
> > Always update the source signal levels during UHBR training. Preserve
> > the per-PHY check for 8b/10b training, which trains downstream receivers
> > individually.
>=20
> The fix is correct, however the above explanation for the root cause and
> fix isn't clear. The actual one is:
>=20
> 128b132b links (i.e. links used for UHBR modes) are link trained in
> LTTPR-transparent-mode, even in the cases where LTTPRs are detected on
> the link: In transparent mode the DPRX PHY is link trained directly,
> without link training the LTTPR PHYs first separately and so the source
> must set the FFE parameters during the - single - DPRX link training
> phase.
>=20
> During a non-transparent link training (i.e. on 8b10b links), the link
> training signal parameters (i.e. vswing/pre-emph) are only set for the
> first LTTPR PHY, directly downstream of the source, if LTTPRs are
> detected on the link. Such LTTPR PHY link training phases are indicated
> by phy being set to one of the DP_PHY_LTTPRx values as opposed to
> DP_PHY_DPRX. At the moment, according to the above setting the source's
> link training signal parameters are skipped whenever a PHY other than
> DP_PHY_LTTPR1 is being link trained on a link with LTTPRs detected on
> it. This is not correct during a transparent link training (i.e. on
> 128b132b links), when the port is in the legacy or DP-alt mode (in the
> TBT-alt mode the Thunderbolt subsytem owns and programs the source's
> PHY).
>=20
> Please update the commit message according to the above lines.
>

Done, hope I didn't forget anything. Patch attached.

> > With this change, the affected system completes four-lane UHBR20
> > training, including channel equalization, interlane alignment and CDS.
> >=20
> > Fixes: 1fd440de4e02 ("drm/i915/dp_tunnel: Add UHBR tunneling support")
>=20
> The change is not limited to tunnel scenarios, rather to any case where
> a 128b132b link (i.e. for any UHBR mode) is used in a legacy or DP-alt
> TypeC port mode (i.e. not TBT-alt port mode), with LTTPRs detected on
> the link. So the above Fixes: line is not correct, instead the patch
> should be backported to a kernel version in which the 128b/132b (i.e.
> UHBR support) in general was enabled.

a421d8a99216d46926609611cdcf260fdf900645 seems to be the first commit of
the current DP2.0 implementation. That is as old as 5.17.

>=20
> > Signed-off-by: Frederik Schwan <freswa@archlinux.org>
> > Assisted-by: Codex:gpt-6
> > ---
> > The analysis and patch preparation were assisted by OpenAI Codex. The
> > reporter performed the bisect and hardware tests.
> >=20
> >  drivers/gpu/drm/i915/display/intel_dp_link_training.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/dr=
ivers/gpu/drm/i915/display/intel_dp_link_training.c
> > index cb92cff90614..92b8a8a1af3d 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > @@ -1019,7 +1019,13 @@ void intel_dp_set_signal_levels(struct intel_dp =
*intel_dp,
> >  		       TRAIN_SET_PREEMPH_ARGS(intel_dp->train_set));
> >  	}
> > =20
> > -	if (intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
> > +	/*
> > +	 * UHBR training uses intra-hop AUX replies at the DPRX address, even
> > +	 * with LTTPRs present. The requested FFE presets apply to the source
> > +	 * transmitter, unlike 8b/10b training of individual downstream PHYs.
> > +	 */
> > +	if (intel_dp_is_uhbr(crtc_state) ||
> > +	    intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
>=20
> Introducing an is_transparent_mode() helper and adding that to
> intel_dp_phy_is_downstream_of_source() would be better probably, but
> that's a bigger change and should be left out from this fix.
>=20
> intel_dp_get_lane_adjust_tx_ffe_preset() should be fixed similarly to
> the above.
>=20
> >  		encoder->set_signal_levels(encoder, crtc_state);
> >  }
> > =20
>=20
> > i915 UHBR / Thunderbolt 5 regression investigation
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Provenance
> > ----------
> > Frederik Schwan performed the bisect, built and booted the test kernels,
> > and supplied the hardware logs. OpenAI Codex, an AI coding assistant,
> > analyzed those logs and the kernel source, identified the skipped source
> > PHY callback, prepared the candidate fix, and ran the source-level chec=
ks.
> > This report was prepared by Codex. Its interpretation is offered for
> > maintainer review; the hardware results below come from the supplied lo=
gs.
> >=20
> > Setup and regression boundary
> > -----------------------------
> > Host: Lenovo 21Q8CTO1WW, BIOS N4EET24W (1.10), 2026-06-29.
> > GPU: Intel Meteor Lake, i915, PCI ID 8086:7d51.
> > Dock: ThinkPad Thunderbolt 5 Smart Dock 7500, connected over Thunderbol=
t 5.
> > Display topology: dock MST hub feeding two DisplayPort 1.x displays.
> > Affected upstream display link: DP-4 / DDI TC3, four lanes, one LTTPR.
> > The GPU-side state dump shows tbt_mode: no: the physical source PHY is
> > in use, rather than the integrated TBT alternate-mode PHY path.
> >=20
> > The bisect began with v7.2 good and v7.3 bad, restricted to
> >   drivers/gpu/drm/i915/display
> >   drivers/gpu/drm/display
> >=20
> > First bad:
> >   1fd440de4e02efab97874bbda0a4daf59d228fa3
> >   drm/i915/dp_tunnel: Add UHBR tunneling support
> >=20
> > Immediate parent tested good:
> >   47fff2b1749e9ba5dfab7528960555cc865360b5
> >   drm/i915/dp: Disable UHBR link configs with 1/2 lanes
> >=20
> > The final patched hardware capture identifies its kernel as
> > 7.3.4-arch1-2, built 2026-11-13 20:51:44 UTC. NVIDIA modules are also
> > loaded; the affected link and training messages in this report are i915.
> >=20
> > Failure and unsuccessful experiments
> > ------------------------------------
> > Before the source-FFE fix, four-lane UHBR20 training fails, including a
> > retry, followed by UHBR10 failure. Representative six-byte link status:
> >   UHBR20: 33 33 00 08 ee ee
> >   UHBR10: 33 33 00 08 66 66
> >=20
> > The adjustment bytes request FFE preset 14 or 6, respectively, on all
> > four lanes. Lane EQ bits are set but alignment is absent. The sink-stat=
us
> > bit 0x08 is DP_INTRA_HOP_AUX_REPLY_INDICATION; these are intra-hop repl=
ies,
> > not proof that the entire downstream path has finished training.
> >=20
> > Experiment 1 (dmesg.log): remove the legacy alignment-bit requirement
> > from the UHBR lane-EQ helper, preserving it for active-link monitoring.
> > Result: training advances to "Lane channel eq done" but then fails with
> > "Interlane align timeout". This did not fix the problem.
> >=20
> > Experiment 2 (dmesg.log.1): restore the original helper and repeat the
> > 0x2215 capability read after LTTPR initialization, logging tunnel caps.
> > Result: coding=3D01 rates=3D03 before initialization, after initializat=
ion,
> > and after the extra read; 0x2215 returns 00. UHBR20 and UHBR10 still fa=
il
> > with "Max loop count reached". This did not fix the problem either.
> >=20
> > Failed runs fall back to HBR3. Although HBR3 training passes, FEC-enable
> > polling subsequently times out with status 0x04 or 0x00. The logs show
> > 8b/10b coding selected and intra-hop mode clearing; there is no evidence
> > that the driver simply leaves UHBR coding or intra-hop mode enabled.
> > The cause of the fallback FEC failure has not been established.
> >=20
> > Source-level finding
> > --------------------
> > File: drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > Function: intel_dp_set_signal_levels()
> >=20
> > The existing code calls encoder->set_signal_levels() only if
> > intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy) returns true.
> > That helper accepts a link without repeaters or the source-adjacent
> > LTTPR, DP_PHY_LTTPR(lttpr_count - 1).
> >=20
> > UHBR lane EQ calls the signal-level update path with DP_PHY_DPRX, even
> > when repeaters are present, because it uses intra-hop AUX replies.
> > Consequently, with one or more LTTPRs, the existing guard skips the
> > source transmitter callback. The debug print precedes the guard, so
> > "TX FFE presets: 14/14/14/14" does not establish that those presets
> > were programmed into the GPU PHY. The AUX training-set writes still run.
> >=20
> > For this platform, the callback leads to intel_cx0_phy_set_signal_level=
s().
> > The lane level is derived from train_set through intel_ddi_dp_level(),
> > and the corresponding transmitter settings are written to the PHY.
> > The integrated TBT alternate-mode path has its own early return there;
> > that is not the path shown by this system's PHY state.
> >=20
> > Candidate fix
> > -------------
> > Allow the callback whenever intel_dp_is_uhbr(crtc_state) is true, retai=
ning
> > the existing per-PHY guard for 8b/10b:
> >=20
> >   if (intel_dp_is_uhbr(crtc_state) ||
> >       intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
> >           encoder->set_signal_levels(encoder, crtc_state);
> >=20
> > Neither unsuccessful experimental change is included in this fix.
> > The bisected commit enabled a path that exposes an older assumption;
> > it did not introduce the original guard itself.
> >=20
> > Hardware evidence with the fix (dmesg.log.2)
> > -------------------------------------------
> > First successful sequence on DP-4:
> >   20.224632  Lane channel eq done
> >   20.271570  Interlane align done
> >   20.297496  CDS interlane align done
> >   20.297680  128b/132b Link Training passed at link rate =3D 2000000,
> >              lane count =3D 4
> >=20
> > Second successful sequence on DP-4:
> >   33.891635  Lane channel eq done
> >   33.934586  Interlane align done
> >   33.956537  CDS interlane align done
> >   33.956747  128b/132b Link Training passed at link rate =3D 2000000,
> >              lane count =3D 4
> >=20
> > The first sequence reaches status 77 77 8d 00 11 11 at CDS completion.
> > There are no UHBR training failures, fallback attempts, or FEC-enable
> > timeouts in this capture. Earlier Thunderbolt DPRX-read timeouts and
> > unrelated NVIDIA messages do appear; this is not an error-free system l=
og.
> >=20
> > The result strongly supports the skipped source FFE update as the cause
> > of the reported UHBR training failure. It also demonstrates that the
> > DP1.x monitors do not inherently prevent this upstream link training at
> > UHBR20. It does not establish long-term display stability or validate
> > UHBR-to-HBR3 fallback recovery, which was not exercised in this run.
> >=20
> > Validation performed by Codex
> > -----------------------------
> > - Built intel_dp_link_training.o using a configuration copied from the
> >   running kernel and processed by olddefconfig.
> > - git diff --check and scripts/checkpatch.pl passed for the code change.
> > - A standalone harness extracted the source functions and mocked the
> >   encoder callback. Before the change, all UHBR cases with 1-8 repeaters
> >   missed the callback. Afterward, those cases passed, and tested 8b/10b
> >   per-PHY callback behavior was unchanged. This is not a KUnit or hardw=
are
> >   test and does not validate electrical signal quality.
> > - The code patch applies cleanly to the v7.3 version of the source file.
> >=20
> > Supporting material
> > -------------------
> > Primary attachments:
> >   bisect.log
> >   i915-uhbr-source-ffe.patch
> >   v7.2-rc1-263-gb0b6d44646dc.log (known-good capture)
> >   v7.2-rc1-268-g1fd440de4e02.log (first-bad capture)
> >   patched.log (successful final candidate on 7.3.4)
> >=20
> > Optional experimental captures:
> >   dmesg.log (lane-EQ helper experiment)
> >   dmesg.log.1 (0x2215 refresh experiment)
> >=20
> > Logging parameters:
> >   drm.debug=3D0x10e log_buf_len=3D32M thunderbolt.dyndbg=3D+p
> >=20
> > Retain full logs, preferably compressed, so reviewers can inspect the
> > capability reads, AUX transactions, topology and ordering. The source
> > filenames from the bisect should be interpreted together with the actual
> > kernel banners and bisect.log.

--phui4qrrnvy344ws
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="i915-uhbr-source-ffe_v2.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 55a68a5e094557572b278fa3193d36c147f63612 Mon Sep 17 00:00:00 2001
=46rom: Frederik Schwan <freswa@archlinux.org>
Date: Mon, 16 Nov 2026 15:38:15 +0100
Subject: [PATCH v2] drm/i915/dp: Fix source PHY updates for UHBR links with
 LTTPRs

128b/132b links use LTTPR-transparent training even when LTTPRs are
present. The DPRX is trained directly in a single phase, without first
training each LTTPR PHY separately. The source must therefore program
its FFE parameters during this DPRX training phase.

The source signal-level update is currently guarded by
intel_dp_phy_is_downstream_of_source(). With LTTPRs present, this only
accepts the source-adjacent LTTPR PHY and rejects DP_PHY_DPRX. That is
appropriate for non-transparent 8b/10b training, but skips the source
FFE update during 128b/132b training. This affects legacy and DP-alt
port modes; in TBT-alt mode the Thunderbolt subsystem owns and programs
the source PHY.

Program the source signal levels for UHBR regardless of the detected
LTTPRs. Also make the per-lane capability check used by
intel_dp_get_lane_adjust_tx_ffe_preset() use the source PHY's capability
for UHBR, rather than treating the DPRX as a separately trained
receiver behind an LTTPR. Preserve the existing 8b/10b behavior.

Enabling UHBR tunneling exposed this older bug on a ThinkPad P1 Gen 8
with a ThinkPad Thunderbolt 5 Smart Dock 7500. Updating the source FFE
presets restores four-lane UHBR20 training and both DP displays.

Fixes: a421d8a99216 ("drm/i915/dp: rewrite DP 2.0 128b/132b link training b=
ased on errata")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/regressions/40e2af4139b94eaeecd41fcdccb4ec1ef=
3dc098a@intel.com/
Assisted-by: Codex:gpt-6
Signed-off-by: Frederik Schwan <freswa@archlinux.org>
---
Changes in v2:
- Explain transparent UHBR training and legacy/DP-alt versus TBT-alt modes.
- Correct the FFE preset-selection path to use source per-lane capability.
- Point Fixes at the DPRX-only UHBR training rewrite, not tunnel support.

 .../drm/i915/display/intel_dp_link_training.c    | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/driver=
s/gpu/drm/i915/display/intel_dp_link_training.c
index ac1aff6edf05..1efc78b329a6 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -773,11 +773,14 @@ static u8 intel_dp_phy_preemph_max(struct intel_dp *i=
ntel_dp,
 }
=20
 static bool has_per_lane_signal_levels(struct intel_dp *intel_dp,
+				       const struct intel_crtc_state *crtc_state,
 				       enum drm_dp_phy dp_phy)
 {
 	struct intel_display *display =3D to_intel_display(intel_dp);
=20
-	return !intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy) ||
+	/* UHBR training always adjusts the source PHY, even with LTTPRs. */
+	return (!intel_dp_is_uhbr(crtc_state) &&
+		!intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy)) ||
 		DISPLAY_VER(display) >=3D 10 || display->platform.broxton;
 }
=20
@@ -790,7 +793,7 @@ static u8 intel_dp_get_lane_adjust_tx_ffe_preset(struct=
 intel_dp *intel_dp,
 {
 	u8 tx_ffe =3D 0;
=20
-	if (has_per_lane_signal_levels(intel_dp, dp_phy)) {
+	if (has_per_lane_signal_levels(intel_dp, crtc_state, dp_phy)) {
 		lane =3D min(lane, crtc_state->lane_count - 1);
 		tx_ffe =3D drm_dp_get_adjust_tx_ffe_preset(link_status, lane);
 	} else {
@@ -813,7 +816,7 @@ static u8 intel_dp_get_lane_adjust_vswing_preemph(struc=
t intel_dp *intel_dp,
 	u8 voltage_max;
 	u8 preemph_max;
=20
-	if (has_per_lane_signal_levels(intel_dp, dp_phy)) {
+	if (has_per_lane_signal_levels(intel_dp, crtc_state, dp_phy)) {
 		lane =3D min(lane, crtc_state->lane_count - 1);
=20
 		v =3D drm_dp_get_adjust_request_voltage(link_status, lane);
@@ -1021,7 +1024,12 @@ void intel_dp_set_signal_levels(struct intel_dp *int=
el_dp,
 		       TRAIN_SET_PREEMPH_ARGS(intel_dp->train_set));
 	}
=20
-	if (intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
+	/*
+	 * UHBR links use transparent training, so the source PHY must be
+	 * programmed during the DPRX training phase even with LTTPRs present.
+	 */
+	if (intel_dp_is_uhbr(crtc_state) ||
+	    intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
 		encoder->set_signal_levels(encoder, crtc_state);
 }
=20

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
--=20
2.56.1


--phui4qrrnvy344ws--

--yrd7mmhjxv5bd5o5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iNUEABYKAH0WIQQFx3danouXdAf+COadTFqhVCbaCgUCavtGe18UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MDVD
Nzc3NUE5RThCOTc3NDA3RkUwOEU2OUQ0QzVBQTE1NDI2REEwQQAKCRCdTFqhVCba
CrsBAP9nxdUABhZQ0Sy77xt4/4BtF1NPv88dBjpR3OzBIXjA1AEAut3nVVWyMkxu
64qknR4c+z96qOhWah+zNnIwpWHDqA8=
=e1ba
-----END PGP SIGNATURE-----

--yrd7mmhjxv5bd5o5--
