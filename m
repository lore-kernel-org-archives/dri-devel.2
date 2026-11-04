Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E53D606D824
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WT2CMDWh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZJ0rxmju
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E3E10FD41;
	Wed,  4 Nov 2026 16:36:54 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 493D610FD1F
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:36:43 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fitcm2210764
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 16:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ux2INFN8CyiFYeuZ7exzPWUq7g3zN6LyU1Ff8oDXkFQ=; b=WT2CMDWhY2Op9Xyh
 IiUxdKXgoQeqXjqsxA/EomAxX0dwvRY0fyZYEQrHhtGs6x8tKgVZbQre95stg7MA
 yjaPm2n3CpdorQEaCBmXwmpY+pUZBsXQ1xhLF+GvVJZZiDK4mYW5UPSxRTqCbvkc
 ScygtmVdO8SZRqrc4f2oJG8Xoc++EzXKhJzZDoeK0Ca52IGdq18FIvuaqaxASb8U
 c4Rx6yIWT1ZYFuNHkmxP202s4pDUzIqr0zq5qxVG6EW2w7C7FMSfMdqinAUjdzFA
 /X5usHRUKG1JxXpGPMig1PU7hcggIRO8w5haRGTxnOkR/AhDl+5L6p/7LHy4o9+K
 cqREaw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bdrjdx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 16:36:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c71966998so12493046d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 08:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810202; x=1794415002;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ux2INFN8CyiFYeuZ7exzPWUq7g3zN6LyU1Ff8oDXkFQ=;
 b=ZJ0rxmjuIgPD78/NqkFpAJJwSVsfNLumsbLnBSPXiGBmqOMGialQWvPNKLSJ0D2OHx
 E5PmCOAcW+VwBvNZVVCZzCdYZirpZJG0oH0R10uLLX13+Q+xRpAyMt010LNm2g7XE7HX
 5Jz7U7W+GIYaa9POnzyxKbEXSltOXrBQi3EdEg97fyEG9wGFIgwdVWi49IKCkFnXLZV8
 Rj1p4OopLt+SZeuHdqQWqILHNRZunCh8Z9iA1vy1ufPLBY90rzVjJr4z1iqRQUCMHdfR
 znM0IWpxtVeBAojzx3IbEkNPlQyzaHzOZOE40KTerNnYS8ahZ6lkNpRhkleM1H4OE6D9
 HYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810202; x=1794415002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ux2INFN8CyiFYeuZ7exzPWUq7g3zN6LyU1Ff8oDXkFQ=;
 b=Tc5Jb5eTxLJvfStPGbXhEA3rprv6qr3MxDCpCeMII1ZssscTvigxu5p63ERxShLvg/
 FbqWfVIrS/kNK0maIYQk4YdwEt0EXznNgW7HZoAvmx1S1jCnuAkJ/RM73rikYKY2Ank5
 NI5JBw7ssV9Hahd9Do86IhPJtSmlDd52AltZclwF9ACfoppNH1K930TD2mOpI7wFq3Cf
 nRRqiu4vtzheRLoN1n+slACSswNEXDwklwe1tVCCJY2LZLvbqpV6y8q8neVrUqSPoJNp
 ULS16IE5yyogRTB1iTURPhBAbZtDj4JJXxwjDswRqIecKnsEYZLEB/S5Wq2q/HDdKa1k
 eb6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3TE9KMrN66HuDzSHSsNOTiUoKV5MKkcQ0ZX5jhlLCugQvmDqew8+F8nICjlvERYJ/GNX1OppD86A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9btpjl4CDX6Srlq9VLIghISOkqc5R6RalMmynEyLdtShWkR0mY
 JyxOcbJ4WU8d5leyvqlJ/QlX9AbzkicBrCszgoU1tQgZwwlNgr7X1/vXm1I+JjSdEKJpxI4uW3D
 e8A1X8EjRZNixwjNAa5kg7PTZvy9usRk7XyUXHftsSZ22ZA7ctTx5mfBLJIqdzjVxXZSkdTA=
X-Gm-Gg: AYBFou0D+bNBOL9OvzP3th2qN1qE8mHaMx5pzwL988hxdexdOoXZlk2gkdxdjOhDulY
 EFb7hGbj2wBQw4pA39h/kCMoVjSahb4MioOBtH7EXKmnsFmavua3XhyO8F5pMQWVJ1GHJQVF1Yj
 FbfTkOcavy7nFGcMlxYbTpugDwOlDzUlrSWcQdUo9n0ON7u+Hcf5U7vgxEAjZxu7dkxFNSxIwsy
 0GZWaP5D2V2blhXXV18cZctHxDuoQ2/TP6T7FUFfWRvE1SlanJ7yXdkIO4CqLKWmbK4BpMo74sL
 VT63/v0Ab3qrPWBnSsI1e7l8KwQLgso77jBT4fSoEL6Aq7RH0WtUH4VX9i2cJ/JXrpMnJ5KFqFO
 ijAaROU00x+mgC1RIhAH8SKXoYX4krv2APzAzARPmfuKneFvt65Ou8UTTRx/2p/5IvwTGOan6i/
 TmX6Qt9qX9kNDEAB86wNRDRgsyX2JGZ2spUgyk1ldmGYigjJCBHXDFZs9MrtAuqg==
