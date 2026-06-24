Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476ADCDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 06:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF2C10E03C;
	Wed, 24 Jun 2026 06:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="CAYQE8+6";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2575710E03C
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 06:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1782282439; x=1782887239; i=markus.elfring@web.de;
 bh=Yqq4XWp+p3kifceGORFd2jQBDj3RjzcTWpq6JZ3BTW4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=CAYQE8+6wUYX3qfivZLzLC/FgzmzG4xYYJAFr/xuQ4FnFbtpTE2Plaf+GpSnlk/R
 cj0v2AMJv0mgUy7jBcBUcDo6bC4UM7KJdn4WE36gSEHBIloGtugCh26mG6+bX07ni
 6WuR2W4il7f8d6UFu8gtDwKd+6Fnpwx+RXiZNrfxAwyq+YYXmby1NpNPesgRHtxbf
 2489g9QGQDMj0j3O1lt239OCrT60mYVpTe4C72Q9kQwW/uKwn3yM0DedQherE/jLV
 fOFqGOg15QAdRMO6BiXWS8hH+vGMd90aANM+cl+PzOmDl+0IsebrPvSon5TaWgKwg
 04XKBNWUFYYMgnjLtQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB4F-1wgHPq1I93-00Wnzw; Wed, 24
 Jun 2026 08:27:19 +0200
Message-ID: <6194fe38-1f49-4190-a508-87d7b379e59e@web.de>
Date: Wed, 24 Jun 2026 08:27:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
To: Amit Barzilai <amit.barzilai22@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Azuddin
 <azuddinadam@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 Chintan Patel <chintanlike@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller
 <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
References: <16a86f3d-caf0-46d0-97a4-c9585bdaa06c@web.de>
 <20260623213447.30196-1-amit.barzilai22@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260623213447.30196-1-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FPSVt/JoKekDlA+VAEpC/+JR8z9XsVR+MLZFN+TWShm+AMKT8aN
 uaOkEvu5GNDyaszfkxmccPbrS0LmH7cTQ2Fuxn12cuMuF3Fn+SwxACrSyiq6bQmgBpjARGG
 QfQOCwg5AgDfJDlzgP765P/WVFF8dyD/YmBt0k6O717tQIbnoVG0AO36XXdyaKFcBoXa8vq
 60B7MtFDI7C/DTNjicbhQ==
UI-OutboundReport: notjunk:1;M01:P0:ZjnPpbG9fCw=;66QYnYZSLekJbUJa0TYcJn7Ofik
 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
 oNB9Z2yin1IOvrRdaU=
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

>>> +++ b/drivers/gpu/drm/solomon/ssd130x.c
>>> @@ -146,6 +146,33 @@
>>>  #define SSD133X_COLOR_DEPTH_256			0x0
>>>  #define SSD133X_COLOR_DEPTH_65K			0x1
>>> =20
>>> +/* ssd135x commands */
>>> +#define SSD135X_SET_COL_RANGE			0x15
>>> +#define SSD135X_WRITE_RAM			0x5c
>>> +#define SSD135X_SET_ROW_RANGE			0x75
>> [...]
>>
>> How do you think about to use an enumeration for such data?
>> https://en.wikipedia.org/wiki/Enumerated_type#C_and_syntactically_simil=
ar_languages
>=20
> Thank you for the suggestion.
>=20
> I used #define to stay consistent with the rest of ssd130x.c, where the
> command constants for the other families are all defined the same way.

Will any further adjustments become more interesting?


> In my opinion an enum could be a readable solution for these values,

This is nice.


> but I don't think the switch should be included in this series.
What does hinder you to take another design option better into account?

Regards,
Markus
