Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5888EC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E59310EB9D;
	Tue,  1 Sep 2026 07:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kVSuK7Kz";
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0365810E2C4
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:52:36 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-857ff9fef54so41130397b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788187955; cv=none;
 d=google.com; s=arc-20260327;
 b=l3cLjadv8sJdYHg0OV47yquwgbID0KLCnkCvoGRjsZfOj2DWRdOooFs5TINhM99K+2
 thHUQeODe69l87bNNexCH4a297BD1edLcIZvE7ob66wGKY9bYE7hK9/R5H7p+iBv3Kno
 uW5HDvnAYWmpvUyjNoqWDbr3lSvBzac+Dgw8cBr1Knnkub8VwNSTlO3a+k7eYYyZeAcZ
 85If/KTuEgE0zW79U02y/3aGzbp6yir9TtyH52ZwSmYf9tuIbdh7mEUHpwCUly5n/J2n
 NXYOxQonYSbZufXFeffS+z117dudQp0doM12jz2UNmV/AMuiHYji0LWWe3dZ+OaVMZ66
 vbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=47LXHtG5Iqznaxlrm/uIvRWiDRcVmWNGlzEfgcurp/o=;
 fh=P6t3ExyqQVaBMj8p5DwPz1SAkQoeBR7TJ1ztGOJykug=;
 b=NtxuQzbW68nh7sBlaJ8qwx+qpxslHftV7RdI8Ad5uYryIG4vd1KRTiXbznEOUiksVe
 c/AT85r7AjmFZIPHj6Rnn4CCls0JXZSVIjI0GFTfM8/t4DWBft+8L46M+ybCXa9njoCJ
 cf2RqK8biC+P3Hbz9dgmJLqaqVDldVx27yDF0hgEWnmXL8ziT8JMky6LvjWCM+OmapVZ
 fbbU/SvO8nkcZC238Rg0AE+vo1s67TqG9kaZMOspRbVvNee6Zyd6vnppC5kx2yrVGGqC
 jGQ7DU0Fqisg8a0c58xLoksOBawaDHG0IjJ2d2z9BMBbfSKi3uzemZRm86wKFONGMQ0a
 oKsA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788187955; x=1788792755; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=47LXHtG5Iqznaxlrm/uIvRWiDRcVmWNGlzEfgcurp/o=;
 b=kVSuK7KzZThAvcm2QF0ncaiarWUwHONtMTlBJ9MYMNF+KcyB0QCYG3nE0l6J3KwBtJ
 k5zEKMux9mENfMXJ9VckHFY0DZZsdhWlC3C1o3RwbCGnCZC8v02dRglRDjFXR8ZeAhSU
 tQEFX7VuWXPYnWhP9tEH5gL1VMh9GoOtG53ANi+/7cmEH3RRc9X56IJyBoq0GYxVHzrd
 JCazsAuSyaNwyxMpkIqiec1h6eh6ANP7eglaSnigG4AUBDB2Ouh117ywOMUIcJ8HDE77
 qd3URHX2EBSEgOFuqHJ1zOjPvGHsLtGwSRw7a/dPu8RrYTjB1vQo6DzzEQxc1iU9E+/v
 YIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788187955; x=1788792755;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=47LXHtG5Iqznaxlrm/uIvRWiDRcVmWNGlzEfgcurp/o=;
 b=YHoCB3AKiVE3KYRMI6BTd7am1+wH5puiNnwUKF6uHLUVKV7jirTY4bxL02LfY4t/LJ
 TcVihofDj9u/MsTN4PjGkRy48Of64hchliR578rdShcB5P+4zJNrNdqYm3jDxhgPF1GN
 fdHq2OnUbetiqocxBw7flH6mhdp6q8Z6NSfHcSMkRhBjO479F21IFTbw2fcKRREmiHhq
 J3B2lHLrsdmYI/kXr//55KSdKzrafLYYhPIZVmFG+XSejCbM26eVH+wNMzRrB9dwQEMz
 b3Ww1nVL/ajfCsxnUG1W6MrChLFJiEbFJ2DsUcGuZjKKik5pYw4HIDiWRTcWMyLkvt49
 aExw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsjfAgzEnkFEBlVWDIF3tZ6bcURalygJN+9fEu010xmf693aYr9Lp0bp1cgGOjA8lQhDP/eMWcpso=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mhhohbSlma9Yn2w6ZzaFv9Q69c/UZw1metInXkQkXFIhZd5e6N
 JqGYQRStd+J41puM3m+eRk4FWkMXygn8gc+mg7WBpew5O9QPttaztM2MBAlHwYEA/cmniSakMpp
 Bz7KS2fIeRzUk7JgjCLmYc6cm+Vm/kw==
