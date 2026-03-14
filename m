Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACC6107BCD1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 01:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14E110EC5F;
	Sat, 14 Mar 2026 01:09:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i9PGtWcR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yj43ILD+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF4F10EC5F
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:18 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DFXPgD437916
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DeGmUPYleUd1gI+tkP9VMwvXNEE1375NE+M4CsEsAl8=; b=i9PGtWcRErUChHkS
 K78Zt3xE6VfqxWve6fHd1hfsYbBypv9VaqD0TCjZcjRyxXIRv8P64C0UZUx14uS9
 Ne2qn3kPDq/jgCy3zifkQ9fJGUzuVyO8HPPKj4lHEh3S6BM+k45UQVP6I2qyrRQ6
 Rfofig2yyMDP8UPWCTkDBBG9PSRnJyPmdBAR+1UXVes+PY0AaIyQpfqjeU5GZIlc
 inEtOWRzGbDLxsCQDvdjg5665zbIl0cJORG/NTiwwi55scmRaukZqVJbjldjwJ2R
 9Wjs5FX/Mt5Q6dInFDzSuPIuZlxXqOqFUP6KdXvAbtl9GN/UFYBk9P4ifFqVncBM
 lUD0rw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvnax9kyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:09:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd781c0d90so2066186185a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773450557; x=1774055357;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DeGmUPYleUd1gI+tkP9VMwvXNEE1375NE+M4CsEsAl8=;
 b=Yj43ILD+wlmrilKs5oAYJHffRO5cZXpYXcuA8uWa9audWUGK2w0pDxlskfUKOeMP0d
 Zebwjl7m6OeA/xQBo+BiEfdoJRCwLadMxRZRU/Ul6MHy0DTmhXWO9LcGcVyu1j41/BpG
 4Xzc5CfBPX6orl85kOJfl+aqPS0IKeHiiRIsGfS12Fbe+clefB2ZRMkgg7U2qw/2yemj
 PZB9We5lM+jpKEpJagNoyuZqY8+r0238zurGLG4f7LjzlCrTh6Mz8DX4DkOP2VFtsFqd
 AZY7245j3a3bSX7z8bMmJH0HuHY2rd9pxwQKOI1SEPdAPxpkySqIaVsCrniPQE52Cszi
 Btsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773450557; x=1774055357;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DeGmUPYleUd1gI+tkP9VMwvXNEE1375NE+M4CsEsAl8=;
 b=O+fqwlygJ9JP6QJcpesWvtsJqaxsnV1cBqvuQuRsiKVnX/D4nYy791UT8xVPERAJv8
 N+BHRIKz8psqN7ioBAJ/OXcaGEzp11gcSaVQvBwy4L9BHHv6aHYpDTyh3jXGjZXOmgcH
 UKaGqwuDvzh0PoK6Ng8YudL+OMP+2p+lygyLq7oXAfzLKy1KID4QwBLz2tUhdL8FBuZh
 jBMHkdHuSME4J7ooy+WonjmL1VvL4SlvvsCvebs5/b+naG1N29bE7GbDS1+Wy7isHui0
 1zPtKX1rDTJ0rBK0fgjX2eCEeS13qOa32ATc3kPZAijUu4Qv2aa/YjH7g9RRuGDL4yxl
 BHnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0hnA8zL5+eH0PXrhtYGebs0uf7VtzDmTwpoJY/Aza2AqSVA7zo36Ni11DIdVEzWrnElJkzvLHBnY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlE2PaTLBfOcbzWLch6lV4hI6y5t6qEKwfUhob0AsTKheBROhZ
 sPtoWvsxqRAI23Qsq0LyhTEDnvSPvBAgsUvXaqb+zwtgQhqc08xlZxPY3VzWnIFmGxBRki1YMHy
 /iAtCjAnRi+vg0b8ZzWheMMaaExPBE/bICknyyXYsFLAvPO1GkXwq9FjjPs/XGJ8NlwtuUOc=
X-Gm-Gg: ATEYQzxXzEp49dzZiNk1eIs0lq3pFQme1q1a67ExdqctnpovMVi8U2Avq0Rgg0RJoHn
 iohL6wP/bWNxjGHE2Ws2vOqDZBAoAoiFxI6+E/yW0bGMOFz1YfO5V4RIoMniuqsUynrJNlxhLS6
 SQiIhT3swqz8PjdDTQZGubZQgS9tTAdpYBdDiZbtGVRTbWPyusOR1GvAQu85k1ddKErPsnizeDx
 m4oDRO3btGzwX2wln+owclaY4Jq+hgqk22AEPADnoibxp1C7aeYWiYE0tZDZS/3QcgphbUo9JVX
 aQGdS/heYYWSC23p/nE8KbS+ZTaxyOAqyD2daQeRqX+gF6zJzTTI4lSvWx0q6qSCu94dPa/QNMR
 gKJ9zaYl4A3HkNHzcuMkCbkXtNZLoStHWIz4EnV7I9Z736NvXeA98G8TA4CnwRYZv4LRStamh4c
 5D7jk82dtCvsCeQSQjmv1yCsUq0ND+6vQMRu4=
