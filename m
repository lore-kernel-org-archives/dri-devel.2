Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4DF606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NvC/L5yg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YGCO20W+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC79610E553;
	Wed, 11 Nov 2026 13:06:07 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D5910E908
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:39 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCZBOm2288020
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EQWl5k5Bb5z9sN1Rk2HwinSW3Pdya3j3yf455M6otcE=; b=NvC/L5ygkNX5bN3O
 06sEMHIa076XPn7KEoMUaduGu6JAabJZvOxMpehYGm1BhPSk5J+PaxNUGq8ZrsNf
 E8v5ndHOsWpFff65yKypozPCGBr3erL1Yf1S2pcuBFuL87v2wP++UsxM+aSNLJZT
 d/VuEpAqskFsN9/kqLMGd5udCvxzdNJ4XmKlGuDx8mXd3nx3ZLLhrDia9jBBdZsa
 vYX26WVMI1bg9okDpnsqW6o1csnVGGedymqO4HRoVKfEsi4A31Y9KrnMoF+lhUMn
 dZubSgJNY3AVcpXq1cGOuFIVaiqA93ES7HjRMU9o234LbZGPVLjOkdfr88MIIBjl
 y2N4Jw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm9948-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:05:39 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c96bf59c31so962760e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794402338; x=1795007138;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EQWl5k5Bb5z9sN1Rk2HwinSW3Pdya3j3yf455M6otcE=;
 b=YGCO20W+nILk+AHY9eGz3Jvw3WvBMpp3t88+fSl8XpWv09gyr9lz+0IGLAx9XvmyMu
 R0nT3ciFFjQpRCIVmT1/nkZAWxedEX8oDxJyY/6FU68zStkQHfbSsISQ2egXxLQBW0uS
 KhmMntDCYz93S6j7heTiUDIU3WvN1NfzNekkjwpi0QR4sNDnG35fjhX7/iNif0MdNbsp
 0/5xEPTofAXLRp7kHZrQFb0UQ5uxeFOO9EISHfj9OPs3YkA88tZjquqMaZikbDUpLN3i
 bTjEseEy4RjMmfHV2SiWsA1tjE6jnjxrEnaerFkyCJWxsTYm67JvsIATM46ry6nUc17I
 7/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794402338; x=1795007138;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EQWl5k5Bb5z9sN1Rk2HwinSW3Pdya3j3yf455M6otcE=;
 b=LDZfaVm86Ptzi/s6eMVxOt4DoMhiFe6H0N0kge5yHGdPhfJ+2F6FWXwGvOIempPkjR
 TGoC/J2SwmdYxIQ8B7hwZuVpFY+JbcVWbJdQzDY/jKrlh05D1nGhqNmwI8iFI9HCtGST
 sfsqW+SzAfX6xhyVI5172x8WW6pcq2MH1FB8+xDxJVSia2XaIWnIyDIVnjcH0Rd2zyNc
 ELrj9X4iXxavIpN8tRvemHwG5mwDb+YuxlbCp6W0gj1bMQIbWY9h2uUboC1ZSIL5lkRu
 Kt/VFPAMSG7CCaNzrYq8M78ppHOquHET7W+Fk8jdi4v4msnvuqlsF6MCUOj0afs8uGwA
 NvWA==
X-Forwarded-Encrypted: i=1;
 AL+hErE9xPH22JTQs1nGiBQd8c/kWtZwoTykKZjyhDSTuLEVyfDbPJZp+bXY8F9w1fPCPzp2Wxq6LV+fIc4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/m2k6V5VrK9Xtl8YJhlXIaELhgRGLjbHdI4HGYxeUkeDJKSk0n
 EiVia1PH3mP4Pw811JNNgnNLT/u3QYUwE7xptmpBBGLJo9melH9tYx/XMkHDFcLg1hpuvQWqB9B
 au484K185jejUHXjbF5/aSMJnTlmpQktrxz84mZDwh6y9kMCnoUge7iI6XSJ49DVTGw5VPTQ=
X-Gm-Gg: AYBFou2LT/P2T9yfCnyeoWzwriXRmtgFEq/iOQWnd/Y74t6guWSumCGqhVlyZ+5Nkav
 Di3lsPge6jGOJkV7xlO1wlRt3hyzRqKkp/koy5BdnPk/Fm1oUVWnidzrwtXcWDytFCBi/spBAXT
 aseP5AUrzgdqarA5gIV40aHDcEV6rIjh5cj7D6c2ogMad8mkfqM2gT/lRaUQLBKT5UezKlmbzZU
 8IvQr7E0o3o9fvweLwdSooUPUeVWY8VsoNhGOrVuh4FjjFtLF4guj4oBG7+eU41ztenZ8MnCOKi
 ydvKz91hVnySkQhqSYGIDIbztAEEWZSawcZlwp0n3mesA+YG9Qd+Ooh9gd7i0ip+0HFE2SVrnQA
 oQRhCQOTYBlheACa5l+WoZD3JoiJmyUeXPL38IVdO5DZBrw48pyfYun/U1O/rkWKBJVKd5WjwtF
 KS4F2mX7Qk4q8FnpRUKtCdTEeP8RQ7r+aBrhoRN+gCZS6K6yzUZ88kKZvy59trcg==
