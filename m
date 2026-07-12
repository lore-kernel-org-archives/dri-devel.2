Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68027C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 12:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B347A10E459;
	Sun, 12 Jul 2026 12:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=quora.org header.i=@quora.org header.b="RpYIeLIN";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C7C610E459
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 12:47:47 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2ceab75934dso9385775ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 05:47:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783860467; cv=none;
 d=google.com; s=arc-20260327;
 b=QBz8HQOI9v7KXRIDv6Dktbs7weQPyeUJUXsfm1dkkRvfZ770bsaTLFx0eokgRtFOJl
 +LPCAvhdve+MJA7nUzeQ4g6C1mRk0upSnBfFcouvdcIrApnoTOq1K3l8lRc6aAXEpsU2
 9dVR9AGgWJDie+AnnSnNb62hDn/OTogIw0vQgXSmLiBygHO4DNNNxmHajhvnhxvTKJ+1
 T7FBN/TGeZmmsE4O87aCuWzoMqkI4dXRELC/BJLQwxjDa8/fK4gkAiIs26Mw7bHmnp1a
 0bOfj+SBovKAayVPmBKeW++DqZBIXzZdllLG7rE09PGZzu7FeaXZxGbpdwRQhnFhX4EB
 GJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ikvSy5XLG1P+DmNPA6bgvTYTJm+JvB6ahXSZXySRz+4=;
 fh=mJfMOT8sCNIVEf6V1BK60ovrvQn4Wdqd3v4WBzt4e/g=;
 b=ktvYtCZIAuhq64l4ZFX6aAcbqsgYJGBAiHZ5z9IriLCAWWuZA7qRNF60l0SBnBdpnw
 Gvxpx5ZA7brPEDWkIJbJxBSKY4Ug1nmnd3WKd4AYoa6RLTlunvXoTM9Q0bePPCePu43n
 UsbBbRD3RoGdt9RqFaT7VFSmHiF7Z7rXlbtS0TXze9+j9JIDNQQJyFmAjuWM2sK9fCV9
 ZsJL/2np4IxDnrltMpDu29Mvp1fUBy2SKPKZUh3vfwGB/EGNDcPNSFbm3Bewelu8ficJ
 XSN+OYA0aSHGkP612hct24Vvg5zETdyZbwbHMRGqK97rNeQpr6Fa7tHUvvVOyGMAMrZD
 zpVw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quora.org; s=google; t=1783860467; x=1784465267; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ikvSy5XLG1P+DmNPA6bgvTYTJm+JvB6ahXSZXySRz+4=;
 b=RpYIeLINWk2VI+fNHjJRa1106Ju2+Rbwpl8m55KRWa5KdcyiJWhpuPmVVB04CyxmrG
 1AZCjE6Qrz9o4eFAJKeLM801a+/LgTzBBLwS1al3T7DKhpe9KVIBjEXv5WyV9UQD8y49
 P5LMALpw6bSQHYDim6blLhSQ5uoXuVmENu+QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783860467; x=1784465267;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ikvSy5XLG1P+DmNPA6bgvTYTJm+JvB6ahXSZXySRz+4=;
 b=UxeXqDDtP5FOeY0Lh+0TeHs6JuDV/fG6Dfg5IXkawmpTdHqTBVTAFQWVXDejT650Gi
 hff+dA51PBtElwc0YK2Hek76VvHBsfuIpvmxqS+V9K7/9XXh8hpiTVFlVs3vUUrrmXS7
 olkhvlkFkOjHh2mVTFIjw1LyXL5Ad7Duy7FtJqdJxFzWMufmkI8jBYznsZPIyoHw6kPv
 svxML8ufzZu2pFnTF9lWL2YjC36/GQInDdqzSinazdS2My8iBe4za+JczttP14FPlAiw
 +2026PdLX1lEKOUv3QKLLR0PUpo1SgL40SO+UyKUviAkYpCzbrsABMn86jG/4A2tiBoO
 GwHA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7Ogj9mCk8RYfvGYSVzjOMopRfI/tMjaenK2LAGnejLgJk2reYsq0qb+UmyQtZjFHxcttk47YUIzo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzUhFCwjc5ORAdHp/bzAT8YFK1DewHNXflfG45BbZ7r00tMWGe
 wvKbUXqmwBuMbPWv9bYxIIDHjmlIUKSGsBhbRhuETQbyT+JiP8NeDp5CN0Lbw1bMZltR+/sTsMH
 3rH9/qeojL2oatYbaYtpadIZITyOQ4fS4kiKF7Gb0nw==
X-Gm-Gg: AfdE7cnpVWG1FF9h9IWoXjFfvnR3wTHDeG7cwjoMxxveex8AvHwudMb6IbVcggdkpca
 o7DggnWfCznjrnfklPUvXwNGOLDYz4duOmsgbIQT4VDwCMdHP9EaVkBf2Eb+kYwefMW6uNDWAY7
 JJWgYPUrzAC936+nI/EDuPS6+e8hlM3cjQPCLm3DS3vLHlYwH9/JbaUPcMtwtKycdFU9Jlcqo+a
 wHthHUWL80+V92hrBHDz4aTd17wAe9hVeRciJkxOGvYFOS2JQe+ssIx/WahYirMBJJ1bJ/wEgp9
 QnwkteRrx0EjPsRKP3nmpVrizy3mgNWHtD3HRqdew1I/c1CaSU3jEgAb+1dp7bj8ExAOOq/NeKm
 8qaugNYWtCrUyLydsLr2U20itykmVvs4ntnHz7mX1b+Klt2Sl83gebi+x3qFGoP27XsTAWcWPhr
 0e4ClPyavRc/+Hn+8mJsMtX9AQpJ/Isdqm253DeeNtdRRQHyAeJoADm0amFzpsqkCRP6i6q/E=
