Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865B606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o3S3hmZG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D8lNUH3A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C35E810E66F;
	Fri, 23 Oct 2026 15:32:33 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C4410E69D
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:08 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6FOl2974651
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DySIkjkLNzBjfm2iRDrOgfAGcklnPyicfzhINo2PUoU=; b=o3S3hmZGZz/xOtlI
 AbMn1pO+BIouwFtMYrp2W/LAJh6M/5zNGqrAu9JBHpv9DgdYup8OzzGs+HePK1R1
 +pk8Pl9RWqCbeOArSf1iWXgT4B+GerPJp566qg3NSBsZOiMotshLwCmtuRf6xD/X
 JTUielYyc4H8PwnLtPF2yKFZi1OAGTyq8ki5JKefeJStA8KXM+MaHJsF2rdMZsnG
 U1Y/RJQDPAmWpbADXc5Kyn8u07/0cGpfsGqVPlHM2dP7Yb3sCJPRp07hmthrv4OE
 sa0q/rWxrivWXiLnVuspZEh4koFLh62wwZZT2mQO+mmQ2A/WsnxI2STy9c9X4LA+
 HZYaQA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw4tb5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:08 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-990ca9607c3so644177241.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769527; x=1793374327;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DySIkjkLNzBjfm2iRDrOgfAGcklnPyicfzhINo2PUoU=;
 b=D8lNUH3AyCmqpCNiJiNq+6wiBQFi9Z7i3ynzoF8LEGL4Zxy7HKsSN5rijQsLH7mOJJ
 9ToaRxawMryHMeUApCxcfslM3rTpowWs6wuwU76WlJcon/fizm5Ms7el/5D6Df219xGJ
 p7fOsONmnreRBok5kcsnheYsEsGdRtiUPkgDB9/KdZBYN0QUdj/uwUuMKWVWsL/613zi
 Mdra1CFZk4oKFSr/LnryA+T9Ob+2NK6h484tq59G7gdbl5/ntcVaIMz56onYWCtTxZUq
 N3Gc3kOsP3McoYuQ2w2aHyCoGE3MwMVgZW5Znbo1Z5OrJmu2OzXjeu5nKswxXl3/72lK
 jNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769527; x=1793374327;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DySIkjkLNzBjfm2iRDrOgfAGcklnPyicfzhINo2PUoU=;
 b=1LyYIu3lx/Wftx3hssXoeousezxjTih/BN0dVVkJA3NUKsSuM2lAeSMLo3ikORXFGS
 gyy/XQw3qPrANvEX5hbSjFFfn592on1IXMs9MnvbkxbY6xRkKR2HY+5VcwUuN3kMlJI9
 immZwz8dAjeFzrn65AyCMnomGPE1igoQnYH5LP0FJ4sK04IMsVnhy5o2hCJihDMoblAG
 bn5HhrU16C5UyXXXWxFy8vk3BpUyCiqXxOBlxcIlsoSYeUwCgn4l4AnTFdBKuVJJ5EhY
 V2vaDxExjNP6Nxzg7M+wgWmwwP/4BMOe2JPwXXk1T/zjUzvMSDR4tzIsbO/csqkl7JeG
 M4cQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByXfs2GNC/SPSh678PE+CrJEKuCTYB34t288opQUTL0nbR6J7lqw63uwWstNvBWNgl6m7G4CXCesQs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK01vEkwe6i/XjdZZNE+gMzqocXbCZo43vzL2aE537aqLoMNXs+
 QypQtgGpmM1wvhPOg7K0IRlgrAuwjEAU0MXgr35lSz1BkIM4svm15DwMF/23Q7ogdzbl7oMc13k
 CZAZhsd7svnAvXNKxP0ZTIJ7wkGmPtQV53T3hlqbv0EVVH6mOUmGtOcdpmI/NYIHZ6GICjpQ=
X-Gm-Gg: AYBFou3KQK0ClC8M8pcNIGyjDHWTua07R5BGS0EE5EifwvTjmYc9r+XP1pUUJ0pSTQZ
 xWjbl45FrjZ00GnBfg3wVTWnBCl5nKe6UCAHqOn7ony+z3VtzkhlvIfHCLc71mSrvooYL6DRXmg
 1sBdJa/43dN9yk3xqXwQF0VHZnczOXWFl5T/V2Yut+4vvWEcUeKr/ng+KumuQ3VALKn2xoltc16
 WthXffgwfj3d6m6RkToTorrWSvLJ0PqyiK/tyQp+wyPon9jzyiOlNTw6ARq0gH9jhxTcr4magSM
 V79+A1n3iWal0PGbP5184UlEZ1SIaIQZXkZoKKlgveSeBXiFrgU1rRXAmWpbFygd1fskduSoRLd
 r3OIPqCUAEqjRwb+TrupUeMa8E1Okhv91z+85/WVXfJVvwebxuMrWc/7nEcIlLZkjSONv1eqvUp
 lt6G6Ox8K5QWyU
