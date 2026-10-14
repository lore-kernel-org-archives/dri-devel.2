Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4BACC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2BEC1121BF;
	Thu, 15 Oct 2026 07:57:29 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F073010FE70
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:57:54 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-8198a3a54d7so6329984a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791986274; x=1792591074; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7e0ci0C74qh1IaIQAQj4oYwASorhtlXqumTlEsvUPK0=;
 b=fJ5vIDLpMMnLA+YyTb1OqRLPxOn5vddWgoUQSISvMv9/GSuWrvvzvrOX6k5+PBaTG2
 F3Bu/08YVFJzXGFY/g+Ei+cFhUYHK17ULEKqeRL1NceUFpqHWk5bi/rFhDb4jlTAnX9u
 V/GoKjt1KoZR+5Ma+knpDnffCifAphYwBhv1B3JaIQBB6yhVTPlwBOirjYLJdXZoRx2G
 d6lbOTBOMWX7MS5GFdObN/jiclA/SnnKe4y92aIbjvbQBe7iWFttRSavLWch6NK4n0no
 mdsnRR8NSjN6ANR7Pn55d+4lDQ8z3qB0cJeHV3mCevJMJDTQYA1Cd1Hmig3TC/eoTIOq
 BNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791986274; x=1792591074;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7e0ci0C74qh1IaIQAQj4oYwASorhtlXqumTlEsvUPK0=;
 b=2kXlK44YXoVR2NeQJi9jr4SgeuknDWLOOWlTF2G5Ah6jHQYNZfkHSE1Th61LT/17Ce
 a+kgB45DohTT4qvOQyf/vAe+c1d+qvD8FC8/RhFp8KVGh6UMyVB5koIJgQ+yGrYiKgWz
 f4gT7CCM/sZ3CgYwYVj2KemTTQpi26sbJCv0BrRzTmkq1LzPx0l7dSk+23zLyincqcIb
 sH8rrKNpx7dFL+7kS8syBUNWx6PVUIxqO03zItfHRJw3N5ZFvTbU/Xnf4NHYyG9gGshw
 zNrC8B40e+scFbGUnJtW4RioLo183oe3qwihuzcriNKDP6VSDaEDi5z5dRCUZ6Sd8Oin
 gxsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8rh+NarvcdCaE8ZpJwDcmVT2ODglVQGxG25BLlxiQr3UeGB0kFYeO45JH73psa+o5Egg4XgvAhp4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJrzhJg/GfoT1tCfl6IgLezcBRC0xhSINLkV8T5N8T+MQpQE9e2
 D6P9+C99ALCsnXMfXjCkcLqDtLwJ570MScr446Q/MrbbbBVf5Ex6CFGo
X-Gm-Gg: AYBFou2bmRd2epZVYxSbOyxC/cqMfs6pYJvM9TNcWU9lAzdvXsZE65jzTVJ6hfBkAEO
 F5pEQZZ9BUNPksq5v/M5hdo6FNRDXHuJjcHX8Lu/Y2jvkqSRbB79VRFqfq7aGWYr2raoaCC9Ana
 DxD9016tHuEBcVVr0MQVT+D4ED7QR/FXMMYRMYhnhbpd2CEDp+dmhMvqRH9qeUEqRIrx+p6/Gd+
 9Y7xYa+hJHWytFQUlopvlZlLs1eHtrkw8DhncIchjYJyPOAgqudfxDPqQc32wIeIHSIO+L4APuj
 1k27HigWgUlIoFfLB9ZHMzxUQS2cUHuEFMQyQZQNFZFWMUa5eWE0oUhsISjZfXlr7roStWSjoob
 1TGhu1k+qIyfCxYfCsMjMzqk961Y2zNo9hfdROOq21JYw54w8WqWEjqAWfuPd1eBAiwJjA9Wgcz
 gxRw30sgXOinI+uxWW0fOTLKF87UJ/iwkfHmM0QIMhe5bIL0KU/4j0qpdW+xlPai1T/7bkNZ0mp
 G8Q3JMAbYQ3Uf8=
