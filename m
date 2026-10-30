Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC8606A321
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hQ6yPost;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LCpIzLy4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E3810E705;
	Fri, 30 Oct 2026 17:09:59 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5446110E140
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:38 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER3G8377953
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=VP8eLV61So8nBgWsMjbR1a
 GqDYSp4VOFYMS/WdXn87I=; b=hQ6yPostG/53jXQeHXhlQ2jxbbS+k9rtUEk5rD
 iDKomjV74zA67Y7J+EdBUiRq6DDkDqSURJb6018DbbTYuqC+7Go7ixNYA6MErWEF
 fCeqhkOEcuTAOs1PusODRWB9skMIM1HrDpdL+ep67mr5P9ptWlu6o5VbO2u6vVMn
 GImFyO9F3vOnwiHA5nFnSIqZge8vKiZUvodLTNwLXZnKKv33ne1mRUFw0q02Gz3b
 URPV6NAEfT+JFEWXOpFBHJOoU5FeUBHNH4pLDx/xGXU9bR32ssBacf2jcBm6fpfC
 wzhFYBiLc6I3MtlAsp7jIBMclDMxDndGHOg5FG3pUNTEjAjg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme7544ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:37 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1a5005fd0f8so1552153c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793380177; x=1793984977;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VP8eLV61So8nBgWsMjbR1aGqDYSp4VOFYMS/WdXn87I=;
 b=LCpIzLy40hxFUdtoETJHfQWl/IU6QUREXcbOPqdVz5vzfCBVgG6Kb5bcX3zNxfE6i2
 66gWDJvop9sLOS5CBbAH62YNsTEN+6EOUGJDy/2yhvkw2d3RkKBUD2E75iAiLPV5f/Bs
 LE2HPpvJMTJhK0ok8CyLz6hIOTen7YbkzPwsvIIWq/gMu5ScZIfiC6guQ7Y0QvRAEbTc
 Y4c+j53BFLbfH6Rz0aqJ3VTpbyrxeqhKExdfDoit7L4Y5lxev9bEdwAbv/km4Uu2q5AH
 Cw4oIo54N2CshhWb/+MwE1XOVZgMvzZ87eHcV9M7efe4qmeDAUeRQxWa8e6WXnUIeAaD
 ouog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380177; x=1793984977;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VP8eLV61So8nBgWsMjbR1aGqDYSp4VOFYMS/WdXn87I=;
 b=kjAuhQ5YzwINhLCdE5LJjmYpQsHVgbDtynQqtwafCY7NR5J4sL0Y16paxYfWFXCX5V
 gS9p5i+4QlvyIwPMpGUchNfYovLbyCAaNolFidDzUFGBK6Kvwq8GV53tO+gh92B2JL2D
 4pcaORqSSlfkSt5R6tJB3GtB5Sjq5tTtp9MszYU9VQuR1gJs0LJpogLFLg3glv+etPsI
 qEXcAlF38TUULBO/ZnYOpL5ohnACtcmPaDRHqmwBLUCtSdelqerjRkTgBciU5XMRCYaV
 +lKadneNi1vdVLmoaXZ9W5D0PcDTq4lxLl7vFjSW7kFDc1UHJUZQTk2ULAz2XrQW7ovm
 +wNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrLxULHgTRvPIoO9ldyqP7RLuwhoDZvkmf92FtDRbpuRClpyiDkaHyhG4SNRObRdfy0wT7LPFbk3g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI9kFoOmma/7473P/MzwXsMYCwdug5+CpvzV0eRQwBN9qdEiqcP
 AMVApUNH2JLGXCyHyFRTLqXVJew6DmUqRvNojwAKv+4kbKSs2uRfztLSHDoSUetMOYyKO+35Xjr
 HCr7w1TQEprR7La8T9HUdSYGxUdTRPcr2BCJ8vbcBbtgVr/w2yMOclr5QANzHmr3yGj1MvAU=
