Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC8BC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 798E710E665;
	Mon, 10 Aug 2026 06:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kaskAhfu";
	dkim-atps=neutral
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610A910E03C
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:39:20 +0000 (UTC)
Received: by mail-pj2-f0.google.com with SMTP id
 98e67ed59e1d1-380f4166f80so526819a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786199960; x=1786804760; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gLPlagPSnxq9fTONnyyz/3ddba5KQ5Gz9V5u0Vh5tVQ=;
 b=kaskAhfur9lI0Si/oHi1Of83xnOCXef5SCRQaScw9IaU9Gc6RCNR9+e4+JSrDgaEQL
 1hEMx1pGjOvJkahaTkn1srphpEGSmDygX0QcjH/LGZ4+rb9GZU5aj05ZfzJC0figKZux
 Hm3ioZ8i8dPSnL2XFB/L/iGQ6xZi5O4wfGPeMwDeS88Qm8glgt+Wqs8LNOh5KzE4WBsi
 WxWQjITAfW6WC5A7csv64rBnV3EcGQ+LpJI1ib25c2WA9ksTXO5yQT7g5qQCQKy8HMwc
 GQR3VHC4h88h0n7nE82ghCcpJs/1tmsLxQjPAhMTEfPe+OuzlOvt5E3p0cwMPjUzVbQk
 JYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786199960; x=1786804760;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gLPlagPSnxq9fTONnyyz/3ddba5KQ5Gz9V5u0Vh5tVQ=;
 b=KBROo8iICce8/28n/URinJbTz2lwJGULyZXWuYTCEtYKBIcrJyHgf4/TDcb8wUnJSQ
 SR1OBUypojUFHMakde/Y+6moXpxrH2hIahG6DKL/spKJz5HV7j5RMkYLIrU7BgiZqZDI
 TKsGpP3H1HSEhbg1YCtyQtLcIHDol845JFHJUWUY1BNA6SLqtYBNjF9HkJyugLGqp2E9
 hiKnu68QtgT0Kc6O3nV0ZfaCs4bItuopY+lHN3breSk40b8ZG2B/LEO+bBDUqpJpUM26
 vsSLPupdvBlkvO/r228XlnBtrTAcrWLHOESIjHrMlkprPn4duhw6RRipC0AU9LV+n3ej
 LW3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrC8XTm+oW1rrizqxXtO90xRKyqqHq4eoVhLo0gdGt3mj8KcC9sMvyM+9ZQyTc+GvU/IUNNvCLTArs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw71YTEXMWSFiBkJAsmo5CI9zJWcjgaE8RLCqlB3ZIX7ECf6NK2
 aoL5TJ0y8nTOcu/tn9JTDikWOnXQt3sXfpTglvbFNcprz2f1oR96S2Te
X-Gm-Gg: AR+sD119skBtbHzosL8Eo8H+F7IldFLOjxL8Az9MBJwXCUrb7ZM5U4jjdrXnjjluIsR
 YD+VprTMSPDT/TeoiPJGnG3rc35Y+COBIRe3TbFLaEJ/iWdgrCC4+pfc4s/GZk+3sy9IsVySuJ8
 oJlewx3b7WsUuzOZz+Yl2KXSovYcFc8CNz9H3iwtp26Hb6cPR5MB+xXd/UHUrlCdFm3EbIO3stz
 0BO0zglgmyZFg5qzHXn/JfNS4FEi35F9rK71mGjQY+ifuPuQqULrOhhl80j9Ia1qsZRLpQgUCF0
 TVMvajdw23UykBiVUoTXWqC/gE6N+BPGME1GEmFD1iaC55dRdTyx5RC2DH7Ae1jk0d33qtu+zfG
 28dtmkXPnjLXvm6kA9kl21rmC+6iIIizVAxTFvX2L+BPCQNUMdPSFjcsLOwnkk0vwboEA0n6bwc
 DPmtY29+Y1VR6a4LBNhiiXvS5f14/I2pNrQJuAVCU=
X-Received: by 2002:a17:90b:2585:b0:38e:bbf1:de34 with SMTP id
 98e67ed59e1d1-39261fdab5amr13832835a91.7.1786199959787; 
 Sat, 08 Aug 2026 07:39:19 -0700 (PDT)
Received: from localhost ([2403:2c80:17:1e::20db])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fd95794sm6424491a91.7.2026.08.08.07.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 07:39:19 -0700 (PDT)
Date: Sat, 08 Aug 2026 22:39:16 +0800
Message-ID: <ec84e2ba71be5e82a3afcf257129bf58.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Haylen Chu <heylenay@4d2.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND 03/17] dt-bindings: display: spacemit: add K3
 Innosilicon DP/eDP controller
In-Reply-To: <20260807230404.GA2211679-robh@kernel.org>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-3-6de34d80e86c@gmail.com>
 <20260807230404.GA2211679-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

Hi Rob,

On Fri, 07 Aug 2026 18:04:04 -0500, Rob Herring wrote:
> On Sat, Jul 25, 2026 at 12:51:12AM -0400, Cody Kang wrote:
> > Both K3 instances are the same IP and share one compatible; which one
> > behaves as eDP is decided by what its downstream port is wired to, not by
> > which register window it sits in, so the binding does not distinguish them.
> >
> > Signed-off-by: Cody Kang <codykang.hk@gmail.com>
> > ---
> >  .../display/spacemit/spacemit,k3-inno-dp.yaml      | 140 +++++++++++++++++++++
> >  1 file changed, 140 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/spacemit/spacemit,k3-inno-dp.yaml b/Documentation/devicetree/bindings/display/spacemit/spacemit,k3-inno-dp.yaml
> > new file mode 100644
> > index 000000000000..865ea310daaf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/spacemit/spacemit,k3-inno-dp.yaml
> > @@ -0,0 +1,140 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/spacemit/spacemit,k3-inno-dp.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SpacemiT K3 Innosilicon DisplayPort / embedded DisplayPort Controller
> > +
> > +maintainers:
> > +  - Cody Kang <codykang.hk@gmail.com>
> > +
> > +description:
> > +  Innosilicon DisplayPort transmit controller integrated in the SpacemiT K3
> > +  SoC. The K3 has two instances of the same block sharing one compatible;
> > +  each acts as embedded or external DisplayPort depending on whether its
> > +  output port drives a panel or a connector.
> > +
> > +properties:
> > +  compatible:
> > +    const: spacemit,k3-inno-dp
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: Link and hot-plug events.
> > +
> > +  clocks:
> > +    items:
> > +      - description: Pixel clock for the controller.
> > +      - description:
> > +          Pixel clock generated by the DP PHY PLL; the pixel clock above is
> > +          parented onto it in use.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pxclk
> > +      - const: pll
> > +
> > +  resets:
> > +    maxItems: 1
> > +    description: Controller-wide reset signal.
> > +
> > +  phys:
> > +    maxItems: 1
> > +    description: Phandle to the K3 Innosilicon DP PHY.
> > +
> > +  phy-names:
> > +    items:
> > +      - const: dp
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Video input from the DPU.
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Output to the panel or to the DisplayPort connector.
> > +
> > +    required:
> > +      - port@0
>
> Shouldn't port@1 be required too?

Thanks for the review. Yes, will make port@1 required in v2 and
describe the DP connector on the board side (dp-connector) so the
graph is complete.

> Otherwise,
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Thanks! Will pick up your Reviewed-by with that change in v2.

Cody
