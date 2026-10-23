Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3260A2636
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V8cIjAwP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aQxF+c55
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F7E10E763;
	Fri, 23 Oct 2026 23:20:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC8C112D39
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:41 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvDiw3983449
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yv7pO7Jw2oEWR6tz+A4kcNR+pqqDBtVeuYIBE/hxEUI=; b=V8cIjAwPVzF3sl0s
 qqVdosh279tMLglHm1tDmWR1h3tves5/FxXbwbSgHSMRrBaJQ1a1fRVbhsmdiqt0
 ydZXYZaURZEYUDelErcSVEQegqvxoZ5CzbtSzrEDFPtJMemsPZgFsS2sIvTstvlI
 IYjm1nh5iRXUelq5HOeC+AtrdentA2QoUzjlJHKphLuhCHOhWmqMjSW+mS3ivXip
 dvd+if8Z+qR8da1KkSCIQhQ0yeKkOwjDxiF4HJGyrVcKqN0ZRJCTuxTR6gsho/k8
 ocgy2pKgYOcak1XhgaNdNwlxsRMYtq69tDG3oW8IUu4t6OeuZKYoCv82eqHZtFRK
 tAWagg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgart1d0d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f13c143c8so251444585a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797640; x=1793402440;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yv7pO7Jw2oEWR6tz+A4kcNR+pqqDBtVeuYIBE/hxEUI=;
 b=aQxF+c55FDZQeFg72wMU4aWGMRVwajnfTOLq6D+fze+tcB9B6Cq+HfIEbTnHmk5iSx
 8dMvZTRPrNKcnx7CB29Y4NHUlmLrdZ2fwjC2aMFPTtbeKvklhEybXQ0SeyYnb+sDkqVL
 YQINaPt5eVoMMpblN/Wvg8ti0ecDAc4lSPmR2CdTWzmjKszkIKHIUjdMd3ctfX/1YkMj
 4262stY0nA/5PSqlXs2jO0fBoB6yak8mkR1MjnlzTAqmqFIIrpGBqRc4zWOT5VPKxoWY
 cUYYHEn0Mq1FaHboLM0UDNOlrWG731rTn0M55mSad2m3gCUPg4H2brAbvrDO+v/gidK/
 F7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797640; x=1793402440;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Yv7pO7Jw2oEWR6tz+A4kcNR+pqqDBtVeuYIBE/hxEUI=;
 b=I+9TUZj9uh1wTFeLR/5ZSjmEsuTJxhXhKJ0Hk+fg48aluMzk8qMG07A72zIf0w4lh2
 8br6iDZO1ajpj3kU0pM1kufCP/b16hoZ9Ayqb9KEWkdt4k6HHWaQUIEcWoLuib7H4/kL
 OdqdlVC3g9C8Tc9JhrpgnFcvzX22kUrHHvbE7PQhJuq5flkSrG6u5lHRpQx0hMqUnjYi
 ZLZpWJJVbTf258voIkSyWLbhy1OAsS8YSL1tznx4emumsMb7vPRqK1HeTvJnKoPOXEXB
 O2oy6hP9bZMb4D7OuWwG/RMf2leTgzxq7vIEALeiNJsYjrMW0XSDow0O9H8hcbaThF8K
 aDzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZbS9fEFu6TTG9BqK2W+utZioB83i++RJsk7nEfDsLchkFRApUa10/Ca9Hd4I7ngR5Y2FBvSA1Ik4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJlEJYf9XDDadlSkANOUbvoBSAOy/G4DiWhWfarTFq7v19e6opR
 3cSPJ64huNf6Cmow2KSjJC4imqy0O5IRoXu2Vup3Sn9UJ+rT4QdDbQObWn8P2l3D18Jr2t7Q7vd
 37GV+B5hZXaEyk5EgbzHnnyyrDgS+ikidVWLawKeQPfPWEvIP0Ldr4w7w/MpHFyCCaJcBZKo=
X-Gm-Gg: AYBFou3TtIemd1mksJaYUTV4AOIgHgvELwt60P1aJTZv4sV9WlMxxqB5jkYcCOVM4AI
 va4KBuRs+v3+btI0bwrenGIZjL7JrTLxQaO/O0u7m341lohz7RPBagKDIMR+kgBdMJYKjpGpHJc
 zRAHuukm5q6rSLW/WisKQTCKMgHQrpY5hj1UY9c1bTBD3tZo8mBRaTjLMAc84w3iLFM/EbM5U7F
 TBbfbNHU+mINu+pbYVEOfzSBnbtT3cWCVqHpcP574mexn4L9A/FIA8GC/zGzg+PpHdITkT3sl/A
 H+pE8hRg7AihwrZPsKuVmZdpdwHxRoS43ruztT3hDgW9RWStDe/1sXRHiIKtsvhi1Ttrxd5+sEr
 U7zZ+qRMdH+6o6HZYaqXROBvRviAj16ykSGMYrUKBNUWJ28VDOCY/IuywBsAIQyYNfh40XkATL5
 GJUpMvUMdtsf4D
