Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EA1CD3447
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 00:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1763110E3FF;
	Sun, 10 May 2026 00:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gsa0+jYX";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB6E10E3EF
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 00:14:22 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-bccb9dca1beso83152166b.1
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 17:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778372059; x=1778976859;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0IEw6PL++3nRwVDi7bI7XIxavnaE4whVnMCPLVR4zQ=;
 b=gsa0+jYX5+CkuAeSfkvFvD/6wKez4DrIW0tc2nKsucP35gGtxQrVBH76Z23WTaE2CF
 eN/dRpQlBFXUBpWjYD7PmpXmRuL5AV0saXF8Fhbv/8x/KI16c7+nxj3bBjNaDfyCBTxn
 W5f/Lvq/6Cue/U68vK27te5yIVeLvhzrWNNCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778372059; x=1778976859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I0IEw6PL++3nRwVDi7bI7XIxavnaE4whVnMCPLVR4zQ=;
 b=TJlBmicNhMAjHuQ9QrKUVB0g5wjuUtqlAXPM6H6i60ulbvd6AM03olrczpHuMdoJ3/
 NLjkrL0J/Fluqp11T5F8nvo5Uzn5p2Q4BOuZx22lGm1mDsJRLy6FLAoPv0rGnr60+QzP
 t7AljCOWQwpwMNuzQorVfbl9relZsBmSKR2BdfuVfy/Ab1W2USGaaZwSYMsW/FwybzwA
 U5SH7Pphm+mJGa34B27O0Y+fCbHb5OcsNCxiHqcWWn9AH7HkmfBQowhn6EqT7UQP3Y+Y
 YLG0lkf0o51M46nMm42jy2GdzVK17HL/kFFttrZuZ8B+RnvE3rn4FcSang9fstNqrdiX
 M59Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BmJ1DkJr5UQCPRM5FIGyVvscWt9BSICNnUuhaUcf3V/P34w+KXRTUpreME+CJxTMcnLUdAdAOh78=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxw44R5LxECTq+cSnGQ0DwIW0BsbKurkIteP9kbA+vkMODweCx0
 L9pzUJBCYPAfOzr2GbkR8ST36/MqZTkZTcbaMI74ad1b2r2TTYg0lX5lWd5PKqYzwg4DkmKzM6T
 jw5Hemg==
X-Gm-Gg: Acq92OGazGdrqT4TuKM7+fzjxIhOpbO9pi6NpIIttg/c584fmSTmwhNPwk/hmYawTju
 xdvZVXLWwI3Au07IoPG9qQsdguilmv929Jf/Oek1Mtt5UAs9PgsHjvIl4FlP/Y74gIMtSBUwxUn
 k8d3K3uFDMSuJCOVUPGXs3AxvgkUa205iOeWY8P9H02xP8k7h6LlNjrKhkbo8fMrjGxYbsVvYjD
 Uq+r9KiFTnQZAbBg6Ymye+AP5kAJsbivfSzh4T+WT87h2qzjrAsm5Rl02GthLVYH7ynO4KKw1hm
 D0f3sSH5VSuJMiSTIUJWQ3LuIkMgNm5aAClpSIF34hZFFJztwGMspHRjcnEpUNI+TdcRA4YIL8W
 /S/tu9fUwcUsuhIGFeS0svSDMzGRBYG+2xLDThlQOErm6fwKI5JKq1sZETCilV4FlH6Yn8V6Ncz
 grg3RfMl2QMrNJuOSjS05O7nyz3KQbyKZpxX2pnfabP9rvlqwkqqWqPAZD+0AvV+QoKJc1GCaI
X-Received: by 2002:a17:907:809:b0:bca:48de:5cce with SMTP id
 a640c23a62f3a-bcc1499a53cmr154485266b.36.1778372058867; 
 Sat, 09 May 2026 17:14:18 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bce33b0071csm19695766b.51.2026.05.09.17.14.17
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2026 17:14:18 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so1828939f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 17:14:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+0sU0K2Zv/wakDhnPrQxGe6niUi+wPGEc9sd8BHIllTKZ50TmCza9hpSLaHRs/MRUtfZ7h4gHRwGY=@lists.freedesktop.org
X-Received: by 2002:a5d:64c5:0:b0:43c:f8b4:e58 with SMTP id
 ffacd0b85a97d-4568e708e16mr6458511f8f.41.1778372057073; Sat, 09 May 2026
 17:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260506170607.10813-1-terry_hsiao@compal.corp-partner.google.com>
 <20260506170607.10813-5-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20260506170607.10813-5-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sat, 9 May 2026 17:14:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V6rervT6kvbxh7hxBNROBEQmG7yMNia6s6apsOoLqh_A@mail.gmail.com>
X-Gm-Features: AVHnY4I9hSF-hlkcXuEV7Q-0CAgOEeJBT2h-a94MR8FWP6eX1BPFn9iz4ipBsNM
Message-ID: <CAD=FV=V6rervT6kvbxh7hxBNROBEQmG7yMNia6s6apsOoLqh_A@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] drm/panel-edp: Modify panel name and delay for CMN
 0x14d6
To: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Wed, May 6, 2026 at 10:06=E2=80=AFAM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> Correct the panel name for CMN 0x14d6 from N140BGA-EA4 to N140BGA-E54.
>
> Additionally, adjust the power sequence delay_200_500_e80_d50 to
> delay_200_500_e80.
>
> CMN N140BGA-E54
> 00 ff ff ff ff ff ff 00 0d ae d6 14 00 00 00 00
> 22 21 01 04 95 1f 11 78 03 8e d5 94 57 53 93 27
> 21 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 da 1d 56 e2 50 00 20 30 2e 1e
> a6 00 35 ad 10 00 00 1a e7 13 56 e2 50 00 20 30
> 2e 1e a6 00 35 ad 10 00 00 1a 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 02
> 00 0c 3d ff 0d 3c 7d 11 10 21 7d 00 00 00 00 3d
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 427a4b4c6712..295412ba13cd 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2069,7 +2069,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x14a8, &delay_200_500_e80, "N140J=
CA-ELP"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x14c7, &delay_200_500_e80, "N140H=
CA-EEK"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d4, &delay_200_500_e80_d50, "N=
140HCA-EAC"),
> -       EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N=
140BGA-EA4"),
> +       EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80, "N140B=
GA-E54"),

This makes me at least slightly nervous that the manufacturer might
have used the same panel ID for more than one panel. ...but
unfortunately the original entry was added here:

http://lore.kernel.org/r/20231107204611.3082200-4-hsinyi@chromium.org

...and that was before we started including EDIDs in the commit
message, so it's really hard to tell. :( It was also made during the
big batch of panels added after the fact, so the chances are that the
datasheet that Hsin-Yi was looking at was simply not quite right.

So with all that, I think this should be OK. The string name doesn't
matter a whole lot, and from my experience the disable timing isn't
one of the most critical ones. ...so I'm going to go ahead and say
it's fine to apply.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[4/4] drm/panel-edp: Modify panel name and delay for CMN 0x14d6
      commit: 9abe13a0598a8dae9a24c1cfea5643f8e12b49ed
