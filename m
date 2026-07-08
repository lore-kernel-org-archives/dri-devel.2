Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0DDC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABAE10E0C2;
	Wed,  8 Jul 2026 12:13:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m0sFEtCN";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD2C10E5C5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 12:13:09 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493d92b7db3so6382565e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 05:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783512788; x=1784117588; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eKW5gFGH/771IARNO8a+Mk4z1dF2QiKqn10sOpp4x8M=;
 b=m0sFEtCN7QZBu/0SRJHa5HJjWtUL69Mtm6jJjM4QKMAh2ZxjwttlrBdVyeot+jIAEl
 Ma1Bp4/bbbf/hqE+OM3vS6ru3CUQ1OtTiFFeUA52c1x2FAp6/Mu9q+DHq6FmUaSsKQIH
 fvFhjSrBMJRE8yWlx5Yfwu5byBvVf6LX6MZmaUSM2xOzHBeqe42KUnsigKUz3Ip/7sXN
 Jq6SHEtaobGew+4WHmPuq9oslCDoBhLLwbiMgt1DS/bw89wRCuHdsW99/OTvcWwcl+XN
 KEk+k7VWrAEfksLEaW51/ChNXNHl9mRaNspECVo332o/DnlF7ZyM2NaPtUDz0MBZELxV
 1bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783512788; x=1784117588;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eKW5gFGH/771IARNO8a+Mk4z1dF2QiKqn10sOpp4x8M=;
 b=jpW/Hz6w1SlAhV2sOAbtMBpsok8tCsCWEBgSR2tL0GsJ2XsmNKvtTRCQ/xDcjzZ3nH
 lrYhgm8BHvmtD0jbt7bfeQXDDFOm2sQF8wId5QOl5sB0XiAwyA9AgywDJRi94ARApLnn
 Cg36nqL6/GtjnOhe9nSnTvS0E3amgNH44kYnuPLifEVCYxMXydzbP/wpzLSpVePp7CHv
 y6KLKV01oqPbjOH9KyASB5/Ejbw6Os/kOiu0NAE2O0Q+LB6cZAUtcu9yol4Z0NqJHBb2
 klVNSaFSoTO7JAiPYYwf53gBmQRF4D5IISLPWjGIjoJPwTVjLASFMyhUhX8YmdqSA9gJ
 wcjg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrpdi2JxOZuorumk8UkQGcscww5V3O1t0Lvc5SKWxnriB6G/JLBEH7mpxFZ275gFbO9Ers99w1RaJI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjUcde8F+dhlBF1/cJ0L2M/npviJSM8lVUgXCHrP9JivLX09cv
 bsBkD0hf04nBvH+zlXuMc905CxZzVgikLIsTg8UWNMm0Q65LuNwUQziw
X-Gm-Gg: AfdE7ckJk+6dWxDNOyWEM7m12tvjpxYjgm+yhzCFZANKMe5zkOdbz3jl04V2GtdZloP
 pqzQ8INPekqyXAjVeJS9kzVex9FLyZreFH9iVPLuWeNJotT6GboSUdbEviK+4Rel0ihQ7QDcEBK
 Qp82lEuRvYTpHwfFJlRs1EkAbHfpixawmvt/B4pEQpBXZ08/1EiYjE6BzTgr4Nnlm0GCzM50eoH
 kZezXa/VDTe2ErlWQ4xQm3LzSscCFByZsUqBSiTtuu6V64wRCTr3rpfCo6IQ5G2p3I6IM7aL+an
 RuUCzCgJ0e6z4vVChd9adbDVLodQ9UmI9LhZYrVgxMCUphdYfY0/EojiAU4j7NPQpbAutWV1CzI
 ZfTV3n/4CIOfhxSGtbIEl4QPwstEFOqdj/bSblzd9r9ds/bQ1pR5M12VU9YVIksE+ZTsYyAYova
 5k7Q+W1cDZ
