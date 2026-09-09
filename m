Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07D8C79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B77110EA32;
	Wed,  9 Sep 2026 20:50:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gOMeFThn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E63910E943
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 20:50:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61343601F0;
 Wed,  9 Sep 2026 20:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AC61F00893;
 Wed,  9 Sep 2026 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788987014;
 bh=sEYSNtkQsHWLYM3PXCQWIlCK3l7SMDlKCMnAzv0/c04=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=gOMeFThnbpVMkbb/Ox7his+45bTJSZUYII58tClT7B8IjjpnIKFg6jLm5H0UsoOJY
 RUXCNaGZpbKb5PEhI/OdxxWOoBTXYoZfHWNmCVkVoepyaqJWuS6Qr+gtbhw1myp8bm
 2OZUGUh8j0ZkNjOUvlTeX/HNUf11W90knVRiU3Z0Lr2AtlfBHcoH3rUgk6yqGBw/77
 t61uzTrJ2RmBaP8oTPgK1nQSi5NC5Rgq6AYLeAXtZSIJaGWHHrvi5MpcXjkeMEsamA
 8HnZh94+oYrhwK7Ivk/BCHl9N1x8LjC+uOgJ6yV9CduQC/WH37KV6z7otqORactsEp
 dB8mtHsZclHfw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfauth.ams.internal (Postfix) with ESMTP id C2B03198003A;
 Wed,  9 Sep 2026 16:50:10 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
 by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 16:50:10 -0400
X-ME-Sender: <xms:gMahahDNLKkgf41aoJ7QltWnM6RjqnFpLfXsEojPI_9JWYuPk2iNog>
 <xme:gMahaqWDng7vjgrXuNAJZtouBbnOu9dKHOb_H84YyQJQkj3qP0y8S-vvvD1z-CQ7u
 tpVSYnCSUxwrq2nqgQjHhARBIoqOZDKM8W--cYdHTAmXZL6hXtrCpuW>
X-ME-Proxy-Cause: dmFkZTG0uhuAwommTLNbPA5zod+Ry1qWg/m7XlAGS9AdDnt3HTzO0NGzxkWWcRme1Tw0h6
 2oy+SYxgKztzRfyTjPJiM9vSe+eacDZh4DciJUPEIZV25DTKFUp824VkumpHvRrGOv/0uZ
 ITnJQHUUoBa9V3Il4KqyRBk26etkkKEVTIsIjSYZfhjUr+jIr27VYJ4CUq9E6v0MqhyHHT
 Pa0UQQrdGQNuqNG6ZLgVgfay6/rIuK7BT7LhjOY8wUuwIQoryxN6QuDg5BU2J/1X+OK6Ua
 OrBdMMNlKJPGlQuVV1BHGhlCy9po7rYP0YrFEfYf4v1gpVIY+KoUh0HRsQhWy9Z1NcphWX
 W8sG8Mtoj6S1OZxYPWVZPKkNHhvIs7VSSqEjX33Rj6p04iZ+bqaVzR/Xcb0c5IeJD0evQr
 +eBpaz3wbej2T+yt4olZbvQCvZMP88jwwKNZFqZCdJC4uemKpuNXA9uqW0Xh3TyuuzQRMq
 qmYBwykaCczZAe/Vls5T0E9LtGoPESTCNComwicK60COcZaapRYsW1HNZw0sdFhXKPPK/S
 5wQD0N+O3DZpgl/p6Gg6ikRyWnFIKINIurficUB19XTpSUuiqo8cL0VbFqagd6oxH6kRLi
 cm8qR4ZH1F1Y3jJ+GxSwPhDHaQvfeIom0Om/ZrEbgHhWGxbgAzdfgFyt0zqg
X-ME-Proxy: <xmx:gsahagC8DuynwTStL5ScvWsLHE4Pod8CYU1jOS5DnTK-BttUxCdX9w>
 <xmx:gsahau3Vr7wX7MCFw_jYXNrh6a-x0a8e6SQ0Zmt9VHhZY4VyWakx8g>
 <xmx:gsahalOmgsfnZ8TiK2vbZqQHgFzdb5bOjWnkh5RJ2MWqpmVwb-td2Q>
 <xmx:gsahaj4i2OtfLp4fLGOgmxvOaUJeQPp0JAqE7M3ADtmx_KbHPQpJaA>
 <xmx:gsahaqbk07EfSSONzdTia82tGwneMbOHRyPdPWn7pCFmJT79vSYE6br9>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id 81AA132A007B; Wed,  9 Sep 2026 16:50:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Arw8dbDHChV7
Date: Wed, 09 Sep 2026 22:49:48 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: mfd@lists.linux.dev, "Lee Jones" <lee@kernel.org>,
 linux-rtc@vger.kernel.org,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 linux-input@vger.kernel.org, media-ci@linuxtv.org,
 "Conor Dooley" <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 "Rob Herring" <robh@kernel.org>, linux-leds@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Message-Id: <9cd2bbe1-6e0a-4387-b082-5ea4d70c7379@app.fastmail.com>
In-Reply-To: <20260909133929.AB9A01F00A3D@smtp.kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-11-arnd@kernel.org>
 <20260909133929.AB9A01F00A3D@smtp.kernel.org>
Subject: Re: [PATCH 10/14] mfd: remove unused rc5t583 driver
Content-Type: text/plain
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

On Wed, Sep 9, 2026, at 15:39, sashiko-bot@kernel.org wrote:

> [Severity: Low]
> Does this removal break Kconfig consistency and leave dead code in the tree?
>
> The config GPIO_RC5T583 in drivers/gpio/Kconfig still depends on MFD_RC5T583,
> which violates Kconfig rules since the target dependency is now missing.
>
> Additionally, drivers/gpio/gpio-rc5t583.c is left in the tree and still includes
> the deleted <linux/mfd/rc5t583.h> header, making it unbuildable, and its entry
> is still present in drivers/gpio/Makefile.
>
> Should the GPIO driver be removed in this patch as well?

Right, I had this as a separate patch but folded that in here now.

      Arnd
