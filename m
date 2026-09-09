Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F91C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 20:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551ED10E219;
	Wed,  9 Sep 2026 20:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="myegnbxe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E51110E219
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 20:15:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B995E416BF
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 20:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188BC1F00893;
 Wed,  9 Sep 2026 20:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788984916;
 bh=O/wi1u9pSbKRwNUJ2MezstBNsMqAVCnFe5LWKSVEEP4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=myegnbxe5bqb9CHfCKlWfMPz3SMrph/3cqw0aXQ/8bW7V297NF+iqxvoBZRhNBzNX
 zTcSlFKGAcwfeAPSQcnEccDBlqmfPxLhOI9abznPmLlzv6tgkuxNcSNfhGzou1a8lZ
 knig8MQgkGo3Pa+LpeYRLgog7CfbDwo9Do0KsFJCUkZ2XQK5j/k8iuwnjsr+B8xuxi
 t1tCnqsMFxoGyN2eKBQRTLSYxTtUs698yaAmvYGjSNETnYw9MM4ptNUj0Ay4YPuir1
 xdx4B3ElZklaBtbEZ9Lwz8SST+31cUBRqawdsU6Rw5pGqSJ3b5YKHwwPNEiSlREbRF
 2qirFLKjQm0YA==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailfauth.ams.internal (Postfix) with ESMTP id 998E51980052;
 Wed,  9 Sep 2026 16:15:14 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
 by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 16:15:14 -0400
X-ME-Sender: <xms:UL6hauRnCHCTOcdhzfyQLoNyv4nPcLE0vacYOrVxHQ37AJHeeldz0Q>
 <xme:UL6haunnqZo6ampX9O-A6TVEd3VNfLUOhkjC_KZZlRRWBLXC4yfwLhEF7HGhfsCZp
 WLBTYpvuHARkAJW3Bbj1IoeovdxoCTVj78w9xwc_aG8RszeIw4Zl2Hx>
X-ME-Proxy-Cause: dmFkZTGbpvMjpO2V3Neh9RZY0iihlQM+LxkijBni6OqXlpP05vUUEQtKy398h5AzAnKL1c
 3OKEcJNwmE2/KZmUWOIzMsYkwRNmpQU8iNi3MunEoH4uQFrmf+QWZWgvBjoMoMw+4vGi+D
 kp32vYDcxBTSIRUPmZdwo+pntTH8YZ4hJn3nBKriPxqW2pwZwGkA3sJzj4sAqrQVrWtpYq
 V1TKs6gubR9pk4Oai7tEKLYmQ5g2UZ2NSMYuEJ1TXwwR1WeBgFQQuTQxhQGSI50kF/+c/H
 yM2YqpyCzE6xuNtx+kAOcfH4lmMulcJqeLKs1KTnEGSGii4SH5lCR05A+rAl654QLmyhLa
 MMqO0zpeUXJM895vQfIjEr9ni6KhQ0bKe0wO+xiEAECBY9G4wDYMOhUIhX1ihjQsMwPySS
 S/e0yITgHn47ZC7Qdgp4lxPucM0MHnaq7XQN9dokHBv5bLpHTszyWGGaRGqCURIkrOElKQ
 /EhpCcpwLtIMboD893hk++lxznnG/lTJICup7OVdZihNrabsEOkIa+AqySewJb0L7oov6f
 661md0DNIQMWtZQzgzrmeuTqh8j0+rkCj8em8I+H65uX8B5elltHR8OPk/N4m+1xkUUjvn
 6cm45HOtZQHBnH9CgNQojGe8btkeS5i/VWygargHhBmqg0ugnQFPYR8t7Apw
X-ME-Proxy: <xmx:Ur6harSwYKQ6Nm00ifGNnw2Q4X31qAk-9sh6YAArwW8fTK_WK3PDEQ>
 <xmx:Ur6hapG-XoeGVf-bBs9TBChcYCuh1ZqVLFw6c_SWcfCsc3FQ1vZyTg>
 <xmx:Ur6haicML-hbxdjfSNHxpxQua0ylDo2gJEpxRnioBde0Ed7CNJhrag>
 <xmx:Ur6haoL1K3DlgTE46F8UBCiLdQTO7gkmLfDVZeyB5ID2zguY7CAheQ>
 <xmx:Ur6haprwAxTPDvBfQTjr3xiwMxu5Ov0XCaZJy9WFz1Z1ZH5Ws6auBUtn>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id 4BE3732A007E; Wed,  9 Sep 2026 16:15:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: A5lluAkCP0jB
Date: Wed, 09 Sep 2026 22:14:51 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org, linux-rtc@vger.kernel.org,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, "Rob Herring" <robh@kernel.org>,
 mfd@lists.linux.dev, media-ci@linuxtv.org,
 "Conor Dooley" <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, "Lee Jones" <lee@kernel.org>
Message-Id: <752ff0a3-8569-4f14-b466-11dc96b87e46@app.fastmail.com>
In-Reply-To: <20260909133955.BD5FC1F00A3A@smtp.kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-8-arnd@kernel.org>
 <20260909133955.BD5FC1F00A3A@smtp.kernel.org>
Subject: Re: [PATCH 07/14] mfd: remove unused lp8788 driver
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
> This patch removes the CONFIG_RTC_DRV_LP8788 symbol here, and also deletes
> the drivers/rtc/rtc-lp8788.c source file. Should the corresponding build 
> rule in drivers/rtc/Makefile also be removed?
>
> Currently, drivers/rtc/Makefile still contains this entry:
> obj-$(CONFIG_RTC_DRV_LP8788) += rtc-lp8788.o
>
> Since the Kconfig symbol is no longer defined, it evaluates to an empty
> string, leaving a dead configuration line in the build system.

Fixed now, the line accidentally ended up being removed in the 
wrong patch after a botched rebase.

      Arnd