X-Gm-Gg: AYBFou34cUJE8kazb1GZjymIg+I7YWXV8VPCCMT8kPgr1HyuL0/1UeoDVr+bi4VwmBT
 D3vNP7OEngbpaAGP+nsQHFMoUGhtGrj/jCCT2wKAycZ10a+cVO9Su3ymb+3hkUizGg5HnaVT91S
 7euXAy3Yw27paGbcP9o3gd3vYJG/h4cpZJBFubki3MK0NpMS80F+B1Xx7lxZWD4xl6alfWF1cSq
 yfYhgV/iVB7BEkia8DqDq49TUJYw/17iQrkV74Df1H5TSYMLQ6SAPTv5TVnhejCBHgTPEk3LLGL
 UZ9cZG8dIpuV1bNz0qGdsz+sWXjQAYIOxE/g7413Mk/Oz/zCFg+Rc0DORCsxqwTCTdAmG5r/TKK
 vcey5fZvQkvtoy5O5gCG3BB+lOw==
X-Received: by 2002:a05:690c:ec3:b0:81e:45a6:bd53 with SMTP id
 00721157ae682-85d69927a1amr105219957b3.8.1788187954310; Mon, 31 Aug 2026
 07:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260830161703.11570-1-iamedu@gmail.com>
 <c2603413d2af50854a620c5966149495b36dc851@intel.com>
In-Reply-To: <c2603413d2af50854a620c5966149495b36dc851@intel.com>
From: =?UTF-8?Q?Eduardo_D=C3=ADaz?= <iamedu@gmail.com>
Date: Mon, 31 Aug 2026 07:52:23 -0700
X-Gm-Features: AcwNN1Ve-OVeWcTmHiOOj8G_f_qu7GnHdkBKjeE2rkSO1tei2ZyCuRoZkjVkwOA
Message-ID: <CAH0s7rY7+ZDgxhA-6mUVLHT2msVzcXA=cOFPpmo0669qP2P1gQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/cdclk: Don't trust boot readout for per-pipe
 cdclk/voltage tracking
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000cef432065a58f3a4"
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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

--000000000000cef432065a58f3a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I filed a report here:
https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9074 debug logs
weren't enabled though.

