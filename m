Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B13CD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3327F10EA56;
	Sun,  7 Jun 2026 14:02:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJWJxoAH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NnoUs6pg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01C9410EA51
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 14:02:05 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657B22Ns378005
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 14:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=j3HLvpgf/bq
 VTB+xJ2J7kEnCnU4hICG3RGlKEepjgjI=; b=KJWJxoAHca53dDOvFXI310X+033
 oG2lTbc7kt/UZAMw6a+NaCADZ/xx60N0yCtNlZxrjgdLcGBKjGoKfwv3Iw2esjr2
 MzfbRDL30HzgE9+J/XgHO6fwpks5X+VRfCkHCAXadSZ+gKCZL29RnBa9ZcE1rN6B
 036QEUNbv1DI+TG7emRGBajPF0wB7hvQVAPcP3+s1slwkkxKecDXQhwwVlC35e11
 WxCwm7ODMgRBHsOsApyLY1eE5TtsFkbofeQu4qMKILKcV7MGzG4r+EJSfuyJ8guV
 Ojmn7xV9n9FrefTGTC31QmczRDh+keB7ky3C4m+Qb5Cnc6pf7/z7kAMxnwQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embx6bwah-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:02:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36bba9b849dso3451484a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780840924; x=1781445724;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3HLvpgf/bqVTB+xJ2J7kEnCnU4hICG3RGlKEepjgjI=;
 b=NnoUs6pg/71CWEYcE9HoanG4Msi3cs8L0a2UsFloSzbEtVtRaw4WDMcfFbjZ6YgjRy
 6oM4+Do6UShLaT1tFd6ItNGyzPjOedQDV34+yd5SzNQh9p0tmeOGax1aaGxgvu9Ta6G5
 OzTn57lJN3Cyasfa0Sf2O/xqS4/I+CO6QmT4VH3EWOiuMTXS27hQszCxsGGWIMMKEJxG
 jwMMVtet8acw3mJOnOE9OvXb6r/4zMRxSDC1tP+z/e0RTPn20lpP/bP5LvDJI9r8MQDv
 5nr4ETxJGXkHg6gaquKn6NOjTCQdFg+GszodlM1RFxFiRozVNSv4BX9a0xznUVKVutz3
 PYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780840924; x=1781445724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j3HLvpgf/bqVTB+xJ2J7kEnCnU4hICG3RGlKEepjgjI=;
 b=HMABS9LpgMeXr78hZdoYtVjaXsHrbZM3b9JyLhY0yDbqZDnvBqxCHRsGla581XUP0R
 fB3cE/fyN1mQpCfILrQV35sn684hUZRn+8z6PZgGCXWFvabbtP0Ij4ddNasbw9oatZfN
 QoKfNFxoz3N8SzcxAQgfoJFYi/yJfmsLFNXU3R0SkshfYnPJuiXn0lW7EUWAItaYcDoR
 lmBbIF0eFUjfThKNuJs24QFXLQpiNyn/sJASHrinr7DKdgWSo7xmxcM2PHW3w6U0ztwT
 Wqj2LvCLJ7KWwfNZabrtBimXfIBDdjt50OIARWCggho5EX/naGlz4XHKYfiklRuP0JZw
 u4RQ==
X-Gm-Message-State: AOJu0YwoM6Pe/qKLF/NkGSp8DmNYDf82qjlQMl4Hk4eln45AXUiOpMFJ
 mNHj9mlW1QgfFdQw5l1XaNYghAJVTjapfBiyhGTfrvQKkTl8bHsh8AxvQGN9S0I8o8vWu3uIajO
 Kik8ZTu3raIEAowkUsNwnyBFRGxw9oqKpIhqTxINaXluCMF8+1Kro7cIoDsIIwGAwun+j9t/s0A
 1Ndak=
