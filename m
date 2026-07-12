Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98183C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 11:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8836988A3E;
	Sun, 12 Jul 2026 11:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=quora.org header.i=@quora.org header.b="CQYNxzha";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C0C710E0E6
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 11:50:10 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so1120470a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 04:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783857010; cv=none;
 d=google.com; s=arc-20260327;
 b=W72aZ+DQ1pyvkX9BByKwVohvT9XiflyF6iJ/yLlS82ZEOcI1+sZ607P50QZ5LX4qVe
 UhCKG+6+Q2/o2KOHjWpzL5qaSFmVslPcqXTw+9jF08t3dCqErS5/TU4vA83oOz7G9peV
 XNn5XKN/nOSw6D7Mr4AtDdSW67a5w/duJWpT3Z3uXF/BDtQynw3q+TMaZr8fvOGUKljf
 RUbqFTCUHgYttz7FCSRq5GDq+0U6SgRIdclSWQv5jf4i8VzpNan+dzRLPfSXy/2Q9TXA
 SnG4GxG2xCqlNyI6bXhGwTCA6zUDfccjE6zvQI3WLkZ7pNl4Ym0f0QV8OO2Ib8CVx7vh
 yngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Sp9a2KMToJnfNko4S/JCutxocl3+KvZJzirc4K2SinU=;
 fh=ZTrV8f8o4jxOB3O25ZPk/enC8L839mUqQTFvekwuF7k=;
 b=Mnb8t79tf9spXjbWsj2Icrzbd5Zl6NJ5GXVM9SFCUXm7vx7eqknlcmQ2d46llm3VaC
 Tn5czWhfW8Blo2Gh0bHyPHDgN75NPnemRBqnuaA0ldAhrepIWzhc7hxFvF5vZV6rcV3j
 pIRDiZzCfWNOgeXnQ+scPXWIY1Y58vb12DvDZjeEAhcKyoAWxHn2gZeLuvO4C1SzrPi9
 5NCFRDFgrBrGNBL+xl+IS8DabcYzG5bwEhPke6tSFNpkMTWSCGrnYEy3lRUPNKTFRZ+M
 gP7hixFrwacvYRRq/60XerVBjRFP+rCQUU9iW4PDeDSuX+5WjIcBa7ABTay4krYFMavx
 vkTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quora.org; s=google; t=1783857010; x=1784461810; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Sp9a2KMToJnfNko4S/JCutxocl3+KvZJzirc4K2SinU=;
 b=CQYNxzhavpUIb5+nZEcmUO6kis9pn7JuDCPcGT/U7b/IH7H6t0wNLZ/Tg7XLBxbLMQ
 QECYKrTX+k4qmiZ1QF4L6FBPc57Mw/Oj5yThdOHzmuTXayrcbmn7ePnS3fFfZNN6geaS
 kMfrLJewYTMbxMDQO1RBdrWuhkmmS/b6tfG6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783857010; x=1784461810;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Sp9a2KMToJnfNko4S/JCutxocl3+KvZJzirc4K2SinU=;
 b=OWAPF/zS2JB/whFCK1W5HPTTUgyu6uIlR80rPuqKZcDlXcNvsc7EmlpMUaBvCKrSpp
 UBi17962A7bDyi8D6PH41aPVrKPGWE38gbvh6qwDIOb8YQInE7tCpnC5VtFAJCNxYXM4
 R/jVgPiNuBTFuG0ZGgHSyxcv4sWH7lJJ5qKZ1xRTUVTdvZFlEKW5txZMw6JRow+Sd3Wt
 Sc64wVOxsVhnycXS03zyNHIM50Qo9buI/2lerKO9DbsgVrkr/g0qKaR1Cb338gQQgjGu
 4QNbJIEjZ0r3QnY8wmRQcl+0GTt36C8WZME9f2U40THFB60RHyFvC1FbUKlHCQEEjen3
 H05A==
X-Forwarded-Encrypted: i=1;
 AHgh+RredHBXDjH4IDgDabGaSkduYwm8Bp/OTZSZq7tWoX6a41IXuID4K3xXInOVgKNCI2vo+KVh6GjG67M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+agc0FfQS7kCZdIpNCeEPXtOLZNWCV8PqZO3vYjPmfiiaU8jx
 pD6tXCtSbSLzMWzCMndvrz1sV44YK9k5GAdUUFh9KCE49kHtCZrBEwof4K5gVaeExuN96eLrV2m
 LDETzdgvfeSim9k9mB6qMAbcb27ANUgBFg08lKNqBtA==
