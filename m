Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FECFC5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A3A310E43C;
	Tue, 18 Aug 2026 05:49:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="ZNU/HA32";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A872610E43C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 05:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1787032135; x=1787636935; i=markus.elfring@web.de;
 bh=pCBCtAiE+vvWZ1cnuOPDOCGP7CSKJvkCAtS/Lp6tFbE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZNU/HA32UkLKutPIRif/hEYYFeiqbwQ7OeaDDRnSBE0bpt0rBB5Corf09vmBKCZZ
 tfLwW2dVAd7oeWXwflzXmlBaGayf5Xw3tG+8pLlgEwHdpg6/KUnl8qlaucRu24VPc
 Kd5MqWKuYsa4I2t8pc9fMaI2R1tH4GEjUUhf6nGy54aqwelDby8buZI3TYOqhbZPs
 940piOMoZAKHxQKQNGjinjWQz3m4np1qgT/gs7keYH6eyrd7OThEfyMfV2irD4xcJ
 UYKiHVNz1hOMbdWzUXbT9+seFecK5JL+sjms3Z3udXSp7uG8EjjSoG7OgAo4NhIxj
 hWMk9bQorp5gzWnjtQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq1CC-1wZSs83vWc-00l8vO; Tue, 18
 Aug 2026 07:48:54 +0200
Message-ID: <67dc50c5-19ab-4612-857b-59d6a850f76b@web.de>
Date: Tue, 18 Aug 2026 07:48:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 1/2] drm/rocket: Check allocations before use
To: Triet Hoang <triet.hoang.dev@gmail.com>, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
References: <d593bdeb-e6f8-44d2-a444-e9197a8ed1a3@web.de>
 <20260818013130.1482249-1-triet.hoang@datalogic.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260818013130.1482249-1-triet.hoang@datalogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KP7rrl5ZsiWitVg0Pnq5fRsQI0+k6pnD/OFD/IY1tDzFnkrOR7P
 TtRfMS3qEdtgk91jYe5ptAHU2PjNu4dKTelw9cZ2ekbTmh8T3KF/uJosWTJWkPKUZmur+d1
 YR5YNz/+cqpW27JIU6//DLM24TvLvBend0lZqCOJAj1pw7BRl3awxmSW06pMI6K7lNDLIU3
 SykL1v6yGQcAnYoI+U9Jw==
UI-OutboundReport: notjunk:1;M01:P0:+JrPqNxy5pc=;rMP7XkfAQr3xAtX/85CF9RcEnZM
 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
 mNGl6mg==
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

>> I see opportunities for corresponding collateral evolution.
>> How do you think about to apply the attribute =E2=80=9C__free(kvfree)=
=E2=80=9D also in such
>> a function implementation by another update step?
>=20
> I am not sure I understand your idea.
> Could you explain more? This attribute is a new thing to media
There are programming interfaces supported to some degree
for the application of scope-based resource management.
https://elixir.bootlin.com/linux/v7.2-rc7/source/include/linux/cleanup.h#L=
10

Would you like to take any adjustment possibilities better into account ac=
cordingly?

Regards,
Markus
