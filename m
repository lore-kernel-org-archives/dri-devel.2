Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA697C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 14:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AFB810E58E;
	Sat, 18 Jul 2026 14:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLb/8G2M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FGS6NOLk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 533DC10E542
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:21:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66IDDaXH841537
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:reply-to
 :subject:to; s=qcppdkim1; bh=qJbihdpS5pMhZFxXprWpaELXaJzDUAQpSlA
 nQGYaGus=; b=NLb/8G2M6G1oy7nK3nwILVH9ch7NkWR7pTCOKcxyA/XCn1A152/
 /7pMQxc7elw5nOijGtNTXoFcyQKXhiNpa450nOFsZkajYU8EWwwaZ82+XjRDtJAM
 ciFDQbpmDNfigp1IydDYO3MzMYPQWGwJk3SRuJo1z1DfpExw5DRES3ZvCzt8JzFE
 dnghWC15WU0ZlmUq35CgXopkGHSN+PJicGCsWwE5GCI+crtZwNEAE+7bAMpxNjsv
 IPqkVDzB9xF3kAwhL1Vdsj1gMPoJnjpyRqXwgUWJp7UmrpX8nugrLrqXA1wNmXSn
 VwQ7kqyjkF0pA957b5HNmEbVMS3tO1FTcRg==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af0wbq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:21:45 +0000 (GMT)
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-455d6f14efeso3617503fac.3
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 07:21:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784384505; cv=none;
 d=google.com; s=arc-20260327;
 b=dARSnhziF+vcdrIosZDKVjEj/PERcPyhW6/lv4SLmaRvZTVY1gKqNn7aR22kzlqsaI
 Sc/2FFquK1sizsakhLs+7NoLpvanZCCFReRvrjTXReuKmw6loD69PLXMrJ690oU3yUnY
 PwI+0uy+CyzjgWooIiOo5H3cJwjU0aQ3ZTBPRg2Iq7ZnG8dh+gIDHzqglJizgKVJxErB
 1FtHcyToU9T770p1VxghIGAFtZ1WKWG/paiqoLkqGOHhaZjPVwoW2rOzWMtlL0jHVaQS
 /gICKbK9KlmH44ZofuzG/8Jz8M0pIDcqSvILFQp2RTPGf6vdKhuDCl8fPvUKflbRepyc
 8KvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:mime-version
 :dkim-signature;
 bh=qJbihdpS5pMhZFxXprWpaELXaJzDUAQpSlAnQGYaGus=;
 fh=lUa31pXghKJJA2PenM0whbt+5Zk//abQDn787iXH3eQ=;
 b=a+4vUuhXbEewOp6wZnyfcy3HfE07fn8icM+br79Jqev3SsYtX0jQ3YZLWvopMlc4pV
 kHwNVHJFyBkHslHOArQE6bioLJUzgwoj1I6rm0+FGaNQJtb9Tob9teUKNipCjjESoVIY
 TJpKeAGEcMDrtSx3P1NXHy/LfBW3qZnPglyCLvF0D8102kBmBHoZVA4U2d5WjwKC72pE
 AxSVCfpDlUl7KpyBe50YfNHs/YUM24Fu39FKGFYglCz7s85VuGj9tExRk4BPujk/vetY
 YFLKQwHFTMZLftZorpjCSXa7bHhObBXn3kgKDHOmFg9KvOYXOXPevlt/YWj53i1XD+lu
 6jjw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784384505; x=1784989305;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qJbihdpS5pMhZFxXprWpaELXaJzDUAQpSlAnQGYaGus=;
 b=FGS6NOLk2f3Dnx+g+txV3qjnjfLRlZ23toGKNkyZRTEMfV2Bj2ls4eJ42SmxHgIJ1I
 u8ZyV727O81ilj92jZgKxHwdcS2WHyuoypuwa/wxan452Jw9OB+LtJfNdZMrPkvh66p3
 QjHFTQmHv3l6K93cbgNEOOjqbJXzvcBADRpmwI4l4LIOBKo+jfyLToA4qbsyQN6BV3Lp
 DEZM/tqoSa34RwQ0IqsGRTdITNQPNuaGoTeTODUY2+DgB75jhMSqDwEgFVGqcbWsdl+7
 Vl81jrxi7OsqgsQLLNd43PUTRze03kTM0WLv0BykslApeMH+pH8gOGimVtIePHINtieo
 HXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784384505; x=1784989305;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qJbihdpS5pMhZFxXprWpaELXaJzDUAQpSlAnQGYaGus=;
 b=W+zkFD4heSeLjv4wLRAdxIdRJPCbgByUWvQ99DKzSqmew7zjAIIwMTm7fQQXc2LePr
 9fJVEqKhTGQHnngdF8+ISBEqe4UHUIQBVICEPxfrnPcXY7ebGFYJ1eWEFb+0rHxkV2cB
 lasKfq/aa6plldLbMS0BiGLVr/GsVlbOIunjcNMEtPJcUEfD1a225YppSKx7kWE9aVS2
 rWt9h/52APvUz2QMDJCxFHzg2+7bc0WQ1LcGuT3c3UFVF9HGhe3HPu+s6sWHxb49fi85
 iCNTCULet1o8nbTTpf4BbU7/qyt7piRzlY7mx6EgQedaMI444n2Q35lKvsm5GbrMKXeU
 HeMg==
