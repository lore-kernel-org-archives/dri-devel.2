Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF0EC88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C170A10E867;
	Fri, 18 Sep 2026 08:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hdcpnpbx";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F27E10E867
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:24:07 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c264788fd58so66690866b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 01:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789719846; x=1790324646; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0ORtPf5rfrOcpgyi/FO05MAHQySi4ZeH+yKwjJ5NuVg=;
 b=Hdcpnpbx+yuv/lBh7zQEGgKbMyoNGKRs6N7I8VaJI4j1ndzkqwj1KvXwIZ0Os/lfr6
 eDKg+a1fjvBc5BZ/dWcaHVAIBYI8YBEFNIRxV17U+7DNXXaBJjdnnGHIBZgEJhGFaRYc
 8JU3avE/roZszLiRODiQHyrDB1uIVWeYQQInwUEnIEepQimBuXqMPTSN7HqkO4Z6MWYM
 bbGFOdS68uiIUUw0KqWFRLgUsvmJNeU1BI581hUIiyUIv6K/YhuCAeL5UhW4JUICuHua
 WE1AbuDot9xuqkaO6Tdgm4mtxSl7ZQnFGfmHkCtGojgWZhN2j5d+fwPCkzpZRU8dc38I
 KH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789719846; x=1790324646;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0ORtPf5rfrOcpgyi/FO05MAHQySi4ZeH+yKwjJ5NuVg=;
 b=iw6VSWUJSwHwRlWgfVFpc98Mp6CCXUBarguJ+OAiAKfd79b4iSy4xV7zrDnF+KTyvB
 wef8BRTOxCBBkh0TdIIqI58qk+doPqVlead3OE/Vp1hiySQUZQID45Qt943oXVt8UOZW
 em04vfp5FvXpbsBGPG6no3mjauT8I10X+ws4HqJcDiJ7gJ83WbhRwrELoNlwwep4WhsY
 aUADmS44k2EtmwmgfFJUu/KpHZ8Vt4+6+FxT8ysG7j7OEkKWQfFqOmm/8NF7XtpIlR1D
 9jlukNeVvFHrZamXyYbY02E4GM1/oIZurDUEiEWjIsSc8qKnu3Vi2K7DqyFzUxXJEDYT
 cDXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0ti6iNVmPJRn2Uv8Ag8Q+tqGZ0VDQuPE6ti5zdcRgrd5nxcYqHbR+PofPN+l04V+dZjt5cVdIwHU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nUDpegiF7geZt3e3qhHo/a7e6WPLMDTB7cWn9OE0+Qh5aMB9tE
 gDhdaHyG5Am358Je50bwb/3/vzBcrqPruQE+ME4oaur2xqhRFcDZpix8tpOoOf2nJG0=
X-Gm-Gg: AYBFou2SJX+DyAO5PXG6IzLfWaFcdecyV8hfRKF9DjKogQ9FBH/wkcnoGrx6e7d/OI/
 ah6iK7C7/PZrlaTzJW96UJtx7EDIiWFFUzPp0UusWcIithObt6vEvPs3NyBCkeBf7JFtJfVsrP5
 EWxIGNsYv3uYHQUpfdDTvmAHOjXO3B9gO2yg4TuXIYt42MXz/pK8lldYQC+iDGzhw3vs6vflZ4e
 yfMmDNi2KFib5W9+dGdEkkIom3mxBMb9N8gHuvbKzFR73EyZrD2wLxzYv+pO07XVJJZPQzrs81g
 rkwCPL+h1E7m7mrJKGSzbvpLaAZVPTGaXtuKmV6xn6SpVE7iq2xoPGXqLwZPzD1IsvPM32bZgam
 I5Bzo2ftpVmBx4gCk8t8SrYGBPrHXQwiBa08HOvUDPEsXNjLk6/BcS7BcRXr09pt3sztZ1VOB4H
 MsOYAUJOwyGCmG33brLumRqyPh8Mz+QM/+KVmU1GYCk+iYYQkFFemDdgRiy7Oau9Rda37gUgwyE
 rk=
X-Received: by 2002:a17:907:72c7:b0:c26:3190:296b with SMTP id
 a640c23a62f3a-c2a15e7df89mr192409366b.48.1789719845848; 
 Fri, 18 Sep 2026 01:24:05 -0700 (PDT)
Received: from draszik.lan ([109.255.181.4]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a1bbc6aafsm33384266b.51.2026.09.18.01.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 01:24:05 -0700 (PDT)
Message-ID: <b567cb05cf1508be7474e2874d267d8e8a09e49c.camel@linaro.org>
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Daniel Matyas <matyasdaniel006@gmail.com>, Lee Jones <lee@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Liang Yang <liang.yang@amlogic.com>, Miquel
 Raynal	 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman	 <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller"	 <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Bjorn Helgaas	 <bhelgaas@google.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Ray Jui	
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,  Vinod Koul
 <vkoul@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, Jonathan
 Hunter	 <jonathanh@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown	 <broonie@kernel.org>
Cc: Jose Abreu <joabreu@synopsys.com>, Ray Jui <ray.jui@broadcom.com>, Scott
 Branden <scott.branden@broadcom.com>, Atish Patra <atishp@rivosinc.com>,
 Shawn Guo	 <shawn.guo@linaro.org>, Dmitry Osipenko <digetx@gmail.com>,
 Thierry Reding	 <thierry.reding@gmail.com>, Ibrahim Tilki
 <Ibrahim.Tilki@analog.com>, Okan Sahin <Okan.Sahin@analog.com>,
 devicetree@vger.kernel.org, Paul Walmsley	 <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley	 <conor@kernel.org>,
 linux-rtc@vger.kernel.org, Ricard Wanderlof <ricardw@axis.com>, 
 patches@opensource.cirrus.com, Lukas Wunner <lukas@wunner.de>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Eugen Hristev <ehristev@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux@analog.com, linux-input@vger.kernel.org, 
 chrome-platform@lists.linux.dev, linux-riscv@lists.infradead.org
Date: Fri, 18 Sep 2026 09:25:27 +0100
In-Reply-To: <20260917144028.459053-1-matyasdaniel006@gmail.com>
References: <20260917144028.459053-1-matyasdaniel006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
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

On Thu, 2026-09-17 at 17:40 +0300, Daniel Matyas wrote:
> Running dt_bindings_check returned:
> [error] string value is redundantly quoted with any quotes (quoted-string=
s)
>=20
> The files used quotation marks in flow lists because the strings had
> commas and these commas were interpreted as separators. Convert flow
> style lists to block style lists, so that there is no problems with the
> commas.
>=20
> Signed-off-by: Daniel Matyas <matyasdaniel006@gmail.com>
> ---

Acked-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
