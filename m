Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9D2C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F1E10F8F9;
	Fri,  3 Jul 2026 20:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QK0bT6ac";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kVjm+Uvu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82BA10F8FB
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:35:36 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KQkxN1023691
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 20:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=; b=QK0bT6acctMmVRcC
 2/da5Pd4TXGhQi4kOuWThCPpHrSeU90ccV7oPPbEG/ts6Xwajo54zSQS7shMXiVf
 z90g5tuSbTLKlK0r+3Bpt+Woe9V5rm0OQMqW1zbBFCpaTITAsTBeFZKUTBRXc3gp
 Aw1lsRCA1j+A0wJ2aPqhSjkvjzJMR15gBUCHJhR+RE+axWX3+lmfVbNZqPEIqOgp
 H+Tns85ndROt4nEsfLIYKbPGq5wDmrxdCygCHlpmYqMJLkN11fX2/PAiTyptGVyH
 jjLA5cauqLhul+JvsmQQ9I/SwdbX4KhLdw+fMl+mkNOZ1lGTxKMb0xKH3N9PiM7R
 5p2wPQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u32pm5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 20:35:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso1684786a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783110935; x=1783715735;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
 b=kVjm+Uvupc6IKX/vL+TXLFO4qmRYD5ot4zFqelDdh/l1MgmMPSpBjWVAwMJhhbUS6C
 bSRojhVXxJ+V+LvyYZB+tS+vejWbISdP9nCCrGvHIRahzT5abczAftlQXKOhqE0pMgzu
 t/e7UdyIvspqSZ3h5Anfhq/6+6L4dyXixKJ5B2nTV1CElH1T6Ia+YZIXIofLX/2cHhyw
 DTkOjFm3TGrHVRMtqMxUdBjpveHGVhY9xNg2s7V+UwHwkcJ3SyAGJWmeKtQcjLWWB+e0
 YggVBOjDQ4Hi4iU6QxXLdW6hvzgu2peWjm/GfXixycYq8urtBYsHOTcDzN9VLEQkFRP+
 oxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110935; x=1783715735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PRyyWybhTFXDYdqUvdU9HzDk0XM7qXOARMEqjkTcmss=;
 b=Aw96cZRzHHLQ9ypThORWFrsypvoCUti0S7pZOJNK7mVoecZDdYQmpFZbqVZbx96nIV
 3uBdbpVwlVFdZWv2z/kVPSpKdz7iwDwf7Q2YrWuUOFBbYsAOOgoICYIxHeySAOvaPy5V
 E583Plhirny7cSy5y/OBqAR0jYi0m4E9JE46Arvp5ZzBvsiNDKrQFNto0IUsh/epHjtw
 yDlJfjFTeZa1i4Stk6XtJkrRUy6okTm6o/PkQgKNH7MfSfRTOtiwlE3MKQqu2Hznvo9u
 IYtF++Z6vH/86OZjGgr8ll/MrjAJK+p3ojaMl0jPj4T4jD6a0BFdyI9Yh+aevryH+IUP
 i4rg==
X-Forwarded-Encrypted: i=1;
 AHgh+RosJ3wa/gZM36cqfGfeDtwduVNY6RVgbildFdeToabygJf9qeSUjvP14PGv8iKeX2nmyM4RYmvzino=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxjz1fFJsnePYX7/XUXq6L9V5Wa2aS1Ik+mRqjTOf4tMjXkU3nq
 gGiEhz9MBXfQMxMSlKNYNCECqqNTuD4D0hIdJNb/H+4vJOaUyK4Rc6WSg+RRZLgwtpTFmwggr1m
 VpLdd4D09HUaAYlxd3+JylF/ul8OZ/mUQfgDKjQmcSoY48FfpKGmvodOzMRWCwrJWySqHueg=
