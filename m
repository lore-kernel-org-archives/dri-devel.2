Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FD0D58CBF
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E991C10E455;
	Mon, 23 Mar 2026 22:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iL0liLYo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UnR4gTuN";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0732A10E452
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:56:42 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqZ6N943555
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=2ZstTuHl7bih1VkM7rz3Sd
 0l8JroL3oROjL1l70Xarc=; b=iL0liLYoa0URKVpCq/SQMfpuHcjmBXZm2VUUmH
 GqA3998hdoFYMpxGvk/nvKLljTVpK6tl55hZaWymyM/q853c2FECIqGg2Elzlh24
 hRKm6UMyfAvTXFoH7jxOhvSLKtO6Wu2uGAzl9JGIRgHHzgfLQM5qBUo7GoPTpSEH
 /FfaRcCHgdPX7CYKBzxQdt1copzxbF9N/3rBWWfqibg+R4shSZcCw0beS6GjHGJa
 GMQ06y/+lUv5/GXHGccXii7QBlgsJFPQ+Q8ozu1SBlmLk76DUgKS8NfwNSHim7GD
 3/rnFZMcVBTmpDCGUyaAfdeV9ltR16YdWOBFCHA2HSiEgd9w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vkt6ka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 22:56:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b317c40acso49916211cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774306601; x=1774911401;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZstTuHl7bih1VkM7rz3Sd0l8JroL3oROjL1l70Xarc=;
 b=UnR4gTuNvyMKIe8zDdzCfgTv/vNKHT1AQhY2IbZszNoeR/l84GR6K/fTrfI7TtbA+J
 JcJ5aj15v6CwbedRMCsW7pJ9OGGQ4ZRFMm9wSry/a23XgVecfED2sYH8skBzirss7HYu
 lHyBDT82QxmvEnQYaw7iDVXrhGu7zWta17fpnxmE4FC3GXftfWILHsH6X5HRrzZgpwTd
 MirFSt8WkBB8fUJ6JF6dupXJfVcejlWBwEfqumi+Z32NOc4MoNmGtOPyBAeAGHyNWEfp
 bCEZpsJUnC+K9b1b6FeebvQS9qzCtT/jOhxI07Me2FsO6KAYMwW8vO2Xm8pFW/iofvKu
 Imxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774306601; x=1774911401;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZstTuHl7bih1VkM7rz3Sd0l8JroL3oROjL1l70Xarc=;
 b=oJxLuxIUc14/4oHcBk9uf+WSGQsLLAqKcBj7ztqvFig+iwCsyxaj3ueCeEYV9oEM4H
 EaNHR/E+zEt2+o/FXDND5uenkRBromW/L0hJG8eBQm00Tg3/sHRA28kSJEcpScJ6ixuJ
 2jOoL73QbK/fdejUm05oaKjaHu0sn+tAnisFu+4o8So2lElWvasrXEes6Fg6gNwjyZuI
 znS83CdHbFbQKVeH9AnAC6Mx69zIucMRMhp6UIofwGZZg9QeY3+qjQud99atPSaLDRcW
 WRSL5BHiIsbpD3nkersHa99kSWRHwyIVZ/miPFUDp4XsoDC5jYijHCLpPfnFOQm8o1rX
 fZjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1+c9JbM9k0DXjI6miDwj24VH0ITfVTewscb/3yMCce8AG4mtqY+bj7VDxNnTve+qgM/0AyyDLtS8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8sjmzC8VX8mmfIun4G07LtmV7U106ozw9tJIH/nH+TI1p5Y7T
 +/qzWdRpNwf5aqGYln9pXraXVRKPjYeE/2w9dapHlzXHpZJWvSJIYv8+TylkS/UgHVTXGt5xysx
 HDiF3nvTFniCvRA/1fKYUhl0aOBgUXI7+rwpdwDL8TA2NS9kldjihYjs/Q3320d3M7tI12Y4=
X-Gm-Gg: ATEYQzyw4BQPRY9gpTVg3oXuHAoS69NQwS8Ua9xeI+xRjPfKCtz5z/e+3HY+c/1lwth
 i/MMEHnmgZd1cmzXfLlYFcxiCGyPHOk4PiW2x0r8yUCUXs7dAz+WiaBjM88GhTOOnF7+eLz0ONY
 4drn3r3k1DQHFJg9NZqp9E2W0eSIKLNvpCTB+Y1Qm1pDfwAo//cv1NBwSTOmqF6eztUb5AEA0wB
 WQLgQr3BBn8wzKUciLbPGSR3//AXJKRVA4jcnFBVd8sL3Q5wVb0S83ROSW5dTDupfSYB24RMTJM
 O4gkSwDSavDTWqsQgYOnArH9G/UbqzseE1fzk30ulkDW9s57XlFqf0Ph3wsTZXgbAVIVhIHVX7H
 70BkFsCKirG9zW5utIH9uuYdBNhBtd3ImWTaymNp/C//LXwXWl+9e9LeQEXlDmQsoudS4RZ8noL
 BoyUBo00tdPnIHNVkPuVHWiG1/lKxsf87ze1s=
