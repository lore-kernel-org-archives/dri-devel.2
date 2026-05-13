Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3ECCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1833810EFCB;
	Wed, 13 May 2026 18:14:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C/HOeRdm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RikcYhHv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2512710EFC2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:13 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DF9bhk4159600
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bbJqSkiMGG/gTLlM9QQTChdoblkSPekP2NE+zK4RSQA=; b=C/HOeRdmjsX7LIMc
 N8C3ZLYyTNEjpFHRMQhpgHsFzgwvV/v4ccfSWjvy8Wh4t21P8spUVCvPr2FEkTre
 khJC7r0nTwM4pKUni19l1G+JmlY6qv/+P8wol+WJwcjIvFUwbSp8IsQ3lNUoraMt
 z3Z8PypH7jOgNwy1DNRzH4ZqSQsCs2DgL+JYsfQaTN3ZWEXKT0eqb3+Llgs8re2A
 PqUkvVZxdE8SPtVUo0XGC0QVFw+vcNfBvMkQaPMVEs/v7hWwOSNQkPr1o8bhUZMH
 kUaUK7V0+oZxOfRcLw3f5OthJ1k0i/MBpvqLxBhn2n9gnvnHmJqMS+bL5VdSDSqL
 6L55BQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p91t6wf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:14:12 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-95f8863e500so2447223241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696052; x=1779300852;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bbJqSkiMGG/gTLlM9QQTChdoblkSPekP2NE+zK4RSQA=;
 b=RikcYhHvWa2zL1PP/k2w4IITo8arj7g0OzBC4nNysLiKN3DmmXl0RJAZhszrTLkZ1w
 /s4S33PucpuNCY2E/xS23RPkC6CY2T2nqe+6gALp405WgopZNpYs7VLLBolrv2edEfth
 gsOn5VhYA3+fSmSDjB1zeQo/pzOj6XE9+rcaIldb027aHcVgrRttmmr8qd5CBTOJMT1Y
 m4nBA3HYP2sMF90E+dfDuy2/x6TPLiu8QeOXHcEcH3e51vml7NUU5z/hy5bZEds0fDPl
 vzh8l/BkXTybCZo+UL7wleYFXiuwU90tCgGwyCNksomp8mnS/zzFxqYmsXPZqmLMEVNy
 ImnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696052; x=1779300852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bbJqSkiMGG/gTLlM9QQTChdoblkSPekP2NE+zK4RSQA=;
 b=UxB1bCTSEPVYr9ZF0PZhCskp80TOaYAamdgzJ1vN5IbCzQN0JGs/QL3qcZMCTc9qCz
 /W7+ZEVx0NtBDPCegpy5tYOQfvDbP3WY4InUoRWoFF92pfDlHdA/b8HqCarfMxcLgJCq
 fWejBb/EbeKJ7RflOEb87XhcxUljZKzbC49bjw5vQ9Cao5FriZFsGeQHvkh6zOvY9qLI
 ucNtBoh/C8QDmic3xxMqE2fjF/mQX/70E6eQCuWKbvIr158OEGY1fH7xFs3xzrEckMLs
 +bOGFHRW5L2XDkcxiuPPYKXc1VtQmH82JR7VXnmz3ukdcQtGQV9GskV7RT7eFyVlezFo
 9n8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FHrX4dgnzIlo4brQMLRzeT6V1vxnJGrGn/mQk7vkMGW/N8PIh6CK9RFgEZsNCDX/Y2nYgz20R37E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmH8gUdD29IyME3dTq7Ko3HLWPKNgTZ3jfY7I/e2nQNiWckx6s
 x8/gqSXibOLrRTxtppCcXDB8AzupkCdFV8OmcsOPKy4WUTnnsg9Vp0lSNRIr9VO7A3Qs1UQbLHI
 29sh+mVwESrn+VgUr2i8C3sJB46JOnLuDYHWtnHzXjLkViZyWZom8UOaM6ljYPQnvivD/ORA=