X-Received: by 2002:a05:6102:2d0d:b0:7af:fef2:8ecf with SMTP id
 ada2fe7eead31-7ccc328b76emr1082195137.8.1792769527401; 
 Fri, 23 Oct 2026 08:32:07 -0700 (PDT)
X-Received: by 2002:a05:6102:2d0d:b0:7af:fef2:8ecf with SMTP id
 ada2fe7eead31-7ccc328b76emr1082167137.8.1792769526933; 
 Fri, 23 Oct 2026 08:32:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:32:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:28 +0300
Subject: [PATCH v2 13/14] drm/msm/mdp4: disable the vdd regulator on teardown
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-13-83727c122de7@oss.qualcomm.com>
References: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
In-Reply-To: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
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
 bh=Ny7/Zl0/DVQbqPkZ96Ridz4UaSxsRZCEOGYlva8TgRQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233bMA9BzPVdeqoEGTgsKKhlJ0wLn+wdbePVp
 1aNJY9MHh6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt92wAKCRCLPIo+Aiko
 1SHpB/9DGqf99c9AycySqXMdvLfuK7hVVbU6usMJS0SzmqS8aK39KvanYnVyQED6qoGzjCchnec
 qHjrqra+WeSfVNLEiIlVvzdy/+yJnTLgGUdRbzIis8bA/OazqbcwTFW7hvbA3cuTyRkjz4iosHh
 iBbMSGc7GbKLLjYsA245H72wwUpXlIQvKh3zVo1HOcmd9Zw0zDukFlgjsxolo9kvYaO+Kgjgc0T
 5V+4t6ugzr/KbsCXaKgFnOx+u6KeCzu3FLyi1YXIjn7fcj/Lk8rv6p7wp9+dbh8xzW14dWdIXND
 nkyUaGEkubcsWA4z+LWTRw8eg9lF3FmW3DjOA0ZhA2nrwfqj
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: qzF2s2wpr2vcDLZfIDNEkSqulZygXbFf
X-Proofpoint-ORIG-GUID: qzF2s2wpr2vcDLZfIDNEkSqulZygXbFf
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb7df8 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=m8q_D-2G2n8EEWQKP4cA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX2eSjlP7Pe/p9
 wG+sKJARZog7IXUo/og9UETwtHXct0iEBP+bRjAv3adbo5OlvEyMeNsuBM+2hMIvVu+Uq5GdnCP
 zWkLobSg7cAQlzS4WawtM1Jxws5vlRk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX7MXQBPHvGTXp
 vMRhNEq/lJt9iIVjzv/B4tLmgrU+sWDyBMQNIRPaL/l2YgwipX0Wy2WfDgjmwCPcNz0NbWG0ORh
 dnCFEnfuMDyPLE4gPL1glbTq+XKfJdSFVEzFpWhkwfh1lAbxl9VqjsBNj/AvLLXZpCpKhjzkdzW
 sj68ENayF4tPll0aYI9rNoeYK3/kkTTAMsHUfcI6cPXCHXh+EUOgMDNLDwUSP8fjz5DnoxV3c0G
 lOXvpbkCdK+KLzejoh5owr+CTpJYHTgp1c0lDBl6e9MMgHbykZ9zj6HUDjF+VerYN7cdQu5Wz3r
 ktPAHckoScRvjJpOqwaGTXSKQYw6t79WHRHRszkV7m5atHEPPRZlv+inXJXon1KI0H6Qp2NIEvd
 YJw0Nb8RNVxXrHz2ZJY95K0m8HpAKRJs6Jl2etDunEKSsre8dhRJWWK7t1rRQzMdeyvzN31Hv8o
 PYBN0GdmK5/W8VEfLWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230060
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
index b6615427cebd..58a269cae31d 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -138,6 +138,9 @@ static void mdp4_destroy(struct msm_kms *kms)
 	if (mdp4_kms->rpm_enabled)
 		pm_runtime_disable(dev);
 
+	if (mdp4_kms->vdd)
+		regulator_disable(mdp4_kms->vdd);
+
 	mdp_kms_destroy(&mdp4_kms->base);
 }
 

-- 
2.47.3

