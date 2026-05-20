Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF02CD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592CC10F0CD;
	Wed, 20 May 2026 14:52:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b/kLwfly";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NtDTUs/Y";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18AF610F0C5
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:01 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6Sue118974
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HGml7biXVVWjOOR6Y1Gdb7Ld32RnBgrsNfRj6o0i/eM=; b=b/kLwflydCkC2Ciw
 kFMu/ey2k8Bi8oimviQ7NY/zbR+HX3YKUz+cruiz6XGpmeauU25S4o0DIROda8RN
 CUbSeVFt5XjXJjAWRogUhATQdXZdz7cyjO0tNwQBCs4oXlcGxwz3G1eEMp8M1/b8
 PrLo7iK8xCg1W0WxqyxKRzWuIzr+ZNMUhcbTt/6Z2E8cJbHq3ldimJTwoE4wHDFl
 VdeFLfcuB3/ojPlRPVHcQRsyieWG0aQDb5iiV9Zs1Q5XXHMRlTegcmInTyh8jWMw
 lvdrBGUZz5MgfumJleaZ991y9hAHslKoqvECKl5iGfFtjJmp1Jwevaxh3nefnqaE
 yTvHug==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee886gw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:52:00 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-6332db4182dso7832002137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288720; x=1779893520;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HGml7biXVVWjOOR6Y1Gdb7Ld32RnBgrsNfRj6o0i/eM=;
 b=NtDTUs/YAMFR+Zi2umNsgChozI7B6EHJ4Zb5MyEmtoQMipfzcMqArXtWNUjME5Smiw
 kVuva8svvqjqx1GYDF8THkwbVK9AqCFQAhgfRWikgffMOEgzItQAQ3gB+XY6XwAX7t2v
 auIVNg9PFQhWzns0VsATNzSEUZKqBo0+qGSECpiISNujbEqI4V/dgJ5NJAcPWiZe1IPM
 Oc2hnUAi+bGK8DVxkLFbI/y3bvMId4LeB5gc0qpE9Qkiw3ZsTSgbUe30f1ThFEmo977G
 ZSb3LF5E2Iy2m2Xm/unXgIDI0IDSfy2eJv507ETUI2z8U9tpTEkcpaaKIgAP820YKVz7
 V/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288720; x=1779893520;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HGml7biXVVWjOOR6Y1Gdb7Ld32RnBgrsNfRj6o0i/eM=;
 b=qgvQw4wpa1ze7KolwjELr5KvivHY/H5ydaE+wavVSOW8bD+PHysyyYtfrDWwm3kApd
 i4LKP1x3S61sFrefa+/c1zNbIVbVfSie7b78yEJAutG/kXeGLiq9bscNclyiWsrZo2pR
 0pLgMj87pMLtyxHScBZq/mrs7ea6J5K5ZF3uu3ubaxZBKWZnXdJhfPyv+ot5mQH3ckuJ
 IRhwhKixu/H0KPAjmg+ceaCjt/GPIxGckp0EOl0W6Z1wGnSY4oBHGjlGheH9avPr0qCE
 Y5mlhGrQX1PRbAX/vnhuYpTzSbcNFTOXdvpO8ycdKbnzxSMj2pPwNbw646UQdxeTdxlG
 cg4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/a86kiacTZjjI/gIMUxVi/XjJuAOSmSwGOmOokdudVXBAK+k9xcTv9BEp8XeNi67QxGfD85J/5eec=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4JdIVVx2INqxalt5qVMHJK50e9sLZ5r2VkmRNzei8BlKNuIRP
 /rKbRJNl2R4BYWpMkeKldqM8TIx2Pz2yEfj/caRzGFfWgHtS7vAF+okwXPdUMLMlW0PwWL3DE+S
 03uOZ4nTrhUFRC1+qcCAIK3URTLYR5Iipqu7zYoEl4x9x4KWVh9Tb58ciyQqsLDnqoFt8VEY=
X-Gm-Gg: Acq92OHJN/wOIlz3fBSTBhZ3UcbHVgVoFMb8bKFJLY184OH/WMG5xFB0LquoQdFeA9i
 lNYFdqC4Z3neWzI5e25tv11ba8naDIxzScw4Ddu/G8ZUx/IsCP7NDeT0WjhDFyuOi/C0MxDELYX
 +gzU/Va5pKQCfB3x45KmoxiYcqj6uiGSux6axjeZF9MLL8MRdNppliybxarm1s/ONnxyaXG1uP3
 LDLPgVDxaXcAk5vWmiP8KWbSrYCLuqt1+onsvdR3QWdmlk0vEgprj2kDFj2havzqjxfv/JgVPgE
 uMFUhlp2qHqSwPygGTbGKBNrt6UMuwpMrFnU0H7dAPBGU6sO4SwLZHFg8zTmHIkImklOmm6+dnG
 rPusZuMMUdZ8tmKeKt/TYOr0BGoUq/wR7ojrOSqnUw0bN8Ry0zSgKHlOAmDbfgv0M/Bif+/FsJL
 Q7OXNIyBSrh/hdCgt6UBMHp/AnBcPSq0EQpCM=
