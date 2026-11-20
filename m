Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23529606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPjsVoOv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61FB210E8D4;
	Fri, 20 Nov 2026 01:41:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E1610E8C7
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:40:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8496160D9F;
 Fri, 20 Nov 2026 01:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48EC1F000C6;
 Fri, 20 Nov 2026 01:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795138850;
 bh=UNYBiOhAD+30znGjPejLZJPRdYr6/sqO+OtQ52jw+6k=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=mPjsVoOv+gyomx2nkUJ4gfXTECNpfs5wubWv4LBWT7r0aOiMaRqYeG5ZVChyVtO2K
 bLpyRDUr98Io9WqgybKFqsLehTGnCTwWSPELRLnqacSzqL4Z5NLDlEzTrGl9iATzxh
 jN4Nh7bMMmbylRorj69iyvun/dpZc95nam8RKhXUnBOnG9x1/udORrrynW+j2WJ9Tf
 EiTZZCI8I3jWTlFiPonHcW+KngD34tcF6LtLGpxm+6gcw2xEwi2wuhVm3PRhMDrCZq
 jj9fkEs31b9b01QNqei7QmfcSZZIjZRGbwLYjATdDFDixrc3/gpTtpMuTWjqdXcUcM
 vxI05YqsG3JCQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/6] [RFT] drm/rockchip: dw_hdmi: Convert to
 dev_clk_get_from_provider()
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
In-Reply-To: <313d11bdd1dd46e895e34236191e7a3b175d0382.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <313d11bdd1dd46e895e34236191e7a3b175d0382.1795094688.git.geert+renesas@glider.be>
Date: Thu, 19 Nov 2026 20:40:22 -0500
Message-Id: <179513882273.284394.4331892287524393422.b4-review@b4>
X-Mailer: b4 0.17-dev-8145e
X-Developer-Signature: v=1; a=openpgp-sha256; l=479; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=JGsrsWKRl0kw3WUwGSIprP/RenP+nQQZD7u3j9iJt1I=;
 b=kA0DAAoWt9LdJ11+wIcByyZiAGr/pROgWlEsgnn4T7idnP8BIUXK0HiWzQz/5qMUdPDmhjFmD
 Ih1BAAWCgAdFiEEpG0ycFhlqj3e3CkEt9LdJ11+wIcFAmr/pRMACgkQt9LdJ11+wIeTyAEAnOnn
 uWf5C9UfZlObjo+Lo59Bat1yoayzzvNH9NdY1qwBAOswW+07L4AHYLwWodYFTqnZ7ppxIcEV09w
 V46KoATMJ
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

> The Rockchip Designware HDMI driver uses of_clk_get_from_provider() to
> obtain the clock for the HDMI PHY, so the latter shows up as
> "deviceless" in the consumer column of the clk_summary file in debugfs.
> 
> Fix this by using dev_clk_get_from_provider() instead, letting us pass
> the consumer device, too.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <masneyb@kernel.org>

-- 
Brian Masney <masneyb@kernel.org>