X-Gm-Gg: Acq92OEgQNbXy5twK3A2DYSomHTQg9TlFBVXEc42CUa4lj43FAGZooIK19YAXQGtZIw
 mlt2maB6ZHL3bkCg42C9TAV7XP1knaWlNTCJrNkGclw9OmRD3iXhmfIVmZ/E/XgffKJy3cL4qt0
 d6mFNUfAJvMBLuKfIagC7zEEQHRRMMShpE8dHmM2n8vePls77gIPhM0VJ6PDFg9/69kMDNPNj8A
 f8gjDmf7AUI6iy2mtcvsEomZNiRpYNCWf1MugAG2/iSj831Hpx4g1g4xEL4jttRhe1K0qdwNpXS
 4+C9bF79ZdSrxjuqSj5gyfYYjPiAD2YD+Iu5MeraMqoc2kp6l1H8bNHRMZKu+jQ9CHIKj8fCr/0
 dVIF/KuBM25AvwFW7ulusM/a79GXdRHSJ0MiZxhwJcTnzvhe2M8fjZslDILk79xw01/snSRvtdf
 dHNhxOK7pfeLUzvCh0/wjBikeLJQJCH3V1wFY=
X-Received: by 2002:a05:6102:3a12:b0:631:8665:350c with SMTP id
 ada2fe7eead31-637a96e9cc3mr2136982137.25.1778696051397; 
 Wed, 13 May 2026 11:14:11 -0700 (PDT)
X-Received: by 2002:a05:6102:3a12:b0:631:8665:350c with SMTP id
 ada2fe7eead31-637a96e9cc3mr2136961137.25.1778696050842; 
 Wed, 13 May 2026 11:14:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8bd7d8974sm3174770e87.64.2026.05.13.11.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:14:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 13 May 2026 21:14:05 +0300
Subject: [PATCH v9 2/5] phy: qualcomm: hdmi-28lpm: provide dynamic
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-fd-hdmi-phy-v9-2-ca98c72f1f9f@oss.qualcomm.com>
References: <20260513-fd-hdmi-phy-v9-0-ca98c72f1f9f@oss.qualcomm.com>
In-Reply-To: <20260513-fd-hdmi-phy-v9-0-ca98c72f1f9f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-phy@lists.infradead.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=14593;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Gb9iaHhErPAWN0IRSVbJi0WfaWGvRDkDjNcbmOqzreM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqBL9tcVl2yBY5Sp5zqauRiqNPnJ4JPfcFm0gu5
 XiGZue78ZOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagS/bQAKCRCLPIo+Aiko
 1cdIB/9HEGnTFQD+U8aYt1inxPazDFqyM5/xUjplEupLOdC6+t1ACNc6YNHX0Ed4McwNFZpbwpj
 kG1lRdYC7qcn7Uk+CaRw+4n4YcKToJTbfXIkfY1jgKkBl/rAChj12VoN30+ppoxm6ni+pfdak3g
 6O02fAyq1h9xq4VGQ1yuOogTIIelMuTzKKBngS+mcHkPKng4S5CuL1n+xmILyQlh/Wm+YmmuINP
 Yp4dZlymfIjjhRH7Txdz0VvcvSIgQBamnz24Dqo+PVIns91V3nxl2/nbVbX3LF+u07v9Y1iXZhi
 byUA+mQG29Hi6vOIzmuZ7e+/kPw25HFGMdzTFEXnxfEmpzB7
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: I4WR0XqaPu7nmBiwK7_ZpGHXxp_jRpf-
X-Proofpoint-GUID: I4WR0XqaPu7nmBiwK7_ZpGHXxp_jRpf-
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=6a04bf74 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=rFVNmrDKDD7H5MqYjYMA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MiBTYWx0ZWRfX1L0f23RicqBf
 xqbULz+2U7jaUMVI+RdvRPtiRTAB9Fa3aY9rkSA+UI8zlh39Z0f79+6QrZzpHJ7aSA8rg5F6vX1
 MDUxYl9d5ZFP5dpdmmDJ020ocamQlDCmswDKuZW1HzFliVwwNMLONL/Fj87b6b7ZgiodXZlRcF2
 UK+zP2xa58L341bYo1HC57iruYqkllGPqHAjWCgzZnUQQGg58RvkAxA4mqyZOHKmrpkC/i74Qps
 2OmOIl5hrpiwSiQd0crC/N+T39Wt3TcyEWksQPVfEZzZvlU8EzNNUH+1eofRp7Yz/vdBrS/p6rK
 3KTkReNJbF6t0BHn+48UFBRhg0tvD208vgKu68DIbY8X5FHZao2PDmsmJB7wCPHBY2RTtaE62bC
 5gD9fP8Tcip0ASNZyZqRBpm7pk9rU1zcA3pypeGegPQT+IDRU/TVYzZ63UR3Rf8fDIaiv7HZ+bo
 oEpT9Hxkkh54nrEQkgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130182
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

