Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A435FC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDAF410F40A;
	Thu,  3 Sep 2026 07:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DRRPwrza";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 623EA10E35E
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 23:48:23 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-66f79f58123so509475d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 16:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788306502; cv=none;
 d=google.com; s=arc-20260327;
 b=EjEU2BEVHzlm/b4FIRNeDu9tDx40zG9ma7v17eaRLgNvAVb/S0SC3t/OPihCYaTlpD
 QfU+vE6SaHFmL0r3E0PVM6vtBfBUG2LdSHkHlyiRY3S76ZsQu/5aUIIc8xF6EE4BRIe8
 sTuy45nsWXgYg+UvU7NcQjwx2xNh68bL8tg+WdzKzyJbcfgjvZ4BQVoLZIflAfwLLqWG
 uX77l+CouGR0TCaFanlVxqO0lzbiPTXQCjuwentV+RkB83FD+mxwgUYDKJ9kpRS7pXzE
 lMrOvEw1meRGpuFpq5ahFNiZXSPCpGaZ2Yb5BE4dVF617JKjOh0w+EqzXLcf7BMqKfRm
 mwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6rj1WG5w9092EDpKl9YtsCKqmoFQ4+iBJFF22wWoC/U=;
 fh=sfdUxdIbKPol/uCuGkYNTFdd9pqa4cHxAxQ3BiNc9X4=;
 b=JUzikBMODj8Dwf83yfBIiD/FJqPsNjqnE/xz+CyR2Pu5LmvGKghzJc6C0CYFOULPQ1
 pKppsB5x8xIKeaVJQe6h3IZaHBm8T6PCSB909tr6HEwV2mH3V8Ko61av0R6I198NK/MV
 ktUR/qUjHOEXZpn/r57yG8OH4pqfZf3s4octdMbDoEUHnW1sx+AD8mD6IpSJMFGMYEaB
 WbCxF2hmU0D+X/2dxqdH7TbYvYbw+50n2tOoe/9aeujl5R6pLPaCOGH4fBlIRnicm8dB
 jdiJf6kTR2/1MnSxzZGFjRS690wCXwSHb+y+eoCcm256lUp0zEo6Aj3yQbrL834AqL3f
 BiGA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788306502; x=1788911302; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6rj1WG5w9092EDpKl9YtsCKqmoFQ4+iBJFF22wWoC/U=;
 b=DRRPwrza+awvV16lip220Pu1khx2W65APh+u5+GGJ0sRG1Fzg9zRUqH0ybsiUQ/5s3
 LFdwIfEasRrOCPMLVzX44685pgj4qKBJLp2vUcv2+nGJOHmu1NLJP2O98Y0tSiLVkmLY
 UPt9laV4IYj3wamYcUhKt0UgR147nYQMdyu0zOkaa9hxifYAI/3H2eHXAKjthw8C/IVU
 BsYxZb+Rs1VZX+xx0Ikcv4mC/gEq3z9fZxXFGPMk26IelhWBVBPSrEdMsZOSsM4dA/6z
 5NrWN7l2N0plmNYgw2nRv7+DLHKJjaRyZcpyHwJhWs81gKqmnqIW8nJEbwJRYUjosm2E
 /llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788306502; x=1788911302;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6rj1WG5w9092EDpKl9YtsCKqmoFQ4+iBJFF22wWoC/U=;
 b=e9Hm8dDucapMz05+I4Sm4CEAvdeFPiV+DvNm70Tl7+X8Rr6Ce43xdNZz0W8EIPZpjj
 UBbcfTa9H1fPg6yV76ZMmupHC0xMihmkIt2NLIEfWeFmnQzcnXNSQCmMahpP6XOFG6EF
 2n4fkxHolW0C2xIlW75Bhns7YUCOdjqd4daCZOM5/g6Bg6RJ298oHS64ed/39v8J4dyf
 ht0thTUApeB/8bt5qMnK8zXCliWlsTiX0j7osxlQ3mMSgs482MSjZSE+Ts+14KjDgWiP
 vd/7E85U3X6CDZ73/B5scPir19PZeCUxhCc6smKVUHLzxn11Xyz5EyUt8LhM0kmaJo/m
 V/Ww==
X-Forwarded-Encrypted: i=1;
 AKwUvBygc/nXJwyYiXtEX+uSfAz+Xbc2h1TjCDOqswseMOclfmeo7xAedDhn4XQ5bZwDDhbgKzpmWy/l0dQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lJj+waKDQdJ6duY8OJ3rJHRZzDs+AXoTjqul8iEWMCLY7JZFUc
 eaJBQYohVTKSD4fqztX5n6oGLTC0DqeS3KHbmFaJj689U58hJ5/mSY5Sa/vM3OK+RJB1r6NtXec
 p6BbWIXvNhL8g4sbfEvp/Uvi+qxERWw==