X-Received: by 2002:a05:6808:1a19:b0:4f3:28f7:dfb with SMTP id
 5614622812f47-50c516e42fcmr11298620b6e.14.1791986273875; 
 Wed, 14 Oct 2026 06:57:53 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c1815fd26sm17891866b6e.10.2026.10.14.06.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 06:57:51 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:57:40 -0300
From: Leonardo Costa <leoreis.costa@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 
 Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH 0/3] Add VGA support for Apalis iMX6
Message-ID: <druavdvcgm3rljk3mhano3o424xyelupmcz7kbzguuljdsungx@xuj2ovbvz654>
References: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
 <20261012164054.GA56180@killaraus.ideasonboard.com>
 <20261013090631.GA33628@francesco-nb>
 <20261013111158.GG56180@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013111158.GG56180@killaraus.ideasonboard.com>
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

Hi Laurent,

On Tue, Oct 13, 2026 at 01:11:58PM +0200, Laurent Pinchart wrote:
> Hi Francesco,
> 
> On Tue, Oct 13, 2026 at 11:06:31AM +0200, Francesco Dolcini wrote:
> > On Mon, Oct 12, 2026 at 06:40:54PM +0200, Laurent Pinchart wrote:
> > > On Mon, Oct 12, 2026 at 04:25:22AM -0300, Leonardo Costa wrote:
> > > > This series adds a device tree overlay that enables the VGA output on Apalis
> > > > iMX6, which is driven from a parallel RGB interface passing through a
> > > > non-programmable video DAC.
> > > > 
> > > > The video DAC is a simple resistor network gated by an active-low
> > > > data-enable signal. For the bridge to work properly, this series also
> > > > changes the following in the dt-bindings and simple-bridge driver:
> > > > 
> > > > - dt-bindings: Add a new compatible for the bridge in the simple-bridge
> > > >   binding. This is necessary because the existing dumb-vga-dac compatible
> > > >   doesn't describe a data-enable signal polarity.
> > > > 
> > > > - simple-bridge: Add the VGA bridge match-table entry and timings
> > > >   struct, setting the DRM_BUS_FLAG_DE_LOW flag for the bridge.
> > > 
> > > Is there schematics available anywhere ? That would help reviewing the
> > > series ?
> > 
> > This circuit is on the SoM, and the SoM schematics are
> > confidential and not generally available.
> > 
> > I tried to extract as ascii art the relevant circuit, hope it helps
> 
> Thank you, it makes things clearer.
> 
> The circuit seems fairly generic. Wouldn't it be better to add an
> optional property ot the dumb-vga-dac instead of a new compatible string
> specific to Apalis ?

See the diff below, this was the initial idea we had when working on
this. On one hand, at least to me it seems like something that other
bridges could use, and a new property seems reasonable. On the other,
since we don't know exactly how much configuration is expected from a
bridge in the simple-bridge driver, we weren't sure if this would be
accepted, and went with the simpler solution of creating a new binding
for our bridge, which also seemed less intrusive.

What are your thoughts about a change like this?

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 3fba7002322e..41b00a44983a 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -171,6 +171,7 @@ static int simple_bridge_probe(struct platform_device *pdev)
 {
 	struct simple_bridge *sbridge;
 	struct device_node *remote;
+	u32 de;
 
 	sbridge = devm_drm_bridge_alloc(&pdev->dev, struct simple_bridge,
 					bridge, &simple_bridge_bridge_funcs);
@@ -212,6 +213,19 @@ static int simple_bridge_probe(struct platform_device *pdev)
 	sbridge->bridge.of_node = pdev->dev.of_node;
 	sbridge->bridge.timings = sbridge->info->timings;
 
+	if (!sbridge->bridge.timings &&
+	    !of_property_read_u32(pdev->dev.of_node, "data-enable-active", &de)) {
+		struct drm_bridge_timings *timings;
+
+		timings = devm_kzalloc(&pdev->dev, sizeof(*timings), GFP_KERNEL);
+		if (!timings)
+			return -ENOMEM;
+
+		timings->input_bus_flags = de ? DRM_BUS_FLAG_DE_HIGH :
+						DRM_BUS_FLAG_DE_LOW;
+		sbridge->bridge.timings = timings;
+	}
+
 	return devm_drm_bridge_add(&pdev->dev, &sbridge->bridge);
 }
