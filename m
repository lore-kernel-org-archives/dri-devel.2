Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA66C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6132910F66F;
	Fri,  3 Jul 2026 07:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DlmTeHVU";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB68210E4BB
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 13:00:33 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c9c80265bd7so853401a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782997233; x=1783602033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1E44Sgh/fBb3+oxPV/igqOovjJZCJr4T8Ggc55Eveo0=;
 b=DlmTeHVUVnH48AJn+e4Ha34ElL4DYzjWAX/B1f/FHIfqW20z+AoI54+e27Jb0gHGdE
 I5vRKZHjJlj+L+naPq23fgyRwbPT5uYpf+1KHfs1wWkV0xvjct7b/X9Cxrmy9Iplzxka
 ldHGgFkFuy6oaneHw3Tap+0KLvfY26ZariLJHl1QD0P9qgNljSUbT0wwjyxh8UTOc+4M
 VjnGKms3+pCBNhQz5W/u1rwJuIEMTfP41Ma633X7csD0wAg+zUO3wIzaQbBcTg1E7naq
 56kyRdBrHebaYJ/E611O5D+csrd9w02kKh57Bpmk0AQFTimOdzG6EqIIlWZxBvr2Cq5I
 UauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782997233; x=1783602033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1E44Sgh/fBb3+oxPV/igqOovjJZCJr4T8Ggc55Eveo0=;
 b=LvH+8UdGLRpXqE4WxI8FUE4sbzjl40HRppE2AeQ8SemJPtjfXEzGNW+Lv5jXUK0Y8t
 PHWJ9oIG717Z4h9ZbwHpWzjCp76CLu08KjxNod7LXzYGHw8vjP1r50RA8wQyVlT5yZ6W
 tGBzeByL54yMSM9eCo3a9982YDghM/rBDF4EGbEbgQlzBeMq86qfpJzONfZj9QSLdtg4
 /TM5zBk+DcDzEpRRDCm+Bh+T6At9l2JIvzcBaz/urrAOMk56dsf9eliBBCRcJynum8Q4
 EnCaqzbV9R8gUKYw2sMsByxI3FDxSa86Abp0oZPAokGGHKM3hgmxoNm38f4hgkRbz2fz
 h71Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+y2dK7vNuz8J/SWgWqpib9fc3wXMeFWnTI1Zx7rBb7gioGyRpxBGB2GG8+GhjZFDgfdKLcxqPO1L0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVN0w5Qj7PRMuG4iYA4rg9Y9+W5cgSONMadmIwBomouVvcs28N
 yJyOBFVbSt+mRLUEfpP5LXydYNU+sPWOIUSxImqJH910BKoYABAdm3eD
X-Gm-Gg: AfdE7ckw/2gNWZpyyHT+kWjGqOhkZ0I+JtjRiGhHxqmu5dOoGdBP33pLRl+jVfnolpZ
 hGsgtR1VFxh1c21Qoazr07cawQQfwbRI8z3eYb3ZR2UgkpUrurpDtVsR9hmqZi6ULKxINVrMmQ+
 Ws1p1oSOV5NkwKf8nJDQoQT6a6w1FAfW2IuKY/D6AXWEfnYrKjC/EDyl2ybeNuy1FNMjBhgQ4iY
 jHGKkNGKPZy3Gu6fiE0a3ymzWTqTiOtIErG2iSzKjzCzVUegelSD9NL1wFMOa2v0/vL+Rrb5pM7
 fZa5r8ZcMJV4RJROoUy2jP6ipjCL3iMnXIi8lUw5ybAnCApzq/WtTs5EjNFSxPxjjORytrFH76S
 h6s+9tbYwHKW+7R/fD40FBK4APb+oW0hd9wr1RJ0Nq6Gm+odcTCLNQO4UWg8crowHeWq+BiZdXl
 GSPA27mKFiSM0wnCkXC/gv2acnyLWKZa++f7lI8PrrBiOr3QOhrZwMMYxi0RgNR+hdX4+iUjS8O
 02kEdSmx1Q0SLSq/Yo8sCTNdSmiX/98zvUzTG6z6ss=
X-Received: by 2002:a05:6a20:258f:b0:3bf:8b8d:3151 with SMTP id
 adf61e73a8af0-3bfed3efa54mr7187075637.44.1782997233311; 
 Thu, 02 Jul 2026 06:00:33 -0700 (PDT)
Received: from leonardoc-nb (201-68-197-145.dsl.telesp.net.br.
 [201.68.197.145]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f116065c5sm7279613eec.11.2026.07.02.06.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:00:32 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: s-jain1@ti.com
Cc: airlied@gmail.com, aradhya.bhatia@linux.dev, conor+dt@kernel.org,
 devarsht@ti.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, h-shenoy@ti.com, jyri.sarha@iki.fi,
 kristo@kernel.org, krzk+dt@kernel.org, lee@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 louis.chauvet@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, nm@ti.com, praneeth@ti.com, robh@kernel.org,
 simona@ffwll.ch, tomi.valkeinen@ideasonboard.com, tzimmermann@suse.de,
 vigneshr@ti.com, leonardo.costa@toradex.com
Subject: Re: [RESEND PATCH v2 5/5] drm/tidss: Fix sampling edge configuration
Date: Thu,  2 Jul 2026 09:59:43 -0300
Message-ID: <20260702130010.1238089-1-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106141227.899054-6-s-jain1@ti.com>
References: <20251106141227.899054-6-s-jain1@ti.com>
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

Please ignore the previous email I sent:
https://lore.kernel.org/all/20260702104817.1219078-1-leoreis.costa@gmail.com/
I hadn't seen this more recent thread at the time.
