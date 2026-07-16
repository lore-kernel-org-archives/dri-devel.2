Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A79EC44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D9E10F3DD;
	Thu, 16 Jul 2026 20:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mxhsdYpU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eyULhHLl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DABC10F3DA
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:16:07 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJoOQt3753225
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=R5rQRmby/aI
 qaDxi3lDE9FH/pFFSKzh2fmPcewxXgX4=; b=mxhsdYpUIkz1c0vF+NQrAtW2Q+h
 eXErsuuxIrCsGdLYDqKAfC9GgLmNQcKKmQFwU5gZC5qiDflCtp6elpKFDz3fPFNG
 N2oSRhGUDongA+fwF4RF9GGuX4FlN9jnGU3MnuWj+/lku9+1g5Wg/+rXUn0GDknr
 F7ffst7sZvWyAWAkUONO++fYNvogB+dnm3LfecRSjLItQ1Y5eCOAm21Za35qHVDH
 3YlpynzIxgXv0KtYxSWwq0n8gvB+ZPmuT3L1seui86mhscc0HpokoejTjPEjie6f
 9C20+X+jxYiN+EEHeXBiy1uobPSPT27XB1z3G/A+xIy504IGs6JSU9HWMHg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex35pn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:16:06 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8484b57b98bso13321121b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784232965; x=1784837765;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R5rQRmby/aIqaDxi3lDE9FH/pFFSKzh2fmPcewxXgX4=;
 b=eyULhHLlLo/GqOAhGLnrd0SOGD7ExW8v2p0CR0sWpGxZHZdR6Jm9KieuiG+ZkcfH9b
 jPfZ7xTMZ6vCQovOxKr29s6dpbaySL0dPNh7ZNpFEati8wwaHVLu7oETW/sCD4i2GPCL
 tzU4IbW3U+Ww/aXmrCPiHFgr8GZ6AFvQQh3yIaVRX1Sn9GdFZ5GzVhKRoKOvgCwlyj44
 W6PybAyxQJjd5GWiKOh6KxpFZlzcvbrxHzaQYSyjMl7ZBmC8Iatr0QnC4Gybez4t3URy
 hwDXGAxXZdkGOthWwg7vhtMQBQKZby22lxtcb2aD1CcNU0MG1ZNkeypnS7KDoF1tA05g
 bKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232965; x=1784837765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R5rQRmby/aIqaDxi3lDE9FH/pFFSKzh2fmPcewxXgX4=;
 b=S/s1zs7A+kFy7wLvCpLgbhpsvVRgXC7E8ivpAQA+8N5cYxOVVjNgtgYmIB21yURhg3
 2uBateeex5gt/1XTToOv9j+zW7Siw//7jvf06FN0qIreVsssN1ixXfrtmJXWklezzvby
 WQIHgTEF11IN1dd29FeOeliwNDfuckMmGUGQYR9LbOu98RgFP06rENiBXDGCGGPoTqdm
 n+MnAyx+drsOuWvINL+KtT9amMtZ3CBpUYICmcgm9AnSvuvw6u7fx/Py76ByES1pabKX
 ALvC8U490+NBPIYCDg34ZzhhyCuFJ5ew8tJtekkDiSNgwJWjiAXfgpUceVw9ceLiU/SD
 FaWg==
X-Gm-Message-State: AOJu0YwBnzFPKSPaWcwHeM+Id3wa3vURcWGAJh/5VWDEZUGOLQKtVNYt
 3rDffkCVsgCsaLuURou9i85K2MMAigQ7dDo23DT8Etd/xNniKzkbP5Z5z2vCq265bik9aHvgcp4
 kBPhSCTMQODy20NGzMP/PBWW+BXX4mEXWKXdE4kmA7O1axJDG47ZpQhorZ9mUkgBYnVkNExQftf
 JUxfY=