X-Gm-Gg: AfdE7ckqkx5jjLHMvU3MjnLNKjc7RLfepJojXa9ZP8yyBFbsXnBPgofytsUrAatE7O0
 3OWwJYUtMZqXUOtf6fmQTaDPSJ2j0gvk9y0V3zC8YYqBnmJ0BLOmbX8YJsBzJYI7Ub+CBGIQQYz
 vKYk/H1jKjGthnPEamb0KJ9XBUxgHC34aFPe5tBIy5+qc9Yb6F4eCy0GgK+ds9KpRD5IKGisQmu
 YM41rqnJs3SUB9W2jDsJaf3o0MtKgR12yrxnFmSO9ruvcykRIPiLO5X3sjJp5jQUbePEyFdtn/A
 zo7YsTiY8tSPTIcDuFOMjSf77Na4XwGBzRtdXk6e4Pg1wxwT7PX/i3T8K3vM4eO9+NemziCmbwl
 cXSsGCWr0/vmFyp/6YeykjURrC7oPgs1ZbOetnBcUmXTmv9aRon2CaGGeQYF8P5ybAhYofPCm5m
 Pc+Y40UuJoR6Uh1BoSbwSYbyymWgYTpVsVesdK5b6zQ8tENv6jTATIUMAnBq8mHZY39Ki3syo=
X-Received: by 2002:a17:90b:314c:b0:380:94de:155e with SMTP id
 98e67ed59e1d1-38dc73c1d67mr5199069a91.5.1783857009794; Sun, 12 Jul 2026
 04:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAMVG2st2udHCUHZ_2j=jNmwTAVi2Cvda0qGgH4tDZHwsGVfLKQ@mail.gmail.com>
 <CAMVG2stuY5aTwfmJkL_cLDn86hfuFD+sT-LdqdmN5m21y2aL5g@mail.gmail.com>
In-Reply-To: <CAMVG2stuY5aTwfmJkL_cLDn86hfuFD+sT-LdqdmN5m21y2aL5g@mail.gmail.com>
From: Daniel J Blueman <daniel@quora.org>
Date: Sun, 12 Jul 2026 19:49:58 +0800
X-Gm-Features: AVVi8CfnlO117VJ3lWa7mSJR7b-rlpaw2gAO1sdjMy1bq3J7HIu3u3SqtlgnsgQ
Message-ID: <CAMVG2suBZFMbUmUaAdyOhZ=WNysecPQCD5rZpj96AUi7Au_xHw@mail.gmail.com>
Subject: Re: [BUG] qcom: x1: GAMMA_LUT corruption on DPMS wake
To: linux-arm-msm@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jun Nie <jun.nie@linaro.org>, Federico Amedeo Izzo <federico@izzo.pro>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>, 
 Val Packett <val@packett.cool>, Steev Klimaszewski <threeway@gmail.com>,
 Sean Paul <sean@poorly.run>, 
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Marijn Suijten <marijn.suijten@somainline.org>
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

On Sun, 14 Jun 2026 at 18:27, Daniel J Blueman <daniel@quora.org> wrote:
> On Mon, 1 Jun 2026 at 13:37, Daniel J Blueman <daniel@quora.org> wrote:
> > Since Adreno X1-85 GAMMA_LUT support was introduced in Linux v7.0 (eg
> > Ubuntu 26.04), when waking from DPMS-off, palette corruption is
> > frequently seen; this manifests as purple banding. If GNOME night
> > light or similar is enabled, the visual impact is greater.
> >
> > Further, on larger panel monitors or laptops eg the Lenovo Yoga Slim
> > 7x (2944x1840), a second INT2 block is used for the right half of the
> > screen, which may remain totally blank on wake; major usability
> > impact.
> >
> > Intuitively, the symptoms feel like the LUT SRAM clock isn't being
> > driven soon enough during the wakeup, thus state loss may depend on
> > silicon binning/variation or related. No such symptom is seen in
> > Windows on the same hardware. I found a workaround supporting this
> > mechanism is to activate the GNOME night light and adjust the slider
> > to update the LUT - any black right half of the screen always
> > reappears.
> >
> > Please can someone with X1-85 Adreno insight check the Linux clock and
> > power domain behaviour around GC_EN, Layer Mixer, INTerFace and INT2
> > on DPMS wake? Happy to test changes; this is a stunning platform
> > otherwise.
> ...
> > Link: https://gitlab.freedesktop.org/drm/msm/-/work_items/89
>
> Just a heads-up on this with additional findings. Note this issue
> could be the only remaining daily friction on X1 laptops with suspend,
> once my video decode reboot workaround or similar is merged. Also note
> in my case, without GNOME night light active, only a few LUT entries
> render purple so visual artifacts often go unnoticed until a gradient
> eg in an image is visible.
>
> From DPMS wake on a dual-LM panel (>2560 pixels wide) with
> INTF_5/DSPP_0 (master) and INTF_6/DSPP_1, I find DSPP_1's registers
> are intermittently unresponsive just after MDSS resume. DSPP_0 doesn't
> exhibit this issue, suggesting some missing slave/second unit setup,
> despite booting clk_ignore_unused pd_ignore_unused.

Guys, further debug reveals the Windows driver (which doesn't exhibit
the issue) doesn't use the same register access as Linux to reprogram
all LUT entries on DPMS wake. Instead, it appears to submit a DMA
descriptor to fetch LUT values which get internally loaded in a stable
manner.

Is it possible for Qualcomm to attempt a minimal fix, or share the DMA
description struct and doorbell/completion register offsets and
related so the community can?

Also, it would be good to hear if anyone with an X1E running a 7.0
kernel or newer with a 4K monitor *doesn't* see palette corruption
across DPMS sleep-wake, as this could indicate another possible
solution.

Thanks,
  Dan
-- 
Daniel J Blueman
