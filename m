Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4F606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NwSmFY0v;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qz6CzVmF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2448910FF7E;
	Thu,  5 Nov 2026 20:41:04 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F88D10FEF6
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:40:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeBL72433593
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lfoXwA9UTdo
 ZzNFdOqsicYhSJ5ry/Efkki2NBM8m1i8=; b=NwSmFY0vH5c62ZXXuZTBhl+slPE
 XtIPJzzOLQqhsI6gZRN3kQCw22GTkzntcn5OgO4YW8IVSHtcxTgKIPiNM/76Mhn9
 0sHiDLupizm2OB5zoHICJuDt5A8O8341w+1q/RpOGCQZHK6FI1DkRYv0xVUwbjKA
 F+wtv41nO7wjMJ10g6QAStqgoNMGSrdjLr/d0/ppT4z8j9Sxihp86VcVmEBnO+MC
 A8Jot3JaP7cf1HidKtiZUlgaDSQb6RS43GfvO2f84xNZOMJPS0qZVat07to4duuu
 C+qLwCXb5b1j5nl/f7Zd8nHvjPRRDBX8lqB7wx51L/pyE2fM9JPXMz7L59Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqpd2s89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:40:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd6532dbd7bso1514419a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911242; x=1794516042;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lfoXwA9UTdoZzNFdOqsicYhSJ5ry/Efkki2NBM8m1i8=;
 b=Qz6CzVmFrosexr9KAjYCwOi19Cl4VEzJHvTvcwvyhVwHO1uM0Dd61hkG5A5JLBmTtk
 pN216FKi9UZFIyXVHE3+fP7QloPpwduNHHk1A7nchmYWYU9OFv1uIlB4d69Gc/zQkw9T
 RXVsZwRsJN6C5pB5HghkcJFO4ep6Cf8yiPPkzBet1XnPGbKhdJHAIe0uAolICW6l9eGg
 R36tAWVUzW28c806VEj19Ogb3eHXSP38kFzwWTiVyFwQzrhUF0bxawwFsLkUZGsIZY+Q
 YcawJWolMWbACzfhq73j660s/POQAWrsfeJ8U9zrCwZ1RfKxzff1plzxmIpRuLEK2+vD
 jJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911242; x=1794516042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lfoXwA9UTdoZzNFdOqsicYhSJ5ry/Efkki2NBM8m1i8=;
 b=lwBEIzW4uaDT1g5K4n1frcPDoR7AuXyOjbDrQoh/CKB+6yxHzn2cy8/VFL6atafnVe
 OEiNr2iN6M09YzTi3uWr70aQk7XuStRrzHl+R0AT6k7Lo/W3hr3lSs44fmp7CT0OMNUd
 5FsrRAMzc4879VjEVCNaYIn4KmqXZUGigQmUFE14gqvR3QUr4sbH253ABkUdgjNyh6Ij
 +z8WBStNoc/+/NDmJn5cdvNp9AHEQ7vyvf9ZGl3CTi5Fo8H4aas0Plu9X3wVvlMEasrp
 xc0rAl8wc1phOchhHf/YUTR5Y2ZAlaT2wHZEgZF+3buP8cmz7wkVGMxwHVw1hY5CMZt5
 Y74A==
X-Gm-Message-State: APuU4Z8mcTlX/xuVh2L+kAfx6xNqCvWBTbUVEk8R5Ti3AVm49szxSvAA
 aMtOAfn2yc6yTrEszZMhUMxCw+X+x/y8g/vNtcizAdu8TVPlY6pQZNIrQbM3P9EUynJ1pnJu3h1
 Zz7zGhNP6vLVvfFJj4m/ItUO+6Et/A8p3sMnJ7NiyfZG+0RhL5RYQficX5hKP/qurfq7FisvmTf
 FT9JjbQw==
