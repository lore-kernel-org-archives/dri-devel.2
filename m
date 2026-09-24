Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F22C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D595B10F56A;
	Thu, 24 Sep 2026 13:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="oISgL3Up";
	dkim-atps=neutral
Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com
 [74.125.228.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5747710F580
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 13:36:10 +0000 (UTC)
Received: by mail-ed2-f35.google.com with SMTP id
 4fb4d7f45d1cf-6a98505364aso3427795a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1790256969; x=1790861769; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qbis09Q+KRjx9IyPuxFMqUf7Bej9ELQ4/FObbQ4rTIM=;
 b=oISgL3Upe/gBkZTgiW2Nsm03T3t/II8yG5Ql73QEq87PY39Cw/NhRU1hpORx3mwz9W
 a4fyJXd5c4BIWKWlJnJ/pFiBZ9GZe8mOM1KgiLfe5xQGKsYZxVd4xOePnEJGrNOqJ02Y
 97N7dUYPyd2kQAT59gHW+Ryl1zDutahbE1Df+cDoPiylJvG3EM2MF+6DFUFeMHAwBa5V
 vtMhHqaNjmsh0xfPOIKDl09T4EmoTraFCP2l16FQ1BdUs6EKSO/8/WNdQUVD0J6rZsCR
 evNfB8ZSkvb9DnLihKjkFP39ObRVTRHre0RXy3GXaPSp4Lq1NzkwNIL5UkIrV+1Amvwi
 NU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256969; x=1790861769;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qbis09Q+KRjx9IyPuxFMqUf7Bej9ELQ4/FObbQ4rTIM=;
 b=q6C50N7AdbL8Cy0+NkYjmEwhsXg8cHeg/mRI9H8V2oqD1SPbA22R/3WQ9EH/+ftCOh
 IzO7vRpxlR8zc8AkC80dGjjUtcY3+n25lm0qmbji717maE7JTOHGK5/ZGZ0laA2rtZ94
 ldaTqcrG9+5ElN+Oujc79wQHHjkPbyVw1trAS3Qo8U5EQ3yMx6cjJXs6SheRw+/5PfHU
 PT4YpklFVi4PXbpXicmNjbtrcGg5+EanHgWn+hUuhcmRIu0FL4BjHzaWUxRtKGn8JCwP
 tv7aet3jkR+4jtn7hc7XmrB8RGIQapKK6M0JA6rF5RpeKmtYdVgl1EoeBmaKn69Rc+wW
 ljvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlcxWkHRL0T2BBwga4Q/53degyXkEYJk7mSfEseTbHPtH9zerkkWSd74bp+o0nKRPKVxRpVxD9H8Y=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nMP2O56WP24hV0HwhqUdLHqB1xgzA6teLm0bRo7Pkvd5JnlLH9
 tByEzYPpFWeFQmbehDzn47S/Fuo6ZzXuXeYJ4iBq55StNKbm+dRwVvM9+BQVxRCgjC8=
X-Gm-Gg: AYBFou3OiTFBFgSWKXupPLCvk2uWjkh/wsfauZNx7+TldKxT6AL2QVfE19Tm5Nci1/3
 IBBpHS+7J7r5++4CXpyqdNWF6Ke1ZY/X/r9uHFoltixlwOxUDI0Ml9QMtAO8SLBEfQKODhVJrMP
 z29vAczJa3HEwLq0N8teQMRsgrMQmoN5diDSi/qsuI+tPuTcfwdogqlRUxtDTbFLmuoXMHd0NNq
 2VSwaOaBqj+i82UlVMj20rvD6uJ/066Fsl2CM2hogi8XBL0BuXA7Q7drVPPVjNt5EFiYSimQ8Zl
 JePxsgIcC0HyvsR6jCvGrdm245cAjVV7sqiihj/KdE2Qn1SDEXzgip9pToC9EkHEUPZUvFmQJh8
 P6aZSN32IlcEezFLjUxOYCtv+db/nf+MgUS9WMOHcm80ZhgM3ExVdZxN+UuKyQYzlzCdK1ElquJ
 JulLU7nuVL9e6ZLWzar9wQNuDkWwDp/e16b2gW/1klMEs+GxDtCOPG8NXnVTcKd5MtNlQBCZ0Um
 uzDwCrJcsY=
X-Received: by 2002:a17:907:3f89:b0:c29:61b9:7b3b with SMTP id
 a640c23a62f3a-c2ac25b1f23mr204543866b.49.1790256968563; 
 Thu, 24 Sep 2026 06:36:08 -0700 (PDT)
Received: from localhost ([145.15.244.233]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae6149e6sm294506266b.28.2026.09.24.06.36.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 06:36:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 15:36:05 +0200
Message-Id: <DLNL4OAG2D1L.2EI2N80LMZV8N@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/dsi/phy: power up the digital top before
 starting the 7nm PLL
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Sean Paul" <sean@poorly.run>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Jonathan Marek" <jonathan@marek.ca>,
 "Val Packett" <val@packett.cool>, "Bjorn Andersson" <andersson@kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20260924-dsi-7nm-pll-digtop-v1-1-c2b24c8e218d@oss.qualcomm.com>
In-Reply-To: <20260924-dsi-7nm-pll-digtop-v1-1-c2b24c8e218d@oss.qualcomm.com>
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

Hi Dmitry,

On Thu Sep 24, 2026 at 2:51 AM CEST, Dmitry Baryshkov wrote:
> dsi_pll_7nm_vco_prepare() de-asserts PLL_SHUTDOWNB and starts the PLL,
> but leaves the PHY digital top powered down; only dsi_7nm_phy_enable()
> sets DIGTOP_PWRDN_B.  The PLL cannot lock in that state.  This went
> unnoticed for as long as the PLL was only ever prepared from the DSI
> host's enable path, after the PHY had been enabled.
>
> Since commit acf7a91d0b0e ("clk: qcom: dispcc-sm8250: Enable parents for
> pixel clocks") the clock framework enables the PHY PLL on its own while
> applying the DT's assigned-clock-parents from of_clk_set_defaults(), at
> probe time, before the PHY has been touched.  The lock fails, the failed
> enable leaves the pixel clock with an unbalanced enable count, and the
> retries on every probe attempt stall the boot for tens of seconds:
>
>   DSI PLL(0) lock failed, status=3D0x00000000
>   PLL(0) lock failed
>   dsi0_phy_pll_out_dsiclk already disabled
>   WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x244/0x24c
>    clk_core_disable
>    __clk_set_parent_after
>    clk_core_set_parent_nolock
>    clk_set_parent
>    of_clk_set_defaults
>    platform_probe
>
> CMN_CTRL_0 reads 0x20 at the failing attempt: PLL_SHUTDOWNB set,
> DIGTOP_PWRDN_B clear.  Setting DIGTOP_PWRDN_B alone makes the same PLL
> lock, with no rate change and no other register touched.
>
> Power up the digital top together with the PLL bias, and power it down
> again with it.  The normal enable path is unaffected: dsi_7nm_phy_enable(=
)
> holds the bias reference and writes CMN_CTRL_0 in full anyway.

FWIW the same fix seems to help on the 10nm with this error on bootup

[    0.503085] msm_dsi_phy ae94400.phy: [drm:dsi_pll_10nm_vco_prepare] *ERR=
OR* DSI PLL(0) lock failed, status=3D0x00000000
[    0.503168] msm_dsi_phy ae94400.phy: [drm:dsi_pll_10nm_vco_prepare] *ERR=
OR* PLL(0) lock failed

I've also ported more commits from 7nm to 10nm locally, will send them
soon, since anyway they should be good fixes and code quality
improvements

drm/msm/dsi_phy_10nm: Protect PHY_CMN_CLK_CFG0 updated from driver side
drm/msm/dsi_phy_10nm: Protect PHY_CMN_CLK_CFG1 against clock driver
drm/msm/dsi_phy_10nm: Do not overwite PHY_CMN_CLK_CFG1 when choosing bitclk=
 source
drm/msm/dsi_phy_10nm: Define PHY_CMN_CLK_CFG[01] bitfields and simplify sav=
ing
drm/msm/dsi_phy_10nm: Define PHY_CMN_CTRL_0 bitfields
drm/msm/dsi_phy_10nm: Fix reading zero as PLL rates when unprepared

Unfortunately some other warnings/errors still persist on bootup that I
can't figure out... maybe you have some idea?

If not, I don't want to bring this thread too much offtopic :)

[    1.197104] ------------[ cut here ]------------
[    1.197113] dsi0_pll_bit_clk: Zero divisor and CLK_DIVIDER_ALLOW_ZERO no=
t set
[    1.197134] WARNING: drivers/clk/clk-divider.c:145 at divider_recalc_rat=
e+0xac/0xd4, CPU#0: kworker/u32:0/12
[    1.197150] Modules linked in:
[    1.197160] CPU: 0 UID: 0 PID: 12 Comm: kworker/u32:0 Not tainted 7.2.0-=
00088-gddc402c24fff #86 PREEMPTLAZY=20
[    1.197166] Hardware name: Fairphone 4 (DT)
[    1.197170] Workqueue: events_unbound deferred_probe_work_func
[    1.197181] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    1.197186] pc : divider_recalc_rate+0xac/0xd4
[    1.197190] lr : divider_recalc_rate+0xac/0xd4
[    1.197195] sp : ffff8000800b2720
[    1.197197] x29: ffff8000800b2720 x28: ffff0000858b9080 x27: 00000000000=
00000
[    1.197204] x26: ffff0000859eb5c0 x25: 0000000000000000 x24: 00000000072=
a88a0
[    1.197211] x23: ffff000080394c10 x22: ffff0000859eac00 x21: ffff000080a=
9fe00
[    1.197217] x20: 0000000072a88a00 x19: ffff000084c92400 x18: fffffffffff=
e9898
[    1.197224] x17: 000000040044ffff x16: 045000f2b5503510 x15: fffffffffff=
e9848
[    1.197232] x14: 0000000000000050 x13: 0a74657320746f6e x12: 204f52455a5=
f574f
[    1.197238] x11: ffffd97c73dedd58 x10: 00000000000001fa x9 : ffffd97c73d=
edd58
[    1.197245] x8 : 3fffffffffffefff x7 : ffffd97c73e45d58 x6 : 00000000000=
00000
[    1.197251] x5 : 0000000000000001 x4 : 0000000000000000 x3 : 00000000fff=
fffff
[    1.197257] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000801=
c0000
[    1.197265] Call trace:
[    1.197268]  divider_recalc_rate+0xac/0xd4 (P)
[    1.197275]  clk_divider_recalc_rate+0x58/0x80
[    1.197279]  clk_recalc+0x74/0xc0
[    1.197287]  clk_calc_subtree+0x50/0x80
[    1.197293]  clk_calc_subtree+0x68/0x80
[    1.197298]  clk_calc_new_rates+0x1a8/0x208
[    1.197305]  clk_calc_new_rates+0x12c/0x208
[    1.197311]  clk_calc_new_rates+0x12c/0x208
[    1.197316]  clk_calc_new_rates+0x12c/0x208
[    1.197323]  clk_calc_new_rates+0x12c/0x208
[    1.197329]  clk_calc_new_rates+0x18c/0x208
[    1.197335]  clk_core_set_rate_nolock+0xc0/0x2d0
[    1.197340]  clk_set_rate+0x38/0x14c
[    1.197344]  _set_opp+0x140/0x5c0
[    1.197352]  dev_pm_opp_set_rate+0x110/0x2f4
[    1.197358]  dsi_link_clk_set_rate_6g+0x44/0x100
[    1.197366]  msm_dsi_host_power_on+0xb8/0x99c
[    1.197371]  dsi_mgr_bridge_pre_enable+0x19c/0x3c0
[    1.197376]  drm_atomic_bridge_call_pre_enable+0x40/0x54
[    1.197384]  drm_atomic_bridge_chain_pre_enable+0xe0/0x14c
[    1.197390]  drm_atomic_helper_commit_encoder_bridge_pre_enable+0xb4/0xf=
c
[    1.197399]  drm_atomic_helper_commit_modeset_enables+0x28/0x58
[    1.197406]  msm_atomic_commit_tail+0x1ac/0x55c
[    1.197412]  commit_tail+0xa4/0x1a0
[    1.197416]  drm_atomic_helper_commit+0x178/0x1a0
[    1.197421]  drm_atomic_commit+0x8c/0xd0
[    1.197427]  drm_client_modeset_commit_atomic+0x214/0x280
[    1.197434]  drm_client_modeset_commit_locked+0x60/0x178
[    1.197442]  drm_client_modeset_commit+0x2c/0x60
[    1.197448]  __drm_fb_helper_restore_fbdev_mode_unlocked.part.0+0x84/0x8=
c
[    1.197456]  drm_fb_helper_set_par+0x58/0x74
[    1.197462]  fbcon_init+0x4c0/0x4e4
[    1.197470]  visual_init+0xb4/0x104
[    1.197478]  do_bind_con_driver.isra.0+0x1c4/0x360
[    1.197483]  do_take_over_console+0x1c0/0x214
[    1.197487]  do_fbcon_takeover+0x78/0xf4
[    1.197493]  fbcon_fb_registered+0x17c/0x1e8
[    1.197498]  do_register_framebuffer+0x19c/0x250
[    1.197504]  register_framebuffer+0x28/0x50
[    1.197509]  __drm_fb_helper_initial_config_and_unlock+0x324/0x5a0
[    1.197516]  drm_fb_helper_initial_config+0x38/0x44
[    1.197523]  drm_fbdev_client_hotplug+0x7c/0xd4
[    1.197529]  drm_client_register+0x58/0x9c
[    1.197535]  drm_fbdev_client_setup+0xa4/0x1c0
[    1.197540]  drm_client_setup+0xac/0xe0
[    1.197546]  msm_drm_kms_post_init+0x28/0x40
[    1.197552]  msm_drm_init+0x15c/0x1d4
[    1.197558]  msm_drm_bind+0x48/0x60
[    1.197562]  try_to_bring_up_aggregate_device+0x16c/0x1e0
[    1.197569]  __component_add+0xa4/0x170
[    1.197574]  component_add+0x14/0x20
[    1.197579]  dsi_dev_attach+0x20/0x38
[    1.197585]  dsi_host_attach+0x140/0x158
[    1.197591]  mipi_dsi_attach+0x2c/0x50
[    1.197596]  hx83112a_probe+0xec/0x1bc
[    1.197601]  mipi_dsi_drv_probe+0x1c/0x28
[    1.197606]  really_probe+0xbc/0x2c0
[    1.197612]  __driver_probe_device+0x118/0x16c
[    1.197618]  driver_probe_device+0x3c/0x120
[    1.197623]  __device_attach_driver+0xa4/0x108
[    1.197628]  bus_for_each_drv+0x84/0xe4
[    1.197633]  __device_attach+0x9c/0x1a0
[    1.197639]  device_initial_probe+0x54/0x5c
[    1.197644]  bus_probe_device+0x34/0x98
[    1.197649]  device_add+0x5c4/0x7dc
[    1.197654]  mipi_dsi_device_register_full+0xd8/0x168
[    1.197659]  mipi_dsi_host_register+0xb8/0x178
[    1.197663]  msm_dsi_host_register+0x3c/0x60
[    1.197668]  msm_dsi_manager_register+0x148/0x220
[    1.197673]  dsi_dev_probe+0x18c/0x220
[    1.197679]  platform_probe+0x80/0xac
[    1.197686]  really_probe+0xbc/0x2c0
[    1.197691]  __driver_probe_device+0x118/0x16c
[    1.197697]  driver_probe_device+0x3c/0x120
[    1.197703]  __device_attach_driver+0xa4/0x108
[    1.197708]  bus_for_each_drv+0x84/0xe4
[    1.197713]  __device_attach+0x9c/0x1a0
[    1.197718]  device_initial_probe+0x54/0x5c
[    1.197723]  bus_probe_device+0x34/0x98
[    1.197729]  deferred_probe_work_func+0x88/0xc0
[    1.197734]  process_one_work+0x150/0x280
[    1.197743]  worker_thread+0x18c/0x2e0
[    1.197748]  kthread+0x11c/0x13c
[    1.197754]  ret_from_fork+0x10/0x20
[    1.197761] ---[ end trace 0000000000000000 ]---
[    1.197768] ------------[ cut here ]------------
[    1.197769] dsi0_phy_pll_out_dsiclk: Zero divisor and CLK_DIVIDER_ALLOW_=
ZERO not set
[    1.197785] WARNING: drivers/clk/clk-divider.c:145 at divider_recalc_rat=
e+0xac/0xd4, CPU#0: kworker/u32:0/12

Regards
Luca

>
> Fixes: 1ef7c99d145c ("drm/msm/dsi: add support for 7nm DSI PHY/PLL")
> Fixes: acf7a91d0b0e ("clk: qcom: dispcc-sm8250: Enable parents for pixel =
clocks")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Single fix for the DSI PLL lock failure and the clk_core_disable() WARN
> seen at probe on SM8150/SM8250/SM8350/SC8180X since the dispcc-sm8250
> pixel clock sources gained CLK_OPS_PARENT_ENABLE.  The clock framework
> now enables the PHY PLL while applying assigned-clock-parents, before the
> PHY driver has powered up the PHY's digital top, and the PLL cannot lock
> without it.
>
> Found by forcing the missing bit on a failing boot: CMN_CTRL_0 read 0x20
> at the failed attempt, and setting DIGTOP_PWRDN_B alone made the same
> PLL lock.  Verified on QRB5165 RB5 and SM8350 HDK with the current DTs,
> and with the link clock sources moved into the driver; the fix is
> independent of that series and makes it unnecessary as a fix.
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/=
msm/dsi/phy/dsi_phy_7nm.c
> index 5d805a797abd..7bacc1031187 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> @@ -413,7 +413,8 @@ static void dsi_pll_disable_pll_bias(struct dsi_pll_7=
nm *pll)
>  	} /* else: =3D=3D 0 */
> =20
>  	data =3D readl(pll->phy->base + REG_DSI_7nm_PHY_CMN_CTRL_0);
> -	data &=3D ~DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;
> +	data &=3D ~(DSI_7nm_PHY_CMN_CTRL_0_DIGTOP_PWRDN_B |
> +		  DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB);
>  	writel(0, pll->phy->pll_base + REG_DSI_7nm_PHY_PLL_SYSTEM_MUXES);
>  	writel(data, pll->phy->base + REG_DSI_7nm_PHY_CMN_CTRL_0);
>  	spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
> @@ -433,7 +434,8 @@ static void dsi_pll_enable_pll_bias(struct dsi_pll_7n=
m *pll)
>  	}
> =20
>  	data =3D readl(pll->phy->base + REG_DSI_7nm_PHY_CMN_CTRL_0);
> -	data |=3D DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;
> +	data |=3D DSI_7nm_PHY_CMN_CTRL_0_DIGTOP_PWRDN_B |
> +		DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;
>  	writel(data, pll->phy->base + REG_DSI_7nm_PHY_CMN_CTRL_0);
> =20
>  	writel(0xc0, pll->phy->pll_base + REG_DSI_7nm_PHY_PLL_SYSTEM_MUXES);
>
> ---
> base-commit: a15fac810c76397ec9f62a6fc26c4d7ab6e238a7
> change-id: 20260924-dsi-7nm-pll-digtop-9939220a453a
>
> Best regards,
> -- =20
> With best wishes
> Dmitry


