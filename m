Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F168C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110A810ECC7;
	Wed, 29 Jul 2026 15:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CTgZdahd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gX0p2BDA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D2FF10ECAE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:02 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF2QKI1961578
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JwmCQxui8//
 y9OuoPvnSLIPSYLXC2fHhEyhJF+VayoY=; b=CTgZdahd0vmOteMwuWCKSb/bg3Z
 Ap5eARGGU7HbUCqYCbccymAOJSQvzUqTrYBfTNiJZ78lCb9UG9XJwmom8tH7a/Tz
 5YsG69Zer/E3Nhbk4fh7kHfKLReYAflQip1HIr7Ne2g0joL7o1HpzqzDK5bDWPoE
 jcbBrSR3njXERuE/GK3ad1R+EHSdZ9d/g5rSBJLnjH6gnMHkU88ZZcWBzmQMucnA
 4QfkJikK1LenLYeoTyEUtrO0/KfPK4NayQanPBWG6Lx8VFrNQvScaBM1V/XOK5Fq
 BJUNC1+Kuvg79s+iozGWou/NarchO6upf+cpwUjj0ahYbrQEoDsZL9pQvIw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgy919c1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cca3673560so19738295ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340621; x=1785945421;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JwmCQxui8//y9OuoPvnSLIPSYLXC2fHhEyhJF+VayoY=;
 b=gX0p2BDAB3ngDTp33Nt489Ed4Y4E/IoWxsUowKh8w8pbxJSFu6ULMlbuVY7UIt6lQp
 MdoNai2HH/KGXwUuH8dRngiwDuI7emPk0MBrIZU/MXF2uEhMprNwtFiBGgVkUvsHWl4r
 VR6qP+cfj6fLXFtyRFmlPFUu+RFU+VPOdayRL8CFitaR9vn0wyjBJ8c91Lffx+9/ExVU
 BdVgzyV1z0wuBMkG6f3iH0rt4mEy/VvJAPuH6UF8FIKNHloA6fUvqJZQa60Q7M4StUQX
 YMbHE02uiIVPzTdelRPSm3GkRBQRGbbkScLhUzrf0UoT391e3IZNadi5dGeYjwmtNlSi
 F2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340621; x=1785945421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JwmCQxui8//y9OuoPvnSLIPSYLXC2fHhEyhJF+VayoY=;
 b=FGf94BK77GCN7mta39p5xmgpcRKD3SFISMEsB30xWfHYqxZtAD1XzY7pQSe6JP7FEJ
 TzOy04ahLeMAPB1NCl9nNzxBcgui4EeWEwuTOLM+7OpvGvibccjoRzuyYvRjnGPZEm75
 6IR990IHyGz+02VxVrMh3ylr6FUXoU0gucC2UQxTDry3awCd7S6O3POcdmFz6bop7iXg
 21dvRVoXPXENljr+jHI40E97OAr6rQOHX3eSWCNd8cWNLezeH7OtzEI8PnW6zH1hYmgc
 m4zBSR30TQ+ZVouQhsVauxRWNlB58mT3yQGal+5DZBbaZ09LGnEXP5eA1kTrpETnarwY
 QrwA==
X-Gm-Message-State: AOJu0YwIooLx56aYoB2nF5SPz89iuYaShmXJePbeRMmcSlxJ4YTzErjA
 vke+kTpSIg7asSoSZQ+miWeXh8rHNxbIND4LquW8SO6QR9LpuLrQgduSvHIRidtfTjbNLVZ49rO
 fMYC72ycn5zCHgJPbqEIGGrWW25AcyQvCQaaO2KNYHF0oIQGCAFPyQcXdt2G+VKXqCm8V0ht7u2
 S/XmQ=
