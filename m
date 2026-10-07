Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28575CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6968910E62E;
	Wed,  7 Oct 2026 16:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="tnQplAXm";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8558810E62E
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 16:39:36 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=eRnpcjNC87JUgc4ntFV8wX1zk+0mhQpCHSIVo+orZIQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791391174; v=1; x=1791995974;
 b=tnQplAXm+DUcB2pqVegxG5XeRJv6dHVEPnpUusHUuxD8z2xooxVqsSnZCivmqS6EPAPC2B/+
 1DJEXapTTAxhc/E66phNIaRhbBrqn6vmt3lVxLTqCZLY1zKq5od08EMC4DqquZH25K9O4cpAlU0
 SaLqp79hV+heJ0sYPFjhdKxU=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id e17154cc886362ab;
 Wed, 07 Oct 2026 16:39:34 +0000
X-Mizu-Trace-ID: e17154cc886362ab
X-Migadu-Flow: FLOW_OUT
Message-ID: <f6790e78-8432-4bab-8363-501a2fb9783d@linux.dev>
Date: Wed, 7 Oct 2026 18:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] soundwire: amd: Add BRA/BPT firmware download
 support
To: Syed Saba Kareem <syed.sabakareem@amd.com>, vkoul@kernel.org
Cc: broonie@kernel.org, Sunil-kumar.Dommati@amd.com,
 vijendar.mukunda@amd.com, Mario.Limonciello@amd.com,
 venkataprasad.potturu@amd.com, yung-chuan.liao@linux.intel.com,
 anson.tsao@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Trimmer <simont@opensource.cirrus.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "open list:SOUNDWIRE SUBSYSTEM" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
 <sound-open-firmware@alsa-project.org>,
 "open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <linux-media@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <dri-devel@lists.freedesktop.org>, moderated "list:DMA" BUFFER SHARING
 "FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <linaro-mm-sig@lists.linaro.org>
References: <20261005091620.1390916-1-syed.sabakareem@amd.com>
 <20261005091620.1390916-5-syed.sabakareem@amd.com>
 <b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev>
 <87dff7bd-fa1d-4153-8dd1-75947a25a466@amd.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <87dff7bd-fa1d-4153-8dd1-75947a25a466@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


>> general comment: this patch is quite complex, with code needed for the
>> BTP side as well as the DMA side, only interleaved. Is there a way to
>> have a 'cleaner' split between DMA functionality on the ACP side and BPT
>> on the SoundWire bus side?
>>
>> Likewise the parts dealing with contiguous and non-contiguous parts of
>> the firmware should be handled at a higher level using DMA/BTP support
>> lower-level routines.
> 
> Agreed, I'll restructure this into three layers for v5: ACP BRA /DMA/
> primitives (configure descriptor, arm, poll/wait, disarm, deconfigure)
> with no SoundWire-stream knowledge; SoundWire /BPT/ primitives (open/
> close stream, enable/disable); 
> and a higher-level orchestrator with a dispatcher for the contiguous
> (single-buffer) vs non-contiguous (per-section loop, with the small-
> section sdw_nwrite/nread fallback) cases.

Sounds good.

> One hardware detail I'll preserve and document along the way: the
> SoundWire bank switch is itself the BRA DMA start trigger,and correct
> teardown requires disarming the DMA before the disable-path bank switch. 

