Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BADCD98D2
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 10:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9790B10E033;
	Sun, 14 Jun 2026 10:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=quora.org header.i=@quora.org header.b="XXn7PcIA";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3D9010E033
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 10:28:03 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2c0c2c7d45eso21435655ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 03:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781432883; cv=none;
 d=google.com; s=arc-20240605;
 b=bCBeksDA0lAeqJQBASFcef6DMFeY3YUZ/jkv4Ip+qUJpTpXxSWos+eivvJtS/GBV/y
 CrNOFD2SUfmZ3xU8KL3M3xgRgC0GkLeEFSM4BRDrzpCmy142ptdNkjVK5bB0XHPVaTIe
 vCcgmsxnyW5UYlR4W2ltIkuFyhHnHm4os/oVcJA50WlRxMelMdYeDBzyy+Sa01gFMLOh
 JshI4+bBpXjRRYJHEolkLdGiqu7SCFElFxGc9X+yTu26xA6s15c/VVGabVTKjJfdCMJw
 FIS9Xoz9rAMA4BbQKL3xoxbo50zkuHAOZYrssMWb3Oh+dJEiMHw1DlDTjijS6zmoU7YM
 vN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yzePJ3jQDgqzUoVchbve1mIf57FTjpX6L66SunK2+KA=;
 fh=/FiBp+GFAlEoS7T19FQzrJ/XgSt6W5d53O7SlTW3Ap0=;
 b=OXmMJf0hNaKAFL5vLQRdaiOQ1TAbwavK3n5xJK/EZTtuR1M/4fP8/scj3kjfXGftJJ
 5Oay/C3LxJuF6LG2tD5GnBrZotM1JhvpXZ2cA9XVzdaFYFQXX0KXkYDWQfFZRwLIJo89
 5A3BRMRBBXvxXZ7BIBoW48cu8IhdbXwyynJeK8M/SovBO2uKtaXOJ3GyveaK9mmcqBVv
 TPT12Imkaw88cAqNNUq5yNoK94UzCxmihlDPhGvdKdnQ2fTF4MYoUEMANWFr1iCYeWWf
 xk5xLJDX0D7VzzyMtY8jOfVjMPFyA4qm+Ct8uFauYd+2o3E0y1hvF5i4JAAZyFC2VjK5
 JTlw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quora.org; s=google; t=1781432883; x=1782037683; darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yzePJ3jQDgqzUoVchbve1mIf57FTjpX6L66SunK2+KA=;
 b=XXn7PcIAwRYUuI2bVvMIgvJETQGVb3LAXqGCZEMYf8AN6OHuGlOtDXDgVsVFN01dvy
 pHOI58ZhKG54b2Ca+KmH1NTDMP4nF/ambfx4LYBoBr+7A4gZ4+je6EQxA2qANPrLf6+T
 TSY71Bme8odH+dR1JYUe6I9qRoKXWkQyaqgRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781432883; x=1782037683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzePJ3jQDgqzUoVchbve1mIf57FTjpX6L66SunK2+KA=;
 b=Q8eI3t+sgbadjyXRfb4dov0sw/SKE/J1wDs58l0pJPcqN6pjzatUP/dhx6gnbwT8f5
 iAP6A3iXdzxj50lZ+bSw7rJA/4BmLw8r2YIFrfxxkGSXMKH4ubKXDHS4Hyx19rV6lbwH
 FAmXcLpKlEE/yE01PVSVCntxF7LIkI+wZlS3zwRk5kkuFCs4N9RrIY7hOh14X7M3MgBc
 MIGPuUvP9rfIfY9btL5BvUtuuVUMQRrBelqNMyzWMnBgGIW1oZDZ/NiS2LdXlphf1+QU
 zkpCuBZfW2Unm+9kdc/pn+aqe6q/qyEdWPyFr6EQyvKUZwh86X4tT93SY2EmKWxW+crW
 q/7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XISwsO/Ri2aMo0LUT+jtQtP1fF6uC4jT+8uWE8aPTaobw9s18OObQy0pTvj7Ap213BXZqwUh0C6E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRxucIU6/1hCtPEHFCfg0QGYLDthdPynNaU9C1VJxbtUKpxgEG
 uNp+YipOoq/7Dk0njNbDeU35bJSZVdRjKU/123TLUjLhAr5TP8yrZP5zpmaoUyBrYStBOWeUIVe
 xUHcIKRped7lNULzgHfoRaMWJTKlaM2qbsRy/MAa8vg==
X-Gm-Gg: Acq92OEbclEo+yHwzSrVDZ4C0cOKd0H5xO8unGjYMKdssKGTIomPQ4wrL+IGM1aGiqK
 TGv/01E3MkdBRGKccrB97i8Q3vYD3jUtpujnT2A8ZtwEF+Z39WlFLaVSN54gKT+QHyGBnypb5l2
 oJCmi4HqI1Y4FLReNc4+8E2Bu1vAAQ9FejF+gP4V4GYlVsfQSkDzB2rplnN141OdqTa43iY/JJL
 Y0QWBWOWQ6QmMrAriheSOVuI1X25EWnFvzx9wbtaJeR9yKOKTa5QjehgI8Lxtr0HIKhe6CpaAXH
 3bxodruApCgO6xeqx+yTC3UI4Z3SWCsclzQw6ykX2V3cZqbT+ccQ1ZzkdFBVQ2QLmGcLtcYlYIa
 JVLAkl4hLvvb2jFHXEsbw5bP9cxbO0Ru77j5gyAY443YDp3RbyptJaBPmN4WbUvo8AArqY0X85j
 ByLg+bi5/Yjm6ZUFV942jgt18TNt1RdXMZNRXwMAEbxgGXNEL2YwMToS1gtEMiavpQL5aZwnOEX
 XlMLZA=
