Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24173C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 734AA10E544;
	Mon, 13 Jul 2026 05:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nCZdYU3f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GAf6BX82";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B894110E544
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:54 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D3AIdY299226
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/MjSPuTi5VX
 dbi0rrWASgpaoUJZb5OphbbYvcj7YXs0=; b=nCZdYU3fuA0XZ6xQSk9gyhP5ylt
 hhjW1/sGkOpbqKJ2B21Mc64vfIXSsK7Z9cC77SiTaSKxwiaLRcES7haEVb/8qkca
 R6rq0F2icglKlVw6oUxLSL+s2/NAWX78Hfxu2xOkElqqxiFDMoDE3kRujci588Lz
 JOTvNATdATUZb2SuesbU/eFez/PtNa+LDyng5wpZAp3trJwlhgvMFqwSTrMvR5Ix
 eJs5HWNbcaGWCPe2a55rofsJb6Sak01eMwCeOBVh5jSxyFT9i32EWzt9OZr6Ou+L
 JJDPM0pBrVH3zmjfA3n5HRj1AwWdIDymScLiKCP7gvO01skd7QCeVmnT+eg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn38w1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-381250979d5so3119168a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 22:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783920173; x=1784524973;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/MjSPuTi5VXdbi0rrWASgpaoUJZb5OphbbYvcj7YXs0=;
 b=GAf6BX82kxzosSVXnu9nXglf/+PtHJFcTog2cCQjGooHQ2OglmLfbCpbyNFe2zUwsE
 +KcmBCdt1/mzKuA1fP49N0kVjxGihNEx/cf61HFZYKNC1IYl2AjDvWuw3rPSWi7oFPPg
 27FLdYKLXxr4aqmL74F1jYzk77GD2xgiDRpl8gCsWi8Ayhfv88JiH5T78czf18LRWSfC
 FvqSDOKiujKlebsMrzJbRIUtjz3Xw/th+wA1NmnRmN+Hdi2DgrvzZ6uowsoh4u9eEzAS
 K6+nmv6eFElYq72UHKOQudVypR2oo2xyEmYm0HR4zDEJHh18dbfuBFYykfRyRI28F0SF
 ieYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783920173; x=1784524973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/MjSPuTi5VXdbi0rrWASgpaoUJZb5OphbbYvcj7YXs0=;
 b=k5TMNsfmMvtw3qWcKY6IOtCc0k5LbmHBoSXxQi906lEK1qPE9LB74JnmID99nHGhKm
 xBFpP3t5Lqfdpq6DWbY3sAWjeO1zyv+PxNGHmUTsZkKDzeTueTt+8dP5k5VCcf1a6bQp
 MyCeTzmh29+e7nI64b7ol2vxY7y8jHxk/aWMblzNGgcAN69r290b5EHy6gjQxUFQ5CHX
 HynMHvygnWTznBz+6yahX3DgdO5JGFgbmDOYJNMX8zONiZEngSCJGae4HWh+/cmzB2m+
 l+kcqzuhtu1mQnUC6Q8q3QKO5mfhPMS0qTJByPLbI+lpB7E1ztnoEpnevceOuKj70ut+
 v/1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeYNXCXsjzaoqenesZA87q2tW4Y3Orqn7B5RedExlgbXUOTqCADXWROITKdCzbb+6cv3S1JtiLNVY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7ednwLiL2pYrwU6QnFnAiqLked+pgGgEYYeuketXiPU1zj5V/
 Yio/hfSNJzc5Le71iRYFAFeM7c5C6D0AUAD8+Rn8QBZpP4cPoGqqBA6od1WMrQryVe4KAUP+pJs
 it9PFuap83pHDQikGmc3cY/T9OxGIxyy0s+BoTStCn3ikkc1yZzN9N0hlAdOSXWbIKLhDp3Q=
X-Gm-Gg: AfdE7clPBUmWrMocSpEUdD94EwCrxtBAjE1iyqMl7/zgF6sOkt9C8oHV2vyHU4mQbpQ
 Je/dEFrZX3NQ+XufjS2Ym+4CCuZ1Hw2XswCHh5jyNSwyaN3y3D9xuSD1u3QLP39geVulF400H0N
 mKO7bKEAmTF5nJLmhC8djZjXXRzNvJP6dl4hf8SEACp3FI8/UVN9fJSlxHK7e57nTprZ84rhzNc
 DLYn+tHEdL/9VK2BMvojUhciBkKLCegD6t1rIZ6QqrZk9FCYLLTFa5B9ian/mNVkgZpbG/lJkpj
 dguoFZhLavBiBQhGHLsgxbd3q2fZmMC8eodDVFOuldhJVyJ4ttG2moT+QrpQfXnKpNYTmFwLslv
 MyTrEW/qDVeOFfjX0pK2V9CHtGFXbxmBYI1PhVViN3Ew=
X-Received: by 2002:a05:6a21:3393:b0:3bf:7994:ddc6 with SMTP id
 adf61e73a8af0-3c11063c3bamr10103104637.25.1783920173357; 
 Sun, 12 Jul 2026 22:22:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:3393:b0:3bf:7994:ddc6 with SMTP id
 adf61e73a8af0-3c11063c3bamr10103065637.25.1783920172795; 
 Sun, 12 Jul 2026 22:22:52 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca75ef0c30dsm6245605a12.17.2026.07.12.22.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 22:22:52 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v13 3/4] misc: fastrpc: Expand context ID mask for DSP polling
 mode support
Date: Mon, 13 Jul 2026 10:52:35 +0530
Message-Id: <20260713052236.3033744-4-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
References: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA1MiBTYWx0ZWRfXydudgobtKz7H
 z/aXESVK7JYkoixoWNlaGNviw+AydIAMWxiJ0wIHdgsg7h5p8O+JG1CQiYStD77bVUdIg4YAIy2
 lkCWPhCHLMaS9E3Yl8rzijzSGnEFUDz2Lw1rjbHbT/lzSYwNDyL2cAsf1OgsYGc7QILzKobo8ud
 YCWop1tHAGo7AikfngDTSpOWRuhf8Ua+llkmp5/fvcfjAeo0DdCTmCbDLEwudVquKn2jpXFN7Ne
 Dj9rGgpyAY76MvCeeW2BcT8odsqWyjHV41SUUorO9Tio1oW682kNkUUfhbATUCOKezJgw/5QGQB
 nwXEEJ/o5A2hbHcWCHctZqBQXihdKtYoQ5xdtNbg/AHUzN5myz7I4yWhuD8jXrOa7ydb9M3ZgpC
 i3hDd2WG1b5Dm700GS5vwE/C8FUz5PaicqU1d6fjzoB7jiHGfGTeNcVJRbWrRmCGok39J+mTtay
 O3XeERfCmICl477KVMA==
X-Proofpoint-ORIG-GUID: oiXl2RdSsilH11aqLYOw85JecyGfXfIj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA1MiBTYWx0ZWRfX9t8sEm4hGqy8
 5siNmFieNtWXzKDL6OUq2WOxfmYQfcRmUgCjomxdCH74OlBH5izF0CIcBmOANCXvJNuvACWy9uY
 cqRHNQLlvRhrvpcfLRp9QisoIQ8Rt2w=
X-Proofpoint-GUID: oiXl2RdSsilH11aqLYOw85JecyGfXfIj
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a54762e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=JTa3dIKMUYn8LlmgGFYA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130052
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
index 41c2ec0bc628..78bd5b8f67f8 100644
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

