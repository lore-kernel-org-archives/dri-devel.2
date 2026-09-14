Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394BBC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2BB10EBED;
	Mon, 14 Sep 2026 08:11:23 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7F610EBED
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:11:22 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-8073433285dso596445a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789373482; x=1789978282;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G2JcK4+UnTdYFj4YxjDgOg657J6kp6BHITWmwnB32W8=;
 b=I2PqQ/RbGuTV9OWpEjSGV2Uudln/7LjiCHTtpTSN4ExtcaCw4jWiSX5008r6ll1O7v
 XljerDczbkSMB0mUERT3LXDROGvHdKXg0LByM6lON4+sgP42lGVUw6olC8PN+R3V0mRA
 biF35Lk5i+bbovusfs4m+/8UUBu34Fvd+grb2O25n/bUbL/fVaqYlOQTzIyfhtNeK52n
 1LVkjFUJ54ruM80bGpFOKxX8TFVKF4oZzsqP280OC19M63F6DqdncEfI3m40CsEevNu5
 GA6SHy6KrCyx8TRB1PcTVCCmGnYrH/Abirl6QFU8oGEsZ2liKUV06wM1TA5fi+TtxMbQ
 G9tw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgeQnfuaTEHlhMBemji/TqZCsp2ZqduyRB4495I5rk7JFJ5YVF48b0ujLry3NvpzhQ20KiNy3kk3M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n9Ltirwb+ABoc7dapRtnUERPOksjNFJchCUFxtxcZ1OQPczUZg
 3pXULvKjIxEgPWmW7AH4gyAXFJqLLN5reiAv5noOKziO3CAol4V3OFOILTDIbG+v
X-Gm-Gg: AYBFou3DLPmKPXdOsbbkaJX5Qg5msyWUm/azHs3cTfBCDGQ/8KnCOrkeQWM+HIcmIou
 k8tazKNi9+i5Sho9ShRqNcLQWmyPrE+W1OEZQXRd3uvwuo5ARceLUzc/RY75Zp39Zzi1BUn3PBT
 QXifpPP6Dy1wcduHk5DhsBWyGcRHeOt/GDdStoWbPHnvQUGYT9ulno/+PWt9KbcDzQXC5iRqhl6
 gCUweR//VhlofN52XsNSejyDDFTd9DldVDdGQ9DcFEynkwx1f6NklAAIRgU3P1mE4JA8m4q0Q8/
 Zp65G04Ji1+e8/koibSSxkBjCwc5QgDb3wmwOohv7DnaII0ANQj27VlAM94Ez6mc9erRyuf5Ve3
 wW32sWf9rGrD0/Zc0IMesgREmtJ/KtOVoAd1SeZKq/0aMZMDuJaGHl552KT13t4TeMKjrujeClD
 ThaD5Z/BGDCXOlQtHZvwzH9nBXolYQdWeoVKheugaTvNOHYc5VYwoY5T1NkeqHbUUfodJg9N40A
 boB1uwJxFu/ODMRKg4jHzKDrEIzYFOoCsPV
X-Received: by 2002:a05:6830:6d23:b0:7e6:dc7a:f459 with SMTP id
 46e09a7af769-80897894ef2mr810731a34.11.1789373481548; 
 Mon, 14 Sep 2026 01:11:21 -0700 (PDT)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com.
 [209.85.161.51]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-805cb5ba734sm6066877a34.0.2026.09.14.01.11.20
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 01:11:21 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-6b1afdf98dfso1919241eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:11:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzpo1xXAp9i8CdpirsWsJ3O0eeNXtc5quh0RFG/qBkW3pUryEbRbUcFoDc0Y7dEx/8eEGi3ZoVT558=@lists.freedesktop.org
X-Received: by 2002:a05:6122:4905:b0:5bd:cb34:1b70 with SMTP id
 71dfb90a1353d-5c981a7ddc0mr603320e0c.1.1789373084860; Mon, 14 Sep 2026
 01:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
 <2489cf57-65f1-4502-86ae-1e3673899b87@ideasonboard.com>
In-Reply-To: <2489cf57-65f1-4502-86ae-1e3673899b87@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2026 10:04:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfmVHsJBtnn0sB1f6YwnVpQOY5coP0pu6qOsknc-XfaA@mail.gmail.com>
X-Gm-Features: AcwNN1UjvEXLwhrFNF_ZKWONSXtVIhmEHRxBRtfYrWrrOz2Bml4dSuA03jjsOBQ
Message-ID: <CAMuHMdWfmVHsJBtnn0sB1f6YwnVpQOY5coP0pu6qOsknc-XfaA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] drm/rcar-du: Add support for DSI pipelines with DSC
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-renesas-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
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

Hi Tomi,

On Fri, 11 Sept 2026 at 09:07, Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> On 07/09/2026 12:29, Tomi Valkeinen wrote:
> > Some DSI pipelines have DSC (Display Stream Compression) IP block
> > between the DU and the DSI. Even if DSC is not needed, the IP must be
> > enabled for the DSI output to work.
> >
> > This series adds a basic DSC driver, so that the DSC IP gets enabled in
> > bypass mode. This enables DisplayPort output on Sparrow Hawk board, as
> > the DP output comes from DSI and sn65dsi86 bridge, and also White Hawk
> > board's second mini-DP output.
> >
> > Original series from Marek.
> >
> > Note: I see that not every run of kms++'s kmstest gives me a picture on
> > my monitor. Sometimes the monitor seems to be trying to repeatedly sync,
> > but fails, and the screen stays black. However, I see this same issue on
> > WhiteHawk, which uses DSI0 pipeline, without DSC, so I think that is a
> > separate issue.
>
> Pushed the first three patches to drm-misc-next. I'll leave the dts ones
> to Geert.

Thanks, will queue in renesas-devel for v7.4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