X-Gm-Gg: AYBFou2pWHwXtH/a5qqZ8w7vFHSxqgj+ahXb41ELMd6Et63oxsQ79y4EFu4bLeGekd4
 mmyUrZVSJZO/WMGsUQ6Sn9wZ9w18vE6MMKOgPEM9LdchOdHuQk7fv62X3ArjTdcumuUGHi3P9f4
 B8BHwYN1b5aweaGFl2i7cBKRr4yCTKyZH40gpI4G3kL2xWSJuxZYxjKt9QGLBXXaG6JXi18Lnyl
 duhwNSRki4+VminLLBfX4H4MOcR9yI+CCy4eTJgpDCc7yP48mDljpfH2Gl7gKfcAzxVmo8HAOFj
 GMg9zj3Wra+X6yLc1ZTsrb05F7yzEQsLwHmq8CRyAWLjDsm4RnkuL2VxG7fRipHQp/QaQg+7dRj
 Njvy+iujVZFlO+cg2pw2oWcn+tCGdNvJUPfwSvFTo4XEGMF45wtWEm4NFvp4b8OOhnCYDqMp35Q
 ==
X-Received: by 2002:a05:7022:f517:b0:193:9aa3:4758 with SMTP id
 a92af1059eb24-1ac55968b07mr3895983c88.4.1793380176693; 
 Fri, 30 Oct 2026 10:09:36 -0700 (PDT)
X-Received: by 2002:a05:7022:f517:b0:193:9aa3:4758 with SMTP id
 a92af1059eb24-1ac55968b07mr3895937c88.4.1793380175908; 
 Fri, 30 Oct 2026 10:09:35 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm9481168c88.13.2026.10.30.10.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:09:35 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 0/8] drm/msm: Attach a driver to GMU
Date: Fri, 30 Oct 2026 22:39:21 +0530
Message-Id: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHP5GoC/22OQQqDMBBFryKz7kgSW2td9R7FRdRRA1VrJooi3
 r1Ru+xm4H/4780KTNYQQxqsYGkybPrOB3UJoGh0VxOa0mdQQsXiJiXW7Yi8dAWy046wMjPmRZy
 rMhGP6C7BDz+WfH1AX9mZLQ2jZ7uzhFwzYdG3rXFp0NHscOdLoRLYB41h19vleGqSx+Lnj/75J
 4kCY4oiirV+5Nfq2TOHw6jfuyL0B7Jt277gzQVD7AAAAA==
X-Change-ID: 20260511-gmu-sync-state-fix-bc6b2d809371
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akisaira <akisaira@outlook.com>, Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Haitao Xu <haitao.xu@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793380168; l=3358;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Q9tVKdJvoMzo7EPCNlzx65XdhsylbcAoFd4MRTjQvW8=;
 b=dWXKocWqFzhBRmsCyaJEBbCB1rtkNgZCNVQq/3Dgyxw3wk03nQOeT1ZnBWHVP7HQ9tLJn1Vvl
 cyKpkVaYhVUCR1C52MZON3ApOXmQECW//2iGPb242hgvNK0K7UXN1Nu
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: Vxct8IJaRHSaX-LcVWn_GXWr9H9p6ZMY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX+4Vk/OeSGU3V
 4ShS+JJ4ZDMZPbFTrOQXDg6gRgurC2tFwnshDudKu2w2/hzXV2qSvezwGbddg3fnLi8kxp8tMLR
 0ruDm+1sGsEu6KZpN7/cv5xJNrUtnES5rWBKxvfrlipcLpcRNUrjMtHBP9mjHGqW8zoOWZpJyrP
 M9PSh0nz7utpw9m745Tk/Nhw/n8czWQYWTrwHJ6rzrgb/p5SIhtCrBi9C+6sdTaU2A3fFub4ygC
 GqTkcV6ooaCTCnglmt8f4cKEHCcL9dnxc0SOe6Yj1bjksp0SrWqCR6kulsIY9IrLxjeIWQBZTVy
 ULa4Gh/AA8WmSpL0eY4btTlvvKU9WjgPvxjGUfneQxuM91mw4TiOstym+snzn6Dp84tycbvC6JJ
 eBWdD3JGV7+Vzun8JxFTDNSzmysqj4X2EO4KpmKk5MUFQEG77QHcmw986MkJ2TTHxjWSYhgl1QV
 rKylHIwd7uQDtR4ZrnA==
