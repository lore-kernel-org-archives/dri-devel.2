Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7AB606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UaFouKCE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F1gketYl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5A110FD2E;
	Wed,  4 Nov 2026 16:36:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6971D10FD29
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:36:31 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FioFJ1292199
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 16:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QHBwADlwEkzpdYTh3CVC8KuWmqpeEYj9lfAptSkifbA=; b=UaFouKCEuHtwzAXj
 sN0G1e/I+rzJKlQkK6bE/o4YDrLnHB0rxFW/PzMlQjFYECBAArIQgMtOJH15suU0
 3QUgHfusOb2vXi1XnfCijlUMMOEdbiZTWdiXmTR8swCJnbiC+o/HP9C7J/coW1Cb
 /sJMK9UPBqbJhvslygFMUPMkeJolISD1b3XJZoYIH59Q6p1aTrT4joN+YJ3Z1RP/
 jiS+3RlU9aPudJOYFVeRnZstsdlFxqtcs3yaZnSoYMjZLUpzjfMUicII57Z1sxuA
 b2fZ1gMkcj7unw2TzpGPAECp3122JBrzTMN+lHrgN1oe6nhdGBYtmhpFwgvNgA+k
 /fhHaQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr163hxb2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 16:36:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e92aad34aso214759385a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 08:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810190; x=1794414990;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QHBwADlwEkzpdYTh3CVC8KuWmqpeEYj9lfAptSkifbA=;
 b=F1gketYlnDoNf7989i0SpylZh1EfTk47f73d6L4BLBv+rOvk/HXNe0UoLLOjRSxmiq
 v9Keejp5DvrwcKdhx1FphmJxm3LrNh/1iwrMhprgUHxLItdNK6XHrYC6cLk2Q0MF/a6C
 HTaqgZxNPMpeBUxmSbpFOxz3qenHLAjWE95ukAaiZ2dHrifZvKGrXVwjQTTfWVKwPC/7
 WryrYv8AOFw/KBh5CD4jrGWXVqkrP0VKpUgesMC4ty2aWST/+M4lJBvNPrl/Btg4N48P
 Wm/IOM1qsbMj7X3d0dE3qxjqEGpEPlMYkx0n7VnlIaVXGwkTyltOyEUgQehWAA9r18wi
 az0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810190; x=1794414990;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QHBwADlwEkzpdYTh3CVC8KuWmqpeEYj9lfAptSkifbA=;
 b=ODv7nlN3lFTbZ9eVUECE58H9MwqkHrFJzbuBeuGbSbWT2HRhc9sk52ynLOwwHeld+8
 QbbeMD9OixLW8U1LdC5EMMG8NgWTzLKj41HafKqjysg3adfE4DnbhevozrcLrD6S2niK
 2m9ygOJhRI/5+qNvTnf+z9Sx12eNkAbF2PZ0EEBROMXb32zZ9/+XpUyuYXd7asZ0Q5xq
 e7QlacNMBR8W0vyvOaihORWladxHdwCWaR70QEBPIBgNUElLThquuGIBYW8NpLzJccsu
 wdRno4/Ts0/4Gfv+TuGwAZbwjHTHkWXobvtdcoHlvyovGIVp2Kpb9bIyJtMq3iXC0i7a
 6nsg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKBQaW31+D2FAe1LMoXFUbGuOWhlSW3sSatLuyxYAdHbQJiRjiIyeEY39TCPbIwPzI3pr3AgCFuMk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+X3hNnQ/572utjyoaQ8hU+dPx+hRuI4iJZaE7jwDbFpAnQvxh3
 HAxNEee5Sf8NeqCslqWm+6QOGwUZnIquhQff4i4yjpy4JOxQ353fyX4tCW2KEYVZFnCuufdaPD3
 JoJcDD895GCfOge+66LhHq26vQGv218g4UDkrmjFAQ162JkNduorhENdZQn5JDOfz/K8zgj8=
X-Gm-Gg: AYBFou3VLl7wnkVT5ucjaQZa22Jo/fjwdOoSh7QlIfCwgiCIdqrj3ncj/mH5mgRizLK
 wkAFK31t6mg+HkDkgz9ULA4xQD5RNSchMFMIpZBZanRLiGbr2B8HqXh8hJ56z/nNQUNFVzawECj
 BAsFcztlaUzDe1iVciWw54m38AiM+UawVIxHdeZka5rS+wsZF3JLYP/1Sx9ZBSwnzl4kBftzYLm
 V/xZm0/q/fIhJL1GZ4q38nqqLPBBROQiJ2GBzWBmx4YRZURFa8zqweFNOmk40e7iiA6cTEXDS3k
 qDVfmKSC/qCfbbR8JFejIy0wx/kraFT9bhhMQZJKBmBfuF7lQErwXFS0gJs88Quajj3l492CKif
 BBkswqOmeTek6Naf0aBvWWVoaItDN15AbjDeTxhF7kYNbqv7yF2jGjp4vloOmpkpwdzoryy59Pi
 mbvR90ZDaafccvBemLCmlv6/OfZdVaxpEmqK0OKox9uTXemsVhU9dYOyzxp4zEhA==
