Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BC1CCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18EC910E690;
	Sun, 18 Oct 2026 14:53:56 +0000 (UTC)
Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E2110E37C
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 17:37:46 +0000 (UTC)
Received: by mail-pz2-f9.google.com with SMTP id
 41be03b00d2f7-cd65a511e43so98007a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 10:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792172266; cv=none;
 d=google.com; s=arc-20260327;
 b=UzDlb0OhFt/fFvRhW9M7s2rmiESXne0jAMwaPvixxwwWBzpZVP3HWaOKNlUlKvRWAs
 nsmYLfG8dTLuNXgeaQbaQY4a/dd2jwhxIGnVaiswRPVWSdEUpiQ3Os4/Gh4jB1SEXatb
 EYnoZ3Oe1pOCDVS2HR/2urILgVqfvRkc+le7xnQsVJDp74phb5CX9uY5adJEDPlEsGHi
 XnvUCq4sDE4VjKm/rDVklmrvSHCp+hdvScGf7UWmyX6/alDxrPh//AM668SpssfJkl3W
 xb4tqXAKcMej+7289FQt0kxTCuxyCsWWx1a7Dgqm9PbXyn3kfBGQJUWY2ahZSvzWB6b4
 bLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:references:in-reply-to:from
 :mime-version:dkim-signature;
 bh=cSBeL18Hzr+0k6iOggYBFAtCAyebrXp5vaXSKHdHnjg=;
 fh=3Bj5WtgxIJl4ByqMQ2mqZ5IfFmG0TIIIeBH0Q6X0l54=;
 b=clzEo5S5lbfNa3PPBcOQMjOcRb0CazaabFqJb2HFP2z0G5MDro41sX3vcisfniqKnp
 Annb9JqfkZyQIcC2HZZCUgpLaQZKJGrR29xbknN6NmsJ0Da3IIakd8asCqYyzCtDup60
 unETiCjDryjuMmpvvPDzJM7hc3QHSoEJzczV89Fzxw1YGe/MG7nER47CS3mLNkuk1QkW
 MADBa/s8dBZrIiYb15bnasgPAPz/zboGJEAbA0h9n3F3X+3Ws7m/llwetcZo9XZzCVxA
 sID4/NaxxQN16hLdwrDxUTMXIVmF+Sjy8eCH2v8rQSZgapmxxLIbQs0Mg9gEFrpYdhrR
 KYQQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792172266; x=1792777066; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cSBeL18Hzr+0k6iOggYBFAtCAyebrXp5vaXSKHdHnjg=;
 b=WJdX71RGp9XdlyeLeSjmij00ByHPiXOi9puWkveNeIOB+YTUZWA7bdHOYh47XQno1w
 h8hvJbeoN6nGn0a7a6B1MlHOGo5XzRd3fjKHOv5X8p3O2NrmgyNDpfJt1OGpOKE5luCY
 QFpbeCJDTPdpEui9P1CHactfoRj73UpPfk8BDwxeiB3es7ZY6gQgl1qMw7IDQ99EHTvt
 HaRk1H+NzZEfH9ikwwAPVHjOgpWhF8jBAUMOPwdl2aixeHsMJEaUEp/8qLKubkenx4t+
 iScOdX/HSmsuqp9YR+ANVYce87L9iqxkfh93MzkUwAzFgCJkpuZJoWvhs9Mxhg6vaRr+
 i56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172266; x=1792777066;
 h=content-type:cc:to:subject:message-id:date:references:in-reply-to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cSBeL18Hzr+0k6iOggYBFAtCAyebrXp5vaXSKHdHnjg=;
 b=cQ/95S0N9NLP5srKY3kdQ4oHYYVt5nuoAMgCraPH40XPi5JLpY5dL1L/d/4blriOoi
 ovNO5vhNj8VK6kVy7YGVtowEd3MH0sejeLuwfkHzaDUVHSIAglXFmk3b9xg7Uzm5EDvJ
 USSHajDrtqGJVYCIOpFZGemVb/AdG9GNkRzlfprRHLMJOjZhjBuWHdYGy+I70RK2kHvL
 9g8Cjzfc1EUX4xtPGEIipZJnR89p2nrc97q4FRSUh8S8S6qLGa+SW/gOHZ4Q07OamrlP
 v61pLW2XDooCYPMtBGRQxVuJoGw6HK0k/IhMNhviXqy6zRj2mHf03zd1UCZCQXNwGb0D
 VsIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5oHnBWqEhmNvhVH5kAre7un81myeV7QMubvhgjdAHOMHYfwLG2ItoV50hidaeODV4AOALsUci5ng=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJal0bfD7NwPFDlEjl9lOdl9c8MwJrc44OsR5KaMyBdWIS+/t+0
 iJVtQzGb4iJ6gUY9EJLSrO66nRR3kCKsiOSwsKW7GYn2YCH53WTTxDtHOlnYVci9QlPdJPE9aHE
 byqtQLntzrubMv+Ba3al6Tqtj/UU5NmI=
