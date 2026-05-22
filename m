Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F706CD5BAF
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 02:29:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9572A10E229;
	Fri, 22 May 2026 02:29:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XaYOcVoK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sg8lISk3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 804E210E229
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:29:01 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGkFW51658210
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=L72rJ7gbfqTsuIIcEDgkzY
 59CvyMaa6z48PV5hmMSQQ=; b=XaYOcVoKcpMP9T/cQjvAQE3J4KKluQR3RKYJPJ
 4Pn5J68AG2ubNW+zIrO1N1VUoMQq9bpjpKvQUfa8zvUTsWTGAwOS3D4TeFj2iQhS
 8XIVLT0kuMrGGxFrlGQJQ4wz03JW5r8KNcdjJz1TO3aogD1a0PuIyqbczl3Qtjbf
 LHQ8a+NXNOhRHqKVq25bI7rg6jg0DfZR7JNb+PBJ2pn9ssOjsPm9BuO8iUYQDh31
 dR9YISkL3JtoaTs+R9u3+3D5J6mXGpEhDv4+u2MuZZrSnt1+7Wz1wiTfmw8njAxv
 Ulm5MkSVIcYLh/VYmXPa+fNdwGLc4GC368bV4DMvGJ3B1Ohg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea0dkkhay-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 02:29:00 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-63230863010so10558518137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779416940; x=1780021740;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L72rJ7gbfqTsuIIcEDgkzY59CvyMaa6z48PV5hmMSQQ=;
 b=Sg8lISk3CfbbDv0YW18s8K5GvY5N1qe3Wn/TB+DcHegb892RtJi1KDgT0xQqdSgBGO
 tArC/u478wqu2vLYaOtjERyhkJdt8CHY7j+MX0p1Nw9+11lA63258DjwhPYt+hVFKRXI
 R9s7aEMb1kHga/LPHk8AhTSwqdXwk6zaibEHktGsxKIGYtMoPkB+HFqhtMAB4gVEBb/h
 vJ4kG1oLcaUUMYebDAApAohZoi5cBVu2kNHRzazRxV7QSWMmPNV3asQOsLvnvFtakd0a
 2DXUr8YIYF5leuB4/+YAnvkSbww50wwI5j/huh/l+In7ciWKE9QaM4DqYXuxJcb8Q1kI
 XxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779416940; x=1780021740;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L72rJ7gbfqTsuIIcEDgkzY59CvyMaa6z48PV5hmMSQQ=;
 b=GHbfzikl6/97Wl4/bpmEIsTgOZvbMweamDXeNOJoK+yG+1VHZtYdfoLq3UpTE1f25m
 S9qDKgx9NsFI/XD045mce4RTYeB16ghKznsKrKD1qRJDeHWYH6dHXydrnfzJKDajD/xW
 ubLvytFWKYahw9fxoKFYlhVO1shKHd2UjoD6BsP9pedLMG8YwsZwcUc5UuDskW0XUqrZ
 M2ToSDtXKEyk3SLtvbFbq/YwtGloKhfrVexK/YnXeIp49qpjyQpKKaNlOHaACcK3fJYG
 5ItUl9MJsT3Pg8BasshuKxNk9N5suNM1TvPomEeGk61UktTdV2BvNNfXfBq+wor/UZoz
 3VXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UNN69Z05iZo8tmF3QKBmXwDzkXSCnWdHC/yN2Jfnmr6C/NzBlX2y2s5PqqwlgSKCUUCDVlf/NLts=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCa3/bbpSejZK9XxEHmkktS82/fb1JacxHItzXuJnKg21B8rcg
 bgk1kzcvO0kY9bxFYaDG3jYfTYL0/Hj2w5G8rH9OfLzAbng1VwJH3PKCwoO+C4+H7UOEQT0gaj2
 zkMrI+41zedsUOruOqGN0vFBdzUBmzRSyPThPL5zFUrCMLG0sdAY5tvZa5dBV+3/5pm+RpHg=
X-Gm-Gg: Acq92OFHseeCvG+I4AvNa2qMBE854rBw9PLl/qWqoARBPimWhEricaXd4Lk/72vI4H8
 8mZQxh9au/lP0mQT5CvTdsTJGBsNehiMzDbRGomkQBZRY0zPUFWT+0d5t8X2w39+ojYd3bJbdW9
 gv9rmrPFDsGdDksgwpzQC/q6DN1sxrHcxIO6b+vyQowpZwMyX2SMePBSuAgueGZUVhAMnpCn6yd
 pq9QwI3HBuzRCzyxqEHH+UjOkW5Yjc5UHPogVzudgdQ9ggVlOMbciCDMXolT8mZwEjzGXeBY2Nc
 fkKivMyoqBjgZmuid7wr0hU7ckZz1CKbki5aqzx749NM2fu7NsiKvPzzyb92tPh9rczcxy9v1NW
 fGVhVKzwV6WbYhIquCvnk+s/Bb6ejjecZsM7yIYPoEQeumelJPMRGP0s7PJGydjnQIdQ8mQf/6X
 WzXIoLldzQjX99TBtc0taBfVdvTKzig04d8jE=
