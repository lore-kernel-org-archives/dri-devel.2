Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680F5C44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B71408920D;
	Wed, 22 Jul 2026 06:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h7NIiLkf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9432F8920D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:59:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 734C543E2B;
 Wed, 22 Jul 2026 06:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD6D1F000E9;
 Wed, 22 Jul 2026 06:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703580;
 bh=JRQSxQeZiSEUHZEhPIytWwulx+2Klp1X/bQZo0dNtbs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h7NIiLkfy/WbO2NwWrPWEqe41oPNkiDklo6gKwP4Y7H/uCUJJKEQjxtnDkI7lC7us
 DpaTWKZuki4cCCusy683AkLfUSlvJnSwOviqTDsMxf2EJUYhXDFp2ZiEAl5mvImci1
 NVX08Y7EyXd49sSvoP5iXYA1qr8SIru/NHeB8VHZ1iXENhzZuojLhvU8tmYwWlaFcy
 ZMFk8XJ0eSgnc3Yh5Xnptt6VNrD7cJQr8iuYwK9H4e+ho0kK65EGnbsGPE+B/m6IYZ
 K6ZOvVbdA4pO/sdMsDYUOYG6Tkjp1P71dHb85krHGH9dk3trIgXAd0TDBEIf6YAY4b
 c9HENBpwmlzfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/24] drm/msm/hdmi: capture the HDMI registers in the
 display snapshot
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-drm-msm-display-interface-v1-6-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
 <20260722-drm-msm-display-interface-v1-6-368c10fe62fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 06:59:39 +0000
Message-Id: <20260722065940.2BD6D1F000E9@smtp.kernel.org>
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
- [High] Time-of-check to time-of-use (TOCTOU) race condition when checking=
 `hdmi->power_on` without synchronization, potentially leading to unclocked=
 MMIO access and a kernel panic.
--

--- Patch [6]: [PATCH 06/24] drm/msm/hdmi: capture the HDMI registers in th=
e display snapshot ---
commit ab4d516f006653666c039568efe30c3c3e320faa
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/hdmi: capture the HDMI registers in the display snapshot

This commit fills in the previously empty HDMI snapshot callback to dump=20
the HDMI core register block. The size of the block is obtained via=20
msm_ioremap_size() at probe time, and registers are only accessed while=20
the block is powered on.

> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/h=
dmi.c
> index 350867ada0cf1..72ab2e92964e7 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c

[ ... ]

> @@ -214,6 +215,17 @@ static int msm_hdmi_modeset_init(struct msm_display =
*display,
>  static void msm_hdmi_snapshot(struct msm_display *display,
>  			      struct msm_disp_state *disp_state)
>  {
> +	struct hdmi *hdmi =3D container_of(display, struct hdmi, display);
> +
> +	/*
> +	 * Accessing the HDMI registers requires the clocks to be running,
> +	 * which is only guaranteed while the block is powered on.
> +	 */
> +	if (!hdmi->power_on)
> +		return;
> +
> +	msm_disp_snapshot_add_block(disp_state, hdmi->mmio_size,
> +				    hdmi->mmio, "hdmi");

[Severity: High]
Is it possible to hit a Time-of-check to time-of-use (TOCTOU) race condition
here?

If a concurrent atomic commit thread executes
msm_hdmi_bridge_atomic_post_disable(), takes hdmi->state_mutex, disables the
clocks, and sets hdmi->power_on =3D false, this lockless check could pass b=
efore
the clocks are actually disabled.

Would the subsequent msm_disp_snapshot_add_block() then attempt to read
unclocked hardware registers, potentially causing a synchronous external ab=
ort
and kernel panic?

Does this access need to be protected by hdmi->state_mutex to ensure the
clocks remain enabled during the entire snapshot capture?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-drm-msm-di=
splay-interface-v1-0-368c10fe62fd@oss.qualcomm.com?part=3D6
