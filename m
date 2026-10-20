Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1986606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bl7SJiLG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5391A10FCB3;
	Wed, 21 Oct 2026 08:51:53 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0C4110EBB9
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:33:19 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-33fb4680717so5720660eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792492399; x=1793097199; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iQyv3UXDKrcHPg5SiBMTwmI7JSOMjEBmbwi+E5uk+A8=;
 b=bl7SJiLGkUC3dCMe9cHEgiPopRj+lvObXnq+cjg46Apqf+sKINhk2GmZNcOuInfeJG
 jIsydsHuKuF00S0pRAB3W+OSBAJpkO1UJiPYZ3lHHZZnVQjWXhYATgOvUEXTGH6vz7ta
 RvU0s5dPJPcyxGzBqwZIrgvh40JprBkibT4PtHKF5VE9OtI7+2+O3ifIpzQI1AO8aJmF
 HzHLUXS/glo8XnoCiuCFD4m6rXyt92Rt4NvxM3JsPJlPz7BhlUCjHca+DBeXyssKjJJm
 58pbN1aBUQtTIufsGIv6WKXdrmALsWd53czepchhMHDB7KoLM/MZauw1nQ1wH4NvPfYc
 r0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792492399; x=1793097199;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iQyv3UXDKrcHPg5SiBMTwmI7JSOMjEBmbwi+E5uk+A8=;
 b=ql4GqC8i0IVOIE+h69O6GfLMYaAO/2zQuRPGf9id9JPrvC3UXI3bwZ69KwXt454GRg
 8AVS72oDpWAa3z2nhNF3JadkgfSlBQyk6F2E0ec0X1W1xielmaA5iCRgFJxdtP5Kk4or
 Ut6/JLCVrVYjc1miPUkVj9NhShEFt098SRnvVqMaAxnIWYj2igFvSx92u2ovsb74A+HP
 IiXlNwRbOQ7JXC7DUNJIL4yZng0TjhVnr9qFzlUKzigmp2+OEXgKTqPwQKtgbf0Q9r67
 EZOCmHmTezML2205gdKOpZlMpsWGYaJK3wC7lgepa+RdcKjOwoJJHenKja8aSEDDeJ3v
 8jbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcXsmR5NbThsCafLeUp3WHLbk/ahW3N5VD52bieAPiu373FhbrJlTdO7KllN5EJGXft2V6RJJ+ALs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIze+oIf9T6PB3MZa8q+2be2Fd3IKZ2cUGuKE7sHDMm9Cga8pfD
 ndEWBXVN5xYbCXKaIcLfVqHhzMv2qnSEcgjMtNBptG0fNQ34d7CugD4D
X-Gm-Gg: AYBFou2VqsH3Kr4gDX+0/UwUUfunPiue1Zka25OYrlsykFgjjlp0IDvl5RQ3aGPTCUI
 6UIBPggnp9HSd6vLIi0CIjxNMMcMpdkNDdQyBpS3uWKzJB8XErvkyCopjN7jafMUopRGjdslAz6
 UJ//9vrGdNmU6GMYYMRmolOWEuku0Th3bWvbs4j2Ph2agRFtdb2yxaJ1USeZeBAmoc+GziysXpg
 aOFqpDxCwa9h20jUFP3Q0gMzHgmEHst9DVJiuCq7d3lhTV76PUkHFpq08DeSed1UEZd0J6vwAKT
 Zr3wpVuATN3q06eBU0XbxLTc/oG5+YW2UVYxsaxBm6ZnT2WIl5K1SUmCSj/vr+8W0MVU/iD0pfk
 eDv2AJ8wm8rFkKx5ujUW0TQUBDhE+J66IRccU0j5gdeLdCuJxz+qH1Al/MwlzRVuMV++CrzafJb
 ez6eLs3MG0r7BDuprpnRF9tp15FOqbvwNnKU/LHwOaEzN4Qr6OP/0vi9tmRpcZ/i3tfAWtysTJs
 241
X-Received: by 2002:a05:7022:1001:b0:14c:be8e:69fe with SMTP id
 a92af1059eb24-1850c8da80emr20220476c88.5.1792492398134; 
 Tue, 20 Oct 2026 03:33:18 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831c4d4675sm35068908c88.21.2026.10.20.03.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:33:17 -0700 (PDT)
Date: Tue, 20 Oct 2026 07:33:10 -0300
From: Leonardo Costa <leoreis.costa@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 
 Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6q-apalis: Add VGA overlay
Message-ID: <lozimedmt3h7v6odvp4svvmatvk7726a4ztn3j7ft44oto7p5p@dmrudrmzyz3s>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-3-ef6a3a780472@toradex.com>
 <atZxhWaUWthEHkti@SMW015318>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atZxhWaUWthEHkti@SMW015318>
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 02:37:41PM -0500, Frank Li wrote:
> On Mon, Oct 19, 2026 at 07:17:16AM -0300, Leonardo Costa wrote:
> > From: Leonardo Costa <leonardo.costa@toradex.com>
> >
> > Add a device tree overlay for the VGA output available on the Apalis
> > Evaluation Board, which is driven from a parallel RGB interface passing
> > through a non-programmable video DAC to a VGA connector, without VESA
> > DDC I2C signals.
> >
> > The non-programmable video DAC consists of a simple resistor ladder that
> > converts the digital 16-bit RGB signal to VGA. The VGA output is gated by
> > an active-low data-enable signal.
> >
> > The overlay is also combined with the various Apalis Evaluation Board
> > device trees to provide ready-to-use DTBs.
> >
> > Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> > ---
> >  arch/arm/boot/dts/nxp/imx/Makefile                 | 21 ++++++
> >  .../boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso    | 80 ++++++++++++++++++++++
> 
> what's difference with
> 
> https://lore.kernel.org/imx/20261019-colibri-imx6-overlays-v1-5-e4d028727382@toradex.com/T/#u
> 
> Is it possible share one dtso also?
> 
> Frank

Hi Frank,

The Apalis iMX6 one needs to set up the connection between the IPU the
LCD interface (endpoints ipu2_di0_disp0 and vga_display_in), and the
Colibri iMX6 one uses a DVI connector instead of a VGA one. Most of all,
the bridge on the Colibri iMX6 doesn't have any control signals, while
this one on the Apalis iMX6 has an active-low data-enable signal
specified on the input endpoint. Because of all of these, the overlay
needs to be different between these modules.

Best regards,
Leonardo
