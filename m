Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F24CCD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 06:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378E510E1AB;
	Thu,  7 May 2026 06:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GAqcjy+U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i5rbsS23";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA8010E1AB
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 06:22:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6475wTRF1926223
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 06:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=0bYlSt7DWtFV9/30w21jcxKBV6pVHX6j/yi
 YjnHQK14=; b=GAqcjy+UyF2OdNB80Qo0WASGdve03m019NIzIpUkj3xXHgiJFH7
 +5cE8HUCJKFt/xMUjl0tGLwEx+EH3MczqQLm7lagXescsQ0dXzLaijWK+FcqXa2E
 zDdQsqCors/T+WDNVwPAYOMlZvBJ6EzyRZLL9BNs4RCAT4tqBGRn4JVmpD7WwFyN
 jxmOx0ExafeeA+rs4MhPff1Imox6K+cQVxeCDhPLy0MRH4+3oNZWMOjS574zUngy
 q8fRQR7PQguVoIrr6kfoq+zn8fL/sLsMfnHwMPUg2m3joGAdNZ8DpAJz1dY1nmNb
 mMurm5YzYr/iRJnQ71s9S2/p2dloWrqKTQA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0n2g82qv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:22:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-83565161a6eso307219b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 23:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778134972; x=1778739772;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0bYlSt7DWtFV9/30w21jcxKBV6pVHX6j/yiYjnHQK14=;
 b=i5rbsS23spOaaqbNNl2yS6fyBIOntBogWCuD1sZJGV8I7QNdNLAAXw0W/GzeWItgwL
 GvU59diiNz+usXi/vhIY6XmFrYKSyKOT5pa5t/f9sgDsNxzWVKjeNKEMj3qhoERqaYh2
 bqutBbl5QHnjdptaOulwpijlzHiLVayRFLKbpZpMt4tZkDMmx09tfcc2pPDAStVPTRQr
 NV8gFUC5zYRwYkhQEF9VTiow7SBgje6uOZUjUb+OynTRWlxz225XENahH/FPxHVgWH4x
 fPpOMlvVQKL2Xt/ocF3AtaX2z+iZip+IDxhAOnEMeNfPFm4ttb+M5RDiSxrBzUMsucqS
 Gw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778134972; x=1778739772;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bYlSt7DWtFV9/30w21jcxKBV6pVHX6j/yiYjnHQK14=;
 b=aufj6U3a4B+H4k2kRrK0zOysMzVOvEvhJe44mIt/WwSpla6FcBmPw6Eew9clo4dF+c
 GdqUS+1T90+ciF42CFeohbJKHwZbUjr7FNTLcm6XOEP1c5zbgOk8uiDanqiR903lhjyr
 5JzBv5XEAORT6vJGpJ+2hAzFsNyb1tglo0PC4bun5Bfz7vpMKiz2VpJPV8DKTs777ggz
 imXygj72lyk7Stn4dzsNyPQJQWW4c9Y1dLln3l1KPmCYpe3eTBzGXo5uF9nZkK8u0zR/
 6aVFQISj9RgXgqh6HW6toOKqTJw3BTY7xJE1oEU0AjgRa487+d+lKqdZUOMRsSYh+s51
 stFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Vyi2R675Qf7ethljlRb0XCkh1TmRiEMDWT0O1HRgsJbhvowsGYRbAij2tMb1P6BHQc19vsN3mw8U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwB4U1Smkg6EQ/K6OlSD3DxAtHrPLE1Os9isTYwCp3eOj7LO019
 WuFKpITMX5jXnCL4mOtFeC5yn1OGCFBLAMEBfdUyStvAtHQ5Dy4QJLTYL9Ec9rLTt/4chPCTWwF
 bnXuCf5dWqN+erTEwswjaiG7GgRg38fV4uzlgEAuQXyDA2vBYa0aGLoswjvFy9rakdAXYYzs=
