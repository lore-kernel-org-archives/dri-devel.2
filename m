Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC904606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Z16QyKYT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDFD10E132;
	Wed, 25 Nov 2026 20:59:05 +0000 (UTC)
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B44E410E132
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 20:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 sang-engineering.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=k1; bh=Yi8H
 bY7avl9S/WCaQ0l/DLFnbsp+kW/rpAuDBKM+Wwk=; b=Z16QyKYTJXiCk1GBl7qp
 8OSv/TFvPsvbxjRerrVgd8aSkTHmaLr61YpEJktg9X+4ADStTJECdOT4ahpnz1Yc
 7eU63v6K7T4fpS3/snmspxQ0itWHB7Pk7i9r1Xz58BeNI/EG9thweohVbkbxdSID
 krbLBkJlkNs7VcbnIKLMyLV+ME40bAsEWG1Zf8QtMGZYdkzMt4DBzRujIN/4bS/h
 309VFtXc8H6DFmzzhXSygyAjU1ebEHgczZW68rtq6ZYq2r13xwBTZstawhD9f+xz
 WXQKTwNPHbWl2feGv18UhJwSAdk28vH5pmDnv4/tQoXzPaAY9JtVZ5WTw8o0biHF
 +A==
Received: (qmail 1133866 invoked from network); 25 Nov 2026 21:58:56 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 25 Nov 2026 21:58:56 +0100
X-UD-Smtp-Session: l3s3148p1@MnZjGCBhIOoujnvc
Date: Wed, 25 Nov 2026 21:58:56 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 6/6] [RFC] pmdomain: renesas: r8a78000: Convert to
 dev_clk_get_from_provider()
Message-ID: <awdMEJReSkI-YEdo@ninjato>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <81de8a7aadf587377916763d24181c44b5d13775.1795094688.git.geert+renesas@glider.be>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81de8a7aadf587377916763d24181c44b5d13775.1795094688.git.geert+renesas@glider.be>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 02:40:39PM +0100, Geert Uytterhoeven wrote:
> The R-Car X5H clock domain callback uses of_clk_get_from_provider() to
> obtain clocks used for power management, so the latter show up as
> "deviceless" in the consumer column of the clk_summary file in debugfs.
> 
> Fix this by using dev_clk_get_from_provider() instead, letting us pass
> the consumer device, too.
> 
> Sample clk_summary change snippet on R-Car X5H Ironhide:
>     - hscif0 1 1 0 0 0 0 50000 Y deviceless      dev_clk_get_from_provider
>     + hscif0 1 1 0 0 0 0 50000 Y c0710000.serial dev_clk_get_from_provider
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Works fine.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

