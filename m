Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9BEC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E6710E4D7;
	Mon, 21 Sep 2026 07:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=asseily.com header.i=@asseily.com header.b="R8/lS5qD";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB1410E0D9
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 04:01:25 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 00721157ae682-85d45ae011aso17992997b3.0
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 21:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789963284; cv=none;
 d=google.com; s=arc-20260327;
 b=GzUSMKyWb9Ncojpa4H5opGaWKaoQ7zLcRB7gSMepiX3FNkzTNF+4uE3l1wT4fqYuhV
 uy/a+Nb5L0VAqr0oKe9JZD53OrFubFLpQzETF20JCBZCse1rtBYoUH1wFLOQaVX+VIe0
 NSqHZkK5S7uYeNEEUFZTU7qq5OUHCrOIiRx0T5Q3lKAmMEnP30EeePRC0tZQ5H3zrSlI
 D1hWrF+NgQfxVoBeQcktmfjjKi2X/cI2ii/rPxL4NysNqHjEnS6GpXiWRAFXfdiUhFjr
 bpFYyGzZX5wDlUHTrDfs/pk/6Z3AJeRWBvkC4CNJhSvbtppyb2j7x3q5QdSmjvaRjkrA
 Hf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=xjZ/julrVPkOc1J+viodVRzYcF9y3okE/px0LcKIV1E=;
 fh=2g1uKHtZDQa78zl1uuedfCSTLgiabuP6D/ZJ/HW2ov8=;
 b=GinCFxmuHVOnMAbBUCXWSSrKf4KPubQdl93HC22CFGxzsPftFGveQCSAVl4OOHG4e0
 GBLFjAYKqjk96dypN1rROu+WYoa4BsHaMDXjmdq5gGSja8woVLo++V265iGghzrTU5Fk
 mOMXJ7pvDsjrCKAoOZzXGgOUrmqP8pNjNAAuE9cvpWE5Cq1Oz/w3RTz/tHm1ENt6gA/Z
 O/um43G2CKF3VCpBxF2DAp9C6hUxT6xvnjr/mdG8DrwgexuWLQkXRUKKcBa7u/A5vhKC
 jspx21cXZtd0uzVSqqgqBXPJ2IGsg7kt5KTLFTN9E31tVjAMCdFPv6/9R0WXbgk6N9C1
 kZ2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=asseily.com; s=google; t=1789963284; x=1790568084; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xjZ/julrVPkOc1J+viodVRzYcF9y3okE/px0LcKIV1E=;
 b=R8/lS5qDTLJdkZMY6ZcCmkR2qdCsLP+kkqziyLgDQxchrIuOWgHvEeJHovH3a8yHvC
 mbdtvg4kUkWLL6y9qsZCMoZWiuRtyOxbzlenJ72O35do8wBw5l3wMzihyMmCF+QshDiL
 s8O7ikewOSTHikJC5BgfygZor8BX9tHyskLXebPlJWr7jSE1qJg2KFGDS9U/sM3u7q4L
 +ciGPXFiI7RG92Y4zhW4RbXTbxNz7GBo0qrNV3ToJbHV38iDVIfofgLrAxgFmEQnd/q7
 E24CqVu1kELt2t0agqByVon2wCvxyQ1Namqji7Yvyg25Kqrecx21369Sx9TF17ERgjIt
 GQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789963284; x=1790568084;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xjZ/julrVPkOc1J+viodVRzYcF9y3okE/px0LcKIV1E=;
 b=AEZCL+ISsd2NqxyH/kwD8ynaGIoW7Lum4W1sOoXdOMJSmR06OR7nsVfEd6KN2Qly+N
 eYJxfjFfXbPLczjlCFR77NA1LT1mz67uUDQ+RVA9jBwqt+c8yZVsTcguRdBEjw3wz21S
 /VGAS+lK9csrp3CB/XHnXbgWXngS4v6J4M4KACUGlzOryihgaD6NMpsaEmG59ZRnNRKR
 Wi8RZ5/s6hrAIXiRdnrg68F+LMVkDdcERNLncxDzjVE1xDPUhgNDhlzTo5HruXVD7/pM
 S+k0Km0+7H8CWTh33HHGD5aQFgyAAuBi/ip3wMQYIsBLgZr8hobAIUH4bDuWZYI8jNLl
 Jg6A==
X-Gm-Message-State: AFuF++lKoAhZpd2FOyMNGVJ3Ys0pGBsjnuoLwmmMhBqJ8nk7W6aZbnPa
 PV0XOl2Mupf+3wt8Mto/88lKntb0XQXMVkGEfqPtJpYMkiLZPkyLTSzopWQtkxpt7U8l+XSOWAb
 Eb9jKoZYOjtOwD77008uxN6Qilc+qNeJd4dWq5LlgDA==
