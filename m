Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17B3C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17B9B10E8AA;
	Mon, 28 Sep 2026 10:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GOX3tfQm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF41D10E8AA
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:05:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9915F42338;
 Mon, 28 Sep 2026 10:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2451F000FF;
 Mon, 28 Sep 2026 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790589940;
 bh=43+YVXyrdWk5fDHV8RByct1Z4fjfr1ARLHxq905/6e8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GOX3tfQmMrYnoW34ss7TvG8kuqFbajcWZxildni27Q4qyCt3q6MdT0rIg5ciHjuIo
 ao/yjWenwFUosPjQn71u4WfnmotIB5tVD7Vdb70ePA6pMmmPU9jAhx2MPsmqDhZ51o
 W40AkISe8wpNRrkok7wLzgoO1nNuxOmV9YPC9VoK3HQgMDx0fT8KeoyyOm8zeLII7h
 c1Nz/8LwgohFdaLX5VydGVDUD6OHzTWOrYeKc3Xp9QIEq/O7qPdpd+7P+8A8dTOfh1
 IUdyrAJxVwfygYSpj3S61JrV7QpenbckymrXTLihS44x9ovfeLwJwgCejCEejqVbms
 TftN0U44DYYDQ==
Date: Mon, 28 Sep 2026 12:05:38 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rudolf Marek <r.marek@assembler.cz>, Chris Snook <chris.snook@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>, 
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, 
 Duncan Sands <duncan.sands@free.fr>, Chas Williams <3chas3@gmail.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, 
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, 
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] drivers: Replace __MODULE_STRING() with __stringify()
Message-ID: <aro70o5N7VoXbjsy@zenone.zhora.eu>
References: <20260922-module-string-v1-0-c18766690185@suse.com>
 <20260922-module-string-v1-2-c18766690185@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-module-string-v1-2-c18766690185@suse.com>
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

Hi Petr,

On Tue, Sep 22, 2026 at 03:32:22PM +0200, Petr Pavlu wrote:
> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
> 
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
> 
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