X-Gm-Gg: AeBDiesLWRqNYW1eY583JMnEcKq858VFCUXDAJKRkTzVKD5JXAQmIdtQGIRmtFDgU8S
 wGMd54X0BTplge6bhd8C8OmTMZ+SxknBCFtL2YRHY9hr6ezv8TMpovfhJ2z/l5dO2mquj6vVdzq
 2c3KePlSbMxWEPMzu7vnKp0fV3TCX4Y8Yla7bBAxZ/vmivAuzAgWCXBk4lQ0T5Y9i3vvdBRC3Qo
 NJWIS522kOmII6uMjcACW7z2nyA2kCX/tj91KmBLCAVGXbSrw+nycby0CsEySZ0BqYeN6P12xSC
 tw79CPl4N+ZidtWaOIy2gmjGHrco9mAYIAMTLbS9t/I54/J8uX4DyU7MxmMXgIAq7rUyyMS0J13
 l6iXnDjs3A8G9ZWDR6qTGNeXK+uQL27SnPUW3gywEsYS2d4kQQSZJ5OBrB/lc7Xqk3+U6qGx8HJ
 xTJY2hryG6+0mkMLdIyl8eI9W2STjSWtdwb79UKDLwCCUwz94T/xhLPfxauA==
X-Received: by 2002:a05:6a00:2986:b0:82c:9c90:6ea0 with SMTP id
 d2e1a72fcca58-83bb630704bmr1396465b3a.3.1778134971538; 
 Wed, 06 May 2026 23:22:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:2986:b0:82c:9c90:6ea0 with SMTP id
 d2e1a72fcca58-83bb630704bmr1396426b3a.3.1778134971017; 
 Wed, 06 May 2026 23:22:51 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 23:22:50 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com, 
 kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
 konradybcio@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 jonathanh@nvidia.com, thierry.reding@kernel.org, digetx@gmail.com,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: [RFC V6 0/8] arm_scmi: vendors: Qualcomm Generic Vendor Extensions
Date: Thu,  7 May 2026 11:52:29 +0530
Message-Id: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Wv4b99fv c=1 sm=1 tr=0 ts=69fc2fbc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bK4GZpSpkxiEjqyRu_sA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: _WP2BiGWibdvKJNQ6-J5wqWkGwszKd_Z
X-Proofpoint-GUID: _WP2BiGWibdvKJNQ6-J5wqWkGwszKd_Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfX3GdSG3kjR+N+
 Uq8zR8ZnwKmJFODSRG0iI8+xSzo95aGXuLOULW7EN3hybTBHMkMn+xaQYweeYKgb1eaP8YCRv4B
 z0hkFZMLaZbUgVNekLe4TewFj1A1W2jrOqAGg18yuryS3wtzcNV9SBnIyR8MCiIrXnC7e4TVDey
 HvGYhKF2w4KJCjZA4LlIBncgUUZ5qi1CwXhmEzph9zIJSmMM/GzkgOJaznPFQc4jnRIM8h0yWry
 uBlIuOUURQSm1/7m0MUwJRmYESrParuwV7AitHO86A4yGJHVDA+uu4sh4CEW2fBR3v4mVxOIh2O
 ZYhINm0RwX/K5NNuph7TKQVXxEDptUZcOQXCbLtr5m1A5DG++VjhMQKaRELpc+SigZduO0N704q
 dqLUvLa1VLFH94GQHlHb94Yu6BJfT1Ye+hFUYQbSHEefTv7kPoFWy5cHfc0m0WU5btEAIv0ZGKx
 gOeZCF9JFmjsOG0iHmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070060
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

The QCOM SCMI vendor protocol provides a generic way of exposing a number of
Qualcomm SoC specific features (like memory bus scaling) through a mixture of
pre-determined algorithm strings and param_id pairs hosted on the SCMI
controller. On Qualcomm Glymur and Hamoa SoCs, the memlat governor and the
mechanism to control the various caches and ram is hosted on the CPU Control
Processor (CPUCP) and the method to tweak and start the governor is exposed
through the QCOM SCMI Generic Extension Protocol.