X-Gm-Message-State: AOJu0YwUl/otVyfIpIYzr79U6YF/m/ydEeTPtNEkpa8zDNajRQh5a+zu
 boTf9YibwLlp/DLAx+E+gq8Se+JYei8Gwdr/mh4yY2Vlc63HxwYvG9bImX2UxEd0Tfc4f5l9yBy
 9aMur0/s+09Js5KbWMzsIPHpSMDXAe5ZrAjVT1tdajbZfN9VkjTf4Oi4djFsXN9bA8s9hPJBPIY
 3SnTvGsR/E2apn4ftNT4Svuv3HSekqm90a+ygYpPl9t93RQQ==
X-Gm-Gg: AfdE7ckcEhL05ttB4pynbnZW9R3FDf3DFIg+ZD8tybDEvTAYjWt7K9d33WUvWLvc02i
 EKvE8EEw4u1dFgCXp7IUjG60vl1ZduHenTKTJQxMo3jm+VNyfp4Kf5TgexrNSb+od3doP9R7a88
 ZalRL4lmwuczZSXFJJn3p8gorCkJ3Nfg6CzLqlWInKJUeipA/wuOBNyHXt
X-Received: by 2002:a05:6870:36cf:b0:448:558c:d820 with SMTP id
 586e51a60fabf-4569042f516mr3046266fac.35.1784384505250; 
 Sat, 18 Jul 2026 07:21:45 -0700 (PDT)
X-Received: by 2002:a05:6870:36cf:b0:448:558c:d820 with SMTP id
 586e51a60fabf-4569042f516mr3046251fac.35.1784384504857; Sat, 18 Jul 2026
 07:21:44 -0700 (PDT)
MIME-Version: 1.0
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 07:21:33 -0700
X-Gm-Features: AUfX_mwkKFGoMcHJEmH0d92IozyRwgE3dPW85xlwmC5VF7kYwUWibss20bzR2dQ
Message-ID: <CACSVV00hU=Ab__jEErEfC9tMn5DqC9MdgTVZA6p9U3iutDyZMA@mail.gmail.com>
Subject: drm/msm: drm-msm-fixes-2026-07-18 for v7.2-rc4
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: "open list:DRM DRIVER for Qualcomm Adreno GPUs"
 <dri-devel@lists.freedesktop.org>, 
 "open list:DRM DRIVER for Qualcomm Adreno GPUs"
 <freedreno@lists.freedesktop.org>, 
 "open list:DRM DRIVER for Qualcomm Adreno GPUs"
 <linux-arm-msm@vger.kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE0OSBTYWx0ZWRfX6wX+J6boINDt
 L84liC0XyIowfekXws8fKsAxYUDKH7WdIhFqPm6toPKoVfGpYSy/zYSOsgG8u7hXDITkElQV+1b
 SWpX/zlisKq9ICDRGuWETOO1tdcemHA=
