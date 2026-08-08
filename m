Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEEAC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC2F10E65A;
	Mon, 10 Aug 2026 06:38:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QBSYvKFE";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F49F10E4BA
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 17:13:26 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8eeb4508f29so3145426d6.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786209205; x=1786814005; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tOPf2FedcS2eOFBS8+PnivGCIYlDP4XiFxFJYIs9CDY=;
 b=QBSYvKFEhlQxfR9hlZEOE7RBsxeO2/IfqUu9dS1+aeUl/T8l+4tiPHwjC/elh1Rl5C
 /URLXfgXjrHAUkaYspG/rSZzS4qybrFLVS9KRq7FZ0AOklse48waP8IxfLjR//WofVY9
 TM4IEc3Vexao5ax48ygq9fTgdzHEHxm69Vh0/rBAx6VPPHdqMsw3X9tGFHDom95Q5xYg
 YRJiaTpBD6poCHiVU6fxVIUUOwC4sr/F+Kiw0wYd91s/AJGE0wNZBHo1z54s8m6RI2CO
 K4h8fOo4kiXbQePQBjluoKC2iFzU+9J4T6iLEsAFFFSCEuk+cCF/KeumDzy48CsH02XW
 agUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786209205; x=1786814005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tOPf2FedcS2eOFBS8+PnivGCIYlDP4XiFxFJYIs9CDY=;
 b=et4DrGmhz0P4jzWudssDhdX6IS8QLlmxclhdNcUXm0PP/jomqXlUUe5SxlbbbFEivP
 vVZWHnESrn2IZbCKa6jMDEgYmVh2m1ajPy0T+wnloDOJp9EliZZ1lgyc9BqigYauCPT4
 +yJW/lFeYxoXpU3q8iJTxuEVSWfrSh/3Y/1FpyENnS/p8vgY4ccT+pCAKdG4jXezrwZ5
 +g+1GnZGCUOjcjyWZnLeJuNmZJHqJa71iXZCh0V2HwCH3GIGKXo33lzkhPyUal/MJapg
 wK9KlmKqa15lrm9yEodGNeZE7TittGHeRghlQKg2z0s+XJ+nvF5IRogFRVREGI9MNlGA
 XWpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHx40D7j+y6V38D4O7VDla+2wsX3LL68Pqi4v4dnoDV86ZcFvTDWYtg9alIHhYZbE5gEWa2iZSXt8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrtqSOChAH18d0t+bQ/2R3Zo9UXU/yEZuMgXODu/KLn4BOYmBk
 FFcm1nmmHBKZerIRFsStmEmsq5gEAWJpV+IU48Z0oSIOSuv/Tw2QoB0T
X-Gm-Gg: AR+sD13+UwLAQppsIZMndQrC6xgdCxJvFkxjO6Rf6NrowVyR04QOjLnJn/g8Ka87aKG
 hJ7mLB5RWGAJEwGuLTRDZi+pZXBymdvs86U6GFpz/U3zpPOWSDkasEU+70QXlIBrZ7iJ0Sojly9
 58bUxOH1eCn5vZqe9S1PoLZfvahg/o6o8W43d5EEThA5XCfmvnTYr0KHdnt2zNODh40Vv+P+u1z
 jzLvbpuBgo/YVMYNCkQp1kL6vxYpndrr6tABI0WWR1Rew8rswBQ5mDpBSU9EedgUGU5pRUe5ahY
 nIh0mMl7erwfohUOY7OPet7ClKGNs9EbHXg5bhvs/LJ+M0xcdoso+x0Xk0zsTPrsXTeKFJpsuk/
 jM8rgmob5ttLOIngere2pczMz0hy2LAKaPhLF1ZVwIFvUJL3m99Kz+d9VdgGN9udfLEkyvGkYhR
 TZrRYXf9qU9TVZIDYFMS3F8mWfzTt/vj79TFtrYcaVkWF5xJ/TDLhWi2QHu8bIV8TkboHCFAM7s
 5wNN6qfqtZDcEzioFiQ4oPuzU0r3RF4DoP/sSpRcizmtZlstAytuBCBOlbEoC5mXHPVnDNdRw==
X-Received: by 2002:a05:6214:4108:b0:907:888e:380c with SMTP id
 6a1803df08f44-908813741c6mr361668286d6.26.1786209204977; 
 Sat, 08 Aug 2026 10:13:24 -0700 (PDT)
Received: from JesseofTheNorth.internal ([2600:4041:502b:ea00::1408])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908a91b5899sm34499566d6.17.2026.08.08.10.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 10:13:24 -0700 (PDT)
From: Jesse Casco <jesse.casco@gmail.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, linux-phy@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: glymur eDP PHY (v8): link trains only at HBR3, all lower rates fail
Date: Sat,  8 Aug 2026 13:13:21 -0400
Message-ID: <20260808171321.133028-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

Hi Abel,

