Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69B7CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D02E10F405;
	Wed, 30 Sep 2026 13:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gRaBZb7c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DLkChl7p";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 720D510F402
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:51 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDItwR616103
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=jCcy0+dmxhjISV1WNXx+vo
 E3LvhshC75PT+Ka3ytGgQ=; b=gRaBZb7cNO2Q8yMKeQOfdaLS2+UVK1A/5KLuyo
 uoN4mGRQoDo+3UhHjvdZmNHnkRzQGylX5Sf7eH5ktzxXXTRhJzznUf3pPjqOu1ZQ
 nlFf7MZIRR6gvyHKqCFUWuqXAHbOonJlX4qTvwDTHhVSsNR/hFJbyOsNsFpqxcnM
 M2w4hFwY4LFPjuV1vSm4210q93Ti1GPFOQjhIY32XfC///iY698eQTa7KeYDOGJG
 y7YQgonSqof4p+W25U0goJIzvnWUaKZBVn5wnWaTCxJXE13Q4sUv84VEV6RrnDUn
 x7jv+Ev9iqzzoZ1cpZIm+6QLl2wLBXV2yTYkS3LyCH5SSr5Q==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tg2cg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:36:50 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-988ce887bc2so938395241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790775410; x=1791380210;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jCcy0+dmxhjISV1WNXx+voE3LvhshC75PT+Ka3ytGgQ=;
 b=DLkChl7peR0GyM8fd7HyNZhAjSs1zQ0VhXgR9y0K4VcKxGjWPrZYmHVayo6RPl/x5K
 G4yd37+AQFHaNi+YiVG8pozRCn+y6dfh2ebh+UoU+mmgpnw3bgi4UwVGrQL5n1Yuq0Or
 xThlahlIxfqkqPzgF0Ls8D8nqnBXc4QYqJ16wsUpSayDoRTVp+bD7NHvYGNxdSBBpxjH
 aLtpTvATfElz5SarjTE3Vfi1tEUO4lJ2XX+IEdNQHikoVJIIEg213m7bEu8v0+p7GMs4
 PLxPWk+AHB230kjGGFNnBoJrI6oQCb1U8gj0nrTELNuhmKyulbhpwMTAvUd5qsdH0TlD
 v+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775410; x=1791380210;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jCcy0+dmxhjISV1WNXx+voE3LvhshC75PT+Ka3ytGgQ=;
 b=F2Td4hOuKM5ZkaLfSr8rOjgUgZr1VBp9JUOOo2xpO0/FTIHBKo37qYt5wdLCYsAemS
 62UqwVD16Ult8qf0vykBxlzKWZfOyMveLB2Omx0DcwbFk35V+XYKmxMdwo1CXe1yzqYp
 EvqgxnqN+QrT8jGxbAlSUw/CmX/FjTIWqWmf/J4umZ5m2KICLfPSoDfd7LFAxVIku7eq
 lsNZAzqu87RAFsoEjk4veHXD+DBL2m90VFqKIq5FbVwOcKRVZGav3pnAhD1b+EbqjTF7
 xBn4vkGVT5Kw8IKZvXPcPQaxPNZD5wXnD4drZBbwp9TjAI6DNqshsBBSCt8Tic04W1El
 sH4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaL3gOeDm2026P6vbncjrDJTmtblaT2vvd5Nsoo/fgs/piWWp/WEXXZcoCo8nh/ON+Axc7nzG/gYo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKMF78CBoXQxjnxTbtCynkbX+VWB4RioGasxdPElcOa3TI7LRv
 aLMm9URE/j1Jo5Ip9wOaX1NRxrk9RY/UN2URP0KPeUvooq668xchDX1uTeBw4xYQ0jRWi73jKxV
 oSHkn8VXKbr5FFqRW/Lp3S/ETFXIDr4v+cLiJ2IDq/XJ3K80e+MPdJx0gHL9LZP1Vlo6gLSo=
X-Gm-Gg: AYBFou2+KLPKMm72bmpHDYnY5ClplABW8FGQFGQ2qG1wIZAeF0LOrfVctUFlFM8lO/g
 wFcwOIiFJhKH+G3XDzFts4W0QzzcrE5KAB6ctBk/l8b42mvxakYPOUlB+QG1JXyY1co9rUdfB/Q
 8ggrLvT/TaX7uN/+spHkW5lg2KFMoE8XNBxgcr2rYfA5vO2h5D5G4zT00cqWuKanhtgMb3Cw2MM
 n2yREZrRk0VdxWOuYFYOafQwP8HrEtPCZHB9ytRWkqP3d+632C1yin6ibfXqawpHQaChds9KGO4
 pUKrD+nrEGzTjzf8+KHIRP1eWwL0Y3QU6HWQ9JmTi29gXdQkx3bldNF5PyELocYu4Xp3uYJCHmt
 WEwp+KEkHNglLXjYQ0H9UnaBRCvdYU1dx5SH7xBGi4g3XlaJhfSigZLlbFpu3O7BJbC0NbK23GZ
 Xh+QL4wcUipk6o
X-Received: by 2002:a05:6102:3faa:b0:7a1:f7e2:aade with SMTP id
 ada2fe7eead31-7be7359628amr353694137.16.1790775409828; 
 Wed, 30 Sep 2026 06:36:49 -0700 (PDT)
