Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A7EC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2716890FE;
	Fri,  7 Aug 2026 06:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="iea25uz1";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DB5890FE
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 06:53:47 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso22602375e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 23:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786085625; x=1786690425;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nUIF+ZoBfnPhDtlVbHIbfV3H6x1dAyvkNT/RRT7NjLI=;
 b=iea25uz18bAfrHXHRY+y+pV+au4qU6inc7TQIUMZ4A8r6PPygVLU05m1W9nBGAbg+S
 2nFeDllbG9myy6+GYZbV8L7Xj0TDNI0BXgMzOdRiLGS+QIA52UDdiwcJfiN/DW9hSeeu
 h2/0b2LWYcQRO2Xjrbr+XoxM/LtZP2gz8FYUwsTusmOExOP2YpX1Bb0Z1JFShW5ltQ2d
 sOzw1zNPNViXh+vUIihpbl7sOXHzsZ18eaCoaEFglwq3RIDPzyUWhOX5eYqDHk4MYpVe
 QIAMhckNH1Iy8vBAUWCCNrWgcWHfI5tvCXASapfal8ylDmlgLYIHojoShb4YlaqJJB2j
 bUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786085625; x=1786690425;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nUIF+ZoBfnPhDtlVbHIbfV3H6x1dAyvkNT/RRT7NjLI=;
 b=qZLYPhHsJw7wqXxnXL/xUtwufyfukyvh5k6bU3Ehjk2DtSnLNL2KRO66gy+NlJzMJJ
 fdDkrL4u8T0dG9iFSRjsuCspCkFdeB6eaDN+PNfGk5G24FH1Uly7xBurEQQp4GmuaOvQ
 4XUTVyZr1wQ1IAsUYw6t3BfMDTYxMitx+n07CeQ/9GusGUulVDV8mNvBjrfrJWCQGlAE
 M31WvLlmZwuHzhdLHLgoeL2AJaT90yvygb6ZtYhd0nel82f+Bgufu43QgCf0sA/ZM2kA
 4AM/+laBaA3dQH2C1CnvqOa0P/Zzn1w4r+dQYsHnouuuxx/Q9llhK1WLJvhsOTkKWBro
 2+YA==
X-Forwarded-Encrypted: i=1;
 AHgh+RplIGoT13NJM9GQxEDJAb+ef8y7L5y++ihNuhjpNo8qWlHMKuBK3nno7/GZmEmUG2Rhe8E3C7z9NYo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxuyvd6aXhZ/RCAjPFsEsJd7W2O5/a1Ei4T6rlDb6Jvr1aw0oOY
 vqK7IRCzbyGtqkGhu4AstR0Af7FVB+q9JwEsf7J+NnJ4CvieBbTjnzVVte31Lhgq91w=
X-Gm-Gg: AR+sD132bPcboRggLentcs+0ieMQzvl94ROq00Ex4KP0Ihk7qsH8rdgXYteZUSD1poK
 7uATRvBml/YfGKhw/uRlb4EEEh4kSC0uxg46IcXIYj85lJPDDPNv8fvTctyZ85eoS5vNNO22bmS
 JPuxqH414ugDO1tXnm7YSbUexDJ7XKfnL1D89HpDy6mdwT43okO95PvKWp0DbrL1CUr1vj3RkwE
 4fNPHiRI4AeqFABQVHD+P+gWZKzlONK/JmBgLId0gVcR2PNb/w6/+USv4xU7y4gVXs5yq5sF/qb
 +aYHWa+TaskPWQhd9fWCtWTMrrglXfmkR1mTBYh6xJ03PMvLXYoUUf/tIt60fE40rPf6DIDkR1s
 cqbv5ITVQvC4vSUab0ScKAmpZ0K4tdbLo2ybue37OG859NwxDjUVCb7qE1wdAK0m8lIoZMIOnv1
 PrJqOxRlopdv57N6PmPJnFUO936lL7oHxKGiMcSt/wTkGLMX0SVoA7VM4RiJUf01deSMkdrK3xh
 bBTuONz0MsR+B2ivHRKs1Ml4xKTksWLrhEDNV4/KgzUjky/6eyH
X-Received: by 2002:a05:600c:4fcb:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-4995e084875mr16392445e9.7.1786085625549; 
 Thu, 06 Aug 2026 23:53:45 -0700 (PDT)
Received: from localhost
 (p200300f65f017104bf0aa590e17c3201.dip0.t-ipconnect.de.
 [2003:f6:5f01:7104:bf0a:a590:e17c:3201])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4995422016fsm98840415e9.8.2026.08.06.23.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 23:53:44 -0700 (PDT)
Date: Fri, 7 Aug 2026 08:53:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Cody Kang <codykang.hk@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 05/17] phy: spacemit: add Innosilicon DP TX PHY driver
Message-ID: <anWAmitXSFRUw1W2@monoceros>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
 <20260724-k3-display-v1-5-f22a10a52867@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pjrvltbz7ftd6xiv"
Content-Disposition: inline
In-Reply-To: <20260724-k3-display-v1-5-f22a10a52867@gmail.com>
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


--pjrvltbz7ftd6xiv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 05/17] phy: spacemit: add Innosilicon DP TX PHY driver
MIME-Version: 1.0

Hello,

On Fri, Jul 24, 2026 at 11:16:37PM -0400, Cody Kang wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/platform_device.h>

Please drop the include for <linux/mod_devicetable.h>,
<linux/platform_device.h> already provides of_device_id.

Thanks
Uwe

--pjrvltbz7ftd6xiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp1gPUACgkQj4D7WH0S
/k5t1Af+IUdmJ1rwWz3XTKVvTnkiumXy+BBJlthTfpRB3pFeiGILfF6fTXLHen+q
HI5KuCh4tnAo/jb3zLCDqO0RRmh14m5WlEgbMnFB9NGgBsbmj77K/WjLo2asTvFN
zTn9nrSjAtcmoJs0h4hIB3zaaueCYiWTGq8S2lIKH5D3xMUy61+006h2s5Dtrzlc
fHv743vCRkGoaGQWxHvpsgkx8Sp7WXEwZQyMaRvSggG2FiskKlV5pyM35siiJuAA
re4sCShFRtGFOhGjKK+mM7y8skzgBNqDocWT4sYp0QYeW6w8nwNHyKh3KUN//afs
1fDWRTlDMEJQqbI9K3OToPHbVguUIA==
=glOr
-----END PGP SIGNATURE-----

--pjrvltbz7ftd6xiv--