X-Gm-Gg: AYBFou0ZCtthm6y6IQNLfidwoTl12aJMLz+VC96KuFYSH/3A0hAsE672qn66rXlQs1J
 RRvgKDXWVfhvK/pYCBJR7Gi1MUEqafkIdPY4/BrbEVZ93pZ2KnbN9ew+FJMBtB8IccEIsmraiaE
 hoTHfh12yTsivvG3QkF8hldGWDnMle0Bh11Py6f72GerbX5AE3XnVVUlPNycPWFNSJ712rnPa+i
 kKVb6Nyspx4LkBaXIQNQytx9fTnMvEy+1+fSRpD8Wy/KbjeZMaBpDC0nXEBKs83Ly3RHhOGIMrn
 40vfMejeGcM5rje0jlQSoUBHn0tA53a0bpxk1b9tAOARvnNBiLYuH6ZkpQiJCGFhQrGdkqG+NzK
 pBBtejCvOT+EbUw==
X-Received: by 2002:a05:690c:399:b0:861:d4d3:513f with SMTP id
 00721157ae682-897309026ffmr30935537b3.6.1789963284391; Sun, 20 Sep 2026
 21:01:24 -0700 (PDT)
MIME-Version: 1.0
From: Karl Asseily <karl@asseily.com>
Date: Mon, 21 Sep 2026 07:01:13 +0300
X-Gm-Features: AcwNN1W2OTb_bnWhs7bjrZIJS80bxGDyPde2uFnaGYEf3coenjPKVVz3VTNjHgo
Message-ID: <CA+gvwboeDa1jj65eaGER2CqxnOWxt4s+OqXRB9Svdz9QG1Hh4Q@mail.gmail.com>
Subject: Re: [PATCH v10 00/21] Synopsys DisplayPort Controller improvements
 for Rockchip platforms
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Andy Yan <andyshrk@163.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

Hi Sebastian,

I run an RK3588 board with native DP out of usbdp_phy0 and have been
carrying parts of this series locally. Patches 3, 6 and 8 are on it and
they fixed real problems for me, so thanks for those.

The board is a custom RK3588 design, not upstream - DP0 is wired DP-only,
four lanes, no USB-C alt mode, so it is the native DP configuration your
changelog note refers to.

Two things that may be useful to you, one of them a correction to an
assumption in the v10 changelog.

1. System sleep is not broken on this platform

The changelog gives "system sleep is broken on recent Rockchip platforms"
as part of the reason for leaving the system sleep callbacks out. That is
not what I see here: S3 suspend and resume are reliable on this board.
What was broken was DP specifically, and only because the controller was
never reconfigured on the way back.

With no system sleep handling, after an S3 with a DisplayPort monitor
attached and working beforehand:

  - DW_DP_HPD_STATUS returns a stale value that reads as asserted, and
    does not change when the sink's mains lead is pulled and replaced.
    The register is not backed by a configured controller.
  - Every AUX transaction therefore clears the HPD guard and then times
    out.
  - The threaded HPD interrupt is never re-armed, so no hot-plug event is
    delivered at all. Replugging the monitor produces silence.
  - The connector settles at disconnected - the outcome of the failed
    probe rather than a statement about the cable - and the display stays
    dark until the machine is rebooted.

Unbinding and rebinding the DP device on the live machine recovers it
completely, with nothing touched at the monitor end.

2. Your runtime PM work already contains the fix

I had been carrying a local patch against the pre-series driver that
masks the interrupt on suspend and re-runs dw_dp_init_hw() plus
enable_irq() on resume. It has held for twelve deep-suspend cycles, with
the display coming back on its own every time.

Reading patch 14, that is what dw_dp_runtime_resume() already does -
clocks, hpd_sw_sel/hpd_sw_cfg, dw_dp_init_hw(), enable_irq(), and the
110 ms settle. And dw_dp_runtime_suspend() is the disable_irq() half.

So on top of your series the whole thing may be as small as adding the
system sleep pair to the ops you already have:

    static const struct dev_pm_ops dw_dp_pm_ops = {
            RUNTIME_PM_OPS(dw_dp_rockchip_runtime_suspend,
                           dw_dp_rockchip_runtime_resume, NULL)
            SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
                                pm_runtime_force_resume)
    };

To be explicit about what I have and have not tested: those twelve cycles
were with my own hand-rolled callbacks against the pre-series driver, not
with the above on top of your series. I have not tested that, and my
patch is not worth sending - it collides with patch 15 and targets a
probe path you have since restructured.

What I can offer is hardware. This board reproduces the failure reliably
and S3 is dependable on it, so if you write the system sleep ops I am
happy to test them and report back.

One other offer, unrelated: this board also appears to be a reliable
source of AUX transaction timeouts, which is the path patch 6 addresses.
I have not captured a clean trace yet. If one would be useful, tell me
what you would want in it and I will produce it.

Karl Asseily
