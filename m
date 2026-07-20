Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABE9C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5B110E6B2;
	Mon, 20 Jul 2026 06:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nde6GuEr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B95B210E6B2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:49:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5D79601D9;
 Mon, 20 Jul 2026 06:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7EF1F000E9;
 Mon, 20 Jul 2026 06:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784530149;
 bh=Ry9+H351PRVIvu5vCfIer432Q6M8xqRP0Sn/miUHYkE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nde6GuEr7OlZiPypguZ1cJnwb3Qwsv0SJG6vGPlgn/HdybXuagqtMMNzQPpy03iYj
 pOYLpshQ9s8ytGcVd3hVXJgvar756OtCIteylABt4yOEwBw+z25FxD7f2tGndKR1KA
 84SHixNIGqUbo6cmf1+3Zzrl8bdKYXV5CKMbk9hX7fk6TZgjigadigeyKq/qhQmf2T
 +BBw0z7rpupjz5WKoTulj5uPlBpGZPWzJbsQy2IUMgW46P21XGvW1NM00Fey8yb4Oe
 jiN/46wfxPy2DWT4a/T1ZdMjMby6lTkefLa4+sGeNanxwXIAHDhKmRzcIBr8quHM+V
 y0H/88c/+k2tQ==
Date: Mon, 20 Jul 2026 08:49:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, dri-devel@lists.freedesktop.org, 
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-omap@vger.kernel.org, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
 goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 1/3] ARM: dts: ti: am335x-guardian: Drop unused
 isink-en property
Message-ID: <20260720-debonair-calculating-muskox-830657@quoll>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-2-egbostina@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718215632.3295049-2-egbostina@gmail.com>
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

On Sat, Jul 18, 2026 at 09:56:30PM +0000, Eduard Bostina wrote:
> The 'isink-en' property is not read by any driver, so remove it from the

"...is not documented and not read by any driver..."

> TPS65217 backlight node.

With this change:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