This series introduces the devfreq scmi client driver that uses the memlat
algorithm string hosted on QCOM SCMI Generic Extension Protocol to detect
memory latency workloads and control frequency/level of the various memory
buses (DDR/LLCC/DDR_QOS). The DDR/LLCC/DDR_QOS are modelled as devfreq
devices, with the governor set to remote devfreq governor. This serves as
a way to get a basic insight into the device operation through trans_stat
and provides for ways to further tweak the parameters of the remote
governor.

Transtat data for DDR/LLCC/DDR_QOS is now available in this series:

#cat llcc/trans_stat 
From  :   To
315000000 479000000 545000000 725000000 840000000 95900000010900000001211000000   time(ms)
315000000:         0         3         6         6         6         7         0        30    143956
479000000:         2         0         7         1         1         1         0         3       356
545000000:         7         6         0         5         5         0         0        10      1200
725000000:         3         0         5         0         6         1         0         6      2172
840000000:         8         2         3         2         0         4         0        12      1188
959000000:         3         0         1         2         2         0         0        13       272
1090000000:         0         0         0         0         0         0         0         0         0
1211000000:        35         4        11         5        11         8         0         0     21684
Total transition : 253

QCOM SCMI Generic Vendor protocol background:
It was found that a lot of the vendor protocol used internally was
for debug/internal development purposes that would either be super
SoC specific or had to be disabled because of some features being
fused out during production. This lead to a large number of vendor
protocol numbers being quickly consumed and were never released
either. Using a generic vendor protocol with functionality abstracted
behind algorithm strings gave us the flexibility of allowing such
functionality exist during initial development/debugging while
still being able to expose functionality like memlat once they have
matured enough. The param-ids are certainly expected to act as ABI
for algorithms strings like MEMLAT.

Thanks in advance for taking time to review the series.

Changes in v5:
 - Combining vendor protocol and the client and moving it
   back into RFC mode.
 - Introduce target_freq attr flag and TRACK_REMOTE devfreq
   governor flag.
 - Add basic remote devfreq governor to give users data like
   transtat [Dmitry]
 - Drop the current design that relies on manual parsing of
   device tree data and move those into SoC specific structs
 - Add Glymur/Mahua/Hamoa/Purwa support in the same series.

 Changes in v4:
 - Splitting the series into vendor protocol and memlat client.
 - Also the move the memlat client implementation back to RFC
   due to multiple opens.
 - Use common xfer helper to avoid code duplication [Dmitry]
 - Update enum documentation without duplicate enum info [Dmitry]
 - Update the protol attributes doc with more information. [Cristian]

Changes in v3:
 - Restructure the bindings to mimic IMX [Christian]
 - Add documentation for the qcom generic vendor protocol [Christian/Sudeep]
 - Pick up Rb tag and fixup/re-order elements of the vendor ops [Christian]
 - Follow naming convention and folder structure used by IMX
 - Add missing enum in the vendor protocol and fix documentation [Konrad]
 - Add missing enum in the scmi memlat driver and fix documentation [Konrad]
 - Add checks for max memory and monitor [Shivnandan]
 - Fix typo from START_TIMER -> STOP_TIMER [Shivnandan]
 - Make populate_physical_mask func to void [Shivnandan]
 - Remove unecessary zero set [Shivnandan]
 - Use __free(device node) in init_cpufreq-memfreqmap [Christian/Konrad]
 - Use sdev->dev.of_node directly [Christian]
 - use return dev_err_probe in multiple places [Christian]

Changes in v2:
 - Drop container dvfs memlat container node. [Rob]
 - Move scmi-memlat.yaml to protocol level given that a lot of vendors might end up
 - using the same protocol number. [Rob]
 - Replace qcom,cpulist with the standard "cpus" property. [Rob]
 - Fix up compute-type/ipm-ceil required. [Rob]
 - Make driver changes to the accommodate bindings changes. [Rob]
 - Minor fixups in subjects/coverletter.
 - Minor style fixes in dts.

