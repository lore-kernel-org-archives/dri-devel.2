Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73B606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=norik.com header.i=@norik.com header.a=rsa-sha256 header.s=default header.b=MDGAnUER
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6630112AC1;
	Fri, 27 Nov 2026 13:06:36 +0000 (UTC)
X-Greylist: delayed 1564 seconds by postgrey-1.36 at gabe;
 Fri, 27 Nov 2026 13:06:30 UTC
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DBB112AC1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1h7on8HImX2X0LgBMc3cNbmT/5TZPxb20/cpZcLkUw=; b=MDGAnUERglQnqyyCJ5069e0ocB
 H8j/V19yzpMwApbLBuukG7lBOK8yLeJIGfIglr00DoxaHZvkTPiSNorYeMBXfEGJUVbEZNIOufvot
 Zo7gmKgCxeKunFu5bdOCqQa3SGRzqhTRtrHMkzD/Fmtvra99wClJfFzPbSG4ICyLkNavez3lUKNe1
 S9Gc+92o7D33gbEk0fNqvHtbNYGD6yhw90HmrfYS06TEavP7hW/xTzbpPzLIqOfnnyxa5QHwC/kRI
 QeIh/f/2iB/KTjONoS/P29Ay/k06+Y5U3zNwZKOYdK7gU6dugJJ+uHg3OLsUyweOPFSdw9ofEYX8W
 OBH7T/Uw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:55190
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.100.1) (envelope-from <andrej.picej@norik.com>)
 id 1xWvFW-00000004Q4L-1Qqr; Fri, 27 Nov 2026 13:40:21 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Ernest Van Hoecke <ernestvanhoecke@gmail.com>, regressions@lists.linux.dev
Cc: tessolveupstream@gmail.com, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, marex@denx.de, valentin@compulab.co.il,
 philippe.schenker@toradex.com, alexander.stein@ew.tq-group.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Teresa Remmet <t.remmet@phytec.de>, upstream@lists.phytec.de
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
Date: Fri, 27 Nov 2026 13:40:12 +0100
Message-Id: <20261127124012.3664549-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DMTXMG427D7Z.MVUAQQE9B08W@bootlin.com>
References: <DMTXMG427D7Z.MVUAQQE9B08W@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cp2.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Luca, Francesco, Ernest,

On Fri Nov 13, 2026 at 9:15 AM CET, Luca Ceresoli wrote:
> I hoped to get better info from Ernest. The commit looks correct so chances
> are that regression is caused but other bugs (incorrect timings, inaccurate
> clocks, etc).

I see the same regression on another board, the PHYTEC phyBOARD-Polis
i.MX8MM with the PEB-AV-10 adapter. This board also had a clock problem,
but with that fixed, the display is clean without
4af021a97773 and glitches constantly with it. Details below, following
your list.

> * accurate description of what hardware breaks, with pipeline components

i.MX8MM LCDIF (mxsfb) -> samsung-dsim (4 lanes, video burst mode) ->
SN65DSI83 (single-link LVDS, LVDS clock taken from the DSI clock) ->
EDT ETML1010G3DRA panel, DT overlay
imx8mm-phyboard-polis-peb-av-10-etml1010g3dra.dtso.

> * panel timings (or, better, panel datasheet URL with that info)

panel-simple edt_etml1010g3dra, typical values: 72.4 MHz, 1280x800,
hfp 72, hbp 86, hsync 2, vfp 15, vbp 21, vsync 2.

> * exact kernel version (upstream kernel tag or SHA-1)

v7.4-rc2 (9d66f26fefac), and Frank Li's imx/fixes (acba37c2e2df, based
on v7.4-rc1).

> * clocks used and measured on the lines

Clocks read from the registers, not measured on the lines:
- LCDIF pixel clock: 72.375 MHz (video_pll1 144.75 MHz / 2, set by the
  DT fix [1])
- DSI: 434.4 Mbit/s per lane (samsung,burst-clock-frequency = <434400000>,
  DSIM PLLCTRL 0x0155541F), so the SN65DSI83 runs its LVDS clock at
  434.4 / 2 / 3 = 72.4 MHz

Without [1], the pixel clock is exactly 72.4 MHz, and the panel shows
line glitches even with 4af021a97773 reverted (about 12 per minute).
That is a separate, older problem of this board, which [1] fixes.

> * difference observed before/after the patch on the cables and in software

                         4af021a97773 applied   reverted
  without [1]            constant glitches      ~12 glitches/min
  with [1]               constant glitches      clean (50 display starts)

The glitch is a missing line for one frame. The SN65DSI83 does not
report an error (register 0xE5 stays 0). In software, 4af021a97773
changes the DSI mode flags from 0x2e3 to 0x283, and DSIM_CONFIG from
0x1670707F to 0x1610707F, so the HFP and HBP blanking packets are
sent.

> * any other detail of your investigation

I think, but I'm not sure, that the HFP/HBP packets don't fit into the
line time, because the DSI link runs at exactly 72.4 MHz * 24 / 4 =
434.4 Mbit/s per lane and has no headroom. As a quick test, a 724 Mbit/s
link with the SN65DSI83 DSI clock divider changed to 5 by hand was clean
with 4af021a97773 applied. That can't be set up properly without the DSI
link-rate negotiation discussed for patch 2/2.

Unlike on Ernest's board, disabling burst mode does not help here: with
patch 2/2 applied on top (DSIM_CONFIG 0x1210707F), the SN65DSI83
reports CHA_SYNCH_ERR (0xE5 = 0x80) and the driver resets the pipe
about once per second.

[1] https://lore.kernel.org/all/20261127093953.3541816-1-andrej.picej@norik.com/

Best regards,
Andrej