X-Received: by 2002:a17:903:1a4e:b0:2c0:c940:dc32 with SMTP id
 d9443c01a7336-2c4111b93fcmr108749535ad.16.1781432883171; Sun, 14 Jun 2026
 03:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAMVG2st2udHCUHZ_2j=jNmwTAVi2Cvda0qGgH4tDZHwsGVfLKQ@mail.gmail.com>
In-Reply-To: <CAMVG2st2udHCUHZ_2j=jNmwTAVi2Cvda0qGgH4tDZHwsGVfLKQ@mail.gmail.com>
From: Daniel J Blueman <daniel@quora.org>
Date: Sun, 14 Jun 2026 18:27:50 +0800
X-Gm-Features: AVVi8CdcXb4-gMPYfo_2MKrfEemE11HwTvuMlcaF21UGcMmG1gPdvrVoSsDvb1k
Message-ID: <CAMVG2stuY5aTwfmJkL_cLDn86hfuFD+sT-LdqdmN5m21y2aL5g@mail.gmail.com>
Subject: Re: [BUG] qcom: x1: GAMMA_LUT corruption on DPMS wake
To: linux-arm-msm@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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

On Mon, 1 Jun 2026 at 13:37, Daniel J Blueman <daniel@quora.org> wrote:
> Since Adreno X1-85 GAMMA_LUT support was introduced in Linux v7.0 (eg
> Ubuntu 26.04), when waking from DPMS-off, palette corruption is
> frequently seen; this manifests as purple banding. If GNOME night
> light or similar is enabled, the visual impact is greater.
>
> Further, on larger panel monitors or laptops eg the Lenovo Yoga Slim
> 7x (2944x1840), a second INT2 block is used for the right half of the
> screen, which may remain totally blank on wake; major usability
> impact.
>
> Intuitively, the symptoms feel like the LUT SRAM clock isn't being
> driven soon enough during the wakeup, thus state loss may depend on
> silicon binning/variation or related. No such symptom is seen in
> Windows on the same hardware. I found a workaround supporting this
> mechanism is to activate the GNOME night light and adjust the slider
> to update the LUT - any black right half of the screen always
> reappears.
>
> Please can someone with X1-85 Adreno insight check the Linux clock and
> power domain behaviour around GC_EN, Layer Mixer, INTerFace and INT2
> on DPMS wake? Happy to test changes; this is a stunning platform
> otherwise.
...
> Link: https://gitlab.freedesktop.org/drm/msm/-/work_items/89

Just a heads-up on this with additional findings. Note this issue
could be the only remaining daily friction on X1 laptops with suspend,
once my video decode reboot workaround or similar is merged. Also note
in my case, without GNOME night light active, only a few LUT entries
render purple so visual artifacts often go unnoticed until a gradient
eg in an image is visible.

From DPMS wake on a dual-LM panel (>2560 pixels wide) with
INTF_5/DSPP_0 (master) and INTF_6/DSPP_1, I find DSPP_1's registers
are intermittently unresponsive just after MDSS resume. DSPP_0 doesn't
exhibit this issue, suggesting some missing slave/second unit setup,
despite booting clk_ignore_unused pd_ignore_unused.

I found the extracted Windows DSDT \_SB.PEP0.G0MD F-state EXIT block
enables disp_cc_mdss_rscc_ahb_clk and disp_cc_mdss_rscc_vsync_clk;
could this relate? RSCC being the RPMh bridge subblock. Also, could
any of the *1_CLK or MDSS_INT2_GDSC entries in dispcc-x1e80100.c lack
setup?

Does Qualcomm also see this readback failure [1]?

Thanks!
  Dan

-- [1]

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c
b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c
index 23dcbe1ce1b8..xxxxxxxxxxxx 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dspp.c
@@ -83,7 +83,7 @@ static void dpu_setup_dspp_pcc(struct dpu_hw_dspp *ctx,
 static void dpu_setup_dspp_gc(struct dpu_hw_dspp *ctx,
         struct dpu_hw_gc_lut *gc_lut)
 {
     int i = 0;
-    u32 base, reg;
+    u32 base, reg, rb;

     if (!ctx) {
         DRM_ERROR("invalid ctx\n");
@@ -113,4 +113,8 @@ static void dpu_setup_dspp_gc(struct dpu_hw_dspp *ctx,

     reg = GC_EN | ((gc_lut->flags & PGC_8B_ROUND) ? GC_8B_ROUND_EN : 0);
     DPU_REG_WRITE(&ctx->hw, base, reg);
+
+    rb = DPU_REG_READ(&ctx->hw, base);
+    if (rb != reg)
+        pr_warn("dpu_dspp_gc: dspp %u wrote %08X but read back %08X\n",
+            ctx->idx - DSPP_0, reg, rb);
 }
-- 
Daniel J Blueman