X-Gm-Gg: AYBFou13+fGBDSiy2dDuoTTO3bwDr24IqWrrg34JGpq7WC5YIXGiF7RnuEnLMfIVUBj
 ehOeR7rzG9aVLBzpTUtZ4baVEoatb95XcHBE9Ce0pu9qYWgrBp/QNhTvKfE+h2keU+RQN8GL/jn
 57q3NJ6kgdjlDV9XOEADFdre4H9Ux319TQdn9Z0/0X6FKWdfRSdglNWra7QS5kS2HqU2NeMHBD5
 R/90A7WgL80BY27sGvuCBeBwcLl/AzmmZolp8YhcZxucweT1W1QnlPSd18nlArOTMcbRBfRlX+L
 aT/mtiE4Hlrs/EwLTgghF5ISn0pJeq8XWraE8+6MZedPOzJrovabfp/9Kg+KlVqizwZJFjMqNvT
 m/iZfdmzudGloP1alHy3JXMNr4A==
X-Received: by 2002:a05:690e:13c7:b0:668:9ea4:774b with SMTP id
 956f58d0204a3-66f9bc25746mr273094d50.41.1788306501919; Tue, 01 Sep 2026
 16:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260830161703.11570-1-iamedu@gmail.com>
 <c2603413d2af50854a620c5966149495b36dc851@intel.com>
 <CAH0s7rY7+ZDgxhA-6mUVLHT2msVzcXA=cOFPpmo0669qP2P1gQ@mail.gmail.com>
In-Reply-To: <CAH0s7rY7+ZDgxhA-6mUVLHT2msVzcXA=cOFPpmo0669qP2P1gQ@mail.gmail.com>
From: =?UTF-8?Q?Eduardo_D=C3=ADaz?= <iamedu@gmail.com>
Date: Tue, 1 Sep 2026 16:48:10 -0700
X-Gm-Features: AcwNN1U0ERtU-8B0FPZfMu8nQ8QV92-HLhAAyhy6XWidRBwI8hhEyf8QxXXdOzk
Message-ID: <CAH0s7rY=eWPHAB+w+NF64T5WR3L5hpVEHCxzqVjrnaroojE6zQ@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000cbe8be065a748d17"
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

--000000000000cbe8be065a748d17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, confirmed. That patch fixes the issue

Thanks!



On Mon, Aug 31, 2026 at 7:52=E2=80=AFAM Eduardo D=C3=ADaz <iamedu@gmail.com=
> wrote:

