Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258AFC531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B90D10E086;
	Sat, 25 Jul 2026 01:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GMb5UJWl";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B6F10E086
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 01:22:45 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so1052591a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784942564; x=1785547364; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=evBctyG9uOAPggGOtV7ej6S8jtXBTYTc0DEyRDvPdb8=;
 b=GMb5UJWlApWs3diskGNFB6X7TVnKU6mmtmFbVWAIkRsKLpS5AnRLK9AGrjnNlS7SWa
 X+EQQYbHZfbUJ49T8D/A21QAQceJhnJTjIv7h2BVU37ez7uhZfICeEogsDo0aiyRvBEh
 E/k1VJo5AuFBfi2XbpCT1EtANsi+fW2OjEnq/SPGucaasnjDeYzRF5TNv9fx/Vkk18Nr
 ZUWavST6UdLNodHBsUsS/wxsInChIJjMsx50LXC+0t8kozukO8kKY+PMUOClpyOokEtk
 rKdiGiOj9DPZubJyGJvFgv7SycrNYjyUsg9eqQnVzYn3zVutoReI6c1h6LYRR/+nJxtT
 FkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784942564; x=1785547364;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=evBctyG9uOAPggGOtV7ej6S8jtXBTYTc0DEyRDvPdb8=;
 b=LaD7zCZ9o4+ffHnM9qdaSTXl9+p6DROati4dlq3h5NN53rtOYt/BRAQ/AOaLwSYKMX
 alHu9EvuusJLCmdRybbsgvLnwkjH0hAA2+e5FCTsAr5ST+offmaXcGrRHz17wFWafNSF
 6k1vrr8TvxFa06o02FabbRex17wx40vMUyPwXMjBf4i/Z9+AV2u8D0gUTkyhlYRPdRAd
 cb6U8ei1qdidLixCshvvB5Gg88/UA/+EYe0X4t4rkVrjNxHHpRBbkIjDpxydNubn33hc
 1wHJj31V0cWhdg6gC0a1S15/0WgCR2SIGxyvYsWmo7tuvGO6CzUJcTEjRxlz7KrqZ/Be
 rHXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoMcqcysYBWKHnbaUXNEU1O46E4yWXt0OU/uyNB8MaA1396LdzUhru4vhc0ZoVkBozj9Pb7RZq07DA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2ZXezkDr1h2OpJsZdEfv7/SHV028sOL0tq/idq4qQHArpHCFV
 h/FqlYxgNRAE7TMzv09DOXD4YUuPZLviizfHgn8aILg+h13wJeXrMJz7
X-Gm-Gg: AR+sD10c18KGuM7ahZm8VvLal3ACFOoywGHl0UwDLAR5VTwRVNRQ+8TzdFMNl+I9UPo
 4CSGpE6dD2PCMIZfz2zW7MX4iIfOqWgr5ge4htQhaspyPsCb01UdO4T2wnA1aweh5sDPBOwu10f
 Vh7JswOKqPHvMtqQdYf+ybMbrQGfmac1ZqxIbzrvzZztYvMW5FHVXjXpq+NYLea7Ens460drDZC
 VRy/8VbcgwY8DfOrh5r+eOoBDMnQ+LsOiZJiF6CrCY/9N+1kWZj0gZtdj9Qp0Z/3l1JwZyDFlRR
 vPl16iL3gMhZqf+QnGMeA2h4VFWG43emu74BJPBPxGs4ZDHUi9I+8d8aLD1JlxtX4JqIRO7eQCw
 7SVSAoS2XzVL2iNmFOsQk5CAxVc6qpBY5vS2gPEN4PRPjka2y0jEE/qH2NBZYrcdcLMBrGVQlVk
 jQJaqwyruLvC3Qa5eJuD5BJT9ojxdlXOU5o1MSNDjQeB4=
X-Received: by 2002:a17:90b:254c:b0:387:e0db:3d8d with SMTP id
 98e67ed59e1d1-38f298859c2mr719734a91.40.1784942564547; 
 Fri, 24 Jul 2026 18:22:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc5cb670sm5037501eec.31.2026.07.24.18.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 18:22:43 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:22:40 -0700
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
Message-ID: <amQPyzm6P4BUUGHk@google.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-3-egbostina@gmail.com>
 <amP4csGgdg51VRZw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amP4csGgdg51VRZw@google.com>
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

On Fri, Jul 24, 2026 at 04:42:46PM -0700, Dmitry Torokhov wrote:
> On Sat, Jul 18, 2026 at 09:56:31PM +0000, Eduard Bostina wrote:
> > Convert the Texas Instruments TPS65217 and TPS65218 Power Button
> > bindings to DT schema.
> > 
> > Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> 
> Applied, thank you.

I actually picked up v4 of the patch.

-- 
Dmitry