X-Received: by 2002:a05:600d:8498:20b0:493:d115:d835 with SMTP id
 5b1f17b1804b1-493e68b8094mr18294835e9.8.1783512787657; 
 Wed, 08 Jul 2026 05:13:07 -0700 (PDT)
Received: from owl5 ([2001:861:3201:3d10:d412:a0e9:ab11:7221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e5a572c3sm64268235e9.1.2026.07.08.05.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 05:13:07 -0700 (PDT)
Date: Wed, 8 Jul 2026 14:13:05 +0200
From: Gary Bisson <bisson.gary@gmail.com>
To: Adam Thiede <me@adamthiede.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 CK Hu =?utf-8?B?KOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: enable hs clock during pre-enable
Message-ID: <ak4-0SkPaeU3N2lh@owl5>
References: <20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com>
 <42607fa4-485d-4142-b31c-7bfac71118d2@adamthiede.com>
 <ajka2220depklK1_@owl5>
 <bac79214-050d-448b-be63-0586d45c807d@adamthiede.com>
 <f0d99b1a-e383-4d14-adb1-4ccab46efddb@leemhuis.info>
 <5baeb90d2c3736df67ad075ede4ac765bfeaed2d.camel@mediatek.com>
 <84233951-ee22-4980-9f17-2af1df51fdbf@leemhuis.info>
 <6fed12a6-0c94-477f-8a2e-466c33ea2e29@collabora.com>
 <dbc251f2-0c67-4970-a101-c19129055082@adamthiede.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbc251f2-0c67-4970-a101-c19129055082@adamthiede.com>
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

Hi Adam,

On Tue, Jul 07, 2026 at 08:25:41PM -0500, Adam Thiede wrote:
> On 7/7/26 05:38, AngeloGioacchino Del Regno wrote:
> > On 7/7/26 10:51, Thorsten Leemhuis wrote:
> > > On 7/7/26 04:20, CK Hu (胡俊光) wrote:
> > > > On Mon, 2026-07-06 at 12:16 +0200, Thorsten Leemhuis wrote:
> > > > > On 6/22/26 15:23, Adam Thiede wrote:
> > > > > > On 6/22/26 06:22, Gary Bisson wrote:
> > > > > > > On Thu, Jun 18, 2026 at 04:06:28PM -0500, Adam Thiede wrote:
> > > > > > > > On 1/20/26 05:36, Gary Bisson wrote:
> > > > > > > > > Some bridges, such as the TI SN65DSI83, require the HS clock to be
> > > > > > > > > running in order to lock its PLL during its
> > > > > > > > > own pre-enable function.
> > > > > > > > > 
> > > > > > > > > Without this change, the bridge gives the following error:
> > > > > > > > > sn65dsi83 14-002c: failed to lock PLL, ret=-110
> > > > > > > > > sn65dsi83 14-002c: Unexpected link status 0x01
> > > > > > > > > sn65dsi83 14-002c: reset the pipe
> > > > > > > > > [...]
> > > > > > > > 
> > > > > > > > This commit was part of 7.1 and caused a problem for me.
> > > > > > > > I'm running postmarketOS (basically Alpine Linux) on a Lenovo C330
> > > > > > > > chromebook with a Mediatek MT8173 processor.
> > > > > > > > The problem: when the display on my laptop
> > > > > > > > powers off (via suspend or
> > > > > > > > idle,
> > > > > > > > like xset dpms off) the picture does not come back when the display
> > > > > > > > powers
> > > > > > > > back on (from resume). The display backlight
> > > > > > > > comes on and brightness is
> > > > > > > > adjustable but there is no picture. The only fix is to reboot.
> > > > > > > > 
> > > > > > > > Reverting this commit and applying it as a patch on top of 7.1
> > > > > > > > addresses the
> > > > > > > > issue for me.
> > > > > > > > 
> > > > > > > > You can view the config I'm using here:
> > > > > > > > https://urldefense.com/v3/__https://gitlab.postmarketos.org/
> > > > > > > > postmarketOS/pmaports/-/__;!!CTRNKA9wMg0ARbw! jrsPDtSEUdaINzLlq92Li8gmsEBkTOxZ6WUzNHjvIN6CyOJjHiHkNSOhIRPXFTLPlaYlxU2uvryVkwjUAN9bmax5$
> > > > > > > > merge_requests/8819
> > > > > > > > 
> > > > > > > > Is there any sort of testing or other debugging
> > > > > > > > info I can provide to
> > > > > > > > help
> > > > > > > > address this issue?
> > > > > > > 
> > > > > > > Thanks for reporting the issue, could you share some
> > > > > > > logs? Is the driver
> > > > > > > saying anything during resume? Also, what type of
> > > > > > > panel is used on that
> > > > > > > chromebook?
> > > > > > 
> > > > > > The curious thing is that there are no real logs in dmesg or /var/log/
> > > > > > messages about this. This picture just fails to come
> > > > > > back. If there are
> > > > > > some kernel params I can set to get deeper logging, that
> > > > > > would help, but
> > > > > > I'm not aware of any.
> > > > > > 
> > > > > > I think the panel is a "BOE NV116WHM-T00" - I used this command to get
> > > > > > info: cat /sys/class/drm/card0-eDP-1/edid | edid-decode
> > > > > > 
> > > > > > Output:
> > > > > > https://urldefense.com/v3/__https://termbin.com/8nbd__;!!
> > > > > > CTRNKA9wMg0ARbw! jrsPDtSEUdaINzLlq92Li8gmsEBkTOxZ6WUzNHjvIN6CyOJjHiHkNSOhIRPXFTLPlaYlxU2uvryVkwjUAJooSyqL$
> > > > > 
> > > > > This looked stalled. If I'm mistaken here, please let me known; but if
> > > > > no solution is in sight, should we maybe just revert the change until a
> > > > > proper was found?
> > > > 
> > > > It's welcome anyone to provide a revert patch,
> > > > but I would still wait for the fixup patch until 7.2-rc4.
> > > > If no fixup patch exist, then apply the revert patch.
> > >  From my understanding of things the position in the devel cycle doesn't
> > > matter much in a case like this. To quote Linus statements from
> > > https://www.kernel.org/doc/html/latest/process/handling-
> > > regressions.html#on-how-quickly-regressions-should-be-fixed
> > > 
> > > """
> > >  From 2026-01-22:
> > > 
> > >   But a user complaining should basically result in an immediate fix -
> > >   possibly a "revert and rethink".
> > > 
> > > With a later clarification on 2026-01-28:
> > > 
> > >   It's also worth noting that "immediate" obviously doesn't mean "right
> > >   this *second* when the problem has been reported".
> > > 
> > >   But if it's a regression with a known commit that caused it, I think
> > >   the rule of thumb should generally be "within a week", preferably
> > >   before the next rc.
> > > """
> > > 
> > > Adam reported the problem about three weeks ago, so we are way past the
> > > "rule of thumb" timeframe Linus set.
> > > 
> > > Ciao, Thorsten
> > 
> > This is a kind of odd situation here. The fix from Adam is actually
> > correct, as in,
> > the SN65DSI83 bridge gets broken without...
> > 
> > ....but then, there's some more oddness going on: I tried to reproduce
> > this on my
> > MT8173 Elm device, but there I can resume the system just fine, and the
> > display is
> > up and running like normal?
> > 
> > I'm not sure what to advice here at this point - just adding some info.
> > 
> > Cheers,
> > Angelo
> Angelo, would you mind sharing your config, and the details of what you're
> running? It might be a configuration difference.

As a FYI here is the latest branch I tested that patch on:
https://github.com/gibsson/linux-next/commits/master-mtk/

As far as I remember suspend/resume was ok. It was tested with a
Tungsten510 SMARC SOM (MT8370) + sn65dsi83 + tm070jdhg30 display.
Both the bridge and the display are mainline, you can see that the main
change is in the defconfig where a bunch of options are changed to be
built-in (for NFS booting).

I'll try to repro against latest kernel this week and report back.

In your case, is the panel upstream as well?

Regards,
Gary
