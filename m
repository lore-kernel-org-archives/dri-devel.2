Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACBD606A6A0
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQBqktVk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 052FD112D3F;
	Fri, 20 Nov 2026 22:18:50 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFC09112D3F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 22:18:43 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-9495f083657so171894485a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:18:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795213122; cv=none;
 d=google.com; s=arc-20260327;
 b=qt1pGbNChoCbzRDQym5giSv0BmI9KP2YfjabNIO4tkWbow6GB1Sh1h+EFdU1YhmRYw
 9kEaTAFT3z/jo70t1Wwg5XPZ5oXYVFZfM3X/dyd794zlpO08iiPlv6ZsBqP4YQ6K5v7B
 1dw8zRpQ2ObYh/fixbVy/PwbqNIKrWCqAd863OnAFVmYlctqovAmwmLExcAim9pvNPlC
 JD36aGAObLK6X4Hb4HLZUh49XjzaHcYyD/YXbgNSnAlQ7CwAQ1/IZwGhFg8BdNPbkqIf
 AJOwhIDyyFqwyjPxt7PzC1VguDm3jEZzeK1or4htV6YRYcxMoPLr2RCzhv2MkCHPnSqR
 Om0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9hK61NhYm4hbvqQZMc/tWnALDQEyPFZSvX9uNHUR+Aw=;
 fh=oFdE6K1X7vQCNGpVUKnrPXiCCUD77NKwWgCRggYaG9I=;
 b=jCB2ZT+BAvglR6EwUXsKQElhxvMb4begNwuen7EzXL73r518PWEwQfnysv0JBja5hc
 OFeo5P2wbjTF2TzdMHbpJbJsPG6LD01tT9Z3x2iMqOCRTa9YgqB5F7oXtZyN6gvL8TNp
 VbYmUFdTk1wH5QeZVcGNyCR1zJHAnskqeyHYM3Ngs6jcBPXy7UJpXDk5OQH0vn6qT9Wg
 HCTVECyhAz5wuQsojkm/IqbR64QRYIpM0NwafeKbsvtprRXkXcwwZLKwe/UR2m1hi4+j
 sQH2+oIAEPCjQDiLMDz6/qILVWVFzHKXG3ZjPBm5+yuTO+F06CWsL46CUymFvVWhSw5T
 rLXw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795213122; x=1795817922; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9hK61NhYm4hbvqQZMc/tWnALDQEyPFZSvX9uNHUR+Aw=;
 b=MQBqktVkG536riOXKxBWiehxngHGxaa6FJudxMk4fMFi7R8mELA2E3roCI+m2wmEFC
 6+/orCR6FBK94YQMYBwacUL2rAA+eGDC90E3qyG447wRLauLWkOFgQo5HAf4sPW3NacD
 dwo7ZyrVQo9yj/dC+CrJbAOblS0MTylKFoagXdv4FAO5GxM3WJkYBYSJJ326/i/++AzU
 7JFgEMzC7+iNo31Wg58sQYS6K2IxqFr7qm4pkXRgwCeUH/zytjSQEG82a3kS7/rDI09H
 QxhhdRV1kyK2yTF9QuhVz1amCbB4HjCc5W1LsaCM357Yi4Np1nWsh1T54z3zz7GBtw7l
 DqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795213122; x=1795817922;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9hK61NhYm4hbvqQZMc/tWnALDQEyPFZSvX9uNHUR+Aw=;
 b=L9QDiw1M1P11JrATLAv9SWG7s3LNK6TGt5p6sHyelsxcOfQobXrqyb28C88S9ltyPK
 z1ROqfMnfK+k4epOjcS1BDAcbB150fu10PlUhn52l5FkwyhVHqHt1SipN0OI10uPlY36
 bq8xNm1KO/353g9gtcLLYVsza5rmVY2eFCr3urAl9cj+lT9DxXtQNXf9fGKWBxNfa8Zv
 +xvjtn4vZPWrG8bQQB3ZDtenvjH70zKZ+Ufuwk9O0PeSnuyoXjqXyjImvKdnnX7h1as4
 Yxj5y/mSL0HiIjPamkhfHiKtgfRKN8a13x2RM1jbqZaW2+HQuRbolkb4INOahfGVW1x6
 mvGQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFFWRej/C/IZpSbo9HHl+VL5IWJaGxOtf9F6y5JxxMf54zeEcSd8URbsKDtBYtXac51nYtqxfEs0/c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/HARixQb7iXW2qJGna5VOidwaHiZK4hT9Pd1D7bWDRMawNgh9J
 cofQKOI/nsCybHBUyiBR2r9TJyRNRzs8KGmJr7lSCcCwmiSTX24OwfXL7owq1qDfPGTx+JFKOOA
 cYEaSeOkL9F76Fv9s/Ol11Mt9xgQXxm4=
