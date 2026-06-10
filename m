Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113EFCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 03:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C63510E6E4;
	Wed, 10 Jun 2026 03:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="piaj78gN";
	dkim-atps=neutral
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com
 [74.125.224.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA94B10E6EA
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 03:56:30 +0000 (UTC)
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-660512d80b4so6698687d50.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 20:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781063790; cv=none;
 d=google.com; s=arc-20240605;
 b=XKPQBRMAgULLfygn/VnJ3zdVgc5965CLhTGKSiI1uMV9FozI2PgNMMaRddrMtBzfGJ
 DxwxIZO2lg4FWpgxAAsRB7tnfVBtq3he1sIaZ/WM2jSMpGPVWq1z4nmFJGll3zxuMLMH
 15Jdr9nXTY9IlS9MHwRg/DePU+Qiv3jD+hAs1p07VunvJhAL7/mm95Zi5MBGlxJZn7ar
 AlUyhQBMiCQLD3rfYcW5+oD38i3S0cavnt/AwKeBxW39+OylNIOrIb0ofzg8MVmoaUry
 uKGUQuusEIE6AQ1GdgM+yNACJ3gVrey7hSB5uqe5PqvvWjh4w5tR87h+xUCVO238btGu
 n1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=o2Y71ur2j8AWeXxKEtF9d/8FWw9ai/UzloR6wLp7LdY=;
 fh=R/vlUfgv8VbOj0Qy8Crqn2uklsEAe2w6fzy9glVucDw=;
 b=csGx4Iaf0ZlIPxo+dUF6A47lOhhz+RtKaJogovxaw1+XEVzBlIHPWYSW3Oxv7t8Eet
 iOOOk9NpYuQBqsMpOV6ghC+4Ow1VI2IXB62aQ922lmkd7Jje6k7IrYtesp7HTkEijMCy
 nAv0SKtwKznlndSoJmQnUhnefgI94egiOzivy7Silf7KuG1Xiv0RxqnvPn/BpAu9tPd2
 PfyeN/pwSQWpQmij188/2hfkVUfL3PVksDiYzsjTbUaJ7WbPCUAFqWTslCtFFxgLu+S6
 xWz2ETmYTeGGpCSIMXLLB2897Qv6T8f1X4ehJFyXWXyXGd2MFXB+V57YUx70UdI+Vogr
 qngw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781063790; x=1781668590; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o2Y71ur2j8AWeXxKEtF9d/8FWw9ai/UzloR6wLp7LdY=;
 b=piaj78gN/m1udGdPA7m5mJ0YXW6DHfKJlv0xm9gvVSnWxdmN9JjitVR0BAqFq8to77
 qlu4xGCfX8LoFwecNxVRqU19hdi2pHOQH/8iBOd6+ci856yvU75S7bESdrPSstnjtryd
 SiFmZIjaL4s4czco/1tBIHlwJxcHBCY6HfEYpVDHht95K7AR6XM65zdrax6ifUqoW0v5
 bUO0kshUyHwAzVtZwMNz3lO9GK/odbayPzjQM8TQZOfZyvBHPW9r3qPVQUPH0pU02Qbc
 XMb++xOqrzKZdvXOyV50zvHzdleQbJ2+3uT68r7HhEsU8teMo6ybAnQ1JHON6vWsLyVW
 mJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781063790; x=1781668590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2Y71ur2j8AWeXxKEtF9d/8FWw9ai/UzloR6wLp7LdY=;
 b=nYUxM8iRllUz6BTUCswuQdJ8AcIhGHaimNYxJSDdQRS5+wOQ5+IPL988AULxuyCTp4
 +CZNPGfnP2kxiEZ707KMt1n2/2Yzr3mfJ+mrBsGpNW1g0Pz2WepHPcXeFn/3cYWCnLL8
 Uaea9HShsnvJfc+8aleWMKYTp3ETPRADzo1D7ps8Yx2qBaOcfvjxFylZkZB1sqx21Cui
 e391YAVhL7g0L5YxS7CL9BPZtmZEEMSu7JOkPjsApkDrt3OzMHSRLmWenv0jFxVcburJ
 ZIGvP1Nr+MOmwN+Yp6EbCF3BWADthGMK3kH9biEdkkyGyPS8+Puz2y+0KJSoLWOtllkZ
 lcWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kmwJhIRnMnUDy4yI+cuO9ClV1U3OcPGUPqPuVkCeuyVXeKJjFRSLh+TGX9tiy3VT4JBnw3yXUVxw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzo7grR0uRQ6ae3w4rQxOylL/lx+76CUKlhJ+ocoXSiGUL+0kZ/
 T5oU0iM8TE8g5JdgmFfi0IoimgT7ItFnN4GUK2sjc6seyLKW+A3pxCcA9OIG0v0vo+ospGJUfLt
 M7U+fd9ILiDxKtF7T+PgxRgrpXhHzMX4=
X-Gm-Gg: Acq92OHkX85cGckW10nKeAMZtLPrZEkutAZLHZ248Ju6aUeQCGfFhtQj/uu7MhDORn4
 /xuv9ESzrvYI2S319TCyUhsJllifF4I5uq/q1IOLykoLguT75mV7mavIkXtUOj2Otp3/pNlRInJ
 q1m4BIApm/foAJBLDVKsZlI92odBZnb+takK1VkUfOB+L+cQ7o7ASsA6W+ceWiPt8lDAdVWgqrm
 rIOg56XR9XExhmcbFabe7VhiorpkmIrRa89z2Lq1k5Ajy7UjBXFm/QCXdM/xluLyPtlAB47jmUv
 1ez6kZhGSmV7oo2wQtWX9Vdwl1Gekw==
X-Received: by 2002:a05:690e:1242:b0:660:431b:8a5c with SMTP id
 956f58d0204a3-6610a624fa8mr15634436d50.4.1781063789814; Tue, 09 Jun 2026
 20:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260605060527.1443552-1-lgs201920130244@gmail.com>
 <aiLe61REFDPGvZWM@ideak-desk.lan>
In-Reply-To: <aiLe61REFDPGvZWM@ideak-desk.lan>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 10 Jun 2026 11:56:16 +0800
X-Gm-Features: AVVi8Cdl7bjaaSoyIcwbk4y7y4tCXUvPuwgUj1XqVjclggrW4JUWxHkR6dTt11A
Message-ID: <CANUHTR-gdPwagMqGbH+GfPVqWN2ygP6b-GTaUQe_AxZsi5RHfg@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/dp_tunnel: fix CRTC hw state cleanup ordering
To: imre.deak@intel.com
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Uma Shankar <uma.shankar@intel.com>, 
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Imre,

Thanks for the review.

On Fri, 5 Jun 2026 at 22:36, Imre Deak <imre.deak@intel.com> wrote:
>
> On Fri, Jun 05, 2026 at 02:05:27PM +0800, Guangshuo Li wrote:
> > intel_crtc_prepare_cleared_state() frees the old CRTC hw state before
> > calling intel_dp_tunnel_atomic_clear_stream_bw(). The latter can fail
> > while looking up the DP tunnel group state, for example with -EDEADLK.
> >
> > If that happens, the function returns without completing the cleared
> > state preparation, leaving the duplicated CRTC state with its hw color
> > blob references already dropped. The failed atomic state will then be
> > cleared by the atomic core, which can drop the same references again.
> >
> > Move the hw state release after the DP tunnel stream BW clear has
> > succeeded. Keep the temporary state allocation before the failable DP
> > tunnel operation so an allocation failure cannot happen after the stream
> > BW has already been cleared.
> >
> > Fixes: fb69d0076e68 ("drm/i915/dp_tunnel: Fix error handling when clearing stream BW in atomic state")
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_display.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> > index ad2fe10b6b1f..0c015bc6c9fd 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display.c
> > @@ -4646,9 +4646,6 @@ intel_crtc_prepare_cleared_state(struct intel_atomic_state *state,
> >       if (!saved_state)
> >               return -ENOMEM;
> >
> > -     /* free the old crtc_state->hw members */
> > -     intel_crtc_free_hw_state(crtc_state);
>
> The fix is valid, however I think instead of this change it'd be better
> to clear the blob reference pointers in intel_crtc_free_hw_state().
>
> > -
> >       err = intel_dp_tunnel_atomic_clear_stream_bw(state, crtc_state);
> >       if (err) {
> >               kfree(saved_state);
> > @@ -4656,6 +4653,9 @@ intel_crtc_prepare_cleared_state(struct intel_atomic_state *state,
> >               return err;
> >       }
> >
> > +     /* free the old crtc_state->hw members */
> > +     intel_crtc_free_hw_state(crtc_state);
> > +
> >       /* FIXME: before the switch to atomic started, a new pipe_config was
> >        * kzalloc'd. Code that depends on any field being zero should be
> >        * fixed, so that the crtc_state can be safely duplicated. For now,
> > --
> > 2.43.0
> >

Agreed, clearing the blob reference pointers in
intel_crtc_free_hw_state() makes the cleanup safe against repeated calls
and avoids changing the ordering in intel_crtc_prepare_cleared_state().

I'll send a v2 with that change.

Best regards,
Guangshuo
