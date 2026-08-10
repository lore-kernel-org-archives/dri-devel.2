Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFCEC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 681E410E8DA;
	Mon, 10 Aug 2026 14:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ImZqAgwN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pi9hvD5V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5500710E8DA
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:52:00 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ACjVMq1960026
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kTqFwWAy8gxz1MmUqc7zci3CtGF3y+5TmAl/jfQIgWc=; b=ImZqAgwNjTbYRndF
 Lb892AhJfvCwZs3t0nPq9Lnk6u1N/mrzwPU1guaeZL3Fpgu5Avs6XoQvzJ8/Xknz
 2eYfQB/asrZAoA1VF2GDa2CZvdPU7gTXRI17ExTK6+0rd4VtT+f3wRgCaGDbNyyR
 wcWhSfdml8kZJS88B2fAFxP+576pw8W4kJR3p77wNhf1rzv3uFDqTSuNW3xfUPKz
 Z+s/LARBMQEjcjfhoBX6n5cChK8yGCzyR45n9tO3CYXNwpl9xVrH4OAFLS17Bczx
 PRIo6om31kyIMEPOBcd+iEVrb9fnbJA79h+yGAfFjBHgNljf17Ys4WyLAbGzcNUG
 HFhsSw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy18xu46w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c26012cd0so18353141cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786373518; x=1786978318;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kTqFwWAy8gxz1MmUqc7zci3CtGF3y+5TmAl/jfQIgWc=;
 b=Pi9hvD5Vf7Inmi8uDtwPqtfEPMJNYRE0BABQx6tpQK0k3JV9YeYsOPWnjg1hoxAU+t
 jJpKH67RyDIkRc3UUz4R4Dl183E3fpPbCDF8eKBTg8Lna0NQVh55E0b/4psKuCAr8kHw
 6IwH0niCENM8N1IFblac0E6zr/9BzSjRBUBtcSbd3lU3qNAiw1SlqnORGyUCDvpgRCxd
 5yMwE7DGTu/IrUpQbdoZH5tgTmWZZJff3A7AW9jXnabgxXheiBy4+LPNsMjg1wv6s0bg
 HD5Qb62IqYPzaqEo499hTM7jI4gWtEqfZaHwzdZidIykG/qI1yh1CMBMrpAFXlM3Q7KY
 YPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786373518; x=1786978318;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kTqFwWAy8gxz1MmUqc7zci3CtGF3y+5TmAl/jfQIgWc=;
 b=spizBqYFUPN/Zfz7Bz3r3Fjzv0ByGo6qJ35Vg4PJ7CMBHEuQ12SI0rjXD1ICJg/u9h
 z6M03ZyR05TJ8yrQdk3eBCu4dhWci4Yap2tGX9NE5nHhqG9pfJLTHN19hhh6LBR432+r
 KJWNZptJZQXzlHN+3R0H1vEDXr3WXuTnXEoJFbtayC8SBnz6lGbTWNHsXnwHKwiaB5ib
 UyQah+2d6eI+kk3KQi6jDoxxxDSS8ah3kPRauamjKTnly1ZVnFkSnZ2PILxDTl3D1FjJ
 rjh326d1Gm5lT31xC3HtGGzuZiQasWmehQZ2c/pp22sDuqdpGrTrOQtHsqyIUS1e2DHb
 iTdw==
X-Gm-Message-State: AOJu0YwnskZiSvzo7KTOlncG+PxgWAW+UG0UQ91qbZhC4GEOLYFcKC9Y
 5ZyJMErg5rVq5wKrvugLP2M5g/M1q0vbAuTbbX65gWtsS82JiaGZkUTZEBNBjNwd/F3xtisS6D5
 MCR4pfHws1VrPLq5Pfvmt4CXbHbpxQb5hcUdElHwhiF7M2uUTA2u37BvSKGx7EBHBMHjKW+4=
X-Gm-Gg: AR+sD12mY0NeH1EwIyf49d2k3tiNpFbk40amgFVomUTsYcNGosRqGEDixo3iyczNe5g
 MulJS7nYMErsiydyKm120sPCocPfbM3p/CaAL09liXuNS5PTRnZXlzk4VndAF/kf5JQZU6hd7VZ
 9WQMipiUg3Rbj2kg4vHp5creICi+DlyxuX/Bnb2u6BR+/dj+u4m5zxrxKq98dv7FCglHwIs8Oat
 GoADS892vTm3aYEJedHzoxhME4lQS2Gseo6kT+PTNoXfAKX7BG5/0RaxlIKwjExOp1lbmNsZ9Nh
 SOu1Motqvq98ae+tMhK7PXWIvJ608bn7bW0VfjliwsekQ0JHF76gLnCGDWYl4ulAmcpgdRbLLv0
 t9WuE5W8mauOvPQkgzurEYy/mgkOxoJcgrDYWDyioy1e2Oxbk8y0zswGZ5BZ9kWtXS6nVe580xA
 GahaUozvv8V3jcNQ==
X-Received: by 2002:a05:622a:5806:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52d4be1ab03mr27753831cf.9.1786373518193; 
 Mon, 10 Aug 2026 07:51:58 -0700 (PDT)
X-Received: by 2002:a05:622a:5806:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52d4be1ab03mr27753211cf.9.1786373517789; 
 Mon, 10 Aug 2026 07:51:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39fddd6a796sm22489661fa.36.2026.08.10.07.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:51:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 17:51:49 +0300
