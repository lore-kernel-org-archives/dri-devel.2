Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B925606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IRnVvi0y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D3B10F956;
	Wed, 11 Nov 2026 08:23:41 +0000 (UTC)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6011910E074
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:54:55 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-15ea896ddc8so3316363c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:54:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794318895; cv=none;
 d=google.com; s=arc-20260327;
 b=eyQblReaNW7j+yKP8MU+ioRP3zbsrKf0qSrx50YIetJVpslQJiK38+7NcrUlw01r6x
 oIZeWRBKqk8WWSG9O+RHgEYnxhZpHC+ztXa2YTA3d7A/44g5AhKRE3hBy7OYS7tcwqmj
 iSAYb+moGVD+noT6IRmTnmNDK1MCJpEpictjk9SwqnfbrwYjfMMiFSk8JpiESKfrQF17
 VOczqK2pKNh+8tl/6ixeIiOJtdku+P18oeUQ0mABSj7rcm1JPvQWo76ixGqShRt5ovoF
 0slsKQy32e1myoRzRm88FXSko0mCJiacGaW6EnaTA7DFjtQ1zbwzKJ7hI4aC6UuVB2lA
 FmcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DqnGBDj+8F1Y/oWXY/oJDLw+ryRi3kCbJ0uvQjf0h+Y=;
 fh=os7xcCHidLIVJBlCJQOV4G0QzivUWam7uLQOabIvNpE=;
 b=ki4HxACh4IRBHJ2/+2fwBpe/6Mr/C6wwtV2Mq929zo0/KhLfckaB6L7OXeJEnZ8jjo
 ixcLYUgj+DZEBHEOT9EulCc+2J2AATZ6ag/og5G77dPJu7welcmDUbd+blYW+AJzE15P
 ICsuRfA96MUxY+U24Rhn0YIoSImKfWtt+Dehc04SNZ5MEC1bMwqVfDyYtl3NS8iBqIiZ
 nK2rCvuo/+CoWuNDsijJ3db/gRj5UQZp4488L9FyadQc+DjYhr2ealmsjlNq2fiZjtvS
 HpndbHIlWVx8PvocWFnoD3sFwS6zMIMAzItWM7zj6nCYNl+oUFgi+ykTbQFkjNIfQejZ
 vJZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794318894; x=1794923694; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DqnGBDj+8F1Y/oWXY/oJDLw+ryRi3kCbJ0uvQjf0h+Y=;
 b=IRnVvi0y/C1O438SReMjoCB/hB/6dG8D0mNB+bywOHBRe14T1ZKuEAJ+DKtmoHxriT
 xyOL0OqEZi1np94pKYa7JLKrQncIzPb9uXTUyivp24oAEWomthBUjfAy5yc4QLWD8m8h
 NMGn3zgfYk0ufFlHLpMGQAWinBkmixkQLrd2xObzUNgQfVd/IRjGpiK2ZPUU/ERTRBOe
 lx1ybYog5kkPzIsx32wBZE/YBkj7UlC5tVnxU8tzda0DzfJLtnE+VOCVwSAPDX9cvSxN
 4cAfzoI8kMlFXguQxNZng37Zw146L4YZ9DH7MwTzyEvEuH8wUQKxr7fZiQlK7XtWMyZu
 ae0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794318895; x=1794923695;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DqnGBDj+8F1Y/oWXY/oJDLw+ryRi3kCbJ0uvQjf0h+Y=;
 b=VIJbHqIIAtz9ils7W3JVd6197iR51xcDbj7qc/cLc1mP8IO0C+kIzypDbCVx9T9bwK
 0mamj8La2akFqkZDatPFZqGXN0EafkPdPPmu7wo5LrLeCmI+rlexFRg6ysOCj0+5CIiH
 jmkIxRTNPydHpFXUa5JiZgTJXM793tvgdM+2GlMTvVZ/Kv64L/OIcRUOxPbAqH6qKSwV
 oOstFzCAURbQfEL/fhgFYpJnntwiTmrjPGNcjzgVeYfTgiccFrQbeDupNCGSGJj07+tB
 yI2cTUYisHOaIa5UXCiLR9MniVBGUiDed8f+l17MxHoPwKDoFWh6nj+ihybR/CntP90z
 g79Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGZ1V7oNyN29Ep7cWWd10rmz7MKHeXcEuHrsPx0IW4biH1deadVnPbUGSM7hH4aEW69kuiNydwLiI8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8dE6iNnMcDwGuIETUmw25t9PIcAlueTRJK2aX7QEj1DpP9Ld/E
 xrsdRkHSxlqP2OOmCa98PHd1UIry0MTPJ3WGNnz8lCFDuDt/SNpqGHcEi5/BriLMsLRUiFyguv2
 IX1Q/aQDEjFYMHM6eQ0KEfWF1ilYBm1E=
