Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80032106FD9D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A7E10EB32;
	Fri, 13 Mar 2026 08:42:45 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3074610EB32
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:42:44 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-56b58473bb6so1229561e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 01:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773391363; x=1773996163;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=coFdykaFhQc0bQ/g4Wh8hLjrN7rpqsPnMcfIcHyR0fw=;
 b=U3UzP8IK6p2JhUQ1yrxHl8KFxdzbc1bTDx/PZbnZ5Y42urtDOOLUCtrkvwz1IsolRE
 C0cA0xj5Xi8o+8sQDe55NVtzlHSPaqEKRPd6CER7yvyr/8nvK6gX3w6vGMY6DXituYA1
 OxkTQ0KY9NKEYZASwYItfuqlc8bM8C0n5SUf4MVgwnWAMeoaFl/T3vVeVL52yw5dI2Mj
 wx4tLKhmC/NYwHtpl4drVJKwpqkhm2zgz6qyIqL33uH/H8TlmsvxXQXZeLLvcB/qmQqY
 zDatBAujOMOBrwGPABPUe09om4kINXXLtsYDvcLgEKIKn6xzx2AC3EHykuoZkIS8F+UQ
 XepA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmJnpGuD68DpCEopEGw8ywcdxzLm8v7TAA1REOVVHQEfJ7/vhAduqqBH5hgFJwEbBy5zq1Venbpf8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyFnRnQuVpNiL2bR4aKw7m89P+178pNXaj0j+dsfVqQaRFxevP
 cNz1tToNVoF/AIri3Lr0BqkQZgUPGkzOCYHFeqOKmdDaLhl0UUL4fshpOz0oud6bv6w=
X-Gm-Gg: ATEYQzw7hxI5Xygvi/ylFnfCVzkmAI1lN30CZfooNI7PbY97g2Wnwt6aWhSEpAzWIau
 Iyk+jOixGdI6MrM3ZZHun+2Tgqr6YgDeIUvEb5Fa4D7dCSJ/Mn3hvbvXJ8S0jRrK8gzgdh5i16+
 rE1Iu2RtUwJDalFyV2DkpXlx0iwoo0NxTiHAabxbUSWUD5TCDwuTX/68tdfaHzY+QsDxS92PR03
 YBokUUQVvEYp126cSuhH1juJG2pofFwF2Z1vZubHmYNG8Qw9njHij/+A4Q5dpJEcuQ8p1sXeJdn
 jZ4iJkXkfhRMSzEv3MXNlwwfcCFORwksnRpdQIvaSn/XX84XGpUb5L/GAerOwssKCqVl1gT0AEe
 aY8XcSR+q33usgstoSEU9fFo6opnxr1SA4CHI85HKseJA3pA/bwH88ozdArp1Oh/rVfrI1x/ihS
 JX50M9H353NlePyfnyTlEU/NfCs8reMbJUBWZgUlexaAeOMirUdnOEDCp4dTei
X-Received: by 2002:a05:6102:3711:b0:5f7:2430:cba with SMTP id
 ada2fe7eead31-6020e20d4bcmr1222945137.12.1773391363167; 
 Fri, 13 Mar 2026 01:42:43 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com.
 [209.85.222.48]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-94ecfc9cb40sm2555096241.5.2026.03.13.01.42.42
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 01:42:42 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-94a231b285dso864496241.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 01:42:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVJt0Kb+Y3BVWUyKJcSBIieYGjZk6ZrRRTEzKhqqIK4G4KwKXcOmLX0x2S1ZdY7Yl38+eSCEWvX3Ec=@lists.freedesktop.org
X-Received: by 2002:a05:6102:32c4:b0:5f8:e4c1:7bd2 with SMTP id
 ada2fe7eead31-6020e2172e9mr1003965137.16.1773391362257; Fri, 13 Mar 2026
 01:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdXrYTGQkjC1Sr4NjOcsRyOw3_eEj9m5MVVo1GWUuCxo3Q@mail.gmail.com>
 <20260227095742.4449-1-phucduc.bui@gmail.com>
 <CAMuHMdUNA=wTksUEmnW7NQ=XCjMBuHDyJy-XqZh4yRxECNFuwQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUNA=wTksUEmnW7NQ=XCjMBuHDyJy-XqZh4yRxECNFuwQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Mar 2026 09:42:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJQmfU0p=yk1kROTm=ZiiQoUHZQpw5kj813x=RWCS1fg@mail.gmail.com>
X-Gm-Features: AaiRm533L4rgQGHamcsBJAYP34l6jzwmxk9y4dM9xwhf4jREg3YdsecGp-kRNPY
Message-ID: <CAMuHMdXJQmfU0p=yk1kROTm=ZiiQoUHZQpw5kj813x=RWCS1fg@mail.gmail.com>
Subject: Re: [PATCH v2] drm: shmobile: Fix blank screen after resume when LCDC
 is stopped
To: phucduc.bui@gmail.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
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

On Fri, 13 Mar 2026 at 09:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 27 Feb 2026 at 10:57, <phucduc.bui@gmail.com> wrote:
> > > What do you mean by "deep sleep"? s2ram? In upstream, s2ram behaves
> > > the same as s2idle, and the LCD works fine after resume from s2ram on
> > > my Amadillo, with and without your patch,
> >
> > > What am I missing?
> > > Thanks!
> >
> > Thank you for your feedback.
> >
> > To clarify the "deep sleep" context, I have tested both s2idle and deep
> > states using:
> > - echo freeze > /sys/power/state
> > - echo mem > /sys/power/state
>
> OK, same for me.
>
> > On my hardware, the issue is consistently reproducible in both cases,
> > resulting in a completely white screen after resume.
>
> TL;DR it depends on kernel config.
> With my .config, your patch is not needed (but it doesn't hurt).
> With your .config, your patch is needed.
> Unfortunately I haven't found yet which config options causes this.
> I will send you my .config by personal email.
>
> Your change looks valid to me, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

And of course:
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
