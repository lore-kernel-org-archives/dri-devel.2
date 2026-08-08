Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D53C5B56B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A5D810E655;
	Mon, 10 Aug 2026 06:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ffVqBwp+";
	dkim-atps=neutral
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF49F10E4D9
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 16:43:11 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-92e7c6ec9dbso23300685a.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786207391; x=1786812191; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lz/jE6jwP2/NdrVzpAXOIzj+A4PttFcfbpXJ2Xjln/8=;
 b=ffVqBwp+jeiI2weu8qFY/AOEqBLMxcJ9D6eSzsfJ/OTBSTPmTLVwXkckP+WVYp1btz
 0bqppiKO+8b3Ph4PsPX8KCJyxR5qg0NHEiklzxi/IHAMnBQ+Qjj7qlsbsOK1/O1gtIWp
 Quo/iQe+oLNNNbK188NImVw7gX6apdfNMu632VLeWgxiq9A1/whXTA/HIXAan8a1GzaM
 W46St0KaZOEd05e/lV0nyszCZrAoeVD32rDnvB0zPk8JWDqihCvMHZwwLFZAGFrpNqmI
 mFWaF6BfHVqIR60iAsiBR/ILNpRlWgvvscuQfQpblK0PfUw/5ogTGM/QzsVz7HYT7KEu
 ofSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786207391; x=1786812191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lz/jE6jwP2/NdrVzpAXOIzj+A4PttFcfbpXJ2Xjln/8=;
 b=KUWKzwFXIkgsFq6EgVFiZR5jCVphbj65kn9Rtn1h5CSNMv2yD9MybjeiIXvaL5Aq8x
 VGexsnA50vxq331dzpR/CNYeVGGmpAbututwYCY4+1q7eOtZ2Nn1CFCzq7dOzdhGYkgh
 5snJW/me69BMSgXNQdnJUGkDTmFLC9XWqBEnteXLnGZwG8olcDKOEISja69767FD/lXH
 +P/EqLsSE+2e8jM7Tzuo9l1sBQoDg4UvKdXalbB6fFZ6z4zKO/rRlAxnB4VO/SJhzIGz
 m2hZcrXyKia0TP8KBJFRsLAa4nkQ+spHIACpaybedXwLiCbkHU2TEZ75CpKmIFd/OIMj
 mWQw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5th5MRinLlWS72OeYATpM86s7BIFmBQ2ksn4ZpavxILXOgNHYC+mCxOE6JlE+nJrLu9jm6nsyZ04=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfqoQSu6ld1Cuf8qpqGLXK4X97ofPNkxMS2sHDLiCDSRhYiN6K
 ZuWkr3JLeYQ8XYE+v3pBaedUTJa54JJgs6DUIhk08X5ENonnZ+uM3z6h
X-Gm-Gg: AR+sD11+OpBf6ny+HyyPzQ0eNxudUqyFpVVRBsx9W4/jFjBj5SY2ynK744TPCQemek7
 lwBsg+IhcT7L+j57bw+KswmY9HGH1y9CpTwPSYRlmcEtqKdGbL0F1scYdZY6/cnLqEmXMbKaRWx
 +wvRI5Ry38xBLtyRPfyTVKBs+8ssrQ5o8V7QwdTGO+5Gx6dSroNBuqdNRknxuQufDCZLur5QFTV
 EXkmCGTtUICpCisB2wT7sOYTuE3/RhG048yRsZUDlXPWTHw23rFni3kgzoOzLQcp6UhJnRsW+l0
 VnNNj+IKCXiTUIukLIlF8Nhhyx5WV8oLRtYXtPrGsAUKX4sNc78m+ImR/ZGYSgw+KiRSy3heip6
 le+KVkZ1c7Onc8mzrgjuhLj3A9aNb2fvdvma8YpOLn5h9M91iyWNRLe9rSSv05+S+wAOw/mw7Lb
 LwYKEswPfyAdguxOy5KpSaJw3g2E19e8rbfsVS3cS1PytI64y1CwzAgBmh73ApO2NBnc5f8xxoU
 Gbu+ipDAkwl9KN8G0IvK3oC5wL4WFK8kZCSVAmjuqEQRtIPP+0YcXejUXwTxcgJKoFVz03/RRvt
 qN3hUj6ltQ==