X-Gm-Gg: AYBFou2ixM8HvHY7FR+oxLqqDvq877eoSLJULFLU8WPOz+zrhzjYHFgZ0rjleZ/VpCy
 jH/akO6NuYF5XrX0/EDB4qWBBEhL144gNRP1b1QBwqsx7zTJe0WXhWaBQgnonK+/Q71snZBNECT
 2hhbmkBl90+Cni62x/wBIAkCXfLkzm7+tBqtFkVRMumBQvOyf/9FrRPd80KFpRZmpWuZNXaOwRS
 dtXwBN1eQL3hXDwS4r8znk0fF85zKELdG8zx7Js0r0ipbW4894CTdqBBLdk6TM2c2W0a2JLlSp0
 Hj361wyg7wxHlXOFb4kDPRUDgQ0QniGJGaqQbtPE7gebnuSwcMv/NxW3YhOV48c2cgrOYjEzXMI
 rMi4REgL7lGJPb4fyaQ0tmMxqr4SuxosO7utqCw/2ZXTFP95QB/S+/AhHm4raoz3nGs6t9SYe/B
 9BeFknyJwFHrKe1A/Xl3HjsZ9qU9aVmbktdJJGo65vON7fbHV5liyqCg==
X-Received: by 2002:a05:7022:f8a:b0:1a7:7160:ffc8 with SMTP id
 a92af1059eb24-1b3b60039e7mr4605593c88.10.1794318894291; Tue, 10 Nov 2026
 05:54:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109230147.16302-1-claudioforain@gmail.com>
In-Reply-To: <20261109230147.16302-1-claudioforain@gmail.com>
From: =?UTF-8?Q?Cl=C3=A1udio_Forain?= <claudioforain@gmail.com>
Date: Tue, 10 Nov 2026 07:54:42 -0600
X-Gm-Features: AclHuK-3CNOIAx6d73x-TgXb1mwKho28x2ys-H0_-pwHs0pp2n1EZgwORe-Jqh0
Message-ID: <CAOKbSHTuinvW_q-eqCaYeD75t1nLEdxLp5ot5HNkR5SHvUB9eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Only allow idle optimizations when all
 CRTCs are idle
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, 
 ray.wu@amd.com, superm1@kernel.org, siqueira@igalia.com, 
 dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000004eddd4065fec6c36"
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000004eddd4065fec6c36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please don't apply this version.


The automated review at sashiko.dev found three real problems, which I
have confirmed against the source:

- dm_ism_all_crtcs_idle() reads crtc->state of other CRTCs under only
  dc_lock. A concurrent atomic commit on another CRTC can swap and free
  that state, so this can be a use-after-free.
- A CRTC that is enabled or resumed and stays static without ever taking
  a vblank reference remains in FULL_POWER_RUNNING, so idle
  optimizations could never be allowed again (a power regression).
- It uses adev_to_drm(dm->adev) instead of dm->ddev, which breaks the
  ISM KUnit commit tests.

The diagnosis in the changelog still stands: a static CRTC's ISM
enables HW-wide idle optimizations while another CRTC is receiving
legacy cursor updates. I'll send a v2 with a different approach, tested
with KUnit and across suspend/resume.

