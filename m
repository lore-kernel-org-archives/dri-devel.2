Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEADFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3BA210EFBE;
	Wed, 29 Apr 2026 11:46:19 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22F5D10EFD2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 11:46:19 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-56f65f62b4cso4031273e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 04:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777463178; x=1778067978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eQI/JeVJWqMxkzWYnwpYH2rFZzbRa7DUVbDEpXwBWE=;
 b=jnsglXBVxKxfD6uTFOUoyc2X/HYAon0uIiBveBw8qBCDb1U5UrYbrDZmi0NsItGic4
 +b/8eOdl4iS6FCQZcsnRWhdqcCtjmC3LdL5JI0fLIZPPpUE4NGxh4o6YKNDmcIvPqRPd
 CvSYIIYQfXoHRb5IUSH+B8h/iJmadPIGD831AuNEmns3JeJwPSGkW+3//hsvCaAE84K1
 leWHbYPjSl39c6IvZ+dRu72ZhBWKWYJSuqs/zqCCNNRjd1JJoqRURyZx6wiRuajHtynS
 hz4MtPdXzVSMR52Y5HgEw8pxSEm+0bNqy7EZcsxFRYZMz0ERFw494AYkmCoItjojbQW5
 h0xQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TVfK5tMB021cHYuB07U4vyvsMuq9Cm8HuWOxRTlPvn3p55WzvHriR7FYbjEIKwYWSslNeiwXlwcU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcQTjE9I5C8SJgBzx6rCcNIox8xsAb4IZ9/5NqCmDa6u8yLALu
 tza7Qzdr89476zQrl2rabMHdCZ8ynzXn1/iKZSdo9SQSlT7WHFp/MCFCn+p9Dxeq19s=
X-Gm-Gg: AeBDiesYozcmrXZaIK1rim8+o5iuZl/ZdCckIl9/u52mP8LeKhULnG/EgKkvKzZXCLl
 ShlZXX/1vrrnd/WFETF8CoPc1JrPXB5HrNcS6UyfH0m6MeZhxu4Oq408PFjRyA0CNvuZgIxUOGA
 jYem1MtPGla2Ug1lwb058isDpMNZOB8FYlaAScqgP71Y091wYszxZqA913WES57bQg0edrkDJ3H
 DnnVtKFtIoDnsrFDJbTFfvhFtrcyZ9aM+aPcuoK5pSWETGSbuFPf9Smvg2i/hfsT3QWGA4M6nhd
 ZRpTLs4TqNW3/dU+Ea7sJWZVZh0i8GMVJLbnTqGKW8eItfkwbdYottfzqCadbEeVzMRUcd97Viz
 leHoseCrM7OAXj5kA1Tv29HLcDsP+9ReYRt31RfSi3kPH6C9UM4tY4BmxNjW3ugm0fVMP1RVgHU
 PBxgZqEMXYctgP9T9GxGjUeAiyKeemrlsSvc4DlTPiso0CDIy+8mOkOhwf/C11T43IDRc/1KU=
X-Received: by 2002:a05:6122:2108:b0:56c:da22:6921 with SMTP id
 71dfb90a1353d-573a558f3famr3664970e0c.5.1777463178093; 
 Wed, 29 Apr 2026 04:46:18 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com.
 [209.85.217.42]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-573b6d8b84bsm894611e0c.10.2026.04.29.04.46.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 04:46:17 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-6221c7251e1so1885005137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 04:46:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+c54dHkMFm1k4RGMur1bv5JLwFBxeZOWOdPYNFR5H+Spds8WSEgbu7zFRNUX3/bX8R++HHyfPCPVU=@lists.freedesktop.org
X-Received: by 2002:a05:6102:8496:20b0:60c:fe65:7dbd with SMTP id
 ada2fe7eead31-62808c547e7mr2534931137.5.1777463176356; Wed, 29 Apr 2026
 04:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
 <20260419193718.133174-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260419193718.133174-6-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Apr 2026 13:46:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU7Wv=ff34PGtauGE=pxu-gz60bYckFvC0s_7+NGF2sSQ@mail.gmail.com>
X-Gm-Features: AVHnY4LIrMWzlW7YEacrKVCpl1tXW3XTPU8aR2UA76Yz1rMTuJKkQscGTQj67Yc
Message-ID: <CAMuHMdU7Wv=ff34PGtauGE=pxu-gz60bYckFvC0s_7+NGF2sSQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] soc: renesas: Identify Renesas R-Car R8A779MD M3Le SoC
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Stephen Boyd <sboyd@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
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

On Sun, 19 Apr 2026 at 21:38, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Add support for identifying the R-Car M3Le (R8A779MD) SoC.
>
> The Renesas R-Car R8A779MD M3Le SoC is a variant of the
> already supported R-Car M3-N SoC with reduced peripherals.
> Enable support for the M3Le SoC through already existing
> ARCH_R8A77965 configuration symbol. PRR reads 0x67c05501 .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
