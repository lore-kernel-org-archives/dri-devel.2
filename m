Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8B5CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0125B10F39B;
	Fri,  8 May 2026 07:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="CrGH8IBi";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D42C510F390
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778225299;
 bh=7gm+mcDWEZxlLbT9ThUjYICxy8NSTbZxFiGykculdGs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CrGH8IBiryMwAX1r5+LHr+8JJcpFaZm1z/QYpMt7+BoJDJbrjOvhfeHUmIcdgMOSu
 O2FYrlhP1nQp6Z/GPD2nWE+oM0AP5eSA9J+JtWzgQ8fSjQJiJ7IoCTyaMCqvGcz90w
 +A9SOSifaRlb6SYFxSYdFp6/SFCyCAzWLshZCdh4irqzKhExn0R1T2uVYTqeCwfS/m
 x3fj5cKx1Gv9gbAzFtPSCz20sO2+BUe4mlaq88vGUL69tTMl2Rsh2JJzCR2WDvWZIY
 C88GOWyur1tFnLJkCb6o+3MXFnBpIv2OHhsf2zy8Uy+RErJoYo0EqbeOmQW8KiIcCI
 x/lI6F7vwtXDg==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 298F717E0E08;
 Fri,  8 May 2026 09:28:19 +0200 (CEST)
Message-ID: <2b2aa38b-329d-4c05-b1ed-bf6c29209f8a@collabora.com>
Date: Fri, 8 May 2026 10:28:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/bridge: dw-hdmi-qp: seamless handoff sets wrong
 tmds_char_rate, breaking audio on strict HDMI 2.1 sinks
To: Simon Wright <Simon@symple.nz>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kernel@collabora.com" <kernel@collabora.com>
References: <ME3P282MB21960D9D68BFF520316BDFCEA83E2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
 <38b2e226-c8f0-44b4-bf71-66caa0b27d43@collabora.com>
 <ME3P282MB2196C1D097CB4A61D2376FAFA83C2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
 <61e86f45-cc62-433b-b929-2df66ab0f1ff@collabora.com>
 <ME3P282MB2196331E84F4BB5FC72419A5A83D2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ME3P282MB2196331E84F4BB5FC72419A5A83D2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 5/8/26 8:53 AM, Simon Wright wrote:
> Hi Cristian,
> 
> Thanks for the pointers -- I should have checked rockchip-devel
> before the previous reply. Three things to clean up:
> 
> * Sige5 in linux-next and Sige7 in rockchip-devel both match what I'd
>   derived from the schematics -- dropping the DTS follow-ups I had
>   drafted.
> 
> * Your FRL work in rockchip-devel supersedes the BSP-derived prototype
>   I was going to port. Standing down on that; happy to Tested-by the
>   series once it's posted.
> 
> * Acknowledged on the HDMI 1.4 vs 2.x framing.
> 
> Tested-by: Simon Wright <simon@symple.nz>

The trailer must be added by replying to the series containing the patches, i.e.
see the "Reply instructions" at the bottom of:

  https://lore.kernel.org/all/20260227-hdptx-clk-fixes-v1-0-f998f2762d0f@collabora.com/

> 
> Heiko, Vinod -- any chance hdptx-clk-fixes v1 can be applied? It
> cleanly addresses the high-bpc rate recalculation and uncommitted PHY
> config issues on RK3576 hdptx, and Tested-by results on real hardware
> (R76S + LG G3 OLED) match the cover letter.

This should also go with the reply above.

> 
> Reproducer for the audio mute:
> 
>   1. mainline 7.0 + hdptx-clk-fixes v1 applied (or rockchip-devel HEAD
>      -- same code path).
>   2. Sink that doesn't tolerate incorrect ACR CTS values -- LG G3 OLED
>      is the canonical case, LG C4 OLED behaves identically. More-
>      permissive sinks play audio regardless and won't surface the bug.
>   3. Set a mode whose tmds_char_rate is NOT in common_tmds_cts_table[].
>      Affected rates we tested: 1920x1080@60 bpc=10 (185.625 MHz, the
>      original-bug regime -- requires max_bpc=10 set on the connector
>      property), 3840x2160@30 8-bit (297 MHz), and 3840x2160@60 8-bit
>      (594 MHz).
>   4. The mode must be held for the duration of the audio test --
>      `modetest -s` releases DRM master on exit and fbcon reverts to
>      an in-table mode, which would explain audio playing in your
>      test path.
>   5. speaker-test -D hw:0,0 -c 2 -t sine -f 440 -- mutes without the
>      fix, plays with it.
> 
> I'll send the CTS-from-N change as a separate patch against
> rockchip-devel, 

Any submitted patches must be based on a recent enough upstream branch or tag -
in this case either v7.1-rc2 [1], next-20260507 [2] or drm-misc-next [3].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v7.1-rc2
[2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?h=next-20260507
[3] https://gitlab.freedesktop.org/drm/misc/kernel/-/commits/drm-misc-next?ref_type=heads

Regards,
Cristian