X-Gm-Gg: AfdE7ckqosFW9UxIyQpoICUH/RvrxqeVNN9cQYJVcUEdLgaYCMFMwvqlcoo/Au4qwdy
 11XIo51jnm0wMJ4A6G0isrVA+C6AaOOL8Q2Wzf5on7w9l3r6niI0yIvs3U1NRawIt0igfOmjjhY
 878B+r9oEgQyTiDfTK4ZFskp1QnxoBUB4fkAgE8jz3C6xp63E+D1KhAlMk0jnGHEIhlqI3jXpZd
 yacPfo8v7hxINs8KwJsR0e1oCFPBHBMdoqOcbXsW+EG6+2G7bp1/UyiwbiBICJaVrZV2dXDG0no
 J9n9ezOxdiRHXZl1foNAAZGxR0lan1skuVVluCMCo9gLpNVGpcCGB/rjTNu5f+yj91eunRKqRNk
 6+ciWKZKoYqh5vtaT+q329MMWjl5bax6NROk=
X-Received: by 2002:a17:90b:3c0f:b0:381:939e:adf0 with SMTP id
 98e67ed59e1d1-3829fbd7827mr851929a91.31.1783110935539; 
 Fri, 03 Jul 2026 13:35:35 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0f:b0:381:939e:adf0 with SMTP id
 98e67ed59e1d1-3829fbd7827mr851893a91.31.1783110935077; 
 Fri, 03 Jul 2026 13:35:35 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:35:34 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:28 +0530
Subject: [PATCH v4 2/9] drm/msm/adreno: Add support for A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-2-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=1210;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=vmi+IpVwDwItd0JsdKwDI4X0C7GvFEMaBv3VFip4Ixg=;
 b=cN7pn2+JEuwNoT9wv704PT5FWDf0yxNfWzcSdWVP2z7Sjet4xiZVOgeM2KvXBFueaSmGt4kuy
 CcHPa+9lH75CVOuJgzKjvkpem+q3xyNaj1NqF1nIpvU+/j/iI6FWZIZ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: RmJsFVBnRIkJqhMrVNOGHoTKRthSvkz_
X-Proofpoint-ORIG-GUID: RmJsFVBnRIkJqhMrVNOGHoTKRthSvkz_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX3AvuMD6L2r+1
 rjTCWAD+E4i1ViszOLDlEaiHfCWC9BOTS7vKskaDuQb3V/e9jmVCe+leiK0lNbGSRsn1z4AMq2j
 qJWYB+LSV6WBjtrhXP3mJ2s9ZYxrfkE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX6f3Yucn3xHC3
 HnI15M5+6Tf5Bwd5iPyfs2GzWJFRB4jAruVdLJX4sS10pQ/eD5hoO/ENGsER10sbCJABYfrZcnZ
 fEtROyz/r3XyV/lSh4KM3CRGlfH+yxazImvGlPeidc+POZL7c2lkW4rvuIeXg8PcizIhoZjJjEp
 73cY8rmwxfdhbZz7FC5ZffstbVDy6G0lM2F3dCXN8Htx0GF+2ULhkrpIKo8qCOmElz0j+Z6QTzv
 3s5ykNeNYKsnM3G8Q2G2rajMPVBmcmmpOlEjD7ivq1LdB4hLwHkZVQbb5uqSuJkSXCzFWfi6NO3
 6zzwVKd1CkD12S5pAvXg4g3yQaaB+gqF0JOPLstkOS47YbMFZDZJ80xzEbQ9zhyALJMgbr0cB58
 lmhEAze1JFoo8KU/22JZNHWl9UiwcCJoKvIGM0Qfru2mIZSwvc4fAbUDsPG5y9Y1ZtSTvVHQ5LZ
 YNN7DnHhD/36InPkuQw==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a481d18 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=XFVbiEAxaSnpWCc0n_YA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030208
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very
minimal changes. The only KMD facing difference is the chipid and the
zap firmware which is specified via devicetree.

Just add the new chipid to enable support for A704 GPU in Shikra.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 3e6f409d13a2..2de3ab010135 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1454,7 +1454,7 @@ DECLARE_ADRENO_REGLIST_PIPE_LIST(a7xx_dyn_pwrup_reglist);
 
 static const struct adreno_info a7xx_gpus[] = {
 	{
-		.chip_ids = ADRENO_CHIP_IDS(0x07000200),
+		.chip_ids = ADRENO_CHIP_IDS(0x07000200, 0x07000400),
 		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
 		.fw = {
 			[ADRENO_FW_SQE] = "a702_sqe.fw",

-- 
2.54.0

