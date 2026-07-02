Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1ACC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B5710F459;
	Thu,  2 Jul 2026 15:16:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QOuTFlZt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1AB10F459
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:16:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2128D601C6;
 Thu,  2 Jul 2026 15:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC111F000E9;
 Thu,  2 Jul 2026 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783005397;
 bh=Fkhk8pAgUBdhooiC+kuzg22dzImvkuNkC1FL9zvU4+g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QOuTFlZtIPmt0oMBsW4mT81BHjTrmnfTYycFvLvCHfWogNggHoec8Er2P9+TJrVQP
 Bake/AZ6BLtamfIemK1Y82akjsa/lNZ6L0JeF2YPs5yrIY0cxShDATGwH2YhKzKOYO
 MLO/qMDT1m5Rbv8c9oYBORbbkxs7wCtorIzrvqRhfgaLA0bPDjbc5X2SfgdJuxA8mr
 LXb0bH1fdOvK5GRgN5Y9dbf1Q8MEdv1H5dePnTuAkKykVE+IJmzarbymjlb6b/rDLc
 QamAzjMzrtKfneckXS661YhzLIiLLwCXMEwDJOtlxU46WywOadtwDtQs2xg7ID/mWN
 Ia7q0bpnTA6wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 31/39] drm/vc4: hdmi: Convert to common SCDC
 scrambling infrastructure
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-31-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-31-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:16:37 +0000
Message-Id: <20260702151637.9FC111F000E9@smtp.kernel.org>
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
- [High] If `drm_dev_enter` fails in `vc4_hdmi_encoder_post_crtc_disable` (=
e.g., when the device is unbound or unplugged), the function jumps to the `=
out` label and skips calling `drm_connector_hdmi_disable_scrambling()`. Thi=
s leaves the `connector->hdmi.scdc_work` delayed work pending. Since `drm_c=
onnector_cleanup()` does not natively cancel this work, it will execute aft=
er the connector memory has been zeroed and freed, causing a use-after-free=
 and kernel crash.
--

commit b7c6215b3f661e126a4a4477a77ead5d481367d2
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/vc4: hdmi: Convert to common SCDC scrambling infrastructure

This commit converts the vc4 HDMI driver to use the common HDMI 2.0
scrambling infrastructure. It removes the local scrambling workqueue and
state tracking, relying instead on the shared drm_connector_hdmi layer
functions.

> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -909,7 +738,7 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct=
 drm_encoder *encoder,
>  		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
>  	}
> =20
> -	vc4_hdmi_disable_scrambling(encoder);
> +	drm_connector_hdmi_disable_scrambling(&vc4_hdmi->connector);
> =20
>  	drm_dev_exit(idx);

[Severity: High]
This is a pre-existing issue, but does skipping this function leave a
pending delayed work if device access is lost?

Looking at vc4_hdmi_encoder_post_crtc_disable(), if drm_dev_enter() fails,
the function jumps to the out label:

	if (!drm_dev_enter(drm, &idx))
		goto out;
	...
	drm_connector_hdmi_disable_scrambling(&vc4_hdmi->connector);
	drm_dev_exit(idx);
out:
	mutex_unlock(&vc4_hdmi->mutex);

If drm_connector_hdmi_disable_scrambling() is skipped because drm_dev_enter=
()
failed, the connector->hdmi.scdc_work delayed work is never cancelled. Since
drm_connector_cleanup() does not cancel this work, will it execute after the
connector is freed and cause a use-after-free when the timer fires?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D31
