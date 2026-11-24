Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EE606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTujfiTy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0614D10E855;
	Tue, 24 Nov 2026 12:22:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB0A10E855
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:22:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 45F4443967;
 Tue, 24 Nov 2026 12:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DE61F000D8;
 Tue, 24 Nov 2026 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795522924;
 bh=6RWEltw+KBsAefU66UGVQdsZI4qoc+M7z+Bs4+vNeNE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QTujfiTy2AZiYgSTSR8WTPKFIsXvYqo3HgMOc9TwgSMfBOQMfk0uExeUglKpzGmfm
 lepQ8ni4BX3OeOKVmXQyHs4N9X/CVEgcK1gLdFLdvbBpYNzwF/gG7+ZNPfmnD0lYbO
 WQOMmFe6P3W+gbd07AjvKk0jFK8asT1NfLTLh/3u3B46Z6SM+ofKvW7xfI/YcrASRY
 ZCqnSMJ/WYTr3KXJbkDTmRHwYt2k6TUuP0EX0dGkCkB9F9ZKtgGsYGsIcm+TM8jwkg
 jOGeGm3zF8yixk86276HTCpSic9GMYuX0JJ2Zl/rNpyjXzxN0HxhRdNaLqZzJDo3iI
 KVeFjRJZyGn+w==
Message-ID: <sashiko-outbox-231126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] drm/bridge: trilinear: add the DPTX hardware layer
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124120114.3273161-3-Luo.Liu@cixtech.com>
References: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
 <20261124120114.3273161-3-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:22:03 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/bridge: trilinear: unmasked interrupt cause dispatch in
  dptx_hw_irq()
- [Medium] drm/bridge: trilinear: stale enhanced framing state in
  dptx_hw_link_setup()
- [Low] drm/bridge: trilinear: open-coded drm_dp_vsc_sdp_supported() in
  sink caps
--

commit 4fa26124ea587953f5e3c4b3e14b850c7ab4e1d9
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: trilinear: add the DPTX hardware layer

This commit adds the DisplayPort transmitter hardware layer for the
Trilinear bridge driver, covering PHY and clock control, AUX transfers,
DPCD capability parsing, link training, and SST stream configuration.

> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_hw.c b/drivers/gpu/drm=
/bridge/trilinear/dptx_hw.c
> new file mode 100644
> index 0000000000000..6f3011ab65413
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_hw.c

[ ... ]

> +static void dptx_hw_link_setup(struct dp_hw *hw, u8 lane_cnt,
> +			       bool enhanced, bool downspread)
> +{
> +	dptx_hw_write(hw, DPTX_LANE_COUNT_SET, lane_cnt);
> +
> +	if (enhanced)
> +		dptx_hw_write(hw, DPTX_ENHANCED_FRAMING_ENABLE, 1);
> +
> +	dptx_hw_write(hw, DPTX_DOWNSPREAD_CONTROL, downspread);
> +}

[Severity: Medium]
Should DPTX_ENHANCED_FRAMING_ENABLE be written unconditionally with
enhanced?  When enhanced is false, dptx_hw_link_configure() clears
DP_LANE_COUNT_ENHANCED_FRAME_EN in the sink's DP_LANE_COUNT_SET register,
so leaving DPTX_ENHANCED_FRAMING_ENABLE set from a previously connected
sink causes a framing mismatch between the transmitter and the sink.

[ ... ]

> +static int dptx_hw_dpcd_sink_caps(struct dp_hw *hw)
> +{
> +	u8 value =3D 0;
> +	int ret;
> +
> +	memset(&hw->caps, 0, sizeof(hw->caps));
> +
> +	ret =3D drm_dp_read_dpcd_caps(&hw->aux, hw->dpcd);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D drm_dp_read_downstream_info(&hw->aux, hw->dpcd,
> +					  hw->downstream_ports);
> +	if (ret)
> +		return ret;
> +
> +	hw->caps.enhanced_framing =3D drm_dp_enhanced_frame_cap(hw->dpcd);
> +	hw->caps.tps3_supported =3D drm_dp_tps3_supported(hw->dpcd);
> +	hw->caps.tps4_supported =3D drm_dp_tps4_supported(hw->dpcd);
> +
> +	/*
> +	 * DP_DPRX_FEATURE_ENUMERATION_LIST is DP 1.3+. A NACK here just means
> +	 * an older sink, so degrade to "unsupported" instead of failing.
> +	 */
> +	if (hw->dpcd[DP_DPCD_REV] >=3D DP_DPCD_REV_13 &&
> +	    drm_dp_dpcd_readb(&hw->aux, DP_DPRX_FEATURE_ENUMERATION_LIST,
> +			      &value) =3D=3D 1)
> +		hw->caps.vsc_supported =3D
> +			!!(value & DP_VSC_SDP_EXT_FOR_COLORIMETRY_SUPPORTED);

[Severity: Low]
This isn't a bug, but drm_dp_vsc_sdp_supported(&hw->aux, hw->dpcd) already
performs this exact check and can be used here instead of open-coding it.

[ ... ]

> +static irqreturn_t dptx_hw_irq(struct dp_hw *hw)
> +{
> +	u32 value;
> +	u32 mask;
> +
> +	value =3D dptx_hw_read(hw, DPTX_INTERRUPT_CAUSE);
> +	mask =3D dptx_hw_read(hw, DPTX_INTERRUPT_MASK);
> +	if (!(value & ~mask))
> +		return IRQ_NONE;
> +
> +	if (value & DPTX_INTERRUPT_GP_TIMER_IRQ)
> +		dev_dbg_ratelimited(hw->dev, "gp tmr\n");
> +
> +	if (value & DPTX_INTERRUPT_REPLY_TIMEOUT)
> +		dev_dbg_ratelimited(hw->dev, "reply timeout\n");
> +
> +	if (value & DPTX_INTERRUPT_REPLY_RECEIVED)
> +		dev_dbg_ratelimited(hw->dev, "reply received\n");
> +
> +	if (value & DPTX_INTERRUPT_HPD_EVENT)
> +		hw->hpd_event_callback(hw->data);
> +
> +	if (value & DPTX_INTERRUPT_HPD_IRQ)
> +		hw->hpd_irq_callback(hw->data);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
Should value be masked with ~mask before testing individual interrupt
cause bits?  Because dptx_hw_aux_submit() polls DPTX_AUX_STATUS without
reading DPTX_INTERRUPT_CAUSE, masked bits such as
DPTX_INTERRUPT_REPLY_RECEIVED remain latched in DPTX_INTERRUPT_CAUSE and
will be evaluated whenever an unmasked HPD interrupt fires.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124120114.3273=
161-1-Luo.Liu@cixtech.com?part=3D2
