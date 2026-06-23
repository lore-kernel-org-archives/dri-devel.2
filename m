Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E597CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5682D10EA2C;
	Tue, 23 Jun 2026 09:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="eNiiKZNb";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC03910EA2B
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 09:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1782205525; x=1782810325; i=markus.elfring@web.de;
 bh=k6gMzOPqXTS+G90vyYHscI8fx+phyEQvJwJPse6tYYg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=eNiiKZNbcDT1WqaGZBit2aAMREz3PlIyUG/VxH8M6vLYLBJ1No4DUsW/MSqgE60M
 ZNBe4RX9q1SzNZcXPzBYZ9o6eeF2LAx9coQCiSASFXOZPgQ4uDv6HaTocoGOYdXY1
 xOv61bONsrBSxju0N11fTMXkaSoiKO/RFTDxdWSnvCzYDOPdWDu69OZdcWPJuWjB3
 kiohRp5duKX5IcBM+A0XdTbHlD3Tv67v3t6d9HOV7e9NgkiuFvGdBmPR2lyadp1WR
 s2BNgTbzCk63BNqOevHrQk+DXBuETbPG1o8OAB7lQiKMVE6KTkZGG1DDCuFh3AkXI
 vIkEwZSIXyl56V5I1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCE0-1x94xx0JgG-00mBG1; Tue, 23
 Jun 2026 11:05:25 +0200
Message-ID: <16a86f3d-caf0-46d0-97a4-c9585bdaa06c@web.de>
Date: Tue, 23 Jun 2026 11:05:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Amit Barzilai <amit.barzilai22@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 Andy Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller
 <deller@gmx.de>, Javier Martinez Canillas <javierm@redhat.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Azuddin
 <azuddinadam@gmail.com>, Chintan Patel <chintanlike@gmail.com>
References: <20260622152506.78627-4-amit.barzilai22@gmail.com>
Subject: Re: [PATCH v2 3/4] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260622152506.78627-4-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O5rVX9YN2GyeY2Sk83RD+qXyH06OJTyAXKtdn8cNlqe3WepRpFA
 4HvlpsW3A65TGmW7quxv4Up08ieumgF1GXncjmyHj6e2JzC08ugCxHHjiAE/I1ifbyMWhb1
 4mUrMY0138Udz3zBgzrDPHESjBKl75MMlDqDdvaIVtYBWyJ3oCuNZCTE2h22CCjNvEo3wrS
 TlyCtgho8h7M0t77f1Wuw==
UI-OutboundReport: notjunk:1;M01:P0:IB047I2Ja28=;eUb2xQLtkNtGWO/9ucz3J+tdfvC
 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
 ngi7mQ==
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

=E2=80=A6
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -146,6 +146,33 @@
>  #define SSD133X_COLOR_DEPTH_256			0x0
>  #define SSD133X_COLOR_DEPTH_65K			0x1
> =20
> +/* ssd135x commands */
> +#define SSD135X_SET_COL_RANGE			0x15
> +#define SSD135X_WRITE_RAM			0x5c
> +#define SSD135X_SET_ROW_RANGE			0x75
=E2=80=A6

How do you think about to use an enumeration for such data?
https://en.wikipedia.org/wiki/Enumerated_type#C_and_syntactically_similar_=
languages

Regards,
Markus