X-Received: by 2002:a05:620a:44d2:b0:92e:6f45:dfdb with SMTP id
 af79cd13be357-93648f51d58mr3084475285a.0.1786207390576; 
 Sat, 08 Aug 2026 09:43:10 -0700 (PDT)
Received: from JesseofTheNorth.internal ([2600:4041:502b:ea00::1408])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e22695bsm402910885a.25.2026.08.08.09.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 09:43:10 -0700 (PDT)
From: Jesse Casco <jesse.casco@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, linux-phy@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: phy-qcom-qmp-combo: com_aux enable fails on a DP-only instance with
 no USB half (Snapdragon X2 Elite / glymur)
Date: Sat,  8 Aug 2026 12:41:48 -0400
Message-ID: <20260808164148.123057-1-jesse.casco@gmail.com>
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

Hi,

On the ASUS Zenbook A16 (UX3607OA, Snapdragon X2 Elite Extreme, glymur /
X2E94100) the internal HDMI output never produces a picture, and a second
problem turns that into an unusable machine. I would like verification on
the reading of both.

The failure

	Failed to enable clk 'com_aux': -16
	phy phy-88e1000.phy.7: phy init failed --> -16
	  clk_branch_toggle <- clk_branch2_enable <- qmp_combo_com_init
	    <- qmp_combo_dp_init <- phy_init

Plugging a display in afterwards produces only "phy_power_on was called
before phy_init", and the connector comes up with nothing behind it:

	                      status         EDID      modes
	nothing attached      disconnected   0 bytes   0
	display attached      connected      0 bytes   0

Why this looks like the driver and not the DT

phy@88e1000 has no DWC3 behind it. The USB controllers on this board are
a400000.usb (multiport), a600000.usb and a800000.usb; none is the tertiary
instance phy@88e1000 would pair with. That PHY is DisplayPort-only here,
and every tertiary clock sits at an enable count of 0 while the two PHYs
that do have controllers sit at 1:

	                                en prep     rate     hw  consumer
	gcc_usb3_tert_phy_com_aux_clk    0   0    19200000   Y   88e1000.phy
	gcc_usb3_tert_phy_aux_clk        0   0    19200000   N   88e1000.phy
	gcc_usb3_tert_phy_pipe_clk       0   0   125000000   N   88e1000.phy
	gcc_usb3_sec_phy_com_aux_clk     1   1    19200000   Y   fde000.phy
	gcc_usb3_prim_phy_com_aux_clk    1   1    19200000   Y   fd5000.phy

com_aux reports hw_enable = Y at an enable count of 0 -- the hardware reads
as on while nothing in the framework has enabled it, which is what I would
expect if clk_branch_toggle() polls the halt bit and times out at -EBUSY.

qmp_combo_clk_init() fetches {aux, cfg_ahb, ref, com_aux} with
devm_clk_bulk_get_optional(), and qmp_combo_com_init() enables the whole
bulk unconditionally -- including com_aux, which on this instance never
comes out of halt.

I cannot say from outside the SoC why it does not, but I can narrow it. It
is not a shared vote: gcc_usb3_tert_phy_com_aux_clk is BRANCH_HALT with
enable_reg == halt_reg == 0xe1074, its own CBCR rather than a bit in a vote
register, so enabling it waits on no other master. Its source is
gcc_usb3_tert_phy_aux_clk_src, an XO-derived RCG, at enable count 0 here
while the secondary instance's equivalent sits at 2. That leaves the
block's own power/reset state, which on the two working instances is
brought up by the DWC3 controller this one does not have. I would rather be
told the mechanism than guess at it, which is much of why I am writing.

