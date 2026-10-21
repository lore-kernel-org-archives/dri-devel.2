Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF32606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UvNujxgL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JBKfOsil
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A183D11221D;
	Wed, 21 Oct 2026 20:53:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A7811221D
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:53:25 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeANC1359825
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QK2V0ULW7LP
 9ugrR40QAJ25MXENJhXs4M1ySCOtIhX0=; b=UvNujxgLvFS7OZHEHS/tp8x8vkl
 UislSsxNnOGPq2zcODAMF7YPKDdeZVMJvA0fXFaRm1ewx4gASulnNLwrS0fdTq+G
 FNsJXsFV6JGiJq0afZJA7QJVjV4/DpMXAPYn4i6PLX50RTHLl/07c/t9JnfsBwE9
 fRNAaJTM9P4msrElJate3F7gIy88xLLiy5v+qmFG6xLmG3U0QOGjUR6kmZbZWaYc
 Y6zgu95lycOK7toV3WzN3XXDyTy0oM4VRfT/ZS71gP+JMFoJs+gPi/XJImT3hLFf
 qgpmeK2QW6DoVdpQmW4vhXo+ppC+PbToaFkPH8QWrSH6ozX0NbIZFeM2tYA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vsu08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:53:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e95f8543c9so9052445ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792616003; x=1793220803;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QK2V0ULW7LP9ugrR40QAJ25MXENJhXs4M1ySCOtIhX0=;
 b=JBKfOsilw9ewM2k/aAvJEkOs2e+LXnQCzz+jcnLpZQTcyoa5yXHyizBSESqkYf+X4j
 fyaUOrCxfM9gieuY69zaBKhGMzQKAZkkUIHPbP9l6hAWpGOeWde7c74UBRjBVjbz87D+
 RMOrTydSjKW1IZpn6LhpIJkScrbnsMzCtbWT2FwCmDhMGxefxTZqA+4a2PCpiLMapaj6
 fGxTVSBKBrbbIKCnc2uKOpglO5Czv/5sBK6hQRvTDRi+/3VChGUTIhzW0auLO4SuKzqK
 Zw5fjnFnocrqzOSdPBECtlhWMEyM8W4NhuoGU+ljamRWhlNNbULPZu2KZy4vTXolMhkm
 8NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792616003; x=1793220803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QK2V0ULW7LP9ugrR40QAJ25MXENJhXs4M1ySCOtIhX0=;
 b=w21ExbkwQmrpKMb3gZ3I8j/eMmL6NsyKGRQZs3uRRCtwCspAAFIm1ARxn46ApZ1mTd
 K81pBIR81PBR9YUdXxnaNZmKhFhXzfif5NiBMAhY8XWjVrfkI4rj353dtKrM9NEEHnWK
 /tYYfyH4cokGt34O561pOZH2NHLVVd86uAVtUUmL+nd2ZUwT7XA8WeXkXMrqeHtUtHSI
 l5rMsY897ANN6XoKmFYE7Bzuy0YgLZN1KiCp7dx5tJBRm7oQz6k5E16T6fBlMXwzSdST
 XVPwD9Dx+ikMf5uL/4HXz7Dbv3yJe3HOOQeug9Gtu79iXjB5LcV0gQpj2tr+sVK2yYRi
 y8zA==
X-Gm-Message-State: AFq9FYIdDdJkwi7pGHzUjT8Nac3ft4w0xoeWij1NpIKhp9fc/acD+Gr3
 PVAk8e2hpLBLQDA1x4oaNa9mGSY2r4Vn28hy1RLqOG+TWKEc3cGf6kKi7E93TckabwfEsLqTXKE
 oHJ649OKSjfWUkp4ESSFfoyPcvegVLGeuMUrhJdUXpywPi9yQMulCD2VhPNiCn42asHnIQVD1HH
 Wgmc0=
X-Gm-Gg: AYBFou1KHqTMRdbsD0D6yalh57y6ryd86Amq93bbFimIYZFbitQRE9mJ6SitMGf4ACN
 Tx2hajBmdsQQotPQXZ40dXeIzE/76qcPf4o+fYaTd7j4SvgmHmHlQfpt6QUzDczAdgIm9Av/8l3
 hG8RxQhZY72JhRbubyHdNmCpahoB0N96PFKuDKBMYhpg7VBrSJZkKR0aN3gQa0qf64V3KZoO2sb
 f8QtaKZxbBX0HNgVVXA/CGKTq0SwKyr6TZn+gNSJJgR5I3hS5+QupdCsEnxQZyzLwTj3Lg8r5Ji
 kOfwPL0TOb2kfbsFd2NipkiA0kCw09h1dDLHljpAqYe5oAV8Q6ykQ6mPmibuJ75hucFb4oRxnvJ
 HxyoM6snKu7gx/0nJblFGnI5qISqFyl83CaMXDetMi+ZfmW7leA==
X-Received: by 2002:a17:902:c948:b0:2e9:6b5b:3db6 with SMTP id
 d9443c01a7336-2ea43c0c306mr22232375ad.30.1792616003390; 
 Wed, 21 Oct 2026 13:53:23 -0700 (PDT)
X-Received: by 2002:a17:902:c948:b0:2e9:6b5b:3db6 with SMTP id
 d9443c01a7336-2ea43c0c306mr22232105ad.30.1792616002917; 
 Wed, 21 Oct 2026 13:53:22 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea3b48866bsm15910495ad.65.2026.10.21.13.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:53:21 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 14/14] drm/msm/adreno: Remove temporary __maybe_unused
Date: Wed, 21 Oct 2026 13:41:39 -0700
Message-ID: <20261021204244.67160-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BQJHswF3ZABOYIO6cOOE4WQrNBiUoBK4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX2g8zSZ88InGx
 YYxO/KbbAhtM6lyyHkRtJLLQRQX1XKRVwfX6C4eyk72uQyQWhuecaQqpgGoOMF5KrqULqoKzr+e
 +IMYWZaBt08w9Linc444C6HaUSnaP8w=
X-Proofpoint-GUID: BQJHswF3ZABOYIO6cOOE4WQrNBiUoBK4
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad92644 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX+KMzHmfTdYVE
 rFHvT6nzUvjTx05xdb4xJZoBLxwvBXlh5iGBUBX3Xzd83UKf3LjAnAZl7QsyQMvifCXui+0PByc
 qikEBaokubA/VOPL4VzrnxqgvLG/+jiKZzkJB8F42snGaY1pEDz0QHIy7NUsGjqPXggPurdegbd
 gJVni8pRHLhcOJSx5OKiojSCiXImxyTkfXgUCHeWcIUy0Sz6duERwr2xKgMLnvkAOj/yHpfJJh1
 TWFPhpPDgozaY/DZ+U4EjWZivyZtW/EXgjDcT1oH8pvMuYrpwu6hm0t4d5OtRzyDzo0f33Qugew
 5uRys/Y2Ik8TIheGcTPqbOspDpPuZ+71de6RUeNRJBNLLEAR7uw8AcRVxi+dKOolnXsXeF7oja1
 8PizrPt4ThDVpuUBymBgda9QX+J2dK1i55Q1navdqfxG6fCTFGR1VgdzYOJBInVhtPmqnW2Sqx/
 ck3X1gjLUv28DtFCwrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210083
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

Now that is unneeded.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index ed83dd927b54..3ef3ac2d86f9 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -170,7 +170,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name __maybe_unused = {		\
+static const struct adreno_protect name = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

