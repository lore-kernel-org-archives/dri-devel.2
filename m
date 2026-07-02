Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1A8C44502
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6400010F67D;
	Fri,  3 Jul 2026 07:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HwBJsJmt";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6821610F2BA
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 10:48:35 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-c9ef3e1337fso353065a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782989315; x=1783594115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HePeeifvB/opdYPmqi87Awn5dRCasskHjfVg9hPOIo=;
 b=HwBJsJmtVOdhGxRNi09qvDyaiNo7a+xqWKN+aAs5hrf89eBC7vkpEwzFnUkNYgU2/p
 Wfdz72FtE0zqblqE8RzhpdVhpEEanoXQq+W5ahSOR0t76LQPCxAiQEtLJuREKi/6LGGy
 nN3SJlSHI6DF+fHhmcEKQj/Na1ooiabkpoup/cvSbA9oFhBI+kL+RCU/k+IcB65MKw+J
 a4rvvvFtqendmp6+Itcn3osUSxmoi52GcYHzhzXo+6K/FNJSCDfb313of8vdComkcvjY
 AhIN6CprAcF3BYA3YcECxc2R3D/0yXZoXJRJ9h/WGhAVz4VI/WAOVGp0FnEmiu/MZfyq
 /Yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782989315; x=1783594115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8HePeeifvB/opdYPmqi87Awn5dRCasskHjfVg9hPOIo=;
 b=jwKcBPoTQHgx1a/vecqvTri9CC+HZAs6o8poPyv9bPYU0fs97kSaDUTg2Zd0N5mmqC
 VwKaATnyKZV397GNsXhfMPjyjoeggNWnM5sH9E4DCMjnBcsLhLN3aUmrq8/MkOjWmOdu
 mLr2J+T/lLhLkwGVWJ2P81m0RxpQVpSS/blXw/YE1a76ABx8/YVQ+fQM5cjnQeL0Z0s/
 ANlq8kUiXHx2cAg/FsMUudi9jw/vpLRZoKwcISlcdHbclEb+loHGUAvlIB7aBXFrU7kQ
 Rq0DOGr9qbarTvJt6Cs40FtHzo6XpSk7V+GTsLUuQBtuQQLcZbkyaGL6fKXatURnuteI
 Y2vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9i0Kt0u0Ws6O6xU7Tx3erMSEAEy6bx62OKowzt1V2Rp/Mu/v2EdaIga9wa5AYZz8wBHZqH/E4+IMQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymTw4NNH5Dd6+41Q4F44DW2YoRL/gf09qgvt0N/1+r80gozCOL
 ThX/moGP3JyJZBWTOs5WJTBH2I0j+gkpPdZhAZqvoaCmwyR3Xaj3rzht
X-Gm-Gg: AfdE7cmdti1cBoUET8xWdfjDF4tqAUWL44NnwsOvB5ocU1M1agBE1xdi7zEAG01pFl2
 9u4NuDQlMh+INkB2MuiIRtQ8v+T30NDGE0iMZUUnH7B0uxewYXeuOuJ+zeGoOBHo8JQe7Kt6zlo
 7q7FXlphCQvRWZcE9CrJTHAJPe6GnQv/wdS1kr2ip/rRuZyctE89pJckHPixOMeyYji58UvCXoe
 PpZ8C4CdYaGT2bKKZq5cmOi/NAmF6d4uAOVK1usfJHXVg7Knz/LioDYnBvH1Ise/fRTcoyFZs58
 JKs977IN63h2WdEjEhEcT4YxqeW1+m1gBW0h+Tz/27POEPh+TjWQwIHsV4pjXK8qj6hUoh9RDTO
 KY5kTzTT1T/YsOw3eS+gK/Nf80lNzyhi6EW65t+bo2IAP/6Agsagbzn4FbiONPiN5CIxAgXq7aP
 mT9BhQEtTCI+y/D7MsTjkBoRnmzVSOo0gysViFOq0PjMPEPFh0x56CQIgbrxY6VaZPLEaAxJiqS
 qnDbzwVVCr3yrSbfiVddtGaPGcdGqjC4MSGGLgAmtw=
X-Received: by 2002:a05:6a20:e20f:b0:3b4:669c:ee32 with SMTP id
 adf61e73a8af0-3bfed3b26edmr7042853637.37.1782989314653; 
 Thu, 02 Jul 2026 03:48:34 -0700 (PDT)
Received: from leonardoc-nb (201-68-197-145.dsl.telesp.net.br.
 [201.68.197.145]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f116065c5sm5936815eec.11.2026.07.02.03.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 03:48:34 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, bparrot@ti.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, jsarha@ti.com,
 jyri.sarha@iki.fi, kristo@kernel.org, krzk+dt@kernel.org, lee@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, nm@ti.com,
 robh@kernel.org, sam@ravnborg.org, simona@ffwll.ch, stable@vger.kernel.org,
 thomas.petazzoni@bootlin.com, tomi.valkeinen@ideasonboard.com,
 tomi.valkeinen@ti.com, tzimmermann@suse.de, vigneshr@ti.com
Subject: Re: [PATCH 4/4] drm/tidss: Fix sampling edge configuration
Date: Thu,  2 Jul 2026 07:48:01 -0300
Message-ID: <20260702104817.1219078-1-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730-fix-edge-handling-v1-4-1bdfb3fe7922@bootlin.com>
References: <20250730-fix-edge-handling-v1-4-1bdfb3fe7922@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

Hello,

We tested this patch and it introduces a regression on our panel.

On our board, a Toshiba TC358768 DPI-to-DSI bridge is connected to the parallel
RGB output. The bridge requires data to be driven on the negative edge, and
this is also reflected by the `ipc` variable in `dispc_vp_enable()`, which is
set to `1`.

With this patch applied, however, data is driven on the positive edge instead.

According to SPRUIV7C, both `MAIN_CTRL_MMR_CFG0_DPI0_CLK_CTRL[8]` and
`DSS_VP1_POL_FREQ[14] IPC` should be programmed consistently. However, if we
follow the actual bit descriptions, and ignore the sentence saying that the two
programmed values should be the same, the data is driven on the requested edge.

From SPRUIV7C (https://www.ti.com/lit/ug/spruiv7b/spruiv7c.pdf):

MAIN_CTRL_MMR_CFG0_DPI0_CLK_CTRL[8] (DPI0_CLK_CTRL_DATA_CLK_INVDIS):

        Clock edge select for DPI0 data outputs

        Note that this value should be the same as the programmed value of
        DSS_POL_FREQ[14] IPC.

        Reset Source: mod_por_rst_n

        0 DATA and DE are driven on the falling edge of clk
        1 DATA and DE are driven on the rising edge of clk


    DSS_VP1_POL_FREQ[14] (IPC)

        Invert pixel clock

        To set data to pixel clock relationship, CTRL_MMR_DPI0_CLK_CTRL[8]
        DPI0_CLK_CTRL_DATA_CLK_INVDIS setting should be the same as the [14]
        IPC setting.

        0 Data is driven on the LCD data lines on the rising-edge of the pixel clock
        1 Data is driven on the LCD data lines on the falling-edge of the pixel clock

So, the proposed fix to this patch is:

```diff
- regmap_update_bits(dispc->clk_ctrl, 0, 0x100, ipc ? 0x100 : 0x000);
+ regmap_update_bits(dispc->clk_ctrl, 0, 0x100, ipc ? 0x000 : 0x100);
```

Reverting the patch also makes the Toshiba bridge work correctly again.
However, we can confirm that the patch is needed, otherwise only the
positive-edge case (our case) works correctly.

In other words, the two registers need to match semantically, not numerically.