X-Received: by 2002:a05:622a:5a88:b0:50b:4226:9250 with SMTP id
 d75a77b69052e-50b4226a527mr199416261cf.44.1774306601118; 
 Mon, 23 Mar 2026 15:56:41 -0700 (PDT)
X-Received: by 2002:a05:622a:5a88:b0:50b:4226:9250 with SMTP id
 d75a77b69052e-50b4226a527mr199416041cf.44.1774306600639; 
 Mon, 23 Mar 2026 15:56:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2963fa304sm156489e87.27.2026.03.23.15.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 15:56:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v7 0/4] drm/msm/hdmi & phy: use generic PHY framework
Date: Tue, 24 Mar 2026 00:56:33 +0200
Message-Id: <20260324-fd-hdmi-phy-v7-0-b41dde8d83b8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLFwWkC/3XQTWrDMBAF4KsErSuj0Z/trnKP0oUsS5FobKUjV
 9QE371yIFBDuxl4A/PxmDvJDqPL5PV0J+hKzDHNNbQvJ2KDmS+OxrFmwhmXDFhP/UjDOEV6Cyu
 VcugE9H6wtiX14obOx++H9vZes8c00SWgM09DsJ53AKAFa4BDK6GnQKu34NoMBtccPlI5X+NsM
 DUJLzsbYl4Sro+ORe74TimmODvUKZLWhR2M0YqbsVXnlHPz+WWuNk1TUwfZWxX1JDQTII+EqoT
 qgHPjej2K4R9C/yaOTym6EtZ5yzqjlGzZH8S2bT+FqDUregEAAA==
X-Change-ID: 20240109-fd-hdmi-phy-44b8319fbcc7
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4684;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=wmhP025rglUx7+8vVzUuIs8KYz9sx5JxJRsRX38iJbg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwcUmgHLBp5eXLKQV/pwQik3PWswABr5/GgT8c
 /PkG0xp/hGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacHFJgAKCRCLPIo+Aiko
 1Q93B/9J9OPumurTq5B/6bIkP757/W//ayjgSu98QSIvQF2b2MDx2R1srj8w849Bri4eu1/g7bY
 Tt05hjT2ikV/thilJIv9LFpCqE/krjlnPNb/1PdEEPor1M4PZQx+yuk0pcGy2UIthcvD39LAsvi
 37MIJI97u6hdJCn6oIr3O0fal4IKvh6Qv23Cw24Xdnt6ehmacqxMybUqrcSBVHP1b5b9nOtFHdB
 hFnjU7nItBoEh1nNFdihIZPXhzCZeUow75A/YDtbGjxVL0t999eQNuEaeWts5G0FmHXyQKv2YUB
 t7xHd4LIthT+2YbPnnu2nZPLxKZbJtpQYGYWoLhDy5AjUyCV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE2OSBTYWx0ZWRfX9jfMOj1Stv4I
 g4ZXKrzmBphx86025p6o7r+J+rWcqUMTSpJNbqYsOIQI80ZesuRZRhBdJgEoNKjjL7+/Y/3RMEJ
 AUiMxthaoSgAEPAIGfFEInphk9K83m93mIGr33/iO5YNKZdo9El3SxeNHo5HOP2VcF6NzY1dpOg
 z84gQkvkm7vew3Pfes/Ef9I4pAOTABgztDMBmk8cAw70AG5qRquXHgOmlFxXXMK27mvgiXju107
 5ccmTkk1NkUp1GD+m5JoOX2X6jxBQOr39TFnLzzH3r/mlzOM5sIQcFFUR8aOtr28w5yTVp9gjXi
 ipbpjDTG8Mx+RdqtH6BGzJ1iPGyhjFuXf/zyi9H3KluI/uOdwNw+8mhPgHkoKchLIgn34cWumus
 pOLMSsjQp4pu+n4wgkMM6H7qZK3PcGXlWkMFPI53a2r6FigqCZSUipWasbJe0SRakX9v7OT/NVp
 AG0iqU+3olXFHJsUpaA==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c1c529 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=aG6DWvB8Nz23F0sxf60A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: KoXusBFkNRgfmoMeQgb9UJ01SuqehKjD
X-Proofpoint-ORIG-GUID: KoXusBFkNRgfmoMeQgb9UJ01SuqehKjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_06,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230169
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

