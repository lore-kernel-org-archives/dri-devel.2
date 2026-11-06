Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFDB606EEB8
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kWjrqTBg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HP1yyDjc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08923112DB1;
	Fri,  6 Nov 2026 13:45:23 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47229112DA6
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:54 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6APABH3645828
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 13:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KFMOrkADVP+8BGFWWz5DwK17BKn+/vVaPVTQ4G5cEjo=; b=kWjrqTBgogdaHeUL
 sEZfG7dvzXh3zIWl1p/IilIITI1lE7uLTWgz38momuwDYjDjNXzWWyCPDeSp+AOk
 lQvLWzgGYr3ZJW1UidMfrHgtGODYKv+R7WxX+Y7yqAfDuZtEk5wI8Vp8cz0bPL59
 wDP0h/W0QGeiTO9KWVskOGjQxdP8obWIhc9g2tNK+Wq91BEPCbljudWYvwPKyU9H
 kHAG6nBiVx9/oeVnBbJJsxpk2aaBn0jOmLBsjXEvkrj4uPcVE0f35UF45jELtkhh
 pxpDZKp5xFZI6aaqyvbXInPncRgbseb2YszsBVse7pPGRTnkNCYjEuy+AOOHVqhw
 UcdvFA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa2y64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 13:44:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844e383so131577685a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793972693; x=1794577493;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KFMOrkADVP+8BGFWWz5DwK17BKn+/vVaPVTQ4G5cEjo=;
 b=HP1yyDjc/qLXia7VDM/7T6+9nuyNgdaE+HE4AZd4Us+K8H/AiBiBSfiiT2oFRGL1lY
 a5bBTjUAmgPLmb6mRXl5bYO3HxSepFDULCzTt21pjMA2yyDGWoqJDMzghMYpBFEF9N3M
 xA9TWdNEx2P6Tc87CHd7BjE0HByM/9qS5zsrZJjAauprcQywmrs6n5mPQ6GlwDqXYzK9
 RPO6dHhoIIqab3kJ3UxsI8YDLmKnaDdbgQ99/5hQ0XcR2vFH6eeL5J2qMMiyBXkwWdCu
 UCp9lZrPHWOmMBMXe5rqQr17hvC08EA4SynaJxA1RPxyQzbYR31VOOnj6WIE1/rzoUrU
 Npwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972693; x=1794577493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KFMOrkADVP+8BGFWWz5DwK17BKn+/vVaPVTQ4G5cEjo=;
 b=bE6DhjE4ypumcF4xm6tjtgoXyOxdeUnZR5uD+XKM7IsQM5TDStKRKAmY/uEu7rMNRw
 yV2Iy5sF+OO7F9+i/aGkjFxsvE88PSaiH4bDcYC+BmVzLEn/yCxzLb37eJR2v5TNQBKb
 Kau/2J/sCpTh6cs/Nu/yUZVLfro7fi/bP56ERf1yFvQvLHJAGT7hDE3mlQMbJvVwPkJM
 UV7XA+Ozf72vXuXpzfx4xT4tWTFKEKi2n2vEID3aQ3Atu2R0/zGOr5EgCk7fEgut6j9i
 FNwjtMX0lMD2gAHYT9ii8WZxTGfNG4JlYYiMU9j1F3maJhO4Z9XBreeqauRjLSGjygv6
 G+3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBywJ+ckbBHFMWnvcFPrHnZzkvn3+eoixQy2/IFJIkI133teQ+LGSaTmOYknAtP8iHvusa+s838ZNC4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8X6jKKuL6rCyHfi6v0kLhmMottGPVeqbBNJnuZ6HL539B8Chgi
 +mVnWfC2s0gt2ly91MuwqqyxOvkvTDC/xrd6icUM9VLIOxo5aXqIByBmw77ZkbzSXqjARx+PhEd
 ylVPHxTD7oozdaCMhnRcKXV6vhR0xCiuIFNrSO2/8vGdcGLR7isQW5HUta/cZfIv5Jw9F9b8=
X-Gm-Gg: AYBFou1nvDZKB0hz4yS0KqYpI/YcmoPZSRudBUX0fxW6QT2Giq1XyfQ8ClGD27+Amr5
 g/aX2vExG9pXXwULxUxUbgRAmisARV9uhiQxbziEHFmDzZVmyRDu6sp+Lj7+1zPwRKWTv9PX9iK
 2hbquykvL4pxf9zGsAEWV62vbXp3uSxRmlBNjRiNw4IFB6fsPlpe15LqjbbhCMe/UwNeW5tfrQf
 XYnNuCDTlgy4+c4keuI3kco2AGgkIJ4nYmAp2fYrzVi8npjVnYSuuJZ0Rhm54vamIUz1A9wYT0c
 JUqeghKxqc2/HNje3jDQvcNmpRPVnaQ4vGEfA5q9p1h0VPrzINodTyOo1Qc2qLsBRtB36KvUBGg
 lkZ34B5E0uFSxQipiNuvyOzCZjoepjtOyZCHTbGkpYcdMnBOXIILIuMLDKQVmEjfhud0N0+PPd5
 GY3KvumIzCGpkbD1W8cbs/50V5DCtjn8st72LGSer8Y7dugik2pq3oeVwXXQY2wA==