X-Proofpoint-GUID: s4nrOgxu-Vyh4nPzSEE0GUVLsRJ3j3PC
X-Proofpoint-ORIG-GUID: s4nrOgxu-Vyh4nPzSEE0GUVLsRJ3j3PC
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5b8bf9 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8 a=zdhE6EiQQNMlgiWoPcUA:9
 a=QEXdDO2ut3YA:10 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE0OSBTYWx0ZWRfX8Q06n8XNd6w7
 lprHqNrm8C3Va/VMBOu7ojgTTFo8y7w4SabrG30YQ775lCI1buIwS6aDvoddqy7nOHtNMtFzx57
 FQ4ZjGsQ6L5xx4xuKTkgI7VRclvZMxDo9Cfj0pbrSjlGj6CxthULTVgckleTOiZjN+k326I5AeD
 pkHbS1WuuVGS7zvVDYkDHv6fejRu5H9DVwXTBWJO7IJXZ69DeB61+uxlUEpAWP+yEZC5kTj5IUW
 pISipjRA1KZFpcdTjhJXXFODQQPq0RxbMPvyqlXgTtE5GjyX70IGwweg3LLW+P3JX0wtu5dVydf
 puGTUmOMS7vzq8Ie4+YVxzbrdstx80QVbiR+fPU1ON5KMjwyVqewBYFfgvi83pxoDn+tSbRGA/2
 FUDbaU+uHHDym8n6fBCFry2rTHbphbGCaxczmJZeLuyiP2Wk8a8tBTOUvTgjJH0QSt4MRu4zxu2
 toXEzeFR+6H+oP9JxWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180149
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Dave, Simona,

A few fixes for v7.2 as described below.

The following changes since commit 9a967125427e03c7ebc24d7ad26e9307e8403d4e:

  drm/msm/adreno: add Adreno 810 GPU support (2026-05-29 07:07:31 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/msm.git tags/drm-msm-fixes-2026-07-18

for you to fetch changes up to e2332abed2a4d3caa59052095dc16e4ce44791ea:

  drm/msm: Only fini scheduler after successful init (2026-07-16 13:41:36 -0700)

----------------------------------------------------------------
Fixes for v7.2-rc4:

DSI:
- Fixed the rate setting to prevent extra clock glitches
- Reverted the patch for the DSI bonded mode

DP:
- Added missing drm_edid_connector_update(), fixing the modes setting

DPU:
- Fixed the documentation warning

GPU:
- a3xx pm suspend fix
- a6xx stale rpmh fix
- recovery fix
- a621 and a663 gpu snapshot fixes
- fix irq storm with igt msm_recovery test
- few error path fixes

----------------------------------------------------------------
Alexandre MINETTE (1):
      drm/msm/a3xx: Drain VBIF before GPU suspend

Dan Carpenter (1):
      drm/msm/adreno: fix use after free on error path in a6xx_gpu_init()

Dmitry Baryshkov (1):
      Revert "drm/msm: dsi: fix PLL init in bonded mode"

Jens Glathe (1):
      drm/msm/dp: add missing drm_edid_connector_update() before
add_modes on cached EDID

Jie Zhang (5):
      drm/msm: Recover HW before retire hung submit
      drm/msm/a6xx: Fix A663 GPUCC register list for state capture
      drm/msm/a6xx: Fix A621 GPUCC register list for state capture
      drm/msm/a6xx: Fix IRQ storm during msm_recovery test
      drm/msm: Fix task_struct reference leak in recover_worker

Kavan Smith (1):
      drm/msm/dsi: round 6G byte clock rate to the PLL-achievable value

Rosen Penev (1):
      drm/msm/dpu: fix parameter name in
dpu_core_perf_adjusted_mode_clk kernel-doc

Ruoyu Wang (1):
      drm/msm: Only fini scheduler after successful init

Shivam Rawat (1):
      drm/msm/a6xx: Fix stale rpmh votes after suspend

 drivers/gpu/drm/msm/adreno/a3xx_gpu.c         | 36 ++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |  5 ++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |  5 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  8 ++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c   |  5 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h   | 12 +++++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c         |  5 +++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c |  2 +-
 drivers/gpu/drm/msm/dp/dp_panel.c             |  4 ++-
 drivers/gpu/drm/msm/dsi/dsi_host.c            | 12 +++++++++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h         |  1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c     | 18 ++++++++++++--
 drivers/gpu/drm/msm/msm_gpu.c                 |  8 ++++--
 drivers/gpu/drm/msm/msm_ringbuffer.c          |  7 +++---
 drivers/gpu/drm/msm/msm_ringbuffer.h          |  1 +
 drivers/gpu/drm/msm/registers/adreno/a3xx.xml |  2 ++
 16 files changed, 116 insertions(+), 15 deletions(-)
