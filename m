Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE3DCD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AAB110FD35;
	Fri, 29 May 2026 11:45:42 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10F4510FD35
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:45:41 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-6c449ac3588so26940137.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 04:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055140; x=1780659940;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tI1s7RBWZ86LPvUzgArfAozo8RX0QfMdUCXZm64P2Is=;
 b=XV1XvaXbvk7gRAXCR/jv3gcVgLi1d4VrGDzGLgdRm2QxE3qKNmxFd6uboEJJcU45vh
 3uXMcU4YIelrN99XphvpS8rS7iTwgmBoQ+S9xSt6P/t9pAOuGiQuNmk0MHQTyCe7BwCK
 cSrWjjLBftOaA4Gg5i2HFclpqdwXcE/ln9d6ztuid5aKRAveZ1Irp5Ac5kQljg/gqNHx
 hwBtB171Du6bBL+hBdhlzfxMr4C0tJm1Wt3YM8g5ItY4h73Ad3K3jA3dZ11EoVHiz1Rm
 jzqbGSzZCjDAB9LJeIdRjV5ZrDV9mpK460+U6n83szwkZhCU7oNDh4CRxmy9j53V9J1o
 gQAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ppRzknxT0AZXN3crH3tjBrowm26w9aHnlANJdpLMe6j650508oQZG10P7102sAovT8EZtt6v/1fg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4+cSzM0i6D8/wzVpZNlBMEiEbNliP5WBhPyKpiMWA1ZiQHA8Q
 whzJoQ4WazJI4q388R8kPrfkEQ8fE8iYVy9pONitZ+je0pE69CA1Rz8FzeYWncl2fjo=
X-Gm-Gg: Acq92OF7OVmLuku9BxLBI+qDGhGL5D6C6HVuzYwxz5NLV4kuWp70XT7q29mKswn/Uy6
 bT0ihV5nJDd0MRgsjgJrWLYMgNvhTb7O8nlwJeNCIJBTgNKSlfT9zrfaqE2KpG3Zv3zGhfcTDEE
 Z+5/6ByAbnbn7rqjDgXL8+2OK5QxZXM0wxWPslzgitwNuwyFgD37MFtxAbrbwbFG1SBAmiSOkKy
 ttW9JyhTuBk3IMgJAIh9KVZqA8YbiyOKUrmf0NgAVxsvUn1KeAZcYBP/eni5CKuOA+Yjt16woH8
 gM+/2/rHa2leWAIqbXFyNpPBjxmhspcYJMVZPCDWeopANGlO/Qgz8qHP3bywOU/niAYrsLuhc71
 MKFBkPUpHg59DywaGQ9YkjsjKWhwEIG/mdtEr+s07OA29tREvzCmvvncPwC2bOmfezplTiYXQhg
 h6tnx/5Y+m6YU/a8EfzRCa6pHA4uKDcz7lZUNsmCROdM1LffoSIAt/Ir7Bwx8R7316JiHr8ZY=
X-Received: by 2002:a05:6102:54a3:b0:631:4580:6a42 with SMTP id
 ada2fe7eead31-6bf3dd7ea53mr702062137.22.1780055139849; 
 Fri, 29 May 2026 04:45:39 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com.
 [209.85.217.51]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6bfca34f6basm798360137.10.2026.05.29.04.45.39
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 04:45:39 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-6c449ac3588so26936137.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 04:45:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8Zm3BEcGp4I7Bujrh3C8RlqB3Is3JnUbJVkQ9PbaIM6E1W+KD0kqznLWKOSvuLwCAT9ASs44tSEWk=@lists.freedesktop.org
X-Received: by 2002:a05:6102:1591:b0:650:aa33:5dd7 with SMTP id
 ada2fe7eead31-6bf2d2f8f9amr796853137.2.1780055139478; Fri, 29 May 2026
 04:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <1ba6a98ace4ad9525d054cbaa308d3aeeecfa22a.1775636898.git.tommaso.merciai.xr@bp.renesas.com>
 <20260408113217.GD1928916@killaraus.ideasonboard.com>
In-Reply-To: <20260408113217.GD1928916@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 May 2026 13:45:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXZqJw=T7voOnJjsh-Y1e79Mr9wK6zoGxwojzidDxMycw@mail.gmail.com>
X-Gm-Features: AVHnY4KloFUS2B9LQzF4TBeNYZgidRaM7YLq9hAhtI_KcqQjkDOZSbYAGjwtGrU
Message-ID: <CAMuHMdXZqJw=T7voOnJjsh-Y1e79Mr9wK6zoGxwojzidDxMycw@mail.gmail.com>
Subject: Re: [PATCH v6 18/21] arm64: dts: renesas: r9a09g047: Add fcpvd{0,
 1} nodes
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, tomm.merciai@gmail.com,
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org
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

On Wed, 8 Apr 2026 at 13:32, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Apr 08, 2026 at 12:37:03PM +0200, Tommaso Merciai wrote:
> > Add fcpvd{0,1} nodes to RZ/G3E SoC DTSI.
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, will queue in renesas-devel for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