X-Received: by 2002:a05:620a:4107:b0:93e:d364:c9ee with SMTP id
 af79cd13be357-945f35650e8mr365627785a.74.1793972692550; 
 Fri, 06 Nov 2026 05:44:52 -0800 (PST)
X-Received: by 2002:a05:620a:4107:b0:93e:d364:c9ee with SMTP id
 af79cd13be357-945f35650e8mr365622185a.74.1793972692010; 
 Fri, 06 Nov 2026 05:44:52 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c003055a5csm382747e87.13.2026.11.06.05.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:44:49 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 15:44:14 +0200
Subject: [PATCH v2 8/8] media: qcom: iris: describe QC10C as P030 (TP10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ubwc-format-docs-v2-8-82949f88f030@oss.qualcomm.com>
References: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
In-Reply-To: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=iqfuEamj2XlYNE5hnAH8AT8Abj9VyJ9jbobRw0cnh4U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq7dm+CuAs9qhMdIEzhgPgtp3QrLIHoNoaQQRqo
 5AS3EfM2waJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCau3ZvgAKCRCLPIo+Aiko
 1dACB/9wA5t9MLN7WDxdbjgtqULBKGm0SpbExAmy9p6mSMbiTO8Le6urnKTjbKIOZ7ASp+GT6Xb
 9tp9oF3nSmHKUuPJVN62rnCYy/aCCQf6kQNRbs+DGOtdl2JYO5oAz2be+16k2a4HQ4jYknMmt6d
 jWUmU94ZXRhvL+VmecHbdAomLNoe0edTG1B2hGpkrdCqOjliSumqwgR3VnadosCpLd5yUZRsHfB
 QDmfQpLALm+DQiBohVvSnl3WAKBEoE/uzWuUzeQqwKaAh5ST8z5n92RMp49LL+feneDBClJ0+F3
 H6QXQd0qaxqniymZG2q+iw8NRfjarePkUshiri/P0SLz5Rtu
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aedd9d5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=w2mF-G9HTFYObF59u-MA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX3WqFN3LowikG
 H6D5zPvTYaJcpYdWuViDTggPMFSZM6WXS/Jc5oE4DT+odxEifqlOK/BS0BZhFCuiQVSM3pIgOFL
 PvnRoml4jk5gqj0ASKNaDajS3o1ivCE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX7E3GbM6R2cSr
 GDpTgpO1kL4TMu6/2WBt3FA73UPSuhZkqwlm0FP1wcoCtxZJMTmlfvULcTRsYdwXRlG6acbvrJ2
 PEGdVLseI9FpF2Iy2+LP6mDAysiFRE5kbnwRmsER/hZfOlGFUgYWNXzG4IS2r6BMIypxyA75R/Y
 LxpCajcZZ47uCpOp/bEKkwxE8xOwPZn6UyWd7lGvhJg3JwqOx9UxYrgCRYK96/RpICFgqank0UF
 5//Omj6VldPpqXE47BR/AY6492VYaY5Zz1nlWkvHuvT6A4KcUBc+EZgAYY6f3uP58TOV1pKeOks
 5rOtiQopfykDxZTayY38uDiD4bJ9N6QKdguGfJL4VEFevi/qkTYTaazIuAhAW/ABWVE3UDDksLI
 aoR6lLaNp16mXOva0JX/VGRZihUr/pH989XHNxtEpmXOTyvXdTBLxAlW47MYQxQVrPj0RP4UVrR
 U6p8L9e8vwCHSJAa3kg==
X-Proofpoint-GUID: YLYs6e_rmr0g0c0lnoX4umNgzlCoRMFl
X-Proofpoint-ORIG-GUID: YLYs6e_rmr0g0c0lnoX4umNgzlCoRMFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060054
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

The comment describing the QC10C buffer layout calls it a compressed
P010. It is not: P010 stores each sample in 16 bits, QC10C packs three
10-bit samples in each 32-bit word, which is P030 (TP10) and what the
stride computed below (width * 4 / 3) assumes. Name the format correctly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
index eb8de60c1177..19a984d2ff3b 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struct iris_inst *inst)
 
 /*
  * QC10C:
- * UBWC-compressed format for P010.
+ * UBWC-compressed P030 (TP10), YUV 4:2:0, three 10 bit samples in 32 bits.
  * Contains 4 planes in the following order -
  * (A) Y_Meta_Plane
  * (B) Y_UBWC_Plane

-- 
2.47.3

