Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8D4F41986
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3AA10E6C0;
	Wed, 15 Apr 2026 11:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WprX435k";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AaSFB4MT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD50210E6BD
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:50 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63F8NVYe2972280
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tFUu7w/Mdhl
 BRhU4Ur6TRUhTba4EbTByy053HqbjsgU=; b=WprX435kplAEgsQTfMPYD97BASu
 LJuAGZygo87rFdvNo8j7F5cR4oUwvHOzBwsWi49+H4zzkD/EfUVb6lT2z6hbvD7M
 CxruIwU6WJNVd1CDSlXlRlbE8ig8Z6x5smEqnSaHKERwcn2LeQ0ZaWMLX02x70PJ
 wIf2TKYmSjJm79ThdLFc7dpYgyrmC+LvPJ+XEZ9NVRPal0YYqK4fqZnLNXXSDvZS
 3igHGsSiSvwuyTy4G91e8ms4QhXeIlWQOBaNnFtNNv3C18q1k0a1smAhDnWfUgpE
 XC+p4O+nRUttCDFsxNv2lh4bzXLOt1Bv9BTkl4hz/unn/Ev9S+VjtlA8YxA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj74g8k3j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2e06219cbso47309095ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776252349; x=1776857149;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFUu7w/MdhlBRhU4Ur6TRUhTba4EbTByy053HqbjsgU=;
 b=AaSFB4MTZPOkYIpUl3t3uZBTpRc0f8Zbd1CMmWL1am0FJp0ShuaEykt7rE4YZ8iRgH
 f2FJhbBKg8KC7BQ8tcYi7pon+SZxEZTDfmEqXTlwRoRdL0iT5M85k95ARTAmXl1Ra1fK
 0s/Q8caVqa6f1VQUL0gAGrk4qTJWhagqU5YJZr4+cMSKM2ymDb8u14Hz/Xj4nZSyrmNl
 vmQ/rhiQTxIWOQgIheBFRCftK4x8ANO2RrRnx8g9IgfGaEUZc3WbpNikRqJGsqiiqqvx
 opMVuil9Xg4NsotYBgp9qINjYrd/mfiUTmMo4f/imusVuHq6kaVOVPbqNJBFXkgltD+/
 Nzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776252349; x=1776857149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFUu7w/MdhlBRhU4Ur6TRUhTba4EbTByy053HqbjsgU=;
 b=KulSXbu0aRWju4EAKT5mx+q5Ropk9zzt94f36rGI1Pt/xYYYU5WzSxV4RWc/A0m1ug
 FGJGbcq7/4/e839rzJY67WBYOV9rUl2Ye4vy/wo5uUdtM63vc3HbeLoVN/W0/F2kW866
 ubkt56IfIgV02evZSOJdy2GmDlqo/+/wyxFG1oXz64D4iiYTg7TONADFPQFiZqUzNOkY
 JJ1DL82KhG+LHuM3GL2pan2gcaouLfRjsxVeT+XRdxz7GucyNPqjZKSXuIrih5XMnRWU
 X+z2DFfvBLb4kCIWsiFG0kNGIhrcUe/3GX9OPmY2uwn3rVqKS+fzqWBd5xIC5sQGwaKz
 fiGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ97Ir6E6heT5xnel3vjagyvgIdqhZKdXrdkUUlE3KenFV22mJ0NMP5wiIEDtgDfwT00HNvsuTdWcDY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8JNswlXtoWNG3gcRhklP9WOKuL75xIxXtoJpUosQCgw7CuFt/
 Pj6MzIcUIKsH/q+a2euNHCOKfRTQ0NuDIdZvsW23VW4/ndqDk8EAzZGdYN0B0zcCK+W7aNoKPwQ
 EX6xXJN59w6FxJtr7paoqY/E7tCJvpzHZUFfw0htL/NxL1YuQtUw0Ts9Eq2ohDwJuDJOAceE=