That sounds fine, provided that hardware pushes a invalid BPT frame on
the link in the time window between the disarming and bank switch.
Otherwise the peripherals might receive garbage BTP data, no?
> So the orchestrator still sequences an ACP call and a SoundWire call in
> a fixed order — the layering makes each side independently readable and
> testable while keeping that ordering contract explicit.
> 
>>> +static int amd_sdw_execute_bra_transfer(struct amd_sdw_manager *amd_manager,
>>> +					struct sdw_slave *slave,
>>> +					bool *dma_unsafe)
>>> +{
>>> +	struct sdw_bus *bus = &amd_manager->bus;
>>> +	u32 i2s_err_offset;
>>> +	u32 saved_intr_mask;
>>> +	u32 reg_addr, len;
>>> +	u32 val;
>>> +	int ret, ret_disable;
>>> +
>>> +	/* Read descriptor regs before enabling the DMA engine. */
>>> +	reg_addr = readl(amd_manager->mmio + ACP_SW_BPT_PORT_FIRST_BYTE_ADDR);
>>> +	len = readl(amd_manager->mmio + ACP_SW_BRA_TRANSFER_SIZE);
>>> +
>>> +	i2s_err_offset = (amd_manager->instance == 0) ?
>>> +			 ACP_SW_I2S_ERROR_REASON : ACP_P1_SW_I2S_ERROR_REASON;
>>> +
>>> +	/*
>>> +	 * Save and disable the error interrupt mask for manual error
>>> +	 * checking.  acp_bra_lock is held across the whole BPT sequence by
>>> +	 * amd_sdw_bpt_wait(), which serialises this shared-register
>>> +	 * read-modify-write against the other manager instance.
>>> +	 */
>>> +	saved_intr_mask = readl(amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>>> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>>> +	writel(0, amd_manager->acp_mmio + i2s_err_offset);
>>> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_REASON1);
>>> +
>>> +	/* Arm the ACP BPT DMA engine */
>>> +	writel(1, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
>>> +
>>> +	/*
>>> +	 * Use the framework's sdw_enable_stream() to write CHANNELEN and
>>> +	 * perform a bank switch.  The ACP BPT hardware uses the bank switch
>>> +	 * as the trigger to start the DMA transfer.  The framework manages
>> do you mean to say
>> a) the DMA transfer was armed and started ealier, and the bank switch
>> unblocks it, ob
>> b) the DMA starts fetching data from memory when the bank switch happens?
>>
>> the latter case would be quite racy and dependent on the time needed to
>> access memory..
> It's (a). The BRA descriptor (BASE_ADDRESS/TRANSFER_SIZE/FRAME_FORMAT)
> is fully programmed in amd_sdw_config_bra_descriptor(), 
> and the engine is armed with ACP_SW_BPT_PORT_EN=1, both before
> sdw_enable_stream(). 
> The bank switch is only the trigger for the already-armed engine — it
> doesn't start a cold engine, so there's no memory-latency race on the
> switch. 

ok

> Once triggered the engine runs autonomously frame by frame, and any
> stall/underrun surfaces as a BRA/I2S error (ACP_SW_I2S_ERROR_REASON /
> ACP_SW_BRA_RESP), not silent corruption. 

but then if I follow your explanations above, if you stop the DMA first
don't you get a systematic xrun error before the bank switch happens?
> This is also why, on an aborted or timed-out transfer, the teardown
> clears PORT_EN before the sdw_disable_stream() bank switch — otherwise
> that switch 
> could re-trigger the armed engine into a buffer we're about to free. 
> I'll reword the comment to say the engine is armed here and the bank
> switch only triggers it.

ok

[...]

>>> +	/*
>>> +	 * The ATU GRP_1 and scratch PTE registers programmed here are
>>> +	 * ACP-global and shared by both SoundWire manager instances, as is the
>>> +	 * BRA DMA engine that reads through them.  bpt_lock is per-manager and
>>> +	 * does not serialise across instances, so hold the ACP-wide
>>> +	 * acp_bra_lock across the whole configure -> transfer -> deconfigure
>>> +	 * sequence to stop the other instance reprogramming the shared PTEs
>>> +	 * mid-transfer.
>> In that case, what is the point of having a per-instance btp_lock as well?
>>
>> It seems from the comment that only *one* BTP transfer can take place
>> across all manager instances, which defeats the purpose of a
>> per-instance lock, no?
>> What I am missing?
> 
> You're right that the transfer itself is serialized ACP-wide: that's
> acp_bra_lock, held only across configure → transfer → deconfigure,
> because the ATU PTEs and
>  the BRA DMA engine are single resources shared by both links. bpt_lock
> is per-link and has a different scope rather than a different transfer
> window:
> 
>   * It guards bpt_disabled, which is per-link suspend/clock-stop/
>     runtime-PM state — each link's amd_suspend()/clock-stop 
>     sets it and amd_resume_runtime() clears it under bpt_lock. A per-
>     link flag doesn't belong under an ACP-global lock.
>   * It serializes multiple BPT requests to the same link and lets that
>     link's suspend path drain an in-flight transfer, without reaching
>     for the global lock.
>   * It keeps acp_bra_lock's hold time minimal: the per-link setup/
>     teardown (open_stream, dma_alloc, the PM get/put, the bpt_disabled
>     check) runs 
>     under bpt_lock but outside acp_bra_lock, so the other link contends
>     for the global lock only during the actual shared-hardware window,
>     not the whole sequence.
> 
> Folding everything onto acp_bra_lock would mean the global lock has to
> cover each link's full transfer path including its runtime-PM callbacks,
>  i.e. one link's PM transitions would serialize against the other link's
> transfer — a scope mismatch and a longer global hold time.
>  So the two are intentionally different scopes: bpt_lock = per-link
> lifecycle/PM, acp_bra_lock = ACP-global shared hardware. Today the
> comment only documents acp_bra_lock; I'll expand it to cover both.

The explanation make sense... but I am not fully clear on why you'd need
to protect the BPT state for link-based pm_runtime. Presumably a BPT
transfer would happen with a device reference held to prevent it from
suspending? Something's not right if you need to drain a BPT transfer in
a pm_runtime suspend, that suspend shouldn't happen in the first place...


