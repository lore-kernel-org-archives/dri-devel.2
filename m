Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09263CD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1FEF10F0CA;
	Wed, 20 May 2026 14:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q0xmi/Nb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F3D+o9vn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0680D10F0B7
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:44 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDXgDE1798325
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oiUTlYZdmXRE6wHZobRlLY7t2S1s4URFF4b8EHPtYQc=; b=Q0xmi/NbitxmcvIr
 sw28MKVhUys3bEosnqDqsthvWfKzFVBJjHXz2CZbkGHjPewjfw/spQ40hv+ovtio
 wN8an6OWenbw716nkkjpoTLKOLqI1XxdCgGOUKCtFRsZQsPiBeTab5PDF2+Uvp6l
 0jXIYQE+6NGD7ACiiqC0kX0QRaCADJZMvdya4I0mnBP5ss2QQ+UGKQib+WftNSU5
 mLJS7sgy4ZQb0BE8R7S9t43b/xNoawgMCH/po/di5/n6DBPuUW2sxPTeya++OGRQ
 9c5VFClwrT3KMJvRi1838bBxxuVAwOjtXR80P8F7WjHJLn9y9MHb/WBtWDJpOtZJ
 6iOCCQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu0a12-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:43 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6322654bb6eso8493932137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288702; x=1779893502;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oiUTlYZdmXRE6wHZobRlLY7t2S1s4URFF4b8EHPtYQc=;
 b=F3D+o9vnv0aGGJLuTzXYWr2JoOj7dMknmDPdlUGXk4t8VPO1ahBqv/3rpu0RWS+5Qe
 C858I/1uwFlug68YHXvX0zG0880MeWsX7rQX4+1FZhaInYeg9dwti47Rxi8M6t1SvrPm
 bytATS8yo1i850PXIDH3XpZTCagZ+idcKcYXeRG8Mx4QBhAJjAIQuZzzQEAXdlxVkxTo
 nYOxdZNci8nLsfJBrWMTW0M42n8+UOAliZTbp3XVWQ3yGLNw4W2+yZy029O4fVITWITb
 AH2KZTZpWP6jRP5UHndsPlGUV8SulObTLXt5cCdqNE+NJaHCWdeBC8+wuxEIjqUc0s3l
 LLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288702; x=1779893502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oiUTlYZdmXRE6wHZobRlLY7t2S1s4URFF4b8EHPtYQc=;
 b=KQ4OGMkYPP9nJtnPJJHSKyeMPyJiInFwL5KoMjSkiZPJEg4qSvDNbrya8Gpw7vT0cb
 UIFpMC7BoHykpe456iFpZzxHgdGhGIf3HuJ7R+RGvTJDsFdywsN6BFSOEu4INDraVv0b
 AIhBp6bvRRCXn4rzsSR9igtwU1RFUO+L3CGweG1M9mURBkElpiM15BT9q1So99YLRoi3
 9Lg7CFI/md2V0oSluMYHhS/PX9/k0KIwnG4Eir0BX5TyD0UkUtQDjTPSOo9yPKwyoBIp
 Lo7AxC2qsdyCo3sVRV4V+NSrEJ3wTb1QPN+nxMhTpxaVqWswY/24hR+Rl4Yqt12TIf/P
 ZKeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/f+1Gk+GaewxSURPHYgo3Fwfnab5QFLVwBE4s4v7/duVIblQ7slZPukb7/MP9j3OV6CuRaMc6zRHE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyryNU1OhLjsedfQQjMDirPxe6DE3MIZmpBiBuw/iP+hn1xfqF4
 5bVFwgCwczIEmXtiJ4hAOa8nIPUOwg8w1wd39MNGuyC1cpB92D+6tgZ/pqjub+6bXfveRuwcK7d
 4M/vlzKYoVLa6T3YbfSjqvruSN5osKxwKwIvNojGDt7H8d2j0qK/J4ziSJ2hTVxIZ6t4KuhM=