X-Received: by 2002:a17:903:37c4:b0:2ca:bc05:b082 with SMTP id
 d9443c01a7336-2ce9f052b73mr58124925ad.29.1783860466725; Sun, 12 Jul 2026
 05:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAMVG2st2udHCUHZ_2j=jNmwTAVi2Cvda0qGgH4tDZHwsGVfLKQ@mail.gmail.com>
 <CAMVG2stuY5aTwfmJkL_cLDn86hfuFD+sT-LdqdmN5m21y2aL5g@mail.gmail.com>
 <zscjwjuqhg36vwsbt735y5gq3bcfxcfh4m46zcgpakacyoxrvf@ekji5eglhdcn>
In-Reply-To: <zscjwjuqhg36vwsbt735y5gq3bcfxcfh4m46zcgpakacyoxrvf@ekji5eglhdcn>
From: Daniel J Blueman <daniel@quora.org>
Date: Sun, 12 Jul 2026 20:47:34 +0800
X-Gm-Features: AVVi8CdulQCM4FcxmDA84gLCyj97rAnjiQtbUfGcHr-szb3Uwrhdqe4fpBDVKoc
Message-ID: <CAMVG2st0i7W3S5pyZRqMufL+pfKTkv8e3sLnws0UhOpbqfXbmg@mail.gmail.com>
Subject: Re: [BUG] qcom: x1: GAMMA_LUT corruption on DPMS wake
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jun Nie <jun.nie@linaro.org>, Federico Amedeo Izzo <federico@izzo.pro>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>, 
 Val Packett <val@packett.cool>, Steev Klimaszewski <threeway@gmail.com>
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

On Sun, 12 Jul 2026 at 19:56, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Sun, Jun 14, 2026 at 06:27:50PM +0800, Daniel J Blueman wrote:
> > On Mon, 1 Jun 2026 at 13:37, Daniel J Blueman <daniel@quora.org> wrote:
> > > Since Adreno X1-85 GAMMA_LUT support was introduced in Linux v7.0 (eg
> > > Ubuntu 26.04), when waking from DPMS-off, palette corruption is
> > > frequently seen; this manifests as purple banding. If GNOME night
> > > light or similar is enabled, the visual impact is greater.
> > >
> > > Further, on larger panel monitors or laptops eg the Lenovo Yoga Slim
> > > 7x (2944x1840), a second INT2 block is used for the right half of the
> > > screen, which may remain totally blank on wake; major usability
> > > impact.
> > >
> > > Intuitively, the symptoms feel like the LUT SRAM clock isn't being
> > > driven soon enough during the wakeup, thus state loss may depend on
> > > silicon binning/variation or related. No such symptom is seen in
> > > Windows on the same hardware. I found a workaround supporting this
> > > mechanism is to activate the GNOME night light and adjust the slider
> > > to update the LUT - any black right half of the screen always
> > > reappears.
> > >
> > > Please can someone with X1-85 Adreno insight check the Linux clock and
> > > power domain behaviour around GC_EN, Layer Mixer, INTerFace and INT2
> > > on DPMS wake? Happy to test changes; this is a stunning platform
> > > otherwise.
> > ...
> > > Link: https://gitlab.freedesktop.org/drm/msm/-/work_items/89
> >
> > Just a heads-up on this with additional findings. Note this issue
> > could be the only remaining daily friction on X1 laptops with suspend,
> > once my video decode reboot workaround or similar is merged. Also note
> > in my case, without GNOME night light active, only a few LUT entries
> > render purple so visual artifacts often go unnoticed until a gradient
> > eg in an image is visible.
>
> Could you please check if increasing reg_bus_bw in msm_mdss.c would fix
> the issue? It's not a proper fix yet, but it might help me to understand
> the issue.

Adjusting like so [1] didn't resolve the issue, however it was worth
ruling out. Perhaps you could check with the Windows driver team why
the DMA descriptor approach was used for LUT setup?

> > From DPMS wake on a dual-LM panel (>2560 pixels wide) with
> > INTF_5/DSPP_0 (master) and INTF_6/DSPP_1, I find DSPP_1's registers
> > are intermittently unresponsive just after MDSS resume. DSPP_0 doesn't
> > exhibit this issue, suggesting some missing slave/second unit setup,
> > despite booting clk_ignore_unused pd_ignore_unused.
> >
> > I found the extracted Windows DSDT \_SB.PEP0.G0MD F-state EXIT block
> > enables disp_cc_mdss_rscc_ahb_clk and disp_cc_mdss_rscc_vsync_clk;
> > could this relate? RSCC being the RPMh bridge subblock. Also, could
> > any of the *1_CLK or MDSS_INT2_GDSC entries in dispcc-x1e80100.c lack
> > setup?
>
> RSCC should not affect these blocks.

Good tip on ruling this out too!

Thanks,
  Dan

-- [1]

--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -22,7 +22,7 @@

 #include <generated/mdss.xml.h>

-#define MIN_IB_BW      400000000UL /* Min ib vote 400MB */
+#define MIN_IB_BW      800000000UL /* Min ib vote 400MB */

 struct msm_mdss_data {
        u32 reg_bus_bw;
@@ -521,7 +521,7 @@ static const struct msm_mdss_data data_76k8 = {
 };

 static const struct msm_mdss_data data_153k6 = {
-       .reg_bus_bw = 153600,
+       .reg_bus_bw = 153600*16,
 };

 static const struct of_device_id mdss_dt_match[] = {
-- 
Daniel J Blueman
