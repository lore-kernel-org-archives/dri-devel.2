Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C55BC5AD5A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 01:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A7910E5C5;
	Mon, 10 Aug 2026 01:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gvYwIxUy";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Mon, 10 Aug 2026 01:37:05 UTC
Received: from mail-m20521016463.xmail.ntesmail.com
 (mail-m20521016463.xmail.ntesmail.com [205.210.164.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDFBC10E5C5
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 01:37:05 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4954c83d2;
 Mon, 10 Aug 2026 09:31:58 +0800 (GMT+08:00)
Message-ID: <4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com>
Date: Mon, 10 Aug 2026 09:31:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 7/9] accel/rocket: add RK3576 NPU (RKNN) support
To: Jiaxing Hu <gahing@gahingwoo.com>, robin.murphy@arm.com,
 diederik@cknow-tech.com, tomeu@tomeuvizoso.net, heiko@sntech.de
Cc: royalnet026@gmail.com, alchark@flipper.net,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260807211629.1573228-1-gahing@gahingwoo.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260807211629.1573228-1-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9fe94c473d03a7kunmce24bfbe32cc6a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHxpIVk8YTklMGE1NQ00eTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=gvYwIxUyRKyWrRPg/LzX/WyFw38Sqo3xYCQ4wqD9F6CVmdoIfBSqnYCMPF6PvmHvbK8L+y7Q5K/rDDmVaRqJEK+8LIWPfhHiU4x9Vh6ehxrNO3+HuhtlcF3nGkCGpaRTya2McD64fX7wN6/PSnPmaXOldmlH8R8IRiE9yhbuM6E=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=TyZsKoeFO/hOdOg/2IcDw4HLimad+gEcqp8l3PEbK/c=;
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

Hello Jiaxing, 

On 8/8/2026 5:16 AM, Jiaxing Hu wrote:
> On 07/08/2026 1:56 pm, Robin Murphy wrote:
>> If the interrupt never fires at all then possibly the signal depends on
>> some additional clock or power domain in order to propagate, or it's
>> just described incorrectly; or if other interrupt sources within the
>> NPU/IOMMU do still work then maybe there's some additional masking
>> control that's been overlooked, or perhaps it it just terminally broken.
> 
> Robin, Diederik, I owe you both a correction before you spend any more
> time on this. The premise is wrong. The interrupt is fine, and the
> polling in patch 7 should not exist.
> 
> The completion interrupt does reach the GIC on RK3576. With the fix
> below and the hrtimer disabled, so that only a real interrupt can retire
> a job, a single int8 convolution runs correctly three times out of three
> on three different inputs with zero timeouts and /proc/interrupts
> counting up. No extra clock, no extra power domain, no extra mask.
> 
> What was actually wrong is one register write. PC_TASK_CON packs the
> task number, and rocket_registers.h is derived from RK3588, where that
> field is 12 bits wide with TASK_PP_EN, TASK_COUNT_CLEAR and RESERVED_0
> above it at bits 12, 13 and 14. RK3576 uses a 16 bit task number, so
> those three controls sit at bits 16, 17 and 18 instead:
>

Sorry, I haven't had time to check this series. Here is some
information for your reference:

For RK3588:

- BIT[11:0] task_number
- BIT[12] task_pp_en
- BIT[13] task_count_clear

For RK3576:

- BIT[15:0] task_number
- BIT[16] task_pp_en
- BIT[17] task_count_clear
- BIT[18] task_last_layer_clear

>   rocket, v1 through v6:  TASK_CON = 0x00007001
>   vendor driver, RK3576:  TASK_CON = 0x00070001
> 
> So the PC read our word as task_number = 0x7001, that is 28673 tasks,
> with the count clear landing on nothing. It never signalled completion
> because by its own count it was never finished, and only a full reset
> ever cleared the counter. That also explains the other symptom in the
> cover letter, that only the first job after a reset computed anything.
> 
>   rocket_pc_writel(core, TASK_CON, (0x7u << 16) | task_count);
> 
> I found it by taking an ordered trace of every register write our driver
> makes during one submit and diffing it against the same trace from the
> vendor driver on the same board. Exactly one value differed. I should
> have done that before writing a workaround, and before describing a
> hardware limitation I had not established.
> 
> Two guesses I made the same night, a per job IOMMU teardown and the
> vendor's post completion sequence, were both wrong, which is the other
> half of the lesson.
> 
> So for v7: patch 7 loses the polling and the "the interrupt does not
> arrive" text. I would rather not carry a bounded poll at all. Jobs that
> compute incorrectly do still time out, but that is a driver bug on my
> side rather than something the hardware needs help with, and the
> scheduler timeout already covers it. Diederik, this is what you warned
> me about off list, that a poll reads as a workaround for an
> undetermined problem. You were right and the problem is now determined.
> 
> The rest of v7 follows what you both asked for: the job_lock fix becomes
> its own patch with a Fixes tag and leaves the RFC series, the
> rk3588_soc_data change is separated from adding rk3576_soc_data,
> refactoring comes before the new support rather than inside it, and I
> will stop editing a comment in the patch after the one that added it.
> 
> On the GIC question, for the record, so the thread has it in one place:
> RK3576 is GICv2, gic-400 in the upstream DT, not GICv3. It made no
> difference here, as you said it would not.
> 
> Thanks for digging into this, and sorry for pointing you at a fault that
> was mine.
> 
> Jiaxing
> 
> 

-- 
Best, 
Chaoyi
