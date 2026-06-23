Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05256CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6440010E99C;
	Tue, 23 Jun 2026 07:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=deller@gmx.de header.b="BBCEQzgC";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC7010E982
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782199695; x=1782804495; i=deller@gmx.de;
 bh=FkzNbXihV1642W4QXdTfCML4H1hn6/kKAe41Z7dA0as=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BBCEQzgCMO0OWT10PAZbYVATBdWbyhttxNV9Og4l8JiCTTJnT/pqcxV1NsEEmH3Q
 QO+rTRBmz8Khtp22VV8UQDQmXWHT989pVNnXHF8J5HQBeOkPo1qxL/FN6dYGVL8RS
 e+NSRtsLVKAKJWZEWZ1zwX+GvrzZLkRjWPU73M3uxxak7tje3bg5ZsaYEGunCpC4w
 2IYuc4PTTRLXXLXLhaPrVEoc60SkekBGiW7Y6uCYbxg+6Ri2/4WYrxFueouL0Fn4d
 kMd7lrt/KVjBSdbCFC9k+H4EFxpTBWvGjT5VR1klfT3wJau68OlkviEY7lGCgShJ9
 Q+HHKwW8hDrMrvRg6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQj7-1wNr4U0hVF-006Z1n; Tue, 23
 Jun 2026 09:28:15 +0200
Message-ID: <b7ed4685-4917-45c2-a0fd-735d3936ae9c@gmx.de>
Date: Tue, 23 Jun 2026 09:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fbdev: vga16fb: Drop unused assignment of
 platform_device_id driver data
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Javier Garcia <rampxxxx@gmail.com>,
 Vivek BalachandharTN <vivek.balachandhar@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <02710e01b80c06230f399afa6a7d247b95b3f2de.1781689394.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <02710e01b80c06230f399afa6a7d247b95b3f2de.1781689394.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5+jR7FX8zfRPFy9sL2SnsypuSEiJDxIbtHQtrZhfm5LWgyLz4zl
 Wy/JpLkGP1ylyTPPfGs6yWOU9SSvQkZ3UuderS0lVMstkE9gk80bApZnS7li5NTe5duCxRM
 bE8H4uOH/5tizeawWK4hNe61tAeWk9lwTjxmW6hb+MPt241MyqpZ6qTiYAcxoib3NzS2aPO
 jvdJG56DYmbHwpjYM17rQ==
UI-OutboundReport: notjunk:1;M01:P0:JcXodzwnhfU=;K9oB+ZC6II8I2ATMbMcK0GJU/ld
 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
 LFb91800N9DcwDdw+U=
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

On 6/17/26 11:44, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> The driver explicitly sets the .driver_data member of struct
> platform_device_id to zero without relying on that value. Drop these
> unused assignments.
>=20
> While touching this array unify spacing and usage of commas and use
> named initializers for .name.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@=
baylibre.com>
> ---
>   drivers/video/fbdev/vga16fb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

applied.
Thanks!
Helge
