Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7C606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=I4RCL8+l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4F910E7E8;
	Mon, 23 Nov 2026 13:01:16 +0000 (UTC)
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D37CC10E7E8
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 sang-engineering.com; h=date:from:to:cc:subject:message-id
 :references:mime-version:content-type:in-reply-to; s=k1; bh=SsVR
 MPSyNzie31mooAWwpfLKTDZGyyCN3cZBedOe8C4=; b=I4RCL8+lfqpMIAWTNiyl
 Po3sM2dYYNnR0RVAbIEz75KzF2sOpEi0h7sIuXnka9qQIOHY6CY/PJ/feNrWrHrB
 6bE64kbw20m/c+8Uj3Shwms/DmvhERv6+T2Di+nxPDn1iG72DHVAo07B7mttZGEk
 +P26Y9LeYdoNC1jh+XZCwfj4cW0iB6iJdxdONZjGSIJTsLfP2lsc2WmoL/UGfZzq
 I8cjXXUtgimzxmC5e05i1VIhO0oxnQJlMWpgW1ch+DOcHjqAMQkKBMeAE+CYz9pH
 ZmQnveSzX5XVpsrjra98/SLTYFHxR77GV+xjhqMFLQOK9Ubg9ok1u8g3BlBr97zm
 BQ==
Received: (qmail 2731665 invoked from network); 23 Nov 2026 14:01:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 23 Nov 2026 14:01:06 +0100
X-UD-Smtp-Session: l3s3148p1@vhjXL/FgUIgujnsu
Date: Mon, 23 Nov 2026 14:01:06 +0100
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
Subject: Re: [PATCH 1/6] clk: Remove unused clk.dev
Message-ID: <awQ5Ems-ZyYsWVRy@ninjato>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
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

On Thu, Nov 19, 2026 at 02:40:34PM +0100, Geert Uytterhoeven wrote:
> This basically reverts commit efa850487a6b6742 ("clk: Inform the core
> about consumer devices").
> 
> This commit added a struct device pointer member to struct clk and a
> parameter to clk_hw_create_clk(), but the new member was never used
> beyond setting.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Cool cleanup!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

