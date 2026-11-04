Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B36074F8A
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T9txq0pG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45EC710E51D;
	Wed,  4 Nov 2026 20:32:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C39C10E51D
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793824361; x=1825360361;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6f8UgVjKpQ2wVNTwKjGWI3IG5kYob1To5ZXvPuHXznw=;
 b=T9txq0pGeQFs+uc7DzsUe19pTReCw+4rEX9bZApMhQiR1wEToVrsfEdn
 Y6BRpxn/1c+WrWMrnV7znbky9lkA4DvK53ar5Llt/8wga05kTaXBfPJ32
 OeikSzFHH4NpTTtdMKI7RRDvDNfI09A96cYlhqQRiqUpS9/4FYrBr4kWY
 D9KoZ86uNtsRLQUgo0hURjWTjxg93Ul56FqAwpIIx2tHeqNqFVGEsaR0q
 ja5o5Ghy8E9dzGoetw/7k+aSlx/gsuUIMW7hWRqkLZ2jxCuxu0a4BC/4m
 yEXafTfYB/idGWIgUO7VUknx/Qt+h9Z3M1v9nM5aNplNeSZecBL5azSjF Q==;
X-CSE-ConnectionGUID: DhVWko0ERRCVtTAlaOQrXw==
X-CSE-MsgGUID: DNwX+uS5Q1+rjcbSrIXTpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2590657"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2590657"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:32:41 -0800
X-CSE-ConnectionGUID: oeRVokCFTSG70c80N5OpXQ==
X-CSE-MsgGUID: cq871yY0SA+tQsjaqT4Xmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6690148"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.24])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 12:32:23 -0800
Date: Wed, 4 Nov 2026 22:32:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Shawn Guo <shawnguo@kernel.org>,
 Chanh Nguyen <chanh@os.amperecomputing.com>,
 Alistair Francis <alistair@alistair23.me>,
 Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>,
 Dmitry Osipenko <digetx@gmail.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>,
 Scott Branden <scott.branden@broadcom.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-sound@vger.kernel.org, linux-input@vger.kernel.org,
 linux-tegra@vger.kernel.org, mfd@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
Message-ID: <auuWVGsyb3RrOIfh@ashevche-desk.local>
References: <20261102135330.2493332-1-robh@kernel.org>
 <20261104-vigorous-flat-dingo-3e5bd2@quoll>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-vigorous-flat-dingo-3e5bd2@quoll>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 06:32:43PM +0100, Krzysztof Kozlowski wrote:
> On Mon, Nov 02, 2026 at 07:53:22AM -0600, Rob Herring (Arm) wrote:
> > Unit-addresses by default (and most commonly) are hexadecimal. There's a
> > number of cases using decimal patterns. Fix all of them, limiting the
> > pattern to match the 'reg' limits if there are any.

...

> > --- a/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> > +++ b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> > @@ -123,7 +123,7 @@ properties:
> >          const: 0
> >  
> >      patternProperties:
> > -      "^layer@[0-9]+$":
> > +      "^layer@[0-9a-f]+$":
> 
> These two lines are looking good.
> 
> Andy, it's okay if I give Rb tag?

Yes, again a pointer to 34d1e754155b ("dt-bindings: iio: drop unneeded quotes").

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

I expect to see

 Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> # xylon

or something that matches the piece you reviewed.

-- 
With Best Regards,
Andy Shevchenko