Replace fixed value configuration tables with the values calculated at
the runtime. In some cases the values might differ from the original
values. Those were validated on the IFC6410 board.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c | 325 +++++++++--------------------
 1 file changed, 104 insertions(+), 221 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c b/drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c
index f1e7113e10bd..90d3331313c0 100644
--- a/drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c
+++ b/drivers/phy/qualcomm/phy-qcom-hdmi-28lpm.c
@@ -148,222 +148,17 @@
 
 #define HDMI_8960_COMMON_DIV 5
 
-struct pll_rate {
-	unsigned long rate;
-	int num_reg;
-	struct {
-		u32 val;
-		u32 reg;
-	} conf[32];
-};
-
-/* NOTE: keep sorted highest freq to lowest: */
-static const struct pll_rate freqtbl[] = {
-	{ 154000000, 14, {
-		{ 0x08, REG_HDMI_8960_PHY_PLL_REFCLK_CFG    },
-		{ 0x20, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG0 },
-		{ 0xf9, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG1 },
-		{ 0x02, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG0   },
-		{ 0x03, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG1   },
-		{ 0x3b, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG2   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG3   },
-		{ 0x86, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG4   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG5   },
-		{ 0x0d, REG_HDMI_8960_PHY_PLL_SDM_CFG0      },
-		{ 0x4d, REG_HDMI_8960_PHY_PLL_SDM_CFG1      },
-		{ 0x5e, REG_HDMI_8960_PHY_PLL_SDM_CFG2      },
-		{ 0x42, REG_HDMI_8960_PHY_PLL_SDM_CFG3      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG4      },
-			}
-	},
-	/* 1080p60/1080p50 case */
-	{ 148500000, 27, {
-		{ 0x02, REG_HDMI_8960_PHY_PLL_REFCLK_CFG    },
-		{ 0x02, REG_HDMI_8960_PHY_PLL_CHRG_PUMP_CFG },
-		{ 0x01, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG0 },
-		{ 0x33, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG1 },
-		{ 0x2c, REG_HDMI_8960_PHY_PLL_IDAC_ADJ_CFG  },
-		{ 0x06, REG_HDMI_8960_PHY_PLL_I_VI_KVCO_CFG },
-		{ 0x0a, REG_HDMI_8960_PHY_PLL_PWRDN_B       },
-		{ 0x76, REG_HDMI_8960_PHY_PLL_SDM_CFG0      },
-		{ 0x01, REG_HDMI_8960_PHY_PLL_SDM_CFG1      },
-		{ 0x4c, REG_HDMI_8960_PHY_PLL_SDM_CFG2      },
-		{ 0xc0, REG_HDMI_8960_PHY_PLL_SDM_CFG3      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG4      },
-		{ 0x9a, REG_HDMI_8960_PHY_PLL_SSC_CFG0      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SSC_CFG1      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SSC_CFG2      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SSC_CFG3      },
-		{ 0x10, REG_HDMI_8960_PHY_PLL_LOCKDET_CFG0  },
-		{ 0x1a, REG_HDMI_8960_PHY_PLL_LOCKDET_CFG1  },
-		{ 0x0d, REG_HDMI_8960_PHY_PLL_LOCKDET_CFG2  },
-		{ 0xe6, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG0   },
-		{ 0x02, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG1   },
-		{ 0x3b, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG2   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG3   },
-		{ 0x86, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG4   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG5   },
-		{ 0x33, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG6   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG7   },
-			}
-	},
-	{ 108000000, 13, {
-		{ 0x08, REG_HDMI_8960_PHY_PLL_REFCLK_CFG    },
-		{ 0x21, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG0 },
-		{ 0xf9, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG1 },
-		{ 0x1c, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG0   },
-		{ 0x02, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG1   },
-		{ 0x3b, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG2   },
-		{ 0x86, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG4   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG5   },
-		{ 0x49, REG_HDMI_8960_PHY_PLL_SDM_CFG0      },
-		{ 0x49, REG_HDMI_8960_PHY_PLL_SDM_CFG1      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG2      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG3      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG4      },
-			}
-	},
-	/* 720p60/720p50/1080i60/1080i50/1080p24/1080p30/1080p25 */
-	{ 74250000, 8, {
-		{ 0x0a, REG_HDMI_8960_PHY_PLL_PWRDN_B       },
-		{ 0x12, REG_HDMI_8960_PHY_PLL_REFCLK_CFG    },
-		{ 0x01, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG0 },
-		{ 0x33, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG1 },
-		{ 0x76, REG_HDMI_8960_PHY_PLL_SDM_CFG0      },
-		{ 0xe6, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG0   },
-		{ 0x02, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG1   },
-		{ 0x3b, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG2   },
-			}
-	},
-	{ 74176000, 14, {
-		{ 0x18, REG_HDMI_8960_PHY_PLL_REFCLK_CFG    },
-		{ 0x20, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG0 },
-		{ 0xf9, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG1 },
-		{ 0xe5, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG0   },
-		{ 0x02, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG1   },
-		{ 0x3b, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG2   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG3   },
-		{ 0x86, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG4   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG5   },
-		{ 0x0c, REG_HDMI_8960_PHY_PLL_SDM_CFG0      },
-		{ 0x4c, REG_HDMI_8960_PHY_PLL_SDM_CFG1      },
-		{ 0x7d, REG_HDMI_8960_PHY_PLL_SDM_CFG2      },
-		{ 0xbc, REG_HDMI_8960_PHY_PLL_SDM_CFG3      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG4      },
-			}
-	},
-	{ 65000000, 14, {
-		{ 0x18, REG_HDMI_8960_PHY_PLL_REFCLK_CFG    },
-		{ 0x20, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG0 },
-		{ 0xf9, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG1 },
-		{ 0x8a, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG0   },
-		{ 0x02, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG1   },
-		{ 0x3b, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG2   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG3   },
-		{ 0x86, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG4   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG5   },
-		{ 0x0b, REG_HDMI_8960_PHY_PLL_SDM_CFG0      },
-		{ 0x4b, REG_HDMI_8960_PHY_PLL_SDM_CFG1      },
-		{ 0x7b, REG_HDMI_8960_PHY_PLL_SDM_CFG2      },
-		{ 0x09, REG_HDMI_8960_PHY_PLL_SDM_CFG3      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG4      },
-			}
-	},
-	/* 480p60/480i60 */
-	{ 27030000, 18, {
-		{ 0x0a, REG_HDMI_8960_PHY_PLL_PWRDN_B       },
-		{ 0x38, REG_HDMI_8960_PHY_PLL_REFCLK_CFG    },
-		{ 0x02, REG_HDMI_8960_PHY_PLL_CHRG_PUMP_CFG },
-		{ 0x20, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG0 },
-		{ 0xff, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG1 },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG0      },
-		{ 0x4e, REG_HDMI_8960_PHY_PLL_SDM_CFG1      },
-		{ 0xd7, REG_HDMI_8960_PHY_PLL_SDM_CFG2      },
-		{ 0x03, REG_HDMI_8960_PHY_PLL_SDM_CFG3      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG4      },
-		{ 0x2a, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG0   },
-		{ 0x03, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG1   },
-		{ 0x3b, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG2   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG3   },
-		{ 0x86, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG4   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG5   },
-		{ 0x33, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG6   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG7   },
-			}
-	},
-	/* 576p50/576i50 */
-	{ 27000000, 27, {
-		{ 0x32, REG_HDMI_8960_PHY_PLL_REFCLK_CFG    },
-		{ 0x02, REG_HDMI_8960_PHY_PLL_CHRG_PUMP_CFG },
-		{ 0x01, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG0 },
-		{ 0x33, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG1 },
-		{ 0x2c, REG_HDMI_8960_PHY_PLL_IDAC_ADJ_CFG  },
-		{ 0x06, REG_HDMI_8960_PHY_PLL_I_VI_KVCO_CFG },
-		{ 0x0a, REG_HDMI_8960_PHY_PLL_PWRDN_B       },
-		{ 0x7b, REG_HDMI_8960_PHY_PLL_SDM_CFG0      },
-		{ 0x01, REG_HDMI_8960_PHY_PLL_SDM_CFG1      },
-		{ 0x4c, REG_HDMI_8960_PHY_PLL_SDM_CFG2      },
-		{ 0xc0, REG_HDMI_8960_PHY_PLL_SDM_CFG3      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG4      },
-		{ 0x9a, REG_HDMI_8960_PHY_PLL_SSC_CFG0      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SSC_CFG1      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SSC_CFG2      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SSC_CFG3      },
-		{ 0x10, REG_HDMI_8960_PHY_PLL_LOCKDET_CFG0  },
-		{ 0x1a, REG_HDMI_8960_PHY_PLL_LOCKDET_CFG1  },
-		{ 0x0d, REG_HDMI_8960_PHY_PLL_LOCKDET_CFG2  },
-		{ 0x2a, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG0   },
-		{ 0x03, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG1   },
-		{ 0x3b, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG2   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG3   },
-		{ 0x86, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG4   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG5   },
-		{ 0x33, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG6   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG7   },
-			}
-	},
-	/* 640x480p60 */
-	{ 25200000, 27, {
-		{ 0x32, REG_HDMI_8960_PHY_PLL_REFCLK_CFG    },
-		{ 0x02, REG_HDMI_8960_PHY_PLL_CHRG_PUMP_CFG },
-		{ 0x01, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG0 },
-		{ 0x33, REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG1 },
-		{ 0x2c, REG_HDMI_8960_PHY_PLL_IDAC_ADJ_CFG  },
-		{ 0x06, REG_HDMI_8960_PHY_PLL_I_VI_KVCO_CFG },
-		{ 0x0a, REG_HDMI_8960_PHY_PLL_PWRDN_B       },
-		{ 0x77, REG_HDMI_8960_PHY_PLL_SDM_CFG0      },
-		{ 0x4c, REG_HDMI_8960_PHY_PLL_SDM_CFG1      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG2      },
-		{ 0xc0, REG_HDMI_8960_PHY_PLL_SDM_CFG3      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SDM_CFG4      },
-		{ 0x9a, REG_HDMI_8960_PHY_PLL_SSC_CFG0      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SSC_CFG1      },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_SSC_CFG2      },
-		{ 0x20, REG_HDMI_8960_PHY_PLL_SSC_CFG3      },
-		{ 0x10, REG_HDMI_8960_PHY_PLL_LOCKDET_CFG0  },
-		{ 0x1a, REG_HDMI_8960_PHY_PLL_LOCKDET_CFG1  },
-		{ 0x0d, REG_HDMI_8960_PHY_PLL_LOCKDET_CFG2  },
-		{ 0xf4, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG0   },
-		{ 0x02, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG1   },
-		{ 0x3b, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG2   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG3   },
-		{ 0x86, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG4   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG5   },
-		{ 0x33, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG6   },
-		{ 0x00, REG_HDMI_8960_PHY_PLL_VCOCAL_CFG7   },
-			}
-	},
-};
-
-static const struct pll_rate *qcom_hdmi_8960_pll_find_rate(unsigned long rate)
+static inline void write16(u16 val, void __iomem *reg)
 {
-	int i;
-
-	for (i = 1; i < ARRAY_SIZE(freqtbl); i++)
-		if (rate > freqtbl[i].rate)
-			return &freqtbl[i - 1];
+	writel(val & 0xff, reg);
+	writel(val >> 8, reg + 4);
+}
 