X-Proofpoint-ORIG-GUID: Vxct8IJaRHSaX-LcVWn_GXWr9H9p6ZMY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX9M+5HTDOr+lO
 SLxh6KcOrYSjAc1/VPKY8JX+2vKkbxpEgoKhaBe+RpzfmqLgy/8hZkn7w9LTF381zJKk9ZFP+sA
 yFN6aH1rMleDlKIDHV1YAfDZMg7+Csc=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4cf51 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ef3994DOcC-j_uFHgC8A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300068
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the introduction of sync_state in the genpd framework, any consumer
device of GCC and GPUCC which is not bound to a driver will result in
bootup warnings like below:

[   24.362666] gcc-kaanapali 100000.clock-controller: sync_state() pending due to 3d37000.gmu
[   24.371210] gxclkctl-kaanapali 3d64000.clock-controller: sync_state() pending due to 3d37000.gmu
[   24.380268] gpucc-kaanapali 3d90000.clock-controller: sync_state() pending due to 3d37000.gmu

To silence these warnings and also to have a proper state in driver core,
attach a driver to the GMU and set it up as a component device for the drm
master device.

The first few patches are preparatory fixes. And the later patches
introduces a driver for GMU device and a couple of minor refactors.

I have ignored most of the T-b/R-b tags as there is significant code
churn in v2 when compared to v1.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v2:
- Reorder patches to move fixes to the front (Dmitry)
- New patch to remove unused gpu_ops paramer (Dmitry)
- New patch to consolidate msm_gpu_probe into msm_drv_probe
- Drop patch#2 in the v1 series as it doesn't make sense after rebase
- A new patch to pass around DRM private data via devres
- Retrieve GPU data from master's private data during GMU bind
- Move devfreq initialiation post GPU/GMU bind to avoid handling thermal
  mitigation while GMU device is not bound to the driver.
- Ensure GPU is queicent before GMU unbind.
- Link to v1: https://lore.kernel.org/r/20260513-gmu-sync-state-fix-v1-0-6e33e6aa9b4f@oss.qualcomm.com

---
Akhil P Oommen (6):
      drm/msm/adreno: Fix invalid drvdata typecast in adreno_remove()
      drm/msm/adreno/a6xx: Mark cxpd device_link as stateless
      drm/msm: Keep DRM private data separate from GPU drvdata
      drm/msm/adreno: Simplify adreno_probe()
      drm/msm: Always use component model for standalone GPU
      drm/msm: Attach a driver to the GMU

Haitao Xu (2):
      drm/msm: Remove dead gpu_ops parameter from msm_drm_init/uninit
      drm/msm: Consolidate msm_gpu_probe into msm_drv_probe

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 117 +++++++++++++++++++---------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  19 +----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |   3 -
 drivers/gpu/drm/msm/adreno/adreno_device.c |  40 ++++++----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c    |   8 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c   |   3 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c   |   9 +--
 drivers/gpu/drm/msm/dp/dp_display.c        |   4 +-
 drivers/gpu/drm/msm/dsi/dsi.c              |   4 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c            |   4 +-
 drivers/gpu/drm/msm/msm_drv.c              | 119 +++++++++++++++--------------
 drivers/gpu/drm/msm/msm_drv.h              |   9 ++-
 drivers/gpu/drm/msm/msm_gpu.c              |   3 -
 drivers/gpu/drm/msm/msm_gpu.h              |   1 +
 drivers/gpu/drm/msm/msm_gpu_devfreq.c      |   5 ++
 drivers/gpu/drm/msm/msm_kms.c              |  17 ++---
 17 files changed, 205 insertions(+), 162 deletions(-)
---
base-commit: 5fed66a6fde4dcc6a63ecec6f32e1a331dc4e1a4
change-id: 20260511-gmu-sync-state-fix-bc6b2d809371

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

