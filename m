Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ACB606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gr5nohgX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 710F410F64D;
	Tue, 10 Nov 2026 12:25:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5BDB10F64D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:25:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A03141187;
 Tue, 10 Nov 2026 12:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A651F008A2;
 Tue, 10 Nov 2026 12:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794313532;
 bh=o8vOqPjQp+qIgT4SjBM1vuuP9NkLzsqzq4almCwh0ns=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=Gr5nohgXHm1YYyj6tvLEZ2lSM8AwTngl7Y9YhcAEKBH+Qk95txebAZ9NtKzrDhbMu
 /kcVhI4wBuCa61a001FzAROnBPqNtiO/ytzlzOWo7XJ5chQlrrTZ0jAur7hkGa2Dea
 9e8VcncC+5ovHWHZPm9Udas/YhDeQJz+/Hw/DgiFOKQphYC3tCbIwtuUfnQDwnkr0A
 NlkNf0d03csKo9TcHJmIS39u4zkv/CzH2xeQIMrUlC8N+o3OuHRReJJo3cYKVKlsnW
 Ok7Bxat5Tx0PnCcbiQSm1rkYigOOsx53IhuLC4CVONUmhMnelBCuvRRROviPHPq5B4
 hzmGl2iyPjB0A==
Message-ID: <69a3552e-1fca-49e9-a9c0-66963319d2a9@kernel.org>
Date: Tue, 10 Nov 2026 13:25:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 03/14] mfd: remove unused si476x driver
To: Arnd Bergmann <arnd@kernel.org>, Lee Jones <lee@kernel.org>,
 mfd@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek
 <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Sebastian Reichel <sre@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-sound@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-4-arnd@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260909132153.1596191-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 09/09/2026 15:21, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The si476x driver was added in linux-3.9 without devicetree
> support, and has always failed the probe function in the
> absence of a si476x_platform_data definition.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For drivers/media/radio, include/media/drv-intf/si476x.h,
Documentation/admin-guide/media and include/uapi/linux/v4l2-controls.h:

Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

> ---
>  .../admin-guide/media/radio-cardlist.rst      |    1 -
>  Documentation/admin-guide/media/si476x.rst    |  160 --
>  .../admin-guide/media/v4l-drivers.rst         |    1 -
>  drivers/media/radio/Kconfig                   |   17 -
>  drivers/media/radio/Makefile                  |    1 -
>  drivers/media/radio/radio-si476x.c            | 1523 ----------------
>  drivers/mfd/Kconfig                           |   13 -
>  drivers/mfd/Makefile                          |    3 -
>  drivers/mfd/si476x-cmd.c                      | 1543 -----------------
>  drivers/mfd/si476x-i2c.c                      |  861 ---------
>  drivers/mfd/si476x-prop.c                     |  233 ---
>  include/linux/mfd/si476x-core.h               |  532 ------
>  include/linux/mfd/si476x-platform.h           |  256 ---
>  include/linux/mfd/si476x-reports.h            |  154 --
>  include/media/drv-intf/si476x.h               |   28 -
>  include/uapi/linux/v4l2-controls.h            |    4 +-
>  sound/soc/codecs/Kconfig                      |    5 -
>  sound/soc/codecs/Makefile                     |    2 -
>  sound/soc/codecs/si476x.c                     |  263 ---
>  sound/soc/fsl/fsl-asoc-card.c                 |    8 -
>  20 files changed, 2 insertions(+), 5606 deletions(-)
>  delete mode 100644 Documentation/admin-guide/media/si476x.rst
>  delete mode 100644 drivers/media/radio/radio-si476x.c
>  delete mode 100644 drivers/mfd/si476x-cmd.c
>  delete mode 100644 drivers/mfd/si476x-i2c.c
>  delete mode 100644 drivers/mfd/si476x-prop.c
>  delete mode 100644 include/linux/mfd/si476x-core.h
>  delete mode 100644 include/linux/mfd/si476x-platform.h
>  delete mode 100644 include/linux/mfd/si476x-reports.h
>  delete mode 100644 include/media/drv-intf/si476x.h
>  delete mode 100644 sound/soc/codecs/si476x.c
> 
