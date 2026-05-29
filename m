Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF20ACD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E73711200F;
	Fri, 29 May 2026 14:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="nuqi1KQ2";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDCA311200F
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:37:02 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5a887ebb416so17502671e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780065421; x=1780670221;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RdKPo/J7jz8+PTZxfMlAGNH6ifidcVIKtGtDAneEbNI=;
 b=nuqi1KQ2rTUvqQo9LRKYKrPb9a5ElyklewqzlE4DrY4fqB5t7i8lMvg76htDNERDLh
 0DKfL6tGi/aSDJ73xgiLpyzXfuBF0I5yG6N6qAHR/G1if66+GuubSIlJR1AKqoUqv9BU
 ZnKOP+AShbQqAhVnQiIcMzFwqqPoDnT6e2QNFFLmw+YCIub9FRm9EUFymKFEm5iQHQ6G
 LZ4twY0yjDV7JDhd88JEuY65dIUZXwQ/yXuCUxhe3e5Gog33iyV0s8qRjPNzZSBqpcl8
 qPrhkD0guo6+4M0/PSh9wz58l0nuQmQry/k32mGJO21+TF33kIhSK9tOjyGZMVkYiD8m
 /Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780065421; x=1780670221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RdKPo/J7jz8+PTZxfMlAGNH6ifidcVIKtGtDAneEbNI=;
 b=IOiVxG0rUkdJ7q3iOrXcqvJcoidjYHtKR+aSjBiPsbOG0BaIWvghi3N8wS571Tsvlz
 p6bLJsZwR7E3Gs4aXoqBPEi/8NcyCe3aGVf2ERtA8qpaTagsr2QCRhL1EIhtaGCUzSo1
 UNQP+tqin2clSrpXu2Ahpk3XXF2pCj6ayj0DKAnReWHlSBSljMlJZSixH1M0N0nBkwVZ
 MCWxNNMBcKOILJc6g4tKbtvtOelLWH0vGV0txrA3/2Rhip6iy+rOL8AAEzR8dAUbsYfp
 a2Klxfq2Qeoo8pCvBT7/vkHKv0ynHqx5Hc8PZOrszt9OCGpRt43dCRdxqYmTzIegHUjU
 xxUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QBT0OBvAWUlwIMTGlPNJTBA71C6mS97M+VKUt9YFhHOXlF25hDwki4hzmrB/IEcajZHSFIaigQv0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuXy33xf+Oi3QAg4NwrXS4f0l9nti4Y7p/IhtI9ORifBAk4Oo9
 iHyNpFs8Nd2TzW/0tEVI45rz2MLuzc3O8ydqfDkOlxsTtQpTbcWsfffDPB8c11A/0nQ=
X-Gm-Gg: Acq92OHK25O4Kh0R/jdm5t4/MozDOFbkwsvy6v+EHOxjc5S18UqSK+MlgcS+wy6RmUq
 XYbStjkSORd0sMBu8HMzRz5lH/iq77aeSiuz0v+LhsFL2DJCHcKyf0CWFZWngBRv6TMIVyGwbO7
 hCU+geMToLXX1PYncRXff0lB9+2YEppGcTVoFtBjeeSxc0kmHpn3gE+ueAYzRudXBIq+hM/Bexr
 Rtl86hXSWLH5D+8uuVd1pRkmMD0iWBLN5BYk0rsrKHxJNzbBLVRsXJ+3Xr0gpnWBcpI+6ZWyuKZ
 1MIgUIss+pbJuCJsh0gBEKyDGtZY90fMjvK8eO70xSvn+W9N4IwuTprcVizLeu9ur7q3V2+6RCl
 uTKFzmYcEinQyAG3/0QWfEgaKOrPv2aPFm3wyzZX9raX5Z+Bo+t2GC3GCOnOia4Jrf5ASDvOY7S
 RTq8bH9XpcPSTc9Xr+IzarUq8LaqrU8uHaE4av0j/6O8EpaY1jTVOUMGKb4YbD9h2ScN1uicVGZ
 TR2mytR0Y3ZGizM1UZyqoGcheFW9JBDk+4AlCbN3l2IuGcys1MpRPTr0mO+rHnTP4O/zhg8/t0W
 Af9m+WbGCl2qcBomBFM=
X-Received: by 2002:a05:6512:ac8:b0:5aa:5bae:e9eb with SMTP id
 2adb3069b0e04-5aa607c49c7mr35920e87.9.1780065421236; 
 Fri, 29 May 2026 07:37:01 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3556f51sm3888107f8f.25.2026.05.29.07.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 07:37:00 -0700 (PDT)
Date: Fri, 29 May 2026 15:36:58 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Daniel Thompson <danielt@kernel.org>, Lee Jones <lee@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Message-ID: <ahmkirIuOYhd1rkM@aspen.lan>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
 <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-1-ec8194bbc885@linaro.org>
 <ahllT_HVTAJ5MbkS@aspen.lan>
 <e3c99fe3-9279-4dfa-af69-d9366ab06837@linaro.org>
 <ahlr5PnX5O0tEd6G@aspen.lan>
 <4001cf6a-b7de-4933-96bc-c9b4ccb53e4d@linaro.org>
 <ahmfZ0tdxbVfD_y4@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahmfZ0tdxbVfD_y4@aspen.lan>
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

On Fri, May 29, 2026 at 03:15:03PM +0100, Daniel Thompson wrote:
> On Fri, May 29, 2026 at 02:50:43PM +0200, Neil Armstrong wrote:
> > On 5/29/26 12:35, Daniel Thompson wrote:
> > > On Fri, May 29, 2026 at 12:16:07PM +0200, Neil Armstrong wrote:
> > So it's not really 2 regulators, and having regulators means the enable
> > signal can be shared and would have regulator characteristics which it hasn't.
>
> Agreed. If the EN pin is merely use as an enable and voltage reference
> then it are not two regulators.
>
> However, it is also *not* vddio-supply and enable-gpios. We don't need
> the board design to check this. The pinout diagram in the datasheet
> should be sufficient!
>
> If you have to activate vddio-supply for the backlight to work on the
> board are you sure you don't just have a misnamed vdd-supply that needs
> to be taken care of? That would make much more sense given the datasheet.

After posting this I figured there is another possibility.

If the host GPIO pin is not capable of delivering the 1mA requires by
the chip then the board designer would have to add a buffer and that
buffer would need a power supply... and that power supply could, in
pinciple, be switchable.

However if that were the case then I don't think the power supply for
the buffer would belong in the bindings for the sy7758 so I'm afraid
whichever way I turn it I can't make vddio-supply make sense.


Daniel.
