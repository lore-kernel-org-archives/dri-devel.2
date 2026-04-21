Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407E1F327B3
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A7C10EB80;
	Tue, 21 Apr 2026 07:12:03 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 300B610EB80
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 07:12:02 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-56d93355337so2540037e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 00:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776755521; x=1777360321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwInXibjWzl/vO4JD/MNvyHm7guro1FSh41fR8veI6E=;
 b=WIn2eVG3jOabH3KEBpPw7+tGcJRbf19DydTL47fziVZq90UPuNjZaDijybJiMe2kiH
 I0hbDmtr5f3f/Scda1h3gPDJFP4Tb0Hz3qjdFkppKygGiDdvwjg5lEljPPSaRP4jW2Bj
 T5khxgqhEMB/XuUScz1corHx+BLR8gn39d6kGl4rBCYgTX3DrxZF8zjK+Z0iQF0Sc3kD
 zTpVaoW/u+1c4h60aOFek0ep0OaIaAQpqZMK2RLmMDB2YZBVP+zEBKYSeEidOybsVaqF
 Okd84bEpiY3B0HZiapoqtYIeVGMB27ReFG8M3/f3Stmhqn4bvMZcFlEDNj7INBdlM4T2
 exFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wEtiNo7e1koV2r86ot8Xqy208WYq9esOHTIksrm0ovTpCCV495j9U52WD2jOVojV81cttBZUx6Xs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxH5pvfC6y1eBfWJJtA0aYOdCWqA49mNEdsiE+gRt8aZPIJFHOK
 dOY54ItEn9c2tveVaXW6uiFI96ooU4AXIG1cMoM8R4IeTfAS4y1XoMU+EU92l8l8dKc=
X-Gm-Gg: AeBDiesqOKYjRGx9OfHs7LQpjCGnLzYctJySu4JzHT9DihbHRKyTgz9g43wz+Edih/F
 qmfmkCkva60mZczozP1vRMSeu54jZeBrn1NIDmF+7xDdrBVUYKHZkPN0WbGdQEEaskSIf5Y+Mjm
 LrQzi2W8FIJhSLir3GzW2Qix2qRaedlSXDNw3zPQo1nfVXnrLwffpvszi6N0TwrFiVpGAXYjLHK
 5zkKX0CJFDWjzoI4OteInPMa/n7P4LAxMbVjOWJbKl2I/ZvRz90BITZlhUCAzKCXr/rr0a61aqs
 1NxEWpieitcKSW8gG1ZpERyb16v7h5l9plIykNkiZ9ei5W0cFkzrkeUT5M5AHsf7ghX5vB6+esG
 jOGbSQyg0ciaWydl2HpVCtrNLeDI47Tuv1Yp3ZYhzUMsqiTd2ybQCWeqXtaAwaxxV8Y+RA7p6Js
 p4pOyJD+dd2sdvTcCLXB/IUxP/PoXPWgDDWwPgU6FgNyAQ1UQXt2uP+fykeE13DQTE9XVDM8Y=
X-Received: by 2002:a05:6122:82a9:b0:56f:b0bd:2276 with SMTP id
 71dfb90a1353d-56fb0bd24ddmr7141448e0c.0.1776755520378; 
 Tue, 21 Apr 2026 00:12:00 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com.
 [209.85.222.54]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56fa93513c6sm7663639e0c.17.2026.04.21.00.11.59
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 00:11:59 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id
 a1e0cc1a2514c-9539d9f1675so2621301241.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 00:11:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/nTVXf55qTT/OsJmR0ZoDfQx0dJ5TAiysjwJlSGQ9SP52WbPAEPUrMGR5g2TUYWuRdpS5p9HeazVc=@lists.freedesktop.org
X-Received: by 2002:a05:6102:20c8:b0:61a:c2e2:932e with SMTP id
 ada2fe7eead31-61ac2e297e9mr2628301137.22.1776755519482; Tue, 21 Apr 2026
 00:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260417140231.3972749-1-chris.brandt@renesas.com>
 <CAMuHMdUVCtzxumM6yniuGTKfqG_z6BuySHNcZYE9UHP5AuDoLw@mail.gmail.com>
 <OS3PR01MB83197FBDFCDECBA1220BF52B8A2F2@OS3PR01MB8319.jpnprd01.prod.outlook.com>
 <OS3PR01MB83193C199C2DF1F2153827458A2F2@OS3PR01MB8319.jpnprd01.prod.outlook.com>
In-Reply-To: <OS3PR01MB83193C199C2DF1F2153827458A2F2@OS3PR01MB8319.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Apr 2026 09:11:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvUp00y2i-jB=1ZzTo9vQ-1+T_BRhanOWL+oX5CGinog@mail.gmail.com>
X-Gm-Features: AQROBzCgWJdDzE2USTixi86Dz844wFu7yea9_t_E6eSnIWvNdWuUZpLqybVPrSg
Message-ID: <CAMuHMdUvUp00y2i-jB=1ZzTo9vQ-1+T_BRhanOWL+oX5CGinog@mail.gmail.com>
Subject: Re: [PATCH] drm: renesas: rz-du: mipi_dsi: Fix return path on error
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Pavel Machek <pavel@nabladev.com>, Hugo Villeneuve <hugo@hugovil.com>, 
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
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

Hi Chris,

On Tue, 21 Apr 2026 at 00:05, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Mon, Apr 20, 2026 5:14 PM, Chris Brandt wrote:
> > Since it doesn't really matter -when- that memory is allocated in probe, maybe I'll just keep the original lines, just
> > move them earlier in the function when all the other resources are being allocated using devm_xxx.
> >
> > Then I don't have to worry about the it anymore.
>
> Oh wait, I guess I also need to change from calling dma_alloc_coherent() to dmam_alloc_coherent() so it will automatically unwind.
>
> And then, I can remove the call to dma_free_coherent() in rzg2l_mipi_dsi_remove() as well.
>
> Does this sound like a better idea?

Sounds fine to me!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