X-Gm-Gg: AYBFou3MEU9GnJrbeLwolsZOwkqzBm8oiyky83nMXOeoLdQM56scD0aypnRZxNyQcoO
 KudJY6BRkXtmQj+OunHNlArqUNDAGMquiV+X5i6BtqBzC4ZWLt6/MwoGoMNRiLrzt6MslF5hADV
 NzGRd7xtcQaiAcjj5Z+LR0M6WzlUcJ6y7rHLw3w/lVDXRzuQLjwWLR/0JAqhIOvBjmWNePIDtPB
 rb29TLqmhTToOU+v2IFiIvUAKdaEKCG2/CWc3T0OvUDF8vyCObCYC1Rjv6hSr23L80I1OMqMOOg
 85f/6OR/8fWji9w4D2Dk9KtqYxIP5hSjy0NwjkcdD3/QO6Hijr4uDuM3AM+h8hMlce+ATB3Fgig
 oXZp2GiEu5BubXtXNLUb/0aluYOt4G8GCBbAHUTBfzmRlbCqTRk7SIySeob5zB8GRTDyfGWzePk
 sLBb1LoYOTsAJ4+zoGaJQyB110BNLdVeFYiqJq6zjY0ZtosZb+acq0N1EXS+R6
X-Received: by 2002:a17:90b:1643:b0:3b0:8947:fad2 with SMTP id
 98e67ed59e1d1-3b0db70e040mr203461a91.53.1793911241721; 
 Thu, 05 Nov 2026 12:40:41 -0800 (PST)
X-Received: by 2002:a17:90b:1643:b0:3b0:8947:fad2 with SMTP id
 98e67ed59e1d1-3b0db70e040mr203434a91.53.1793911241219; 
 Thu, 05 Nov 2026 12:40:41 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0d7c42932sm616255a91.6.2026.11.05.12.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:40:39 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 09/15] drm/msm/adreno: add temporary __maybe_unused
Date: Thu,  5 Nov 2026 12:29:35 -0800
Message-ID: <20261105203057.66520-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX44UczUvoskSP
 20vCNh4WYDXJNSKFdidcdIWrg+ULDm5o2j8xscApt/L9OUl7HnDq+y8MroDUSZeWeKdGcDlW6Fd
 DMwS+p9/JWD31caFrbYX5joiu9fSwjw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX0ah33db/Morq
 9aWpHTlKiUV4oLC7Os3TeiXgR729KWITVZeu5Po4dZ/BMpfjGtnCOpnHPIjovZIBDyfpkwJiAW1
 9Jx24rYPghZB0dKJbgJbEaSlSPs6nuVlRmcXecPYEoAMilMxfPeZVmWPE0HCTdveBKrZPoEgahW
 duKaRVJKMBBu+envl1+DwrFZ2kAxfUFGDkJNsLiug56ss6LPSYMiNYYbE3rbbjl0Lv3M4PYN3gx
 6O9toHhPR0o+3vQvIY2n7NvE4uuvpcFTtVSe6hEUMMxza33cOQPE29Qn1JhWsKW65kP1pMpSZ4d
 OXW58kbMTxpBZUHJQ3wnaU6RVhqIk28cQaCqiEwbP8nwWEGMOUpMfhEASfpX0Z6RcmsWil/wk0g
 GKIlwo9b+/jYYqF0mlFOyYs4IJ37yJQb/zzD1JqvUzogxU8tFRsBs5GIt9nCxx+yag7v3/qggMx
 g+BOBE+MZmx3I5YPcIg==
X-Proofpoint-ORIG-GUID: V78AGoYs4Ze7kzWWRolfNTGHthMTIew0
X-Proofpoint-GUID: V78AGoYs4Ze7kzWWRolfNTGHthMTIew0
X-Authority-Analysis: v=2.4 cv=Y5JtIReN c=1 sm=1 tr=0 ts=6aece9ca cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=5VHPQfPT90DSkkNPp7MA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050082
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

To keep this series bisectable.  This will be removed once there maybe-
unused protect tables are gone.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 9e0d37ec9c15..2408adfeeb23 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -168,7 +168,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name = {		\
+static const struct adreno_protect name __maybe_unused = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

