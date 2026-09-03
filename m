Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A07C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54ACF10E123;
	Thu,  3 Sep 2026 14:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="BuzK7HIi";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52AB910E123
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1788446233; x=1789051033; i=wahrenst@gmx.net;
 bh=pZr1yIP0mVzswGAiMBblm/mWfClTTsBn9BYCULS++hI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BuzK7HIiQNUrCI8oRv7xDdrvIjyDS3CqgGfh+TVkq2Ku5imiP3h3DYx+1vmyhP9c
 DBml5h4aWfd8bOnqDEBGIz9QFxdWQlsCRwHbIWjLYiEYZs8fR83HRo4tyNFm1iBbR
 KVkyYe0oHRj7HFOk4ABRfx6yre42DfZryAy/enVE7BE5SLWCnzRSMY2AOhQvX2omM
 1sU6Qr4akaYVhs15xoedx7WPpQgy8aCXN7JHtH+H0OKQTRv6SwiMCZrV4fmfGVbL7
 bR0SJFIKnoyIQPby/XiMQxPNnPlR2GtTSinve1zfI+BxLXL3SPzKey7QmTjFN8IHM
 OB8T+A7Ci77iza2slQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEUzA-1x4weR08ny-00HMlQ; Thu, 03
 Sep 2026 16:37:13 +0200
Message-ID: <57b9bc9d-12dc-4eab-a601-ccd9e68ce898@gmx.net>
Date: Thu, 3 Sep 2026 16:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/vc4: Reset the V3D block through the reset
 controller
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
 <a096712c-8bc6-4cb5-94ca-6a82525f1bad@igalia.com>
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
In-Reply-To: <a096712c-8bc6-4cb5-94ca-6a82525f1bad@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4jRAkO+nqrQ4dyRq+5QCYWLOzl5U6KKWfiF4VlOhMIwqjSVGRJA
 Y9BxLH3EsDak303lc7XYiNM31Ga0hObDawmPoHu9Auy8lUdguhBG9UXeUCuCYoLILgWoNav
 5zlS2seP065yq+m93Vkxj+x4sss1/UiZRG3daBGx3Bx42LdG7RWUmy+ytZV2xZQmmL24qhz
 04MiHThJAoIinL25ZZUiQ==
UI-OutboundReport: notjunk:1;M01:P0:aiDCEFyY2Ho=;4FIsTtnLwQfxFd4bJk/aOXjk/CK
 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
 M=
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

Hi Ma=C3=ADra,

Am 03.09.26 um 15:39 schrieb Ma=C3=ADra Canal:
> Hi,
>
> Florian, Stefan and other Broadcom engineers, any thoughts about this
> series?
I already sent the Reviewed-by for those parts, which doesn't require=20
background knowledge.

Do you have specific questions?

Best regards