X-Gm-Gg: Acq92OE7Qh5LrgSdpvi8UqcBlt7miIVwnXGiZk1tl1ZEOig25pPXwYzskzVfddJqv/i
 7bfmhE/ZYmhIvhaWbWx/CuMWR+JdAfrfh5Kh3pnrCf+E1Jx6+lIaW1sRZWFvJStdvSNrT5HpHh/
 smWZ9iV7l/JAm8967nHgT146cFwyWLyY4pYvNYINSSpht8vcvN8e88q8Rx/eSwZYQcCWiRGz9Ey
 Dj+GU9v6NDtz1Gt8y6Zn8H9Sc9CnH3z1lO87o4z938+3p6t2jMJ5g14yXrzpM5h/ngizyQeIHLN
 GeL/TyWExDM052p7sas4EtsgIA9yeei+fmebQsLNWIqQHmyllszYE4H3dfmWn8yyOLVuhKpDZGW
 1uabDHtsGvRl6/dUoJq6HBCNV2bJHkR55uLy9e+xuDcTbcTiK2do2y9yB7C+Y4T0oVcGUe4egXC
 WTgDQ8sWbhJ8ao3hD5zkVcbHkleDVVTSRbYQM=
X-Received: by 2002:a05:6102:358e:b0:605:5d09:8631 with SMTP id
 ada2fe7eead31-63a3fc98de6mr13087512137.29.1779288702262; 
 Wed, 20 May 2026 07:51:42 -0700 (PDT)
X-Received: by 2002:a05:6102:358e:b0:605:5d09:8631 with SMTP id
 ada2fe7eead31-63a3fc98de6mr13087481137.29.1779288701632; 
 Wed, 20 May 2026 07:51:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:18 +0300
Subject: [PATCH v5 11/28] drm/msm/mdss: use new helper to set UBWC bank
 spreading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-11-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=853;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=05LhYAKGVaBgZaN0qt9lOXQChuEy0ARdc0e/ucvP2Qw=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQxbvqfSTCpfebak57jC9nSVwT4AL/ymz8IhVb7WtIvnLE
 6skXz7sZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEbrRzMMzoFH/Afbu1VdBg
 1prG6pJJMh+MT/belZig94LB0v4Bp9bX42xvOb7c1bRNif5zTTaK4VzLtMufdv+ctCXmxWTzI78
 Cv83W+jvF0VXd3kdR6dCWV/GBQlvk1BTvrJRhnRLMKPJ/zQ3Z+hbGF4bv9S9fepqrI7Er7QF77v
 zbRfZ562cdm/rOqNcx2fBu/uzrWgp+/9zMeyrfKC9kNn91klVldd4c3o/OngWaZusf3Wm5WHRje
 Y+nxTWP476Z6jZZyhr613UOVafVyx85y/J2XXhJkw7fQtm8hSZhf09sN3zfvdfhREr9zwXlTQxr
 jymocqwvcbXtLcopuL2IVUW1p7SX88hWzuhZcX9zrXX1AQ==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX+9QA4bkZ1E0t
 bd9lbPmHCRyS/2rEuxQn4uXNoZu45HuUh73YIsW0aKLIViALhkA/0ArO3FIor6gE/EVf0I63Ogn
 MVWCQ1lpDyCLqBs6er2wLIdQrCKS4wrry0snskjw6BfjzdGZWdSNomqZNPUyd5sUrE0jx+Ed0GS
 PF70MMPeVKJefckc5oPty4OMHhfW5j8OnfQkgc9n1yYarH2CgFbQ8iBBFUNIpWf+hM9UAN6EF4c
 TinMRSUzq1pMJLD8Rez98o5DcHAJD5u2om536i1zl6IIt7noixKCIkmIybo5narLS4kVMNMV7wU
 JjDeaiNYgZmS6ilno/i6zDtHhbOXtRJGdn1QtMuL2khx+MGDZhh0EeVYbx6tjGIwRkBqIrc0x0y
 e1pLiFXPffPXZXfZlavZpMvRxVQZZHPZNXJhr0Jp4XjSXjD3bBe7nlYPbr3AtRfWAw1o6ntPf6H
 qddhkN6ycW5NMKYyE6Q==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0dca7f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=vkIeKiNhsAXvYQN2DwYA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: vvopZaRBC_DTu-T_mFoyi2HEgMaQIlCe
X-Proofpoint-ORIG-GUID: vvopZaRBC_DTu-T_mFoyi2HEgMaQIlCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200145
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

Use freshly defined helper instead of hardcoding the checks in the
driver.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 2742d4bb2a4d..bf106d849dea 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -201,7 +201,7 @@ static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 	u32 prediction_mode;
 
-	if (data->ubwc_bank_spread)
+	if (qcom_ubwc_bank_spread(data))
 		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
 
 	if (qcom_ubwc_macrotile_mode(data))

-- 
2.47.3

