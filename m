Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01563606A332
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=aK5RDBX6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 551FF11283E;
	Fri, 20 Nov 2026 09:53:49 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1B7112852
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=/XR8mwGEvCfQ40OFBdbL3peozsc+De8DLZuvdd7EMf8=; t=1795168422; x=1796378022; 
 b=aK5RDBX6Rr6BdX9n0BOKoI8Kdu9psGS2EkLIeT1s+aG5hOuZwdgdFHDZcvRvFMU6kHTa4VCsqFF
 lWaRhtwMg1QBY5XWPe4pZExBxyG5znIY1JL+/9va8AnpVA22TwC73iEEeLWUWTVb3odDhYl1YAVEo
 QbJJhcmPK6+PNlZu0APWW9g5pEEoY5bJ5kpgM7N/YjVq94We/9y2o/yMjbCzdQX11Pw7j5YH4E334
 MR0RYIDUHnwwTbzy+6XOIG7YUNXlpSXx9WUygeuPjCWwDBAlmf/XxMdTEOtu+HzutKax5kV1byIz6
 nEgBYhAf/OeN9aS0OxBQ+FYkMN5xX5oQINDg==;
Date: Fri, 20 Nov 2026 10:53:14 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: ettore.chimenti@linaro.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin
 Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Paul
 Walmsley <paul@pwsan.com>, Stephen Boyd <sboyd@kernel.org>, Brian Masney
 <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy
 Huang <hjc@rock-chips.com>, Heiko =?UTF-8?B?U3TDvGJuZXI=?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, Ulf Hansson
 <ulfh@kernel.org>, linux-clk@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to
 dev_clk_get_from_provider()
Message-ID: <20261120105314.57a13a83@kemnade.info>
In-Reply-To: <CAMuHMdWiCODz6RC9Q9-xMM5_k3grHztiLuR+-ikOZYoBawVvZg@mail.gmail.com>
References: <cover.1795094688.git.geert+renesas@glider.be>
 <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
 <20261119225017.15a7b5cc@kemnade.info>
 <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
 <20261120094320.442d064b@kemnade.info>
 <CAMuHMdWiCODz6RC9Q9-xMM5_k3grHztiLuR+-ikOZYoBawVvZg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 09:49:39 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Andreas,
> 
> On Fri, 20 Nov 2026 at 09:44, Andreas Kemnade <andreas@kemnade.info> wrote:
> > On Fri, 20 Nov 2026 08:49:05 +0100
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:  
> > > On Thu, 19 Nov 2026 at 22:50, Andreas Kemnade <andreas@kemnade.info> wrote:  
> > > > On Thu, 19 Nov 2026 14:40:38 +0100
> > > > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > > >  
> > > > > OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> > > > > used for power management, so the latter show up as "deviceless" in the
> > > > > consumer column of the clk_summary file in debugfs.
> > > > >
> > > > > Fix this by using dev_clk_get_from_provider() instead, letting us pass
> > > > > the consumer device, too.
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > ---
> > > > > Compile-tested only.
> > > > >
> > > > > The first change is probably OK.  The second change may fail if anything
> > > > > in the oh->od->pdev->dev chain is not available yet at this point.  
> > > >
> > > > Test on OMAP3:  
> > >
> > > Thanks for testing!
> > >  
> > > > --- clk-old     2026-11-19 22:44:59.810807920 +0100
> > > > +++ clk-new     2026-11-19 22:26:52.862531880 +0100
> > > > @@ -1,17 +1,17 @@
> > > >                                   enable  prepare  protect                                duty  hardware                            connection
> > > >     clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
> > > >  ---------------------------------------------------------------------------------------------------------------------------------------------
> > > > - oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      of_clk_get_from_provider
> > > > + oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      dev_clk_get_from_provider
> > > >                                                                                                             deviceless                      no_connection_id  
> 
>                                 deviceless
> mcbsp_clks
> > >
> > > Hmm, so the passed device is always NULL, and thus there is no point
> > > in making the change.
> > > Do you know if these come from the first or second change in my patch
> > > (I guess the second)?
> > >  
> > From the first change, The second piece is nowadys only used by the dm81*
> > devices.  
> 
> Interesting.  So that means all/some of the existing use of
> &od->pdev->dev in _add_clkdev() is futile, as it may be NULL?
> 
I was wrong, it comes from neither. So lets start ftrace via cmdline...
ftrace=function ftrace_filter=dev_clk_get_from_provider

Piping the result through uniq -c 
      8           <idle>-0       [000] d....     0.000000: dev_clk_get_from_provider <-ti_dt_clocks_register
     66           <idle>-0       [000] d....     0.000000: dev_clk_get_from_provider <-ti_clk_add_aliases
      1           <idle>-0       [000] d....     0.004913: dev_clk_get_from_provider <-of_clk_set_defaults
      1           <idle>-0       [000] d....     0.004974: dev_clk_get_from_provider <-of_clk_set_defaults


Regards,
Andreas