X-Gm-Gg: AYBFou002cQIhAwKs/bA+qpsBf2ydSQifBLp7FV3Ey61hNsDVl21w67crnPzplGb4ET
 wzz3E5N71VgV4o4NdrcKDgfO3TmnorvJKatxPnptqTknfB0agkDL5zk5+bMWHj1OxY+3tGYoBqd
 fj4xFeWHI8GMBpUisxHo/0dwGG96jjvCTUfrs2sBu4jzNAnhjWYYMCSyZE3oBmNV95yg2d+763q
 9UhYCUW7gU50wsZrTwpyCVceVXZo2skoTO3mQVmXhXhBvRSp1AbNFewwbR5hwD49v7XPNI4YYkx
 CKBjxbwRwJGaLvR62shtbVIhgg40+aMWHAwd7WthT3xENpkXj71r/+8EZKH39Ylu69qHwaWTG/4
 aWysCo5Rc42aFDDzbO1xTj0dugZe18sJHg2UXsGfwaHH/iCj3ykgpFZC8c+FkGJ1pZIKK726D8z
 kHgKqV6e9Y+Gcwe0u0hVHVWg==
X-Received: by 2002:a05:620a:1308:b0:949:6493:7c6c with SMTP id
 af79cd13be357-949ba9e05efmr715091585a.30.1795213121902; Fri, 20 Nov 2026
 14:18:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <aveDNRBLx1a-9hRQ@mail.tty42.de> <avsSK1OE97meC40e@ideak-desk.lan>
 <avtDzWO1sOXYvxZ2@mail.tty42.de>
In-Reply-To: <avtDzWO1sOXYvxZ2@mail.tty42.de>
From: Dave Airlie <airlied@gmail.com>
Date: Sat, 21 Nov 2026 08:18:30 +1000
X-Gm-Features: AclHuK-PSpYuj1ahpbNwXwT3dsy09uR-DRKpJwSDX7vu-5SIVe4I6Jr9vd-wnBw
Message-ID: <CAPM=9tz7suJ0UwGPVCusSQr1Km_hK29aNAGWyaCehTEeAHVXbQ@mail.gmail.com>
Subject: Re: [REGRESSION] i915: UHBR training fails with TB5 dock after
 1fd440de4e02; source FFE update skipped?
To: Frederik Schwan <frederik@tty42.de>
Cc: Imre Deak <imre.deak@intel.com>, intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, regressions@lists.linux.dev, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a pretty well reported regressions in 7.3 that is hitting a
lot of laptop/docks, can we get some maintainer to just pull the patch
together and get it into the tree soon?

Dave.

