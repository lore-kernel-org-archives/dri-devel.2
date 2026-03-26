Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CA410A62DA
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014E210E217;
	Thu, 26 Mar 2026 14:11:07 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 303E110E217
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 14:11:04 +0000 (UTC)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-94ac5cb71feso298458241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 07:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774534263; x=1775139063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+bKV+ZQocjR4wxZ5VtPX9Yx9FjCc2fmvfO12wKPoP8=;
 b=hli5rUG3l1jdZkJrPZiRBrZMeVV99Q9nE/H5p8170B+oJH6bSqAUfYzCSqyBt6QrWb
 WDIpVuJ7lPTMiXeH/ddNo+6JfmKPrgfBlmXazskUgdyuXmZF+77sTa5BCDjlks+1CaXH
 7X/ZmK1WrIdF5clwHSGR1RijVOd2S4I/i5kKSrAZ14GSiq14J8sPzbV29HcxRkvfcnhL
 s6DAaZJvdjApArlHDeKaHBmkPmM2hlVGm4LCSzmxDK8jX/3mEpVBz2LZKH7zDpfXDR+z
 P8BGFZvysewMBGEJbh0mbJdC5PcbvOvlVlsfIasUvOuWDO7VxQs3aS8xH6rx7zwyNcvK
 ZnwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbbuF8a/1I1taALOFTLdtf9gZAgJhm4YGB0vsQR+SxaAYJ8pKNKqh2WYu3oFPlPwua0Y+02HDR1n0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsBalSVZ1sbG7ivPLFc5qmbCtQl6KWD6izDl7fY4cps588eLVm
 PY88m3DwLm0WSkMC/29xiNrYOej95voyXkTemKg0C9c/CatI/536BLCy54OhcHXJtNE=
X-Gm-Gg: ATEYQzzc/0G3IolxpdpCkncEjELPg1JOUKnux0uGbtoUiW6QDjAVZEfYtm3/HwjKh80
 r+mLc4AIt0WBKqUbbp2NzrZxJoc1MYcHxSVXSF/q71dK36f77GMo+8AJWPAMFO3ShC6WeyjX8Fe
 i1LIKESizCkWY0uEr/X3/BzSJXyGeNB4BtNHBWmGZOYEU5QNRi5ulJeqOhLTcoZg86EyYrupPEj
 xK2MGzeIeZO5lQhESbyRagag15PczRQU6JKuJTxSvAb3VzEn3TtkYUGf5PkUZSDKxxf54oI/zjv
 /FekJKPZ1BeHTOjXbPfWHyCg9UF/1UW0dxMC6RPHvo6nOCuutmT0IS2SY0yu8DlZeQjryUWdogg
 J2M7/iTQMcuBoJ+OCkh+wZGYdJTO8B1eVoOAPfxguEWJN5H+1CzEgVeKbv6hB9rKppKbu7XLPbJ
 qIHf/u7RjTwtjZGnu4Dj+w7N1m0deMl4veTWwC4K406DI0e1uvmQ67WFpA2Sbl
X-Received: by 2002:a05:6102:149e:b0:5ff:ea33:2c0 with SMTP id
 ada2fe7eead31-60387334d20mr3495707137.33.1774534263321; 
 Thu, 26 Mar 2026 07:11:03 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com.
 [209.85.217.46]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-951be5afa8bsm3922386241.12.2026.03.26.07.11.02
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 07:11:02 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-5ffa0b23a60so366117137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 07:11:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWeKZT3yasE/K6MQ4h/C0FY/Hb3wvA52EsXYeZLPU4+AN/HGI5NZcZ8nQ/qE0XEnTGPhvYjYt56ZmM=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3976:b0:5ff:e769:44bb with SMTP id
 ada2fe7eead31-60387319018mr2792199137.30.1774534262074; Thu, 26 Mar 2026
 07:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
 <20260320164158.487406-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260320164158.487406-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Mar 2026 15:10:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWqgVmugEVV=k2_u1xKRswu+e8Hhi7dKD=E4Lep9S96OQ@mail.gmail.com>
X-Gm-Features: AQROBzCL0y_jZA3BBZ1V00Z_wgTT1ywsDaOPuag8T0_jf1tfWGKQ90rerqBeNPg
Message-ID: <CAMuHMdWqgVmugEVV=k2_u1xKRswu+e8Hhi7dKD=E4Lep9S96OQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: gpu: mali-bifrost: Add compatible for
 RZ/G3L SoC
To: Biju <biju.das.au@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Fri, 20 Mar 2026 at 17:42, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add a compatible string for the Renesas RZ/G3L SoC variants that include a
> Mali-G31 GPU. These variants share the same restrictions on interrupts,
> clocks, and power domains as the RZ/G2L SoC, so extend the existing schema
> validation accordingly.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
