Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A19F532D8
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 05:30:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB9B210E46B;
	Tue, 24 Mar 2026 05:30:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IwWTEQB3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7110710E435;
 Tue, 24 Mar 2026 05:30:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FC68405B1;
 Tue, 24 Mar 2026 05:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB708C19424;
 Tue, 24 Mar 2026 05:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774330227;
 bh=526IhjsOFPVmG2tNWNSg5v0vlx2brzpXsRolpXsjTxo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IwWTEQB3juSgzdL+5oAblN8Vg5C2TndIzXIJ+/psD+qLI87dPTnoZjI03lh86g1OB
 mpSx1LZMSw/DBe07y/3Zp7OwHRoXIwmNyksCLyArn6Wgy/ZHCvMbVGNpS90y0hARXP
 F0cEESScMmvPYn5UufI98xv5QMoRbgZrZzhD7xIu0KifQHEz3rXAPZncO9dZT6B7kz
 f7eteFWu1GwBo5+I9vrgiWwlDtSUwgSH1mRAXD6RYsxRwmK/CWvAd8Nwsx8c7aA7z2
 z6dYz7z5nVUXZFH9xdB88UIr+/EMARSpJjWMql6MVkuv6lSlxP20W2BfZ5GZOiuE6l
 rVsq+mtBjuYfg==
Date: Tue, 24 Mar 2026 11:00:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-sunxi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: Re: [PATCH v5 phy-next 10/27] scsi: ufs: qcom: keep parallel track
 of PHY power state
Message-ID: <ezrcjjwtg5n76w4m65l27szu5mywx66ti3xuprkfcp3x6quvbf@2rew4zrnnbt2>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-11-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319223241.1351137-11-vladimir.oltean@nxp.com>
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

On Fri, Mar 20, 2026 at 12:32:24AM +0200, Vladimir Oltean wrote:
> As explained in the similar ufs-exynos.c change, PHY consumer drivers
> should not look at the phy->power_count, because in the general case
> there might also be other consumers who have called phy_power_on() too,
> so the fact that the power_count is non-zero does not mean that we did.
> 
> Moreover, struct phy will become opaque soon, so the qcom UFS driver
> will not be able to apply this pattern. Keep parallel track of the PHY
> power state, instead of looking at a field which will become unavailable
> (phy->power_count).
> 
> About treating the phy_power_off() return code: from an API perspective,
> this should have probably returned void, otherwise consumers would be
> stuck in a state they can't escape. The provider, phy-qcom-qmp-ufs.c,
> does return 0 in its power_off() implementation. I consider it safe to
> discard potential errors from phy_power_off() instead of complicating
> the phy_powered_on logic.
> 

You could even simplify the code by getting rid of the 'phy_powered_on' check
altogether. There is no real need to track the PHY power state in this driver.
It is safe to call phy_power_off() without any checks.

- Mani

> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Nitin Rawat <quic_nitirawa@quicinc.com>
> 
> v4->v5: patch is new
> ---
>  drivers/ufs/host/ufs-qcom.c | 9 +++++++--
>  drivers/ufs/host/ufs-qcom.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 375fd24ba458..3b8bd9968235 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -508,9 +508,10 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  	if (ret)
>  		return ret;
>  
> -	if (phy->power_count)
> +	if (host->phy_powered_on) {
>  		phy_power_off(phy);
> -
> +		host->phy_powered_on = false;
> +	}
>  
>  	/* phy initialization - calibrate the phy */
>  	ret = phy_init(phy);
> @@ -531,6 +532,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  			__func__, ret);
>  		goto out_disable_phy;
>  	}
> +	host->phy_powered_on = true;
>  
>  	ret = phy_calibrate(phy);
>  	if (ret) {
> @@ -1268,6 +1270,7 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
>  				dev_err(hba->dev, "phy power off failed, ret=%d\n", err);
>  				return err;
>  			}
> +			host->phy_powered_on = false;
>  		}
>  		break;
>  	case POST_CHANGE:
> @@ -1277,6 +1280,7 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
>  				dev_err(hba->dev, "phy power on failed, ret = %d\n", err);
>  				return err;
>  			}
> +			host->phy_powered_on = true;
>  
>  			/* enable the device ref clock for HS mode*/
>  			if (ufshcd_is_hs_mode(&hba->pwr_info))
> @@ -1467,6 +1471,7 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>  
>  	ufs_qcom_disable_lane_clks(host);
>  	phy_power_off(host->generic_phy);
> +	host->phy_powered_on = false;
>  	phy_exit(host->generic_phy);
>  }
>  
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 1111ab34da01..72ce0687fa42 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -282,6 +282,7 @@ struct ufs_qcom_host {
>  	struct clk_bulk_data *clks;
>  	u32 num_clks;
>  	bool is_lane_clks_enabled;
> +	bool phy_powered_on;
>  
>  	struct icc_path *icc_ddr;
>  	struct icc_path *icc_cpu;
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்
