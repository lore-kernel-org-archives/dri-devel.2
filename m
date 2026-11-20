Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D56606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXjgZ5nu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 713A910FE75;
	Fri, 20 Nov 2026 01:41:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561D310E8D4
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:40:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F58E60A6C;
 Fri, 20 Nov 2026 01:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739831F000D2;
 Fri, 20 Nov 2026 01:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795138852;
 bh=vcKPQHmf9gWTDq0nbpcIRDBqyotp3mpevFZSMkbKrMc=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=OXjgZ5nuBCosE1FlnEJeoifb7O714az6f2IdsuWkNJ89tkZTpKfNTf4OhnTdcW4bK
 5cUNPpLYp9ANhTfaKetlX2fEmRAInxL6aB/OnhqXraqqJakMuZsr/j/s9YH6ib5mVg
 UZnzcRM6v9yQiO2+kJv4ddJYpDu4kRHTBK0vXugWiLdvCcrkRhxohYpJ3LH0gA1TFg
 zdxcVxVq1kfrmX2NxboDhSwpvHnaj8CsxJwT0DKAdAqbuIdA6e5o44xQt+/stDFon1
 2a9qVnjIXeBIINOvm9NNi3XRmDcG0T1rdHK2IFfRjn1r0M67yC7CM99EGL2gR85rjJ
 eOLlW3zKvsJog==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to
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
In-Reply-To: <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
Date: Thu, 19 Nov 2026 20:40:22 -0500
Message-Id: <179513882273.284394.16014881415515819933.b4-review@b4>
X-Mailer: b4 0.17-dev-8145e
X-Developer-Signature: v=1; a=openpgp-sha256; l=470; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=agOkKy6rfsDuf/v2Uk7yRPZKM78mXjUOoAKPNIJkhCE=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL+LxUJkxVluuylry9x6uWzQ++lGcU2O7r9UJ+fk//G+
 xG3nu3njlIWBjEuBlkxRZYluUYFEamrbO/d0WSBmcPKBDKEgYtTACay4ALD/9wj5notbPd46naL
 HP950JH7Tr5VWltQya0zRnEPk6JuX2X4n8GcvNHHbdnP3JqL0dpbBKcEGzS1Ldzk+TjuheKLV7s
 YGQE=
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

> OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> used for power management, so the latter show up as "deviceless" in the
> consumer column of the clk_summary file in debugfs.
> 
> Fix this by using dev_clk_get_from_provider() instead, letting us pass
> the consumer device, too.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <masneyb@kernel.org>

-- 
Brian Masney <masneyb@kernel.org>