-	return &freqtbl[i - 1];
+static inline void write24(u32 val, void __iomem *reg)
+{
+	writel(val & 0xff, reg);
+	writel((val >> 8) & 0xff, reg + 4);
+	writel(val >> 16, reg + 8);
 }
 
 static inline u32 read24(void __iomem *reg)
@@ -407,6 +202,70 @@ static unsigned long qcom_28lpm_recalc(struct qcom_hdmi_preqmp_phy *hdmi_phy,
 	return rate;
 }
 
+/* This function is close to UNIPHY, but it has slighly different fields */
+static int qcom_28lpm_set_rate(struct qcom_hdmi_preqmp_phy *hdmi_phy, unsigned long parent_rate,
+			       unsigned long vco_freq, u32 div_idx)
+{
+	unsigned int pixclk = hdmi_phy->hdmi_opts.tmds_char_rate;
+	unsigned int int_ref_freq;
+	unsigned int dc_offset;
+	unsigned int sdm_freq_seed;
+	unsigned int val;
+	bool sdm_mode = false;
+	u32 refclk_cfg;
+	u32 lf_cfg0;
+	u32 lf_cfg1;
+	u64 tmp;
+
+	dev_dbg(hdmi_phy->dev, "rate=%u, div = %d, vco = %lu", pixclk, div_idx, vco_freq);
+
+	if (vco_freq % (parent_rate / 2) == 0) {
+		refclk_cfg = FIELD_PREP(HDMI_8960_PHY_CLK0_DIV, 1);
+		int_ref_freq = parent_rate / 2;
+	} else {
+		refclk_cfg = HDMI_8960_PHY_DBLR_EN;
+		int_ref_freq = parent_rate * 2;
+		sdm_mode = true;
+	}
+
+	dc_offset = vco_freq / int_ref_freq - 1;
+	tmp = vco_freq % int_ref_freq;
+	tmp *= 0x10000;
+	sdm_freq_seed = div_u64(tmp, int_ref_freq);
+
+	val = FIELD_PREP(HDMI_8960_PHY_PLL_VCO_DIV, div_idx) | refclk_cfg;
+	writel(val, hdmi_phy->pll_reg + REG_HDMI_8960_PHY_PLL_REFCLK_CFG);
+
+	lf_cfg0 = dc_offset >= 30 ? 0 : (dc_offset >= 16 ? 0x10 : 0x20);
+	lf_cfg0 += sdm_mode ? 0 : 1;
+
+	/* XXX: 0xc3 instead of 0x33 for qcs404 */
+	lf_cfg1 = dc_offset >= 30 ? 0x33 : (dc_offset >= 16 ? 0xbb : 0xf9);
+
+	writel(lf_cfg0,
+	       hdmi_phy->pll_reg + REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG0);
+	writel(lf_cfg1,
+	       hdmi_phy->pll_reg + REG_HDMI_8960_PHY_PLL_LOOP_FLT_CFG1);
+
+	if (sdm_mode)
+		writel(dc_offset,
+		       hdmi_phy->pll_reg + REG_HDMI_8960_PHY_PLL_SDM_CFG0);
+	else
+		writel(HDMI_8960_PHY_SDM_BYP | dc_offset,
+		       hdmi_phy->pll_reg + REG_HDMI_8960_PHY_PLL_SDM_CFG0);
+
+	writel(HDMI_8960_PHY_DITHER | dc_offset,
+	       hdmi_phy->pll_reg + REG_HDMI_8960_PHY_PLL_SDM_CFG1);
+
+	write24(sdm_freq_seed, hdmi_phy->pll_reg + REG_HDMI_8960_PHY_PLL_SDM_CFG2);
+
+	write16(vco_freq / 1000, hdmi_phy->pll_reg + REG_HDMI_8960_PHY_PLL_VCOCAL_CFG0);
+
+	writel(0x3b, hdmi_phy->pll_reg + REG_HDMI_8960_PHY_PLL_VCOCAL_CFG2);
+
+	return 0;
+}
+
 static const unsigned int qcom_hdmi_8960_divs[] = {1, 2, 4, 6};
 
 static unsigned long qcom_hdmi_8960_pll_recalc_rate(struct clk_hw *hw,
@@ -423,9 +282,10 @@ static unsigned long qcom_hdmi_8960_pll_recalc_rate(struct clk_hw *hw,
 static int qcom_hdmi_8960_pll_determine_rate(struct clk_hw *hw,
 					     struct clk_rate_request *req)
 {
-	const struct pll_rate *pll_rate = qcom_hdmi_8960_pll_find_rate(req->rate);
+	unsigned long long min_freq = HDMI_8960_VCO_MIN_FREQ / HDMI_8960_COMMON_DIV;
+	unsigned long long max_freq = HDMI_8960_VCO_MAX_FREQ / HDMI_8960_COMMON_DIV;
 
-	req->rate = pll_rate->rate;
+	req->rate = clamp(req->rate, min_freq / 6, max_freq);
 
 	return 0;
 }
@@ -510,16 +370,39 @@ static int qcom_hdmi_msm8960_phy_pll_enable(struct qcom_hdmi_preqmp_phy *hdmi_ph
 	return ret;
 }
 
+static int qcom_hdmi_msm8960_phy_find_div(unsigned long long pixclk)
+{
+	unsigned long long min_freq = HDMI_8960_VCO_MIN_FREQ / HDMI_8960_COMMON_DIV;
+	int i;
+
+	if (pixclk > HDMI_8960_VCO_MAX_FREQ / HDMI_8960_COMMON_DIV)
+		return -E2BIG;
+
+	for (i = 0; i < ARRAY_SIZE(qcom_hdmi_8960_divs); i++) {
+		if (pixclk >= min_freq / qcom_hdmi_8960_divs[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static int qcom_hdmi_msm8960_phy_set_rate(struct qcom_hdmi_preqmp_phy *hdmi_phy)
 {
 	unsigned long long pixclk = hdmi_phy->hdmi_opts.tmds_char_rate;
-	const struct pll_rate *pll_rate = qcom_hdmi_8960_pll_find_rate(pixclk);
-	int i;
+	/* XXX: 19.2 for qcs404 */
+	unsigned long parent_rate = 27000000;
+	unsigned long vco_freq;
+	int div_idx;
+	u32 div;
 
-	for (i = 0; i < pll_rate->num_reg; i++)
-		writel(pll_rate->conf[i].val, hdmi_phy->pll_reg + pll_rate->conf[i].reg);
+	div_idx = qcom_hdmi_msm8960_phy_find_div(pixclk);
+	if (WARN_ON(div_idx < 0))
+		return div_idx;
 
-	return 0;
+	div = qcom_hdmi_8960_divs[div_idx];
+	vco_freq = pixclk * HDMI_8960_COMMON_DIV * div;
+
+	return qcom_28lpm_set_rate(hdmi_phy, parent_rate, vco_freq, div_idx);
 }
 
 static void qcom_hdmi_msm8960_phy_pll_disable(struct qcom_hdmi_preqmp_phy *hdmi_phy)

-- 
2.47.3

