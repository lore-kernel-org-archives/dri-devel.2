Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF8C109C05A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B40210E837;
	Wed, 25 Mar 2026 18:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AH6Y5ORw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dMXDB05d";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EF810E851
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:59:35 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PFRKQR1432152
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=jQ/oQs6UJQqcj3OwossbpML3FdcdNFDAZeD
 Kh0U7al4=; b=AH6Y5ORwmX/fye6TGIHruZfMQHtoZP9RYg+ew2hfYoNoeLFpp41
 q0mVpuN9vD/dD4zD4tTUaCo5Bo0jAZ9iQQicEkBUsZvY4Lq18wW684EsZddKYP2w
 LWO0bRNJBsvtaDhUjW8Np88teMNVSQB11XaZrx+/gGn1YAR0+eDO3QAlk3DhfRKD
 NpVeu9f3beC1MIT2x6dTpEAc7KZFn6y/xMJ8MXp1ihsuwZgQy2Lda54r8MquR3S0
 cOHwGMuzm4AsQG2AbS8jbNTxuE1OsX0Pk0rYlDc8b1jRGujLSjAxb/UqUaHbrdAD
 aoC4V8N07dCE6W3tK4OX1OFNoUiuxqwkvDQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4jc50tvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:59:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b060c14ccbso4433885ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774465173; x=1775069973;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jQ/oQs6UJQqcj3OwossbpML3FdcdNFDAZeDKh0U7al4=;
 b=dMXDB05dj8GZ3cmn5JSrds+I6+HXzNluxUHITRsZfJSct9CVwTpH/85vBEN7N2Agjf
 Zq6tRHHOxNEduVsDZjtl/Bd6KXo9xXZNHUlhDsxslqbQQF1OI+wkKK/57DvsrkOa87iQ
 5pc5XoAMUh88MjCz90Nyfd5WDkX1GEVPlV9gEc3pClo5+Omurz0GWg+5EYZV8EBf5kZ3
 BfUBVIgXXnKui9eT6qPRhzGI6VG/aA9rambbZnWq4QJt87c73EvXRupxxo1Dp5TWPjHk
 cbXISNRswJ6vz+BXoNr+DpxELm2v4hMJ0A+roB3RnfEAXmYRCEOJmkrlO1iajnFzZn9c
 LPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465173; x=1775069973;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQ/oQs6UJQqcj3OwossbpML3FdcdNFDAZeDKh0U7al4=;
 b=Cin6KQFh7jbEpFHlOD1qJJyo9CEXT1YgMfdpv6SplDHTS6OQHB5LZHgLvO/QIqnA+l
 YWvSywpYrZHiRTgjo3AuAjGlKCQuWMEX/oxx17BvW1jtWKUzgAzehMT5UdXm0lPHViCp
 m02+HlYSiItojCINZsn85wWMsmRhhCvXVwrZMF5BFMaQoyHJ+oBCD88KOTE6HL7lsgOW
 D8Fm7vawKX43bBQ3NPa93JNBeecnOnnJ+Cvf6uL01zKVOGWCgH/PNu5U45C8VjmftSR7
 PQHKa6XzpyOTImywZedGpMqssyBw/60XTMAe19oJnkTX/jA1HsPG6KSOjNVU7TLiDhQ/
 halA==
X-Gm-Message-State: AOJu0YxmFA/HH24n2LdR+4A9kqZmfcaOIo4Hy5ELxdmpJ8xIjMgLsjfl
 OTpjA4sskRuNqviqUMVZximeCArP5pZMuZn0ky8pHr/YoPob6F86qiuxah5g6vXrA19XfaH0OpB
 N1wM2C7mxS71LQzYUIbEaIoxIkeqMD0Bo6YHHQHPwUloq1QJgCaw8OOHZXuDFqm+jZFiisglr1F
 ry5ns=