X-Received: by 2002:a05:620a:4101:b0:8c7:e8c1:ea05 with SMTP id
 af79cd13be357-8cdaa77938bmr1061169085a.7.1773450556790; 
 Fri, 13 Mar 2026 18:09:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4101:b0:8c7:e8c1:ea05 with SMTP id
 af79cd13be357-8cdaa77938bmr1061166785a.7.1773450556351; 
 Fri, 13 Mar 2026 18:09:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366b22sm1806805e87.77.2026.03.13.18.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:09:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 03:09:05 +0200
Subject: [PATCH v5 01/10] drm/msm/dp: fix HPD state status bit shift value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-hpd-refactor-v5-1-0c8450737d64@oss.qualcomm.com>
References: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
In-Reply-To: <20260314-hpd-refactor-v5-0-0c8450737d64@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hzwfWK5+EPLPBOMgkg/4Azem10iuzkilPWoxif3rO60=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptLUy8W18Y1yfE5HK49Yw4+p+AVbfCcNE8CMe1
 zRTg8C9khuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabS1MgAKCRCLPIo+Aiko
 1duiCACQzw9dsW4ibwfY0VGKLAVvRpZSU1ckvWSmXXgpd38pxyDM4YkshNrmfTKz4BFaMh904Db
 ps8LI/7Dej/U68vZAajNnaZ6kkwV7IgYt2RBcCXOG/O1LahH99RMvIB3WkRgWnyeQakQi+oFpDi
 /vFskvbwcB0ESz5org/uNgFhedTvxIdaAwOh81xtI2mWdE+7RFIcttm5ip40KjvLev0/DMDmSUd
 qKAOEmJqQlvE9+etXHiktS8NYMkgBzleDLV92/4NdLQ/X3yW1eR1ehl1/AP1vO0313Qd4LareMT
 IjV1DiuH3rSKv3pPoLgsnEBZBsEAyqDjVY3EqPxaUXXQ+5w0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 3OPO8tW-QRmJzckNGlRvowyobkoFWVK5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwNiBTYWx0ZWRfX3EXYrhw5dZGr
 XWZRrDXjC4o8yu5u/O4rRAUKUqdDOYr6HMdRy20ejSzPMfnV5Ei0fQYIle4sszW4EuQWACsydRk
 riLpGTSW4pD1Rmf+qbNDzCCFR9M+TFa5FqxMKqrHVY9m7gaaNWDcoTGPcQS7YjuGRaroyAD9dWT
 gD5ROPIzH7P0+C8H6deEr/LVcYAJijfOMZXmkLu+kuK8SbLUWuRWe5Dj7BxEYpXNrhYBLkZGa/U
 VZBv/j8nATOCOBV5A1k6cdLal6SKkJ2zDIkKFDRICBTl26EmA+uiDxLLYBfMjs4MFrbXRlP9WgB
 ja7TUFS60zp8kshFVVE4pL2sKxxmfP227VjZoF4zI7O7Zml3mMBLYaNO/EEt0ST+uh3h3IldXdc
 xJStJ1OXZmNlrzZjWZZXuPSr4IaZwOscmmZilFRsjD9rMveBpAcQJBLVhM1GvqI3uAkJhbaQTt5
 MDC81W06sRGCx9dbqYA==
X-Authority-Analysis: v=2.4 cv=X5Ff6WTe c=1 sm=1 tr=0 ts=69b4b53d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=IBRk8GtBIsankUNt0b0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 3OPO8tW-QRmJzckNGlRvowyobkoFWVK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140006
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

From: Jessica Zhang <jesszhan0024@gmail.com>

The HPD state status is the 3 most significant bits, not 4 bits of the
HPD_INT_STATUS register.

Fix the bit shift macro so that the correct bits are returned in
msm_dp_aux_is_link_connected().

Fixes: 19e52bcb27c2 ("drm/msm/dp: return correct connection status after suspend")
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 7c44d4e2cf13..3689642b7fc0 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -68,8 +68,8 @@
 #define DP_DP_IRQ_HPD_INT_ACK			(0x00000002)
 #define DP_DP_HPD_REPLUG_INT_ACK		(0x00000004)
 #define DP_DP_HPD_UNPLUG_INT_ACK		(0x00000008)
-#define DP_DP_HPD_STATE_STATUS_BITS_MASK	(0x0000000F)
-#define DP_DP_HPD_STATE_STATUS_BITS_SHIFT	(0x1C)
+#define DP_DP_HPD_STATE_STATUS_BITS_MASK	(0x00000007)
+#define DP_DP_HPD_STATE_STATUS_BITS_SHIFT	(0x1D)
 
 #define REG_DP_DP_HPD_INT_MASK			(0x0000000C)
 #define DP_DP_HPD_PLUG_INT_MASK			(0x00000001)

-- 
2.47.3

