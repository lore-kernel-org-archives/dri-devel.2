Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5E4C55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 20:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48C110E0D8;
	Sat,  1 Aug 2026 20:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="Z2YvC1bl";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F25FA10E0D8
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 20:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785616235; x=1786221035; i=deller@gmx.de;
 bh=hM7qstC+4+zdfTOXgnsHcQMmS40DNDN3v+I2mlygUXo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Z2YvC1bl2OGksc29zZJQ3fUV8aWIy4yjcnVM0UlsMBWJadQw3ri2cmFyaY5SpJJq
 r7RjDfQSNIA2yFAO2v4QJcM+MUyMkby9V4oGhn/kOyg4nPddXNp74Xcbi57JW3yiI
 J59LsbwjP7htBebCbwfjEZffgLIenISnTKkcYVAbLfnaowagdyB5nZb9eTzcwvvif
 FY7Jc4jQg3XuUR5f8IQTWh+5GHwLI0Y4xBuHZgX9N8zjH9HtE26i5M1DWotLcXYB2
 LKI6wV195kPOMkK+OeeF1iqRfdBsFuSWgyFCdYUvzOeesDEf/X8bWOJKJavMrSfnA
 rD39rQQpI2fOvmzI2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysW2-1xBlFZ1Xko-00xfS8; Sat, 01
 Aug 2026 22:30:35 +0200
Message-ID: <5e81c472-7fd1-49b2-8c55-6f55cb4a33c1@gmx.de>
Date: Sat, 1 Aug 2026 22:30:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] fbdev: ssd1307fb: add support for Sino Wealth
 SH1107 controller
To: Javier Martinez Canillas <javierm@redhat.com>,
 Jakub Turek <jakub.turek@elsta.tech>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260731-feat-sh1107-v2-0-0d2893e44ebd@elsta.tech>
 <20260731-feat-sh1107-v2-1-0d2893e44ebd@elsta.tech>
 <a90747ae-e2c0-4add-9fff-1ff473d1b410@gmx.de>
 <87y0epd82a.fsf@ocarina.mail-host-address-is-not-set>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <87y0epd82a.fsf@ocarina.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Gyk/zW98MnmVFzoWVab60V/G0bjm2NqNs7YR4EPsi5Qjf9Q3Qk
 XpiYwp8HddoHOS9EjWDk2WDhkJ1vClm83NZhx3EDwTQicSpSxx6ZxyjMUa0fo1TFpcw6GHB
 hYRomtyBU+z+/G9lQ3TQXBnnOld91yTrKconE9LosYE2Ar2D7KvLNS9849eE7kmAoPGNljb
 tX0Z+f+Bdh2mmvJmGzTJQ==
UI-OutboundReport: notjunk:1;M01:P0:CZkWk9Wj4eY=;kpkPrHZx0XuNcyF9im1gV3eufn6
 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
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

Hello Javier,

On 8/1/26 20:11, Javier Martinez Canillas wrote:
> Helge Deller <deller@gmx.de> writes:
>> On 7/31/26 16:45, Jakub Turek wrote:
>>> The SH1107 display controller is very similar to SSD1307 but the main
>>> difference is that SH1107 has different memory layout and uses page mo=
de
>>> adressation only.
>>>
>>> The SH1107 relies primarily on vertical page addressing mode where the
>>> internal 128x128 GDDRAM is split into 16 vertical pages, rather than
>>> the horizontal/tile addressing modes natively utilized by the
>>> SSD1306/SSD1307.
>>>
>>> Signed-off-by: Jakub Turek <jakub.turek@elsta.tech>
>>> ---
>>>    drivers/video/fbdev/ssd1307fb.c | 87 ++++++++++++++++++++++++++++++=
+++++------
>>>    1 file changed, 76 insertions(+), 11 deletions(-)
>> series applied.
>>
>=20
> Why did you apply the series? I mentioned in v1 that Jakub instead shoul=
d
> use the KMS ssd130x driver that already support variants that use page
> addressing, such as the SH1106 (adding SSH1107 should be trivial).

I assume, that Jakub or someone else will send a patch for the KMS driver.=
=20
> Also, Sashiko correctly pointed out that the fbdev driver doesn't suppor=
t
> most of the properties mentioned in the DT binding schema.
>=20
> Now is the opposite given that you merged the DT binding patch. The ssd1=
30x
> driver doesn't have support for the "sinowealth,sh1107" compatible strin=
g
> that is being added by patch 2/2.
Ah, ok.
To avoid issues, I've dropped the patch for now.

Thanks!
Helge
