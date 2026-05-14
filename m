Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AA7CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE04710F23F;
	Thu, 14 May 2026 13:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJ2A2hUP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H6ZfaGX0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8657D10F239
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:45 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBekjK3062547
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Xuhe6ygR1yI
 ktoZp9sFxJLTtkjCvrYy2WoD60aoQU8w=; b=HJ2A2hUP+CGmiN0vNOWTUvpjPp+
 JLqrhQ06jbl/4p3HxRpQQjMhTsj3k7vwrIYXEh53lRjkyCHSfeWuNcee4Gk71TqV
 TtdTlFbCvIVxfVl8NFjYJRw3tHBGQeX8NDokfOqCgWb48515BtXH2xACP2gMcCQ2
 dd1fTjU+xa7nt4/s6Hc9VQlMhTnj+yxILGLZGU8wuQlsfRyDaGEcKT2TlMB63DHl
 +hCo9CdHPNyqPB670SUKeB64Y+AgBECz+loopuPV8+cdDOQzP/poU0gtbJmQNkiu
 gokSLpK4U76LMwe7Uu5ybGEkZzetFFexxuxAvZEs01C/ey17PISFOMFO6sA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e554aa7ww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-368edd5fec4so3421939a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778766884; x=1779371684;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xuhe6ygR1yIktoZp9sFxJLTtkjCvrYy2WoD60aoQU8w=;
 b=H6ZfaGX0PiPDVxA0Zxn9IzKyFq1p0gz1JMZsrrXKX0R+dQXHpCCAh5LyqWHgadIk9m
 FGQnIiZJjwUtjXOXEXET5vmuBdgcSSVSAZ8FPkSfauFkh5TlALZgJo63xs1JrRTWJLzE
 W7eIX9cEtfdh76SVH9hglV6DFYN/tLdiBQ1s6MTyIwQwZZZZEW/K1DFrIhal5owEztAz
 v82gmxijS0PBaTLXDbxivD3GLJUItMoSqiqhL8Qejw0hANq5fSsBuJ6hlCvFYyVb4lMI
 lMDBBAoxCXhif6Yyw7Eq/lkBQ20e/jg6eN8NnUJ+B0fMgHvuIjZKK3G7Thxb/Bww2fAZ
 k25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778766884; x=1779371684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xuhe6ygR1yIktoZp9sFxJLTtkjCvrYy2WoD60aoQU8w=;
 b=MN4wl3rJw2VYwo/ydgGM4cP/bn9qwjVCzm6taQJ0+0M0oRmWJtjfnTueRKKYi9Ppga
 MIFoPlzWfO1BnflM68GHodjEsIqDZbFdiwlXULbtBzpwnGEBL7YRkK8bK4G6M44v5JBL
 LScWQr4mFNzdgUs/wTJkg8Qf4bYEOdTFZ/X3O0IErW5ZvupPrDKb/0QgpCXoRXElfZKc
 ktFLM0o22hgvLPBrLbBOO8F8JGmK/9x5Szm8eF7x6+ETA5+EGQFF5jWbf/rtqRDfjGEU
 M+oRgm7fi9q17ZuRHaqJE830uwSpwQGFMVOAW0/Z/CGr03V6TCkUGt/ihfA3Opx//PRy
 okFw==
X-Gm-Message-State: AOJu0Yw6RHO3IjGICfgPjujmc7SMesYc4Echek47bOuHJmoRigpc81K4
 03zbow7hkxvYAfafV6LXn5+ePBnYrm1hsfO1Bq6Xc/LFWgtzpC/kRTUMMqkJgZslqu8xGuaZI2W
 Jp5xxpj/13el7DOQ38+v+uJZ196nkLD3NPz6D2UOfjVhJYwVLtudI6ZgbQWJmlcpZWRl6ereNJN
 og8Lk=
