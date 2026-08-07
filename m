Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEEAC5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 12:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96BDA10E16A;
	Fri,  7 Aug 2026 12:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="fzFGtKZv";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id DAE9B10E16A
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 12:55:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 154911516;
 Fri,  7 Aug 2026 05:55:54 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A5A23F9A2;
 Fri,  7 Aug 2026 05:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1786107358; bh=xfEgerLRPb7madfeMA7wFM70ghEiPOqFAV7kOwYDnuI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fzFGtKZvoitFZaUTdqu0c54B3XFfBCnXIAu/DR2Mq58FOkjjok0wWgUeiV77bfx2i
 5q1rdjt9kOAEo6MqfhqtZKpEHpW1a4PCLERem8+pzB/f5B6iA0LCqEseD/LNCkk0CH
 gCGZKTgzam0wS2V+g0p36SPV6wRRpQ51dE0RYrRc=
Message-ID: <fb94bd28-fdbf-4f99-a6ff-b5ab18c64345@arm.com>
Date: Fri, 7 Aug 2026 13:55:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 7/9] accel/rocket: add RK3576 NPU (RKNN) support
To: Diederik de Haas <diederik@cknow-tech.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, alchark@flipper.net, chaoyi.chen@rock-chips.com,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260806063413.350184-1-gahing@gahingwoo.com>
 <20260806063413.350184-8-gahing@gahingwoo.com>
 <DKIKXY8XZVPF.3RFR4ISK6Y4QX@cknow-tech.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <DKIKXY8XZVPF.3RFR4ISK6Y4QX@cknow-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 07/08/2026 9:48 am, Diederik de Haas wrote:
> Hi Jiaxing,
> 
> On Thu Aug 6, 2026 at 8:34 AM CEST, Jiaxing Hu wrote:
>> The RK3576 has two cores of the same RKNN block and a few platform
>> differences:
>>
>>   - the CBUF (convolution buffer) has its own clock domain, so the core
>>     needs six clocks rather than four;
>>   - the BIU reset moved into the power domain, leaving one reset here;
>>   - the NPU spans two power domains, and a device with more than one is
>>     skipped by the driver-core single-domain auto-attach, so the list has
>>     to be attached explicitly;
>>   - the DPU completion interrupt is armed exactly as on RK3588 but never
>>     reaches the GIC. The completion is visible in INTERRUPT_RAW_STATUS,
> 
> I don't know if it's relevant, so just a data point:
> - RK3588 has Cortex A-76 + A-55, which have an External GICv4
> - RK3576 has Cortex A-72 + A-53, which have an External GICv3

Nope, RK3588 has GIC-600, which is very much v3 still. I guess RK3576 
probably has GIC-500 like RK3399 given the CPUs, but that shouldn't make 
any meaningful difference here.

If the interrupt never fires at all then possibly the signal depends on 
some additional clock or power domain in order to propagate, or it's 
just described incorrectly; or if other interrupt sources within the 
NPU/IOMMU do still work then maybe there's some additional masking 
control that's been overlooked, or perhaps it it just terminally broken.

(And FWIW I'm also inclined to agree with the other comments that 
refactoring existing code to make room for new stuff, then actually 
adding the new stuff, should probably be two separate steps if it's not 
completely trivial)

Thanks,
Robin.