Dropping com_aux from that node's clocks/clock-names makes the PHY
initialise cleanly: no clk-branch warnings, EDID 0 -> 512 bytes, modes
0 -> 32. That is legal, since the bulk get is _optional and cfg_ahb already
demonstrates it -- cfg_ahb is absent from all three combo PHY nodes here and
nothing complains. I do not think it is the right fix, though: the DT
describes the PHY's clocks correctly, and it is the driver that enables them
all regardless of whether the instance has a USB half.

Reproduced on the merged upstream A16 DTS

The machine daily-drives linux-next next-20260807 booting the merged board
file, e8fbbca94db7 ("arm64: dts: qcom: glymur: Add Asus Zenbook A16
(UX3607OA)"), which builds standalone. It fails identically, and everything
above is from that boot. The only local DT delta is an unrelated
arm,no-completion-irq on the SCMI transport.

Konrad, the merged commit lists the HDMI port as working, and it does not
work here, so I am sure I am missing something on my side: kernel revision,
a prerequisite, or a difference between units. One thing I can rule out --
booting your merged DTS, the board brings up all three USB controllers
including &usb_mp, so that is not it. Any pointer on what to check next
would be welcome.

Also, msm_dp_aux_transfer does not time out when the PHY is down

This is the part I would most like help with, because it turns a dead output
into a dead machine. With com_aux present, plugging a display in puts the DP
IRQ thread into uninterruptible sleep, and the compositor follows it in:

	STAT  PID   WCHAN                  COMMAND
	D     480   -                      irq/230-dp_display_isr
	Dl+   4855  msm_dp_aux_transfer    Hyprland

	# /proc/480/stack
	[<0>] msm_dp_aux_transfer+0x1e4/0x868 [msm]
	[<0>] drm_dp_dpcd_access+0x84/0x1a0 [drm_display_helper]
	[<0>] drm_dp_dpcd_probe+0x50/0x150 [drm_display_helper]
	[<0>] drm_dp_dpcd_read+0x12c/0x240 [drm_display_helper]
	[<0>] drm_dp_read_dpcd_caps+0x48/0x270 [drm_display_helper]
	[<0>] msm_dp_display_process_hpd_high.isra.0+0x50/0x240 [msm]
	[<0>] msm_dp_hpd_plug_handle.isra.0+0x84/0x198 [msm]
	[<0>] msm_dp_bridge_hpd_notify+0x94/0x2a0 [msm]

The AUX transfer is waiting on hardware that was never initialised -- the
"phy_power_on was called before phy_init" above is the same fact from the
other end -- and it never gives up. The compositor holds the DRM master lock
while stuck, so SIGKILL does not land and the session cannot be recovered.

It is not specific to hotplug: rebooting with the display attached brings
the machine up already wedged, same two tasks in the same function, with
phy_power_on-before-phy_init logged at 2.3s and 11.8s. An attached HDMI
display is enough to make the graphical session unusable from power-on, with
no user action at all. It took a cold boot with the cable out to recover.

An AUX transfer that cannot complete because the PHY is down seems like
something that should fail rather than block forever, independently of
whatever is wrong with com_aux. I have put the msm display maintainers on Cc
rather than writing separately, since both halves are the same event seen
from either side -- happy to split it out if you would rather keep the PHY
thread clean.

Environment

  - ASUS Zenbook A16 UX3607OA, Snapdragon X2 Elite Extreme (glymur/X2E94100)
  - linux-next next-20260807, merged upstream board DTS
  - HDMI chain: hdmi-connector <- Parade PS185 (simple-bridge)
    <- mdss_dp2 (af64000) <- phy@88e1000
  - Reproduces on every boot

I have the hardware and use it daily, so I am happy to test a patch or dump
any register state that would help.

I should be upfront that I am a hobbyist rather than a kernel developer, and
this work was AI-assisted. The measurements are real and reproducible;
please weigh my interpretation of them accordingly.

Thanks,

Jesse Casco