Subject: [PATCH 4/4] gpu: ipu-v3: di: report an unattainable pixel clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-imx53-fix-hdmi-v1-4-fff9b1b17f25@oss.qualcomm.com>
References: <20260810-imx53-fix-hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com>
In-Reply-To: <20260810-imx53-fix-hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AJVGyN6ABsrumW1cS+QhP8uMJiKdvZ4L17DP94TV7oo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeeWDuniPTM7aG8qyd3SuSyxN4T3e+ikAJWC8I
 5rfNOm136aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCannlgwAKCRCLPIo+Aiko
 1QRbCACEWOb6JNOqxsn82iOBHRW8q/uQaofmrqxQRemzL4NXdIOQdzJ1B+QcB6YfmOh0AiJElgX
 vQ3NGPnp880zSiX3vPetajSr8oI1v7lRGW3EPKl/xn5vkxvVKLCJt4La2VKHhy31UV7rTBrdDPO
 BIJ8J8ZvVSlq/oWe4b63AMCfm4j1u0Yr6fCCpQ+FS5QTux+jqVasFHOX36lLE4X7y1BegpsKpvH
 s4OIzyMHPrptSM28z5ClQ7ARSXTIzGoF5ZJJrFqpKEMDxYnQ2rExs2TYM5hDThkZFiGcnp08Lot
 Q+i/4s/xBGVsPHWKyPQ8RBh8BUUlEhcbv2CtQafRVRFbOazG
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyOCBTYWx0ZWRfX1HHZl2hwZRLN
 3qmBvJsuOhHQ8hOO19I6HrJ88b+0tKQPQfGU5b3kjJeLUb18AGNjhTtLSot30HbMoMUlFJrgw8e
 nouVASyH9rZtHWHO9FKH2mrGHEYrKoA=
X-Proofpoint-ORIG-GUID: A5yA_67YDsQRuw9x_AiqHzU8I0YxHNzk
X-Proofpoint-GUID: A5yA_67YDsQRuw9x_AiqHzU8I0YxHNzk
X-Authority-Analysis: v=2.4 cv=bfZbluPB c=1 sm=1 tr=0 ts=6a79e58f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=_XsFwZo-ejPuOgsMvnoA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyOCBTYWx0ZWRfXzURtYA6l8s+p
 PAjviC+mySooQBN/rqKHKrbDwIhEofL/cItyREJjXWkFs0kqS2fZSPbz8XM3veVwQuyavkYMPNA
 j6DkH3prBR2cAyHp8/WophxcxtpPi59rFYKKKTYjGAnrhTf4M4ZCudvpFryUYw+TIH4oFZ07TYU
 z999jJnrbaeW0VWJQh7w9Dj5ng6JpaJIzlAxRr7lBrIY+VEhdifLrVlFoUlgVes+nlfyAiMRPJ0
 kp7wHABZohdALqj/3FIq26WuaBViNqlErkadCztv0CDQtbnF6/InGn3PcY1sVVrdWYsDPo+iiSQ
 9ilQVDDaYL9Og/rvQRbnmbuoI2lIKeliKGztzV3zxvfIFaWTWIZ2TzEn4pXPBmVbvZQA4Oa/gwR
 2Wc3Ds1dgMGStvV1uEKQWLIQ8OnSCk4NS33CLE7w/nOqeeXZbyPBd6baclneZqdJ262MyeJLi//
 QyWUkooaA8agNZkJhbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100128
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

When the DI cannot be programmed to the requested pixel clock the only
symptom is a "flip_done timed out" ten seconds later, because the display
never starts and the IDMAC EOF interrupt that ipuv3-crtc uses as its
vblank source never arrives. Working out that the clock is at fault
currently requires rebuilding with dynamic debug enabled.

Print an error when the rate the DI ends up with differs from the
requested one by more than 1%. The CLKMODE_SYNC case is skipped, as
there the encoder programs the pixel clock after this runs.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/ipu-v3/ipu-di.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
index 0a34e0ab4fe6..c971c37356f4 100644
--- a/drivers/gpu/ipu-v3/ipu-di.c
+++ b/drivers/gpu/ipu-v3/ipu-di.c
@@ -497,6 +497,22 @@ static void ipu_di_config_clock(struct ipu_di *di,
 		clk_get_rate(di->clk_di),
 		clk == di->clk_di ? "DI" : "IPU",
 		clk_get_rate(di->clk_di_pixel) / (clkgen0 >> 4));
+
+	/*
+	 * With CLKMODE_SYNC the encoder programs the pixel clock after us, so
+	 * there is nothing to check yet. Otherwise the rate is final, and a
+	 * wrong one only shows up later as a "flip_done timed out".
+	 */
+	if (!(sig->clkflags & IPU_DI_CLKMODE_SYNC)) {
+		unsigned long rate = clk_get_rate(di->clk_di_pixel) /
+				     (clkgen0 >> 4);
+
+		if (abs((long)(rate - sig->mode.pixelclock)) >
+		    sig->mode.pixelclock / 100)
+			dev_err(di->ipu->dev,
+				"DI%d: cannot generate %luHz pixel clock, got %luHz\n",
+				di->id, sig->mode.pixelclock, rate);
+	}
 }
 
 /*

-- 
2.47.3

