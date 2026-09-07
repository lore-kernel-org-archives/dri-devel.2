Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB5EC79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC29C10E7E7;
	Mon,  7 Sep 2026 12:23:20 +0000 (UTC)
X-Greylist: delayed 526 seconds by postgrey-1.36 at gabe;
 Mon, 07 Sep 2026 12:23:19 UTC
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [144.76.133.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D7F10E7C6;
 Mon,  7 Sep 2026 12:23:19 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout3.hostsharing.net (Postfix) with ESMTPS id B3080D76;
 Mon, 07 Sep 2026 14:14:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 6A658601CB35; Mon,  7 Sep 2026 14:14:31 +0200 (CEST)
Date: Mon, 7 Sep 2026 14:14:31 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Alexander Fischer <alexander.fischer@kait2en.org>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>,
 =?iso-8859-1?Q?Andr=E9?= Eikmeyer <andre.eikmeyer@kait2en.org>,
 Yossef Osman <yossef.osman@proton.me>
Subject: Re: [PATCH v2] drm/i915/psr: enable PSR on Apple T2 eDP panels
Message-ID: <ap6qp8Ct7aLQJhmx@wunner.de>
References: <20260829161622.11396-1-alexander.fischer@kait2en.org>
 <20260907083753.41393-1-alexander.fischer@kait2en.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907083753.41393-1-alexander.fischer@kait2en.org>
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

On Mon, Sep 07, 2026 at 10:37:53AM +0200, Alexander Fischer wrote:
> @@ -286,6 +306,14 @@ static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
>  		.sink_oui = SINK_OUI(0x00, 0x22, 0xb9),
>  		.hook = quirk_disable_edp_panel_replay,
>  	},
> +	/* Apple T2 eDP panels */
> +	{
> +		.device = DEVICE_ID_ANY,
> +		.subsystem_vendor = PCI_ANY_ID,
> +		.subsystem_device = PCI_ANY_ID,
> +		.sink_oui = SINK_OUI(0x00, 0x10, 0xfa),
> +		.hook = quirk_apple_psr_handshake,
> +	},
>  };

Looking at lspci output of the MacBookPro16,2 and MacBookPro15,4,
I note that the integrated GPU has Subsystem Vendor 0x106b.
So you could use ".subsystem_vendor = PCI_VENDOR_ID_APPLE,"
to bail out early from the for-loop in intel_init_dpcd_quirks().

Thanks,

Lukas
