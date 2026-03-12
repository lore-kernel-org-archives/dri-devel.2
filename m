Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 442C2106ACEA
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 702A210EAB9;
	Thu, 12 Mar 2026 21:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="1/Rx93PS";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F85710E305
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 21:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=rvd89gy3M/R88xH2NB6tQwBMKfAM+iXnOUeThTDccJE=; b=1/Rx93PSD4XhywynZXNYgCMI2x
 RgAKeeyHO2saVPOJsuKlt3vxGGVQT3DGmWlnXRBetrxYt3NOUK3EWshx17jvGYWd8WZ4TqzQvebAT
 FNazQJRzDabG2KIZuACvkNXeV2GIbRaWJ5NWvhid0TcZTp7Tt7IH3u4fMEicQWwzd68eQ8rrA964s
 oIKoT8+t2AvHT8zNi2D91gImYnB6EAGZjovnvfq42J2e9LE8wuRLjwfIsb8+VTIU7sH4IN/u2aGzf
 W+7YXr7omURbmx7qTWK5GLYmdyI3rv0OW9GVogNeze7lSfNV8K4Ox4iwXNeogxnA9cZW2VGyR5bn9
 h5L4yV6A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1w0nAi-0000000FOT8-2SJi; Thu, 12 Mar 2026 21:02:20 +0000
Message-ID: <034989df-cf86-4136-8522-6c48e5523645@infradead.org>
Date: Thu, 12 Mar 2026 14:02:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fbdev: update outdated help text for CONFIG_FB_NVIDIA
To: robgithub <rob.github@jumpstation.co.uk>, Helge Deller <deller@gmx.de>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org
Cc: Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Sukrut Heroorkar <hsukrut3@gmail.com>,
 Mukesh Rathor <mrathor@linux.microsoft.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260312205507.70b9013b@hexa5>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260312205507.70b9013b@hexa5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/12/26 1:55 PM, robgithub wrote:
> The help text for CONFIG_FB_NVIDIA refers to obsolete hardware and
> incorrect default behaviour. This patch updates the description to
> reflect the current state of the driver and supported devices.
> 
> Signed-off-by: robgithub <rob.github@jumpstation.co.uk>

Inline patches are preferred over attachments.

I thought that Claws mail could send inline patches successfully. (?)

Documentation/process/email-clients.rst says that it works (after a little
configuration setting).

I don't know anything about which products are supported, so I have no
comment on that.

In the patch, the indentation is incorrect. Kconfig help text should be
indented with one tab + 2 spaces, not with 4 spaces.

thanks.
-- 
~Randy

