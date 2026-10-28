Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A8606A323
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IK89y3tY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D91CC10E51E;
	Wed, 28 Oct 2026 05:55:03 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C077D10E51E
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 05:54:57 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-3ab3dd9667dso3660511fa.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 22:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793166896; cv=none;
 d=google.com; s=arc-20260327;
 b=DFaCRJy5JWDLHT/5jreVOgi+Wyion8+2/BYrvVEDSWQezPNr8J6qy7VgCw7SIIZ3an
 56lpjGUsvEH+iA65jGeJkNejHGL5xHkiz8PBmG1/ckxnbgsTalV0nuP0JTUM4tt2Hju7
 SBey5UTdCD3jMEYmIYlSTyFzwFN7HYY/k+5VIQqGSX1H9zroQAnNlxQEYEiFCBx/wW4Y
 uh9I1JB1sQW27065dODZzXDHFiVf7LybeEy0+1bJHcDnmLFAq8x6XqNnpC+RLAHck8cZ
 gUW9VzvWc5za0DnTWVf3JX/ZJKkiPnyStEzmG4e4JKUGQv/ljUo9NtxpEph6Hdgs0ECs
 8WTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/OIe7V+Z5EIyhdSgn5/cXwPf5qh49NuJQ9MgeW2mgsM=;
 fh=rJnvIXl8VjDf/wGfIWvgn1HrnscY2zyzTSE8Vw6u7uk=;
 b=T06ne2uqcHwiynw3lUcym9v5ha/jeyff78XfCv22GIGQTlp3wmV4l2S+iuKJ1uO7ZO
 QPV7pYjIKPKXeMjex7Ubx7QJj2mgZm8+DfFxmUumfH6Suq3lAnVpe4t++2Q/K3Ayk0Gb
 pvqn5ZrUC9FBX8BqVZrXVvjMXGgCZCda1LJql8jNjwWXcKc1v08cKbyIcm/mIbzv08IQ
 85FQC1/htxjYxX1gURRLPKPnd9YC7UzK5aN2Z6G/04WnCynf5vo8JpeRYbb58C3mSz2/
 6AJlrUX9zdsS7GhWA6bSXCZ3LFOYlQYOpI3Mh+Xwm1cbfs28rsxtwGvf/s48LYzCa+Im
 63kw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166896; x=1793771696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/OIe7V+Z5EIyhdSgn5/cXwPf5qh49NuJQ9MgeW2mgsM=;
 b=IK89y3tYPUjMnMduK248liKIYszNUwl3w7oTuc0thH0KKfzhVUr/JTcW4oazZx/a5/
 oud0xVn+ttua8v5ub805HtGzoEdOqd5+JSOhpSzjFxMPcg0Rx2jCDbaQsFKraSrstKET
 5KfsvpUGjQHek9e7XGhVvQGp7oCaz4dM6SfjKPOgZckm6wb2DUS7iO/KesqFJXZU1J8y
 D0Xo9GLZx7h9RX6gk/IzwFYekRbUaA/AAoahhV/MAXR54OHoxekNjaInYidebtJW2o1l
 XzOkPfdl8tUves2OfOmMKHRoOc+jyiNYUPKESScYcaliJ0NvXBP55HhiUflF2/3i3+2l
 7Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166896; x=1793771696;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/OIe7V+Z5EIyhdSgn5/cXwPf5qh49NuJQ9MgeW2mgsM=;
 b=TYIgG7coWHCw5jL2UayTs9raemzY667srzTaL+8Zv7mTjVboSw1ePZTe+n2NzRJF0K
 P1C8vBk0rtmp/XO/0j8SQneUj4MCtZUBX3LvJVBdgDnAhjSvyvY+AUVolnvDfJHjuLHr
 caLZaYnu/SNoAdpT/FyDu0fcIjfa85V0ZWRTpaB0OGkHn5RZsell5di8m9Adc88K+Fq8
 AD2NFd5+q0wpqRQK3TvIUEpUcqWrwUq+7rgpvAKfk0AJ2pQyQ4fVk+QKR5lfRZfsyBZ+
 pu/ebZnZ2sSsplOL0oZE8jzFNBhy2T1cxA36TBQ5i4MfCUZnVkUd3QgdvpK4vG+UZ0iO
 30Xw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3av+N/u7qmBkxZIEmhjPYAFyjm7jsHvoKnPHeaKM7SzOBaMhFYF2u19Xsx8IIAwaFtpUl7j2+FdE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI1WIPH4/5dR+cYgy/DN+CedeszoMCyTSBp1PS8YXbSZtrSn/gK
 LEFSIZeDQVa4UzBDPHBK4ISmaClHrMrCFr38Z1+hJnk/xZtevQ10VOKbrpbBU5ByPhY5dPxMl9I
 07mLOLX0i0Pt/K3vXNL0lRxjm2OUT0w8=
