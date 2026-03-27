Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C358410F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC7AC10EF71;
	Fri, 27 Mar 2026 20:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VOTfZvEy";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 891C710EF71
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 20:24:08 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-66b51bfe5f3so1545362a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774643047; cv=none;
 d=google.com; s=arc-20240605;
 b=gUZf2WiKOpHpVdK7E2kRiUzx1CtnQyCcjhsJb65lkPj8j/VjhqMbyBrCLdUiTDnvad
 a58zRnyFu1JNsIRBAR/skFchzCQcaTCH5ifl+etEq5YqaQsKV8X9M6cAgZKmQLfZ8vZb
 7GVIk/VNQv8MxsTJs5sSLhp1JM3AfLlNVRYOSzey4u58nRSB3sLReRyZssOT8MlHt0f5
 B4laLpZkteR+IO6pSlDsLYdxeOmerc7R0/STOudZwhRxAtysDCDkR5AJ7G1RsixVdz2X
 /s+3kG2kfCHohgRF35jZd7II8/89HLrepTHbGsXJ3j1TezzsnblqSJhy7BcTRd4mrNO5
 iWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9WeOtA6rLKd2feImk1nWk/a5NsEeM0kN8oqqyEId0bQ=;
 fh=WYfriPxqO1ZSnMjsv1EgcOts2JI+yMCAKk4MO0K/QBA=;
 b=khpo39hQks4M7rhvJUy1WZBur9KYarhViPcYbjWIkOZs0m3if5NRTsrIY0044qfgnA
 xcCGjx2laOCRlY33rwZuMMlmGaz5B8hbaL358LS0BENOLnbC8BOsNAZwMrOuUa3YvUQQ
 sRofd10/lLCdZxs/VKxHkNcx1FU9AdTqvubmNHFq6kqsounKeeU5CrIiv+/TCYT3WwWR
 wySTDlr+oyswLg7C5ZDF1ZedoFrY1vaLye8VGV5khTFrnH2yK1baFykB924rha4yaYC5
 9Cc8kPUMCWI4OHBIQbW3RSBdyhfn4W/ZXnNuHy94F0VzxtwxUWhR6bf+CTx/e/GutO1V
 8BqA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774643047; x=1775247847; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9WeOtA6rLKd2feImk1nWk/a5NsEeM0kN8oqqyEId0bQ=;
 b=VOTfZvEyKIVFOsq7Xj6aF18fg2Xob7ssG1DbVtRSsl5HNNcplrSko2wEx6KMHOXb4L
 I6XRpTJPxgED6VwwYwBOpnLSsMJy5evytOSmfciMr5+aKrPWpkJhUzEpaq9Z/4Tw2uaq
 AVMys6LywznfSnkYdsXx0MVX+CSLmMiN96ZaScQzhN4gv2bxiIFk03XcheJBzNUW/uaf
 kkSEO15rvbc7oHSW2BRGHdshO3uid29jWRYf92jrKH25Hvioqf+D6jGL5dZFPNlUaxTr
 69n7d3Igm/LMb+AuUPNTcU/5AnoUA/ufdo4Ng4P19Xv0y0r33gn3E7wAB9aUmSI3YnsI
 Kl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774643047; x=1775247847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WeOtA6rLKd2feImk1nWk/a5NsEeM0kN8oqqyEId0bQ=;
 b=XVic5MaH1HyMQywz9i1P8gHMM1FQ1sq4h2R9uJw5aWdhHMa52oYDPKhhquP+9v10R/
 OkLFBSa3Pomc6FG2yLzulYwokrtS/25W3NMcaxPAp3YFmC5o/9ZfWBEtAxgR2WCquQj+
 FVTAWL0v6MmK3ShzZcaySVq2UdqTwDASjAYFNBBDLPN3t1zUMpLDQZ3CkTIPYC8qoXbI
 LGxKHDmHW1UEYlWYR4keDJ4gcrNkQMo/HIAs42lxueBVaaCUyr0OxuSnobU+MNFUUebt
 PKst4O8UFlnOYoarGgkxnLviIyFH3AFGCdCNEbd2k6LcvLy8CJMNBbkZLlgpdVqx9rwl
 8S9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJrVuOrcEEtsIkhwbpdjjUewwlIygvNFiJK+eLbwjB1OEkoMaNj+ZbcOA73E9y8d45P3rAThsANR4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTRC9JByvtfpm+5PEBqf19ALVyGX4SdBdcLUFMdosQH0YpL33u
 4O8AEnvgQ3CL+r9TFlydhhgo5G5bTjr7mRBzfiGzr8UKX4RwvZBFAYtQHbUzFWGR2mKbqgnY0Bs
 Rm4NbNkdEK4BmRHyFY565qcPiv1ZBfGzoNj9gIH8xxQ==
