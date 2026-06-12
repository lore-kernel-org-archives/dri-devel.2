Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A1FCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 03:42:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A2B10E91B;
	Fri, 12 Jun 2026 03:42:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZJdse7YB";
	dkim-atps=neutral
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF98610E91B
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 03:42:39 +0000 (UTC)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-66039d3efcbso573233d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 20:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781235759; cv=none;
 d=google.com; s=arc-20240605;
 b=I19Vg5gx+1Xu1rZbokjG0u7C08YZRiNpe12mdkUt6Ysw0r5nudPOF+5LPJtJK651l6
 pKxpc7Dlrke4bR9anSIF46WvE4IO5Aw5lzHMkjPm+AqB6VaoiEeHMPexlVcHlEEzZALG
 F355HiTXWGsl78pbPURBrJ1Ku15mYBkfd+2IeQ4qaZgQKiN1vxu3nWC8PpC9iP/8fPB8
 3KbezhM3kgtRzE7fMLQIuqp7P+71bYOGX1HNK92Yp6bMXYTUBBWxAcg44m2ggQpvJwFc
 cAh2iQDYVN2v+YLFk3t1tAxVu/1DMyDPcQ0mczPKC+HAKJtLKHJEi6ULMSdq0EBqmCkP
 sytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F2b1FbuAbMKG8c113cKqrJ2bKBY8pM/9wTcVdHGIxkg=;
 fh=JlnymEdUlO+AyYgJiVEhwYngtvYdIfEd0hDjLi8d8hs=;
 b=QLE0hAkWyNEts6vmsQ3pZs6QgTrxFRH4Hf1aJqy1qxdBzZOO2Gk1Hu0qjDG/p8w729
 j1YBBI5fzGFQhhn70wfaehIG6R8XVefQElvjBj30tcZ7rsdObTXngfMcr6B/hfJIWrn0
 V/O5xGpwU6/u+PIeKpWzJeqUjPJwtNhAcoQs43f71KhiyRBq2cdU2IM3Yzok/ORZOsmm
 be/f8FrVM/w0v/yowtEYgdwYj/GPApB9L1Z3Y/eml1EQ2yVJUTwxhU//VH/uSraRdx/R
 /tLVWiPNp7mIIVf0dCJqID3hzytbuqS832aSZ+D9Cn4fBP1qnuBypovObb++LRdz3Of2
 geVg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781235759; x=1781840559; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F2b1FbuAbMKG8c113cKqrJ2bKBY8pM/9wTcVdHGIxkg=;
 b=ZJdse7YBljmIvcc0E2mphwxVGYoXeHNjWkGOYCkU77UWG3u7xkyVsUzXQL4lrZFXPw
 ExTSrPrOaOpD2G8VEsmFlWOAxHAIU2WTpThODNd0cBkY9jHiIbEBig6XXbAexrEfWBkg
 gZ77RV62FSkob0hnoVWErhLK/AkRgcahGlE7EJ1B/EL6oS2VBGiJAoLJXlMEcKelcMGP
 CrbBcKmFXZMuxsQnFXcrunnBOZiOWCJN85G/OteQZx9vGw98UT1sHIpsJ9DhtXvVl78Z
 noOdt4gGtbSmn2+QS65/zmsn3zQDLZADFMAtOWcBsGVhIfkuCi2Ppyxktqh4kFboNbVj
 ubtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781235759; x=1781840559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2b1FbuAbMKG8c113cKqrJ2bKBY8pM/9wTcVdHGIxkg=;
 b=kUMUkbXRaAFjkPEUVA3+3xqiYqCE7N0LJnpvNjSBEH3DILlpaOR8chFTW0YhvagkBX
 7tN7zpet0cOyzfDoCimGhsWyrhGpTuJK6WuVSeuzMKvjOBu34AXdw025D5nKbEfRT0RR
 C9z/OdnMzVlbnFr72/u/nvl1gfjc21+T1Apz1GGSB/BtokET38L/4knT2hKg3zQTXSJ1
 j+mKT41iB+w+NfImOq/8/jsaB42Vm7p5ZrmCgxy08mOF0mrU7V8thOr96CHddginqMgO
 IsjHni7xtPD+fohqr8S5/c0/RXvl26r/GMTFYmoAzNvEMdgfBi3mjplHGw4W0+VDtgM6
 ZX2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uuDt00Y7lfXJSwYXURnARjoWJZ33dkj9yphGLCMWXKXJfyYjn6DIC6aUy5T7UBUaagbGqIcP1brc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxaMOjBLmZLJzT32r4HhUViblwVYjm286zhDayHeEwWpeXRVPF0
 oLnMC8WRB3lN0/w+lJHPk7ne8VjZWYgndbfgLqWoh6JziK4YvRp+hC5Tlv4r5Magi5cp8lvFAjB
 KaR550i3g3K1ddKFC4HBuLVlaEJDhVDo=
