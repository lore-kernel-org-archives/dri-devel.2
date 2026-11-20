Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513F60A2603
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvjL9tvT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5447310E8FA;
	Fri, 20 Nov 2026 16:57:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA14F10E8FA
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 16:57:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 18EBA62466;
 Fri, 20 Nov 2026 16:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536F91F000C6;
 Fri, 20 Nov 2026 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795193819;
 bh=DJ8cIXCRUOB9I2+njuBlGE2LdGi0WFfh6HrV7BoGga0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IvjL9tvTQiaHmCAeq33bh7cFtxbf7C0P3W2mb5u/sHTjg5ZZ1TlTASaX589CHUTBE
 SYhMFA7GBcFTiBF20NyZfjJPAWMj+S0i8HfaMniF3IF2WrIfG39DkDkl+w4Sc8ZSJl
 rl25wzQXY04GQrpJ5sIp1JoOy4BarvUDAgeh2SV0OI4PtT/XqTzTcCFVSs5n0Gp702
 WcMHxkybAkagD/kGHlIKYRRGjjQmpBseVg1sWbGRqUN3sw7wkBD+EhCrxFCrBOLCX1
 +pLkiqN1sUQPvCj1nzfaOGFY7AsjZCp5JUOyeollaCp+tKvu0tI8pBJ/5/r8oB7XOb
 U7IUN3yMvsNyg==
Date: Fri, 20 Nov 2026 11:56:53 -0500
From: Brian Masney <masneyb@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Russell King <linux@armlinux.org.uk>,
 Paul Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/6] clk: Remove unused clk.dev
Message-ID: <awB71ckHyTRIfy0p@x1g10>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <a896e5bdb29c7c6de39df9b28b11d55614f2ec2d.1795094688.git.geert+renesas@glider.be>
 <179513882271.284394.17357508909448455391.b4-review@b4>
 <CAMuHMdWJ8zK+kzcznM7FJ3JCo1xWzjRZ5MQz9jhSUcYQfO5rBA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWJ8zK+kzcznM7FJ3JCo1xWzjRZ5MQz9jhSUcYQfO5rBA@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 08:44:29AM +0100, Geert Uytterhoeven wrote:
> On Fri, 20 Nov 2026 at 02:40, Brian Masney <masneyb@kernel.org> wrote:
> > > This basically reverts commit efa850487a6b6742 ("clk: Inform the core
> > > about consumer devices").
> > >
> > > This commit added a struct device pointer member to struct clk and a
> > > parameter to clk_hw_create_clk(), but the new member was never used
> > > beyond setting.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > > --- a/drivers/clk/clk.h
> > > +++ b/drivers/clk/clk.h
> > > @@ -5,8 +5,6 @@
> > >   */
> > >
> > >  struct clk_hw;
> > > -struct device;
> > > -struct of_phandle_args;
> >
> > Did you mean to remove of_phandle_args?
> 
> Yes, it was added by efa850487a6b6742, too (although it was
> used in that header file before). Currently it's not used.

OK, I see that.

Reviewed-by: Brian Masney <masneyb@kernel.org>

