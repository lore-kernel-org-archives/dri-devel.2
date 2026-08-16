Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ACFC5DF66
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 20:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9B410E0C9;
	Sun, 16 Aug 2026 20:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="tk8thMuP";
	dkim-atps=neutral
X-Greylist: delayed 324 seconds by postgrey-1.36 at gabe;
 Sun, 16 Aug 2026 20:41:29 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C03B10E0C9
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 20:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1786912887; x=1787517687; i=wahrenst@gmx.net;
 bh=4Z+kPSmsB7rQaR0LkAkEYzUoOZvOc60lKGr4z1NusVs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=tk8thMuP4FZZxSPRcPqmQH/Tx6ahU+x20qpKaOF9UudGNdlot6Rc9QatiJ0oZGCw
 NwGyK14egzhhOlGrP3WbY6hSC8Bs4HTxEqypdGGxb7dYDQHtiOPO20NB0D/SYfeKH
 b189pmmZVn7C6EN4FHJSNQNVk5RzcQASTJsxGMgDKHGxLqNXFjCXWfEg4pYJtrg7o
 9+8MBxk+5OVEALgWMb3OXs2Wsbo+T47NUqsJVb9N+B2iQsPHeJZdPhQeALmpCDDbT
 86MzBNRm9mCRrzTM52Z5No7KDoNJHQWnwQmVLLdgPUvan0Gjg+Z3y3ijSqZfVLrMY
 gA2NWxd3cb9FX7bivA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXhK-1xHCU326YE-00UbXn; Sun, 16
 Aug 2026 22:35:57 +0200
Message-ID: <87f2ee85-e53b-4154-ad5e-60a00b2bdf39@gmx.net>
Date: Sun, 16 Aug 2026 22:35:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: dts: bcm2835: Add the V3D reset line
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
References: <20260816-vc4-reset-control-v1-0-896444373716@igalia.com>
 <20260816-vc4-reset-control-v1-4-896444373716@igalia.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260816-vc4-reset-control-v1-4-896444373716@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qC/mBbUnVev17g1kNFkKIAZrHsgTwMNst/nFJnL0zbKjCS/VawN
 J1P7OlPfwCSYfQNJ1TBZkc91aq8wD99QF4V4dh2XC7OOSlL6AxcJVRDdACct0R8PzbedENu
 NaSt+fa+NMoxOG5fC1FTMo2OnX6jXcORhtNb6wEqqApoQs1b8xFa2RbiajkLjx0HsoJ50Hh
 OUGr1JrcNRvGPcHLoH1hA==
UI-OutboundReport: notjunk:1;M01:P0:w8a6doanvHk=;Ec7l/oN+4+uGGWRqH0A+zo6BBGt
 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
 H2Oq0fsmCw0puG38BhVHbhsnrSD0CmlP4jvRA=
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

Am 16.08.26 um 16:05 schrieb Ma=C3=ADra Canal:
> The PM block exposes a reset line for the V3D block, which the vc4 drive=
r
> uses to reset the GPU when recovering from a hang instead of forcing its
> power domain down. Wire it up in the shared V3D node, covering BCM2835,
> BCM2836 and BCM2837.
>
> BCM2711 already describes the same reset line for its V3D node.
>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>   arch/arm/boot/dts/broadcom/bcm2835-common.dtsi | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi b/arch/arm/b=
oot/dts/broadcom/bcm2835-common.dtsi
> index 1e76b290510d..39eea8ce1058 100644
> --- a/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
> +++ b/arch/arm/boot/dts/broadcom/bcm2835-common.dtsi
> @@ -139,6 +139,7 @@ v3d: v3d@7ec00000 {
>   			compatible =3D "brcm,bcm2835-v3d";
>   			reg =3D <0x7ec00000 0x1000>;
>   			interrupts =3D <1 10>;
> +			resets =3D <&pm BCM2835_RESET_V3D>;
>   		};
>  =20
>   	};
>