X-Received: by 2002:a05:6102:3faa:b0:7a1:f7e2:aade with SMTP id
 ada2fe7eead31-7be7359628amr353675137.16.1790775409340; 
 Wed, 30 Sep 2026 06:36:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ba3fbfb582sm356731e87.57.2026.09.30.06.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:36:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/3] drm/msm/adreno: implement progress handlers for
 a2xx, a3xx and a5xx
Date: Wed, 30 Sep 2026 16:36:45 +0300
Message-Id: <20260930-adreno-progress-v2-0-3882f0fcd7b4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG0QvWoC/3WNyw6CMBREf4V0bUmphoIr/8Ow6OMCNULxXmg0h
 H+34NrNJCeZObMyAvRA7JqtDCF68mFMIE8Zs70eO+DeJWZSyFLUUnHtEMbAJwwdAhGvVFtLJ6r
 irEqWVhNC69+H8d78mBbzADvvmr3Re5oDfo7LWOy9//ZYcMFbYYxxpb5oq26BKH8t+mnDMOQpW
 LNt2xfkBoICxwAAAA==
X-Change-ID: 20260927-adreno-progress-87f92d081376
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3dR/KfgUpEPFYcvKE82HaOvSnzW5RQTXUlnPfU4rkJI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqvRBvLdp95flAy/wXj980CxWYHYmmHg8wg0DnC
 1qCILkwLlKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCar0QbwAKCRCLPIo+Aiko
 1WjdB/9a9/EIt2tdonXcYgC5QsegQiRulxNTgr6GIb3sA+XqbPGE8Elag50kvkfFaY4y+C62pw0
 9jTOpV/RsnNMQgyW772EoOjsfgH06w3b7JNWNDkqvTqmM89+WaZAnQ+327HT+vZofHCz6WCKTj5
 XiFk5cDdo+oRshKKpOfcfYnb9ClUiQJEjG2PELGmkJ21sk+1ZanHaPK9NAXXlgc8oix7xe8cize
 D2CMK8Q7ISdJQJXojkUEJSnsTa/61WFKD9YA0U7vhhF6UDxqtHpq2OfVzJSoES4mpygsjCFvA3g
 U/9VKw/94Git12w8EQ7zt1lp7ausouZPBkjDgH0IwKz0WWiz
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1NCBTYWx0ZWRfX9/XJXivENVJC
 byuSCxagvO/9E6VNBBbHQao1O9tmT7t5ZOu0DDXzCHJiI1WU2jtdlqSI/BDCraSfjJdGH/9QbCf
 NYvg9jKCXugs0ijdfcG94TMDdV4JZJ8=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd1072 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=Kk7049moo6jdYbzpDncA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: m-E8ceXxpTd-D-6l9Rz21EVR-6wubnpr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1NCBTYWx0ZWRfX22t/mmiD76f7
 crM9KD4mKAzMTjpE/ktUMC8NmU99yiRWB39feFnbpeWHgcouIzjKxvf/husyT2ORDo4zXeZ/oj2
 YBVCC0mTWQ0yEWCpIOKgOv9T2sxjf9NQyQiG17SO9x7DTwa6JKwp9Jb1EUZXIecrx4RFGHeGPxd
 2RzZwcEbPI29g5F522dhx7CBbQgiKKiQr781ZTPEXfVuHyZDT1H0lpE13CHB95nW8Z0K/Kkwp7W
 3+mL0nQroNSx58jBoO7pCd1/w/TBtE03MenbiYAI2cy0189+Z5eQOaUM9Xu2vfJK4xEr95NFESs
 AQIbwhdZtqfG+HWqR+N1FBvSu6NG2s2o5v1939YZHTpEQq/iRdHVAgf1q3EkL10cTokdAXHrkx+
 t98lq1hrbK53XB9IQw8pC30nzbKf5mzuucyv8oNsL85lFc2swNxqCbK5peFrQHtKzpIoY3USDq6
 WTFxmSYmFKfIg2NNQ+A==
X-Proofpoint-GUID: m-E8ceXxpTd-D-6l9Rz21EVR-6wubnpr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300054
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

Adreno A2xx, A3xx and A5xx don't have progress callbacks, so any submit
still running when the hangcheck timer expires is declared hung, and long
compute or drawing dispatches are reset while still making progress.

Implement a2xx_progress(), a3xx_progress() and a5xx_progress() callbacks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Added a matching progress callback for a2xx (new patch 1).
- Link to v1: https://patch.msgid.link/20260927-adreno-progress-v1-0-f0bbbd6a4ac7@oss.qualcomm.com

---
Dmitry Baryshkov (3):
      drm/msm/a2xx: Add hangcheck progress detection
      drm/msm/a3xx: Add hangcheck progress detection
      drm/msm/a5xx: Add hangcheck progress detection

 drivers/gpu/drm/msm/adreno/a2xx_gpu.c | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h |  2 ++
 4 files changed, 65 insertions(+)
---
base-commit: a15fac810c76397ec9f62a6fc26c4d7ab6e238a7
change-id: 20260927-adreno-progress-87f92d081376

Best regards,
--  
With best wishes
Dmitry

