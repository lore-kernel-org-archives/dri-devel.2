Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE84CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D3810ECD6;
	Tue, 29 Sep 2026 04:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B9cnj0pv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C775910ECC7
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:50:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8587A42ADB;
 Tue, 29 Sep 2026 04:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AE01F000FF;
 Tue, 29 Sep 2026 04:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657400;
 bh=GOf+m4BIeSRqUv+X1t/puUgci4O5mcKwisr6Uya2Y9c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B9cnj0pvRQGZacqF/Cq+k5et2G1w7I0JwH2HZuMzU1zYsstFNjYZrjeUpSunmEXUc
 gX+nkCHKh4yWGNr8cHBBRgCHXrbys6ogDefoYdblhapCguo73kqw0FUR6Gr7SoxtLx
 1OKdlPhnM8jV7B7j1cz4TrZTWMHhlmnnjeizZts+Dqk0M4Vr5Q5QkguCpeFU1/jNgG
 heKTKKo4U5qED/1W8HABJ/FXfrppaNODSdyVPQcQgmABUjmV6grPjO3Czbk5mjo9Kj
 kI3TjKtjd6mlKTokQ0wlvaFnxpr6uZ72qRZ0FDBW3yWTOTOsulYhMYx3zp8/MWf+cx
 hDJf6cGBGvCDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/35] drm/msm/dp: add support for sending VCPF
 packets in DP controller
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-12-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-12-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:49:59 +0000
Message-Id: <20260929045000.55AE01F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/msm/dp: bitwise OR of STATUS5 and STATUS7 without masking in=
 ISR
--

commit 987123505b6cfcc4664c72feae6b070ad91b79a8
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add support for sending VCPF packets in DP controller

This commit adds support for sending VC Payload Fill (VCPF) sequences in the
MSM DP controller when stream symbols are absent. It introduces interrupt
handling for streams 0-3 using the STATUS5 and STATUS7 registers to signal
VCPF completion.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 9a0c9737e6d00..929e0f94f8ddb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c

[ ... ]

> @@ -379,6 +398,34 @@ static void msm_dp_ctrl_config_psr_interrupt(struct =
msm_dp_ctrl_private *ctrl)
>  	msm_dp_write_ahb(ctrl, REG_DP_INTR_MASK4, DP_INTERRUPT_MASK4);
>  }
> =20
> +static u32 msm_dp_ctrl_get_mst_vcpf_interrupt_0_1(struct msm_dp_ctrl_pri=
vate *ctrl)
> +{
> +	u32 intr, intr_ack;
> +
> +	intr =3D msm_dp_read_ahb(ctrl, REG_DP_INTR_STATUS5);
> +	intr &=3D ~DP_INTERRUPT_STATUS5_MASK;
> +	intr_ack =3D (intr & DP_INTERRUPT_STATUS5)
> +			<< DP_INTERRUPT_STATUS_ACK_SHIFT;
> +	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS5,
> +			 intr_ack | DP_INTERRUPT_STATUS5_MASK);
> +
> +	return intr;
> +}
> +
> +static u32 msm_dp_ctrl_get_mst_vcpf_interrupt_2_3(struct msm_dp_ctrl_pri=
vate *ctrl)
> +{
> +	u32 intr, intr_ack;
> +
> +	intr =3D msm_dp_read_ahb(ctrl, REG_DP_INTR_STATUS7);
> +	intr &=3D ~DP_INTERRUPT_STATUS7_MASK;
> +	intr_ack =3D (intr & DP_INTERRUPT_STATUS7)
> +			<< DP_INTERRUPT_STATUS_ACK_SHIFT;
> +	msm_dp_write_ahb(ctrl, REG_DP_INTR_STATUS7,
> +			 intr_ack | DP_INTERRUPT_STATUS7_MASK);
> +
> +	return intr;
> +}

[ ... ]

> @@ -2801,6 +2877,16 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *ms=
m_dp_ctrl,
>  		ret =3D IRQ_HANDLED;
>  	}
> =20
> +	isr =3D msm_dp_ctrl_get_mst_vcpf_interrupt_0_1(ctrl);
> +	if (ctrl->num_pixel_clks > DP_STREAM_2)
> +		isr |=3D msm_dp_ctrl_get_mst_vcpf_interrupt_2_3(ctrl);
> +
> +	if (isr & (DP_INTR_MST_DP0_VCPF_SENT | DP_INTR_MST_DP1_VCPF_SENT |
> +		   DP_INTR_MST_DP2_VCPF_SENT | DP_INTR_MST_DP3_VCPF_SENT)) {

[Severity: Medium]
Does this bitwise OR of two different status registers cause false positive=
s?

The msm_dp_ctrl_get_mst_vcpf_interrupt_*() functions return the unmasked
register values. Since the values from REG_DP_INTR_STATUS5 and
REG_DP_INTR_STATUS7 are ORed together here, bits from one register could
overlap with the VCPF bits checked for the other.

For example, if an unrelated interrupt sets bit 18 in REG_DP_INTR_STATUS5,
and it gets ORed into `isr`, the condition will see bit 18 set and assume
it's DP_INTR_MST_DP2_VCPF_SENT (which is bit 18 of REG_DP_INTR_STATUS7).

This could cause a spurious completion of ctrl->idle_comp during a VCPF pus=
h,
allowing the driver to proceed while the hardware is still executing the
pattern.

Should the return values of msm_dp_ctrl_get_mst_vcpf_interrupt_*() be masked
against their respective VCPF bits before returning, or should they be chec=
ked
independently instead of ORing them together?

> +		complete(&ctrl->idle_comp);
> +		ret =3D IRQ_HANDLED;
> +	}
> +
>  	/* DP aux isr */
>  	isr =3D msm_dp_ctrl_get_aux_interrupt(ctrl);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D12
