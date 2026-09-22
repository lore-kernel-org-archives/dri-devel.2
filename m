Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A74C982FD
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 01:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275D510E0A0;
	Tue, 22 Sep 2026 01:28:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="W0odU1OO";
	dkim-atps=neutral
Received: from mail-m81144.xmail.ntesmail.com (mail-m81144.xmail.ntesmail.com
 [156.224.81.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA1A10E0A0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:28:13 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4ea47cc08;
 Tue, 22 Sep 2026 09:28:05 +0800 (GMT+08:00)
Message-ID: <86d0a09c-f1e1-4310-aa39-6526268bdc76@rock-chips.com>
Date: Tue, 22 Sep 2026 09:28:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/14] pmdomain: rockchip: add optional per-domain
 power-on settle delay
To: Heiko Stuebner <heiko@sntech.de>
Cc: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>,
 royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-10-gahing@gahingwoo.com> <15844283.tv2OnDr8pf@phil>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <15844283.tv2OnDr8pf@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c6ba2f2d03a7kunmeb9776bc9d1cf
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSk4eVkxDGR9JGEoYHUhCTFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=W0odU1OOloYr55qtR7C7tVj3QAyYPL77i/h4ftBbKvQbI3quKMF5KR+1/q1L6P/K/JX8O6nCNzM53G0WqUmyiLvn/yBNzFcM8m8+KlASYIQ18AARR77yMJC5J/mQMpDGdfyoYrFpsjaJBgVfNbWDNJolVVt1Llx0m7JRklgsMiE=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=bEMNftgPUsUp/chMEhUbfGL5eAcx9DDwnaTufeKfD2w=;
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

Hi Heiko, Jiaxing,

On 9/22/2026 6:06 AM, Heiko Stuebner wrote:
> Hi,
> 
> Am Dienstag, 15. September 2026, 12:43:23 Mitteleuropäische Sommerzeit schrieb Jiaxing Hu:
>> The RK3576 NPU domains need a short settle time after the idle request is
>> released before the registers behind the domain answer. Without it the QoS
>> writes that rockchip_pmu_restore_qos() issues land while the domain is
>> still coming up, and the NPU throws an async SError on the first cold
>> power-on.
> 
> are you really really sure, this is the fault of the domain itself?
> 
> The regulator also can just need a longer time to bring up the power.
> Looking at [0], it seems I actually encountered the same thing back
> on the RK3588.
> 
> Only difference is, on RK3588 a fan5355-type regulator normally does
> provide the npu supply, while on your board it comes from the main pmic.
> 
> Can you please try the following:
> - set your power-domain regulator to always-on in the DT (so it stays
>   on even when the domain gets turned off)
> - try to reproduce your SError issue and see if it still appears
> 
> 
> And for the other case, look through the pmic datasheet to find the
> enable-time values and do something similar for the RK806.
> 
> 

Thank you for your attention to this series.

Providing some background here: this delay is required by the pmdomain
design itself, rather than being dependent on the external RK806 state. 
Taking the NPU as an example, after its pmdomain is powered on, some 
internal preparation is needed, which takes approximately 15us. 
And during this period, the QOS registers *must* not be accessed, 
otherwise it will cause a hang.

-- 
Best, 
Chaoyi
