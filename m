Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43F2C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C1710E19E;
	Tue, 28 Jul 2026 18:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ff8Kf3XQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3645910E19E
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:43:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7BFB060A8C;
 Tue, 28 Jul 2026 18:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20DC1F000E9;
 Tue, 28 Jul 2026 18:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785264202;
 bh=oJZtISN0vw15yZmCx5G1JMucEyyyp4AVsi660OOpugU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ff8Kf3XQ/8JCoRMJJ7YlpQa0QcXqSdHufdhJl72DvO3YlRal4ypqOXF9SShr104H1
 J/0LrX3yQTHUFmWgcnYLJ4L5fpAADLEvER6Tvu56Qk6xkdq3GATLf4FWtbIv+x92HM
 DPja+inMa+12XDFvGK8DzXUuv3Uk8Rh3gJ6UKMTMWRbHkoAvu0nAH1V+6avDbr3SZl
 KG0mpEBap6dRlX22ZsyQLxNhhVsihxmGRabndVrz9erWUMiuJ48s7oL9syBpgMEzxJ
 BK6J3u6gUbFWNfrdQ1ApDybKFC5Q4bJPMCypoamgrrpbJkjB+xDdTpz4UexH7+Kp48
 iaAy3+YrPuZzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/18] drm/bridge: synopsys: dw-dp: Reset AUX channel
 on transfer timeout
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260728-synopsys-dw-dp-improvements-v7-5-b7640fa8cf48@collabora.com>
References: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
 <20260728-synopsys-dw-dp-improvements-v7-5-b7640fa8cf48@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 18:43:21 +0000
Message-Id: <20260728184321.E20DC1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] The soft reset mechanism intended to prevent delayed completions f=
rom leaking into subsequent transfers is incomplete due to a software race =
condition with the threaded IRQ handler. `dw_dp_irq()` is registered via `d=
evm_request_threaded_irq()` with no hard-IRQ handler, meaning it executes i=
n process context. If the hardware asserts the AUX reply interrupt just bef=
ore the transfer timeout expires, the IRQ thread may wake up and read the i=
nterrupt status (`value & AUX_REPLY_EVENT`), but get preempted before calli=
ng `complete(&dp->complete)`. The timeout handler will then reset the hardw=
are and return `-ETIMEDOUT`. When a subsequent transfer starts, it calls `r=
einit_completion(&dp->complete)`. If the delayed IRQ thread resumes and cal=
ls `complete()` at this point, it will erroneously satisfy the new transfer=
's wait, causing it to read aborted or reset hardware status. To fully clos=
e this race, the timeout path must synchronize with the threaded IRQ handle=
r (e.g., using `synchronize_irq()`) before returning.
--

--- Patch [5]: [PATCH v7 05/18] drm/bridge: synopsys: dw-dp: Reset AUX chan=
nel on transfer timeout ---
commit fd706e1cca6ddcdd0e07e034b13e849a9aa5e4b5
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Reset AUX channel on transfer timeout
   =20
This patch resets the AUX controller when a transfer times out to prevent a
delayed reply interrupt from leaking into a subsequent transfer.
Re-initializing the completion before each transfer does not protect against
a reply interrupt that fires after the initialization.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1493,6 +1493,11 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_au=
x *aux,
>  	status =3D wait_for_completion_timeout(&dp->complete, timeout);
>  	if (!status) {
>  		dev_err(dp->dev, "timeout waiting for AUX reply\n");
> +		regmap_update_bits(dp->regmap, DW_DP_SOFT_RESET_CTRL,
> +				   AUX_RESET, FIELD_PREP(AUX_RESET, 1));
> +		usleep_range(10, 20);
> +		regmap_update_bits(dp->regmap, DW_DP_SOFT_RESET_CTRL,
> +				   AUX_RESET, FIELD_PREP(AUX_RESET, 0));
>  		return -ETIMEDOUT;

[Severity: High]
This is a pre-existing issue, but does this soft reset fully close the race
with the threaded IRQ handler?

If the hardware asserts the AUX reply interrupt exactly as the timeout
expires, the threaded IRQ handler dw_dp_irq() could wake up and read the
interrupt status:

dw_dp_irq() {
	...
	if (value & AUX_REPLY_EVENT) {
		regmap_write(dp->regmap, DW_DP_GENERAL_INTERRUPT, AUX_REPLY_EVENT);

If the thread is preempted right here, the timeout handling above executes,
the hardware is reset, and the function returns -ETIMEDOUT.

When a subsequent transfer begins and calls reinit_completion(&dp->complete=
),
could the delayed IRQ thread resume and execute the completion?

		complete(&dp->complete);
	}
}

This would erroneously satisfy the new transfer's wait and cause it to read
aborted hardware status. Would calling synchronize_irq() in this timeout pa=
th
prevent the completion from leaking?

>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-synopsys-d=
w-dp-improvements-v7-0-b7640fa8cf48@collabora.com?part=3D5
