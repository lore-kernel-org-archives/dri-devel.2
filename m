Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393DAC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D91C10F5B0;
	Thu,  3 Sep 2026 13:23:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bsy9TDJy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X8ujGWVL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056B710F5AC
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:23:46 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683DAPMw035513
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 13:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ddEIk0gBSlY/UOmh/O0b11
 0eqVZgbiue9Fzt5Vm/jf4=; b=Bsy9TDJyU9JA1+8EaL9MHFzlfvuK1N4Wozf1hS
 wHWIp8IbRmr1MMYh5pLElyuOOP6eQoRHHyRDMWT5MGbKQg2ucdXDP74XZL3IkbWs
 gpsAEFPepPPXfDQL1TSCEbn98bMuYFO+hCVetmSVVGXnGjRq7BlpHjGh1BNxwERj
 OKINTfcs5FOTUIZNHph3UAZ+OFn5qnkS7VMUpxYfr952n3bNO2zqrK0OX9zSMCth
 zldSbFNuy14o6OvGU8XNkVjdMBvKDO7m2qBjOiKjaibb5ceRyubFjnBjh1uPStz6
 jUo/Feaj2yxwP2S/sTwmMZbmhTPxei4jEgOEWhyCsEa1On+g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m18vc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 13:23:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so187114485a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788441824; x=1789046624;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ddEIk0gBSlY/UOmh/O0b110eqVZgbiue9Fzt5Vm/jf4=;
 b=X8ujGWVLK/ppifWVbBGzwvGAZH7HvWIUliokL4p6YK/5PrI0yMLIQH1LGk2zhPvbJZ
 oynavCq7Q93R5JU81w4W43mAhKNHvZcxufCG69I/tyaO7G0dWem+vvCNN0GqiAlFQAFq
 28KF6rAA1pIwmZC9pLtHvDhpCligt19j4j/6YGHv3D/1K+EIl3VPiIyr6137XTHIirrn
 8pdh92OPrgMLujQ+JCbcNEh9t1UtRtyE+ZvE2iURBBoKYsg+Q4h2PdqPjQaJd7W/X6vZ
 S+JNdDbvJynb8Yk69gpiYGFYyC5qomyQ8V+fLC5qGiAjBC/aVQsM4pQ8gKJGT0mOj/Cv
 0i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441824; x=1789046624;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ddEIk0gBSlY/UOmh/O0b110eqVZgbiue9Fzt5Vm/jf4=;
 b=NMlIbpSOXoQ+Au/M5ZofsN3aYKks9ctNvVjs5stP1KfocYgMyrVJ6eQU1EeSupQRvm
 1rlQKH31vFekLt5PKH9VT5kpfxL365I/MBfKZm7xRTzTYS5s1dF6KBZWaj9A49QSHvFT
 2KJ9nQf1TJXmHl81WDXOU8zRf6genUZUDOq8kNob+MpvU/sbzvNFW3TVfbr/CFFSm6df
 D+bAVU3vDTDTiaoC6ASWR6bXlbNfDzkvONwRQOFMR+T+6QnshKWHUBgQ0zCVqCIA72nr
 R+mKctfxLQBh/ljl3MdbnFk05gJ6v92aQQU5TLxKnKQGsF9nHPVHc2Ymy9uijI9K14KF
 9L+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhUr67hssNnV0HF8bPL52e2Rq8xdaopT5UM7vZSLARvJgkwO2UH71beSCVaNR8JW1U4iCcRFTBS8s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nQr0MvamxWzB+iw6sL4ytxNeyJhtKIONc7mOlAK1w9zryI9ksT
 8Aqeq6KV8d7ujEnQ60KQCl/a5PmeoZ7lQNur5hspnAMnn65GDfSisV2Mu2KiZQftLpZA7O/v03I
 X4F4K+e8PuH4dcVYsl9GP3GCSmypz72Z3fAMUmjbRvv95pQ2BiO0ylIYrZgpQ2S9LoQ5BtwI=
X-Gm-Gg: AYBFou0A9lVZErY+ka/Lw5NBGuZTT4cy0prTmvFL2bvs1BeDDD+EBsvq8mKZE3a45YT
 JdCknJUszxk9yp/l86F1RU5RjUpAOAwx2DpHPgI8scCtk4/SJsP6n7mY+bqpqdVoRfir8nJLi8k
 k+TpYnSajV1DHYSEV87VbbaDsRVR4mqWJCkoIDwXqm+VVFahhAJMPxINwNse6MINlYhu8MvN6NE
 yLlpptwkBCcNXZzNNoxQt6QS08WtkfEJ6FNF0xkU4/fHl+VlI3iyQN5y8fmehebsCliDHSYEcLR
 XDjGPm6nZUKMEsU1lQwJVNgjnEvsIxbibf5qBfsaW5VPAnJjota7vu/itKkwR35u3meju2lHzD3
 H1q0kNmnOQSNXspzZG8/F0tW27KxOvQXe098C0dIz27sB829zjLjT8g2fyIvRLgp+SOb+uNcE5i
 xCe+n5BXxZUYql
X-Received: by 2002:a05:620a:bc8:b0:939:6b87:9a62 with SMTP id
 af79cd13be357-9396b879de0mr1060431785a.38.1788441824393; 
 Thu, 03 Sep 2026 06:23:44 -0700 (PDT)