X-Gm-Gg: AeBDieso3JjchJSXnfcG41yt/FPdyRUSmydHLiKSB+j9leixW99JD1EvSOPf5NbDVpe
 sG/H+1+M+dgKnTSpOVBIpEZ84OUc6nBvE7nQuTmI6TEmkeAdjDQrreooVMvpe2EMQYyLx5FE+vP
 S04DcjqnstdxlIXkiWL+HQ3xTCBesikdYhDwH7m25iXTaQhzht7TTUjRdRFOKYwYHnCgHt10bg4
 s1TJaIT3m1MNUMDdjNQj3MJ3hdvWesMYRfwtnDB/6tJ4O/ZYJ3Ow91t/wR0WfRMqIppndvHUcqK
 UtB5mXtwkCOr2S9DA3iKKpF/6curHLNfAxUqEos+9BVLS75hUGJf2CvNUF5Pvya8eq/b8EUXZVv
 cx9YKnWQO2ineb5Or96tMf+h0rTNApOVGcso0alLna91SNUR052vW2m6XksG1vA7U
X-Received: by 2002:a17:903:2c04:b0:2ae:c5fc:b2ef with SMTP id
 d9443c01a7336-2b2d5a558a4mr210626235ad.30.1776252348827; 
 Wed, 15 Apr 2026 04:25:48 -0700 (PDT)
X-Received: by 2002:a17:903:2c04:b0:2ae:c5fc:b2ef with SMTP id
 d9443c01a7336-2b2d5a558a4mr210625925ad.30.1776252348244; 
 Wed, 15 Apr 2026 04:25:48 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b6fd8sm26794325ad.73.2026.04.15.04.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 04:25:47 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 andersson@kernel.org
Subject: [PATCH v8 3/4] misc: fastrpc: Expand context ID mask for DSP polling
 mode support
Date: Wed, 15 Apr 2026 16:55:29 +0530
Message-Id: <20260415112530.4083240-4-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
References: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwNSBTYWx0ZWRfX+qaIFTjfjDDx
 /qBB5tVh4hHxeGOCatgnfV5Ys9noZCJ/3ye90cSP3gWza5YHU3VOpNXZpSmBgjHM3vagMy6Ro/G
 fQZjKJvYaSU3mDXPwkEwUOCEyaaSbBfZ7DBvVXoYWCtFH+anWQN4ujKr7kDtwoBGHKG0aMnmtsF
 Trqeg3CVzs4v7HjHP6XxC8ejj0VKj1ixp/eIZwrwUJDkM/efnYKRAAYRZgID1LM+sPlpcsDnLMF
 ij4X0CveuvLd/ue4pXByohi2WJDE75bKWiIVI/4uZp8YI4FN1Xq47OtjQ/3hB7jMVJsLOnyp5Vp
 KTE9NtcPfFqG/N9Rpqndg8516rA0ECMTsN4X9P1QnFQLIfv/0FfhJONiy03gocVATvT+LzpyH8M
 ixrd1mHv4PorULij1+cqSRfIkAfGoemTV+6AZFFhQ9nnoUnmwT31iwrl9pI+u7nTvuMDu0F8ket
 JUoS7I76XHfaH1x3b3w==
X-Proofpoint-ORIG-GUID: Zwi_T0iqUO5Zz7Bl1Mel-SE-eCGtfbTc
X-Authority-Analysis: v=2.4 cv=ZIfnX37b c=1 sm=1 tr=0 ts=69df75bd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=JTa3dIKMUYn8LlmgGFYA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Zwi_T0iqUO5Zz7Bl1Mel-SE-eCGtfbTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150105
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

Current FastRPC context uses a 12-bit mask:
  [ID(8 bits)][PD type(4 bits)] = GENMASK(11, 4)

This works for normal calls but fails for DSP polling mode.
Polling mode expects a 16-bit layout:
  [15:8] = context ID (8 bits)
  [7:5]  = reserved
  [4]    = async mode bit
  [3:0]  = PD type (4 bits)

If async bit (bit 4) is set, DSP disables polling. With current
mask, odd IDs can set this bit, causing DSP to skip poll updates.

Update FASTRPC_CTXID_MASK to GENMASK(15, 8) so IDs occupy upper
byte and lower byte is left for DSP flags and PD type.

Reserved bits remain unused. This change is compatible with
polling mode and does not break non-polling behavior.

Bit layout:
  [15:8] = CCCCCCCC (context ID)
  [7:5]  = xxx (reserved)
  [4]    = A (async mode)
  [3:0]  = PPPP (PD type)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 3f5d5d73be5a..c4a3547a5c7f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -38,7 +38,7 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
-#define FASTRPC_CTXID_MASK GENMASK(11, 4)
+#define FASTRPC_CTXID_MASK GENMASK(15, 8)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
-- 
2.34.1

