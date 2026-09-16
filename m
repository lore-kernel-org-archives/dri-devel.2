Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBABC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 01:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B22210E1B8;
	Wed, 16 Sep 2026 01:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="hrHjWyjO";
	dkim-atps=neutral
Received: from mail-m16023652185.xmail.ntesmail.com
 (mail-m16023652185.xmail.ntesmail.com [160.236.52.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5591110E1B8
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 01:55:17 +0000 (UTC)
Received: from [127.0.0.1] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4deb4f28d;
 Wed, 16 Sep 2026 09:55:12 +0800 (GMT+08:00)
Message-ID: <37f6edb3-7e25-4bcc-9af0-f816bab011e0@rock-chips.com>
Date: Wed, 16 Sep 2026 09:54:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] DSI Controller improvements for Rockchip platforms
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chaoyi Chen <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260914013331.108-1-kernel@airkyi.com> <3800544.yaVYbkx8dN@diego>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <3800544.yaVYbkx8dN@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0a7ecdabe03a7kunm8248de34c3a4d1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGB1IVh8ZTxlNSBpNHxpOH1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=hrHjWyjOUkhry66qfs0cSuuOdicD2DmJlD9XhO3AJTaukjIoXOCohSzeMYjEyoAkpZCToUL3Z0FyV2W8VNTZSw8RUIOoivFWt7ldo/ecx6DQ98zsHN4y2NhY9Ap2WJIqGgJB9pktMJnPB4Vd6byovgMlKXPwcZqKA9ppaj40C5E=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=loqpFx2us6AzXdnwENCyISIbEFmke5V5K2ft3dn7wXk=;
 h=date:mime-version:subject:message-id:from;
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

Hello Heiko,

On 9/15/2026 9:36 PM, Heiko Stübner wrote:
> Hi,
> 
> Am Montag, 14. September 2026, 03:33:28 Mitteleuropäische Sommerzeit schrieb Chaoyi Chen:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> This series is dedicated to enhancing the DSI controller and PHY timing
>> interaction, refining the lane rate calculation, and addressing the
>> associated hardware limitations.
> 
> 
> Took me a bit to finally test all the different variants for a display
> that shows strange behaviour. Sorry this gets a bit longer.
> 
> 
> The display in question is the ltk050h3148w [0], display in portrait
> orientation.
> 
> Ever since commit ac87d23694f4 ("drm/bridge: synopsys: dw-mipi-dsi: Use
> pixel clock rate to calculate lbcc") [1] and the subsequent fix in commit
> 93e82bb4de01 ("drm/bridge: synopsys: dw-mipi-dsi: Fix hcomponent lbcc for
> burst mode") [2], that display has its output shifted about 20 pixels to
> the right, with the line then continuing on the next display line.
> 
> We have this display running on all the Theobroma-System modules, so there
> is a lot of variant data :-) .
> 
> Your series actually fixed the PX30 part of that shifted output, but for
> the RK3399 the results are sort of mixed:
> 
> 
> What was confusing me was that in the Rockchip vendor kernel, _all_ DSI
> variants use the standard px30 phy settings? The whole original lookup
> table seems to be gone? And that replicating that setting actually fixes
> the shifted output on RK3399 too?
> 

Thanks a lot for the thorough testing!

The RK3399 results are surprising, as the Synopsys databook
configuration actually performs worse than the PX30 PHY configuration.
As for the vendor changes, unfortunately the specific reasons are lost
to history. But what is certain is that the original intent was to
resolve the interoperability issues with INNO PHY on PX30 and
subsequent platforms. 

So I've gone with a compromise in this series to distinguish INNO PHY
and Synopsys PHY. I'm not sure if using the same configuration for both
would work out completely, but so far no related issues have been
reported in the vendor kernel.

I don't have a better idea for patch 3 right now, because different 
platforms and panels may have different requirements for target_mbps. 
In vendor kernel, we read the DTS to override target_mbps like this:

/* optional override of the desired bandwidth */
if (!of_property_read_u32(dev->of_node, "rockchip,lane-rate", &value)) {
	target_mbps = value;
}

Would you consider this modification acceptable as an alternative to
patch 3? Thank you.

> 
> RK3399:
> 	original:
> 		shifted
> 		mode-clock 59400, target_mbps 450
> 
> 	patches 1+2:
> 		shifted
> 		mode-clock 59400, target_mbps 450
> 
> 	patch 3:
> 		blank disiplay
> 		mode-clock 59400, target_mbps 400
> 
> 	use static px30 phy with patch3:
> 		image is compressed in height and displayed two times one below the other
> 		image is _not_ shifted anymore (so left+right alignment are correct)
> 		mode-clock 59400, target_mbps 400
> 	
> 	use static px30 phy without patch3:
> 		image is _not_ shifted anymore
> 		output is correct
> 		mode-clock 59400, target_mbps 450
> 
> 
> PX30:
> 	original
> 		shifted
> 		mode-clock 59556, target_mbps 450
> 
> 	patches 1+2:
> 		output is correct
> 		image is _not_ shifted anymore (so left+right alignment are correct)
> 		mode-clock 59556, target_mbps 450
> 
> 	patch 3:
> 		output is still correct
> 		mode-clock 59556, target_mbps 400
> 
> RK3588 (DSI2) for reference:
> 	output is correct
> 	mode-clock 59756, lane_mbps 398
> 
> 
> Do you have any insight, what could go wrong here?
> 
> I'll apply patches 1+2 as they're correct, but will keep patch3 out
> for now.
> 
> Also Sashiko seems to still be unhappy with patch3.
> 
> 
> Thanks a lot
> Heiko
> 
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c#n299
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ac87d23694f44af44a98d21dd77016f2756b6b1b
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=93e82bb4de0196c4caeca1d8a6eef67863981d8f

-- 
Best, 
Chaoyi