X-Gm-Gg: ATEYQzzvj4hsk0AqVf1J6jP7Oe28+KMTSMfry5vVWSUC3+ZcFYJXzY1eybxmziGTkUs
 JOL2/ZykuQuseEz58p05x59hHgo4mHkL5oNbvO+2NU30KM9Nxw0eWxMj7Twh7P87ZG67FAsncr+
 CxWqOO5fqrS1kIWAzMbRMNmy8mJaSrmejOEYC2VbkwgelvckmOyicrJq8U/gPu0plgzIN17SJWb
 +3fYzcjZui0/g1yN/K8cwfKTI61no2xVykWvTiVwxPTdKxxtu880P5q7OVoWoaIGL5mdwVQ2Bf9
 2LBiY9dnMDizXpWjjSIHuP205f64WItj1ZwrTPjglcEJ8krducdaOtj8CJoAZZSRm341CsM6Mjx
 NvmWtph6xo6vDcBshEY3u9ARAhdkfKVuD
X-Received: by 2002:a17:903:1b6f:b0:2b0:6263:6a05 with SMTP id
 d9443c01a7336-2b0b0b1e31dmr50542505ad.51.1774465173086; 
 Wed, 25 Mar 2026 11:59:33 -0700 (PDT)
X-Received: by 2002:a17:903:1b6f:b0:2b0:6263:6a05 with SMTP id
 d9443c01a7336-2b0b0b1e31dmr50542095ad.51.1774465172583; 
 Wed, 25 Mar 2026 11:59:32 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc87ebf1sm5764125ad.44.2026.03.25.11.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 11:59:32 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Reject fb creation from _NO_SHARE objs
Date: Wed, 25 Mar 2026 11:59:26 -0700
Message-ID: <20260325185926.1265661-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cGDePQ8OZohHF1fmW321-nP8NyBXvq66
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEzOCBTYWx0ZWRfXwXovf0RbI3a2
 GlYYOmRe4OXoCcoIigdeAHpHBEBVYy1oFXcwRSQSdOsZUI9uHLkjgIY/3TgCY4hsZi9+jkfazft
 rerwup8To7R1051hxXZ3bTZjqjwgjukFKUKc6gX/peSbTOzvdqYqlQr5f7pV/0haw6JGKlFMWFP
 YnQsDJJVprUgg6rv2j9ujtRbcSbVOsT6Jba33VDOuwMjCknyuHVk7T5kVAE5iXc+XmmEeD8T5m2
 0w2sQDuXtFdEh5wjcYMFEXxafg5ve1YUty3OPrMqeJlwrDXGO7cfRo7fGmuzy6HRUp5l5Ue7rHl
 /Z2s7ik8DEojSk+aPKwu+daSOnRkH/6HxoBen/BZP49n9Yd/7U16iJUMFVhwAqKYiBKdLr4CETS
 uV+fv3JhV3qIh2/UtMUZUdF5RqDyfRaRE6gd+qEMnno4z/ouDz93fycoo0hIYl3/QyXh5AnNAhQ
 I/HTZ2wZ0hUOVyMsOUQ==
X-Proofpoint-ORIG-GUID: cGDePQ8OZohHF1fmW321-nP8NyBXvq66
X-Authority-Analysis: v=2.4 cv=KaLfcAYD c=1 sm=1 tr=0 ts=69c43096 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=LRWyuCbFSbfGocd5_k0A:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250138
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

It would be an error to map these into kms->vm.  So reject this as early
as possible, when creating an fb.

Fixes: b58e12a66e47 ("drm/msm: Add _NO_SHARE flag")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_fb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 1eff615ff9bf..ce1725990a48 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -219,7 +219,12 @@ static struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 			 + mode_cmd->offsets[i];
 
 		if (bos[i]->size < min_size) {
-			ret = -EINVAL;
+			ret = UERR(EINVAL, dev, "plane %d too small", i);
+			goto fail;
+		}
+
+		if (to_msm_bo(bos[i])->flags & MSM_BO_NO_SHARE) {
+			ret = UERR(EINVAL, dev, "Cannot map _NO_SHARE to kms vm");
 			goto fail;
 		}
 
-- 
2.53.0