I don't believe I've tried 1786d2688781 ("drm/i915/cdclk: Avoid spurious
cdclk
sanitization on PTL+"), will do so later today.

On Mon, Aug 31, 2026 at 12:39=E2=80=AFAM Jani Nikula <jani.nikula@linux.int=
el.com>
wrote:

> On Sun, 30 Aug 2026, Eduardo Diaz <iamedu@gmail.com> wrote:
> > On Panther Lake (xe3lpd) laptops, cold boot reliably corrupts the
> > internal eDP panel: pipe A gets a "Selective fetch area calculation
> > failed in pipe A" warning immediately followed by a CPU pipe A FIFO
> > underrun, and the panel stays corrupted for the rest of the session.
> > A subsequent suspend/resume cycle (or any other full re-modeset)
> > "fixes" it, which pointed at cdclk/voltage-level tracking rather than
> > a genuine hardware race.
> >
> > intel_modeset_readout_hw_state() runs once at driver probe (and again
> > on resume) to figure out what firmware/GOP left the display in. For
> > each already-active pipe it calls intel_cdclk_update_hw_state(),
> > which seeds cdclk_state->min_cdclk[]/min_voltage_level[] directly
> > from the freshly read-out crtc_state. That treats "firmware left this
> > pipe active with mode X" as proof that this driver's own cdclk,
> > voltage-level and DBUF setup for mode X is already established in
> > hardware. It isn't -- only firmware's own, entirely separate code
> > path has ever touched those registers.
> >
> > The OS driver's first real modeset for an inherited pipe typically
> > targets the same native panel mode, so the freshly computed
> > crtc_state->min_cdclk/min_voltage_level trivially match this
> > readout-seeded baseline. intel_cdclk_update_crtc_min_cdclk() and
> > intel_cdclk_update_crtc_min_voltage_level() then conclude nothing
> > changed and skip the recalculation, on the one commit where it
> > actually matters: taking a pipe from firmware ownership to being
> > correctly configured by this driver.
> >
> > Fix this in two parts:
> >
> >  - Invalidate the per-pipe min_cdclk[]/min_voltage_level[] tracking
> >    right after boot-time readout, so the first real atomic commit is
> >    guaranteed to see a difference.
> >
> >  - Stop early-returning in intel_cdclk_update_crtc_min_cdclk() and
> >    intel_cdclk_update_crtc_min_voltage_level() based on the crtc_state
> >    comparison alone. That comparison is unreliable for exactly the
> >    same reason (it's derived from the same readout), and skips the
> >    real, tracked-state check below it.
> >
> > Bisected on real hardware (Lenovo Yoga 9i 14IPH11, Panther Lake) down
> > to a narrow window between v6.19.10 (clean on every cold boot) and
> > v7.1.10 (broken on every cold boot); confirmed via live kernel
> > tracing that the skip path fires unconditionally on this platform
> > from the very first post-boot atomic commit onward. This fix
> > eliminates the FIFO underrun across many consecutive cold boots on
> > the same hardware, with no regression observed across suspend/resume.
>
> Do you have a regressing commit? Nearly 600 commits were merged to i915
> display alone between 6.19 and 7.1 so it's not really a narrow window.
>
> Have you filed a bug as described at [1]? With debugs, logs, and
> everything.
>
> Have you tried with 1786d2688781 ("drm/i915/cdclk: Avoid spurious cdclk
> sanitization on PTL+")?
>
>
> BR,
> Jani.
>
>
> [1]
> https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html
>
>
> > The investigation and this fix were developed with the assistance of
> > Claude (Anthropic), driven and verified end to end on the affected
> > hardware by the Signed-off-by below.
> >
> > Signed-off-by: Eduardo Diaz <iamedu@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_cdclk.c    | 45 ++++++++++++++-----
> >  drivers/gpu/drm/i915/display/intel_cdclk.h    |  1 +
> >  .../drm/i915/display/intel_modeset_setup.c    |  1 +
> >  3 files changed, 36 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c
> b/drivers/gpu/drm/i915/display/intel_cdclk.c
> > index a53d887271..209a2373d1 100644
> > --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
> > +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
> > @@ -2981,11 +2981,14 @@ static int
> intel_cdclk_update_crtc_min_cdclk(struct intel_atomic_state *state,
> >       bool allow_cdclk_decrease =3D intel_any_crtc_needs_modeset(state)=
;
> >       int ret;
> >
> > -     if (new_min_cdclk =3D=3D old_min_cdclk)
> > -             return 0;
> > -
> > -     if (!allow_cdclk_decrease && new_min_cdclk < old_min_cdclk)
> > -             return 0;
> > +     /*
> > +      * old_min_cdclk comes from the previous crtc_state, which after
> > +      * boot-time readout reflects whatever firmware/GOP left running,
> > +      * not what this driver has programmed. For an inherited pipe it
> > +      * equals new_min_cdclk by construction (same mode, same formula)=
,
> > +      * so an early return here would skip the recalculation that
> > +      * matters. Always continue on to the cdclk_state check below.
> > +      */
> >
> >       cdclk_state =3D intel_atomic_get_cdclk_state(state);
> >       if (IS_ERR(cdclk_state))
> > @@ -3026,12 +3029,10 @@ static int
> intel_cdclk_update_crtc_min_voltage_level(struct intel_atomic_state *
> >       bool allow_voltage_level_decrease =3D
> intel_any_crtc_needs_modeset(state);
> >       int ret;
> >
> > -     if (new_min_voltage_level =3D=3D old_min_voltage_level)
> > -             return 0;
> > -
> > -     if (!allow_voltage_level_decrease &&
> > -         new_min_voltage_level < old_min_voltage_level)
> > -             return 0;
> > +     /*
> > +      * old_min_voltage_level is unreliable for the same reason; see
> > +      * intel_cdclk_update_crtc_min_cdclk().
> > +      */
> >
> >       cdclk_state =3D intel_atomic_get_cdclk_state(state);
> >       if (IS_ERR(cdclk_state))
> > @@ -3705,6 +3706,28 @@ void intel_cdclk_update_hw_state(struct
> intel_display *display)
> >       cdclk_state->dbuf_bw_min_cdclk =3D intel_dbuf_bw_min_cdclk(displa=
y,
> dbuf_bw_state);
> >  }
> >
> > +/*
> > + * intel_cdclk_update_hw_state() seeds min_cdclk[]/min_voltage_level[]
> > + * from readout's crtc_state, i.e. from whatever firmware/GOP left
> > + * running, not from anything this driver has programmed. A pipe's
> > + * first real modeset usually targets the same native mode, so the
> > + * freshly computed value matches this seeded baseline and
> > + * intel_cdclk_update_crtc_min_cdclk()/_min_voltage_level() conclude
> > + * nothing changed, skipping the recalculation that matters. Call
> > + * this after readout so the first real commit sees a difference.
> > + */
> > +void intel_cdclk_invalidate_min_tracking(struct intel_display *display=
)
> > +{
> > +     struct intel_cdclk_state *cdclk_state =3D
> > +             to_intel_cdclk_state(display->cdclk.obj.state);
> > +     enum pipe pipe;
> > +
> > +     for_each_pipe(display, pipe) {
> > +             cdclk_state->min_cdclk[pipe] =3D 0;
> > +             cdclk_state->min_voltage_level[pipe] =3D 0;
> > +     }
> > +}
> > +
> >  void intel_cdclk_crtc_disable_noatomic(struct intel_crtc *crtc)
> >  {
> >       struct intel_display *display =3D to_intel_display(crtc);
> > diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.h
> b/drivers/gpu/drm/i915/display/intel_cdclk.h
> > index a60cbf745e..1517d3605a 100644
> > --- a/drivers/gpu/drm/i915/display/intel_cdclk.h
> > +++ b/drivers/gpu/drm/i915/display/intel_cdclk.h
> > @@ -46,6 +46,7 @@ int intel_cdclk_state_set_joined_mbus(struct
> intel_atomic_state *state, bool joi
> >  struct intel_cdclk_state *
> >  intel_atomic_get_cdclk_state(struct intel_atomic_state *state);
> >  void intel_cdclk_update_hw_state(struct intel_display *display);
> > +void intel_cdclk_invalidate_min_tracking(struct intel_display *display=
);
> >  void intel_cdclk_crtc_disable_noatomic(struct intel_crtc *crtc);
> >  int intel_cdclk_update_dbuf_bw_min_cdclk(struct intel_atomic_state
> *state,
> >                                        int old_min_cdclk, int
> new_min_cdclk,
> > diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> > index 6aed881737..c7be6e63e7 100644
> > --- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> > +++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
> > @@ -880,6 +880,7 @@ static void intel_modeset_readout_hw_state(struct
> intel_display *display)
> >       intel_bw_update_hw_state(display);
> >       intel_dbuf_bw_update_hw_state(display);
> >       intel_cdclk_update_hw_state(display);
> > +     intel_cdclk_invalidate_min_tracking(display);
> >
> >       intel_pmdemand_init_pmdemand_params(display, pmdemand_state);
> >  }
>
> --
> Jani Nikula, Intel
>

--000000000000cef432065a58f3a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I filed a report here:=C2=A0<a href=3D"https://gitlab=
.freedesktop.org/drm/xe/kernel/-/work_items/9074">https://gitlab.freedeskto=
p.org/drm/xe/kernel/-/work_items/9074</a> debug logs weren&#39;t enabled th=
ough.<br><br>I don&#39;t believe I&#39;ve tried=C2=A0<span style=3D"backgro=
und-color:transparent">1786d2688781 (&quot;drm/i915/cdclk: Avoid spurious c=
dclk</span></div>sanitization on PTL+&quot;), will do so later today.<br></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Mon, Aug 31, 2026 at 12:39=E2=80=AFAM Jani Nikula &l=
t;<a href=3D"mailto:jani.nikula@linux.intel.com">jani.nikula@linux.intel.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>On Sun, 30 Aug 2026, Eduardo Diaz &lt;<a href=3D"mailto:iamedu@gmail.com" =
target=3D"_blank">iamedu@gmail.com</a>&gt; wrote:<br>
&gt; On Panther Lake (xe3lpd) laptops, cold boot reliably corrupts the<br>
&gt; internal eDP panel: pipe A gets a &quot;Selective fetch area calculati=
on<br>
&gt; failed in pipe A&quot; warning immediately followed by a CPU pipe A FI=
FO<br>
&gt; underrun, and the panel stays corrupted for the rest of the session.<b=
r>
&gt; A subsequent suspend/resume cycle (or any other full re-modeset)<br>
&gt; &quot;fixes&quot; it, which pointed at cdclk/voltage-level tracking ra=
ther than<br>
&gt; a genuine hardware race.<br>
&gt;<br>
&gt; intel_modeset_readout_hw_state() runs once at driver probe (and again<=
br>
&gt; on resume) to figure out what firmware/GOP left the display in. For<br=
>
&gt; each already-active pipe it calls intel_cdclk_update_hw_state(),<br>
&gt; which seeds cdclk_state-&gt;min_cdclk[]/min_voltage_level[] directly<b=
r>
&gt; from the freshly read-out crtc_state. That treats &quot;firmware left =
this<br>
&gt; pipe active with mode X&quot; as proof that this driver&#39;s own cdcl=
k,<br>
&gt; voltage-level and DBUF setup for mode X is already established in<br>
&gt; hardware. It isn&#39;t -- only firmware&#39;s own, entirely separate c=
ode<br>
&gt; path has ever touched those registers.<br>
&gt;<br>
&gt; The OS driver&#39;s first real modeset for an inherited pipe typically=
<br>
&gt; targets the same native panel mode, so the freshly computed<br>
&gt; crtc_state-&gt;min_cdclk/min_voltage_level trivially match this<br>
&gt; readout-seeded baseline. intel_cdclk_update_crtc_min_cdclk() and<br>
&gt; intel_cdclk_update_crtc_min_voltage_level() then conclude nothing<br>
&gt; changed and skip the recalculation, on the one commit where it<br>
&gt; actually matters: taking a pipe from firmware ownership to being<br>
&gt; correctly configured by this driver.<br>
&gt;<br>
&gt; Fix this in two parts:<br>
&gt;<br>
&gt;=C2=A0 - Invalidate the per-pipe min_cdclk[]/min_voltage_level[] tracki=
ng<br>
&gt;=C2=A0 =C2=A0 right after boot-time readout, so the first real atomic c=
ommit is<br>
&gt;=C2=A0 =C2=A0 guaranteed to see a difference.<br>
&gt;<br>
&gt;=C2=A0 - Stop early-returning in intel_cdclk_update_crtc_min_cdclk() an=
d<br>
&gt;=C2=A0 =C2=A0 intel_cdclk_update_crtc_min_voltage_level() based on the =
crtc_state<br>
&gt;=C2=A0 =C2=A0 comparison alone. That comparison is unreliable for exact=
ly the<br>
&gt;=C2=A0 =C2=A0 same reason (it&#39;s derived from the same readout), and=
 skips the<br>
&gt;=C2=A0 =C2=A0 real, tracked-state check below it.<br>
&gt;<br>
&gt; Bisected on real hardware (Lenovo Yoga 9i 14IPH11, Panther Lake) down<=
br>
&gt; to a narrow window between v6.19.10 (clean on every cold boot) and<br>
&gt; v7.1.10 (broken on every cold boot); confirmed via live kernel<br>
&gt; tracing that the skip path fires unconditionally on this platform<br>
&gt; from the very first post-boot atomic commit onward. This fix<br>
&gt; eliminates the FIFO underrun across many consecutive cold boots on<br>
&gt; the same hardware, with no regression observed across suspend/resume.<=
br>
<br>
Do you have a regressing commit? Nearly 600 commits were merged to i915<br>
display alone between 6.19 and 7.1 so it&#39;s not really a narrow window.<=
br>
<br>
Have you filed a bug as described at [1]? With debugs, logs, and<br>
everything.<br>
<br>
Have you tried with 1786d2688781 (&quot;drm/i915/cdclk: Avoid spurious cdcl=
k<br>
sanitization on PTL+&quot;)?<br>
<br>
<br>
BR,<br>
Jani.<br>
<br>
<br>
[1] <a href=3D"https://drm.pages.freedesktop.org/intel-docs/how-to-file-i91=
5-bugs.html" rel=3D"noreferrer" target=3D"_blank">https://drm.pages.freedes=
ktop.org/intel-docs/how-to-file-i915-bugs.html</a><br>
<br>
<br>
&gt; The investigation and this fix were developed with the assistance of<b=
r>
&gt; Claude (Anthropic), driven and verified end to end on the affected<br>
&gt; hardware by the Signed-off-by below.<br>
&gt;<br>
&gt; Signed-off-by: Eduardo Diaz &lt;<a href=3D"mailto:iamedu@gmail.com" ta=
rget=3D"_blank">iamedu@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/i915/display/intel_cdclk.c=C2=A0 =C2=A0 | 45 +++=
+++++++++++-----<br>
&gt;=C2=A0 drivers/gpu/drm/i915/display/intel_cdclk.h=C2=A0 =C2=A0 |=C2=A0 =
1 +<br>
&gt;=C2=A0 .../drm/i915/display/intel_modeset_setup.c=C2=A0 =C2=A0 |=C2=A0 =
1 +<br>
&gt;=C2=A0 3 files changed, 36 insertions(+), 11 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/=
drm/i915/display/intel_cdclk.c<br>
&gt; index a53d887271..209a2373d1 100644<br>
&gt; --- a/drivers/gpu/drm/i915/display/intel_cdclk.c<br>
&gt; +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c<br>
&gt; @@ -2981,11 +2981,14 @@ static int intel_cdclk_update_crtc_min_cdclk(s=
truct intel_atomic_state *state,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool allow_cdclk_decrease =3D intel_any_crtc=
_needs_modeset(state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (new_min_cdclk =3D=3D old_min_cdclk)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!allow_cdclk_decrease &amp;&amp; new_min_cdcl=
k &lt; old_min_cdclk)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * old_min_cdclk comes from the previous crtc_sta=
te, which after<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * boot-time readout reflects whatever firmware/G=
OP left running,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * not what this driver has programmed. For an in=
herited pipe it<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * equals new_min_cdclk by construction (same mod=
e, same formula),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * so an early return here would skip the recalcu=
lation that<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * matters. Always continue on to the cdclk_state=
 check below.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cdclk_state =3D intel_atomic_get_cdclk_state=
(state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(cdclk_state))<br>
&gt; @@ -3026,12 +3029,10 @@ static int intel_cdclk_update_crtc_min_voltage=
_level(struct intel_atomic_state *<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool allow_voltage_level_decrease =3D intel_=
any_crtc_needs_modeset(state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (new_min_voltage_level =3D=3D old_min_voltage_=
level)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!allow_voltage_level_decrease &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_min_voltage_level &lt; old_min_=
voltage_level)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * old_min_voltage_level is unreliable for the sa=
me reason; see<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * intel_cdclk_update_crtc_min_cdclk().<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cdclk_state =3D intel_atomic_get_cdclk_state=
(state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(cdclk_state))<br>
&gt; @@ -3705,6 +3706,28 @@ void intel_cdclk_update_hw_state(struct intel_d=
isplay *display)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cdclk_state-&gt;dbuf_bw_min_cdclk =3D intel_=
dbuf_bw_min_cdclk(display, dbuf_bw_state);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +/*<br>
&gt; + * intel_cdclk_update_hw_state() seeds min_cdclk[]/min_voltage_level[=
]<br>
&gt; + * from readout&#39;s crtc_state, i.e. from whatever firmware/GOP lef=
t<br>
&gt; + * running, not from anything this driver has programmed. A pipe&#39;=
s<br>
&gt; + * first real modeset usually targets the same native mode, so the<br=
>
&gt; + * freshly computed value matches this seeded baseline and<br>
&gt; + * intel_cdclk_update_crtc_min_cdclk()/_min_voltage_level() conclude<=
br>
&gt; + * nothing changed, skipping the recalculation that matters. Call<br>
&gt; + * this after readout so the first real commit sees a difference.<br>
&gt; + */<br>
&gt; +void intel_cdclk_invalidate_min_tracking(struct intel_display *displa=
y)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct intel_cdclk_state *cdclk_state =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to_intel_cdclk_state(=
display-&gt;cdclk.obj.state);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0enum pipe pipe;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for_each_pipe(display, pipe) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cdclk_state-&gt;min_c=
dclk[pipe] =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cdclk_state-&gt;min_v=
oltage_level[pipe] =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 void intel_cdclk_crtc_disable_noatomic(struct intel_crtc *crtc)<=
br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct intel_display *display =3D to_intel_d=
isplay(crtc);<br>
&gt; diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.h b/drivers/gpu/=
drm/i915/display/intel_cdclk.h<br>
&gt; index a60cbf745e..1517d3605a 100644<br>
&gt; --- a/drivers/gpu/drm/i915/display/intel_cdclk.h<br>
&gt; +++ b/drivers/gpu/drm/i915/display/intel_cdclk.h<br>
&gt; @@ -46,6 +46,7 @@ int intel_cdclk_state_set_joined_mbus(struct intel_a=
tomic_state *state, bool joi<br>
&gt;=C2=A0 struct intel_cdclk_state *<br>
&gt;=C2=A0 intel_atomic_get_cdclk_state(struct intel_atomic_state *state);<=
br>
&gt;=C2=A0 void intel_cdclk_update_hw_state(struct intel_display *display);=
<br>
&gt; +void intel_cdclk_invalidate_min_tracking(struct intel_display *displa=
y);<br>
&gt;=C2=A0 void intel_cdclk_crtc_disable_noatomic(struct intel_crtc *crtc);=
<br>
&gt;=C2=A0 int intel_cdclk_update_dbuf_bw_min_cdclk(struct intel_atomic_sta=
te *state,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int o=
ld_min_cdclk, int new_min_cdclk,<br>
&gt; diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c b/driv=
ers/gpu/drm/i915/display/intel_modeset_setup.c<br>
&gt; index 6aed881737..c7be6e63e7 100644<br>
&gt; --- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c<br>
&gt; +++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c<br>
&gt; @@ -880,6 +880,7 @@ static void intel_modeset_readout_hw_state(struct =
intel_display *display)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0intel_bw_update_hw_state(display);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0intel_dbuf_bw_update_hw_state(display);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0intel_cdclk_update_hw_state(display);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0intel_cdclk_invalidate_min_tracking(display);<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0intel_pmdemand_init_pmdemand_params(display,=
 pmdemand_state);<br>
&gt;=C2=A0 }<br>
<br>
-- <br>
Jani Nikula, Intel<br>
</blockquote></div>

--000000000000cef432065a58f3a4--
