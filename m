Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FC7CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 09:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D53610E030;
	Wed, 27 May 2026 09:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bxnPKlDi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AjOVzFWJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F286110E030
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:17 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64R8mWoe1167786
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Mpd19R1YYwvJuLrssRZztJKV5/zI9q/ICp3
 JoLjL8r8=; b=bxnPKlDiCAXTMnU4ohjuc7VF6sPA+3B3hERxI11IjBNNWXhpLdD
 8zfO88q3Y1dSNVz5uf3AaOUr3SItWbQfDVa1fu4P4SZgm7hqPLaA65ba3jfE4c+m
 WRnGdWcS9a6c07DRItBzLEVaEa1P5qHrJOsooIDB7W9P2c6ecoXauPSbDAxJu4LO
 IOtmXEwiLV/ibMh0hUnlpfR2XwuQvGY23kTEnfUkxhRMgT+IEP4BJb2ZqubQg+RA
 f2dsyaYzVqKJvLqT0ZSehkUVqsWsp1Z6SKUk2db7HVqywiTfz6UlMm/UZpCS2fur
 3uZNyWEHNWeC3NqSKZrcwP/767eo+8pJvDw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edfqk33qx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 09:48:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-516d1a8a6c8so55950741cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779875296; x=1780480096;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mpd19R1YYwvJuLrssRZztJKV5/zI9q/ICp3JoLjL8r8=;
 b=AjOVzFWJsxP5pP2ty4WVrOYys8ewRstTLBicl6UAIUXSm437HErJD2bFEMoznQkPD3
 sFeOYPJH1FzKBe4n4frDB/LQSfZigkgnpIxvg/jUUwHdp75r61lWU479Bx20N9OdLBIR
 /qh3YIsi6uota9MyUPFjOvwWC2UiFBgRPoApFc9XXKGJaye/pvYa3pHRnOeU+f3VSpIL
 MAh6XHntolOFuayg6MQolnfIehL2Q4rfqk1UnWA6F0uumSZHIBNKr8J8TgGnATiVVuyT
 M/sDggciQ2jY1JAZZaKg6y6BSvXMIvqmfREK7UKXto1tg4JrKsZiVOIpXIIZg/G4dsXK
 TMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779875296; x=1780480096;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mpd19R1YYwvJuLrssRZztJKV5/zI9q/ICp3JoLjL8r8=;
 b=Rp9nZFR2LOmE0bviOXEQ6sUw86fQU3o7KSLgqC38Ihlqv213CZUuKWu1DF2tZlroop
 56IOxzE31Ambtm5kK8kFofq8x3vTM4cV02LJPu9sdu4Cftmkf6gSsyC+oVBlOcTH9M2B
 fBBkfbN6xb99+3mrKG4NJIuABjpA280VjyM3bRKZlogNVYgcxzTjWAtnn8A8VDVF2plM
 MGshpHLz/YSVHZYM6nF9N86i6fLJy25fF8zst7873bC2RJ/GYYU6T1RLPRDheRV1IbhP
 wfFCaI2VJuK2DUsqNvUzOO424XtCcnkAF3fNVsUonbtpi4DGkKUVnlLEt99IMvtsem49
 lgFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dHaz+VPBmDJkgWY2cOsNhUEY9RL+lr9KFbjrX5UzN9BCDdeAR2pi8HAxr2IcR0jHvPrlZmeGCarE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJ4WknynzT7UjO/gCzIwfbopTwtpUPgz+tow38PDXHA450SnYZ
 RLxuOdHHq43ARkhyyWai+/EONF4oZGtdmWckFnsvGzrOOGU59g8bJA7npjs7JcSbeIBeiE7ePiC
 ZLiXgOnBHudtTAkjKU34s+OvcKaMIQLdMmpbnTgsE8gdB4v4XeAl8GP+nBVEmWlO4UlL1lpg=
X-Gm-Gg: Acq92OEdpd/fzyqS/tDYL3W3KeqNvHxUACxjosdPMf4TdAZAEqrfrigz+mO1QuJo9LN
 FRrZjeV+Oh063lpDP4+XxlGB0zzSgnaqD9U+msQ1t/ORJ+MnRM5dZZxEvJ7N/YULqsTQCeSFaYq
 ABnNFg6xPd+58mcYd0nAutxSNhY5OjSPoVADIjhsCekxYpDe1V7D8V/zWIOE+xrAkqWs+zkj0mS
 5XtcfE6T0ujYwZqtcuTpeo+vo+tWtXvFwaasfwlD9cPbXAbpW0iO5dQYosVGuDittTNnQpS+Z1T
 EpmDaeH45IeX3ngfEgOMn8iF+5VtE2L+5SCDeAWq9F84Cv2MOz9kqehJjjXHXIdI59m61puQTGt
 doKykj3bUuV6XK+uTHqQdm+niuaMFo/0tkId0DjcJIgEF2d10/nAK/QYQbbPibq4MKR/Igdv4Aa
 4ADQczpyqXKEbiUE0qnjMCu3XxwO32KPu3rUoQXwEfA8Qseu4=
X-Received: by 2002:a05:622a:2508:b0:516:ddc3:6248 with SMTP id
 d75a77b69052e-516ddc36855mr289924701cf.29.1779875296177; 
 Wed, 27 May 2026 02:48:16 -0700 (PDT)
X-Received: by 2002:a05:622a:2508:b0:516:ddc3:6248 with SMTP id
 d75a77b69052e-516ddc36855mr289924321cf.29.1779875295585; 
 Wed, 27 May 2026 02:48:15 -0700 (PDT)