X-Received: by 2002:a05:6102:3e88:b0:631:ec2d:12bd with SMTP id
 ada2fe7eead31-67c798ee724mr848285137.5.1779416939788; 
 Thu, 21 May 2026 19:28:59 -0700 (PDT)
X-Received: by 2002:a05:6102:3e88:b0:631:ec2d:12bd with SMTP id
 ada2fe7eead31-67c798ee724mr848273137.5.1779416939397; 
 Thu, 21 May 2026 19:28:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cf939fsm65739e87.76.2026.05.21.19.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 19:28:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 22 May 2026 05:28:55 +0300
Subject: [PATCH] drm/ci: disable mr-label-maker-test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-drm-ci-mr-label-v1-1-39f778123b30@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGa/D2oC/yXMQQqDMBBA0avIrB2wIybYqxQXMZm2I2ploiKId
 zfa5Vv8v0NkFY7wzHZQXiXKb0x45Bn4rxs/jBKSgQoyRUWEQQf0goNi71ru0ZK1xgRbcl1Bqib
 lt2z38dX8HZe2Yz9fGziOE7e16CFzAAAA
X-Change-ID: 20260522-drm-ci-mr-label-727766d73e95
To: Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=952;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PF/JApBw3jU+G0w1YPNjhHQ0K+Kfl7EII6+7jylmzHo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqD79nphHZ1DEfGwHja0hR8+HnYab3Tu2gksfIS
 h0gt+twevCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag+/ZwAKCRCLPIo+Aiko
 1fyZB/sFkRLW0u7tdo21qpSYKut09e3SLBIxH6d9IooE90MC02NVZXolZTC7WKj/vTDnuSySZtM
 hYXMur8QZ5WadRJeQEfvtIH804eYau228rz5K3enPb+k5LzEEIFlAiy6Uc4kjUc1qK01GlsgAGG
 S7PQWvzlp+s/+EM1Feb6VHuMYJTzXHZ0bt6D0mTzZpEOO5ulmpnWEWwPxYIS761xDwLWashMz8I
 2V9cLma4HkhYsqO5BbXT/Ay5Gg3Q5XOGmWOEN65v6o8t50gROc4oQyaco7aEYhx/UoJXusTq7eP
 NoOhgyKcyAL3fgLkIpwmfz5LNCMjy95E1ABv3UFdmtutRDD4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDAyMiBTYWx0ZWRfX90nSmej1CQ9E
 9XXJwBA8ATZm310Ls5DP7iHYDw2wFhRk8Y4K9hpQ+C54/6QK+iFQ1xcbw4SvFAD4LWpGNh6Wpue
 TgmwRjtVVn+upJdBDPWGXYDxzn2ruYNMre2njBw6S1AXS6638VSOevt/RfQPBEoaLr+DlkjpTW5
 IuL8vW0OKBxXSUVLQcDZJBGADz/nODFxV8YlOH+P07IOq+Aj/yR4tNq9yh0zM6peHLK1q6q6FP1
 KAnnfzuFIzH6aiDfpoh4vmzwvcilgJioydW5n2sC4FpH8K8IZtshZwX+KWZyA63/VMHPI3ByB2B
 wx8SboneKq6btOE9BKpvwXMVomCRJMbg8KGlY6cxxeWSSGnoOAetfmkUU56Jw1MEgY8mlNP3Azq
 2lZGgpq501hhdf86C14W1no/ptbEeOLuofiEPPnIZYDI7MTOTeL6Hkakp1NIw5dC7Yga5j8JtlN
 KVCUrJBlU+v9gJ0mbjg==
X-Authority-Analysis: v=2.4 cv=aueCzyZV c=1 sm=1 tr=0 ts=6a0fbf6c cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=_dksh78a8adESa04-_QA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: EbhW-fCY4P3o-hvDuOxcyG_rBmdHOjyt
X-Proofpoint-ORIG-GUID: EbhW-fCY4P3o-hvDuOxcyG_rBmdHOjyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220022
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

The MR labelling is not used for DRM CI, however the job got enabled as
a part of the CI pipeline and now prevents it from being executed.
Disable the mr-label-maker-test job implicitly.

Link: https://gitlab.freedesktop.org/drm/msm/-/pipelines/1672049
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/ci/gitlab-ci.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 56088c5393cd..c1087731d1a2 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -386,6 +386,10 @@ linkcheck-docs:
    rules:
     - when: never
 
+mr-label-maker-test:
+   rules:
+    - when: never
+
 test-docs:
    rules:
     - when: never

---
base-commit: 687da68900cd1a46549f7d9430c7d40346cb86a0
change-id: 20260522-drm-ci-mr-label-727766d73e95

Best regards,
--  
With best wishes
Dmitry

