Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E77CD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 11:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6245010E11C;
	Sun, 10 May 2026 11:23:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oSgOl3ry";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E10BB10E105;
 Sun, 10 May 2026 11:23:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 98CAB4088A;
 Sun, 10 May 2026 11:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AA1C2BCB8;
 Sun, 10 May 2026 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778412191;
 bh=4wlrsL+5QzVoGJrBs2lTX9zEhWG1wgLayEtMSvZTTXs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oSgOl3ryp0QJRhD68K/YMuHTfuCRfGfYPPiJMVKWkSkJeRKPD3YBD8zF1SU945omz
 ezna2/AhjraczadHYOWyXxXcdaUUyPK7mQq8pID0+NnwT0opPGxF6Vne1iqfbIcXUH
 z3/Jna2Bkymp0ixN00FndgYKuoWSiGcmhik43k5KYDfSyP8mqL8vBgthRYQALDSMjp
 xoK74ENcxLRqfIhs7S+LqQ8mEriVR/EGU1ZoeOhtQ/fIXSuNzoBGjjeqx1UCpcpRKK
 qmp3wFds6wd1Nj11pAnkD+zkRXlIdAl3UB5PQfPWhluQyM44IkDYys2Gw0xfTKZuLn
 qcOUiWoZo7rwQ==
Date: Sun, 10 May 2026 16:53:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v8 0/4] drm/msm/hdmi & phy: use generic PHY framework
Message-ID: <agBqm1Aede3HX0yv@vaman>
References: <20260401-fd-hdmi-phy-v8-0-51b0e98edf6c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-fd-hdmi-phy-v8-0-51b0e98edf6c@oss.qualcomm.com>
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

On 01-04-26, 06:38, Dmitry Baryshkov wrote:
> The MSM HDMI PHYs have been using the ad-hoc approach / API instead of
> using the generic API framework. Move MSM HDMI PHY drivers to
> drivers/phy/qualcomm and rework them to use generic PHY framework. This
> way all the QMP-related code is kept at the same place.
> Also MSM8974 HDMI PHY, 28nm DSI PHY and apq8964 SATA PHY now can use
> common helpers for the UNI PLL.
> 
> This also causes some design changes. Currently on MSM8996 the HDMI PLL
> implements clock's set_rate(), while other HDMI PHY drivers used the
> ad-hoc PHY API for setting the PLL rate (this includes in-tree MSM8960
> driver and posted, but not merged, MSM8974 driver). This might result in
> the PLL being set to one rate, while the rest of the PHY being tuned to
> work at another rate. Adopt the latter idea and always use
> phy_configure() to tune the PHY and set the PLL rate.

Hi Dimitry,

Can you please check

https://sashiko.dev/#/patchset/20260401-fd-hdmi-phy-v8-0-51b0e98edf6c%40oss.qualcomm.com

> 
> Merge strategy: Merge the first patch (either through drm/msm or through
> the PHY tree), merge the rest of the patches in the next cycle.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v8:
> - Rebased on linux-next, fixing conflicts
> - Added missing ids for APQ8084 and MSM8998 (Sashiko)
> - Switched to pm_runtime_put() (Sashiko)
> - Fixed several missed *1000 after pixclk -> tmds_char_rate conversion
>   (Sashiko)
> - Fixed several math overflows (Sashiko)
> - Link to v7: https://patch.msgid.link/20260324-fd-hdmi-phy-v7-0-b41dde8d83b8@oss.qualcomm.com
> 
> Changes in v7:
> - Fixed the build issue between msm8974 patches.
> - Dropped even more writel / readl wrappers (now from QMP PHYs)
> - Link to v6: https://lore.kernel.org/r/20260319-fd-hdmi-phy-v6-0-cefc08a55470@oss.qualcomm.com
> 
> Changes in v6:
> - Changed MSM8974 HDMI PHY driver to use FIELD_PREP / FIELD_GET (Konrad)
> - Fixed rate recalculation for MSM8974 HDMI PHY (Konrad)
> - Dropped register read/write wrappers
> - Link to v5: https://lore.kernel.org/r/20260314-fd-hdmi-phy-v5-0-58122ae96d3b@oss.qualcomm.com
> 
> Changes in v5:
> - Kept only a single place which handles extp clk (after PHY power on,
>   before PHY power off) (Neil)
> - Inlined pm_runtime calls in the HDMI TX driver, replaced
>   pm_runtime_resume_and_get() with pm_runtime_get_sync(), since
>   atomic_pre_enable() can not fail.
> - Renamed registers defines to drop the REG_ prefix.
> - Link to v4: https://lore.kernel.org/r/20250520-fd-hdmi-phy-v4-0-fcbaa652ad75@oss.qualcomm.com
> 
> Changes in v3-v4:
> - Rebased on top of linux-next, solving conflicts
> - Squashed add-and-remove patches into a single git mv patch
> - Dropped HDMI PHY header patch (merged upstream)
> 
> Changes in v2:
> - Changed msm8960 / apq8064 to calculate register data instead of using
>   fixed tables. This extends the list of supported modes.
>   (Implementation is based on mdss-hdmi-pll-28lpm.c from msm-4.14).
> 
> - Fixed the reprogramming of PLL rate on apq8064.
> 
> - Merged all non-QMP HDMI PHY drivers into a common PHY_QCOM_HDMI
>   driver (suggested by Rob Clark)
> 
> ---
> Dmitry Baryshkov (4):
>       drm/msm/hdmi: switch to generic PHY subsystem
>       phy: qcom: apq8064-sata: extract UNI PLL register defines
>       phy: qcom-uniphy: add more registers from display PHYs
>       phy: qualcomm: add MSM8974 HDMI PHY support
> 
>  drivers/gpu/drm/msm/Makefile                     |   7 -
>  drivers/gpu/drm/msm/hdmi/hdmi.c                  |  59 +-
>  drivers/gpu/drm/msm/hdmi/hdmi.h                  |  80 +--
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c           |  80 ++-
>  drivers/gpu/drm/msm/hdmi/hdmi_phy.c              | 226 -------
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c         |  51 --
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c         | 761 ----------------------
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c         | 765 -----------------------
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.c         | 141 -----
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.c         |  44 --
>  drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c         | 460 --------------
>  drivers/gpu/drm/msm/registers/display/hdmi.xml   | 537 ----------------
>  drivers/phy/qualcomm/Kconfig                     |  24 +
>  drivers/phy/qualcomm/Makefile                    |  14 +
>  drivers/phy/qualcomm/phy-qcom-apq8064-sata.c     |  23 +-
>  drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c       | 353 +++++++++++
>  drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c       | 478 ++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-hdmi-45nm.c        | 186 ++++++
>  drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.c      | 213 +++++++
>  drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.h      |  59 ++
>  drivers/phy/qualcomm/phy-qcom-qmp-hdmi-base.c    | 187 ++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8996.c | 440 +++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8998.c | 489 +++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-hdmi.h         |  49 ++
>  drivers/phy/qualcomm/phy-qcom-uniphy.h           |  74 +++
>  25 files changed, 2611 insertions(+), 3189 deletions(-)
> ---
> base-commit: d894dddf2a144f0e1d1cd7a8225c744dc906cdd5
> change-id: 20240109-fd-hdmi-phy-44b8319fbcc7
> 
> Best regards,
> --  
> With best wishes
> Dmitry

-- 
~Vinod
