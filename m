Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71461C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFC610EBAB;
	Tue,  8 Sep 2026 12:19:48 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A87E310EBAB
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:19:47 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-52cd38ddcdfso51290041cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 05:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788869986; x=1789474786;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ofUUPAlzK0RlPGiJuLSG6vss9ksk5CLPkzJ8jLWh4TE=;
 b=EV6VOw66aM3Z37qD8t9BVb3zLtbPoSglhXJ0PJ6v+ewRqtQq5dy0ebAIKh/HFFjUFw
 xZSSXU/RPpPyevVW8vAFaO7Hi+KM1F7fA9O6aRRidyl+EikEt8HqEMpOvswBdq7ed5/F
 SPGUBd0R+X93m8AkP8VlGBGy1d9ohUF7RBOE9VYeGGV5+Mm0vENDC5/cC4CZjHAfyy+7
 FY4vfj3CcBU7LvqzO4yx0aV9AkOeeieLPvJJgz3XzqdZ7nYSLEiXBoZTeBMpSu4mXczs
 nEHB6eLkisH/qPmXXKF22kYK2STV2YvkM+wENTeIkTQP+t6NWV8zXYNgOOPUvyM/XZBN
 gWOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+PB6/ye1lITpgNOYYlJn/hYvlgCthv0w5rejAFR7x7vug0uUCvhKPivOIRB57S84hoq6v6pTaSGE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lyLYrg3PTyxcHiVb7+AxbFI4jaenU5zDCqG4nxIS+oim0OLQhr
 PwX9Qn6upEz6binkFSOU5TyiRn4rhucvrwNY/NaG56fwlV3a4wGdfZuUnopYEz+2
X-Gm-Gg: AYBFou0jHhaLwLrWRLyeWDhoOMlZGRyPdh9Tu1Wtc9uZfLpjVTa/TVnGfqeJ3gCYS8U
 h09fL93aggIxc0TeDArCrIrWl1Mm7qezvkCmpoqN8UbtgiXaAI8CPBz564U2BAmIYPCAMFuBnQ5
 dHO8isSflD0OxPQ/6owNnZokKpNZSrK7iSNl3uQM+DDz34ZAYV+jkmA5RB99N2Zmfp2/iIYf2ue
 KPW+c6A8WWslGE7qvjgfJ/uwn6v2z+jratbLIw4Htsxml3NrR9+Zv7xpwr0Gt35EhCUVyKxmkt6
 czS0bHoXxvCobbgRSv8bY4EtczZCMm9KAzXZ91I9dhjAt+ILgbNHezFGq1ksovAgoipeaM+z7N6
 cYVFClvrfQQpqd4s6YWcmQDISV3s7dGmIzxsbENbiLcAdLOsa1Ntoe+a/RtW8+tgl+HiqxWCUZ0
 3Ulw/hwmO1ge36DMb6W8nPq6hXZErRUa9ssMIqHMa//H03sISRNQPivOHr2Q88unJ/FRKWq/dVn
 6xLsuESD5LUa/dpMQmx+vCO19L6sw==
X-Received: by 2002:a05:622a:4c1b:b0:528:38b1:b547 with SMTP id
 d75a77b69052e-530547feabamr374273691cf.8.1788869986430; 
 Tue, 08 Sep 2026 05:19:46 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com.
 [209.85.160.181]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53080ce82aesm53627021cf.31.2026.09.08.05.19.46
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 05:19:46 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-51c0c45c580so49696071cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 05:19:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwyTLDvVbM7lvJF5sdy3s/vos5pn/Q6UWvqr3WCiA/Ka0T/zP33G0RNAu1pi/BZuowCO/SA0TLEi7A=@lists.freedesktop.org
X-Received: by 2002:a05:6102:8098:b0:783:79ac:9dc3 with SMTP id
 ada2fe7eead31-78a4a880ccdmr9426846137.10.1788869517073; Tue, 08 Sep 2026
 05:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
 <20260907-rcar-du-dsc-v6-4-f8ef711a7494@ideasonboard.com>
In-Reply-To: <20260907-rcar-du-dsc-v6-4-f8ef711a7494@ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Sep 2026 14:11:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXA6koxaUjv7hobWhL4eJHHDnBtn6Z44uAbf=3thn8oew@mail.gmail.com>
X-Gm-Features: AcwNN1WQMv0pxPEjkRceB80LKKGbxYp0qnUsTTCp1Uv8lpJfhrW-zDPu8BR9rQQ
Message-ID: <CAMuHMdXA6koxaUjv7hobWhL4eJHHDnBtn6Z44uAbf=3thn8oew@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: renesas: r8a779g0: Add DSC
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
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
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

On Mon, 7 Sept 2026 at 11:30, Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> The Renesas DSC Display Stream Compression is a bridge embedded in the
> Renesas R-Car V4H SoC. The bridge is placed between DU and DSI1 units.
>
> The current dtsi file does not represent the DSC at all, and thus the
> pipeline for DSI1 has not been functional.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> [tomi.valkeinen: separated the sparrowhawk changes]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.4, pending acceptance of the
DT bindings.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
