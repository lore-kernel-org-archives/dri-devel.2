Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28394C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 772C810E47A;
	Tue,  7 Jul 2026 08:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="YrgSOQBF";
	dkim-atps=neutral
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8944210EC1C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 08:51:53 +0000 (UTC)
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
 by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4gvZj31W9Kz8n1M;
 Tue,  7 Jul 2026 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1783414311;
 bh=qAvw60k//6hFjyNyqu7YYOWF+8zLu93HZ24O0efrTCw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YrgSOQBFmrjB93rhJpD2TtOEeloLXK1usWWnBgVS+BaWUwyLwPYLzd9F8Ab+8teti
 BBp5Vh9q9le4Sl7QlCAOAyDElu85XFUnda01s/AFn9AtJd7Lz0rDVVG7b26HvhdHKY
 ANPETsitGFWHsxpde9Q7b15mcvCHHY6JOE6/8P1aCvgp1zoa8QJAGwRJb3rW6Lst+m
 yyEtbzBM2Tul8PRFIHUP5DJ1uFCFwnVfr07rB00lwTqHebRoqw6tZyuMkvJ/jeyarM
 rZBO/DiU4+B0CtJk2W0XvxwMkVGrlFK4GG+5Bo8Dj1H5zhCDMjImmJ25+VnuQoybl+
 xUDXb4/9Q9tMQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4gvZj30ny2z8n0L;
 Tue,  7 Jul 2026 08:51:51 +0000 (UTC)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gvZj157qlz8sWT;
 Tue,  7 Jul 2026 10:51:49 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id C679A5FC3F;
 Tue,  7 Jul 2026 10:51:48 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <84233951-ee22-4980-9f17-2af1df51fdbf@leemhuis.info>
Date: Tue, 7 Jul 2026 10:51:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "me@adamthiede.com" <me@adamthiede.com>,
 "bisson.gary@gmail.com" <bisson.gary@gmail.com>
Cc: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
 <42607fa4-485d-4142-b31c-7bfac71118d2@adamthiede.com> <ajka2220depklK1_@owl5>
 <bac79214-050d-448b-be63-0586d45c807d@adamthiede.com>
 <f0d99b1a-e383-4d14-adb1-4ccab46efddb@leemhuis.info>
 <5baeb90d2c3736df67ad075ede4ac765bfeaed2d.camel@mediatek.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <5baeb90d2c3736df67ad075ede4ac765bfeaed2d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178341430939.3962464.17635774890868316574@mxe9fb.netcup.net>
X-NC-CID: zdu5T8PV57LkUnyRdE7oTK/+a14nrtefMRsTmliu6xJM4NY6kzM=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On 7/7/26 04:20, CK Hu (胡俊光) wrote:
> On Mon, 2026-07-06 at 12:16 +0200, Thorsten Leemhuis wrote:
>> On 6/22/26 15:23, Adam Thiede wrote:
>> > On 6/22/26 06:22, Gary Bisson wrote:
>> > > On Thu, Jun 18, 2026 at 04:06:28PM -0500, Adam Thiede wrote:
>> > > > On 1/20/26 05:36, Gary Bisson wrote:
>> > > > > Some bridges, such as the TI SN65DSI83, require the HS clock to be
>> > > > > running in order to lock its PLL during its own pre-enable function.
>> > > > > 
>> > > > > Without this change, the bridge gives the following error:
>> > > > > sn65dsi83 14-002c: failed to lock PLL, ret=-110
>> > > > > sn65dsi83 14-002c: Unexpected link status 0x01
>> > > > > sn65dsi83 14-002c: reset the pipe
>> > > > > [...]
>> > > > 
>> > > > This commit was part of 7.1 and caused a problem for me.
>> > > > I'm running postmarketOS (basically Alpine Linux) on a Lenovo C330
>> > > > chromebook with a Mediatek MT8173 processor.
>> > > > The problem: when the display on my laptop powers off (via suspend or
>> > > > idle,
>> > > > like xset dpms off) the picture does not come back when the display
>> > > > powers
>> > > > back on (from resume). The display backlight comes on and brightness is
>> > > > adjustable but there is no picture. The only fix is to reboot.
>> > > > 
>> > > > Reverting this commit and applying it as a patch on top of 7.1
>> > > > addresses the
>> > > > issue for me.
>> > > > 
>> > > > You can view the config I'm using here:
>> > > > https://urldefense.com/v3/__https://gitlab.postmarketos.org/postmarketOS/pmaports/-/__;!!CTRNKA9wMg0ARbw!jrsPDtSEUdaINzLlq92Li8gmsEBkTOxZ6WUzNHjvIN6CyOJjHiHkNSOhIRPXFTLPlaYlxU2uvryVkwjUAN9bmax5$
>> > > > merge_requests/8819
>> > > > 
>> > > > Is there any sort of testing or other debugging info I can provide to
>> > > > help
>> > > > address this issue?
>> > > 
>> > > Thanks for reporting the issue, could you share some logs? Is the driver
>> > > saying anything during resume? Also, what type of panel is used on that
>> > > chromebook?
>> > 
>> > The curious thing is that there are no real logs in dmesg or /var/log/
>> > messages about this. This picture just fails to come back. If there are
>> > some kernel params I can set to get deeper logging, that would help, but
>> > I'm not aware of any.
>> > 
>> > I think the panel is a "BOE NV116WHM-T00" - I used this command to get
>> > info: cat /sys/class/drm/card0-eDP-1/edid | edid-decode
>> > 
>> > Output: https://urldefense.com/v3/__https://termbin.com/8nbd__;!!CTRNKA9wMg0ARbw!jrsPDtSEUdaINzLlq92Li8gmsEBkTOxZ6WUzNHjvIN6CyOJjHiHkNSOhIRPXFTLPlaYlxU2uvryVkwjUAJooSyqL$
>> 
>> This looked stalled. If I'm mistaken here, please let me known; but if
>> no solution is in sight, should we maybe just revert the change until a
>> proper was found?
> 
> It's welcome anyone to provide a revert patch,
> but I would still wait for the fixup patch until 7.2-rc4.
> If no fixup patch exist, then apply the revert patch.
From my understanding of things the position in the devel cycle doesn't
matter much in a case like this. To quote Linus statements from
https://www.kernel.org/doc/html/latest/process/handling-regressions.html#on-how-quickly-regressions-should-be-fixed

"""
From 2026-01-22:

 But a user complaining should basically result in an immediate fix -
 possibly a "revert and rethink".

With a later clarification on 2026-01-28:

 It's also worth noting that "immediate" obviously doesn't mean "right
 this *second* when the problem has been reported".

 But if it's a regression with a known commit that caused it, I think
 the rule of thumb should generally be "within a week", preferably
 before the next rc.
"""

Adam reported the problem about three weeks ago, so we are way past the
"rule of thumb" timeframe Linus set.

Ciao, Thorsten