X-Received: by 2002:a05:6122:8891:b0:5ee:200a:8cda with SMTP id
 71dfb90a1353d-5ee200aebbfmr213530e0c.7.1794402338029; 
 Wed, 11 Nov 2026 05:05:38 -0800 (PST)
X-Received: by 2002:a05:6122:8891:b0:5ee:200a:8cda with SMTP id
 71dfb90a1353d-5ee200aebbfmr213505e0c.7.1794402337496; 
 Wed, 11 Nov 2026 05:05:37 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c15d368e81sm391858e87.21.2026.11.11.05.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:05:36 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 15:05:16 +0200
Subject: [PATCH 3/3] drm/msm/a3xx: update the CP_ME_INIT data to msm-3.10
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-a3xx-fix-me-v1-3-d81f50f1ba1e@oss.qualcomm.com>
References: <20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com>
In-Reply-To: <20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=833;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=+ViPfrdASg19eIkYrm3pPJ/m7IB4rdlNRmFNly/QK20=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq9GgZZG5eJUlvVozg1SvFjWYOWtvOrP+He3MS8
 ZTKpYzsOsyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCavRoGQAKCRCLPIo+Aiko
 1bT5B/sESP6mItRcWy5C+hS/P61fcKVneQJymiST9tKU5DB17cTE8vJdNQ3sPi67F8Wl7+26Ir2
 s017/c+3kMM7z2yMayfefgUQjX+Kpgg5aycbRI5RNrRZbU09TvOdAUzy57fxjhsrAb1gH2TbOQP
 Qnmq244amrMNd9x1KOmIgmjZAaH/28ENzw1NYkqBxfmRbUeCxoocDcxpuyVBjzA+BGOzOHv+8JM
 /PkMuAkX6V6pW75qHDw57K1+p5JHFw5FrRPc8BW+mbpUqEBI2NY642plRP8VBZQ1z+gT+gnk/JD
 B9TMg8DvZv4igBX8zVxbmcndRBT4nUyx9M6fiFt3Nj6/qUQK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 1dRQFe40SQWicresQiKfqhE3O1kYeJIF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfXxJGpe7glmG4l
 uKGdYHRoF3eRHlOGEk8hITBbgFFrJP/Z8o6Dqb1mx/19Uyo1bEStkDaquYnxrgu9RrkO4MkmFm2
 VDFxvvnHTyxkzkg9pXwRrQ3MjPAeFpsIeLomiklg35HqUkQLrBzBBdn5kf/BBeBoR36x2N8o8Ej
 GPgJUjCWEjnFraYbzB6ekqnGHem5VzOYsAJJAWfGgqsjWh/JHv1RgLjEFVaO0soeHXekn7xFH7e
 uhUgFc4cJKqP/H2JeKADGu/yBr6XwTAQ8+SJnnYYyq/mpEKu5whu+cXo28EaXEGsArjIdl0To4i
 Uo1EcZ+GOfJ/u5c7qPpwTov/xNlq5kcuCPCq3BjEMGIG6zR96dtS8OfjXAO+My/WIrvbc1WpVbE
 5YX+ityVtQvUXG3HkaVL+s5cQM9ghrJ1MUnwgbBroOAsHlBW0gWrneWUZvcf0uhvScnJeNpgRVB
 D2MoaUyBs9Vn9Jn4ewA==
X-Proofpoint-ORIG-GUID: 1dRQFe40SQWicresQiKfqhE3O1kYeJIF
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af46823 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ypG0q2TZ0WS5u_ylJzIA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1MiBTYWx0ZWRfX7RfoWADD3Xpf
 QzioMBG6c2Wl5BPrx+JSfl4jvsSsQmh4So9u79MrdyUx7nKqvYA7hKdmVs517Uub0XtE7b8scYv
 MV45zpD8eyCtT31ChZezHlld9YpwXpE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110052
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

Update the CP_ME_INIT payload to the values used by the msm-3.10 kgsl
driver.

Fixes: 7198e6b03155 ("drm/msm: add a3xx gpu support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 1de4277ebf9a..1420f18bcf75 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -103,7 +103,7 @@ static bool a3xx_me_init(struct msm_gpu *gpu)
 	OUT_RING(ring, 0x00000001);
 	OUT_RING(ring, 0x00000000);
 	OUT_RING(ring, 0x00000000);
-	OUT_RING(ring, 0x00000000);
+	OUT_RING(ring, 0x20000000);
 	OUT_RING(ring, 0x00000000);
 	OUT_RING(ring, 0x00000000);
 

-- 
2.47.3