On Tue, 17 Nov 2026 at 04:26, Frederik Schwan <frederik@tty42.de> wrote:
>
> On Mon, Nov 16, 2026 at 04:24:43PM +0200, Imre Deak wrote:
> > On Fri, Nov 13, 2026 at 11:08:15PM +0100, Frederik Schwan wrote:
> > > Hi everyone,
> > > I just upgraded my system to 7.3.x and found a regression with my notebook/dock setup.
> > > 3x 4k displays are hooked to the dock, 2 by DP and one through USB-C (I guess that DP-alt mode then).
> > >
> > > Until 7.2 all displays worked. With 7.3 all displays work until kernel switches from fbdev (?) after
> > > which the 2 DP displays have no signal anymore but the USB-C one still works.
> > >
> > > Bisect:
> > >
> > > # bad: [c03c1a14507dfaf8b856c2608f9ac216021fc222] Linux 7.3
> > > # good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
> > > git bisect start 'v7.3' 'v7.2' '--' 'drivers/gpu/drm/i915/display' 'drivers/gpu/drm/display'
> > > # good: [bbf51a67d1fe895f3d27402d2560259a619b6dba] drm/i915/dp_link_caps: Use max common lane count from link_caps
> > > git bisect good bbf51a67d1fe895f3d27402d2560259a619b6dba
> > > # good: [d6a1bc7c9b4ce71674a633242251d8a804ced82d] drm/i915: Throw away the BIOS fb if has the wrong depth/bpp
> > > git bisect good d6a1bc7c9b4ce71674a633242251d8a804ced82d
> > > # bad: [f0cabcc880aba3f05ca59d735f6d166b7fceca80] drm/i915/fbc: No surface size restrictions from LNL onwards
> > > git bisect bad f0cabcc880aba3f05ca59d735f6d166b7fceca80
> > > # good: [b0b6d44646dc7750df4f052d17688fb7e7569a74] drm/dp_tunnel: Add UHBR tunneling support
> > > git bisect good b0b6d44646dc7750df4f052d17688fb7e7569a74
> > > # bad: [662560bad9be29c3e1a2668806392d2ed9a743d6] drm/i915/bw: Fix spelling mistake "threshod" -> "threshold"
> > > git bisect bad 662560bad9be29c3e1a2668806392d2ed9a743d6
> > > # good: [47fff2b1749e9ba5dfab7528960555cc865360b5] drm/i915/dp: Disable UHBR link configs with 1/2 lanes
> > > git bisect good 47fff2b1749e9ba5dfab7528960555cc865360b5
> > > # bad: [8b9bc7786adef4e2df3a23293c0682efac6dcc83] drm/i915/dram: Interpret 0xF populated-channel count as 16
> > > git bisect bad 8b9bc7786adef4e2df3a23293c0682efac6dcc83
> > > # bad: [1fd440de4e02efab97874bbda0a4daf59d228fa3] drm/i915/dp_tunnel: Add UHBR tunneling support
> > > git bisect bad 1fd440de4e02efab97874bbda0a4daf59d228fa3
> > > # first 'bad' commit: [1fd440de4e02efab97874bbda0a4daf59d228fa3] drm/i915/dp_tunnel: Add UHBR tunneling support
> > >
> > > I collected logs as well with `drm.debug=0x10e log_buf_len=32M thunderbolt.dyndbg=+p`:
> > >
> > > good: v7.2-rc1-263-gb0b6d44646dc.log
> > > bad: v7.2-rc1-268-g1fd440de4e02.log
> > > patched: patched.log
> > >
> > > #regzbot introduced: 1fd440de4e02efab97874bbda0a4daf59d228fa3
> > > #regzbot title: i915: UHBR training fails through TB5 dock when source FFE updates are skipped
> > >
> > > I was desperate and thought I'd give it a quick try with help of Codex which ended in a rabbit whole of DP protocol investigation for me :).
> > > We came up with a patch which I tested successfully.
> > >
> > > I've attached the patch and the "report" codex created in case you're interested.
> > >
> > > Best regards,
> > > Frederik
> >
> > > From: Frederik Schwan <frederik@tty42.de>
> > > Date: Fri, 13 Nov 2026 22:57:12 +0100
> > > Subject: [PATCH] drm/i915/dp: Update source FFE presets during UHBR training with LTTPRs
> > >
> > > UHBR link training uses intra-hop AUX replies at the DPRX address even
> > > when LTTPRs are present. However, intel_dp_set_signal_levels() only
> > > programs the source transmitter when intel_dp_phy_is_downstream_of_source()
> > > identifies the receiver being trained as directly downstream of it.
> > > With LTTPRs present, this check rejects DP_PHY_DPRX.
> > >
> > > As a result, UHBR training updates the requested FFE presets in the DPCD
> > > training set but does not apply them to the source PHY. This causes
> > > UHBR20 and UHBR10 training failures on a Meteor Lake system connected to
> > > a ThinkPad Thunderbolt 5 Smart Dock 7500. Enabling UHBR tunneling exposed
> > > the existing assumption in the source signal-level update path.
> > >
> > > Always update the source signal levels during UHBR training. Preserve
> > > the per-PHY check for 8b/10b training, which trains downstream receivers
> > > individually.
> >
> > The fix is correct, however the above explanation for the root cause and
> > fix isn't clear. The actual one is:
> >
> > 128b132b links (i.e. links used for UHBR modes) are link trained in
> > LTTPR-transparent-mode, even in the cases where LTTPRs are detected on
> > the link: In transparent mode the DPRX PHY is link trained directly,
> > without link training the LTTPR PHYs first separately and so the source
> > must set the FFE parameters during the - single - DPRX link training
> > phase.
> >
> > During a non-transparent link training (i.e. on 8b10b links), the link
> > training signal parameters (i.e. vswing/pre-emph) are only set for the
> > first LTTPR PHY, directly downstream of the source, if LTTPRs are
> > detected on the link. Such LTTPR PHY link training phases are indicated
> > by phy being set to one of the DP_PHY_LTTPRx values as opposed to
> > DP_PHY_DPRX. At the moment, according to the above setting the source's
> > link training signal parameters are skipped whenever a PHY other than
> > DP_PHY_LTTPR1 is being link trained on a link with LTTPRs detected on
> > it. This is not correct during a transparent link training (i.e. on
> > 128b132b links), when the port is in the legacy or DP-alt mode (in the
> > TBT-alt mode the Thunderbolt subsytem owns and programs the source's
> > PHY).
> >
> > Please update the commit message according to the above lines.
> >
>
> Done, hope I didn't forget anything. Patch attached.
>
> > > With this change, the affected system completes four-lane UHBR20
> > > training, including channel equalization, interlane alignment and CDS.
> > >
> > > Fixes: 1fd440de4e02 ("drm/i915/dp_tunnel: Add UHBR tunneling support")
> >
> > The change is not limited to tunnel scenarios, rather to any case where
> > a 128b132b link (i.e. for any UHBR mode) is used in a legacy or DP-alt
> > TypeC port mode (i.e. not TBT-alt port mode), with LTTPRs detected on
> > the link. So the above Fixes: line is not correct, instead the patch
> > should be backported to a kernel version in which the 128b/132b (i.e.
> > UHBR support) in general was enabled.
>
> a421d8a99216d46926609611cdcf260fdf900645 seems to be the first commit of
> the current DP2.0 implementation. That is as old as 5.17.
>
> >
> > > Signed-off-by: Frederik Schwan <freswa@archlinux.org>
> > > Assisted-by: Codex:gpt-6
> > > ---
> > > The analysis and patch preparation were assisted by OpenAI Codex. The
> > > reporter performed the bisect and hardware tests.
> > >
> > >  drivers/gpu/drm/i915/display/intel_dp_link_training.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > > index cb92cff90614..92b8a8a1af3d 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > > @@ -1019,7 +1019,13 @@ void intel_dp_set_signal_levels(struct intel_dp *intel_dp,
> > >                    TRAIN_SET_PREEMPH_ARGS(intel_dp->train_set));
> > >     }
> > >
> > > -   if (intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
> > > +   /*
> > > +    * UHBR training uses intra-hop AUX replies at the DPRX address, even
> > > +    * with LTTPRs present. The requested FFE presets apply to the source
> > > +    * transmitter, unlike 8b/10b training of individual downstream PHYs.
> > > +    */
> > > +   if (intel_dp_is_uhbr(crtc_state) ||
> > > +       intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
> >
> > Introducing an is_transparent_mode() helper and adding that to
> > intel_dp_phy_is_downstream_of_source() would be better probably, but
> > that's a bigger change and should be left out from this fix.
> >
> > intel_dp_get_lane_adjust_tx_ffe_preset() should be fixed similarly to
> > the above.
> >
> > >             encoder->set_signal_levels(encoder, crtc_state);
> > >  }
> > >
> >
> > > i915 UHBR / Thunderbolt 5 regression investigation
> > > ================================================
> > >
> > > Provenance
> > > ----------
> > > Frederik Schwan performed the bisect, built and booted the test kernels,
> > > and supplied the hardware logs. OpenAI Codex, an AI coding assistant,
> > > analyzed those logs and the kernel source, identified the skipped source
> > > PHY callback, prepared the candidate fix, and ran the source-level checks.
> > > This report was prepared by Codex. Its interpretation is offered for
> > > maintainer review; the hardware results below come from the supplied logs.
> > >
> > > Setup and regression boundary
> > > -----------------------------
> > > Host: Lenovo 21Q8CTO1WW, BIOS N4EET24W (1.10), 2026-06-29.
> > > GPU: Intel Meteor Lake, i915, PCI ID 8086:7d51.
> > > Dock: ThinkPad Thunderbolt 5 Smart Dock 7500, connected over Thunderbolt 5.
> > > Display topology: dock MST hub feeding two DisplayPort 1.x displays.
> > > Affected upstream display link: DP-4 / DDI TC3, four lanes, one LTTPR.
> > > The GPU-side state dump shows tbt_mode: no: the physical source PHY is
> > > in use, rather than the integrated TBT alternate-mode PHY path.
> > >
> > > The bisect began with v7.2 good and v7.3 bad, restricted to
> > >   drivers/gpu/drm/i915/display
> > >   drivers/gpu/drm/display
> > >
> > > First bad:
> > >   1fd440de4e02efab97874bbda0a4daf59d228fa3
> > >   drm/i915/dp_tunnel: Add UHBR tunneling support
> > >
> > > Immediate parent tested good:
> > >   47fff2b1749e9ba5dfab7528960555cc865360b5
> > >   drm/i915/dp: Disable UHBR link configs with 1/2 lanes
> > >
> > > The final patched hardware capture identifies its kernel as
> > > 7.3.4-arch1-2, built 2026-11-13 20:51:44 UTC. NVIDIA modules are also
> > > loaded; the affected link and training messages in this report are i915.
> > >
> > > Failure and unsuccessful experiments
> > > ------------------------------------
> > > Before the source-FFE fix, four-lane UHBR20 training fails, including a
> > > retry, followed by UHBR10 failure. Representative six-byte link status:
> > >   UHBR20: 33 33 00 08 ee ee
> > >   UHBR10: 33 33 00 08 66 66
> > >
> > > The adjustment bytes request FFE preset 14 or 6, respectively, on all
> > > four lanes. Lane EQ bits are set but alignment is absent. The sink-status
> > > bit 0x08 is DP_INTRA_HOP_AUX_REPLY_INDICATION; these are intra-hop replies,
> > > not proof that the entire downstream path has finished training.
> > >
> > > Experiment 1 (dmesg.log): remove the legacy alignment-bit requirement
> > > from the UHBR lane-EQ helper, preserving it for active-link monitoring.
> > > Result: training advances to "Lane channel eq done" but then fails with
> > > "Interlane align timeout". This did not fix the problem.
> > >
> > > Experiment 2 (dmesg.log.1): restore the original helper and repeat the
> > > 0x2215 capability read after LTTPR initialization, logging tunnel caps.
> > > Result: coding=01 rates=03 before initialization, after initialization,
> > > and after the extra read; 0x2215 returns 00. UHBR20 and UHBR10 still fail
> > > with "Max loop count reached". This did not fix the problem either.
> > >
> > > Failed runs fall back to HBR3. Although HBR3 training passes, FEC-enable
> > > polling subsequently times out with status 0x04 or 0x00. The logs show
> > > 8b/10b coding selected and intra-hop mode clearing; there is no evidence
> > > that the driver simply leaves UHBR coding or intra-hop mode enabled.
> > > The cause of the fallback FEC failure has not been established.
> > >
> > > Source-level finding
> > > --------------------
> > > File: drivers/gpu/drm/i915/display/intel_dp_link_training.c
> > > Function: intel_dp_set_signal_levels()
> > >
> > > The existing code calls encoder->set_signal_levels() only if
> > > intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy) returns true.
> > > That helper accepts a link without repeaters or the source-adjacent
> > > LTTPR, DP_PHY_LTTPR(lttpr_count - 1).
> > >
> > > UHBR lane EQ calls the signal-level update path with DP_PHY_DPRX, even
> > > when repeaters are present, because it uses intra-hop AUX replies.
> > > Consequently, with one or more LTTPRs, the existing guard skips the
> > > source transmitter callback. The debug print precedes the guard, so
> > > "TX FFE presets: 14/14/14/14" does not establish that those presets
> > > were programmed into the GPU PHY. The AUX training-set writes still run.
> > >
> > > For this platform, the callback leads to intel_cx0_phy_set_signal_levels().
> > > The lane level is derived from train_set through intel_ddi_dp_level(),
> > > and the corresponding transmitter settings are written to the PHY.
> > > The integrated TBT alternate-mode path has its own early return there;
> > > that is not the path shown by this system's PHY state.
> > >
> > > Candidate fix
> > > -------------
> > > Allow the callback whenever intel_dp_is_uhbr(crtc_state) is true, retaining
> > > the existing per-PHY guard for 8b/10b:
> > >
> > >   if (intel_dp_is_uhbr(crtc_state) ||
> > >       intel_dp_phy_is_downstream_of_source(intel_dp, dp_phy))
> > >           encoder->set_signal_levels(encoder, crtc_state);
> > >
> > > Neither unsuccessful experimental change is included in this fix.
> > > The bisected commit enabled a path that exposes an older assumption;
> > > it did not introduce the original guard itself.
> > >
> > > Hardware evidence with the fix (dmesg.log.2)
> > > -------------------------------------------
> > > First successful sequence on DP-4:
> > >   20.224632  Lane channel eq done
> > >   20.271570  Interlane align done
> > >   20.297496  CDS interlane align done
> > >   20.297680  128b/132b Link Training passed at link rate = 2000000,
> > >              lane count = 4
> > >
> > > Second successful sequence on DP-4:
> > >   33.891635  Lane channel eq done
> > >   33.934586  Interlane align done
> > >   33.956537  CDS interlane align done
> > >   33.956747  128b/132b Link Training passed at link rate = 2000000,
> > >              lane count = 4
> > >
> > > The first sequence reaches status 77 77 8d 00 11 11 at CDS completion.
> > > There are no UHBR training failures, fallback attempts, or FEC-enable
> > > timeouts in this capture. Earlier Thunderbolt DPRX-read timeouts and
> > > unrelated NVIDIA messages do appear; this is not an error-free system log.
> > >
> > > The result strongly supports the skipped source FFE update as the cause
> > > of the reported UHBR training failure. It also demonstrates that the
> > > DP1.x monitors do not inherently prevent this upstream link training at
> > > UHBR20. It does not establish long-term display stability or validate
> > > UHBR-to-HBR3 fallback recovery, which was not exercised in this run.
> > >
> > > Validation performed by Codex
> > > -----------------------------
> > > - Built intel_dp_link_training.o using a configuration copied from the
> > >   running kernel and processed by olddefconfig.
> > > - git diff --check and scripts/checkpatch.pl passed for the code change.
> > > - A standalone harness extracted the source functions and mocked the
> > >   encoder callback. Before the change, all UHBR cases with 1-8 repeaters
> > >   missed the callback. Afterward, those cases passed, and tested 8b/10b
> > >   per-PHY callback behavior was unchanged. This is not a KUnit or hardware
> > >   test and does not validate electrical signal quality.
> > > - The code patch applies cleanly to the v7.3 version of the source file.
> > >
> > > Supporting material
> > > -------------------
> > > Primary attachments:
> > >   bisect.log
> > >   i915-uhbr-source-ffe.patch
> > >   v7.2-rc1-263-gb0b6d44646dc.log (known-good capture)
> > >   v7.2-rc1-268-g1fd440de4e02.log (first-bad capture)
> > >   patched.log (successful final candidate on 7.3.4)
> > >
> > > Optional experimental captures:
> > >   dmesg.log (lane-EQ helper experiment)
> > >   dmesg.log.1 (0x2215 refresh experiment)
> > >
> > > Logging parameters:
> > >   drm.debug=0x10e log_buf_len=32M thunderbolt.dyndbg=+p
> > >
> > > Retain full logs, preferably compressed, so reviewers can inspect the
> > > capability reads, AUX transactions, topology and ordering. The source
> > > filenames from the bisect should be interpreted together with the actual
> > > kernel banners and bisect.log.
