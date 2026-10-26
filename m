Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108EE606A320
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TKLCxbbj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C8510F33F;
	Tue, 27 Oct 2026 09:32:19 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC5010E04D
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:25:32 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-7ce6cb4c6faso66689137.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793017531; x=1793622331; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Uy/PqV0xn8AdfJOF2rmqxMZ7uFIic9NZvt40QP1514k=;
 b=TKLCxbbjCW4ttx+V64phTs9ow4yWnJHyJrHc8mu6Z8B469RlWxz9MC7X2vf/UM6m8n
 aT5eXzjJdmnFIy2/Dk81+cBje2JWrliB0dD8by9VyfBPjRootNOJ34ffHlQk+6xYYJic
 6Kj73EZ8sY4v/pT7INOWqFa3r4txMN/ZPOFrWYIex5JC4LdF0yC+cfN5/5vxRwTXi7vh
 gTdgC5g1y2FlX8YajfEAfPg+K7EAlHsTa/bLvnHbTqjydvgkBKZxOi+aiNtPs6U50aXE
 RHOAYoVkw63IPiE5TOmYicYY2j/Jwif7Z9WD9qvNHtC4hHtOH854S9Y+tZZ+0DvCHEwt
 LdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793017531; x=1793622331;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uy/PqV0xn8AdfJOF2rmqxMZ7uFIic9NZvt40QP1514k=;
 b=K/HY37L+eX/WTUI7TtXpvCXCEr9zZeuj3su0+/ZGawo2012eygHj1mFXx8yFBznh+Y
 GQgBGgjdZYEHZgqPo6mRa6ETi9zU08vJ2O+iQ01K6+kRldkRAOB539rq26Q/rscZBbs/
 pr2SWtBRHgjW4XR+l6yCqeGEXZDWkd+LfAhYlE1adYuWPUdVLILmhBGxUHOx67IRCoFj
 qjbe3NbV+/2UNZnt2R5UDXjUtywMznHHBkHzxD7EcgsDYrDPQ1fZT9YoNLEyp8SP84oK
 AgZO8PZX8Ne4f/it84LtTAhLQJHNmAOLM6+k875GG49wrAwcInWDdpyBzkc4ShYdmtK3
 rLUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz97/nNoypc/hRQ/ePLNhWbBGWfbFnVel65DnKSiLeP4WDtyCD+Fsbiw9UFR+yq6lSf5/pLxBDC814=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLW/DKxwgFz0Ov6zbCRjI34Z7E13KDOhZX+Wu16iLzuBHNhofAp
 zBEdWRRf6os/PpmeA/H2JUeQiIzsylSqgEqM98j/cCkjyFMyTgBnGBoo
X-Gm-Gg: AYBFou2W8ycewYS0J/JlnEtj7BjhtK/6V5DZfcaKBWbJ0Nxz4E0pZKMKS8806vJckxU
 wPQRPA/MGys0PPGrO9QWmSRcppn34LxUnfbqqIrsBODzE2u+ZlXiN7jx9JgiArYDX0RiJxvZXlc
 6pIdFqibYyU4+xgmgOFKlph+9yoKjT9VEZCaDeWOHKy0H7z4CYmDO7DAZbiaxz9PgI8Av4cZKmB
 9XKqzTEMj/JcxznXbNsasS8HFz42NT1utEURLw/S6zyP6EhHTt5v7bTdNiTt+Kh08eYgshjzVs8
 PnDiVhMFvGssKtMeRU4aE6Y8BLok/yF0Hnd+FizB6rsMGt24lrxD1a8DlFzcGaY6rKMIDPBxHr1
 P0NOmNnnaTBWBKmcxcHHRE2T0ZxQ+iG/PtXdxn2VMVREuRuDLJjJrgMlrEuO0Zqzz4VeTvqR2Vd
 SvwDD9WNSwidoidzWE7V7weANHmLrBgdd51ZwMCLoJH4mh5UaVJ6kFglg0Bh1FjrrNeJOJQmqCF
 pjHuao+Pl1RggpN+tyhQuY+YRiNTzvWbFtBfUk1Qztm8FgeUGnGaopFMKaSOw==
X-Received: by 2002:a05:6102:604e:b0:7cc:1b19:9258 with SMTP id
 ada2fe7eead31-7ce5ca1e48fmr1995133137.3.1793017530653; 
 Mon, 26 Oct 2026 05:25:30 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9910e7b7069sm8121766241.3.2026.10.26.05.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:25:30 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:25:20 -0300
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
Message-ID: <wancrsxcem5uep5oy5pnw5prewefqah7drmhiu5wrq3ctykltl@akwvtqbebblb>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
 <20261019-v2-apalis-imx6-enable-vga-v2-3-ef6a3a780472@toradex.com>
 <atZxhWaUWthEHkti@SMW015318>
 <lozimedmt3h7v6odvp4svvmatvk7726a4ztn3j7ft44oto7p5p@dmrudrmzyz3s>
 <ateQWqoTtXSBSBvm@SMW015318>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ateQWqoTtXSBSBvm@SMW015318>
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
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

Hi Frank,

On Tue, Oct 20, 2026 at 11:01:30AM -0500, Frank Li wrote:
> On Tue, Oct 20, 2026 at 07:33:10AM -0300, Leonardo Costa wrote:
> > On Mon, Oct 19, 2026 at 02:37:41PM -0500, Frank Li wrote:
> > > On Mon, Oct 19, 2026 at 07:17:16AM -0300, Leonardo Costa wrote:
> > > > From: Leonardo Costa <leonardo.costa@toradex.com>
> > > >
> > > > Add a device tree overlay for the VGA output available on the Apalis
> > > > Evaluation Board, which is driven from a parallel RGB interface passing
> > > > through a non-programmable video DAC to a VGA connector, without VESA
> > > > DDC I2C signals.
> > > >
> > > > The non-programmable video DAC consists of a simple resistor ladder that
> > > > converts the digital 16-bit RGB signal to VGA. The VGA output is gated by
> > > > an active-low data-enable signal.
> > > >
> > > > The overlay is also combined with the various Apalis Evaluation Board
> > > > device trees to provide ready-to-use DTBs.
> > > >
> > > > Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> > > > ---
> > > >  arch/arm/boot/dts/nxp/imx/Makefile                 | 21 ++++++
> > > >  .../boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso    | 80 ++++++++++++++++++++++
> > >
> > > what's difference with
> > >
> > > https://lore.kernel.org/imx/20261019-colibri-imx6-overlays-v1-5-e4d028727382@toradex.com/T/#u
> > >
> > > Is it possible share one dtso also?
> > >
> > > Frank
> >
> > Hi Frank,
> >
> > The Apalis iMX6 one needs to set up the connection between the IPU the
> > LCD interface (endpoints ipu2_di0_disp0 and vga_display_in), and the
> > Colibri iMX6 one uses a DVI connector instead of a VGA one. Most of all,
> > the bridge on the Colibri iMX6 doesn't have any control signals, while
> > this one on the Apalis iMX6 has an active-low data-enable signal
> 
> This make sense to use difference dtso to cover it. Is it use name
> imx6q-ipu-di0-vga.dtso, because this dtso have not boards specific part,
> which can reuse for other similar hardware? Or we can rename it when reuse
> happen.

I think the overlay should be kept as imx6q-apalis-eval-vga.dtso. As it
currently is, it's easy to identify the hardware it may be used with. If
another board is added which uses the same interface in this same way,
we can evaluate if it's adequate to change names for reusability.

Best regards,
Leonardo
