Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356D0C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:07:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FDF10E554;
	Wed,  9 Sep 2026 13:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hJUuRZ8g";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C507510E554
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:07:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3C9060211;
 Wed,  9 Sep 2026 13:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199CC1F00A3A;
 Wed,  9 Sep 2026 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788959262;
 bh=88AYofoa4+1WZWz2yVSnBoAZLxWjWIUQG8AOQZyHr60=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hJUuRZ8gB+EIV1q2DdYH+tmYnilf5hYyi3hbtF1A75jD9YBKo4ljMP/E5v50fPc3p
 17NPln1C7O9+YQOnR7Nc51SnCz6273l/hoEHuNrbLMv3xo+THUTBWZ035uAAOtaq6Z
 w3sBZ2NGX3dDYLny/WYiQ6rnX0vqL6r7pQYm+THw9N1FcPmLUSEchYJEnSFFcbZ8Rk
 huVd2Rdvu87ngcXqNNRz4VIhDzdF7SqyJOzp435IoM33JsIjjgv42Un9J3XKZeucaZ
 aMGfhkQyGWBQNsTd3FdpMAqg/xiLz3HwLPRBU/Jiagx9am5wevJR9qITzU/71vMjRL
 RZWSoomcyn1OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] soundwire: amd: Add BRA/BPT firmware download support
To: "Syed Saba Kareem" <syed.sabakareem@amd.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, bpf@vger.kernel.org
In-Reply-To: <20260909125605.280973-5-syed.sabakareem@amd.com>
References: <20260909125605.280973-1-syed.sabakareem@amd.com>
 <20260909125605.280973-5-syed.sabakareem@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:07:41 +0000
Message-Id: <20260909130742.199CC1F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Releasing `acp_bra_lock` when the DMA engine is wedged allows =
concurrent instances to hijack shared ATU PTEs, defeating the memory leak m=
itigation and causing severe memory corruption.
- [High] False timeout in the BRA DMA busy poll loop due to potential threa=
d preemption.
- [High] Invalid SampleInterval calculation for `col_width =3D=3D 1` bypass=
es mandatory divisibility checks, violating the SoundWire specification.
--

commit de234f818a1a7580df842fe4d73d149a4880c7ba
Author: Syed Saba Kareem <Syed.SabaKareem@amd.com>

soundwire: amd: Add BRA/BPT firmware download support

This commit adds Bulk Register Access (BRA) and Bulk Payload Transport (BPT)
support for AMD SoundWire platforms to enable high-speed firmware downloads
to peripherals. It uses the SoundWire stream framework for DP0 programming
and includes an ATU mapping for scatter-gather DMA.

> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_mana=
ger.c
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c

[ ... ]

> +static u32 amd_sdw_bra_sample_interval(u32 nr, u32 nc, u8 hstart, u8 hst=
op)
> +{
> +	u8 col_width =3D hstop - hstart + 1;
> +	u32 block_count;
> +
> +	if (col_width >=3D 8)
> +		return nc;		/* BlockCount =3D 1 */
> +	if (col_width =3D=3D 1)
> +		return nc * 8;

[Severity: High]
Does this early return bypass the row divisibility requirements for the
SoundWire port?

The SoundWire specification generally requires the number of rows in a frame
(nr) to be an integer multiple of the BlockCount. In a standard 125x2 frame
shape (nr =3D 125, nc =3D 2), this logic would return a SampleInterval that
implies a BlockCount of 8. Since 125 is not divisible by 8, this produces a
fractional block arrangement.

[ ... ]

> +static int amd_sdw_execute_bra_transfer(struct amd_sdw_manager *amd_mana=
ger,
> +					struct sdw_slave *slave,
> +					bool *dma_unsafe)
> +{

[ ... ]

> +	/* Poll DMA_BUSY until transfer completes */
> +	{
> +		unsigned long timeout;
> +
> +		timeout =3D jiffies + msecs_to_jiffies(BRA_DMA_TIMEOUT_MS);
> +		do {
> +			val =3D readl(amd_manager->mmio + ACP_SW_BRA_DMA_BUSY);
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
> +				dev_err(amd_manager->dev,
> +					"BPT: DMA timeout: periph=3D0x%08x len=3D%u EN_STATUS=3D0x%x RESP=
=3D0x%x I2S_ERR=3D0x%08x\n",

[Severity: High]
Could this cause a false timeout if the thread is preempted?

If the thread is preempted immediately after reading the busy status into
val, and the preemption lasts longer than the timeout, the DMA transfer
might complete successfully in the background.

When the thread resumes, time_after() evaluates to true, and the loop aborts
without re-evaluating the DMA status. A final read of the status register
after the timeout check usually prevents this race.

[ ... ]

> +static int amd_sdw_bpt_wait(struct sdw_bus *bus,
> +			    struct sdw_slave *slave,
> +			    struct sdw_bpt_msg *msg)
> +{

[ ... ]

> +deconfigure_pte:
> +	if (dma_unsafe) {
> +		/*
> +		 * PORT_EN_STATUS never cleared: the ACP BPT DMA engine did not
> +		 * confirm it stopped and may still be bus-mastering through the
> +		 * ATU into dma_buf.  PORT_EN=3D0 is the only stop control the
> +		 * hardware exposes -- the audio DMA path relies on the same
> +		 * enable-clear-then-poll-status primitive -- so there is no
> +		 * stronger barrier to force it off here.  Leave the ATU PTEs
> +		 * pointing at dma_buf and do NOT free the buffer: returning
> +		 * these pages to the allocator while a wedged engine can still
> +		 * write would corrupt memory reused for another purpose.
> +		 * Deliberately leak the buffer instead -- the only memory-safe
> +		 * option, matching the guarantee the managed-buffer audio path
> +		 * gets from the PCM core (buffer never reused while the engine
> +		 * may be active).
> +		 */
> +		dev_err(amd_manager->dev,
> +			"BPT: engine did not quiesce; leaking %zu bytes to avoid corruption\n=
",
> +			total_len);
> +		mutex_unlock(amd_manager->acp_bra_lock);
> +		goto close_stream;
> +	}

[Severity: Critical]
Does releasing the acp_bra_lock here allow a concurrent instance to hijack
the shared ATU PTEs?

The code intentionally leaks the DMA buffer to mitigate corruption from a
wedged DMA engine. However, since the ATU PTE registers are ACP-global and
shared between instances (protected by acp_bra_lock), dropping this lock
allows a concurrent BPT transfer on another manager instance to call
amd_sdw_bra_configure_pte() and reprogram the global PTEs.

If the first instance's wedged bus-mastering engine is still active, it
might follow the newly programmed PTEs and overwrite the new transfer's
buffer or other memory, defeating the mitigation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909125605.2809=
73-1-syed.sabakareem@amd.com?part=3D4
