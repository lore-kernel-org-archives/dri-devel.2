Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9ADC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 23:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB5E10E0E0;
	Fri, 24 Jul 2026 23:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LMYo0sse";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68EE10E0E0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 23:42:51 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84847482584so738364b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 16:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784936571; x=1785541371; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WIvddm/SoVY0JsjcwTl95nJ9aWsgQES49WF7YDGAcvw=;
 b=LMYo0ssejYn+vvTotCaQgMAcILD/u3KmCJ1f4E4MoetXj9SN2jJz5hPMc96rdlBKO3
 jQHg+a3klkYd6mhBRFcEX/LM/duwPC55cKf9fX7ufLCzOKh5Ja6v3dzh4IjsaVF6A3/J
 5j9d+mnP9ni0P5hDo3ji3gWcYy4vc9wNksMfTt9s2oazh1SUik2fLbfe0rc8TXBB9FMA
 A2Ga9O2CgGesbqvEqLcfLPbBXNN1Odx3Ko8xVtgjTNFzLAapK77Fn7+PDtuGY3vAdDkH
 k3ShY1Q9VeWrWXc2C2ZvFwCQ1fwW/zckT1GDv04KP81iJsvkTNqTVqQwkS+XmZYLEjXI
 U+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784936571; x=1785541371;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WIvddm/SoVY0JsjcwTl95nJ9aWsgQES49WF7YDGAcvw=;
 b=GT4T6aZN83g2JazJi0CD+9NwQhnxalwINGCS1kzoxRipvkiTd0Nx6Chi8a+7+Mr+Ht
 gN3T+e5DhheHQFyy0QeiJt5yhzYS0IEnX2GrsNHd/OiXQWvQvREOrU0HmlpxbX4P87Ze
 Fc63fpmauj3MDfdMZzp7up2NBdHjxykd0FsaK7aB8grUmlQhq2LttWMpq+YSnnfzsn8P
 VYtNyqA4EhYbEdUgHQJdod985LTSv6rQmacMx8kjgaOQ1U+6LliI+f2af3q+/mGAL7dN
 dEyHZVh6COtAzh/dLgsIuTqJedPQCTrxpd8lQ6cDik75L7kyru40Yh31JcFu8WgJSDPg
 MVQw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0770yqInbj+IKqb4G5phsfo//ExN1DgqH/pjCU94GPr5B7g34K3Jye5lNNsJCmLY57zqgPYWtQOs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYnHuq+UQkRSQ69SiQ1qn+tMceLKsXJNQZ2ZkYEQ1w8bmGJrYV
 RVL35V7TLBzi28x2dtjex7gYerRQSd6mXZ1l14ZBpb2aeRYFBsWqbqop
X-Gm-Gg: AR+sD10R8BzoNbXYAhqGErzDyX/X4Cgr1OGbu+TOLjFw9hJRUQSbGxI8aJ8LfjZcgcN
 tX5J6wHdzi3nTMy1dnVNRX1ZBFoNwSvQ2at9qyCQ0/yMLWbfkEHyXQyLe+9eZSvB1k6zSjDXs9E
 fxNQu0R19TvT86+kN8RHVeHPndP2OsefXz1UGNSEKi8oAxxd8yzNbXu8f906BSezCLz3ZG8+bzA
 j3hi3Iw8431vZJ8RWvFostue/EANCyScoj4XCKgEWdWkzRfTPSUKs/iPbsngxWUUom1NcrSQ5/3
 8hdAlnWn1+vNim41BlkGdBDpGC75lAj3WIUix2n+Z5/U3IcuNOZf1mKUDn08ggEV/v9hdoGxcH6
 nZ8xSOpCqnREyxeLH21WaTWnagNqZPyCZSlwwlGk5BLNW6DwaaGBkM9VqUBq1rtN3CjpHaDz8sI
 cZN2JboMzVC5OACaXobPaRjac0/mHLojEENr8+L02nYiY=
X-Received: by 2002:a05:6300:2287:b0:3b3:3506:cf3f with SMTP id
 adf61e73a8af0-3c67236feb3mr2624676637.1.1784936571055; 
 Fri, 24 Jul 2026 16:42:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc4164ddsm3312255eec.9.2026.07.24.16.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 16:42:50 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:42:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-omap@vger.kernel.org, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
 goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Message-ID: <amP4csGgdg51VRZw@google.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-3-egbostina@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718215632.3295049-3-egbostina@gmail.com>
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

On Sat, Jul 18, 2026 at 09:56:31PM +0000, Eduard Bostina wrote:
> Convert the Texas Instruments TPS65217 and TPS65218 Power Button
> bindings to DT schema.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Applied, thank you.

-- 
Dmitry
