Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7206BCD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C61FE10F076;
	Mon,  8 Jun 2026 09:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YNISX9hX";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Mon, 08 Jun 2026 09:43:40 UTC
Received: from mail-m8229.xmail.ntesmail.com (mail-m8229.xmail.ntesmail.com
 [156.224.82.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A47E210F076
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:43:40 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 41806bd9a;
 Mon, 8 Jun 2026 17:38:33 +0800 (GMT+08:00)
Message-ID: <bcedaff0-abf8-4585-a0ea-057062cd0411@rock-chips.com>
Date: Mon, 8 Jun 2026 17:38:32 +0800
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
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <CA+GS1Y0kAM_XGLQuKPTphif2HcQg18ZXhd8RHHr2xPOEMCDvXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ea6991e1403a7kunm0ef6a63b1a581f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHhlLVk9CH0lMHxgYTU4dSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=YNISX9hXTWB3JU79qXo0H1zIQ3fh38Q/5YMbGdbMb6fd15wfuSsjyr7euUN2kozRagih1CHfmjtNNcmqUqwDywkoiTwCLvwuXuGsg2ymzSQ1eBEYvRSSQEBl3Ac3zBVDZQENXtUYPsMZtRymEl4yLSxI4jnHatTSgFvAzWIKVPg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=ge2Ka7ZiWTZZ4XiOiKgnqGsdGuGGJlMJ7SGwJ0Ypbdk=;
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

On 6/8/2026 5:14 PM, Midgy Balon wrote:
> Hello Chaoyi,
> 
> Following up on the need_regulator suggestion -- I implemented and
> tested it on the
> board, and unfortunately it doesn't avoid the deadlock on RK3568; it
> moves it from
> boot to the NPU job submit.
> 
> What I did: gave the RK3568 NPU power domain a regulator (a DOMAIN_M_R
> variant with
> need_regulator = true), wired domain-supply = <&vdd_npu>, and dropped the
> regulator-always-on workaround.
> 
> Boot is now clean and the NPU probes, but there is a warning during boot:
> 
>   rockchip-pm-domain ...: Failed to create device link (0x180) with supplier
>   0-0020 for .../power-domain@6
> 
> (0-0020 is the rk809 PMIC that supplies vdd_npu.) Then on the first NPU job
> submit the board hard-hangs with an RCU stall:
> 
>   rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>   rcu:     3-...!: (1 GPs behind) ...
>   rcu: rcu_preempt kthread starved for 5115 jiffies! ... RCU_GP_WAIT_FQS(5)
>   rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected
> 
> My reading: vdd_npu is on the rk809 *I2C* PMIC, so when genpd
> enables/disables the
> regulator during the NPU's runtime-PM power transition, the I2C
> transfer runs in a
> context that starves RCU and the box freezes. (I suspect
> need_regulator is fine on
> the RK3588 NPU because its supply isn't behind an I2C PMIC.) The always-on
> workaround avoids this precisely because genpd never touches the I2C
> regulator in
> that path.
>

No, they are all controlled by RK809.

And This looks werid. Is your rocket driver compiled as a module? 
Please try compiling it as a module. When is the above error printed? 
Please provide the complete boot log.

> So: for an NPU domain whose supply is an I2C PMIC, is there a
> supported way to let
> genpd own the regulator without performing the I2C op in the
> power-transition path
> (a deferred/async regulator enable, or a flag), or should RK3568 keep vdd_npu as
> regulator-always-on? For v4 I'll keep always-on unless there's a cleaner path.
> 

-- 
Best, 
Chaoyi
