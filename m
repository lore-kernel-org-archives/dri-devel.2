Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C573CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731B810F604;
	Fri, 22 May 2026 14:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iY1ddCi9";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BE410E168
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:07:08 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-367cbac9c37so3840404a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779430028; x=1780034828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Lq3gUXb9qkQGbBL6A3En/oIKNPxjfDzFOS4CLMToOE=;
 b=iY1ddCi9HX2MD29UTXfbj8WM7l1I7BDP+TRSXLwLwVKSzi7Wy8L0GBgXVd/m9ltXtQ
 HAWWEwE7sYuGLlJ9LnIO/Mjb0Ly3czv+4GiDAt3O5drta2B3iAotv1mxjPU0JcqXPHxc
 kHEe0iBPqOHgk+NTxmn18gy+7w5lelO9BCY3CrKb66hZGLijLMt/honvr97izr0QPY63
 lxRR9Jb2S9Y4Ylp4z5IgmEFvjBIaYkDGNpinWDV9Gl1IaJP8zPkfVhK3jPopFPYJG4LL
 6GEaBq01wkINSdAH0iBcuIT61ty8oWnhPAF/LjnjpFF83xplKj37fRhpLclJ2puV/c47
 W5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430028; x=1780034828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Lq3gUXb9qkQGbBL6A3En/oIKNPxjfDzFOS4CLMToOE=;
 b=fEmRrHDOUwFzaDZVjoAJVk3PhsRFR8weNYl/PBOWAKVhMp9BYXTPKaYaNz0b6abHYn
 vlZTA2lA/66JKsgkXQ/KGgNimw4acV2FGIoNs1cjdPsBtJ/mqcj4fGDaR62mwrAszELp
 Qx9yrZ3oY9OzpA5hdSV85vk1V2PQKT/dD1/dD042OWx1AtXICMYhWkBRfQfl18iuf5Vg
 Kkh+laoCMSs4EC6wpQuQt0IDsnF7kUIvJMbwvu4bzvymjjsjaAVWJA7LEVfPABTU4XNU
 lGflVs5DN9nX6lcdWeInMF/LtWUuXFCZcMpl1x9xSV9oUWhA7/K09NbkYvhQQH3bfqdk
 nl6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qX/A1TX1v/GJc66qjaLswemwxp3f/mvRBlYBQsoaE1MIZ3v3qR0p15nWBzXEMWbG48Hu2m59IvIY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YziSBeva1fLk2UBPkC7H1X7wbZnX9P4yAhS/IRwdxlSH+VaWsNu
 Oq5I2IO4EW7mhPbXPMTY4ILwsb1LVNMO4bb1QuItmroP2E6esIU8qeDL
X-Gm-Gg: Acq92OHLZAXYl7UlkJYbCeIstbJGF33wIA/5+0thf+jNrE/idkfOWCtV5hXA4pXSPgb
 n/MThO0MHhSqIyuzKIUyV1crRSC6isRQNr8CXajC1as/+4ms3vUH8RbQOGDxNAxXIKmIn9FSXSe
 JOP9hoMCZSNSti8Er3hXL7IO9qJECD4O2ysqt7Qik26f0j52wAsmKthTVUDrnwebpQt6UTIQCNk
 QJz5lqyZsGOl6P3TUKQybpryfSLzLaGUi3oGQTFTS1hYcqpjlEeRfOVDJ3ONtndNlSArEnb6sDg
 TQe/gU4pmMXQZsIzzS0s1gO/FwOr2zayTDwJEJKZRQ9pxMGKbHfEb0oNfpeS9hJLOJT3EC8UUME
 MOhm2cE7WzxmASppuKWQF3KIDKcluKdx3BJVRt3ikbZ40uzstXnSyOw1Q4UYGnKaucs98PRBYYd
 B3VAevEqAMdX09Q+dBjnEqN1zsNjkxqresU6NlhnHTuGP3UzuaqGwOGW/b72F4NMdbwA==
X-Received: by 2002:a17:90b:5823:b0:366:aba:4c86 with SMTP id
 98e67ed59e1d1-36a676931aamr2338804a91.27.1779430027543; 
 Thu, 21 May 2026 23:07:07 -0700 (PDT)
Received: from radxa (122-58-25-162-adsl.sparkbb.co.nz. [122.58.25.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7212aa06sm428572a91.3.2026.05.21.23.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:07:06 -0700 (PDT)
From: Graham O'Connor <graham.oconnor@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Graham O'Connor <graham.oconnor@gmail.com>
Subject: [PATCH 0/6] arm64: qcom: Enable additional hardware on Radxa Dragon
 Q6A
Date: Fri, 22 May 2026 18:06:39 +1200
Message-ID: <20260522060645.4399-1-graham.oconnor@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:04 +0000
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

The Radxa Dragon Q6A is a compact single-board computer based on the
Qualcomm QCS6490 SoC (sc7280 family). A basic DTS for this board
already exists in mainline. This series enables the remaining hardware
and fixes platform-specific issues required for correct operation when
booting via UEFI firmware.

Patches 1-3 fix platform issues affecting QCS6490 boards booting via
UEFI firmware:

- The RSC hardware solver is left active by the UEFI firmware, causing
  a security violation if the kernel attempts to reinitialize it.
- EFI variable access requires the board compatible string in the SCM
  allowlist.
- The RA620 DP-to-HDMI bridge does not complete link training at
  voltage swing level 3. Capping at level 2 matches the vendor kernel
  behaviour and allows HDMI output to work correctly.

Patches 4-6 add DTS nodes enabling:

- GPU (Adreno 643) with clock controller and GMU
- DisplayPort output via RA620 passive DP-to-HDMI bridge
- USB3 SuperSpeed via the QMP combo PHY shared with DisplayPort

The following has been confirmed working on this board with mainline
drivers:
- KDE Plasma 6.6.5 desktop on Wayland with GPU acceleration
- HDMI display output via RA620 passive DP-to-HDMI bridge
- USB3 SuperSpeed (5Gbps confirmed via lsusb)
- OpenGL 4.6 and Vulkan 1.3 via Mesa Freedreno/Turnip
- Hardware video decode/encode via Venus (H.264, HEVC, VP9, MPEG-2)
- Audio via WCD938x codec (headphone output, microphone, HDMI audio)
- FastRPC interface to Hexagon DSP available (/dev/fastrpc-cdsp)
  though inference workloads have not been tested

With the out-of-tree AIC8800 driver for the onboard Quectel FCU760K
WiFi/BT module, all remaining hardware on the board is functional
under mainline Linux.

Tested on Radxa Dragon Q6A (QCS6490) with mainline Linux 7.0.9.



Graham O'Connor (6):
  soc: qcom: rpmh-rsc: Skip TCS init when RSC is managed by firmware
  firmware: qcom: scm: Allow EFI variable access on Radxa Dragon Q6A
  drm/msm/dp: Limit voltage swing level to 2 for RA620 bridge
  arm64: dts: qcom: qcs6490-radxa-dragon-q6a: Add regulator supplies and
    disable EUD
  arm64: dts: qcom: qcs6490-radxa-dragon-q6a: Enable GPU and display
    pipeline
  arm64: dts: qcom: qcs6490-radxa-dragon-q6a: Enable USB3 SuperSpeed

 .../dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 176 ++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c              |   1 +
 drivers/gpu/drm/msm/dp/dp_link.h              |   2 +-
 drivers/soc/qcom/rpmh-rsc.c                   |  14 ++
 4 files changed, 192 insertions(+), 1 deletion(-)

-- 
2.53.0

