Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF41C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C46D10E1D0;
	Thu, 10 Sep 2026 19:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="T6NE9aE2";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYxMmbGp";
	dkim-atps=neutral
Received: from flow-b7-smtp.messagingengine.com
 (flow-b7-smtp.messagingengine.com [202.12.124.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED49510E1D0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 19:16:32 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailflow.stl.internal (Postfix) with ESMTP id B56C11300123;
 Thu, 10 Sep 2026 15:16:27 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
 by ams-compute-02.internal (MEProxy); Thu, 10 Sep 2026 15:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1789067786;
 x=1789074986; bh=LL5BvvZb4Il/L3smCK764roi3UOjYRXO6PPqF7iA60o=; b=
 T6NE9aE2vD0JgubP1YTXJkCmky0gcVC6ihsBHZm0RBXVJxnFvHKfpn/jgGp268bN
 Ocg7RiFvSCyv3dN0vfJMl4FlzZpgO4zM90q5HHZOCpsPTZkmzluvzrr1KvRaqgj3
 ghFpPAXXhsj+/FIdWBFlcGd47PnXaH44ztoCwJPu7Hg3QUrTpwuAJfdQpSLRG6ok
 RIcMos4hom4IpDKnTxOGAMJvUM1/Xrm3A2vjwRfr/20H7gjk9LaiALMDUDnq1EcZ
 kRxAGd0BLSQUoZ5+Db6ZW7jDP7fVF6NvOTVSgvHLp6p1x3Ta5gIVWBi1SBbBNcVc
 4jz2EzypFMJlbI/B3mORLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789067786; x=
 1789074986; bh=LL5BvvZb4Il/L3smCK764roi3UOjYRXO6PPqF7iA60o=; b=Q
 YxMmbGpUXUe6JWSt6wFgaWgV6kKFrifNL4zpMR8IZ6k9l09yGNmBC/tmkJ7jOHzc
 zgOhoTRRLmpNbujQkziwK4c6gb22BvDU0Ezlg80E7EUvAlLWaNZ9kh0CkTSmW0IV
 wlXQOi66Y4gisAqp/Jo89stwVrt44ixZH6W7RlPst3nm/SObEWktzzkILVr4+1+A
 JE1uf0+5KDx1W/HUbTProIiovUiesG6cjCSnok4CUfzYwk4/OcgXFVGlzwgYW5G3
 3PWz+DLGnB1EasndokoY6K9TbysUIa/qseWOHKmQORQWYzJ2VSVMZ7TypVR5NNJW
 u3NpvgNq1yYX6zbJMfO+w==
X-ME-Sender: <xms:AgKjapCXAUsGR9NzhQT6Weld296MjYYYYWG6pyncwTxdq3DdSnFYRQ>
 <xme:AgKjaiW8J9J6KMFNr1b_IJMuS-WWoZgFoDLpHRzD5u8XTq9EHOqwM1fQ-1zxZfuPJ
 In6bkVMOp1J3kJT1pw8149ZOGl03L3WdAPrCq5CqXNRr0V5Z7vvKUYT>
X-ME-Proxy-Cause: dmFkZTFPUI2hhqqgtUZ+uRBKQ2lOV87vEROkCNR5CaZ6fIgInu/qZ6Et872VXivU4qi3Yb
 S7K9y0Kh6x/9ahHXeHe+3Rw24dgRP6bfmbpqm1xjXzxznz/CitUohgCt3oeLEdNtCBDFWV
 wAwlx1y89/OGcLz7Hvg+1884PmXT1R/UZ4htyLe4evizdmRp0asTHgMS4ZwBPFc/D9Y+lL
 pjbKNCUOIiDW/kC+I7mCHtxy2/HBnsjdGqvOki3WVysUtRiD8CYdPw9xvpyYEClSdNLQWB
 gQ8Pl57Lb15IwzJNXNzaZUMYe+EMgk0WEb6jBD1eg4FQ4UgkdzcTpXiZHzLwatuZyMzQPR
 AbajmqzYJ9/lDdDepvVHPNjLIhqYfbx1gMTQq9/fz8LJQzh6PG/f4ScG9y5N/KfjK9+HQY
 DGntSRz8ZYM8imBuJaefnFLhlOX8sAaBt6BKM1LqdyrSIVsNJYoKWCY4KVxwAcF/mnAt4n
 oVJPPpYM7s8UyCTE+DjXlJDUBxdqJNXlz0qh7fZswAd6UVlEkQsnkgn0xpHT10dG8DBkoV
 TRwjPmyzBaUEWsnC/QuC7FM+G10r94P0DlNrsDk/6nOSOSFLMILS/ohAK2o9wIayJCiVAI
 qwuaG984U3MuKxrFrmRw4NSis4b6zo13+Wx2/aeQ0+fTJLlvOUkIf98DG+RQ
X-ME-Proxy: <xmx:BwKjajfvbFGu2OjAxcHE_tmdpPRGIP2DBf59mH27GAi-_s4MwoZukA>
 <xmx:BwKjaudX3nkcDf8KN60flmiSbgkg5YhfeXwsQEWoHH8zn5PLuCzkFw>
 <xmx:BwKjavJG5SWvaJdpynS7e-HjY8WA-99WOLGxUokNhNz5dK_9LWHD9g>
 <xmx:BwKjakq9OyXMmSADtkpqIobWGpuhowDn3l_sB6IoiO_PuGO9ClRUlw>
 <xmx:CgKjag7MJuyBvo36joTkPcVfhRPBUUVFBpIxBKCTUGfQOGfmb5qzZdd3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id E068A32A007B; Thu, 10 Sep 2026 15:16:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AK-jVwBtQCQR
Date: Thu, 10 Sep 2026 21:15:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Guenter Roeck" <linux@roeck-us.net>,
 "Svyatoslav Ryhel" <clamor95@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Bartosz Golaszewski" <brgl@kernel.org>,
 "Mark Brown" <broonie@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Daniel Thompson" <danielt@kernel.org>, "Helge Deller" <deller@gmx.de>,
 devicetree@vger.kernel.org, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, "Jonathan Cameron" <jic23@kernel.org>,
 "Jingoo Han" <jingoohan1@gmail.com>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "Liam Girdwood" <lgirdwood@gmail.com>, "Linus Walleij" <linusw@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-fbdev@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>, mfd@lists.linux.dev,
 "Michael Hennerich" <michael.hennerich@analog.com>,
 patches@opensource.cirrus.com, "Pavel Machek" <pavel@kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Sebastian Reichel" <sre@kernel.org>,
 "Support Opensource" <support.opensource@diasemi.com>
Message-Id: <e33b42dc-1561-4819-b028-b13af9e7115b@app.fastmail.com>
In-Reply-To: <7a92a79e-e22a-4e34-9f11-4086b88f62cc@roeck-us.net>
References: <CAPVz0n0ryOns2sCJE_jFana9MVzwEj1QZuPEa8FNhGbHXnMB+A@mail.gmail.com>
 <11652e5e-053e-45b0-98a0-0c1cb2aeedc4@app.fastmail.com>
 <7a92a79e-e22a-4e34-9f11-4086b88f62cc@roeck-us.net>
Subject: Re: [PATCH 08/14] mfd: remove unused aat2870 driver
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

On Thu, Sep 10, 2026, at 20:38, Guenter Roeck wrote:
>> 
> ...
>> drivers/hwmon/ds620.c
>> drivers/hwmon/f75375s.c
>> drivers/hwmon/max1111.c
>> drivers/hwmon/max197.c
>
> I missed the rationale for removing those, but then I don't really
> mind either. I guess we'll hear if someone still uses any of those
> drivers/chips.

None of these have devicetree support, and they are not usable
with any of the remaining board files.

From what I found:

- da620 apparently never had any users upstream, though it does
  not require platform data and is theoretically usable with
  an external dtb
- f75375s was only used on iop32x (long gone)
- max197 was used on x86/elan/ts5500, which is still in the
  tree but cannot be enabled anymore because it is a 486 class SoC.
  I have sent a separate patch to remove that platform
- max1111 was used on spitz, which is on its way out for 7.4.

I'm not sure when I'll get around to send the patches.

      Arnd