X-Gm-Gg: AYBFou3DFSFUs4cVtqhxLq/96hKpciup4xHbzazLKfrW3r7k+Y5tjHXAmjVK+ewpDq8
 b7HnzQUZl7Q5kmA71p+zXqEPE3Ak22NZ4dkrYZqIx2yqUxKYQB5PR2Q+f7/n1TipYxyLt8eLgrC
 cY6QAtsjWGYq//rv/zjcko/sFcc7x4Rpg1A4X1xDaVGqQUqjyis6rIa5FzmW5Ee09HTUqfJfjps
 207oo7REQYxyXqDIxjmVcx3I1O2r+OjP3hQh9XYxJcV78GJvQdIU1q6oZaS6vkZqb5WVoCoiJDs
 J5z28M4BCmDea5dD49s5wHP0rITqw10iDWOmSyURL5IzxXoIx3HD/R73hPTfxKjIxiZexSn1XNd
 P4dmhhhDnRN5Pl35mh3pFXQPkC8cr1SE/q61WcvY2P2R/mW0n7pRoJtzz5wGmOmazoliPg6om20
 Ia6+MHAhCuJeYdRrElvFWmUOA3wyzEU4fDakFjoAwVmVlQqw==
X-Received: by 2002:a05:651c:1543:b0:3ab:a27a:882b with SMTP id
 38308e7fff4ca-3ac9cf8f039mr2342071fa.14.1793166895636; Tue, 27 Oct 2026
 22:54:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028020147.2014466-1-matthew.schwartz@linux.dev>
 <CALHNRZ9f8ZTnc0LnAJ+YPRYKA9D1=tvY=Ce6bf=91O=WWU6XmA@mail.gmail.com>
 <7521fb7a-d46e-4e2a-89a8-ddd1b55e0afb@linux.dev>
In-Reply-To: <7521fb7a-d46e-4e2a-89a8-ddd1b55e0afb@linux.dev>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 28 Oct 2026 00:54:43 -0500
X-Gm-Features: AclHuK9WWp8SGPM-eWG0fxs1FWBVmuy6ctOftERy8mB7zwqvdR8blmFBBHZ3Uv0
Message-ID: <CALHNRZ8Tjb8hyhA4fbz10u4ptmS8ubgcVNEf6qhhUZ=+BwTyEw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: chipwealth-ch13726a: Fix dark grays rendering
 green at 120 Hz
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Teguh Sobirin <teguh@sobir.in>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 12:46=E2=80=AFAM Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> On 10/27/26 9:57 PM, Aaron Kling wrote:
> > On Tue, Oct 27, 2026 at 9:02=E2=80=AFPM Matthew Schwartz
> > <matthew.schwartz@linux.dev> wrote:
> >>
> >> The init sequence writes 0xf0 0x50 followed by 0xb9 0x00. The panel
> >> configuration in the Thor's stock Android firmware (decompiled from it=
s
> >> devicetree overlay, dtbo.img) has two runtime command sequences that
> >> differ only in the 0xb9 value, both "display off; f0 50; b9 xx; displa=
y
> >> on":
> >>
> >>   qcom,mdss-dsi-ram-command:        b9 11
> >>   qcom,mdss-dsi-bypass-ram-command: b9 00
> >>
> >> With 0x00, in the 120 Hz mode, a full-screen gray ramp from black to
> >> white, shown with identity color management, renders black as green an=
d
> >> the darkest grays as bright green, both at maximum and at reduced
> >> brightness, and the tint is more noticeable at lower brightness. The
> >> 60 Hz mode renders it correctly. With 0x11 the ramp renders correctly =
in
> >> both modes and the panel dims without a color shift.
> >>
> >> Use 0x11, the value from the vendor's ram-command sequence, instead.
> >>
> >> Fixes: 3ee01b8647b5 ("drm/panel: Add panel driver for ChipWealth CH137=
26A based panels")
> >> Reported-by: Aaron Kling <webgeek1234@gmail.com>
> >> Link: https://lore.kernel.org/all/20260727-ch13726a-washout-v1-1-bf869=
ddfc5cf@gmail.com/
> >> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> >> ---
> >> Aaron, this should be the 120 Hz issue from your washout patch; could
> >> you give it a try on your Thor? I found the issue here separately and
> >> saw your patch as I was prepping for submission, and I bet I was seein=
g
> >> the same bug you originally saw.
> >
> > This is something we tried before. And best we can tell, enabling gram
> > limits frame rate to 60hz on this panel. Framerate tests such as the
> > ufo test were reporting 60 when set up like this. Can you verify the
> > refresh rate on your device?
>
> Hmm, yeah, it was a bit hard to tell until instrumenting it but it
> seems to use a panel refresh rate of ~63 Hz. I do wonder if this panel
> is just not meant to be driven at 120 Hz though, since it seems like a
> very poor choice to expose as a mode with color issues like this.
>
> It might make more sense to just not expose it if it isn't fixable.

I had hoped to be able to fix it with color profiles or something,
since this as is does appear to push pixels fast enough, just with
gamma issues. But so far none of us have been able to find a way to do
so. Which is sad. But there may not be any other reasonable choice but
to drop the 120hz mode. And if that has to happen, might as well
switch to cmd mode and enable gram at the same time.

Aaron

> - Matt
>
> >
> > Aaron
> >
> >>  drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drive=
rs/gpu/drm/panel/panel-chipwealth-ch13726a.c
> >> index 562dc573528d..0832e49b77a9 100644
> >> --- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> >> +++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> >> @@ -65,7 +65,8 @@ static int ch13726a_on(struct ch13726a_panel *ctx)
> >>         ctx->dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> >>
> >>         mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xf0, 0x50);
> >> -       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x00);
> >> +       /* 0x00 (the vendor "bypass ram" sequence) renders near-black =
as green */
> >> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb9, 0x11);
> >>
> >>         mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> >>
> >>
> >> base-commit: 8ef66514d7b993c9fb96a5886f001e3556610c1c
> >> --
> >> 2.56.0
> >>
>
