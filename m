Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00659CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4541F10E15C;
	Tue, 29 Sep 2026 12:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cHt1pzL9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 881EC10E15C
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:07:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12F17436F7;
 Tue, 29 Sep 2026 12:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29B21F000FF;
 Tue, 29 Sep 2026 12:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790683661;
 bh=scf9Z1J8B6Uf2UdJXsYH3+S99fXPDQY6/0LPRydspeQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cHt1pzL9dMBh1v1WCsjY801E4ZpjgbafRAZ2UTCFawpCHZUpcazZedfOvZZEuAkKo
 pq6YXQ7speNvXaMoOlwSnGUa++AlmyAbiJSngoXOleZjjlS9P29MCvF8v9zqT3KQpR
 f8CDU8H7WshM6kKto722Yl2pX1vH2SYtmFLam6AYyN+G58V9j6lGXfeYHMKnAw9Xvv
 0aA6GzAz9PZcG9ZHIuqbWVW81UqPMrj1CBe50RdIJq0ZSpI0h/ymWXXcvxj/hHZChD
 5WYedNEWaj5LKSJZBo+ETxgdRKtpSCOAIov/xGtmEhbyhLKEzgnYQ4zxM5u49oEcnr
 gYYQ8ddn5dvOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] soundwire: amd: Add BRA/BPT firmware download
 support
To: "Syed Saba Kareem" <syed.sabakareem@amd.com>
Cc: bpf@vger.kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260929115052.247086-5-syed.sabakareem@amd.com>
References: <20260929115052.247086-1-syed.sabakareem@amd.com>
 <20260929115052.247086-5-syed.sabakareem@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 12:07:40 +0000
Message-Id: <20260929120740.B29B21F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] soundwire: amd: deconfiguring wedged BRA descriptor redirects =
active DMA to physical address 0
- [High] soundwire: amd: master port 0 aliasing silences concurrent audio s=
treams during BPT
- [High] soundwire: amd: global acp_bra_wedged flag breaks independent Soun=
dWire controllers
- [Medium] soundwire: amd: integer overflow in total_len causes heap buffer=
 overflow
--

commit 10078bc80a59ffcc131913ae41fbb4706ce8f69f
Author: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Subject: soundwire: amd: Add BRA/BPT firmware download support

This commit adds Bulk Register Access (BRA) and Bulk Payload Transport
(BPT) support for AMD SoundWire platforms. It uses the SoundWire stream
framework for programming the DP0 port and relies on the ACP BRA DMA
engine for transferring large firmware segments.

> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_mana=
ger.c
> index a3316efdf8ac2..f5b4096c83ac3 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> [ ... ]
> @@ -713,6 +764,13 @@ static int amd_sdw_port_params(struct sdw_bus *bus, =
struct sdw_port_params *p_pa
>  	struct amd_sdw_manager *amd_manager =3D to_amd_sdw(bus);
>  	u32 frame_fmt_reg, dpn_frame_fmt;
> =20
> +	/*
> +	 * BPT uses dedicated ACP BRA descriptor registers; ignore DP0 ops only.
> +	 * Allow DPn audio port ops to proceed even while BPT is active.
> +	 */
> +	if (READ_ONCE(bus->bpt_stream) && p_params->num =3D=3D 0)
> +		return 0;
> +

[Severity: High]
By checking p_params->num =3D=3D 0 when bus->bpt_stream is active, won't th=
is
skip hardware programming for any concurrent audio stream using CPU DAI 0
(which also maps to master port 0)? Because the callback cannot distinguish
between the concurrent audio stream's port 0 and the BPT stream's port 0,
does this leave the audio stream unconfigured in the hardware?

> [ ... ]
> @@ -764,6 +843,13 @@ static int amd_sdw_transport_params(struct sdw_bus *=
bus,
>  	u32 frame_fmt_reg, sample_int_reg, hctrl_dp0_reg;
>  	u32 offset_reg, lane_ctrl_ch_en_reg;
> =20
> +	/*
> +	 * BPT uses dedicated ACP BRA descriptor registers; ignore DP0 ops only.
> +	 * Allow DPn audio port ops to proceed even while BPT is active.
> +	 */
> +	if (READ_ONCE(bus->bpt_stream) && params->port_num =3D=3D 0)
> +		return 0;
> +

[Severity: High]
Similarly, does skipping the transport parameters leave concurrent audio
streams on port 0 in a broken hardware state?

> [ ... ]
> @@ -887,6 +953,1062 @@ static int amd_sdw_port_enable(struct sdw_bus *bus,
> +/*
> + * Latched when a BRA transfer leaves the ACP DMA engine wedged: it fail=
ed to
> + * confirm it stopped and may still be bus-mastering through the ACP-glo=
bal ATU
> + * PTEs. Once set, amd_sdw_bra_configure_pte() refuses to reprogram thos=
e shared
> + * PTEs, so a still-active engine on one manager instance cannot be redi=
rected
> + * into another instance's buffer. Written and read only under acp_bra_l=
ock and
> + * never cleared: recovering the engine requires a device reset / driver=
 reload.
> + */
> +static bool acp_bra_wedged;
> +
> +static u32 amd_sdw_bra_configure_pte(struct amd_sdw_manager *amd_manager,
> +				     dma_addr_t dma_addr, size_t size)
> +{
> [ ... ]
> +
> +	if (acp_bra_wedged) {
> +		dev_err(amd_manager->dev,
> +			"BRA engine previously wedged; refusing to reprogram shared ATU PTEs\=
n");
> +		return 0;
> +	}

[Severity: High]
Since acp_bra_wedged is declared as a static module-level global variable,
won't a failure in one SoundWire controller permanently disable firmware
downloads on all other independent controllers in the system? Should this
state be scoped to the shared ACP hardware context (for example, inside
acp_dev_data or sdw_amd_res) so that physically distinct ACP PCI devices
like an APU and a discrete GPU do not share this wedged state?

> [ ... ]
> +static void amd_sdw_deconfig_bra_descriptor(struct amd_sdw_manager *amd_=
manager)
> +{
> [ ... ]
> +	writel(0, amd_manager->mmio + ACP_SW_BRA_BASE_ADDRESS);
> +	writel(0, amd_manager->mmio + ACP_SW_BRA_TRANSFER_SIZE);
> +}
> [ ... ]
> +static int amd_sdw_bra_transfer(struct amd_sdw_manager *amd_manager,
> +				struct sdw_slave *slave, u32 reg_addr,
> +				u32 acp_base_addr, size_t len, bool write,
> +				bool *dma_unsafe)
> +{
> [ ... ]
> +	ret =3D amd_sdw_execute_bra_transfer(amd_manager, slave, dma_unsafe);
> +	amd_sdw_deconfig_bra_descriptor(amd_manager);
> +
> +	return ret;
> +}

[Severity: Critical]
If amd_sdw_execute_bra_transfer() sets dma_unsafe to true, this signals
that the DMA engine failed to quiesce and is still actively bus-mastering.
Because amd_sdw_deconfig_bra_descriptor() is called unconditionally, it
writes 0 to ACP_SW_BRA_BASE_ADDRESS. Won't altering the base address
mid-flight redirect the ongoing DMA writes to physical address 0x0,
bypassing the ATU safe leak buffer and causing memory corruption?

> [ ... ]
> +static int amd_sdw_bpt_send_async(struct sdw_bus *bus,
> +				  struct sdw_slave *slave,
> +				  struct sdw_bpt_msg *msg)
> +{
> +	struct amd_sdw_manager *amd_manager =3D to_amd_sdw(bus);
> +	size_t total_len =3D 0;
> +	int i;
> +
> +	for (i =3D 0; i < msg->sections; i++)
> +		total_len +=3D msg->sec[i].len;
> +
> [ ... ]
> +static int amd_sdw_bpt_wait(struct sdw_bus *bus,
> +			    struct sdw_slave *slave,
> +			    struct sdw_bpt_msg *msg)
> +{
> [ ... ]
> +	size_t total_len =3D 0;
> +	int ret =3D 0;
> +	int i;
> +	bool dma_unsafe =3D false;
> +
> +	for (i =3D 0; i < msg->sections; i++)
> +		total_len +=3D msg->sec[i].len;

[Severity: Medium]
Could total_len (a 32-bit size_t on 32-bit architectures) integer-overflow
here? If a multi-section firmware payload specifies lengths that sum past
4GB, total_len would wrap to a small value, bypassing the
SDW_BPT_MSG_MAX_BYTES validation limit.

> [ ... ]
> +	/* For writes, copy all section data into the DMA buffer */
> +	if (is_write) {
> +		for (i =3D 0; i < msg->sections; i++) {
> +			memcpy(dma_buf + offset, msg->sec[i].buf, msg->sec[i].len);
> +			offset +=3D msg->sec[i].len;
> +		}
> +	}

[Severity: Medium]
If the validation is bypassed due to the wrap-around, dma_buf is allocated
with the wrapped, small total_len. Will this memcpy() using the original,
un-wrapped msg->sec[i].len cause a heap buffer overflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929115052.2470=
86-2-syed.sabakareem@amd.com?part=3D4
