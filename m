Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFBC606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSWvlxGX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A4E1127EE;
	Fri, 20 Nov 2026 01:41:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C2210FE75
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:40:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8AE874683A;
 Fri, 20 Nov 2026 01:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D964F1F000C4;
 Fri, 20 Nov 2026 01:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795138848;
 bh=aWLmF/3TFJHphPfFbdIW/SCt13oJ16DXgR+WbLyacng=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=hSWvlxGXDrkBhyd8iPNzHhSr//zVCQ8oOyWZLSkfEgGDXAqyuxG7EU1Dn8IAgv/o7
 iM55eayZXAoWHo+12C1oZPhfZC3kCYDfQNNR2U1THP45Jy97i7G7Prhsu/4SveW8BB
 rut3yoF9BKy+UwPKY8hauuhCzl2OJR07Tu/t1RD+gS9qb2k/FVet28DIZgILz0xPHC
 qA98vwMx63v6+usMfwqmJLOQ9HXx+ygT87RAyw2hjzoDoKG36r8MUhz4mSJrdm0hgQ
 D1EhOGPj/RRai2NzLViEUzRp9LRhgOKjh6tkEG65FmhZzUq1sJrOSnnzJGxryKq1RA
 7Co0Vh43lGhwA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/6] clk: renesas: Convert to dev_clk_get_from_provider()
From: Brian Masney <masneyb@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>, 
 linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, Brian Masney <masneyb@kernel.org>
In-Reply-To: <55d67b95c675924fb67d13ecbab47bb45c8af372.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <55d67b95c675924fb67d13ecbab47bb45c8af372.1795094688.git.geert+renesas@glider.be>
Date: Thu, 19 Nov 2026 20:40:22 -0500
Message-Id: <179513882272.284394.9826583224210522814.b4-review@b4>
X-Mailer: b4 0.17-dev-8145e
X-Developer-Signature: v=1; a=openpgp-sha256; l=700; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=NYTf8jjEK+WlRFfr+I/PcRCeTGbwoene0QOnnIsqQzM=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL+LxX6yHaVa5rUJs4HTdOYPGVati9u/tZWPIfNWtSye
 EVw+qSwjlIWBjEuBlkxRZYluUYFEamrbO/d0WSBmcPKBDKEgYtTACai3cPwv3D1ca83R60eNDtV
 W085viJXcaXhjiur/qrmzXpv9tnkvxMjw9UJpdHBidtqejZEXP383uHDlwuMn+612oVsStuoubn
 hPScA
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Renesas clock domain callbacks use of_clk_get_from_provider() to obtain
> clocks used for power management, so the latter show up as "deviceless"
> in the consumer column of the clk_summary file in debugfs.
> 
> Fix this by using dev_clk_get_from_provider() instead, letting us pass
> the consumer device, too.
> 
> Sample clk_summary change snippet on R-Car H1 Marzen:
>     - sata 1 1 0 62500000 0 0 50000 Y deviceless    of_clk_get_from_provider
>     + sata 1 1 0 62500000 0 0 50000 Y fc600000.sata dev_clk_get_from_provider
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <masneyb@kernel.org>

-- 
Brian Masney <masneyb@kernel.org>
