Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1F8CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37AF610E174;
	Thu, 15 Oct 2026 17:03:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5657510E174
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 17:02:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 26FBD405C0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 17:02:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8071F000C4;
 Thu, 15 Oct 2026 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792083776;
 bh=pRQP3xKztGqExZR7+p6H2GKJ2SFrQDWmsi4/0qSLYl4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y0+HkmttJmaS2az3Bcjom82VFbEJQu5f2Iyo7ap1cs/eNdqFI7kpnlyMVowmWRNXp
 BX6AtN+Xp5yezFRlYmFd3LfqvQ58nDKS3ReViQd/o9iEefApsfmd2Tisc+hj53Iovr
 gdPcu0PsbypiG0346Tua8Smg5MlBPdEqd7yTTm2OuqPBSF7vPmtxoCQn4Ar6CefT27
 +9YvcFORkXxM0IFWew9fbUH8CFA8Wu4ADHwLTa1wipGd1ZZyArMkMjCSqWoud4CTQ1
 eYcWl5PGiwmJdGShapD7VPvKhJV7EWVaEY9KRymfd//+Jci9ZJLWOw2IayAKfr9Ebv
 CINQdd351iZng==
Message-ID: <sashiko-outbox-173224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 24/28] drm/tidss: dispc: Improve mode checking logs
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-24-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-24-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 17:02:55 +0000
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
- [Low] drm/tidss: misleading debug message for clock tolerance check
--

commit ba6e7e4ea9ca6eb6ee75e88d2391c42dcbb0611c
Author: Maxime Ripard <mripard@kernel.org>

drm/tidss: dispc: Improve mode checking logs

This commit adds diagnostic debug messages to dispc_vp_mode_valid and
check_pixel_clock to clarify why a display mode is rejected by the hardware.
Previously, mode rejection occurred silently without clear attribution.

> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 2a0ec11a6c902..a19b74b0ca302 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
[ ... ]
> @@ -1318,8 +1320,10 @@ static int check_pixel_clock(struct dispc_device *=
dispc, u32 hw_videoport,
>  	 * To keep the check consistent with dispc_vp_set_clk_rate(), we
>  	 * use the same 5% check here.
>  	 */
> -	if (dispc_pclk_diff(clock, round_clock) > 5)
> +	if (dispc_pclk_diff(clock, round_clock) > 5) {
> +		drm_dbg(dev, "Mode pixel clock below hardware minimum pixel clock.");

[Severity: Low]
Is this debug message accurate for this condition?

The dispc_pclk_diff function checks if the requested clock and the rounded
clock differ by more than 5%. This means the synthesized clock is out of
tolerance (it could be either higher or lower than the requested rate by
more than 5%), rather than strictly being below a hardware minimum.

Could this mislead developers trying to diagnose mode rejections?

>  		return -EINVAL;
> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D24