Received: from shalem
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68a6fb31611sm544001a12.22.2026.05.27.02.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 02:48:13 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Helge Deller <deller@gmx.de>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 0/3] clk: Add __clk_disable_unprepare_counts_only() and use
 this in simple[fb|drm]
Date: Wed, 27 May 2026 11:48:08 +0200
Message-ID: <20260527094811.116977-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fqPsol4f c=1 sm=1 tr=0 ts=6a16bde1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=vk9NKK56FxHfhQgqp2gA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: lLLndVbqO1vEi8jHOFHcmKme6dGfiUkp
X-Proofpoint-GUID: lLLndVbqO1vEi8jHOFHcmKme6dGfiUkp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA5NCBTYWx0ZWRfXxZOyHZrtLZoL
 w41XFlO35Kf/xYkvHpHQYL7Dre2SzMaEGIqgTx/vUW3O++vco//LcjzEFp1nnNJSfZhwdwUbwdd
 4o4hIYbnKfn2267rRRKiz7+YdqWNUOmMzm7HRwQ5UCthhOfjpGUA1R8g3yGKKGkYIV2yKLy8nEh
 qBW/AFft0EdvP0+bUoLCgqTCD96xrI64L2ys+oLjvvNFnyN4ehlKaD4m75/fQrbaWvAIIInXPOF
 e7lbWZWXUNNneumn9tzjpq9Mi9fsREd1Up7u6nVPAH0/TGsjSTzkANN85lRwyMM8gqdj1Mmyjq5
 8oDsRYC43qpBl1+Pv6tNcjfwEbB/rGtLytJbdJuzbtQPe8FxM8xsVSibfleP8gjBcWgqfbfaAQS
 JCsUNxSj4txRmodJSP7dVEmlnGK///I746v8s31dyKDHnyeNfG/8qYary5oia1JApd9t0BAPgnY
 Mpf/U/NeMijqTp3OxoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270094
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

Hi Michael, Stephen, et al.,

The device-tree simple-framebuffer device is special in that it does not
describe actual hardware, but it allows firmware (e.g. u-boot) to pass a
firmware initialized framebuffer to the OS to use as display during boot.

To avoid clocks used by the firmware framebuffer getting touched while in
use, the DT node contains a list of clocks which should not be touched
while the simple-framebuffer is in use.

Conceptually this is fine, in practice the *do not touch* is implemented as
a clk_prepare_enable() + clk_disable_unprepare() pair, with the disabling
happening when the simple-framebuffer driver gets replaced by the real
display-engine driver.

The simple-framebuffer concept assumes that the order in which resources
are acquired does not matter since they are already on, so power-sequencing
is not an issue. But clk_disable_unprepare() actually turns the clock off,
messing with the hardware state before the real display driver loads,
without any knowledge of the proper power-off sequence for the display.

The turning off of the clocks outside of a proper power-off sequence causes
the following error when the msm display driver tries to re-enable them:

[    2.980181] disp_cc_mdss_dptx3_pixel0_clk_src: rcg didn't update its configuration.
[    2.980272] WARNING: drivers/clk/qcom/clk-rcg2.c:136 at update_config+0xdc/0x100

Resulting in a non working display.

To fix this, we need a way to properly implement the "do not touch" concept
for clocks. clk_prepare_enable() is fine, the clocks are already on so no
ordering worries and it ensures that the clocks and their parents cannot
get turned off by incrementing their enable, prepare and protect counts.

clk_disable_unprepare() is a problem though since it actually turns the
clocks off. Instead something is needed which only decrements those counts.

This series introduces a new clk-core function called
__clk_disable_unprepare_counts_only() (1) which does just that. Prefixed
with '__' to indicate that normally drivers should not use this.

Michael, Stephen sorry for needing to add a new clk-core function for this,
but I see no other way of solving this (2)(3). The changes are not that
big / not too bad.

I've also considered making __clk_disable_unprepare_counts_only() implement
all the logic itself instead of adding the extra parameter to
clk_core_unprepare() and clk_core_disable() but that leads in duplicating
quite a bit of logic (4) so this seems better.

The other 2 patches just replace the clk_disable_unprepare() calls in
the simple[fb|drm] driver with the new helper.

This series fixes the display not coming up after switching to the msm
driver when a simple-framebuffer node with clocks listed is used.

Regards,

Hans


1) I'm open to changing the name, this is the best I could come up with.

2) One option considered was detaching the simple-framebuffer driver later,
   after the real display driver has had a chance to claim the clocks. But
   this won't work in cases where the real display driver picks different
   parent clocks then the boot firmware did and needs to reparent clocks.

   Basically the goal is for things to behave as if the simple-framebuffer
   driver was not there at all, because that leaves the hw in the state
   the real display driver expects.

3) There is precedence for something like this in other places in the
   kernel, e.g. pm_runtime_put_noidle() and the power_off parameter
   to dev_pm_domain_detach()

4) With the risk of the 2 copies of that logic diverging over time.



Hans de Goede (3):
  clk: Add __clk_disable_unprepare_counts_only() helper
  drm/sysfb: simpledrm: Use __clk_disable_unprepare_counts_only()
  fbdev: simplefb: Use __clk_disable_unprepare_counts_only()

 drivers/clk/clk.c                 | 41 ++++++++++++++++++++++---------
 drivers/gpu/drm/sysfb/simpledrm.c |  4 +--
 drivers/video/fbdev/simplefb.c    |  2 +-
 include/linux/clk.h               | 14 +++++++++++
 4 files changed, 46 insertions(+), 15 deletions(-)

-- 
2.54.0