X-Received: by 2002:a05:620a:6484:b0:93e:bbda:dd06 with SMTP id
 af79cd13be357-944213d6502mr2696744785a.0.1793810201655; 
 Wed, 04 Nov 2026 08:36:41 -0800 (PST)
X-Received: by 2002:a05:620a:6484:b0:93e:bbda:dd06 with SMTP id
 af79cd13be357-944213d6502mr2696737285a.0.1793810200934; 
 Wed, 04 Nov 2026 08:36:40 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acdc6bed64sm5267191fa.7.2026.11.04.08.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:36:38 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 18:36:11 +0200
Subject: [PATCH 7/7] media: qcom: iris: describe QC10C as TP10
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ubwc-format-docs-v1-7-389044012b4e@oss.qualcomm.com>
References: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
In-Reply-To: <20261104-ubwc-format-docs-v1-0-389044012b4e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=SvZh5CRN0P2j/QuhEyRL6uJjDqO3uIDgSWZSsRrj4Y0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq618J4cdRibKnf+VJdjtS1BHyTFVpV1dzNELR2
 sAszpWufteJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCautfCQAKCRCLPIo+Aiko
 1el+CACvzc2zdVgKhNCjubf5o6mOt8oT+ot2JHTQ/URq2MH+m54KiYmLnQO8taUoZ5mmLRhQCS4
 eEQFd2jgxfjAWgH9V0fKM2K3N22ASgSAERYgUzcNOgQpsj8yZviB2vJyXTnCcvEfoo6eLTpcWNV
 lUPQUDoQWJZJhMIkukDJA7hG/h0bcab+y7lXWI4g+dzEzhsgNV0HEtUvG8w4JsgVjqNCgbcGwVn
 ah2I2cNbktErN4rBGlNJKMojexlV1JetVHM4SBnMYNXGdqubKJz27mp6WJ+EJUnVGPr6vrD8vnX
 Q1HH568jwfqpcxDrkdVBw1coCUUX/FiQw561xu5hJ9IAP2YZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX2LiWj0ix7i3U
 Vy5XBjKbCNQEKh4SkPtOdQg8yk78T7ogbB7/pPIx1V9ORpJAO237wn5H908c8NUTUYgeIESztJ9
 90KL5qz9iIFEKJ5Q7Id6HaRRsbNZbeQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX3gqpAATPi2BX
 feJF/+bD5CaFntsbtQ/iuZby6YgCjO0Ggz1INH2AU0DqPsjpaGveabyqQaWV/jl/ZD+6UFc36UG
 Fy+ew53zzYMEl0ikYQKMc5b2c7dOm3fng9rLcVnN2sE0+t7rhueG0tLtlZ7K61qV/nbfWQNIhuT
 5F/1zbAOeZ1kTUBgfPTuzDug2Z4pFhCjNL6PUQK1WA6wFwQRYalNsurr+yKCwwskers+0xsmuv4
 viWjloajWY3DnKz7ry3arDbs4Gx7Np6mEy9mPtjOqHqDwTz+tESXhoa3tNv6UtjIdE5VK3Av6ep
 /zJo62zpdugTH/7xE9v9GiIu/PbH357sPe8VU9lovvMlPuyL4UBvzg+w1zVMApQII+NMlWpy5he
 nvomaMMR7AXVeuC8FIv78UoVzIZuemG7IEgOBLDdaLZ6shQ7NH/PMczAxVLjCOForGXi5YAhoNr
 3/3yZSxP7oX3nZh9WDA==
X-Proofpoint-ORIG-GUID: DDjXSM0pC2YdQNlc4QJhpKCP_vzvU3ih
X-Authority-Analysis: v=2.4 cv=D4XSufRj c=1 sm=1 tr=0 ts=6aeb5f1a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=w2mF-G9HTFYObF59u-MA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: DDjXSM0pC2YdQNlc4QJhpKCP_vzvU3ih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040066
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
10-bit samples in each 32-bit word, which is what the stride computed
below (width * 4 / 3) assumes. Name the format correctly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
index eb8de60c1177..ec2bf2a2d953 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -266,7 +266,7 @@ static u32 iris_yuv_buffer_size_qc08c(struct iris_inst *inst)
 
 /*
  * QC10C:
- * UBWC-compressed format for P010.
+ * UBWC-compressed TP10, YUV 4:2:0 with three 10 bit samples packed in 32 bits.
  * Contains 4 planes in the following order -
  * (A) Y_Meta_Plane
  * (B) Y_UBWC_Plane

-- 
2.47.3

