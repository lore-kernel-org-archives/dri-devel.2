Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12110CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F37C10E7DE;
	Mon, 19 Oct 2026 07:02:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8A010E7DE
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:02:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AB3F41299;
 Mon, 19 Oct 2026 07:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FD41F000C4;
 Mon, 19 Oct 2026 07:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792393337;
 bh=AvFFWNmZRE1kNnhqOhbeBX1SA9rS1msS3gKtfIW3E/4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Nci/PhmVOv10UWF2MX6pCNgm2WmI89Ztm+P40jTp3e5W7jg83i/8RbhoWiyLWab6e
 NMxpm7/SrdqZma/bKaosd5KZWJ65xq98XIFswAyaaaQVwKHER70wCv8ZFu+WNiiAPw
 VJjYmkVQ2yOVQz0oWHMv2RoSY9em3SMkJUPk6ETDUJIXxqDCrlhhOLQNids98wNo0X
 JyiqLAz69PxEu8MF+xYtLcdevIpXrS5gvCNyAlMYtVteTiu5rgSTMygUqvQ4kfUB/0
 EHEOIfCbN4PO2M0Ogsq3Hrt5QmxEI+fPS5f6Lg8NCgkyJsxQv0Hkmq3iFhiiJpbifG
 pK4RQ/V+BceuA==
Date: Mon, 19 Oct 2026 09:02:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luka Panio <lukapanio@gmail.com>
Cc: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, 
 pavel@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 deller@gmx.de, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: Add Awinic AW99703
 backlight
Message-ID: <20261019-yak-of-subtle-protection-8ed0da@quoll>
References: <20261016162912.64581-1-lukapanio@gmail.com>
 <20261016162912.64581-2-lukapanio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261016162912.64581-2-lukapanio@gmail.com>
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

On Fri, Oct 16, 2026 at 06:29:11PM +0200, Luka Panio wrote:
> +  awinic,iled-max-microamp:
> +    description:
> +      Full-scale current of each LED string, reached at the maximum
> +      brightness code (and 100% PWM duty cycle if PWM dimming is used).
> +    minimum: 4800
> +    maximum: 29600
> +    multipleOf: 800
> +    default: 20000
> +
> +  awinic,ramp-on-time-us:
> +    description: Current sink ramp-up time when leaving standby.
> +    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
> +           256000, 512000, 1024000, 2048000, 4096000, 8192000, 16384000]
> +    default: 8000
> +
> +  awinic,ramp-off-time-us:
> +    description: Current sink ramp-down time when entering standby.
> +    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
> +           256000, 512000, 1024000, 2048000, 4096000, 8192000, 16384000]
> +    default: 8000
> +
> +  awinic,pwm-trans-time-ms:
> +    description:
> +      Transition time between brightness levels set by the PWM input,
> +      for a change over the full duty cycle range.
> +    enum: [2, 4, 8, 16, 32, 64, 128, 256]
> +    default: 2

Feels like you are re-implementing triggers. Several properties actually
feel duplicating standard LED ones.

> +
> +  awinic,i2c-trans-time-ms:
> +    description:
> +      Fixed transition time between brightness levels set over I2C,
> +      independent of the size of the change. When absent the brightness
> +      ramps with a fixed slope of 1 us per brightness code instead.
> +    enum: [128, 192, 256, 320, 384, 448, 512, 576, 640, 768, 1024, 1280,
> +           1536, 2560, 4096]

Best regards,
Krzysztof