Thanks,
Claudio


On Mon, Nov 9, 2026 at 5:02=E2=80=AFPM Claudio Forain <claudioforain@gmail.=
com>
wrote:

> [Why]
> Idle optimizations are HW-wide, but the Idle State Manager (ISM) runs per
> CRTC. When a CRTC's ISM reaches OPTIMIZED_IDLE it enables idle
> optimizations globally as long as no CRTC holds a vblank reference
> (dm->active_vblank_irq_count =3D=3D 0). It does not check whether the ISM=
s
> of the other CRTCs are idle.
>
> With two displays on X11, one static and one receiving cursor updates,
> the static CRTC's ISM enables idle optimizations while the cursor CRTC is
> busy. Legacy cursor updates do not take a vblank reference, so nothing
> vetoes it. On ASICs that set debug.exit_idle_opt_for_cursor_updates
> (DCN30x, DCN32x, DCN401, ...), every call to
> dc_stream_program_cursor_attributes() and
> dc_stream_program_cursor_position() then exits and re-enters idle
> optimizations itself. That is up to four synchronous DMUB commands per
> cursor update, each taking up to ~1.6 ms on DCN401, all under dc_lock in
> the X server's input thread. The cursor visibly speeds up and slows down
> while the desktop is otherwise idle.
>
> Measured on RX 9070 XT (DCN401), 240 Hz + 60 Hz displays, Xorg, cursor
> moving continuously for 15 s (ftrace, cursor handler entry to
> dc_stream_program_cursor_position entry):
>
>                                  before      after
>   cursor updates/s                1686        2572
>   latency median / P95 / P99    144/858/927  17/19/87 us
>   samples > 500 us                5460           0
>   idle opt calls from cursor   58093           0
>     programming
>   dcn401_apply_idle_power_
>     optimizations calls          58198           6
>
> With a single display, or with any vblank requestor active, the issue
> does not occur. Commit a1fc7bf6677e ("drm/amd/display: Restore 5s vbl
> offdelay for NV3x+ DGPUs") hid the issue by keeping vblank enabled on the
> cursor CRTC; it reappeared with commit f39283eab44f ("Revert
> "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"").
>
> [How]
> Before allowing idle optimizations, also require every CRTC with an
> active stream to be in OPTIMIZED_IDLE or OPTIMIZED_IDLE_SSO. The ISM
> updates current_state before dispatching, so the last CRTC to go idle
> still allows idle optimizations and no idle entry is lost. Idle
> optimizations are still entered on a static desktop (173 entries in a
> 15 s static capture with the patch applied), idle GPU power is
> unchanged (25.9 W before, 25.8 W after), and vblank enable/disable is
> unchanged.
>
> The problem was found and the fix written with an AI coding assistant,
> working from ftrace captures taken on the affected system: function
> tracer counts and caller attribution, and function_graph durations of
> the cursor, ISM and DMUB paths. The assistant proposed the change and
> drafted this changelog; the submitter reproduced the issue, built and
> ran each test kernel, and confirmed the results.
>
> Fixes: 754003486c3c ("drm/amd/display: Add Idle state manager(ISM)")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6115
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4906
> Assisted-by: claude-opus-5-5
> Signed-off-by: Claudio Forain <claudioforain@gmail.com>
> ---
> Testing and limitations:
> - Reproduced and tested on v7.3.3 (Gentoo) with RX 9070 XT (DCN401),
>   Xorg, two DP displays (240 Hz + 60 Hz). The issue reproduces only with
>   both displays active; disabling one makes stock 7.3.3 behave.
> - Built and booted on v7.3.3. This posting is rebased onto
>   amd-staging-drm-next, where it applies cleanly, but it has not been
>   built or run on that tree.
> - Not tested: other DCN generations, APUs, PSR/Replay panels (the
>   OPTIMIZED_IDLE_SSO path), Wayland compositors, hotplug and
>   suspend/resume with the patch, and the ISM KUnit tests.
> - Idle GPU power on a static desktop (hwmon power1_average, 40 x 1 s):
>   25.9 W before, 25.8 W after. Only checked on this setup.
> - crtc->state is read under dc_lock only, like the existing
>   to_dm_crtc_state(acrtc->base.state) in amdgpu_dm_ism_commit_event().
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> index 127eaba..79546ad 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> @@ -276,6 +276,32 @@ bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,
>  EXPORT_IF_KUNIT(dm_ism_trigger_event);
>
>
> +/*
> + * Idle optimizations are HW-wide, but each CRTC runs its own ISM. Only
> allow
> + * them once every active CRTC's ISM has reached an optimized idle state=
,
> so a
> + * static CRTC cannot enable idle optimizations while another CRTC is
> still busy
> + * (e.g. receiving cursor updates without a vblank reference). Otherwise
> every
> + * cursor update on the busy CRTC must exit and re-enter idle through
> DMUB.
> + */
> +static bool dm_ism_all_crtcs_idle(struct amdgpu_display_manager *dm)
> +{
> +       struct drm_crtc *crtc;
> +
> +       drm_for_each_crtc(crtc, adev_to_drm(dm->adev)) {
> +               struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);
> +               struct dm_crtc_state *state =3D
> to_dm_crtc_state(crtc->state);
> +
> +               if (!state || !state->stream)
> +                       continue;
> +
> +               if (acrtc->ism.current_state !=3D
> DM_ISM_STATE_OPTIMIZED_IDLE &&
> +                   acrtc->ism.current_state !=3D
> DM_ISM_STATE_OPTIMIZED_IDLE_SSO)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism
> *ism,
>                                              struct dc_stream_state
> *stream,
>                                              bool vblank_enabled,
> @@ -326,7 +352,8 @@ static void
> dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
>          * optimizations at the start of this func -- we should disallow
>          * whenever there's *an* active CRTC.
>          */
> -       if (!vblank_enabled && dm->active_vblank_irq_count =3D=3D 0) {
> +       if (!vblank_enabled && dm->active_vblank_irq_count =3D=3D 0 &&
> +           dm_ism_all_crtcs_idle(dm)) {
>                 dc_post_update_surfaces_to_stream(dm->dc);
>                 dc_allow_idle_optimizations(dm->dc, true);
>         }
> --
> 2.x
>

--0000000000004eddd4065fec6c36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"background-color:initial;color:inherit;font=
-size:0.9em">Please don&#39;t apply this version.</span><pre style=3D"overf=
low-x:auto;color:rgb(191,191,191);background:none 0% 0%/auto repeat scroll =
padding-box border-box rgb(36,37,38);box-sizing:border-box;border-radius:4p=
x;max-width:100%;margin:0px;padding:8px;font-size:13px"><code style=3D"colo=
r:inherit;background:0px 0px;padding:0px;border-radius:3px;word-break:break=
-word;font-size:0.9em">
The automated review at <a href=3D"http://sashiko.dev">sashiko.dev</a> foun=
d three real problems, which I
have confirmed against the source:

- dm_ism_all_crtcs_idle() reads crtc-&gt;state of other CRTCs under only
  dc_lock. A concurrent atomic commit on another CRTC can swap and free
  that state, so this can be a use-after-free.
- A CRTC that is enabled or resumed and stays static without ever taking
  a vblank reference remains in FULL_POWER_RUNNING, so idle
  optimizations could never be allowed again (a power regression).
- It uses adev_to_drm(dm-&gt;adev) instead of dm-&gt;ddev, which breaks the
  ISM KUnit commit tests.

The diagnosis in the changelog still stands: a static CRTC&#39;s ISM
enables HW-wide idle optimizations while another CRTC is receiving
legacy cursor updates. I&#39;ll send a v2 with a different approach, tested
with KUnit and across suspend/resume.

Thanks,
Claudio</code></pre></div><br><div class=3D"gmail_quote gmail_quote_contain=
er"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 9, 2026 at 5:02=E2=80=
=AFPM Claudio Forain &lt;<a href=3D"mailto:claudioforain@gmail.com">claudio=
forain@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">[Why]<br>
Idle optimizations are HW-wide, but the Idle State Manager (ISM) runs per<b=
r>
CRTC. When a CRTC&#39;s ISM reaches OPTIMIZED_IDLE it enables idle<br>
optimizations globally as long as no CRTC holds a vblank reference<br>
(dm-&gt;active_vblank_irq_count =3D=3D 0). It does not check whether the IS=
Ms<br>
of the other CRTCs are idle.<br>
<br>
With two displays on X11, one static and one receiving cursor updates,<br>
the static CRTC&#39;s ISM enables idle optimizations while the cursor CRTC =
is<br>
busy. Legacy cursor updates do not take a vblank reference, so nothing<br>
vetoes it. On ASICs that set debug.exit_idle_opt_for_cursor_updates<br>
(DCN30x, DCN32x, DCN401, ...), every call to<br>
dc_stream_program_cursor_attributes() and<br>
dc_stream_program_cursor_position() then exits and re-enters idle<br>
optimizations itself. That is up to four synchronous DMUB commands per<br>
cursor update, each taking up to ~1.6 ms on DCN401, all under dc_lock in<br=
>
the X server&#39;s input thread. The cursor visibly speeds up and slows dow=
n<br>
while the desktop is otherwise idle.<br>
<br>
Measured on RX 9070 XT (DCN401), 240 Hz + 60 Hz displays, Xorg, cursor<br>
moving continuously for 15 s (ftrace, cursor handler entry to<br>
dc_stream_program_cursor_position entry):<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0before=C2=A0 =C2=A0 =C2=A0 aft=
er<br>
=C2=A0 cursor updates/s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1686=C2=A0 =C2=A0 =C2=A0 =C2=A0 2572<br>
=C2=A0 latency median / P95 / P99=C2=A0 =C2=A0 144/858/927=C2=A0 17/19/87 u=
s<br>
=C2=A0 samples &gt; 500 us=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 5460=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
=C2=A0 idle opt calls from cursor=C2=A0 =C2=A058093=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00<br>
=C2=A0 =C2=A0 programming<br>
=C2=A0 dcn401_apply_idle_power_<br>
=C2=A0 =C2=A0 optimizations calls=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 58198=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
<br>
With a single display, or with any vblank requestor active, the issue<br>
does not occur. Commit a1fc7bf6677e (&quot;drm/amd/display: Restore 5s vbl<=
br>
offdelay for NV3x+ DGPUs&quot;) hid the issue by keeping vblank enabled on =
the<br>
cursor CRTC; it reappeared with commit f39283eab44f (&quot;Revert<br>
&quot;drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs&quot;&quot;)=
.<br>
<br>
[How]<br>
Before allowing idle optimizations, also require every CRTC with an<br>
active stream to be in OPTIMIZED_IDLE or OPTIMIZED_IDLE_SSO. The ISM<br>
updates current_state before dispatching, so the last CRTC to go idle<br>
still allows idle optimizations and no idle entry is lost. Idle<br>
optimizations are still entered on a static desktop (173 entries in a<br>
15 s static capture with the patch applied), idle GPU power is<br>
unchanged (25.9 W before, 25.8 W after), and vblank enable/disable is<br>
unchanged.<br>
<br>
The problem was found and the fix written with an AI coding assistant,<br>
working from ftrace captures taken on the affected system: function<br>
tracer counts and caller attribution, and function_graph durations of<br>
the cursor, ISM and DMUB paths. The assistant proposed the change and<br>
drafted this changelog; the submitter reproduced the issue, built and<br>
ran each test kernel, and confirmed the results.<br>
<br>
Fixes: 754003486c3c (&quot;drm/amd/display: Add Idle state manager(ISM)&quo=
t;)<br>
Closes: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/6115" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/drm/amd/-=
/issues/6115</a><br>
Link: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/4906" rel=
=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/drm/amd/-/=
issues/4906</a><br>
Assisted-by: claude-opus-5-5<br>
Signed-off-by: Claudio Forain &lt;<a href=3D"mailto:claudioforain@gmail.com=
" target=3D"_blank">claudioforain@gmail.com</a>&gt;<br>
---<br>
Testing and limitations:<br>
- Reproduced and tested on v7.3.3 (Gentoo) with RX 9070 XT (DCN401),<br>
=C2=A0 Xorg, two DP displays (240 Hz + 60 Hz). The issue reproduces only wi=
th<br>
=C2=A0 both displays active; disabling one makes stock 7.3.3 behave.<br>
- Built and booted on v7.3.3. This posting is rebased onto<br>
=C2=A0 amd-staging-drm-next, where it applies cleanly, but it has not been<=
br>
=C2=A0 built or run on that tree.<br>
- Not tested: other DCN generations, APUs, PSR/Replay panels (the<br>
=C2=A0 OPTIMIZED_IDLE_SSO path), Wayland compositors, hotplug and<br>
=C2=A0 suspend/resume with the patch, and the ISM KUnit tests.<br>
- Idle GPU power on a static desktop (hwmon power1_average, 40 x 1 s):<br>
=C2=A0 25.9 W before, 25.8 W after. Only checked on this setup.<br>
- crtc-&gt;state is read under dc_lock only, like the existing<br>
=C2=A0 to_dm_crtc_state(acrtc-&gt;base.state) in amdgpu_dm_ism_commit_event=
().<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c<br>
index 127eaba..79546ad 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c<br>
@@ -276,6 +276,32 @@ bool dm_ism_trigger_event(struct amdgpu_dm_ism *ism,<b=
r>
=C2=A0EXPORT_IF_KUNIT(dm_ism_trigger_event);<br>
<br>
<br>
+/*<br>
+ * Idle optimizations are HW-wide, but each CRTC runs its own ISM. Only al=
low<br>
+ * them once every active CRTC&#39;s ISM has reached an optimized idle sta=
te, so a<br>
+ * static CRTC cannot enable idle optimizations while another CRTC is stil=
l busy<br>
+ * (e.g. receiving cursor updates without a vblank reference). Otherwise e=
very<br>
+ * cursor update on the busy CRTC must exit and re-enter idle through DMUB=
.<br>
+ */<br>
+static bool dm_ism_all_crtcs_idle(struct amdgpu_display_manager *dm)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_crtc *crtc;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_for_each_crtc(crtc, adev_to_drm(dm-&gt;adev=
)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_crtc =
*acrtc =3D to_amdgpu_crtc(crtc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dm_crtc_stat=
e *state =3D to_dm_crtc_state(crtc-&gt;state);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!state || !stat=
e-&gt;stream)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (acrtc-&gt;ism.c=
urrent_state !=3D DM_ISM_STATE_OPTIMIZED_IDLE &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc=
-&gt;ism.current_state !=3D DM_ISM_STATE_OPTIMIZED_IDLE_SSO)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
+}<br>
+<br>
=C2=A0static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_is=
m *ism,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct dc_stream_state *stream,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bool vblank_enabled,<br>
@@ -326,7 +352,8 @@ static void dm_ism_commit_idle_optimization_state(struc=
t amdgpu_dm_ism *ism,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* optimizations at the start of this func=
 -- we should disallow<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* whenever there&#39;s *an* active CRTC.<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vblank_enabled &amp;&amp; dm-&gt;active_vb=
lank_irq_count =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vblank_enabled &amp;&amp; dm-&gt;active_vb=
lank_irq_count =3D=3D 0 &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dm_ism_all_crtcs_idle(dm)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc_post_update_surf=
aces_to_stream(dm-&gt;dc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc_allow_idle_optim=
izations(dm-&gt;dc, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.x<br>
</blockquote></div>

--0000000000004eddd4065fec6c36--
