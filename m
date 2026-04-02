Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A75CC6B03
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9343E10F060;
	Thu,  2 Apr 2026 05:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Je6fmDaN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bv6nAzKR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA7C10F060
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 05:49:30 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631M4IYO2799332
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 05:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ioNl/pbmY50Wz8O6AM4CCucRvI07piSCemk
 mE1yMrHs=; b=Je6fmDaNLeT7seeNLbvjIUiNWqzDY3swDA9r4z2vZknpE9ZL38C
 PZesqM1onMWhFrcbIVJq6Sl1NBqI70NxgPyuZVCWOnZMx/BxzhAYEtZfWesRgYer
 hWNggZg7OTvrZD68jL47A2I70OhkpUFBvT34EayelhzQYQJ8Gj7mbh5naRXqosxw
 ZniHKeefRddvbFlcMB/3tBZL3/5mVtVboox+J3eHxnzWFRh1XkT2Fmk9N5puBI8O
 eecdMgMycZDyzGon1gN/o5Fa0CU/O/eDvy8zeH8p4CMnwKG2aIEstbkmovNmrmTj
 Lynk4vwd9zGRFAVXIHTNYHx9UXStRWwcKdQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d96hk2fb3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 05:49:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b24611696eso3198295ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 22:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775108969; x=1775713769;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ioNl/pbmY50Wz8O6AM4CCucRvI07piSCemkmE1yMrHs=;
 b=bv6nAzKRae7M0dYukFifgSXK2ozpgCPBHxabPV8+J4xZF2o8Al3zxZRNbmosBHj5ih
 tuXuq69jfc4rVMsPSeMYPZQqQafnObkJpZIaiEAZSOpdwnwlU2ruuyrCuhUTM4XUddAs
 o3ZUs1zZjxk2SGAsI6IWdyv+jeAOV4Qpz9eKrZ8On8PJNTEdDL6QoCWV1KFNaEUoSfGh
 RzLRi7DDb+vsk0pTyCL0kQ9RSWwNzR9/AePrv1QMbR+PkHg+zwKbnkZGtxYC1Hil93QS
 +XydaYyIrid/5SxHpk3YOeDL63z+XVhuQhjUZbT1cBPVQpVOg0C01Yu3L42iIoZ5DpcJ
 PH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775108969; x=1775713769;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioNl/pbmY50Wz8O6AM4CCucRvI07piSCemkmE1yMrHs=;
 b=oIGEM2qvXpWAtSijFdZs4GybuEx76CV+xQj+ke8KIcyLL+K5iWGt00l444r6Xtq/c3
 V2p+ClzSzVBUm/qxbdH21I4Dnwm3xzy1WQXOaIV3PoCD4RoXnbWGmXloQFMJyWbsK2ed
 FJcl4nGit2EeJFAKxbRmLaKEgo/I7boufBLk5AI4dEKY86BViz4OfdmfxMoECQxZHtnO
 9ksiiDpaBpEb4QLPNtf85dwglLzM9T5URiFHtfWWuIRCPpyEuENBzlUs2TybhWCE6Ify
 lXv07cZ2o31HWzM1+2g1FlFaVu19jFb0R+WG5MhdD77Y67uZaZF2v0CrAIeNVbSDUFiF
 o/xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWnHN2W8+vZEYtXVEkd47pMc3lHQYWSWj8eu/6g6ovTIeG8DIOWhWK51CMN3U2TRsw5v6oBvYDOfw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPZT9ayzifRuLEiikqfOqG4iD2o647zNR2c8QLrptJmaDZDkVk
 9DquFK6+3o/OAkTSWYWYnzLy1J+0SCAx7TVJSWUU4Hk7pPAptSHjeY0Em/mbdq/9zY5ZcnDMlOc
 BrAfvl21oIFqkACj0EwLU9Zl8q/7/Zv/OlJGPE/E9uasFOi4l/9G2XaPFWGg/vJL7rgyk1V4=
X-Gm-Gg: ATEYQzznyIHQgu0X59+euITzVlugEq+nVEglIRkVbbQambqdMPwaduIE4gldlwKtT80
 nKsjansGRXvMHkjTaStkiYre9t9dfI54nTWcJtZolfpk5mZhSc42OKWdOV0hcud7c/JwqIOnQKC
 swzecmWc/O2xJqeGKJUHEefiI1siK0N240TSX72xuyvB9uBl2MyXZcufEjmktwn8dmg5DKtZY8Q
 e116yZa8EsFznI9Dnszzp/U6GthjhjGsBKxG0AOEjvyUlXEOwmBSW/74Am9iob2yOx+LCFwfBgU
 iAWIegEen/Km8IHtXfshidM9FsI2lnZ1fhlPSPTzSgbqLk4xPPjhvRZNGv9tf3deFbEC8irgpKr
 QqUVCq9e8bqbgTnWn6jDBw/NlyDCnLK8lvC5FDkbRcIq30R5fwIOdaw==
