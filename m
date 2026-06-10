Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC58CD8CAD
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 01:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB0C210E140;
	Wed, 10 Jun 2026 01:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JMc/acb2";
	dkim-atps=neutral
Received: from mail-m128169.netease.com (mail-m128169.netease.com
 [103.209.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 850F710E140
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 01:14:08 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 41bfeee6e;
 Wed, 10 Jun 2026 09:14:04 +0800 (GMT+08:00)
Message-ID: <b05f7154-e85f-4207-80ae-f080282ba780@rock-chips.com>
Date: Wed, 10 Jun 2026 09:14:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
To: Midgy Balon <midgy971@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Simon Xue <xxm@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
 <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
 <CA+GS1Y1s78PwN63X2YJoS8VEGp7CpTERo_K65yKs00U4VRAw4Q@mail.gmail.com>
 <e5058919-9485-4de5-8eea-331ebfc2987c@rock-chips.com>
 <CA+GS1Y3ysdWZ3qCq3ip_Pbw+v4LxHZd95aBo=jwB+orYaMBBNw@mail.gmail.com>
 <CA+GS1Y0kAM_XGLQuKPTphif2HcQg18ZXhd8RHHr2xPOEMCDvXA@mail.gmail.com>
 <bcedaff0-abf8-4585-a0ea-057062cd0411@rock-chips.com>
 <CA+GS1Y2-hRqpGgsknh+oOX+-uZ3DZtdekdP9viTP6a40zhhUhg@mail.gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <CA+GS1Y2-hRqpGgsknh+oOX+-uZ3DZtdekdP9viTP6a40zhhUhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9eaf17f7ca03a7kunm086ddc0f265e19
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkIaVhgaT0JNSExLGhoeQlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=JMc/acb2P5/j0WDgBoNYDEgabsrTG6UUouYskrbbIrI3+e1FIjV+cY3SVNG0i6tQBYa65TADufI1IrcgOpVVxNrpxG7VhU9HVuUDORdfhEobuPvJC/wPn9SI+ziLIe3dHBTZ3H2EfowPzM3i1R4/7UXBr2WSPouPPyabXZj+Hlc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=xT9TRXqNVQ4NrOZ7G30C+sE2EpbR+Jn/B+pjkgNcIuw=;
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

Hi Midgy,

On 6/9/2026 7:11 PM, Midgy Balon wrote:
> Hello Chaoyi,
> 
> You were right - building rocket as a module fixes it. Thanks for the pointer.
> 
> I rebuilt with CONFIG_DRM_ACCEL_ROCKET=m (everything else the same:
> need_regulator on
> the RK3568 NPU power domain via a DOMAIN_M_R variant, domain-supply =
> <&vdd_npu>, and the
> regulator-always-on workaround dropped). The board now boots cleanly
> and, more importantly,
> an NPU job submit no longer hangs: I ran the test workload five times
> with no RCU stall and
> no freeze.
> 
> So with rocket=m the need_regulator approach works on RK3568, and I'll
> keep it for v4
> (domain-supply + need_regulator, instead of marking vdd_npu
> always-on). rocket=m is the
> normal configuration anyway; my earlier hang came from building it =y
> in a self-contained
> image, so it probed in the initcalls (around 2 s) and the genpd ->
> I2C-PMIC regulator
> transition ran before the system was ready. As a module it loads from
> udev much later
> (~6.8 s here), after the I2C controller and regulator core are fully up.
> 
> On your question of when the device-link error is printed - it is at
> power-domain
> controller probe, not at the rocket probe:
> 
>   [    2.700618] vdd_npu: Bringing 500000uV into 825000-825000uV
>   [    2.749637] rockchip-pm-domain fdd90000.power-management:power-controller:
>                  Failed to create device link (0x180) with supplier 0-0020 for
>                  /power-management@fdd90000/power-controller/power-domain@6
>   [    2.945955] platform fde40000.npu: Adding to iommu group 3
>   ...
>   [    6.840374] rocket: loading out-of-tree module taints kernel.
>   [    6.877647] [drm] Initialized rocket 0.0.0 for rknn on minor 0
>   [    6.879950] rocket fde40000.npu: Rockchip NPU core 0 version: 0
> 
> So the device-link to the rk809 PMIC (0-0020) fails to form at ~2.75
> s, well before rocket
> loads at ~6.8 s. It is non-fatal here - the vdd_npu rail is brought up
> by the regulator core
> and all jobs run - and there is no "failed to get ack on domain npu"
> NoC warning this boot
> (the always-on kernel had one). The complete boot log is attached.
> 
> Two notes / one question:
> - This boot used fw_devlink=permissive on the command line. Is the
> "Failed to create device
>   link ... supplier 0-0020" at pmdomain probe expected/benign, or is
> there a clean way to make
>   it order correctly (so it also works without permissive, and a =y
> build wouldn't deadlock in
>   the initcalls)?

We encountered the same issue on the RK3588 NPU before. And it was
resolved with the following patch at that time.

https://lore.kernel.org/all/20251216055247.13150-1-rmxpzlb@gmail.com/

Please compare the differences in NPU pmdomain and DTS configuration
between the RK3568 and RK3588.

> - (The convolution output is still uniform zero-point / the job times
> out - that is the
>   separate NPU compute-completion issue, unrelated to the power-domain
> work. Finley, that is
>   the one I flagged earlier re PVTPLL/NoC.)
> 
> Kind regards,
> Midgy
> 

-- 
Best, 
Chaoyi
