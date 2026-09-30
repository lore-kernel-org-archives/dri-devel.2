Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D487CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8655310E136;
	Wed, 30 Sep 2026 19:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WbWJlQAD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D5B10E136
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 19:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790795911; x=1822331911;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=CyGtyCPmNZniFcfDSReMKCTj4N1SwBDzJ2xIa3sj7uI=;
 b=WbWJlQADYS/5KjqCp8Oh0hItphHq/mzhyyIezCv7ZYUziSD4R5hf+Cjs
 LBZIihumRXhI9qeBkgBx2SEExF7caiTTBrWtEYDhoJSFKlaLdOigmFqUD
 Sh13wAlluVKNsPIymsWOnd9jT/Gs/RsK+WQDpyfkrQjzyjlmsP85ot4eH
 QESaxmJYsMkphAZWMnzpzMruWkaQexRCB/9WXYg+GpcnHfE0KQ5/Bg8w/
 QBYqdEuDRIayl6bAN1VmminoO1hgCEIHHixDQGrw7Khe39/yEEeyQvDeP
 s/WJhW5a8X34kYs8royTMB5cdAxvtAfwGo/FQs1ZIVHC/T4RgB6IKJfjR w==;
X-CSE-ConnectionGUID: b9RCIgkPSlKPnxSgTBUfjw==
X-CSE-MsgGUID: pZo3oXmiRO6SCihBCJmDZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102218499"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; d="scan'208";a="102218499"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 12:18:30 -0700
X-CSE-ConnectionGUID: BLsley0fRryRnafxe2muKg==
X-CSE-MsgGUID: 955Bc4nlQZCMiHe1JN9npQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; d="scan'208";a="275320575"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.107])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 12:18:23 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, Maxime Ripard
 <mripard@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, Javier Martinez Canillas
 <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Benjamin Tissoires
 <bentiss@kernel.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
In-Reply-To: <6c581ae0-2480-47a2-b46e-97afadbc7c1f@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <054ef52478fc93fc213a9dae23ea77f73094aaf2@intel.com>
 <6c581ae0-2480-47a2-b46e-97afadbc7c1f@linaro.org>
Date: Wed, 30 Sep 2026 22:18:21 +0300
Message-ID: <5617389e496cf14a48efb9026b6d19a0fa37e568@intel.com>
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

On Wed, 30 Sep 2026, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> Yes we could have a similar panel-simple but with init tables, but
> in reality those panels offers much more features we don't handle because
> the DDIC vendors and panel integrators just don't care exposing those
> features, but they get handled by vendor implementation like for Phones.

...

> I don't think we want this, downstream vendors does that and we don't want
> to go there.

I think those are fair points.

BR,
Jani.


-- 
Jani Nikula, Intel