X-Received: by 2002:a05:620a:640d:b0:93e:9934:d179 with SMTP id
 af79cd13be357-944216da4abmr2556842785a.56.1793810189885; 
 Wed, 04 Nov 2026 08:36:29 -0800 (PST)
X-Received: by 2002:a05:620a:640d:b0:93e:9934:d179 with SMTP id
 af79cd13be357-944216da4abmr2556836785a.56.1793810189373; 
 Wed, 04 Nov 2026 08:36:29 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acdc6bed64sm5267191fa.7.2026.11.04.08.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:36:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 04 Nov 2026 18:36:05 +0200
Subject: [PATCH 1/7] drm/msm/dpu: fix the comment on the RGB UBWC plane count
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ubwc-format-docs-v1-1-389044012b4e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0CAHkr5CD33DFJQjC5hRRncFTgq+EH4OMdHJOIvKkuI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq6178730VYiuN89SBhOeHfmoweO7VJXOnWg74p
 yHNRo6XObWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaute/AAKCRCLPIo+Aiko
 1XJBB/9i9TOmM0jSVpjdOHJFEnirGeiyzwiBomZwJrKi5YlcfKcYF3qP2f7QgUMTyErS3BYXwxo
 4vLyVIIk+pmjBQGTjAB7yK+kNna/NaW7I/Jxww3cN/T6+y+7ZyP+HJjHXZqX1OtrPo4q8pYeTNj
 rLkKI8yhrGp/ZRnV+fIn+FIeS/3H5LrT1JU6taU+YqWiRpUeB+1g5T6XsJnJJpyjlhxIC/v74qc
 OEOPJZ/gwbanUJc1Hn+wMObYEVTflKWAArFq79lsBIhGCnNrMtFCcRoShoMzPuxZMx8uakoQWeq
 RmC1Vis+2s2sGzbGTjKfisl0MqmwsaSk4n2HSKVVQ4fRgVSI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: JQ6eUp6tPz4iiY-OT4fN5FwZr2g8Dhoa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX11oOx5DrwXMY
 NUBBtm8lZtaq6XBlutrjh1tDha0fjWcs3MQek8dc5ar3CFPudnGNYUcUMQMLpfgcviABKfb7/N+
 x7Ihhh7e9bPIxdILdg5s4SOINv1qqcw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfXz7X7/mRHWvuJ
 s5yJ/r5UrAZKe+p4qZmCD9EYHt8Jzt90wWewjpWN/HIUKi2ycpbOSLWJxyGWge56Q0txg2CXTit
 PBWzh5Pj0NqHnXe8fM8Ozrjjc8TtjKzQXq+pTSoHiWCvHJvfcprvfzk60xdtkBeRQ38ymjd8nqd
 KjB6wX/d9H34HszW9ZN7P4ffXIB8G4X+R65puMdUGnYvlahEIr7EoTtiqj+hxE5AOwTa3hNDQ6z
 RK1Dge6bDoqcV/txVepYik2CbHWKm2sB501MmY8GQKDLlp/hnPL4Ft1+//wChcOg4CNYW/4W71q
 aPBA9XAxvJbwGaUvO8/KaqzbrAkG6kPFKSgEV+sT3InRl6g9NqGZCAue38IbzDtOPWd2QgPBekW
 Eg+rU9m7B0kfUMNVHil6MjQcKuooa8mW5BFmF4Td1qIkJ/oJ3eVFA1UtySHNGLv7IBs8857768D
 4iz6p2KAQUod53vq+oA==
X-Proofpoint-GUID: JQ6eUp6tPz4iiY-OT4fN5FwZr2g8Dhoa
X-Authority-Analysis: v=2.4 cv=O5OsLx9W c=1 sm=1 tr=0 ts=6aeb5f0e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=53nbmNL_gIBj0mvaGlgA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040066
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

The comment above the num_planes adjustment for RGB UBWC formats says
that the uAPI leaves plane[1] empty, but the uAPI has nothing to do with
it: an RGB UBWC framebuffer has a single plane, with the metadata in
front of the data. The empty slot is in the DPU layout, which follows
the SSPP SRC0-3 address registers. The RGB metadata is fetched through
SRC2 and SRC1 is not used, so num_planes has to cover slot 2. Say so.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
index 590922c4f69b..a8e9a69834af 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -126,7 +126,7 @@ static int _dpu_format_populate_plane_sizes_ubwc(
 		if (!meta)
 			return 0;
 
-		/* uAPI leaves plane[1] empty and plane[2] as meta */
+		/* RGB metadata is fetched through SRC2, SRC1 stays unused */
 		layout->num_planes += 1;
 
 		rgb_meta_stride = DIV_ROUND_UP(fb->width, 16);

-- 
2.47.3

