Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66451CA5FAD
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE9110E81A;
	Tue, 29 Sep 2026 10:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JdFwo8UR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74B1F10E81A
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790677014; x=1822213014;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=e//TCcit/ISzMYO0YeFaG6Hi1WgM+P6dvupJ+mrGO14=;
 b=JdFwo8URVpX8maWAea0yJYA6nrIXVkYQ/IBFPRahbb4eBhaos+w4YKxu
 7G2ht/pEhgcIAdrqCH+K568yilbDkU8vrHZ/iPlmy3ua16AAubiyRaqfH
 ratWoBoM5l8nfvjg6Kl01DQV5WpuuHB8XkjIH4zAaHwTYg6z8oqTxbGDM
 YlVssa/ofM10EnPzfrGwGa2XXuTEzqDM/w6QYf6zn6nmii41RbJcX8WuP
 yLpJshS+Ewh10O4yu0Y2MIzTEZ4ijYQOdwmawGzWeDJ8XAheEtm0pbQNJ
 gLEsldz60QRsNYeiwEn963bCZM962KIEYHb89KoVKvHwzBoznG3HYJ+q2 A==;
X-CSE-ConnectionGUID: 4ddr+pavRDGmQzre592rZg==
X-CSE-MsgGUID: h0u/JguxRMmNeJ9x6+iW7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101558573"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="101558573"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 03:16:53 -0700
X-CSE-ConnectionGUID: mcFPh+TaRTGZ537dHTcCpQ==
X-CSE-MsgGUID: xQ/qpcy8QsmvUL+LJw7xhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="271815009"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.233])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 03:16:44 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, Javier Martinez Canillas
 <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
In-Reply-To: <aruD5kwOEsvFhW2e@beelink>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <054ef52478fc93fc213a9dae23ea77f73094aaf2@intel.com>
 <aruD5kwOEsvFhW2e@beelink>
Date: Tue, 29 Sep 2026 13:16:41 +0300
Message-ID: <42cfa3fb2246c66d69e45d7d9b8d6aaadc0da4c4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 29 Sep 2026, Benjamin Tissoires <bentiss@kernel.org> wrote:
> Ouch. This immediately raises the "let's implement a parser in the
> kernel" flag, or "let's create a new langage".

Fair.

> You'd still need a dedicated driver for your new blob parser, with far
> fewer people who had had a look at it than BPF who has been working on
> for several years.

Fair.

> The integration of BPF and the kernel is honestly transparent nowaday:
> calling a struct_ops BPF function is just a function call away, and from
> the bpf calling anything in the kernel is also just a call away.

I don't know if I'm just being overly conservative here, but it seems to
me BPF provides too much flexibility for the use case. But maybe the
point is completely moot, and you should just ignore me. ;)

> See Maxime's answers: yes, falling back to dedicated driver is still
> encouraged.

[Moved the above to go with below.]

> Isn't that what Maxime wants to have? One driver for a plethora of DSI
> panels, with the same ability the BIOS has to also do function calls to
> set things up?

I suppose this is something that could use some clarification. Is the
idea that most (simple) dedicated panel drivers eventually get converted
to BPF? Or is the idea that BPF is easy for prototyping and development
using stable kernels and short time to market, and most of them would
eventually get converted to dedicated panel drivers?

The story wrt display before userspace is up and running also needs
clarification.


BR,
Jani.


-- 
Jani Nikula, Intel
