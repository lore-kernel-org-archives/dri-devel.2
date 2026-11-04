Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD80606A333
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGYEVKoG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE91C10E86B;
	Wed,  4 Nov 2026 08:19:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A2510FA4C
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 08:19:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A655601F6;
 Wed,  4 Nov 2026 08:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C59E1F000C1;
 Wed,  4 Nov 2026 08:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793780349;
 bh=7JPjenQFeEsZp71b+iGe0lGbAcckPwZVykttqOk4x5Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VGYEVKoGNwFuMJbTOlO7VKVvGlToA5A1xtt1tUQu/WGB1i1j9NttWJM/9bq4oTWXW
 YZVTVn1SAkFb9cnjEgZA4Ox5ZZDmKBJ8PO155G/DBT52C1wa6Ulq19x0nZprUah0Mb
 ne1LR2560+AP7QCob8LSk7VejOfbXRsijZN1KCTZdFUNfq6hNch6sFesuGt/uVP6+e
 9CK/EoculLm9BMAlQPK2Y7oNZ34vt7qKV4AnrKtNqoVber3PRzcgsUhEWrFZI0DgNh
 IHPjWHTdjMgkO8vGJrvcFTFM9rujxlckBOq8SMHdvX2D8z8+i65qNanXxGjDKNXvQ+
 JWcHHnkEVQ3qw==
Date: Wed, 4 Nov 2026 08:19:02 +0000
From: Lee Jones <lee@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Swamil Jain <s-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v5 00/15] drm/tidss: Add BeagleY-AI display support (and
 some more)
Message-ID: <20261104081902.GC792264@google.com>
References: <20261103-beagley-ai-display-v5-0-f1c8d0e52bb4@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-beagley-ai-display-v5-0-f1c8d0e52bb4@ideasonboard.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[...]

> Changes in v2:
> - Add Rb and Tb tags
> - Drop "dt-bindings: mfd: syscon: Add ti,am625-dss-dpi0-clk-ctrl

Looks like I should have been dropped here.

Please can you remove me as a recipient of this large set.  Thanks.

>   compatible", which is now implemented with the below changes.
> - New patch "dt-bindings: display: ti,am65x-dss: Add ti,dpi-io-ctrl"
> - Modify "drm/tidss: Add external data and sync signal edge
>   configuration" to use the 'ti,dpi-io-ctrl' with offset.
> - New patch "arm64: dts: ti: k3-am62p-j722s-common-main: Make main_conf
>   a syscon".
> - Modify "arm64: dts: ti: k3-am62p-j722s-common-main: Add support for
>   DSS" to set 'ti,dpi-io-ctrl' properties
> - Drop generic desc in DT bindings for power-domains property
> - Fix pm_runtime_get_sync() return value check
