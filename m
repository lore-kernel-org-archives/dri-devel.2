Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB65C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047BF10E78E;
	Mon, 31 Aug 2026 09:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jOj4KZYV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0586110E78E
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:12:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 337B560120;
 Mon, 31 Aug 2026 09:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C751F000E9;
 Mon, 31 Aug 2026 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788167554;
 bh=LKqFLlC+Ey75pRx+cP5QjXhnvgu76qQWsGgjFCe4wu8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jOj4KZYV2Q+EDai5yulSEBzLHwSTiTYz4QN+5SLDyeeH9xIwcjYt5BYw5z5w3qwMD
 Zy7tGCLRKNEO7Vyh3xz5lFsBnKNZJzweZtgfiZsLislo1Xp98bDd4eBoEWJO/EAoQV
 9xAwoYbJ+8Fr2RZ+kFMehRHvjpm/YUposchqbxGIphAnbnF9s2j4Mly3r+iii6S0eE
 BK9yrpGC6JU8LF9CcY9tJ1dpZGe0z8QzUjdDdLbar358A/aE/EeUqJ+y24/CvOI6ey
 cpZvyus8vWTeOgc0Wh+iklozi68NIyQ0gKqwMggD80CiNBNRz2nUMgiu6y+NvxA+cY
 vIpZZqZFDKYog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/29] drm/msm/dp: add support for sending VCPF
 packets in DP controller
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-12-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-12-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:12:34 +0000
Message-Id: <20260831091234.B9C751F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Deterministic timeout during VCPF push for MST streams 2 and 3 d=
ue to unhandled interrupts.

Pre-existing issues:
- [High] `msm_dp_ctrl_push_vcpf` calls a sleeping function (`wait_for_compl=
etion_timeout`) from the atomic disable path.
--

commit 507d49b6852332d2246a4d09ccd9c56c895bd874
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add support for sending VCPF packets in DP controller

The VC Payload Fill (VCPF) sequence is inserted by the DP controller
when stream symbols are absent, typically before a stream is disabled.
Add support for triggering the VCPF sequence in the MSM DP controller.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 9a0c9737e6d00..109a841675997 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c

[ ... ]

> @@ -478,6 +500,34 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_d=
p_ctrl)
>  	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
>  }
> =20
> +/* Must be called with msm_dp_mst::mst_lock held */
> +void msm_dp_ctrl_push_vcpf(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_d=
p_panel *msm_dp_panel)
> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +	u32 state =3D 0x0;
> +
> +	ctrl =3D container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_c=
trl);
> +
> +	if (!ctrl->mst_active)
> +		state |=3D DP_STATE_CTRL_PUSH_IDLE;
> +	else if (msm_dp_panel->stream_id =3D=3D DP_STREAM_0)
> +		state |=3D DP_STATE_CTRL_DP0_PUSH_VCPF;
> +	else if (msm_dp_panel->stream_id =3D=3D DP_STREAM_1)
> +		state |=3D DP_STATE_CTRL_DP1_PUSH_VCPF;
> +	else
> +		state |=3D DP_MSTLINK_PUSH_VCPF;
> +
> +	reinit_completion(&ctrl->idle_comp);
> +
> +	msm_dp_write_stream_link(ctrl, msm_dp_panel->stream_id, REG_DP_STATE_CT=
RL, state);
> +
> +	if (!wait_for_completion_timeout(&ctrl->idle_comp,
> +			IDLE_PATTERN_COMPLETION_TIMEOUT_JIFFIES))
> +		pr_warn("PUSH_VCPF pattern timedout\n");

[Severity: High]
This is a pre-existing issue, but wait_for_completion_timeout() is a
sleeping function, and it is being invoked from an atomic context.

The DRM atomic commit tail framework calls the bridge's atomic_disable
callback (msm_dp_display_atomic_disable()), which directly calls this
function. Since the atomic_disable callback is an atomic context path
where sleeping is strictly forbidden, could this cause kernel warnings
or potential deadlocks during display teardown?

[Severity: Medium]
Will this wait result in a deterministic timeout for MST streams 2 and 3?

When the stream is assigned to DP_STREAM_2 or DP_STREAM_3, the hardware is
triggered to send VCPF via DP_MSTLINK_PUSH_VCPF, and the code blocks here.

However, looking at the interrupt handler in this patch:

    isr =3D msm_dp_ctrl_get_mst_interrupt(ctrl);
    if (isr & (DP_INTR_DP0_VCPF_SENT | DP_INTR_DP1_VCPF_SENT)) {
        drm_dbg_dp(ctrl->drm_dev, "vcpf sent\n");
        complete(&ctrl->idle_comp);
        ret =3D IRQ_HANDLED;
    }

The ISR only checks for stream 0 and 1 completion events. DP2 and DP3
are ignored. Since the interrupt for DP2/DP3 is neither unmasked in
DP_INTERRUPT_STATUS5_MASK nor handled in msm_dp_ctrl_isr(), the
completion won't happen.

Does this cause an unnecessary 30ms delay and a timeout warning every time
a secondary MST stream is disabled?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D12
