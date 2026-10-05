Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0995ACA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F42910E168;
	Mon,  5 Oct 2026 12:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="mA1o2DKB";
	dkim-atps=neutral
X-Greylist: delayed 301 seconds by postgrey-1.36 at gabe;
 Mon, 05 Oct 2026 12:11:50 UTC
Received: from mta0.migadu.com (out-244.mta0.migadu.com [91.218.175.244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CA210E168
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 12:11:49 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=acbEeQhquoGSRxYyHz2eRogK/T8TZ+zuOZdfsYzddOE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791202308; v=1; x=1791807108;
 b=mA1o2DKBwafz4GYI5R3aiDRaEaaDC+/HpHhMpx+2/P323S1pjyMEUc9PfrHQiKQk9vjHlSL+
 vrJODzKqMSdxiUx5ioLazNWYT7dHPOYuVu+lZultEqHQDRJz09sAB+xJi8SN8/+1DCQQSRdEZqh
 5NWgdSwadM8iHOGYNpaHAwO8=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 12c376e05a24411f;
 Mon, 05 Oct 2026 12:05:43 +0000
X-Mizu-Trace-ID: 12c376e05a24411f
X-Migadu-Flow: FLOW_OUT
Message-ID: <b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev>
Date: Mon, 5 Oct 2026 14:04:01 +0200
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
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20261005091620.1390916-5-syed.sabakareem@amd.com>
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

general comment: this patch is quite complex, with code needed for the
BTP side as well as the DMA side, only interleaved. Is there a way to
have a 'cleaner' split between DMA functionality on the ACP side and BPT
on the SoundWire bus side?

Likewise the parts dealing with contiguous and non-contiguous parts of
the firmware should be handled at a higher level using DMA/BTP support
lower-level routines.

> +static int amd_sdw_execute_bra_transfer(struct amd_sdw_manager *amd_manager,
> +					struct sdw_slave *slave,
> +					bool *dma_unsafe)
> +{
> +	struct sdw_bus *bus = &amd_manager->bus;
> +	u32 i2s_err_offset;
> +	u32 saved_intr_mask;
> +	u32 reg_addr, len;
> +	u32 val;
> +	int ret, ret_disable;
> +
> +	/* Read descriptor regs before enabling the DMA engine. */
> +	reg_addr = readl(amd_manager->mmio + ACP_SW_BPT_PORT_FIRST_BYTE_ADDR);
> +	len = readl(amd_manager->mmio + ACP_SW_BRA_TRANSFER_SIZE);
> +
> +	i2s_err_offset = (amd_manager->instance == 0) ?
> +			 ACP_SW_I2S_ERROR_REASON : ACP_P1_SW_I2S_ERROR_REASON;
> +
> +	/*
> +	 * Save and disable the error interrupt mask for manual error
> +	 * checking.  acp_bra_lock is held across the whole BPT sequence by
> +	 * amd_sdw_bpt_wait(), which serialises this shared-register
> +	 * read-modify-write against the other manager instance.
> +	 */
> +	saved_intr_mask = readl(amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
> +	writel(0, amd_manager->acp_mmio + i2s_err_offset);
> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_REASON1);
> +
> +	/* Arm the ACP BPT DMA engine */
> +	writel(1, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
> +
> +	/*
> +	 * Use the framework's sdw_enable_stream() to write CHANNELEN and
> +	 * perform a bank switch.  The ACP BPT hardware uses the bank switch
> +	 * as the trigger to start the DMA transfer.  The framework manages

do you mean to say
a) the DMA transfer was armed and started ealier, and the bank switch
unblocks it, ob
b) the DMA starts fetching data from memory when the bank switch happens?

the latter case would be quite racy and dependent on the time needed to
access memory..

> +	 * bank state consistently, eliminating the need for a manual bank
> +	 * switch or DP0 bank mirror.
> +	 */
> +	dev_dbg(amd_manager->dev,
> +		"BPT: pre-enable: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n",
> +		bus->params.curr_bank, bus->params.next_bank,
> +		readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
> +		bus->bpt_stream->state);
> +
> +	ret = sdw_enable_stream(bus->bpt_stream);
> +	if (ret < 0) {
> +		dev_err(amd_manager->dev,
> +			"BPT: sdw_enable_stream failed: %d\n", ret);
> +		/*
> +		 * Disarm the engine and wait for the port to quiesce before
> +		 * returning: the caller (amd_sdw_bra_transfer()) then deconfigures
> +		 * the BRA descriptor unconditionally, zeroing BASE_ADDRESS and
> +		 * TRANSFER_SIZE, so the port must be idle first -- mirrors the
> +		 * disable path below.
> +		 */
> +		writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
> +		ret_disable = readl_poll_timeout(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS,
> +						 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
> +		if (ret_disable < 0) {
> +			dev_err(amd_manager->dev, "BPT: PORT_EN disable timeout\n");
> +			*dma_unsafe = true;
> +		}
> +		goto restore_intr;
> +	}
> +
> +	dev_dbg(amd_manager->dev,
> +		"BPT: DMA started: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n",
> +		bus->params.curr_bank, bus->params.next_bank,
> +		readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
> +		bus->bpt_stream->state);
> +
> +	/* Poll DMA_BUSY until transfer completes */
> +	{
> +		unsigned long timeout;
> +
> +		timeout = jiffies + msecs_to_jiffies(BRA_DMA_TIMEOUT_MS);
> +		do {
> +			val = readl(amd_manager->mmio + ACP_SW_BRA_DMA_BUSY);
> +			/*
> +			 * Side-effectful read: reading ACP_SW_BRA_CURRENT_TRANSFER_SIZE
> +			 * advances the BRA DMA engine to the next frame.  The value is
> +			 * intentionally discarded (hence the (void) cast); removing this
> +			 * read stalls multi-frame transfers, which then time out.
> +			 */
> +			(void)readl(amd_manager->mmio + ACP_SW_BRA_CURRENT_TRANSFER_SIZE);
> +			if (!(val & 0x01))
> +				break;
> +			if (time_after(jiffies, timeout)) {
> +				/*
> +				 * Re-sample the busy bit before declaring a
> +				 * timeout. cond_resched() below can park this
> +				 * thread for longer than BRA_DMA_TIMEOUT_MS, in
> +				 * which window the DMA may have completed; without
> +				 * this final read a finished transfer would be
> +				 * reported as a false timeout.
> +				 */
> +				val = readl(amd_manager->mmio + ACP_SW_BRA_DMA_BUSY);
> +				if (!(val & 0x01))
> +					break;
> +				dev_err(amd_manager->dev,
> +					"BPT: DMA timeout: periph=0x%08x len=%u EN_STATUS=0x%x RESP=0x%x I2S_ERR=0x%08x\n",
> +					reg_addr, len,
> +					readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
> +					readl(amd_manager->mmio + ACP_SW_BRA_RESP),
> +					readl(amd_manager->acp_mmio + i2s_err_offset));
> +				ret = -ETIMEDOUT;
> +				break;
> +			}
> +			/*
> +			 * Runs in process context. Yield the CPU so a
> +			 * multi-frame transfer cannot busy-spin for up to
> +			 * BRA_DMA_TIMEOUT_MS and trip the soft lockup
> +			 * watchdog on non-preemptible kernels. cond_resched()
> +			 * keeps the poll cadence tight -- reading
> +			 * ACP_SW_BRA_CURRENT_TRANSFER_SIZE every iteration is
> +			 * required to advance the DMA engine between frames,
> +			 * so usleep_range() (which would space out the reads)
> +			 * is deliberately not used here.
> +			 */
> +			cond_resched();
> +		} while (1);
> +	}
> +
> +	/* Check for I2S/BRA errors */
> +	val = readl(amd_manager->acp_mmio + i2s_err_offset);
> +	if (val & AMD_SDW_BRA_I2S_ERROR_MASK) {
> +		dev_err(amd_manager->dev,
> +			"BPT: BRA failed I2S_ERROR_REASON=0x%08x (NAK=%u Clash=%u HdrResp=%u FtrResp=%u CRC=%u DMA=%u Cmd=%u)\n",
> +			val,
> +			!!(val & BIT(18)), !!(val & BIT(19)),
> +			!!(val & BIT(26)), !!(val & BIT(27)),
> +			!!(val & BIT(28)), !!(val & BIT(29)), !!(val & BIT(30)));
> +		writel(0, amd_manager->acp_mmio + i2s_err_offset);
> +		if (!ret)
> +			ret = -EIO;
> +	} else if (!ret) {
> +		dev_dbg(amd_manager->dev,
> +			"BPT: DMA done: periph=0x%08x len=%u\n", reg_addr, len);
> +	}
> +
> +	/*
> +	 * On an aborted or timed-out transfer the ACP BPT DMA engine can still
> +	 * be armed (PORT_EN=1, DMA_BUSY=1). sdw_disable_stream() below performs
> +	 * a bank switch, which is the BPT DMA start trigger, so disarm the engine
> +	 * first -- otherwise the bank switch could (re)start a DMA write into
> +	 * dma_buf, which amd_sdw_bpt_wait() frees as soon as this transfer
> +	 * returns. On the success path the DMA has already completed, so this
> +	 * early clear is a no-op.
> +	 */
> +	if (ret < 0)
> +		writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
> +
> +	/*
> +	 * Disable the stream via framework (writes CHANNELEN=0 + bank switch).
> +	 * This cleanly stops the port and keeps bank state consistent.
> +	 * Propagate a disable failure: it leaves the stream in
> +	 * SDW_STREAM_ENABLED, and sdw_enable_stream() returns 0 early for an
> +	 * already-ENABLED stream without the bank switch that triggers the BRA
> +	 * DMA, so the next section would be silently skipped rather than
> +	 * transferred.  Report the failure to the caller so it stops instead of
> +	 * chaining a section whose DMA never starts.
> +	 */
> +	ret_disable = sdw_disable_stream(bus->bpt_stream);
> +	if (ret_disable < 0) {
> +		dev_err(amd_manager->dev, "BPT: sdw_disable_stream failed: %d\n",
> +			ret_disable);
> +		if (!ret)
> +			ret = ret_disable;
> +	}
> +
> +	dev_dbg(amd_manager->dev,
> +		"BPT: post-disable: curr_bank=%u next_bank=%u stream_state=%d\n",
> +		bus->params.curr_bank, bus->params.next_bank,
> +		bus->bpt_stream->state);
> +
> +	/*
> +	 * Disarm the ACP BPT DMA engine and wait for the port to quiesce.
> +	 * Like the manager enable/disable sequence (ACP_SW_EN paired with
> +	 * ACP_SW_EN_STATUS), ACP_SW_BPT_PORT_EN_STATUS reflects the real port
> +	 * state, so polling it here guarantees a non-contiguous transfer's next
> +	 * section cannot re-arm PORT_EN before the current one has torn down.
> +	 */
> +	writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
> +	ret_disable = readl_poll_timeout(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS,
> +					 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
> +	if (ret_disable < 0) {
> +		dev_err(amd_manager->dev, "BPT: PORT_EN disable timeout\n");
> +		if (!ret)
> +			ret = ret_disable;
> +		*dma_unsafe = true;
> +	}
> +	writel(0, amd_manager->acp_mmio + i2s_err_offset);
> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_REASON1);
> +	/*
> +	 * Clearing the immediate-command response-valid status races with the
> +	 * immediate-command path (amd_sdw_send_cmd_get_resp()), which polls and
> +	 * clears the same ACP_SW_IMM_CMD_STS bit under bus->msg_lock. The BPT DMA
> +	 * poll loop above drops all locks, so a concurrent slave enumeration or
> +	 * register access (amd_sdw_work / IRQ thread / codec regmap) can be
> +	 * mid-command here. Take msg_lock so this teardown clear cannot erase a
> +	 * response the command path has not yet consumed, which would make that
> +	 * command time out. This msg_lock nests inside acp_bra_lock and bpt_lock,
> +	 * both already held by the enclosing amd_sdw_bpt_wait(), preserving the
> +	 * bpt_lock -> acp_bra_lock -> msg_lock order. do_bank_switch() inside
> +	 * sdw_enable_stream()/sdw_disable_stream() only takes msg_lock for
> +	 * multi-link managers, so this single-link manager establishes that order
> +	 * via the explicit msg_lock here and in the non-contiguous
> +	 * sdw_nwrite_no_pm()/sdw_nread_no_pm() fallback.
> +	 */
> +	mutex_lock(&bus->msg_lock);
> +	writel(AMD_SDW_IMM_RES_VALID, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
> +	mutex_unlock(&bus->msg_lock);
> +
> +restore_intr:
> +	writel(saved_intr_mask, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
> +	return ret;
> +}

[...]

> +static int amd_sdw_bpt_wait(struct sdw_bus *bus,
> +			    struct sdw_slave *slave,
> +			    struct sdw_bpt_msg *msg)
> +{
> +	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
> +	bool is_write = (msg->flags & SDW_MSG_FLAG_WRITE);
> +	struct amd_bra_params prep_params = {0};
> +	u32 acp_sys_addr;
> +	dma_addr_t dma_addr = 0;
> +	u8 *dma_buf = NULL;
> +	size_t offset = 0;
> +	size_t total_len = 0;
> +	int ret = 0;
> +	int i;
> +	bool dma_unsafe = false;
> +
> +	for (i = 0; i < msg->sections; i++) {
> +		if (msg->sec[i].len > SDW_BPT_MSG_MAX_BYTES - total_len) {
> +			dev_err(amd_manager->dev,
> +				"BPT msg length exceeds maximum %d bytes\n",
> +				SDW_BPT_MSG_MAX_BYTES);
> +			return -EINVAL;
> +		}
> +		total_len += msg->sec[i].len;
> +	}
> +
> +	if (total_len < AMD_BPT_MSG_BYTE_MIN) {
> +		dev_err(amd_manager->dev,
> +			"BPT msg length %zu < minimum %d bytes\n",
> +			total_len, AMD_BPT_MSG_BYTE_MIN);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Take the runtime-PM reference that keeps the bus clock alive before
> +	 * acquiring bpt_lock, not after.  When the manager is runtime
> +	 * suspended, pm_runtime_get_sync() runs amd_resume_runtime()
> +	 * synchronously in this task, and that callback acquires bpt_lock to
> +	 * clear bpt_disabled.  Taking the reference while already holding
> +	 * bpt_lock would therefore deadlock against ourselves.
> +	 */
> +	ret = pm_runtime_get_sync(amd_manager->dev);
> +	/*
> +	 * -EACCES only occurs when runtime PM is disabled, which for this
> +	 * device happens across the system suspend/resume window.  amd_suspend()
> +	 * sets bpt_disabled before the clock is stopped and amd_resume_runtime()
> +	 * clears it only once the clock is back, so the bpt_disabled check below
> +	 * rejects the transfer with -ESHUTDOWN before any BRA access whenever the
> +	 * clock could be down.  A merely runtime-suspended manager (clock stopped,
> +	 * PM still enabled) is resumed by the get above and returns success, not
> +	 * -EACCES; tolerating -EACCES therefore never drives the BRA engine on a
> +	 * stopped clock.
> +	 */
> +	if (ret < 0 && ret != -EACCES) {
> +		pm_runtime_put_noidle(amd_manager->dev);
> +		dev_err(amd_manager->dev, "BPT: pm_runtime_get failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * The ACP BRA engine is a single shared resource.  Serialise all BPT
> +	 * transfers so concurrent slave probes do not race over the hardware.
> +	 */
> +	mutex_lock(&amd_manager->bpt_lock);
> +
> +	/*
> +	 * Refuse the transfer if the bus is being (or has been) clock-stopped
> +	 * for system suspend.  Driving the BRA/command channel while the clock
> +	 * is stopping wedges the channel and leaves the peripheral unable to
> +	 * re-enumerate on resume; the codec retries once it re-attaches.
> +	 */
> +	if (amd_manager->bpt_disabled) {
> +		mutex_unlock(&amd_manager->bpt_lock);
> +		pm_runtime_mark_last_busy(amd_manager->dev);
> +		pm_runtime_put_autosuspend(amd_manager->dev);
> +		return -ESHUTDOWN;
> +	}
> +
> +	/* BRA always uses all available data columns (1..NC-1). */
> +	amd_manager->bra_hstart = 1;
> +	amd_manager->bra_hstop  = bus->params.col - 1;
> +
> +	/*
> +	 * Open the BPT stream so the framework stream state machine tracks the
> +	 * transfer.  Slave DP0 is prepared below before bra_transfer().
> +	 */
> +	ret = amd_sdw_bpt_open_stream(amd_manager, slave, msg);
> +	if (ret < 0)
> +		goto close_stream;
> +
> +	/* Allocate single DMA buffer for entire BPT message */
> +	dma_buf = dma_alloc_coherent(amd_manager->dev->parent, total_len,
> +				     &dma_addr, GFP_KERNEL);
> +	if (!dma_buf) {
> +		ret = -ENOMEM;
> +		goto close_stream;
> +	}
> +
> +	/*
> +	 * The ATU GRP_1 and scratch PTE registers programmed here are
> +	 * ACP-global and shared by both SoundWire manager instances, as is the
> +	 * BRA DMA engine that reads through them.  bpt_lock is per-manager and
> +	 * does not serialise across instances, so hold the ACP-wide
> +	 * acp_bra_lock across the whole configure -> transfer -> deconfigure
> +	 * sequence to stop the other instance reprogramming the shared PTEs
> +	 * mid-transfer.

In that case, what is the point of having a per-instance btp_lock as well?

It seems from the comment that only *one* BTP transfer can take place
across all manager instances, which defeats the purpose of a
per-instance lock, no?
What I am missing?
