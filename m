Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC8DCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3028110EDB1;
	Tue, 29 Sep 2026 09:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Vu5aeqK7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A074910EDB1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790672644; x=1822208644;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=fjTgkfgps1Gk7j6xMRcB1fFz/DjnVOKoczfByJwdpzQ=;
 b=Vu5aeqK7pQWJWUBgvtimQhagMDH7K5s9rS57iSmS/3bTi29QzzvyfRTy
 fxou6XhW89xPX99kxRsa8I02i1Wd2w2VaR7iIs2jmIooKmWpxr6xB9kUe
 6SY8t2eU7zYN6bJiEnj1JxdYU1BzXWOdr/hVcBllZy6TUmQ9ROXFf93pi
 jCIbXkecNVV3VyZaBZGGPzx0MDE8L4IXyqvkvptXNQgHFmaul3WQfN8J0
 pXCfCy4c6EGAHadPz3WkTWBRcxjiTJSw1rNjVsWcZCuE+GQbmcuRgHYtw
 aqJw3D89KCMuFQHXwOz+bdkTf6//8kZlDK6NcfmMzYMRingh+2vrZVpF3 A==;
X-CSE-ConnectionGUID: go+ESv95SEqzBzwkvdk34Q==
X-CSE-MsgGUID: L5p1qMK9SZ+q4QbiGXfx2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91405284"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="91405284"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 02:04:03 -0700
X-CSE-ConnectionGUID: L4F6TTbPScOGpDGQ/vD63w==
X-CSE-MsgGUID: px97l+LIQsul4lmsr50Xug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="271804384"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.233])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 02:03:55 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Albert Esteve <aesteve@redhat.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, Javier Martinez Canillas
 <javierm@redhat.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev,
 linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Maxime Ripard <mripard@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH 0/6] drm/bridge: Add a BPF-based MIPI-DSI panel driver
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
Date: Tue, 29 Sep 2026 12:03:52 +0300
Message-ID: <054ef52478fc93fc213a9dae23ea77f73094aaf2@intel.com>
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

On Mon, 28 Sep 2026, Maxime Ripard <mripard@kernel.org> wrote:
> Panels in general, and MIPI-DSI panels in particular, are pretty
> difficult to support and require pretty much a panel driver for each
> panel produced. Most of them are pretty simple, and require an opaque
> initialization sequence that is usually poorly documented.
>
> This creates a tension between OEMs and distros because OEMs will
> typically get a new panel to react to a sourcing issue during
> production, and thus need some swift turnaround between getting their
> new panel and it being operational in the OS. Distributions on the other
> hand can take years to ship a kernel with that new panel driver.
>
> To solve this, I followed the example of HID-BPF and wrote a panel
> driver that will rely on BPF programs to perform the panel
> initialization. That way, we can ship the programs separately from the
> kernel, and with a different lifecycle. If this driver is accepted, the
> plan is to have a userspace component started by udev to identify and
> load the right BPF program for the panels found on the device.

I'd think for most panels it would suffice to have a declarative
language describing what to do at what points in time. For example, at
poweron, enable this GPIO, wait a little, write this set of DSI
commands, etc. You rarely need actual programming, or even ability to
read-modify-write something.

It could be, say, YAML converted to some binary representation. Maybe
that could be in the DT, or maybe you could override it with the
firmware loader. And obviously any vendor "blob" could be trivially
converted back to YAML and upstreamed.

Where that falls short, you could always have a dedicated driver, or
extend the declarative stuff.

Now, the question is, how much more BPF solves over that, without
requiring a dedicated driver, and is the added complexity worth it?

FWIW, on the Intel platforms that support DSI, all of the
initialization, poweron/poweroff, backlight on/off etc. sequences like
that are stored in the BIOS, defined by the OEM. A plethora of DSI
panels, one driver. Don't look at it for examples how to implement it,
but I think the basic idea is workable.


BR,
Jani.


-- 
Jani Nikula, Intel