The MSM HDMI PHYs have been using the ad-hoc approach / API instead of
using the generic API framework. Move MSM HDMI PHY drivers to
drivers/phy/qualcomm and rework them to use generic PHY framework. This
way all the QMP-related code is kept at the same place.
Also MSM8974 HDMI PHY, 28nm DSI PHY and apq8964 SATA PHY now can use
common helpers for the UNI PLL.

This also causes some design changes. Currently on MSM8996 the HDMI PLL
implements clock's set_rate(), while other HDMI PHY drivers used the
ad-hoc PHY API for setting the PLL rate (this includes in-tree MSM8960
driver and posted, but not merged, MSM8974 driver). This might result in
the PLL being set to one rate, while the rest of the PHY being tuned to
work at another rate. Adopt the latter idea and always use
phy_configure() to tune the PHY and set the PLL rate.

Merge strategy: Merge the first patch (either through drm/msm or through
the PHY tree), merge the rest of the patches in the next cycle.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v7:
- Fixed the build issue between msm8974 patches.
- Dropped even more writel / readl wrappers (now from QMP PHYs)
- Link to v6: https://lore.kernel.org/r/20260319-fd-hdmi-phy-v6-0-cefc08a55470@oss.qualcomm.com

Changes in v6:
- Changed MSM8974 HDMI PHY driver to use FIELD_PREP / FIELD_GET (Konrad)
- Fixed rate recalculation for MSM8974 HDMI PHY (Konrad)
- Dropped register read/write wrappers
- Link to v5: https://lore.kernel.org/r/20260314-fd-hdmi-phy-v5-0-58122ae96d3b@oss.qualcomm.com

Changes in v5:
- Kept only a single place which handles extp clk (after PHY power on,
  before PHY power off) (Neil)
- Inlined pm_runtime calls in the HDMI TX driver, replaced
  pm_runtime_resume_and_get() with pm_runtime_get_sync(), since
  atomic_pre_enable() can not fail.
- Renamed registers defines to drop the REG_ prefix.
- Link to v4: https://lore.kernel.org/r/20250520-fd-hdmi-phy-v4-0-fcbaa652ad75@oss.qualcomm.com

Changes in v3-v4:
- Rebased on top of linux-next, solving conflicts
- Squashed add-and-remove patches into a single git mv patch
- Dropped HDMI PHY header patch (merged upstream)

Changes in v2:
- Changed msm8960 / apq8064 to calculate register data instead of using
  fixed tables. This extends the list of supported modes.
  (Implementation is based on mdss-hdmi-pll-28lpm.c from msm-4.14).

- Fixed the reprogramming of PLL rate on apq8064.

- Merged all non-QMP HDMI PHY drivers into a common PHY_QCOM_HDMI
  driver (suggested by Rob Clark)

---
Dmitry Baryshkov (4):
      drm/msm/hdmi: switch to generic PHY subsystem
      phy: qcom: apq8064-sata: extract UNI PLL register defines
      phy: qcom-uniphy: add more registers from display PHYs
      phy: qualcomm: add MSM8974 HDMI PHY support

 drivers/gpu/drm/msm/Makefile                     |   7 -
 drivers/gpu/drm/msm/hdmi/hdmi.c                  |  58 +-
 drivers/gpu/drm/msm/hdmi/hdmi.h                  |  80 +--
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c           |  80 ++-
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c              | 225 -------
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8960.c         |  51 --
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c         | 761 ----------------------
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c         | 765 -----------------------
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8x60.c         | 141 -----
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8x74.c         |  44 --
 drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c         | 460 --------------
 drivers/gpu/drm/msm/registers/display/hdmi.xml   | 537 ----------------
 drivers/phy/qualcomm/Kconfig                     |  24 +
 drivers/phy/qualcomm/Makefile                    |  14 +
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c     |  23 +-
 drivers/phy/qualcomm/phy-qcom-hdmi-28hpm.c       | 352 +++++++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c       | 462 ++++++++++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-45nm.c        | 186 ++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.c      | 212 +++++++
 drivers/phy/qualcomm/phy-qcom-hdmi-preqmp.h      |  59 ++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-base.c    | 185 ++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8996.c | 440 +++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi-msm8998.c | 489 +++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-hdmi.h         |  49 ++
 drivers/phy/qualcomm/phy-qcom-uniphy.h           |  74 +++
 25 files changed, 2590 insertions(+), 3188 deletions(-)
---
base-commit: 95bcfacccdad8a76e02a8eaa92baaf09c879877e
change-id: 20240109-fd-hdmi-phy-44b8319fbcc7

Best regards,
--  
With best wishes
Dmitry