X-Received: by 2002:a05:6102:441c:b0:631:ff40:22b2 with SMTP id
 ada2fe7eead31-63a3cb14138mr14252023137.2.1779288719513; 
 Wed, 20 May 2026 07:51:59 -0700 (PDT)
X-Received: by 2002:a05:6102:441c:b0:631:ff40:22b2 with SMTP id
 ada2fe7eead31-63a3cb14138mr14252000137.2.1779288719051; 
 Wed, 20 May 2026 07:51:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:29 +0300
Subject: [PATCH v5 22/28] soc: qcom: ubwc: set min_acc length to 64 for all
 UBWC 1.0 targets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-22-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Nxn0ECja9MOevPIO6hY4R3LL49hKUqZQoSFEB/QFA80=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpp5YODtCBqznKGqIh3vbdpzCU+HnKI2fzOG
 sBOSSHiqomJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KaQAKCRCLPIo+Aiko
 1XyrB/wPZk4u1D78C0EkXEYvIzbh2sirhfwGmTOoja7BN5lMmcbDZmvSOThKitFA1FvpJIzwfFZ
 hjtVqthVfZ6PKFhTbyOhmpgHRGyq7Sg5qOyZEjy2O+0Rhu2UU8NgXycWS7bpx4pDkKcYsESvdT3
 v+FOmROZRLCrHQFv56m25SjMDLHfCbtKzjhQEfCfJtnMpIIhAvlXsfFv9tJxWySwNfGUu4KFjAZ
 jGgFgLIN8jPfon00rOT1gEr8OJc8FYLVynBUMu0eLnfls7Se2JuS4PrWnU3EEeEKd5c8kshKzA5
 4OKE0Zvs7JGXGcLh2niaxGF6llOjt1xuhCc7HGwW8tSFoU/3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: UJOJ4rjGf7veCpPllpSJR1fOwJgQhjhP
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dca90 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=5ZsywSmvcCt_NWGkcqUA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX+Er/g1xu/Coa
 B1ZKq1Td8Cn4MRemPqGZzul67adtebOlDQJWAAlUs29hnI14UTThV6qOA15rBHSrMMZ43mgYiH0
 goHDDzKfY3yhaYGyOS+Lx0Sv7seAANyCDRDfEqo165cwuMTskZm2UxbkDW5Cmu4XR7Gr95jTQwi
 JAkxZV/GfR6BgirbPKbynLwVwMpVwyLXZQsDg1vEqIbCR0EnXYV/Ki4B+cmO4YJ72RPPQ46z9cb
 ED9yssUyqXkCJwJD2wychGh4zAFpZH10ZxcJYiEuCWvrdTKDU13UdtukfvScnnXqzpXQ4Fq91Rw
 QoeqaAlkBVFlBXjJvUJ0SBk/QD7UGzffBAuLOq6xxnUF9mKepCwDEgASn/4VIDvBOE4LfiN0O3y
 LlCgP8E1RZa5L+qlECvWpsKCdwlpCObJWgRlhgEZV+U3j6u27Kgz0m2abVMrLYzUEG7e0UAPjkz
 nNy+AYzEe/eLUXz7J2g==
X-Proofpoint-GUID: UJOJ4rjGf7veCpPllpSJR1fOwJgQhjhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200145
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

According to the documentation, the MAL should be set for all UBWC 1.0
targets, no matter what is the version of the UBWC decoders are present
on the device. The helper comes from DPU / GPU world, where there was no
separate bit to control MAL before UBWC 2.0. As the helper is now being
used by other drivers too, correct the helper to return the correct MAL
value (Iris doesn't support UBWC 1.0 devices for now, so there is no
changes of the behaviour).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/linux/soc/qcom/ubwc.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 83d2c2a7116c..0b5aa9d0343b 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -75,14 +75,9 @@ static inline bool qcom_ubwc_get_ubwc_mode(const struct qcom_ubwc_cfg_data *cfg)
 	return ret;
 }
 
-/*
- * This is the best guess, based on the MDSS driver, which worked so far.
- */
 static inline bool qcom_ubwc_min_acc_length_64b(const struct qcom_ubwc_cfg_data *cfg)
 {
-	return cfg->ubwc_enc_version == UBWC_1_0 &&
-		(cfg->ubwc_dec_version == UBWC_2_0 ||
-		 cfg->ubwc_dec_version == UBWC_3_0);
+	return cfg->ubwc_enc_version == UBWC_1_0;
 }
 
 static inline bool qcom_ubwc_macrotile_mode(const struct qcom_ubwc_cfg_data *cfg)

-- 
2.47.3