X-Received: by 2002:a05:620a:2984:b0:93f:571b:c733 with SMTP id
 af79cd13be357-940ef901d8bmr86865785a.13.1792797640095; 
 Fri, 23 Oct 2026 16:20:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2984:b0:93f:571b:c733 with SMTP id
 af79cd13be357-940ef901d8bmr86862685a.13.1792797639605; 
 Fri, 23 Oct 2026 16:20:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:46 +0300
Subject: [PATCH v3 13/14] drm/msm/mdp4: disable the vdd regulator on teardown
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-13-66a30120a5ea@oss.qualcomm.com>
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VKYiNlRfJt8Fwux6dkL1nhokW/Bh3mSOu/sCPXnJ5gY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uYSSzng4DpP5b3LjESkZLtZ1OQwtkpYpx5d
 qEVTTmYH5uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrmAAKCRCLPIo+Aiko
 1WWrB/902OJE+kHi35BZP8sSb/53Y7uXNU3TtdFd/43ktWC6QMoWgqS3EBVSRTbcMXiNUL3nEGZ
 o0f5b5FLes2yO7UzK7GGtjC890s7KQp/LLRn1V6tegJi+tveo6jH4C24Bfa6gjv0PB6yk8BQv7r
 x5pxDF/wmccUjuTfbYkX8t1QkQ4ZZGknleoDMqgu+4lW67NXzV1R+ksqUzzoFRObCipgzVKYyd1
 xl86RZ0Br10M0aq7mI89WS8lrogQqbs/OYUVwHhHYr7832hlkvIVRZPJ6CagkOzxvUy6VinR9w+
 ExuR57f4CaotZCekFVt4RCIg9bKr2MX/nyaBdQLzrQBiE4vM
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX3mPwAIz6lJ5/
 PMA/QPy9+ZRWAMDyAvhE9gaZMOC9m1PN4CbsKiRxbM0PY8X7U5c2C2mtEzyn7/LCAqHQyDqCQlV
 9sJGHTy/uyVHtr5xdadwiyO/cYBkNAekNnlODtkt95WCiNT1IbNu0NY0uv+0YeRTUE12ZArXNGl
 nQj4log3uApmQFO+SgRF6OGUuLUeu9Z1FaW5Pd7F8u7qNhfazu7fmgW0aYlOZ7KMtLIAtzjVzvK
 DsGbcZ85p+KCR6Zh4VGbrb7Um8bQaApbSvozjGcATmqTBcFqA+n7eBNgSPbsr2XP+/nPTmkNfyT
 xjPCAD42i31yPd+D4bEcjNcJ/r5hxi5lteIq2bYxPeyCK9XSH5b49J7Hc0KmH7GWXQSonuCmPEb
 wFBDGBobFHfTfQmvQE3XMhD7PlT2vpunHG7qsXkQHTmDqBeKjvEeafjE08dY2MPEVrtJJZh6kHf
 uctPKH9zI7rMZ34k7GA==
X-Authority-Analysis: v=2.4 cv=JI+uIMKb c=1 sm=1 tr=0 ts=6adbebc8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=m8q_D-2G2n8EEWQKP4cA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX5Jg8dwHJyfCO
 GcD1tN3wgEiCxb7xy/kOKSAXQlTqxDFiX4VL0NkLmJ3oo+0Lr1N3oY2frJS5A34ewYixckSgVLe
 4puKXG4LiDhRU2jnaMcV/mtgsJM9TuM=
X-Proofpoint-ORIG-GUID: XGj89O3P0ug3IDhPoKxxBgZblwzLtFns
X-Proofpoint-GUID: XGj89O3P0ug3IDhPoKxxBgZblwzLtFns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230092
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

mdp4_kms_init() enables the optional vdd regulator, but only its error
path disables it again: unbinding the display leaves it on, and the
regulator core warns when the devm-managed exclusive handle is released
while enabled.

Disable it again in mdp4_destroy().

Fixes: c8afe684c95c ("drm/msm: basic KMS driver for snapdragon")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index c1f61ecf800f..cb95a492e070 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -152,6 +152,9 @@ static void mdp4_destroy(struct msm_kms *kms)
 	if (mdp4_kms->rpm_enabled)
 		pm_runtime_disable(dev);
 
+	if (mdp4_kms->vdd)
+		regulator_disable(mdp4_kms->vdd);
+
 	mdp_kms_destroy(&mdp4_kms->base);
 }
 

-- 
2.47.3