X-Received: by 2002:a05:6a20:9392:b0:39b:cbab:63d6 with SMTP id
 adf61e73a8af0-39ef71fb5b0mr6193179637.3.1775108968823; 
 Wed, 01 Apr 2026 22:49:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:9392:b0:39b:cbab:63d6 with SMTP id
 adf61e73a8af0-39ef71fb5b0mr6193159637.3.1775108968326; 
 Wed, 01 Apr 2026 22:49:28 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b5fb22sm2167747b3a.26.2026.04.01.22.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 22:49:27 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
 konrad.dybcio@oss.qualcomm.com
Subject: [PATCH v7 0/4] misc: fastrpc: Add polling mode support
Date: Thu,  2 Apr 2026 11:19:19 +0530
Message-Id: <20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0OCBTYWx0ZWRfXwTGhz4lmgWNf
 Jz3HMwphEoAhY4ZrmqKpSnpOmCuV0vDKi7gW3YWTuObPactea9DDSyDSZf4uHLYOboqr+dIhhBT
 vnXpYzGdQA1Zwqbcw3hUt/0YEZMG3JX9LfPKxSet7518VPLzgtizELK0/iykuDKMBFZQaY1zgVS
 qm/SP6T2A7UmRPYtkvYnC78povQxku2EAlkcVkb+CZVx02pOt9AKrAY7a/D4i06v7U+5TKcEM7f
 eckgRsSvhhlLRR2aGpPjbhsReDQY6ew//O7OnKueT8APo5whm6bsrLNq+koq2oSWLC/Ov9554x+
 eyvrfgGGiljSrZc2FFDFELLEkh2PalYFEzgVGhlfqhuIxYflhz3kR36qgZw7hkF4rnazgpsKsrl
 s7en7zvT/jxY4OKmWD5fBq0QqDRYypuX9AaILBcFSxGLxAS5nFwYOqS0tpVWzy9r8TveskA5OF1
 krIpPqMfS+XHWwqfezg==
X-Proofpoint-GUID: l3MnACFCXYSi3YBFHN37QOrir5L3MDIj
X-Proofpoint-ORIG-GUID: l3MnACFCXYSi3YBFHN37QOrir5L3MDIj
X-Authority-Analysis: v=2.4 cv=e9ULiKp/ c=1 sm=1 tr=0 ts=69ce0369 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FeUw2I9XaFYL6OdlDaEA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020048
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

This patch series adds polling mode feature that have been missing in
upstream FastRPC driver.

- Add changes to move fdlist to ctx structure to avoid code duplicacy.
- Update context mask to support polling mode.
- Add changes to support polling feature.

Userspace change: https://github.com/qualcomm/fastrpc/pull/258
Patch [v6]: https://lore.kernel.org/all/20260215182136.3995111-1-ekansh.gupta@oss.qualcomm.com/

Changes in v6:
  - Fixed warnings.
  - Fixed commit text.
  - Addressed clean-up comments.

Changes in v5:
  - Fixed poll memory calculation.
  - Added few formatting changes.

Changes in v5:
  - Add more details in commit text.

Changes in v4:
  - Replace hardcoded ctxid mask with GENMASK.
  - Fixed commit text.

Changes in v3:
  - Resolve compilation warning.

Changes in v2:
  - Added comments and fixed commit text.
  - Defined context id position as a macro.
  - Added new IOCTL to control polling mode as always enabling
    it might cause excess power consumption.
  - Cleaned up polling mode implementation.

Ekansh Gupta (4):
  misc: fastrpc: Move fdlist to invoke context structure
  misc: fastrpc: Replace hardcoded ctxid mask with GENMASK
  misc: fastrpc: Expand context ID mask for DSP polling mode support
  misc: fastrpc: Add polling mode support for fastRPC driver

 drivers/misc/fastrpc.c      | 154 +++++++++++++++++++++++++++++++-----
 include/uapi/misc/fastrpc.h |  10 +++
 2 files changed, 144 insertions(+), 20 deletions(-)

-- 
2.34.1