X-Gm-Gg: AYBFou2e5Knk32s50ELzP4M9XnCzzX7b6TE2b0VNWL/uV9qmwmpH2cRFWpJVGpAQIDV
 +M4KdOYkC6F9w8YRqqtMwDnZqh0T/SsyGojQCafUnNjyLrUMUOkgVlrzlPWrarsFZVPHl7Qmv7l
 Z8rEhHRBJrgpMXOtl8MNZuS4dtyp9wKoisImymuw8PBaDsc+YLRMlvNE7/TdSGC86TQbjFvdXzx
 LhZbsbIiv5GFm21jf8ioTcL3q+cg1bH92xyq6RcCuK23tBOwOPSjf3qTem6FkNUntE9iDKnW0Le
 5pTyCFveQZ9YTMguRuPYUjh66rSB2gQ5JtJuBpR1Pj5GDvGrmEuSUQ==
X-Received: by 2002:a05:6a00:3008:b0:89e:fc47:2c17 with SMTP id
 d2e1a72fcca58-8a04be6a27bmr262049b3a.19.1792172266196; Fri, 16 Oct 2026
 10:37:46 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 16 Oct 2026 10:37:44 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 16 Oct 2026 10:37:44 -0700
MIME-Version: 1.0
From: Yibiao Li <biaobiao2233@gmail.com>
In-Reply-To: <f4dcee55-8cc6-4287-a25a-1ace385f092b@amd.com>
References: <CAG1agfwtnjmb8RVLmZvY9W-zrR1onhK6urJA3Lqai82tAXn2Cg@mail.gmail.com>
 <f4dcee55-8cc6-4287-a25a-1ace385f092b@amd.com>
Date: Fri, 16 Oct 2026 10:37:44 -0700
X-Gm-Features: AclHuK_NcSTXBwBpql1smct-MaIzZ_7A3iNYOrIiqYl5afbkmOt6bPkRbY4aer8
Message-ID: <CAG1agfwZF0j71YofDWVqrxX5v-gtSYbM2OQiw+Kbd1zGPTaT3g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use separate iterator for preferred mode
 lookup
To: Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

On Fri, Oct 16, 2026 at 09:50:44AM -0600, Alex Hung wrote:
> Reviewed-by: Alex Hung <alex.hung@amd.com>

Thanks for the review, Alex!

Best regards,
Yibiao


On Fri, 16 Oct 2026 09:50:44 -0600, Alex Hung <alex.hung@amd.com> wrote:
> Reviewed-by: Alex Hung <alex.hung@amd.com>
>
> On 10/7/26 23:17, Yibiao Li wrote:
> > [Some people who received this message don't often get email from biaobiao2233@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Yibiao Li <biaobiao2233@gmail.com>
> >
> > create_stream_for_sink() uses preferred_mode both as the list iterator
> > and as the selected mode. This triggers a false positive from
> > scripts/coccinelle/iterators/use_after_iter.cocci: native_mode_found
> > already ensures that an exhausted iterator is replaced before use.
> >
> > Use a separate iterator and assign preferred_mode only when a preferred
> > entry is found. This keeps the selected mode separate from the iterator
> > state and makes native_mode_found unnecessary. Preserve the fallback to
> > the first entry, or NULL when the list is empty.
> >
> > No functional change intended.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Link: https://lore.kernel.org/oe-kbuild-all/202609190901.yKTzhsGz-lkp@intel.com/
> > Assisted-by: LLM coccinelle
> > Signed-off-by: Yibiao Li <biaobiao2233@gmail.com>
> > ---
> >   .../drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > index d386bb1475..ceea8fe481 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> > @@ -1453,12 +1453,12 @@ create_stream_for_sink(struct drm_connector *connector,
> >          struct drm_device *dev = connector->dev;
> >          struct amdgpu_dm_connector *aconnector = NULL;
> >          struct drm_display_mode *preferred_mode = NULL;
> > +       struct drm_display_mode *connector_mode;
> >          const struct drm_connector_state *con_state = &dm_state->base;
> >          struct dc_stream_state *stream = NULL;
> >          struct drm_display_mode mode;
> >          struct drm_display_mode saved_mode;
> >          struct drm_display_mode *freesync_mode = NULL;
> > -       bool native_mode_found = false;
> >          bool recalculate_timing = false;
> >          bool scale = dm_state->scaling != RMX_OFF;
> >          int mode_refresh;
> > @@ -1509,14 +1509,14 @@ create_stream_for_sink(struct drm_connector *connector,
> >          stream->timing.flags.LTE_340MCSC_SCRAMBLE =
> >                  connector->display_info.hdmi.scdc.scrambling.low_rates;
> >
> > -       list_for_each_entry(preferred_mode, &connector->modes, head) {
> > +       list_for_each_entry(connector_mode, &connector->modes, head) {
> >                  /* Search for preferred mode */
> > -               if (preferred_mode->type & DRM_MODE_TYPE_PREFERRED) {
> > -                       native_mode_found = true;
> > +               if (connector_mode->type & DRM_MODE_TYPE_PREFERRED) {
> > +                       preferred_mode = connector_mode;
> >                          break;
> >                  }
> >          }
> > -       if (!native_mode_found)
> > +       if (!preferred_mode)
> >                  preferred_mode = list_first_entry_or_null(
> >                                  &connector->modes,
> >                                  struct drm_display_mode,
> > --
> > 2.43.0
