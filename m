Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2DCC98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE2310E55C;
	Thu, 24 Sep 2026 21:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X1tYCmgc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y0wFYwgw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE51710E55C
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIe2CC2497506
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=nGnvZWXMboJT5WL07jHly7
 5r0lu1CZomvdfiX/iCkcg=; b=X1tYCmgcBs9GzqHf812XUBsofrXPjVwYjrwb2L
 UHoA65e8b29PKcBl17NocwC5VG7dIMjakjp24eUFZFJhPu6ysIkf8+VZIW8XoQQG
 8I8201X4tWoluXbnNmkbQCij/8F4dYQKt+SJzviOh7iK+KnprBntcZKsNSfoiMSl
 eSeaGrWSIN6wrYOAkinq7wUy07Ww51YeX5vZMVzesSgPdodDgMmuGHLKZ6ZePjw7
 HPAlJNHb36LitcBHEhwv/2DXpi7EZjhePD1rB/TSr8JNwR6RKk06LKMQrFw7ywBE
 yHxRvgqrd28wc1utHEda1Lqfp47i9H6RZzvIcZeNwkcVzbBg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw68e1hax-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:00 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1416f32fe11so674625c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790284500; x=1790889300;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nGnvZWXMboJT5WL07jHly75r0lu1CZomvdfiX/iCkcg=;
 b=Y0wFYwgwvUZI/bCjww39Et+ZGkbZZzasdkyL9jE9zYJr0RiF4yGFEE7hm7m5R2Z+az
 lZdZQsAzNZjj9Kwqr2hefZKcJFHzlxJ6Ung234yw/g91+zRpIS0ypO4CDJOU/oUcXzMR
 r0fLAgfzNBuQalhRAQSrNgGuV/SIbtkP0zo+9D/5p3Wzw6hcBnlZIfq87485bwVrHybP
 A15f0YemfVeyPVPVOo5RnbyA//bVOpqismobUTb6W1wKxUeB2opS12KehMPVCW+eRYHk
 3tRmVY1ZrshimRe+OHxMIySNs4CswtBi02Hcb8OJL70A9WAwoue6Oz/cVCZPTFOXDzki
 seFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790284500; x=1790889300;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nGnvZWXMboJT5WL07jHly75r0lu1CZomvdfiX/iCkcg=;
 b=Dg1FHUvfxxHPlIRoxomQi/EzZ3DW+3GJg0FtwjYSbXeHE+EpKYsKeJ4EcAqY0WXLv9
 NkAuzqXchcs048ANl/vHmUM1uphCQmQcfNBa39PX5yW8Pzf6qITE9ZXQ0k619lgPXpIZ
 Gf4nSMBU54K5eerexB3XNbKBFTT/gx1TdxL0g6yGOB6AjsHby6GTNq2ISHBzR2RNlzbb
 dBteP/DH8W+VB4fkVUfgsgba7OEY0Mujd2nJPjQ4mlQMQZ4mljPwcSY7Us29Ku4T//X9
 RyC9A64+qPcfMUMDtGY/U4vOqZn/kmQZEDbLToX5C52Ue0faU7XYgszGrZDC0fUP2cFE
 piyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpzkW1W5kdSgu3a6gP2aaxbrbpICxMVin1GL4dhlJjGgp7lX3ZS2FWqVRbcmHlVWKdoimffQyJCA4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kHJFQs830t/u3DuwTGGaMX7Gw6lwy6pIgmb6V45f3FYK2JluUf
 EWwfCnrGm6qx8GJUg2TOSBLJsepJ7a5pg5CbZIOHMX6ucPVrwfTUykWWzxZKCCnmlbQnMFbvdAQ
 NVtSPYNSsM6mMBahsEsCydudld6zhSTeNjftSCDg9U9Nj/dy+pAO66/U5L+4oErWheSlE/STwA7
 TrLx4=
X-Gm-Gg: AYBFou2UPoD7iywL+SeT4sFZePM62qbvC5jUmIU/+pJi8hOoYbbU/O9mUyqxjPEeOLX
 eQHKvKqZ+mUIhFqTVC4SF4qFA+dY6o7HdfdxhK9/bQT6IyaD3/OJq/UArrxii6R1sdBlRFs2TU0
 ahzGaf9Cy9IIRFESpo3DsS8WSwnpS1c4HsHTAe+yi+XwshpCLqMRh5y28/QHD1823jhmZGMDE35
 10S5q0cVwnseTzHE9NBpCGPSun2vxGEwrgnXRto5NNuLAS1xqtyTArkC0Tt3eqg6Vict9lYD6Xj
 KEp+sy+egxwLd0gySXqPw5ka0zomAwNMTtYxWl+F+NN9GPyc4HJjtqHfrUDMjzsw3dT73DDiNPB
 saW5yVhCPK1fR3iAWNDG5pNM=