On an ASUS Zenbook A16 (UX3607OA, Snapdragon X2 Elite Extreme) the internal
eDP panel never comes up on mainline. It is the link rate: the v8 eDP PHY
appears to bring up a usable link only at HBR3.

Tested on linux-next next-20260713, next-20260803 and next-20260807, where
phy-qcom-edp.c is byte-identical -- so not a recent regression, and the May
2026 series (eDP low-vdiff LDO config, unified swing/pre-emphasis tables,
eDP/DP mode switch) is present in the tree tested here. The sweep below is
from next-20260803; the machine has since run next-20260807 as its daily
driver, where HBR3 still trains every boot.

PHY: phy@faac00, "qcom,glymur-dp-phy". Panel: SDC ATNA60HR07-0.

Rate sweep. Same kernel, same DTB, same PHY driver; only the requested link
rate forced (one line in msm_dp_panel_read_dpcd(), msm rebuilt as a module
between boots). Four lanes throughout, which the sink and the DT both allow:

  link rate     clock recovery (TPS1)   equalization (TPS2/3)   result
  1620 (RBR)    FAIL -110               -                       no link
  2700 (HBR)    FAIL -110               -                       no link
  5400 (HBR2)   pass                    FAIL -110               no link
  8100 (HBR3)   pass                    pass                    panel lights

HBR3 trains on the first attempt, every boot. At HBR2 clock recovery succeeds
and the sink then requests voltage swing 0 / pre-emphasis 1 on all four lanes
and never reports EQ done, through the full retry budget, with the driver
programming exactly what is asked each time. At HBR and RBR clock recovery
itself never completes.

Why the panel never comes up: the sink advertises HBR2 as its maximum, so msm
correctly selects the one rate that half-works.

  DPCD 0x001 MAX_LINK_RATE           = 0x00
  DPCD 0x00e TRAINING_AUX_RD_INTERVAL= 0x84   (ext receiver caps present)
  DPCD 0x2201 ext MAX_LINK_RATE      = 0x14   (HBR2)
  DPCD 0x010..0x01f SUPPORTED_LINK_RATES = 1.62 / 2.70 / 5.40 Gbps, no more
  DPCD 0x002 MAX_LANE_COUNT          = 0xc4   (4 lanes, TPS3, enhanced framing)

That advertised maximum does not close against the panel's own preferred
timing: 2880x1800 @ 120.000169 Hz, pixel clock 709.633 MHz, EDID declaring 10
bits per primary colour.

  10 bpc -> 21.29 Gbps   HBR2 4-lane = 17.28 Gbps  123%  does not fit
                         HBR3 4-lane = 25.92 Gbps   82%  fits
   8 bpc -> 17.03 Gbps   HBR2                      98.6% fits, barely

So at the depth it advertises, this panel's preferred mode cannot be carried
by the maximum link rate it advertises. It currently runs at HBR3, four lanes,
output_bpc 10, no DSC. I have not read the panel's DSC capability registers,
so I cannot rule out that HBR2 plus DSC is the intended combination -- if so,
that would explain the advertised maximum and I would be glad to be corrected.

Forcing the link above that advertised maximum is what our local tree does,
and it is why this laptop has a display at all -- but it is not a fix, which
is why I am reporting rather than sending a patch.

One observation, as a question rather than a claim: of all the revisions,
qcom_edp_com_configure_pll_v8() is the only one in which HBR2 has no PLL
programming of its own --

  rate   v4 hsclk_sel/dec_start   v6            v8 (glymur)
  1620   0x5 / 0x69               0x5 / 0x34    0x5 / 0x34
  2700   0x3 / 0x69               0x3 / 0x34    0x3 / 0x34
  5400   0x1 / 0x8c               0x1 / 0x46    0x2 / 0x4f  <- falls into 8100
  8100   0x0 / 0x69               0x0 / 0x34    0x2 / 0x4f

DP_PHY_VCO_DIV does differ between the two (0x02 vs 0x01), but
qcom_edp_set_vco_div() uses it to derive the pixel clock rather than the
serial rate. Is the shared case intentional for v8, and if not, are the
correct v8 HBR2 values available? It would not explain the RBR and HBR
failures, whose cases are distinct, so I may be looking at the wrong thing.

Ruled out by experiment here:
 - the device tree: our board file and the merged upstream one fail
   identically; link-frequencies allows 1.62/2.7/5.4/8.1 in both
 - the drivers/gpu/drm/msm/dp rework between next-20260713 and next-20260803:
   an rc6 kernel built with the 0713 dp/ directory fails the same way

Separately: when eDP training fails, msm_dp_display_atomic_disable() pushes
the idle pattern into a link that was never enabled, and on glymur that
resets the SoC. I am sending a patch for that to the msm list alongside this
report.

Happy to run any test here and capture logs over netconsole -- a retail
machine with no firmware unlock, but I can rebuild and reboot it freely.

Thanks for the glymur PHY support -- everything else in it works here.

Jesse Casco