Changes in v1:
 - Add missing bindings for the protocol. [Konrad/Dmitry]
 - Use alternate bindings. [Dmitry/Konrad]
 - Rebase on top of Cristian's "SCMI multiple vendor protocol support" series. [Cristian]
 - Add more documentation wherever possible. [Sudeep]
 - Replace pr_err/info with it's dev equivalents.
 - Mixed tabs and initialization cleanups in the memlat driver. [Konrad]
 - Commit message update for the memlat driver. [Dmitry]
 - Cleanups/Fixes suggested for the client driver. [Dmitry/Konrad/Cristian]
 - Use opp-tables instead of memfreq-tbl. [Dmitry/Konrad]
 - Detect physical cpu to deal with variants with reduced cpu count.
 - Add support for DDR_QOS mem_type.

Sibi Sankar (8):
  firmware: arm_scmi: Add QCOM Generic Vendor Protocol documentation
  firmware: arm_scmi: vendors: Add QCOM SCMI Generic Extensions
  PM / devfreq: Add new target_freq attribute flag for governors
  PM / devfreq: Add new track_remote flag for governors
  PM / devfreq: Add a governor for tracking remote device frequencies
  PM / devfreq: Introduce the QCOM SCMI Memlat devfreq device
  arm64: dts: qcom: glymur: Enable LLCC/DDR/DDR_QOS dvfs
  arm64: dts: qcom: hamoa: Enable LLCC/DDR/DDR_QOS dvfs

 arch/arm64/boot/dts/qcom/glymur.dtsi          |  42 ++
 arch/arm64/boot/dts/qcom/hamoa.dtsi           |   4 +
 drivers/devfreq/Kconfig                       |  21 +
 drivers/devfreq/Makefile                      |   2 +
 drivers/devfreq/devfreq.c                     |   9 +
 drivers/devfreq/governor_passive.c            |   1 +
 drivers/devfreq/governor_performance.c        |   1 +
 drivers/devfreq/governor_powersave.c          |   1 +
 drivers/devfreq/governor_remote.c             |  80 +++
 drivers/devfreq/governor_simpleondemand.c     |   1 +
 drivers/devfreq/governor_userspace.c          |   1 +
 drivers/devfreq/hisi_uncore_freq.c            |   1 +
 drivers/devfreq/scmi-qcom-memlat-cfg.h        | 473 ++++++++++++++
 drivers/devfreq/scmi-qcom-memlat-devfreq.c    | 582 ++++++++++++++++++
 drivers/devfreq/tegra30-devfreq.c             |   3 +-
 drivers/firmware/arm_scmi/Kconfig             |   1 +
 drivers/firmware/arm_scmi/Makefile            |   1 +
 .../firmware/arm_scmi/vendors/qcom/Kconfig    |  15 +
 .../firmware/arm_scmi/vendors/qcom/Makefile   |   2 +
 .../arm_scmi/vendors/qcom/qcom-generic-ext.c  | 135 ++++
 .../arm_scmi/vendors/qcom/qcom_generic.rst    | 211 +++++++
 include/linux/devfreq-governor.h              |   4 +
 include/linux/devfreq.h                       |   1 +
 include/linux/scmi_qcom_protocol.h            |  37 ++
 24 files changed, 1628 insertions(+), 1 deletion(-)
 create mode 100644 drivers/devfreq/governor_remote.c
 create mode 100644 drivers/devfreq/scmi-qcom-memlat-cfg.h
 create mode 100644 drivers/devfreq/scmi-qcom-memlat-devfreq.c
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom/Kconfig
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom/Makefile
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom/qcom-generic-ext.c
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom/qcom_generic.rst
 create mode 100644 include/linux/scmi_qcom_protocol.h


base-commit: 9d0d467c3572e93c5faa2e5906a8bbcd70b24efd
-- 
2.34.1