X-Received: by 2002:a05:7022:fd09:b0:143:4710:a869 with SMTP id
 a92af1059eb24-14503fc15c5mr3510216c88.2.1790284500163; 
 Thu, 24 Sep 2026 14:15:00 -0700 (PDT)
X-Received: by 2002:a05:7022:fd09:b0:143:4710:a869 with SMTP id
 a92af1059eb24-14503fc15c5mr3510187c88.2.1790284499546; 
 Thu, 24 Sep 2026 14:14:59 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acc47ab8sm1323776c88.6.2026.09.24.14.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:14:59 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/5] drm/msm: Mahua GPU support
Date: Fri, 25 Sep 2026 02:44:31 +0530
Message-Id: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALeStWoC/y3MywqDMBCF4VcJs+5AMqlCfZXiItWpziLR5iKC+
 O4Ntcv/cPgOSByFE3TqgMibJFlCDXNTMMwuTIwy1gbS1OoHNejdXBxOa0F7N840rbYjWaj/NfJ
 b9p/17K+O/CmVzNcIL5cYh8V7yZ0KvGf8swT9eX4BxBlgrYwAAAA=
X-Change-ID: 20260925-mahua-gpu-341a15603d23
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790284491; l=1715;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=6IUXPSdbKOsyfWx4OSWOwiBNqzxDAfnOvLLzJ+xlzUM=;
 b=ZDEuG39y/xeorwQ7rLvMYxmR6FW0MXfI++Z1rFW9qkPnL+UFiFq4+ELnF3gGqaBqVuQBjciXU
 eSZZxq7cjqWBMVoi2tv7DRDO3k94/hha0y1i+5bnnTJRCAoufmyxkQ5
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfX94hPOlwiSvhB
 bGCt/673sxNtw3iP3PT7XQtiL0p/vzFQ/q8ifBVICeFS4vEmZqSHwm7sSb/Lqgd5qQgok7SxI1f
 YtItDbnJlePsLvvCjE/4Pd0/idKuPaB9FvA+lrhUTwOallrW9uNYKjLZNXG42BXVSfy1KKG5pml
 JG+tiirteZAqXcnoNSirjSwutXX5xq6TXg6mCrlKach5yqAF05wGq1+Em9d3xzq+J+zIIovZ5E1
 weW/eju+uhGxZDoH0U0xE/AxWKayz/iHmCkOE3AUtk8kl03gaB6RILjND2eNbdoG4+8lrsbyzdU
 Tg6NE1jPCcea54SS//rdilKue32InQFJj6BLapUHIOevpSb+y4HJ/iC19OKkwC965U+2OWBJQIL
 prxeZjKpS0BEEFxVMyZ5/qXscuunmTuXt8RbUwGs2VJLkOfgXVZgdCW+TGEOtxl5CBnJdNliJ2O
 o5QIbwUXzy1Oj5S9FJQ==
X-Proofpoint-GUID: XKQJk37t7Rc-ND5TL8B8fzp2rPnYhwwC
X-Proofpoint-ORIG-GUID: XKQJk37t7Rc-ND5TL8B8fzp2rPnYhwwC
X-Authority-Analysis: v=2.4 cv=XawcX455 c=1 sm=1 tr=0 ts=6ab592d5 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=44lFysMMeNXQ0hntYWMA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfXyA6osg1cPbO0
 SQJduwPcxw718JfiCl5TMw5yYX+eZPxa89XqYKyDaPbWMXWQPJafR7QDIRnGuYLUEcP7aHs1453
 PeWUnyizAXmIVqSRyz+yiefX0aC8NcY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240086
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

This series adds support for the Adreno X2-85 GPU present in the Mahua SoC.
It is a smaller variant of the Glymur GPU, with fewer slices and smaller
internal memories, but it shares the same register layout. As a result,
only minor changes are required to enable support for it.

The first couple of patches fix an error I introduced in the earlier
Glymur series. I incorrectly assumed the X2-85 was the GPU used in
Glymur and used it in the compatible string. I believe it is reasonable
to correct this now, considering that the Glymur DT patches were only
picked up recently.

The DT patches are for Bjorn and the remaining patches are for Rob Clark
to pick up.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Jie Zhang (5):
      dt-bindings: display/msm/gmu: Fix Glymur's compatible
      arm64: dts: qcom: glymur: fix Adreno X2-90 GMU compatible
      drm/msm/a8xx: Add Mahua GPU support
      dt-bindings: display/msm: gpu: Document Mahua GPU/GMU
      arm64: dts: qcom: mahua: Support GPU and GMU

 .../devicetree/bindings/display/msm/gmu.yaml       |  4 ++-
 .../devicetree/bindings/display/msm/gpu.yaml       |  1 +
 arch/arm64/boot/dts/qcom/glymur.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/mahua.dtsi                |  8 +++++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 42 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  7 ++--
 7 files changed, 61 insertions(+), 5 deletions(-)
---
base-commit: 1e9b8055458b92f9ebab6f39d97ade5265a0b012
change-id: 20260925-mahua-gpu-341a15603d23

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

