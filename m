Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854A606A333
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WppsRZ4Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68C7F10E0EC;
	Mon,  9 Nov 2026 18:08:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7DAE10E0EC
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794247690; x=1825783690;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=wfrbeowEpzlsOOtS5Xzt/Z99rOONWv91scfsMt1LT1o=;
 b=WppsRZ4QDfOMoen13mGaFNtTKewEg1uqtYAOCUDgQIzBq9PZcynEA9MV
 Wpk//ldnWCHmq0mHAAX0nIi5/DNsUN/K4RFKtnVufTdw9RQGvOjHdzb/J
 QevrNVh4SwpTj8vw75p5Q0BW0PoFwHqrx+NFvU47cSJ/uj1DrQrcNgea8
 FjbpA5NdsommXRcGmGzxqcvJRAsNUspPnKgWGTzw4iTwTY1i/fUkdYRuO
 Aruw32AhBD91w8XvCvWQkd7QSNHdIvnpqhgvJm+FvNgaiv0e65Zc1/2on
 DVLbLV09J7jnUyNWtquN2hoNAa+KrBywvl/pDH6oIb+h9LrywkwzDtqkT w==;
X-CSE-ConnectionGUID: qx0Y+DaZQSuwEgf7HvmI2g==
X-CSE-MsgGUID: 0CquHDVVQsOCOwklvAIRhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2894244"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2894244"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 10:08:09 -0800
X-CSE-ConnectionGUID: REOqqbgbSlKUYG/hgL23ew==
X-CSE-MsgGUID: M/rq1zH2TtK3zErWiBcqiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8094048"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.93])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 10:07:59 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Petr Pavlu <petr.pavlu@suse.com>, Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
 <hsweeten@visionengravers.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rudolf Marek <r.marek@assembler.cz>, Andi
 Shyti <andi.shyti@kernel.org>, Chris Snook <chris.snook@gmail.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marek =?utf-8?Q?Beh=C3=BA?=
 =?utf-8?Q?n?=
 <kabel@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>, Mika Westerberg
 <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>, Chas Williams
 <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez
 <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, linux-watchdog@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rtc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-atm-general@lists.sourceforge.net, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
In-Reply-To: <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
 <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Date: Mon, 09 Nov 2026 20:07:56 +0200
Message-ID: <6c00fc009f4e61e87895eb2dd3d77c5dfb28183d@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026, Petr Pavlu <petr.pavlu@suse.com> wrote:
> On 10/14/26 11:36 AM, Petr Pavlu wrote:
>> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>>> moved it to the graveyard section at the end of linux/module.h
>>>
>>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>>> remove the macro.
>>>
>>> Apologies for the wide distribution. Acked-bys are appreciated.
>>>
>>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
>> 
>> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
>> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
>> and reviews.
>> 
>> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
>> should go through the hwmon tree. Once these changes are in mainline,
>> I plan to pick up the final patch ("module: Remove obsolete
>> __MODULE_STRING()").
>
> v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
> the final removal in patch 3 on modules-next for 7.5-rc1.

Perhaps send it for v7.4-rc3 to prevent *new* __MODULE_STRING() users
from cropping up between now and v7.5-rc1?

BR,
Jani.


-- 
Jani Nikula, Intel
