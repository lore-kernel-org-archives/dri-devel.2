Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68C5CA5FD9
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4602C10E308;
	Fri,  2 Oct 2026 08:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ewr6WtPx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22CB710E308
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790930971; x=1822466971;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YN0wOfl6bDY8nqUj5Q/9V9fQKfz4SuIc2QBNbMndnaU=;
 b=ewr6WtPxd1KcfTkOjEaFKJyKc75/Y9ggUa++rwzPuGuLMr3O1e/yacA1
 VKr5tDSI4xVYOR2ZIA3Ycav/DngT2j0am5uNJgSb+8oa81mVzE4zEHLwD
 qfYWzEim4TYvdnC3zjvfndlX7ou3RRBKdL7oHL/O265n8uzck6EGZlUdh
 8Wap/KlXI/k3oAnxiXUniRw8YrFmzbPieF7qOcswHhvsZ/7e+9C6UNEwK
 +AOGQHQQSUtQjT9vGaO1R3JH8YLKBXieZCydptiwlph1nkdjBYzDxtRZV
 0hWYRdsBhbd7ETibOzjinoQm2PEuuuEdi0ImuOxy67bSWi8uKe5TquVMF Q==;
X-CSE-ConnectionGUID: JsVHarLLQD2riNxs547g3A==
X-CSE-MsgGUID: hL0Q70lNQguoIU0tDYaJNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102219839"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="102219839"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 01:49:30 -0700
X-CSE-ConnectionGUID: EzkXN5aeRSCVrzI5i6k/hQ==
X-CSE-MsgGUID: jPdD+Ty8Tqyt/zWixcl59g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="276262414"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa009.jf.intel.com with ESMTP; 02 Oct 2026 01:49:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
 id F042199; Fri, 02 Oct 2026 10:49:20 +0200 (CEST)
Date: Fri, 2 Oct 2026 10:49:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drivers: Replace __MODULE_STRING() with
 __stringify()
Message-ID: <20261002084920.GF176164@black.igk.intel.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-2-fc7438acaf4d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002-module-string-v2-2-fc7438acaf4d@suse.com>
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

Hi,

On Fri, Oct 02, 2026 at 10:31:02AM +0200, Petr Pavlu wrote:
>  drivers/thunderbolt/tb.c                              |  3 ++-
>  drivers/thunderbolt/tunnel.c                          |  5 +++--

For Thunderbolt,

Acked-by: Mika Westerberg <westeri@kernel.org>