X-Gm-Gg: Acq92OGIk+yhSUSVe8bm6WtYIRSwywtwvAngT5LQEUVjNsYWmRrp5cH8RMoQVmK5Z3r
 hlJ7gc2JrdfqkVrtbIAwoyxp9cORahyiXRiLEYNX1KPrzMY/OLpNRWgwuLnjIapi7QkUILoFOtd
 6tIm4gtIm0sp4B1rUpjsnkns5j239IpURZSNqN5d729T95qGS4VcyiL71QLJKuHHDUY2Al6jbq3
 WIvvnqnd1VNEV+xMLTnle9Y8dR68Ct+nUtgo2yHw6cjN+tSPT/s3Etbu45boOyCXjzTl/6caWbA
 OTfDFwT/IEnDr8Cflf39zH/fitQzMcy5zfhPGmER6Aqhb89ID+v/PCz7BCK/Tap9ScwvcZcMr2x
 D821YXP3IQT9o5tcdwnfkT3goOs4RWTg2/D4xWvJgRZQ=
X-Received: by 2002:a17:90b:4b0f:b0:366:decb:d119 with SMTP id
 98e67ed59e1d1-370ef0f5942mr12763334a91.11.1780840923564; 
 Sun, 07 Jun 2026 07:02:03 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0f:b0:366:decb:d119 with SMTP id
 98e67ed59e1d1-370ef0f5942mr12763277a91.11.1780840923085; 
 Sun, 07 Jun 2026 07:02:03 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6c668e98sm13168827a91.5.2026.06.07.07.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 07:02:02 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm: Validate lazy VM is created in GEM_SUBMIT
Date: Sun,  7 Jun 2026 07:01:57 -0700
Message-ID: <20260607140159.137068-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607140159.137068-1-robin.clark@oss.qualcomm.com>
References: <20260607140159.137068-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a2579dc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=eWlSUfSnBrBg5eVjM6UA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEzOSBTYWx0ZWRfXx83BYqOIEevv
 2d8TMx9C75Z4onwt0D++zHDTHWS0yBdk9NjPdBPCDzKUBYet4FB7/anNGy1271erhhYRX5+/3LC
 9y2TdqhkewDB4ZOG+UmEcu408iO/SA4+53ErLwBOaT88kd2M1AFMs9hpWmWzfya/3jO3Y96DhuH
 mYuXd/OoiRCJZ4KPqP9uOekvDbPdqskpXFUxH5wTNnGseATgeNpdTx9NB10GSjUcrsSX8NQjDQu
 Y373EmJepDKmBkvDe/m6w/jTD1Fhi9InBIP9427meBs63o5he8uA+O46EUCjenNTDfU4TIAZYTe
 TGqqrl1znYpej6ByNos2w8sWQvq4JNjBmodykdwZl66YYN23JU+HCrhVUIW8vCrpJ8V412wd+i1
 I/mYSixns6NTt+swj3dnynIaGFcBZCsbXnqsjLwF7Wr4hQLmbihghWWZP8XOx0icK0nFz3/JVFx
 7bGU8GGH836oHOIZWLQ==
X-Proofpoint-GUID: wfluX_3Kdgtpdij3UMm0KQDgpjOXsp1A
X-Proofpoint-ORIG-GUID: wfluX_3Kdgtpdij3UMm0KQDgpjOXsp1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070139
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

Otherwise a GEM_SUBMIT ioctl before any BOs are mapped could cause a
NPE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 6a4d287a1ae6 ("drm/msm: Mark VM as unusable on GPU hangs")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 26ea8a28be47..af564acf1f0d 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -572,7 +572,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (args->pad)
 		return -EINVAL;
 
-	if (to_msm_vm(ctx->vm)->unusable)
+	if (ctx->vm && to_msm_vm(ctx->vm)->unusable)
 		return UERR(EPIPE, dev, "context is unusable");
 
 	/* for now, we just have 3d pipe.. eventually this would need to
-- 
2.54.0