X-Gm-Gg: Acq92OG+sEbzSe1vwDlGfVVCb6zfLSD6If6WXojlRH8iiqQ+oaMd+jAXaiD5CtddZ1H
 z81oE9p4aoId0uPppKzY7B2RByD8HKbCpZC47sN7SZY8UEkqD9hMu8P5gVpg6MrbRwQXmfek1b+
 oidHwZa7L4QpjHH9DpUENSdnx7ZT80RC1wCcFjraHEaBb73sx9fGuJ5BAY7YK5+EA9TsceSOs7N
 jJ3zyD6kekfLAEs5Xu3VHiixPfLo+lL1ZeUX3/A6ArogjC2vRcyXhm/MsWRJxYz6iHSKSYC/NHT
 ChZYDSF3
X-Received: by 2002:a05:690e:191b:b0:651:bd70:161b with SMTP id
 956f58d0204a3-66277f4c797mr925128d50.1.1781235758651; Thu, 11 Jun 2026
 20:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260610035419.1596963-1-lgs201920130244@gmail.com>
 <ail6r13cZSN5EPLx@ideak-desk.lan>
In-Reply-To: <ail6r13cZSN5EPLx@ideak-desk.lan>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 12 Jun 2026 11:42:19 +0800
X-Gm-Features: AVVi8Ce4po4Dg0d4OZSFYJGTZQPPjfgeS2QsqZx_6UblnVFzZSwcDHWE8ndszHg
Message-ID: <CANUHTR84uSy15DCdXYr2DWPoJcx_0vnG3LfFb2x9Yt978K5tgA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/i915: clear CRTC color blob pointers after
 dropping refs
To: imre.deak@intel.com
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Uma Shankar <uma.shankar@intel.com>, 
 =?UTF-8?Q?Micha=C5=82_Grzelak?= <michal.grzelak@intel.com>, 
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

On Wed, 10 Jun 2026 at 22:54, Imre Deak <imre.deak@intel.com> wrote:
>
> On Wed, Jun 10, 2026 at 11:54:19AM +0800, Guangshuo Li wrote:
> > intel_crtc_free_hw_state() drops the CRTC color blob references, but
> > leaves the corresponding pointers unchanged.
> >
> > This can matter in intel_crtc_prepare_cleared_state(), which frees the
> > old CRTC hw state before calling intel_dp_tunnel_atomic_clear_stream_bw().
> > The latter can fail while looking up the DP tunnel group state, for
> > example with -EDEADLK.
> >
> > If that happens, the function returns without completing the cleared
> > state preparation. The failed atomic state will then be cleared by the
> > atomic core and intel_crtc_free_hw_state() can be called again for the
> > same state, dropping the same blob references again.
> >
> > Clear the blob pointers after dropping the references so repeated cleanup
> > of the same CRTC hw state is safe.
> >
> > Fixes: fb69d0076e68 ("drm/i915/dp_tunnel: Fix error handling when clearing stream BW in atomic state")
> > Suggested-by: Imre Deak <imre.deak@intel.com>
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> > v2:
> >   - Keep the original ordering in intel_crtc_prepare_cleared_state().
> >   - Clear the blob reference pointers in intel_crtc_free_hw_state(), as
> >     suggested by Imre.
> >
> >  drivers/gpu/drm/i915/display/intel_atomic.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_atomic.c b/drivers/gpu/drm/i915/display/intel_atomic.c
> > index 71b7325917b6..0cdae87e4bfc 100644
> > --- a/drivers/gpu/drm/i915/display/intel_atomic.c
> > +++ b/drivers/gpu/drm/i915/display/intel_atomic.c
> > @@ -294,6 +294,12 @@ static void intel_crtc_put_color_blobs(struct intel_crtc_state *crtc_state)
> >  void intel_crtc_free_hw_state(struct intel_crtc_state *crtc_state)
> >  {
> >       intel_crtc_put_color_blobs(crtc_state);
> > +
> > +     crtc_state->hw.degamma_lut = NULL;
> > +     crtc_state->hw.gamma_lut = NULL;
> > +     crtc_state->hw.ctm = NULL;
> > +     crtc_state->pre_csc_lut = NULL;
> > +     crtc_state->post_csc_lut = NULL;
> >  }
>
> Could you still move the clearing closer where the refs are dropped, to
> the end of intel_crtc_put_color_blobs()? Otherwise this looks ok to me.
>
> >
> >  /**
> > --
> > 2.43.0
> >

Sure, I'll move the pointer clearing to the end of
intel_crtc_put_color_blobs() and send a v3.

Best regards,
Guangshuo
