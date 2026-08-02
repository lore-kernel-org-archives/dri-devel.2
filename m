Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08FCC55174
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 078C210E472;
	Sun,  2 Aug 2026 22:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="iV7X0CIn";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E97F110E32E
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 13:13:41 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso3634607b3a.1
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1785676421; x=1786281221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0twFV3mHRznw8yaEodkq4tq3QB77XZJk3sNwlDZSssw=;
 b=iV7X0CInN5QpFHnw1m1VmUXMMiki7O2FVTX5Uy3YWTr/i7DnDq9ed5KrrpxiytQGzF
 ReovXUhK5uFOsxhv2YShEAj4Dt8j238vPeNz/PR20Xls2QRZ+Rby/JlWBn/LvYR9Nb0s
 ni4zhB8jI1cZBsGz6NpyskHkjx9TIsgbsY9E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785676421; x=1786281221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0twFV3mHRznw8yaEodkq4tq3QB77XZJk3sNwlDZSssw=;
 b=bNfCfUv2fAkx45mus0LS6BSIDGnBGPN1mQZekcrV4V2XXil1HE3AbXhjvETgsf/9Hl
 IMW+xLnjDcPiPz6yGXVLca8ROgDRSZ+86sOzurvD/50UahnOl/MxjJ204lEeW7cjqQSg
 Gu1OrBFZ1EzQ039povfWhB7io6EU+4hR98CSfia3mX352akjlO8XIh3VDA6pZyPWnLvJ
 q4uIqsi3lx6Q90In/gIIQlsG9rDmL9EyqLeIpJ0PWuUsMk/jMcn7cuU2NDSrXuqE6jNy
 wZ1+waKqKoEg04+0LztRb6OdUa25YL/qc6Ps2yONjnhP4lCfCodvdNtu2rZoAqmEwLwL
 DhxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RraVAPU3IZV90CtyYw8Bol1Y36DEVNkYQLNLpkY4hzBbf00ByzSKeO1DaqWsOTRgjwaWEa8X03soBE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyszxP49jalhtWIbjnYD4TW3WrOl2waOPEXEO9XIH011IYizYgq
 MbDpU1W/uU9Fwue2LSkplU0lUXZ8lqhjFJ29wSz+EZPRwmYvIaNJ55v1y5tErGfnxMK28NadcCU
 lCmJq
X-Gm-Gg: AR+sD12OrjixLzCZ3k3wV7cr8fpOJ/F52NWR9uxLedzPLmHaaIRa96bpz6eE2s70fso
 O2xxcUbalhsJ+Fa/pHGrqRMjsXxf+wX4/MAUWYt5pEHnYx9qs+qIo0DJuRVKpvm9NDdTi0KHQzu
 U+AczJQ7YG7wH8fLiiq6QK9DWp/qfdp6mV+v41NETj6qwe78QBcOAnQFkXTl9GHDL/1X0/VXxOn
 OFELYxM9cJ+XPBTGMpeY6II42y8IREWYmh5JrgUADcGI0CcAdumi8Jc08uOpkApN/8LAVzxCham
 iNezETgW0Fmk9HDD3v82w1Obmfk8g/NAwBY1IFOlP9TuqzvBFlnoIRH8NpWr9X8I4uJXUHg7Eam
 UJCdB4TG/mvT2qTUBn4skQbusQeZr9BOYR5Zhg6giToIYdN5beNEQOLgEUivoFxBVHp+LDe1wXi
 BFT4BD0V9C7tVn4FRruNkvpe/5cUix4QnAG+oq481dNg5ckJu/TCDQHw+ITFGxqfZdXQZ7ujWmg
 UDU8iEXcUNj0yjUVA==
X-Received: by 2002:a05:6a00:3c89:b0:847:8b11:5966 with SMTP id
 d2e1a72fcca58-84ee47e4485mr5862655b3a.1.1785676421413; 
 Sun, 02 Aug 2026 06:13:41 -0700 (PDT)
Received: from localhost.localdomain ([61.83.209.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edbe57020sm2547045b3a.17.2026.08.02.06.13.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 02 Aug 2026 06:13:41 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Igor Paunovic <royalnet026@gmail.com>
Cc: ogabbay@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 gahing@gahingwoo.com, heiko@sntech.de, Sidong Yang <sidong.yang@furiosa.ai>
Subject: Re: [PATCH v2] accel/rocket: request the core clocks by name
Date: Sun,  2 Aug 2026 22:13:28 +0900
Message-ID: <20260802131328.75038-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260729130743.128876-1-royalnet026@gmail.com>
References: <20260729130743.128876-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Aug 2026 22:41:01 +0000
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

On Wed, Jul 29, 2026 at 03:07:43PM +0200, Igor Paunovic wrote:
> Found on an Orange Pi 5 Plus (RK3588) by reading the live clock tree:

I see the same thing on a Radxa ROCK 5B+ (RK3588), and the patch fixes
it here as well.

Before, clk_summary has the four rocket handles piled up on the AXI
clock, with no driver consumer at all on the other three:

  aclk_npu0       4x fdab0000.npu    1x npu@fdab0000
  hclk_npu0        -                 1x npu@fdab0000
  pclk_npu_root    -                 3x npu@fdXX0000
  scmi_clk_npu     -                 3x npu@fdXX0000

After the patch every clock has exactly one fdXX0000.npu consumer, and
scmi_clk_npu picks up driver handles for all three cores.

No regressions here:

 - 90 runtime PM suspend/resume cycles over the three cores: no
   power-domain ack failures, no SErrors, nothing logged at all.
   scmi_clk_npu stays at its boot rate and returns to enable_cnt 0
   when the cores go idle.

 - Five MobileNetV2 subgraphs through the Teflon TFLite delegate still
   match the CPU reference (max diff 1).  I could not measure any change
   in inference time either way, though run-to-run spread on this box is
   around 10%, so that only rules out a large regression.

Tested on v7.2-rc3.

Tested-by: Sidong Yang <sidong.yang@furiosa.ai>

Thanks,
Sidong
