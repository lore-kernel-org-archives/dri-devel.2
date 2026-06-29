Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7FFC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557BC10E77C;
	Mon, 29 Jun 2026 15:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="NE6t34RD";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="BvW9GpEf";
	dkim-atps=neutral
X-Greylist: delayed 329 seconds by postgrey-1.36 at gabe;
 Mon, 29 Jun 2026 15:51:03 UTC
Received: from flow-b5-smtp.messagingengine.com
 (flow-b5-smtp.messagingengine.com [202.12.124.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E7B810E77C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:51:03 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailflow.stl.internal (Postfix) with ESMTP id B7CF01300119;
 Mon, 29 Jun 2026 11:45:33 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 11:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1782747933;
 x=1782755133; bh=JSWP+oCjDefLm/g9PuV1GqUkziDul2e9yv/ysVQsJLY=; b=
 NE6t34RDiIItJnjdvpPNLzERZEmy1Uokb4joPY1CUGLVDWSQy6O7lM7YR/JH2Vzz
 EKjSBDHgy12XKPTe4T6/vFGszy9/X5bhW/dAEDGMtAFHdRGEckNuxhc9bX3PR0VE
 bfW0MW2BR1AKR58Jk7h1JxjrIx1Kz7REAVnwk0oAlfoj8/mj7rRNlBSR0zA4hhnh
 nrZ5Ql6KmC6VRVCiJ20YjlxB5Hon27fcsCOduVLOhAndchegK3YeVpKE9Pp1EySs
 +Hgew3gjNwCsL97JbgGzSZGffJk0l4s3icmD0kqHlku9NQytJJHrK5zKTtqTrlSN
 nN0K/5MSbp6GsS3AP9v5Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782747933; x=
 1782755133; bh=JSWP+oCjDefLm/g9PuV1GqUkziDul2e9yv/ysVQsJLY=; b=B
 vW9GpEfQf5KLp9NtJM6GkHv3I5ZqIvw4Ca2lMiHX8SKqsoxlmypG2EMXAsormSFb
 oqLT0a0Bl9FJyA6vd4v32gwdXkqPQVCs0Q1Y9jXp5dOSVQI2tfbQcx1ULcycd2no
 cz4W31l3TBY05Bi2KSWoBV2ZPe6YbfMg4EFP7hw/vkSYA/ePVKRQACV+DCkNrleC
 7d2U6h7NAcmkprtPUjO4A9XW6JXNK6W9RSqJU2/A289YIaXuaBCd1hJaZ6vsHuTg
 GNxjVNjZ5DH/aXylHFIrfAuE5N81jk6hj/53mTDmJA3sJAwIS6GzLql0EapV+l/2
 td6qNY5irlX8jNYf/UttQ==
X-ME-Sender: <xms:HJNCaoMrkvvQS7N_eQkd2-7GzY3rf6oAfFR9scbcsRER6z01sw7mzQ>
 <xme:HJNCapwMpwLVp89QaYKeW8Gu_iFO6mtIcDakQdQ1IcDR2awHglttG5XYgUbY-f2KY
 MUHVhVlQ81X_KxAdYNn48ZwudPAYseWVvBXQ00pUVx7Z5102rCPfbsZ>
X-ME-Proxy-Cause: dmFkZTGfEuV5uhz9iLc4/VqJewkOwZztE2Q/W2L8MWGpthXJSG6cnqB0ybUTZO/gmTStFr
 IiMG3oMMwTOd1GN29iTAZh8ELqDq/pvNTu31HqcDhNTnRV5w+qN8TY5zQgqjhrWyTFnLFv
 a5lC1bd0Nsy33atl2U9pCG8DwHiBT9SAvLqnCXSLgY6ykY2nreWYk0o6gpE7z+zCzbU5QI
 CLqmPEwYE4mll5+cmq6mEdAN12TaRxj619rRYC2M3spZPblqPgudPkyzWrdvTZpBYK3w/u
 jqv7Hdzc+TtswHLZ1V6GZ+c/1ZffJJfwsB5JIPB30uvkpQkKQBrSQtzi9AGb8HNFEb2kgE
 qKkXl9pCm/0B95O8InFrTkKN0fJJdpnCSraeOZvlbYvDYSuDEOsOuD28QLxuf4mNOnHYEc
 4em35Aufoj/L6MFtoXv8X9guYW3iZk9yMbK8VidKBOe9HIlA6Vy69oYVLWvoeIP/sRtUxM
 xWA7NaPmd/Kd9MV/ItckFUA5jQ19oB0lqDlABCPUJva5FAJO0rNnJiVDlHuYcKo1028G2L
 QCmWZB57sVtG9lZURwNtcccEDwqWzXsVO1FCuadUaHZRSO4zh0UrefsDvNNDkSsAklUL8C
 nDBMgI4yo+tcTzxNjLzthPlRQuu7ftRHxOLDna+Fu5ygZv/F2jkt5rcMUitw
X-ME-Proxy: <xmx:HJNCaiVR99ITZUIeVHLQIjkAl3W5L7-NY_eXPpexE2ezyiuvPV7Wig>
 <xmx:HJNCaqDcmel0SZvoqXYoLZayz9Q48weXPGpjP4Y1EEA9-teXfq9kNA>
 <xmx:HJNCalHWKybZhCSB_h9ep1tLEkKEMci7ODZ3AjJ9oK0yH0tMhtYVDw>
 <xmx:HJNCamc1hcyXGhjSob0H8QG7OUqPoVNgYLrZzyvRI9sJF6RPK2srWA>
 <xmx:HZNCahf_1C-xXUG9BEQMuJSIEx8k4QdhQtNpq8TMrV7EM8NaHbepNMFj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id BA658182007A; Mon, 29 Jun 2026 11:45:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A045QOfflcQ7
Date: Mon, 29 Jun 2026 17:45:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>,
 "Marcel Holtmann" <marcel@holtmann.org>,
 "MyungJoo Ham" <myungjoo.ham@samsung.com>,
 "Chanwoo Choi" <cw00.choi@samsung.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Andy Shevchenko" <andy@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Ulf Hansson" <ulfh@kernel.org>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-usb@vger.kernel.org
Message-Id: <34d4eddf-bfe5-4103-b2c6-143c63ea37f9@app.fastmail.com>
In-Reply-To: <akKN59lv55CXS3HU@ashevche-desk.local>
References: <20260629135917.1308621-1-arnd@kernel.org>
 <akKN59lv55CXS3HU@ashevche-desk.local>
Subject: Re: [PATCH] [RFC] gpiolib: introduce gpio_name() helper
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

On Mon, Jun 29, 2026, at 17:23, Andy Shevchenko wrote:
> On Mon, Jun 29, 2026 at 03:56:29PM +0200, Arnd Bergmann wrote:
>> +const char *gpiod_name(const struct gpio_desc *desc)
>> +{
>> +	return desc ? desc->name : "(no gpio)";
>
> Can we get into here with wrong (error pointer descriptor)? Shouldn't you call
> one of validate_desc() / VALIDATE_DESC()?

Since all the callers previously call desc_to_gpio and that does
not even check desc at all, it would be a preexisting bug if
any caller passed an error pointer.

I added the NULL pointer check since many callers had that
part originally, like

      tsdata->wake_gpio ? desc_to_gpio(tsdata->wake_gpio) : -1,

> Also not sure if "(no gpio)" is a good choice. "not requested"? "not provided"?

Any of those seem fine to me, not sure.

>> +static inline const char *gpiod_name(const struct gpio_desc *desc)
>> +{
>> +	WARN_ON(desc);
>> +	return "(no gpio)";
>
> Hmm... This will be a second copy with a slight potential of going apart from
> the other case. Perhaps a #define? (Yes, yes, I understand that there are pros
> and cons, in particular readability with define is questionable.)

I was mostly trying to optimize for consistency with the other
stub functions here. Since it should not actually be used at all
without gpiolib, returning NULL or an empty string here would
also work.

     Arnd
