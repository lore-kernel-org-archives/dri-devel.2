Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B910ACD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32F710F0F8;
	Wed, 20 May 2026 16:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="V8Jh53oL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aVmO1Xex";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7FA310F0F6
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:45 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KCe3Un316511
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1lVUJdVdQjl
 CYs1pn/QJSPt+RdUfcq/IDjWcVJlIwl4=; b=V8Jh53oLHsTay1R7qEe5Nsg6K7I
 hKxrOkwYTMfBnxZH26GDMQ/WGiLmtzQG7RKfTkhgX2+2Tw2fHTqe+EQ/vOHCmIQc
 38F83GTfeaAZoCiyT4DXEPQGxEvwP6PY56PZIdfCuaHvc/ffPbEDFDGyeHjDtbrN
 WCOKKkuH4VR3dzMeqX++ph/fZysOrJK8lH1n9opL3q8GHR2r6yhqwGI8r5uOWZwT
 EL/6V0phYVolN/so7GJgMHhvpqPoLumRPQCl4W9dTRpRI5T8MJrkJel/GwVSs9dA
 T/l14Ij5fAppopkGIgwqZm60tkkXEnzoxP/31Xf3+u2oeJncjTaP1nCHlnQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9d5qrxuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b9b8137828so52466165ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779294344; x=1779899144;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lVUJdVdQjlCYs1pn/QJSPt+RdUfcq/IDjWcVJlIwl4=;
 b=aVmO1XexX6FuyLYbmjXjgquPPRzpcpSTu8wwz4c8ti6faXBTbe/6Zg0jjiKYou5zIe
 znqcEQZ8cBGDq5Xft5iKJkO/5Ck0Af1BFQmUZPEHx57cVxjxXR77A9Eo3jNrUiG8mPOQ
 sIIsh7iAiXBEOqwFCw+cadQZQZlpyvk3wuHot7harDy8/XXV37Hsi9uEjpySY70xHUyZ
 5ZJC35xEIcVh2mfA6j9ST//6VJjodDQ0IxB7cFkOSwaEOMHKlOFdxHq/frfILD0/phM0
 rcKasCGhF0ETzGgw2EnXKVkozd4d5Hzt/1riX2jeOKPi8mq4WmUQlf9j1klMzA3uZiyT
 D5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294344; x=1779899144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1lVUJdVdQjlCYs1pn/QJSPt+RdUfcq/IDjWcVJlIwl4=;
 b=fjgKtFmpeIE5z71uJFdIwPAkSl91CS/LgnqHNl3U3MQ/Q1skc89AzVQXoiG3mzseYW
 fFetDmfFM1txzqqDK6FpKjCPxuXztZb5mQUfXZfob4O0rRxNqe51P7CpOxHqbDhLZX+8
 NVQXbtpJBXUxvrWcLUswkdtyZzaMW19xfq01CiDItgpD87FY9X/a+6Wd49Wy2u2XekGo
 Plte4Okl/QjgN5Kp7418JIZWWdc2iJeqjuf4a1R+uN3BPE/Q/vFE7LQD8LKMK+1kwGEd
 QSxE5sM4MoWvYylBg5wx5KsMJ1xqS/5DqTFcisiLvbqJdowzGTTyY3LX7sJd/N/kN7B5
 oEDA==
X-Gm-Message-State: AOJu0YzuaU3Y3RzulXnalZpI4I9RouXPJtfENiuEdXAg3JFBgFEsL9bQ
 cysST2WfaVZ6bQIvFydBoL9/uXNpAFMs7RhtSNuXQcea4WY2c/NzpXxD4+u9NofhmQD/UoC/GKL
 sR0XaPe3pbMTMBgKT6D/4DhQkk3F4AffPvjKDY7RxDdgnB6gF9PMbGeeTz7EoT8FBEU/xx9w2HZ
 XDuN4=
X-Gm-Gg: Acq92OF028XkjcsYdDqc/N/LoUQGksA0utoIHu9Gi1PEZqP7zAwuJZdy24SSqzb7bT9
 xcCY0B4XIz7WsAwKZwzvWnSG5W60+uw0YQ5lRFobdJ9pHY8eRgp0KBnXYkx+jMpsSElq0H0DR/6
 5KWU7MGCwzP++O52t1294RE79HrDxy85vmnMWFeBLhjd2d/bj/V6SbJj7mvIubn8OCkVsrL9HQT
 54phZsc9KVGsOjvcHAf9WZ02CBHsPKkfgqUldosBLo52bCTkgRxj/zE6F575cBpOZHaqnJcDcCz
 9q870H05vxaaz/MEic/181pR+FO/kcjnVNcS+VWdKxVl8BCTH0EAEvp5B12StJdGxJ+vqB2p/rq
 mWdzBlxMb0bF1dCJIc/9YV6RLLGXrMZt5R3nY5a+IqkM=
X-Received: by 2002:a05:6a20:4308:b0:39b:f25a:28d7 with SMTP id
 adf61e73a8af0-3b22e6672e0mr28332615637.3.1779294343829; 
 Wed, 20 May 2026 09:25:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:4308:b0:39b:f25a:28d7 with SMTP id
 adf61e73a8af0-3b22e6672e0mr28332567637.3.1779294343384; 
 Wed, 20 May 2026 09:25:43 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb1231c7sm20777095a12.31.2026.05.20.09.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:25:42 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 14/16] drm/msm/a6xx: Increase pwrup_reglist size
Date: Wed, 20 May 2026 09:24:01 -0700
Message-ID: <20260520162454.18391-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
References: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1OSBTYWx0ZWRfX3v8vYIivXzfM
 4gEdXMFQGGiAxL+67SDF9Li7v6KrUUiR9B34jRdiULhZdQsAStpZvv/8IPLwpnQz7MGF9og+tAt
 0LHDpc9J4SGRGWVIeo4F8AhwZVmC+BNhGyGV1hrJP9d+48JxeTSUaZjYhhOOKVAN757SSdMLe1D
 At5sBI0gJTshmMoKxy5z7AvM810VqqoJ9cYOgCO0OIJGpDvMd8+3WJdK3eFerMZbxkbUPD1r2s3
 /2iq9XMuww2tb31U2HsVNF/onO6YtD6fCpKEIX8HGBSQms/dGFlchUIw4yuLYt84mQvU1sYfspY
 xKAp0T298TE972eUc7MTFmDwfXRVjG+T6aRYK4S9eXNmhsGCX3+dhdN8h2K+T74MbVAZapQN4d+
 QJX7T1MrJliMG/oqH90qzTYtjZfydJTqO7KMk3y6v/iEdiY38OJb5Mms3TOUDkH4UrPkTBGB2ZN
 fqlMmd6e5gjsGzwsyfA==
X-Authority-Analysis: v=2.4 cv=QshuG1yd c=1 sm=1 tr=0 ts=6a0de088 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=bkW2Msa_OoTtud3PmHQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: S11Iszq7_1L9Q5FWBuTIHLPDD8zgF5i_
X-Proofpoint-ORIG-GUID: S11Iszq7_1L9Q5FWBuTIHLPDD8zgF5i_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200159
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
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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

