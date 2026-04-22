Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324F3F9B5F6
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C708953E;
	Wed, 22 Apr 2026 09:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SKfT2E63";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvTQ3tVe";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A6A8953E
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:31 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M5BwHd3083122
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tFUu7w/Mdhl
 BRhU4Ur6TRUhTba4EbTByy053HqbjsgU=; b=SKfT2E63EP/LASoR4GuII79LXU7
 OgawffQ6Ze4uvBVmRjBkJcWNlnV4gKIdoy4nBnUgZxbhDFyWkZYCNw9L9SGcnwUV
 /8mZVofmJ0RdplQw8tqBC3GPhBraUEobvJknFAUk/Ff9d/wzTllZVy+83SjNasm1
 fiQnWh55T0nNefHMiWytBWk3s9IABpRXNVN7Md5IwyZEI0Lq+3XtBo9en02D7MDm
 0Vj1wNOl+aeYKd6vDAStj4RVytPjcse/XuWkbAA1G9CdYS4/k+Gm0nV+Q6VJWCUR
 7k1WPYBFH63E4/71cynLiD7aXSzGAtMBr1rETGB+Wc1mYGB+UPBhXgr1wlQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenmju2e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:30 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82f9429f49cso6189330b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776849870; x=1777454670;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFUu7w/MdhlBRhU4Ur6TRUhTba4EbTByy053HqbjsgU=;
 b=gvTQ3tVeEnnQg5h356DC7adrsEqLyojMPDUQsZAx6lQkaaONxz/uYTCVycztxIsh6o
 90qLpT1EXz4VD9Rq6GR4wBVt0f0kIrY3jT4I8zP63C49diuN8gxFI6rQIic3NBO8nxIQ
 dyC0BJL9Y1HimzjMtZkyyENE+Uee+G0icZUGk2lzRPgxaDi/5FbJDHI/zVCTAsRFokfY
 CL3ouIjmTys8zFtXbsUVLCd8HlDfT4I+BWcSwRcqDF9Dv3iU39oifL5jJ/EQFd3bLuV2
 IbBj/0hgwfvRLLxubEex3LyP2cfgz2/ZUjew3TtyLqCIVqs0se6r+WJsgT6FURxmS74e
 dTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776849870; x=1777454670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFUu7w/MdhlBRhU4Ur6TRUhTba4EbTByy053HqbjsgU=;
 b=C2cH58Ysszemb/S0mo/yxxu6ohKFhXJiIXZohtBMYN0uO3BZh1b0YrEfuTzvjsNssn
 KKcsEfpicwX1Z8pL1JKNQpFkRUj6HQTgXG6J295gn9KkS7y/Q/vgi8rWrayd4PLhgRUy
 pCuQ6kjvy+Io/LPgR0gmF6qU9CSHdiefbjgoCDbF+aOt09QS8sv/0XDdJa7zeXwJZW2f
 mbg4j2TLMbqd927VX9VgY0oGbYSad1/3TTRep4uZoocDvimb2wPLfiCVw5yKXcG00cQe
 ZiZR3VNehwS7Mr0AU+QlLLMhH4jCP727IdnEyZwyGvSZ3PWVNzUY3BaGwgQGrxdGXrMx
 J1lA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NrfQcgCg/EWv1Ibbky4caX+Sa0ZFrJH2loEbXEA+he64dKqLGtPXOB5g7CTbo+MJX9TeR4/Q+zIE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1d0hETA3Z99StsoUcmFQDRrkXyrEMcAWPep88srBLgVTDSR/X
 a9MJVdjUUiF9/azy3M08b2oU5EzYPIGu0/AMG3doIA7mo1bjUcivWmV/NRRHrpjrKonwooR2vF/
 SJuveKDzo4VYa95AoBIFEhLBsKwE4wRJw9mEsV6mvE98LNWoITH1nhoMZ/bOyGSHWUgKd45A=
X-Gm-Gg: AeBDievgzmM3c1wMIjUGu1HBOqoHxXXV0y4zWh7xooo5g9MZHDqqjayBXFWQpmdKw6O
 +6CMlNzmAOwHyWRbxhq1PWTdHXGT7ACe+W2v3g+Q/cA+FtbyRZomSMiZ1a+aTSV0lBaoqMLpcxJ
 Lv/nOiZLDN++R+uZ0/Q0awVnSgJwxsI8QTJ/j7HWmb+vqRyGYUiUq1l9KiGPKlEW16trLWbi973
 FW7776Ozni9nYLC+K+x48hr7O8R7JBPOwusWhs084TZ2XKazeV/6ny6WnQvk6XGavVZOWjBBbv3
 IW1T8OrT6fxOyHju9vPT6Quoss7pWoUjQ75KAA8LEwWdA+TjgCePD1M3nOXmrjm1PFmuosTG29B
 BO5PEwIifyzGRRSThPBKwdK6G55bdDXbdDYE9HwwG67x1NrQHs1nFmWby+keljb8a
X-Received: by 2002:a05:6a00:4b4e:b0:82f:3828:a00a with SMTP id
 d2e1a72fcca58-82f8c94bebamr22900105b3a.41.1776849870033; 
 Wed, 22 Apr 2026 02:24:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b4e:b0:82f:3828:a00a with SMTP id
 d2e1a72fcca58-82f8c94bebamr22900060b3a.41.1776849869537; 
 Wed, 22 Apr 2026 02:24:29 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb38ddsm15778576b3a.34.2026.04.22.02.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 02:24:28 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: [PATCH v9 3/4] misc: fastrpc: Expand context ID mask for DSP polling
 mode support
Date: Wed, 22 Apr 2026 14:54:08 +0530
Message-Id: <20260422092409.4107093-4-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
References: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rbreTbsg96gaL3pM4cAhJUvwciEr-STW
X-Proofpoint-ORIG-GUID: rbreTbsg96gaL3pM4cAhJUvwciEr-STW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4NCBTYWx0ZWRfXzlmbapiCe4YE
 NgAXsG2vViOdV9WdrJZRON4/CWPo+y4wGZMT8mCTuNJOn4XUU4b/rFIN/iFH85CeHg92kYpyVFK
 N8MDJQnJ4JKPCx/lGRENDqqD5KZz3cWXUq2Nt3o8fqKqqByd9cx/geIa7xn6R6Un6XGWNGLOXgo
 8BtgGiA424Pjj1SZQr7Rj7WLLnEdIbTzewfzemF7ZQZNPmLjIuwzJZFP+FWTUSw72XC2ocCfmLi
 JJCczrowKtaPbKrtQ3WAJDWVElof7BA35ZVezct2o5TbazjYY0kEa5jAASqRPfXlKp/BKF0PgME
 w32+Cy3lkQg+lYxgLeJmdqjEwaDCDAgAlQ0guxyQuHM7mOibXhVm9GsZ5eIP/ZNDQavjyMW+5Fy
 iDrUt1pGP4gPyY/bG+ZZS25iL5DLKltE6c4hv9iD+SfJTBjU1FQrnknGvr2hOIs+YwFDenjc2Zs
 cdKoDEhKlmpCBcSUSww==
X-Authority-Analysis: v=2.4 cv=Xd65Co55 c=1 sm=1 tr=0 ts=69e893ce cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=JTa3dIKMUYn8LlmgGFYA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220084
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

