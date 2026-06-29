Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE333C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 15:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D2010E98A;
	Mon, 29 Jun 2026 15:56:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="otExSv6C";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZP+OSo5y";
	dkim-atps=neutral
Received: from flow-b5-smtp.messagingengine.com
 (flow-b5-smtp.messagingengine.com [202.12.124.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F2810E994
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:56:04 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailflow.stl.internal (Postfix) with ESMTP id 7F8A013001E3;
 Mon, 29 Jun 2026 11:48:31 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 11:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1782748111;
 x=1782755311; bh=OQSYL+rcbbMvXGkfQit/IeSyVBDzp7a1uiLZytls49o=; b=
 otExSv6CCfwgU+53OmRzfq2B2DYzwG97/7OG2yFVL9SLp2zuXWfhdL/w+7nIA4id
 pS7hJpE+p/zM36qUEbCM1LqXAUyUGB34hT8s1CLctdvUhUl0w1ZhqpR2HIS3PV7o
 bsnIFZBboF30NjRkOQ9UT+Q8NXhm9E13I7offTJ2aRcuG8r2Lm82KoHQohaMMwV5
 1pog70vnywIoIEN8MJJPZBLCU4XXKtem9FHI/gOfgvqsBOGTC7GkxZFe5P2Lw2ga
 yjsSm7K9GLJMBOqJ4k1/I3YVG3A8X1aWU9NyZdVYzw3BMgCE/ro9EeoLtAyGzeFK
 Pl4J0bO7j6edaTVNsgNFEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782748111; x=
 1782755311; bh=OQSYL+rcbbMvXGkfQit/IeSyVBDzp7a1uiLZytls49o=; b=Z
 P+OSo5yef9/cf64i9oZY96JMQWrkgDB3///chYutdOeJnhuCLMIQBthaTPJcoReA
 A42wB43XIfLOAHZlUSZRrEWmaIkkJVPyR9ZrNj0Zg79fjHX5GNwFKh44vBnstNjs
 +gKwPg044HSnH3p4e5kEU8/gJdXnd5J9rcJgbSl1CjuvG8G/lzCfuRrzQSuK0yFG
 nAQ3o6X2C2t4pALrCSMONEpg+Bh0sXEMP7jMgbrh5fxsQE9kGxPzz2YGv3rx56Gv
 vpRCb8LQ5USUCARnUKXaPOljl/bpYRFLx50FMB3vSHHH4V2/reUKPVgJULvxVire
 Mkj0fQjdTFT7fm+9wEFeQ==
X-ME-Sender: <xms:z5NCakeBygjeAHHHThz3dUsTnvB6AK_UVMjKz-WZKZVRr2lluk78FQ>
 <xme:z5NCahCpYUk2lb8a1RbHVmyXeGBSy5l5DdSrmUr_uS7YYPkiTX-Ewa_wUd6Pe47oi
 fqqLUBT-9g8HmIrQlngZpk17TUMnckWDzEtut6NIZEoxunmVuyUuWA>
X-ME-Proxy-Cause: dmFkZTGx/zQGI8s/7q5psZd2hog4QvvLF8VyS3SEh6yndDN0NLF+SUROST5TuJaRfbYzsR
 kRNLz+nZnLIWxTAnVDEiVI3LWMoT76m1NPebPhT28iJCWPXc0GO7oFLEPDfrdg9tfzroWb
 HnrfV5e1jPmjz36LnDV+54JGw32aQMY40K1t7WiGcRFvXEmQH6xS4redW3l3jMN7eHVHXH
 OMUBqc4hdT1AWM82wO5kRpwsYMYMv8K7MRSSgj1UrGhr0ZavzP88ve8YyHNE7ly6hSja/5
 QiP/FqZsNFQZ34zbxnGfKyKytbn/wMNNFVGFjw0DXOPPa8n6XjB/fzcu7YZiP8PrvEJSOd
 l8wa/9o9YFghE4nmtzEFNP5GHS4DgMKC4w2rG1ksKG4K1tNod94D3VEihl/RxyL9ohAzRZ
 DV3gAxtenHg9Z5cQJzoBipUKZ9pqhmJudtox/jlSGg2Nc/v34rLMtOwqFKQfA1uoQshteX
 Fj+AMNKhMnJ4QbvjVI2RQG1hwfF0E+t7vkI/rh/pkR03lll3huezz0P+7sfFgS0BBFEc4I
 tgwdiyeO6AWLRMbzNKqGc2BGlgFQrUK3BgCvUK9m1iH9OEbmB8sUgFESS3o9AeJDZgiza+
 QtMgrmbDhds3U+BZzmooK8ccK4+ZTU4CwBh9Kr050guMXdKmxiwbffVRqy2w
X-ME-Proxy: <xmx:z5NCaqnslMw1U4x946I_QUjw_ET8HBcAAsdnOpVQMvFlVCBGjb5OEQ>
 <xmx:z5NCatSrHaFps5ZyxX5SqaW3oWWvqcDK6TzS14FaET5Pf4npQ179sg>
 <xmx:z5NCanXHY9GeHNVa3tjFzINJQ_mrCW-T7sCwo55oVGN2tZsh_Krxbw>
 <xmx:z5NCars5LXs8k9icxryzzfrpvBcoTsGtWAAjyBjSc4vWQn2-iQYc8Q>
 <xmx:z5NCarutsUgfjq0e6Ud1ZnN0qPM1Eju682i8umHuTCrQdRzm5WnqOIk6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 215901820082; Mon, 29 Jun 2026 11:48:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A045QOfflcQ7
Date: Mon, 29 Jun 2026 17:48:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
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
Message-Id: <ff4d7043-1929-4fa1-ba5e-f28403ad6fcc@app.fastmail.com>
In-Reply-To: <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
References: <20260629135917.1308621-1-arnd@kernel.org>
 <CAMuHMdXhsM4JzArRuB=A46N-Ogbn2Fans+PVJVA-hEytFq=DeQ@mail.gmail.com>
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

On Mon, Jun 29, 2026, at 17:29, Geert Uytterhoeven wrote:
> On Mon, 29 Jun 2026 at 15:59, Arnd Bergmann <arnd@kernel.org> wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Most remaining users of desc_to_gpio() only call it for printing debug
>> information.
>>
>> Replace this with a new gpiod_name() helper that returns the
>> gpio_desc->name string after checking the gpio_desc pointer.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for your patch!

Thanks for testing!

>> --- a/drivers/gpio/gpio-aggregator.c
>> +++ b/drivers/gpio/gpio-aggregator.c
>> @@ -758,8 +758,8 @@ int gpiochip_fwd_desc_add(struct gpiochip_fwd *fwd, struct gpio_desc *desc,
>>
>>         fwd->descs[offset] = desc;
>>
>> -       dev_dbg(chip->parent, "%u => gpio %d irq %d\n", offset,
>> -               desc_to_gpio(desc), gpiod_to_irq(desc));
>> +       dev_dbg(chip->parent, "%u => gpio %s irq %d\n", offset,
>> +               gpiod_name(desc), gpiod_to_irq(desc));
>>
>>         return 0;
>>  }
>
> Before, this printed:
>
>     gpio-aggregator gpio-aggregator.1: 0 => gpio 589 irq 188
>     gpio-aggregator gpio-aggregator.1: 1 => gpio 590 irq 189
>
> After, this prints:
>
>     gpio-aggregator gpio-aggregator.1: 0 => gpio (null) irq 188
>     gpio-aggregator gpio-aggregator.1: 1 => gpio (null) irq 189
>
> Same results for instantiation using sysfs or configfs[1], although
> the latter does have optional support for specifying the name.

I wonder how many of the other instances have the same problem
then. Would it be appropriate for gpiochip_fwd_desc_add() to set
a name itself to address this one?

       Arnd
