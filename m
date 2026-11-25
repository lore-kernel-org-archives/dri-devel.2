Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1B606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=bUIkWYwE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61A1010FBF3;
	Wed, 25 Nov 2026 11:53:41 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD1C610FC00
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:53:28 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F73373;
 Wed, 25 Nov 2026 12:50:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795607454;
 bh=NTnR3ucVdadYj5pUOifw5RHcnZpPRNVcEfRv0KFgbmw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bUIkWYwEJTgrEs9oUvp2p8ZbymBRhepLU5mhhTt1L758SlftwJknwL6iWpqeLz26C
 gO3POIgr0NDN43FlMO8v92m6yU/p8bk4jqlj37GtBx9Km2FrLC7bOni+kNI/OK40Xd
 7E2jYRrNyigbKaOSa4D2iKA6iWmmuY6TjXkFAVtQ=
Message-ID: <7783b523-3d37-4a10-b541-bf9ae8013e78@ideasonboard.com>
Date: Wed, 25 Nov 2026 13:53:23 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] drm/tilcdc: Implement state readout support
To: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261116142707.1299360-1-maximpedraza@gmail.com>
 <20261116142707.1299360-4-maximpedraza@gmail.com> <avs2dagfmQkv00H0@houat>
 <20261118212114.150992-1-maximpedraza@gmail.com>
 <20261124141119.441163-1-maximpedraza@gmail.com>
 <e58a5ff5-9c1b-40cc-a65d-c7fbfdaf18d1@ideasonboard.com>
 <20261125101541.463585-1-maximpedraza@gmail.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261125101541.463585-1-maximpedraza@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 25/11/2026 12:15, Màxim Pedraza Padilla wrote:
> On Tue, Nov 24, 2026 at 04:38:43PM +0200, Tomi Valkeinen wrote:
>> I felt that approach was a bit odd (and if I recall right, failed with
>> my OLDI panel), and in my tidss version I just used the clock rate
>> directly from the clk_get_rate() (see dispc_vp_readout_mode):
> 
> Thanks, good to know I'm not the only one it didn't work for. v2 does the
> same: the functional clock rate divided by the LCDC divider, rounded to
> the nearest kHz.
> 
> What I added is a 1% tolerance on the pixel clock in tilcdc's CRTC
> compare hook. When tilcdc_crtc_set_clk() can't get the exact rate, the
> clock read back after a commit differs from the mode by a few kHz: here,
> asking for 16941 kHz gets 16940.69 kHz from the display PLL. Out of 20
> pixel clocks between 16.9 and 45 MHz, four were off by up to 0.015% and
> the exact comparison reported them as mismatches.
> 
> Since you know tilcdc: do you know why tilcdc_crtc_mode_fixup() flips the
> HSYNC polarity? Its comment says the LCDC aligns VS on the second edge of
> HS, but I couldn't find that in the AM335x TRM, where IHS directly sets
> the polarity of the HSYNC pin. As it is, a panel needing an active low
> HSYNC has to leave hsync-active out of its DT timings.
Sorry, I don't remember. It's been quite a while, and that part wasn't 
my code. The original commit says:

+        * We use adjusted_mode, to fixup sync by aligning both rising
+        * edges and add HSKEW offset to let the slave encoder fix it up.

which sounds like the encoder (I think at that time there was really 
just a single encoder used) supports hskew, so the encoder then adjusted 
the syncs horizontally, and also used the correct polarities. You could 
have a look at the old kernel sources.

If I had to guess, the hack helps on some particular panel/encoder. And 
breaks some other. If you remove the hack, you get it the other way 
around =).

  Tomi