X-Gm-Gg: AfdE7ckUWYlEKYsQ4BrfhRk5ds16GTzTUoEx2RsbeExFPkVgfSyXunMnCGIwz/dfMv3
 oLx6UYrgXZhlP/puFwhV0joixt4n1RE0Kwq92x3ym+9WoTUH2Vy6ff5FbMUlVViNcse4EJUSfKu
 4dLR3IAnkocnBM5F7FTZZQO5i9Nk//bll/aElEXSMwcu5KvpvKL8+yh8nPCcDhV01R5bVd/8q9p
 AS7TC9l7j2061Cz5v/jbccRvBZ/4Wde6qf3ITGlwXPGSTFxYN0tr6aRr9hDG/Jm8b/YvOAVNiWb
 iinizRqLGJIxTLW448CsOkOchSJqn37HyiJkxosymxuaKKORuHzbjEVSMXYM6490tjziKzK56Vt
 8ZLA3g5kT8+/1zI8Xti4aWySP6+czbB8S0SPAu77GeXTJzI0=
X-Received: by 2002:a05:6a00:4484:b0:847:9367:e054 with SMTP id
 d2e1a72fcca58-84a5162fac2mr11522948b3a.57.1784232965216; 
 Thu, 16 Jul 2026 13:16:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:4484:b0:847:9367:e054 with SMTP id
 d2e1a72fcca58-84a5162fac2mr11522902b3a.57.1784232964749; 
 Thu, 16 Jul 2026 13:16:04 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84a4f2389f8sm5296283b3a.4.2026.07.16.13.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:16:03 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 10/10] drm/msm: Remove invalid overflow check
Date: Thu, 16 Jul 2026 13:15:33 -0700
Message-ID: <20260716201538.365824-11-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a593c06 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0g9OVxrcTuodNeR8YWUA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: G3rMjdIeHY5wxualO_csoQ4UoX2C82EU
X-Proofpoint-GUID: G3rMjdIeHY5wxualO_csoQ4UoX2C82EU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX8Sq3z4l5eu4O
 Q75xSFCSRxM7V+kbf8RpQU498b8RJqBaJxVG8m8M8jy1nPV9Abxyw7xjwL0tdyF+/vMQCEIhK/U
 WQkUIwthQh/4jhzmhmTVzTQuKzQPVRc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX4hKwby9MUmAo
 cmAxXzTDpcB1YFYNSoRmRbJCNVf4PWm/SugV44p+CW1JEaR/gPjoUWI2b63215it/2NgrbYj7xe
 MdBFX26JA0gcxWWP2KPAgRUwqsJGvszMTvOMvXqH8+au4p2oPZTedtSjteDeN0HmJehFECcNSpt
 idZC9BX0ir6M2iQzKdpnnqAabbj63l9a2GUzc1nna4WA9vd2+mEskspxUwWxjSyDjvh+eTbZBL2
 Uv6jM1DxnGMus2i1+5QOH0NbN+K6cai9WbvytIrf1IkAKci/aDrIxWOi2pj/BtYqqvvh/3UrVnl
 GUkBGXF+nFMlCke6qHFUEBqJfhQIpQcxHdFpRTc4FLb66arSXA9MiFdCkOxFyjRDeA86FJ4O7Bt
 OaAUGHkG3G3Uekxbz03S18RQG0FVriGbTX2T/9vCQ0O4R0QY6Wy+3MTOzCmdrwuZpZkU7AEclA/
 M+fXE/7IpLYu6qyOkgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160206
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

On overflow struct_size() would return SIZE_MAX.  But kzalloc() (and
friends) check this already, so we can just remove the check.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index ab33d499a0e8..ddd52142c1cf 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -36,15 +36,11 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 {
 	static atomic_t ident = ATOMIC_INIT(0);
 	struct msm_gem_submit *submit;
-	uint64_t sz;
+	size_t sz;
 	int ret;
 
 	sz = struct_size(submit, bos, nr_bos) +
 			((u64)nr_cmds * sizeof(submit->cmd[0]));
-
-	if (sz > SIZE_MAX)
-		return ERR_PTR(-ENOMEM);
-
 	submit = kzalloc(sz, GFP_KERNEL | __GFP_NOWARN);
 	if (!submit)
 		return ERR_PTR(-ENOMEM);
-- 
2.55.0