X-Gm-Gg: AR+sD11iH8n3tXm2QIIAFk9XhY4mFqwV+H2PcD9ESU+4QGHzOBOwHIDC1ee5lU3duji
 5Ri4j78+xXhOQIcTQ9637+6BMQnD8ISUHHl8+KvqqXFnVgX+YTpZutAG9wqnoe5j3Uc3g5kbKDN
 bvNElJghN0X8pQUGGhK27LQ2/qeJfUIVwyzh/WZ6p38XBLbPC2oLJn80DUC2rKMgmi8CoNgC2VS
 70wypjAHMezBsvpafOzMpPfdYJz/5mtpYy3vOG5yz8RFCX4mpeR1G08ZmqjNy06txV+hJHGsMBB
 Mq1jBqvOcylNK25+mYkfcN1ABFdvbgYh0A4cPw08Xz/Uu4t5Epk7Yl/JGdOmDI7pT1XpBZO8MuV
 S0nvD0L+Y2iWbwrR7F/KiqRAAHDSLWOA2RgHbJQ1vRHtIQyc=
X-Received: by 2002:a17:902:d550:b0:2cc:aa38:4df3 with SMTP id
 d9443c01a7336-2d015af4dcemr87591895ad.13.1785340620870; 
 Wed, 29 Jul 2026 08:57:00 -0700 (PDT)
X-Received: by 2002:a17:902:d550:b0:2cc:aa38:4df3 with SMTP id
 d9443c01a7336-2d015af4dcemr87591525ad.13.1785340620481; 
 Wed, 29 Jul 2026 08:57:00 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022a48858sm13719045ad.30.2026.07.29.08.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:00 -0700 (PDT)
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
Subject: [PATCH v7 06/17] drm/msm: Remove redundant SIZE_MAX check
Date: Wed, 29 Jul 2026 08:55:43 -0700
Message-ID: <20260729155609.20190-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX2Xb6x63qbhT4
 hG97BTH2NaKRp0sJBMxRXr+8r5tT8t8RlmRBU7yHQD4o22sBNUFx0KVUjs1k9MXnBizIj2hLMBi
 LOKfPGKsn6kVanIhG1M9o2UfG0ZwBkc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX0nWXn9rG1msq
 BoDcWZah13/d0Xn4POsdcNDjjejOsvdF7G4XUlALPMrB3FWZL8Kr4XXbGziDw1VTXo13jl5QNWr
 EQiVvhHVvAnv0Re7i2IA6teJK77BXCe21k+ueSyTTfhyfKDu8RHOHJ81uFl7k9l/DkncGTCpblb
 iIvnkCvCR0z4GCuah/5bwO3P7Ofh7WHAqoYyT9HCNly8snhLXXvWiOHP2y9ygKgYgEZom8aKeb3
 tkr7mK5+Y9y3qkw1VSPCiUIiRGQZRYNKNWpVGwzCkesLSTTmcuoJTqanV8yDs6ML3jxqHPeGbPH
 rAs8nBMYSN/8i45d0mYpPkfdQ1e+wij8bYbF+UL798Z32p02cdLjp5lMWuYuaXON4YHt5jGjGI/
 WFPtHH2Nza+OdJsgI3s3eanM+ejZgK3mmx6vTmxUuyUNidJGh/ucWn7QD0P+g7AMU3597GiVr/s
 5Os28pD/qer+4t2Siww==
X-Authority-Analysis: v=2.4 cv=LtKiDHdc c=1 sm=1 tr=0 ts=6a6a22cd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=eWlSUfSnBrBg5eVjM6UA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: pP9mDx37iAyociXPpV83-1evDNveJ6rp
X-Proofpoint-ORIG-GUID: pP9mDx37iAyociXPpV83-1evDNveJ6rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290127
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

kmalloc() will already fail and return NULL if passed SIZE_MAX.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index aa48ea4e7f58..040354ee16d1 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -250,11 +250,6 @@ static int submit_lookup_cmds(struct msm_gem_submit *submit,
 
 		sz = array_size(submit_cmd.nr_relocs,
 				sizeof(struct drm_msm_gem_submit_reloc));
-		/* check for overflow: */
-		if (sz == SIZE_MAX) {
-			ret = -ENOMEM;
-			goto out;
-		}
 		submit->cmd[i].relocs = kmalloc(sz, GFP_KERNEL | __GFP_NOWARN);
 		if (!submit->cmd[i].relocs) {
 			ret = -ENOMEM;
-- 
2.55.0

