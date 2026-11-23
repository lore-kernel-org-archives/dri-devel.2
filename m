Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF79606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Te4b5n+8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0263510E6CE;
	Mon, 23 Nov 2026 20:24:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B3810E6CE
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:24:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5ED286110A;
 Mon, 23 Nov 2026 20:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0EF1F000C6;
 Mon, 23 Nov 2026 20:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795465456;
 bh=1G36OaovxXTu0LQ+kkMP7/TVPf07CFUGx7fGAbDpiaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Te4b5n+8loWeAUEtLMSZUihv3ZWV7+y2VMUsUhocvoi18aRAwUrVt08Y4H/HXqT9X
 YREbK+Ny794vhIcCK+FyThQG7FxeRtRys69sz3QL0XZfOSsILHUWv/66cNfqKepEAs
 KsJZrB5P7mbwaEoTpc2FeEKgqvWvlFunCrgWD2jihVmiZrB3Twe3IMxXl24krJ5tIn
 1lthtYmcA4TFxrwOiqMmPRF5F9r8gtqWSn83nV4e3t1mol4U+iJ7ktRQJh6YLGLPLq
 Xqixsj7zWDp2I+tt/9NWyth/cEeGtjbv9saAeUb8xVkV/NcnhnmqfQFuu8rVvcMg5B
 b3sfyov5sZjFg==
Date: Mon, 23 Nov 2026 14:24:10 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Selvaraj <jo@jsfamily.in>,
 Jagan Teki <jagan@amarulasolutions.com>, Ondrej Jirman <megi@xff.cz>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ryan Brue <ryanbrue.dev@gmail.com>,
 Nickolay Goppen <setotau@mainlining.org>,
 Robert Chiras <robert.chiras@nxp.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Heiko Stuebner <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>,
 Michael Walle <mwalle@kernel.org>, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Jens Reidel <adrian@travitia.xyz>,
 Michael Srba <Michael.Srba@seznam.cz>, Shawn Guo <shawn.guo@linaro.org>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 Alexander Baransky <sanyapilot496@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Romain TISSERAND <romain.tisserand@gmail.com>
Subject: Re: [PATCH v3] dt-bindings: display: panel: Make DSI panels port
 optional
Message-ID: <20261123202410.GA1813552-robh@kernel.org>
References: <20261113084236.53336-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113084236.53336-2-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 09:42:37AM +0100, Krzysztof Kozlowski wrote:
> DSI panels can be placed under DSI bus directly and some of the Linux DRM
> drivers will work fine with it: mipi_dsi_host_register() adds device for
> such panel and DRM driver does not use OF graph to configure lanes.
> Examples are Samsung Exynos and Allwinner DRM drivers.
> 
> The Linux panel drivers affected here do not use OF graph, either.
> 
> Requiring graph port for such panels is tying the binding to one
> specific implementation of Linux DRM drivers, e.g. Qualcomm DRM which
> requires the port.  That's a mistake, because:
> 1. It prevents usage of such panel in DTS for other platforms,
> 2. Places the constraint (port requirement) in wrong domain - the DSI
>    host needs the port, not the panel.
> 
> The port is not needed for the panel hardware to operate thus it should
> be optional.
> 
> Suggested-by: Romain TISSERAND <romain.tisserand@gmail.com>
> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # renesas r61307 and r69328
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied to drm-misc.

Rob