X-Gm-Gg: ATEYQzy5cN5MDo8R++x4eUw7doteh3IaXAZX3QELPRzIHtnLHnd7p+e+zaRJMphBIB3
 Es+uNRPjrNws7V0ABkZESDZZ+8Z4GgajDOhaj2PGkXqzQ+vQsJaEGIUMKSyjwbs+YXDrFWWvf5j
 /j4M1ISgEJvx78Q7mYbWuXCY2MrfmyonIRkrSz9Bxul6Qb5QPwMAsdeQR2BT+AyaHemj/1GnOPI
 xCZ9bzPoOtJMvwKC1ufFjM6slf2EW59Dj9JryOc6t4JJCr2t57utdKluB/sUPJNsX51dM9ieQDa
 6PX0MZRDdi+twFv5edI0W6S1Wul0lzjosUR/5Rd1
X-Received: by 2002:a05:6402:46db:b0:66a:199d:138 with SMTP id
 4fb4d7f45d1cf-66b28c66cbemr2039826a12.20.1774643046839; Fri, 27 Mar 2026
 13:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260327184706.1600329-1-vladimir.oltean@nxp.com>
 <20260327184706.1600329-10-vladimir.oltean@nxp.com>
In-Reply-To: <20260327184706.1600329-10-vladimir.oltean@nxp.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 27 Mar 2026 20:23:54 +0000
X-Gm-Features: AQROBzCjrloDfUGTlNvOpQXdM4anVOjHCl2P0WQRB2XbIrpLYVg7AhYSjcExBJI
Message-ID: <CADrjBPqMwtrae7LB9A8xipg6R0rHGewe69awQ_jJnsf=2c=eTw@mail.gmail.com>
Subject: Re: [PATCH v6 phy-next 09/28] scsi: ufs: exynos: stop poking into
 struct phy guts
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, spacemit@lists.linux.dev, 
 UNGLinuxDriver@microchip.com, Bart Van Assche <bvanassche@acm.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Chanho Park <chanho61.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 27 Mar 2026 at 18:48, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> The Exynos host controller driver is clearly a PHY consumer (gets the
> ufs->phy using devm_phy_get()), but pokes into the guts of struct phy
> to get the generic_phy->power_count.
>
> The UFS core (specifically ufshcd_link_startup()) may call the variant
> operation exynos_ufs_pre_link() -> exynos_ufs_phy_init() multiple times
> if the link startup fails and needs to be retried.
>
> However ufs-exynos shouldn't be doing what it's doing, i.e. looking at
> the generic_phy->power_count, because in the general sense of the API, a
> single Generic PHY may have multiple consumers. If ufs-exynos looks at
> generic_phy->power_count, there's no guarantee that this ufs-exynos
> instance is the one who previously bumped that power count. So it may be
> powering down the PHY on behalf of another consumer.
>
> The correct way in which this should be handled is ufs-exynos should
> *remember* whether it has initialized and powered up the PHY before, and
> power it down during link retries. Not rely on the power_count (which,
> btw, on the writer side is modified under &phy->mutex, but on the reader
> side is accessed unlocked). This is a discouraged pattern even if here
> it doesn't cause functional problems.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
> Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Chanho Park <chanho61.park@samsung.com>
>
> v5->v6: collect tags from Alim Akhtar
> v4->v5: collect tag, add "scsi: " prefix to commit title
> v3->v4: none
> v2->v3:
> - add Cc Chanho Park, author of commit 3d73b200f989 ("scsi: ufs:
>   ufs-exynos: Change ufs phy control sequence")
> v1->v2:
> - add better ufs->phy_powered_on handling in exynos_ufs_exit(),
>   exynos_ufs_suspend() and exynos_ufs_resume() which ensures we won't
>   enter a phy->power_count underrun condition
> ---
>  drivers/ufs/host/ufs-exynos.c | 24 ++++++++++++++++++++----
>  drivers/ufs/host/ufs-exynos.h |  1 +
>  2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
> index 76fee3a79c77..274e53833571 100644
> --- a/drivers/ufs/host/ufs-exynos.c
> +++ b/drivers/ufs/host/ufs-exynos.c
> @@ -963,9 +963,10 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
>
>         phy_set_bus_width(generic_phy, ufs->avail_ln_rx);
>
> -       if (generic_phy->power_count) {
> +       if (ufs->phy_powered_on) {
>                 phy_power_off(generic_phy);
>                 phy_exit(generic_phy);
> +               ufs->phy_powered_on = false;
>         }
>
>         ret = phy_init(generic_phy);
> @@ -979,6 +980,8 @@ static int exynos_ufs_phy_init(struct exynos_ufs *ufs)
>         if (ret)
>                 goto out_exit_phy;
>
> +       ufs->phy_powered_on = true;
> +
>         return 0;
>
>  out_exit_phy:
> @@ -1527,6 +1530,9 @@ static void exynos_ufs_exit(struct ufs_hba *hba)
>  {
>         struct exynos_ufs *ufs = ufshcd_get_variant(hba);
>
> +       if (!ufs->phy_powered_on)
> +               return;
> +
>         phy_power_off(ufs->phy);
>         phy_exit(ufs->phy);
>  }
> @@ -1728,8 +1734,10 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
>         if (ufs->drv_data->suspend)
>                 ufs->drv_data->suspend(ufs);
>
> -       if (!ufshcd_is_link_active(hba))
> +       if (!ufshcd_is_link_active(hba) && ufs->phy_powered_on) {
>                 phy_power_off(ufs->phy);
> +               ufs->phy_powered_on = false;
> +       }
>
>         return 0;
>  }
> @@ -1737,9 +1745,17 @@ static int exynos_ufs_suspend(struct ufs_hba *hba, enum ufs_pm_op pm_op,
>  static int exynos_ufs_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
>  {
>         struct exynos_ufs *ufs = ufshcd_get_variant(hba);
> +       int err;
>
> -       if (!ufshcd_is_link_active(hba))
> -               phy_power_on(ufs->phy);
> +       if (!ufshcd_is_link_active(hba) && !ufs->phy_powered_on) {
> +               err = phy_power_on(ufs->phy);
> +               if (err) {
> +                       dev_err(hba->dev, "Failed to power on PHY: %pe\n",
> +                               ERR_PTR(err));
> +               } else {
> +                       ufs->phy_powered_on = true;
> +               }
> +       }
>
>         exynos_ufs_config_smu(ufs);
>         exynos_ufs_fmp_resume(hba);
> diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
> index abe7e472759e..683b9150e2ba 100644
> --- a/drivers/ufs/host/ufs-exynos.h
> +++ b/drivers/ufs/host/ufs-exynos.h
> @@ -227,6 +227,7 @@ struct exynos_ufs {
>         int avail_ln_rx;
>         int avail_ln_tx;
>         int rx_sel_idx;
> +       bool phy_powered_on;
>         struct ufs_pa_layer_attr dev_req_params;
>         struct ufs_phy_time_cfg t_cfg;
>         ktime_t entry_hibern8_t;
> --
> 2.43.0
>