X-Gm-Gg: Acq92OFtUZjwSUe8ctZN2PuWhSOfXUaNG9zkEavErlsuW29NoCabUECJaLjN5CNvDpm
 Jd4Issc7miPQ1kAi31LlDQTHW5yB/y8uPiFsw1X2EbFAiErpbZuadMiwdSKeSEefWRxaexLGISO
 6q3ywRwoD+lF8lxUgNbW+31VSyYSBjDdyBwgtPct7CIUHwXK4XOjSMTNJku2SAfourpm+/U2DFa
 UHkbFVqOg/vWssi7acXTtSBVibyOE8Q6LOJWhbuFSbkL+peVrbvBZOURZzfh1ejH7+cZ7IRCSXB
 tXnAqWL2pIJkhHKT8fbetCTx9d2tsYa5WcIv/0qhIJZdICev01noTBlbxbu80XNutqQ1T/eoilr
 Y1VSKKNEkNBQBRueCHPSYBTm7zt+ApEdM
X-Received: by 2002:a17:90b:2b90:b0:366:decb:d119 with SMTP id
 98e67ed59e1d1-368f780753emr7829555a91.11.1778766884314; 
 Thu, 14 May 2026 06:54:44 -0700 (PDT)
X-Received: by 2002:a17:90b:2b90:b0:366:decb:d119 with SMTP id
 98e67ed59e1d1-368f780753emr7829515a91.11.1778766883832; 
 Thu, 14 May 2026 06:54:43 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3694f5cd7edsm48006a91.5.2026.05.14.06.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:54:43 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 14/16] drm/msm/a6xx: Increase pwrup_reglist size
Date: Thu, 14 May 2026 06:40:02 -0700
Message-ID: <20260514134052.361771-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
References: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tf50F5XzCyt0CQ9OsGMPfalqzlD5iyF9
X-Authority-Analysis: v=2.4 cv=Wag8rUhX c=1 sm=1 tr=0 ts=6a05d425 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=bkW2Msa_OoTtud3PmHQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: tf50F5XzCyt0CQ9OsGMPfalqzlD5iyF9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MCBTYWx0ZWRfX9CHG88+2+TUY
 LRReL/z1OXDlI4GUBzt+f4JzcGvFqFfgh7OQpBJWIj9F86ubSik1JHceh3fWcCfPHZ9QQXIP0xf
 dzZjUs/0JzYlEsHjqqIbrS43BdxxueCCxaNdwuvHoBqZBBFTqbQwmK6RoOR2sQBIdBKgRylAjdT
 m7EDR3B3msg09SGczMuUgyGylhED60JMIw/aHZoZGGFX9imL3l9rI5mVsHnsg+19X8zhATogbgH
 lHmxr/dCXgEmYZmHuZjKYFOV3JLI+NLIzugvj75oxrU0ayo47eMgu69rN0+rMqQg+s0nYUgNDu6
 p3YB1aaysS0x4j1bTahws9kqhj3dwRtonuxoRXzDGZof3Nlp9A1F4SJrwQg0Xx6AebIZG4km7zW
 Mx0dU6VJS65Rp2qQYW8xIW2HMPbcXV/0RMJwTJtlQSF/9Y5ICz2lcpTwyrKE+T1r0G7l/qPO88x
 FRiaU2JeKUlf5WkBr2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140140
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

To make room for appending SEL reg programming.  Without increasing the
size, we would overflow the pwrup_reglist at ~190 counters on gen8.
Or possibly fewer, considering that some gen8 counter groups also have
separate slice vs unslice SELectors.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a329d20033d7..61c6b0e781ce 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1183,7 +1183,7 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
 		msm_gem_object_set_name(a6xx_gpu->shadow_bo, "shadow");
 	}
 
-	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, PAGE_SIZE,
+	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, 2 * PAGE_SIZE,
 							 MSM_BO_WC  | MSM_BO_MAP_PRIV,
 							 gpu->vm, &a6xx_gpu->pwrup_reglist_bo,
 							 &a6xx_gpu->pwrup_reglist_iova);
-- 
2.54.0