> I filed a report here:
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9074 debug logs
> weren't enabled though.
>
> I don't believe I've tried 1786d2688781 ("drm/i915/cdclk: Avoid spurious
> cdclk
> sanitization on PTL+"), will do so later today.
>
> On Mon, Aug 31, 2026 at 12:39=E2=80=AFAM Jani Nikula <jani.nikula@linux.i=
ntel.com>
> wrote:
>
>> On Sun, 30 Aug 2026, Eduardo Diaz <iamedu@gmail.com> wrote:
>> > On Panther Lake (xe3lpd) laptops, cold boot reliably corrupts the
>> > internal eDP panel: pipe A gets a "Selective fetch area calculation
>> > failed in pipe A" warning immediately followed by a CPU pipe A FIFO
>> > underrun, and the panel stays corrupted for the rest of the session.
>> > A subsequent suspend/resume cycle (or any other full re-modeset)
>> > "fixes" it, which pointed at cdclk/voltage-level tracking rather than
>> > a genuine hardware race.
>> >
>> > intel_modeset_readout_hw_state() runs once at driver probe (and again
>> > on resume) to figure out what firmware/GOP left the display in. For
>> > each already-active pipe it calls intel_cdclk_update_hw_state(),
>> > which seeds cdclk_state->min_cdclk[]/min_voltage_level[] directly
>> > from the freshly read-out crtc_state. That treats "firmware left this
>> > pipe active with mode X" as proof that this driver's own cdclk,
>> > voltage-level and DBUF setup for mode X is already established in
>> > hardware. It isn't -- only firmware's own, entirely separate code
>> > path has ever touched those registers.
>> >
>> > The OS driver's first real modeset for an inherited pipe typically
>> > targets the same native panel mode, so the freshly computed
>> > crtc_state->min_cdclk/min_voltage_level trivially match this
>> > readout-seeded baseline. intel_cdclk_update_crtc_min_cdclk() and
>> > intel_cdclk_update_crtc_min_voltage_level() then conclude nothing
>> > changed and skip the recalculation, on the one commit where it
>> > actually matters: taking a pipe from firmware ownership to being
>> > correctly configured by this driver.
>> >
>> > Fix this in two parts:
>> >
>> >  - Invalidate the per-pipe min_cdclk[]/min_voltage_level[] tracking
>> >    right after boot-time readout, so the first real atomic commit is
>> >    guaranteed to see a difference.
>> >
>> >  - Stop early-returning in intel_cdclk_update_crtc_min_cdclk() and
>> >    intel_cdclk_update_crtc_min_voltage_level() based on the crtc_state
>> >    comparison alone. That comparison is unreliable for exactly the
>> >    same reason (it's derived from the same readout), and skips the
>> >    real, tracked-state check below it.
>> >
>> > Bisected on real hardware (Lenovo Yoga 9i 14IPH11, Panther Lake) down
>> > to a narrow window between v6.19.10 (clean on every cold boot) and
>> > v7.1.10 (broken on every cold boot); confirmed via live kernel
>> > tracing that the skip path fires unconditionally on this platform
>> > from the very first post-boot atomic commit onward. This fix
>> > eliminates the FIFO underrun across many consecutive cold boots on
>> > the same hardware, with no regression observed across suspend/resume.
>>
>> Do you have a regressing commit? Nearly 600 commits were merged to i915
>> display alone between 6.19 and 7.1 so it's not really a narrow window.
>>
>> Have you filed a bug as described at [1]? With debugs, logs, and
>> everything.
>>
>> Have you tried with 1786d2688781 ("drm/i915/cdclk: Avoid spurious cdclk
>> sanitization on PTL+")?
>>
>>
>> BR,
>> Jani.
>>
>>
>> [1]
>> https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html
>>
>>
>> > The investigation and this fix were developed with the assistance of
>> > Claude (Anthropic), driven and verified end to end on the affected
>> > hardware by the Signed-off-by below.
>> >
>> > Signed-off-by: Eduardo Diaz <iamedu@gmail.com>
>> > ---
>> >  drivers/gpu/drm/i915/display/intel_cdclk.c    | 45 ++++++++++++++----=
-
>> >  drivers/gpu/drm/i915/display/intel_cdclk.h    |  1 +
>> >  .../drm/i915/display/intel_modeset_setup.c    |  1 +
>> >  3 files changed, 36 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c
>> b/drivers/gpu/drm/i915/display/intel_cdclk.c
>> > index a53d887271..209a2373d1 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
>> > +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
>> > @@ -2981,11 +2981,14 @@ static int
>> intel_cdclk_update_crtc_min_cdclk(struct intel_atomic_state *state,
>> >       bool allow_cdclk_decrease =3D intel_any_crtc_needs_modeset(state=
);
>> >       int ret;
>> >
>> > -     if (new_min_cdclk =3D=3D old_min_cdclk)
>> > -             return 0;
>> > -
>> > -     if (!allow_cdclk_decrease && new_min_cdclk < old_min_cdclk)
>> > -             return 0;
>> > +     /*
>> > +      * old_min_cdclk comes from the previous crtc_state, which after
>> > +      * boot-time readout reflects whatever firmware/GOP left running=
,
>> > +      * not what this driver has programmed. For an inherited pipe it
>> > +      * equals new_min_cdclk by construction (same mode, same formula=
),
>> > +      * so an early return here would skip the recalculation that
>> > +      * matters. Always continue on to the cdclk_state check below.
>> > +      */
>> >
>> >       cdclk_state =3D intel_atomic_get_cdclk_state(state);
>> >       if (IS_ERR(cdclk_state))
>> > @@ -3026,12 +3029,10 @@ static int
>> intel_cdclk_update_crtc_min_voltage_level(struct intel_atomic_state *
>> >       bool allow_voltage_level_decrease =3D
>> intel_any_crtc_needs_modeset(state);
>> >       int ret;
>> >
>> > -     if (new_min_voltage_level =3D=3D old_min_voltage_level)
>> > -             return 0;
>> > -
>> > -     if (!allow_voltage_level_decrease &&
>> > -         new_min_voltage_level < old_min_voltage_level)
>> > -             return 0;
>> > +     /*
>> > +      * old_min_voltage_level is unreliable for the same reason; see
>> > +      * intel_cdclk_update_crtc_min_cdclk().
>> > +      */
>> >
>> >       cdclk_state =3D intel_atomic_get_cdclk_state(state);
>> >       if (IS_ERR(cdclk_state))
>> > @@ -3705,6 +3706,28 @@ void intel_cdclk_update_hw_state(struct
>> intel_display *display)
>> >       cdclk_state->dbuf_bw_min_cdclk =3D intel_dbuf_bw_min_cdclk(displ=
ay,
>> dbuf_bw_state);
>> >  }
>> >
>> > +/*
>> > + * intel_cdclk_update_hw_state() seeds min_cdclk[]/min_voltage_level[=
]
>> > + * from readout's crtc_state, i.e. from whatever firmware/GOP left
>> > + * running, not from anything this driver has programmed. A pipe's
>> > + * first real modeset usually targets the same native mode, so the
>> > + * freshly computed value matches this seeded baseline and
>> > + * intel_cdclk_update_crtc_min_cdclk()/_min_voltage_level() conclude
>> > + * nothing changed, skipping the recalculation that matters. Call
>> > + * this after readout so the first real commit sees a difference.
>> > + */
>> > +void intel_cdclk_invalidate_min_tracking(struct intel_display *displa=
y)
>> > +{
>> > +     struct intel_cdclk_state *cdclk_state =3D
>> > +             to_intel_cdclk_state(display->cdclk.obj.state);
>> > +     enum pipe pipe;
>> > +
>> > +     for_each_pipe(display, pipe) {
>> > +             cdclk_state->min_cdclk[pipe] =3D 0;
>> > +             cdclk_state->min_voltage_level[pipe] =3D 0;
>> > +     }
>> > +}
>> > +
>> >  void intel_cdclk_crtc_disable_noatomic(struct intel_crtc *crtc)
>> >  {
>> >       struct intel_display *display =3D to_intel_display(crtc);
>> > diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.h
>> b/drivers/gpu/drm/i915/display/intel_cdclk.h
>> > index a60cbf745e..1517d3605a 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_cdclk.h
>> > +++ b/drivers/gpu/drm/i915/display/intel_cdclk.h
>> > @@ -46,6 +46,7 @@ int intel_cdclk_state_set_joined_mbus(struct
>> intel_atomic_state *state, bool joi
>> >  struct intel_cdclk_state *
>> >  intel_atomic_get_cdclk_state(struct intel_atomic_state *state);
>> >  void intel_cdclk_update_hw_state(struct intel_display *display);
>> > +void intel_cdclk_invalidate_min_tracking(struct intel_display
>> *display);
>> >  void intel_cdclk_crtc_disable_noatomic(struct intel_crtc *crtc);
>> >  int intel_cdclk_update_dbuf_bw_min_cdclk(struct intel_atomic_state
>> *state,
>> >                                        int old_min_cdclk, int
>> new_min_cdclk,
>> > diff --git a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
>> b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
>> > index 6aed881737..c7be6e63e7 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_modeset_setup.c
>> > +++ b/drivers/gpu/drm/i915/display/intel_modeset_setup.c
>> > @@ -880,6 +880,7 @@ static void intel_modeset_readout_hw_state(struct
>> intel_display *display)
>> >       intel_bw_update_hw_state(display);
>> >       intel_dbuf_bw_update_hw_state(display);
>> >       intel_cdclk_update_hw_state(display);
>> > +     intel_cdclk_invalidate_min_tracking(display);
>> >
>> >       intel_pmdemand_init_pmdemand_params(display, pmdemand_state);
>> >  }
>>
>> --
>> Jani Nikula, Intel
>>
>

--000000000000cbe8be065a748d17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">OK=
, confirmed. That patch fixes the issue<br><br></div><div dir=3D"ltr">Thank=
s!<div><br></div></div></div></div><br></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 31=
, 2026 at 7:52=E2=80=AFAM Eduardo D=C3=ADaz &lt;<a href=3D"mailto:iamedu@gm=
ail.com">iamedu@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div>I filed a report here:=C2=A0=
<a href=3D"https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9074" =
target=3D"_blank">https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items=
/9074</a> debug logs weren&#39;t enabled though.<br><br>I don&#39;t believe=
 I&#39;ve tried=C2=A0<span style=3D"background-color:transparent">1786d2688=
781 (&quot;drm/i915/cdclk: Avoid spurious cdclk</span></div>sanitization on=
 PTL+&quot;), will do so later today.<br></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 31, 2026 at 12:39=E2=
=80=AFAM Jani Nikula &lt;<a href=3D"mailto:jani.nikula@linux.intel.com" tar=
get=3D"_blank">jani.nikula@linux.intel.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">On Sun, 30 Aug 2026, Eduardo Diaz=
 &lt;<a href=3D"mailto:iamedu@gmail.com" target=3D"_blank">iamedu@gmail.com=
</a>&gt; wrote:<br>
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
</blockquote></div>

--000000000000cbe8be065a748d17--