X-Received: by 2002:a05:620a:bc8:b0:939:6b87:9a62 with SMTP id
 af79cd13be357-9396b879de0mr1060422485a.38.1788441823782; 
 Thu, 03 Sep 2026 06:23:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b606da57e9sm1296480e87.83.2026.09.03.06.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:23:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/2] drm/msm: fix SMMU fault dumps
Date: Thu, 03 Sep 2026 16:23:39 +0300
Message-Id: <20260903-fd-kms-fix-smmu-v1-0-608d02491666@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANt0mWoC/0WN0Q6CMAxFf4X02SZjgyn8iuGBsaLTDHUFYkL4d
 yuY+NLkpPfeswBTCsRQZwskmgOHxyCQHzLoru1wIQxeGLTSVlVKY+/xHhn78EaOcULtC9e2fWG
 VUyCtZyL5bYvnZmee3I268TvzSyR6TaIa99jfVGebRw5GjtgFcZxsqdB5Uxnjjsaasp5zaNb1A
 2YULE67AAAA
X-Change-ID: 20260902-fd-kms-fix-smmu-2d4baaf460b0
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=RFLoJGRUYKQSl0eHpP3frDnq8eQZYV9TudlRj303MbU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqmXTdZaCsmTfhta7bjVfnWor5pfR1CHZcUmh4N
 /1g/SEMzEaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCapl03QAKCRCLPIo+Aiko
 1VHMCACNGK1ulFfyVcuyqPWadIqYosMva0O8kpB3Ia0l0XYVhStJ91zMYBqalmwUKXKTcON9F+G
 OP7Gv5JRCVa67Rwv7prBayTtuzKi9KihkpKp1Hgsab+qFJv/uAQuWpU5QpEMC/rpvq3Qo3lptXT
 IcAhWgWv8dQoxiJnQVjfy2CWDAEZs3lfevKN6vvNbM6PotKe9nh/n+4ETi0DaRPw+pRojbVwAm1
 qIbFTCV/zIsoMx/GybuAOaNww78pgW8TeshY3nLlzp/ZgFq+ZP0/fyc23FlFZXeLen4nInbciFo
 tpkXKVlCMSSDmgvuTVpDws8yLA4PKXn7iPzIuZ21Iq3XQUM2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: Oxwa_ig-Pe-kgZaX5rvTCZLxr0GQIGU5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExNiBTYWx0ZWRfXx35AKfwGoA1p
 gSSCxDQKRtdpWXm0GKFdCB25i6lK6ICsUZspRZxqBgnkQocMRZVX+I9sSQWvEkx5Gw7u47jo6YQ
 mglNnMF74oPix9JHudydvZvPveAxbsstI0auxfpYhBSozwrzM+qamHLEcYA02tg7POdA9aUFGHr
 ysrff8m07eJsWrRVQt2Z4bzJUkzGpJGbmj66Od9eRJOJgiLhHljBDOA4ZM0IYr+E6twjkC/aImd
 2Yn2H/spPzciWx6TpwpXUj4pJZfzNWqlo27yYWZbm7SnGDSnNipVCGYpwG/ZCF8d8//u/ic5+hk
 CAbAHIBo5uoaq7FTjfwbKV4Jm5zRW9BRIGY20on9TW0YwuJKhYXy1KBBk69sCnXnjAhpZ0rquOg
 GacuOC6JZjfXAVlRIpCGZjhwFOE4ghTbHK0REhiH+m98sHTwRjHXdWa0H+phMurfXZLmwI0Jyke
 9xvgvf34QRToHaB6FUQ==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a9974e1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=YykjKjUOdnYcj-ftorIA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExNiBTYWx0ZWRfXyGNXM7vhjf6C
 WffK8XT5y02m7KSN95bBPMNlolu0BZG5AvqDh05rT7KGWlByJn3e/oMr5WJrbUmIh4vft0o3DWi
 24rmBnr5QFovAfMHpmY5Znw7L68GvFY=
X-Proofpoint-ORIG-GUID: Oxwa_ig-Pe-kgZaX5rvTCZLxr0GQIGU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030116
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

In several cases the drm/msm can cause an SMMU fault on modesetting (due
to the display controller still scanning the BO which is being
unmapped). Fix two cases which I stumbled upon.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (2):
      drm/msm: fix framebuffer pin refcount leak on prepare failure
      drm/msm: release scanout framebuffers only after a vblank

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  2 +-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  3 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |  2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |  2 +-
 drivers/gpu/drm/msm/msm_drv.h                      |  3 +-
 drivers/gpu/drm/msm/msm_fb.c                       | 26 ++++++-
 drivers/gpu/drm/msm/msm_kms.c                      | 88 ++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_kms.h                      | 29 +++++++
 11 files changed, 150 insertions(+), 11 deletions(-)
---
base-commit: 140b13475302601368c0cf4e193e66126a49feb3
change-id: 20260902-fd-kms-fix-smmu-2d4baaf460b0
prerequisite-change-id: 20260202-msm-ci-sm8650-bd3933b73635:v1

Best regards,
--  
With best wishes
Dmitry

