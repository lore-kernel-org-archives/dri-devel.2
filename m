Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B39C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6612C10E65F;
	Mon, 31 Aug 2026 07:19:17 +0000 (UTC)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [83.223.78.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B2710E65F
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:19:15 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout2.hostsharing.net (Postfix) with ESMTPS id 7E43810DD1;
 Mon, 31 Aug 2026 09:19:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 6884B60BA873; Mon, 31 Aug 2026 09:19:13 +0200 (CEST)
Date: Mon, 31 Aug 2026 09:19:13 +0200
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
Subject: Re: [PATCH] drm/i915/psr: enable PSR on Apple T2 eDP panels
Message-ID: <apUq8bYCZ3I9bErN@wunner.de>
References: <20260829161622.11396-1-alexander.fischer@kait2en.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829161622.11396-1-alexander.fischer@kait2en.org>
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

On Sat, Aug 29, 2026 at 06:16:22PM +0200, Alexander Fischer wrote:
> +static void quirk_apple_psr_handshake(struct intel_dp *intel_dp)
> +{
> +	struct intel_display *display = to_intel_display(intel_dp);
> +	struct pci_dev *t2;
> +
> +	if (!intel_dp_is_edp(intel_dp))
> +		return;
> +
> +	t2 = pci_get_device(PCI_VENDOR_ID_APPLE,
> +			    PCI_DEVICE_ID_APPLE_T2_BRIDGE, NULL);
> +	if (!t2)
> +		return;
> +
> +	pci_dev_put(t2);

We've got pci_dev_present() for this.
