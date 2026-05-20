Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F01CD5BAC
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CEE710F0C9;
	Wed, 20 May 2026 14:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aHbdFFFP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j2ghQxlK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A67510F0BB
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:52 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE2OQd826612
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YeXGSGSeoUMRQKY4PjIJ+D/sVcYw4EfpKGdbvxvr2ek=; b=aHbdFFFP9TbmyrcL
 r51Iz+KGXnDnQz8LWjgH4KKhm7kHoNo/svoU8sxkInYfWPfOumROZkM+oh2wibel
 JUd4ws5jp5P7FE05LdiBOtguntJr97EWHebgVmO+B9Fbxq/qVrOSqyo8F9n5Ekq+
 zCmlsz30QiMbkz2Yt1PHpTEHWO0btbP0M/bMHbbFH97eJpU178IUlCwBu1ST0osT
 +lux4Z90GbTYKamihMMkRzm4YuJeFyOoOyBclrSi4N/DEzzYIibHy7dkm+2r2dQh
 NGFK2dB/eUG0pNqzQr0yyJiCwjf5MSR7RtI3Vzrt64G+a3H3xXXFDkfgMP9+Jm8U
 ZkgJOw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ecag6fy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:51 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-577c69d3f04so5469345e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288711; x=1779893511;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YeXGSGSeoUMRQKY4PjIJ+D/sVcYw4EfpKGdbvxvr2ek=;
 b=j2ghQxlKeyzbA6B5P7HmRDLavzs76sy0SVxcEjk2Ib4nZhuLEk6pdKh/FNJOpHIJI0
 WSasrfjnP2HVScAR5qtqvfpgUq7sP7fqXbTjkA7ARgU3e9debxHr1OOshkUcKSu3aYpe
 qRrMnHjCbMaqFbN/+QspkJUFQW1cTb/ckjyyJfFhP8nfxc24gXiZ4CAQ2LJRy4LUQi0Z
 r3f4UAiY/fgrzr2SAtuJ76c/HUiy7viSyNIY2i3/PUsk69uNzLVD3ET+6hRKCTB7NDfy
 SJOpJpPYuEq2ALuSJztc/51QOw5YnZUvQ12Y2kjqkLSkGxzVsGiCzDxK5tqTVvJ4UAdB
 O6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288711; x=1779893511;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YeXGSGSeoUMRQKY4PjIJ+D/sVcYw4EfpKGdbvxvr2ek=;
 b=qkg5a5I/2G75q1A1YRIPstnqtuBVP/x9Rm2S/fjsG7z0oyIq6GNAl5pgYQOeygCg9X
 nTNCa9nYLb9uWus9hgcz/3mqExdC34Hfs0L+1qgo94Lg435m9BpeSJnUjA5/adrotRMD
 r2+/5P7+K+BmksWUsihcG/TxET/xWKlcNlGWxCXM80/zT9iSc1k69U9J+2Ciuh7QNG3/
 gwJzWQiVQ1qwDO9lxumZiIAM7GESjKGn2+Nt8Y+/OuoJR23dFRxQsX2y3hqS5UDEEBXo
 SOKzeGD1bpMCXusTXz2TQ7IMUGx57oVVEhziRpQN3AD2yPaWRlJCYBa2RzXrG2YcDT/B
 TQTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+297OPAvLVcEudt7G0+WUybi9h7kQV/PzC4ZkC2XzjqgRpT+3DTzuEQsX4uP6Kn8MBoDhQECb7KUE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzh8wNwd/VtiwvPVk7s8DNfGaBVqB077nyBll5XassAHTywAVK8
 Xg2duoShyNymcAlcJzBtuIi9A9nak9vG3i1h+v6aqPWLBAWjSbM/3NNA8YPCWdpj92JIy4NAB2K
 dMcvutlpEyIQi7+RqLIXWzChkitoUDXxOoHyTmKMlZvBKFT8mt0P1XpZMXgeuHtnrtjj0Yaw=
X-Gm-Gg: Acq92OGS5EBzlvj4WmNAw48xTSo5/5TY1FoI3TI+qHnJwKa7UH36lu9+PF5EZ8xz5Wz
 ba6C0hJlAAF1a+6640V3gewx4cYvr8BuJzLyGkRK7txGhGcMTsbgd1FAWI1d1xPxuOnO/tiW9sy
 LOilh1zRut3ECOl929mIpmn2Zn95xQ7lsSzAw/y1OuS9lS78XUAvVyBJ3ihjiD8ysQouqCrVUgM
 IWXXkrIlua1yBO0feVIC0RkOWpfmQVRN9Cwk9w9ZmKAp7uSnUeBjfj32UirlSYa8yWzUOgkdl0/
 6dEVCm3WTm/c/jh1J4m8x66Vk9+NhU4RGG9svWWudWX9sVmItn3jivjgP9mkFaWhrtvs03+29eB
 IKJkAS6caYj6DXGs2no+Dz7fFeUBo5APztqi820uLcGMk/ixvwyRRy3RgPN6G4aSSSnhKcGuolE
 L0Ov/ve4K/M6Ava3guGJh6Dv4ryu1xpyPBrBM=
X-Received: by 2002:a05:6122:348d:b0:56b:7023:1393 with SMTP id
 71dfb90a1353d-5760c04adbbmr15005072e0c.11.1779288709997; 
 Wed, 20 May 2026 07:51:49 -0700 (PDT)
X-Received: by 2002:a05:6122:348d:b0:56b:7023:1393 with SMTP id
 71dfb90a1353d-5760c04adbbmr15004990e0c.11.1779288709418; 
 Wed, 20 May 2026 07:51:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:23 +0300
Subject: [PATCH v5 16/28] drm/msm/adreno: set fp16compoptdis for UBWC 3.0
 formats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-16-72f2749bc807@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=801;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=UwVvsKLkUIORbtzZurFAWqIbbBEib65pVmAxe/wBnTg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpoZsoCoh4ITjYLrfP7D/p6oAmgMVaq2dyEI
 bBUkSILO6OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KaAAKCRCLPIo+Aiko
 1fiSCACcq93Vxr0c5qkcZviyqS9YIR9v5nVgibape0QZdC2E8mWm0n7XbJVGelM/7pjRv+22goK
 2bzp00kLkEOoBkGlWT+EpNoTd1v7+BDYYxD7S0vkF6LndQbgbh9qHLEMp/6IVXRMinvIlLDLsxa
 PFxS1AX1VUkUqoKhENMIc9kt3xPCwEmbWBvpaW9/cWTn/bZGuKA9dxew4mINUO4PY9cMmjtqTyz
 6omgFgniK0OrO2XIfrmOhfmxx49QAK+B07xz9eF9+TM3rjoYgfAf+nf+fC0SwZVf+drK9HLZ3ss
 Iix01Ndu4hQ/U220XtaNaooOg10PLNeX99e0J3ZuGB1PzEp9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: qOf5A41wHZ1u0SdgJSo5vjTVIuW6FJtt
X-Authority-Analysis: v=2.4 cv=WqMb99fv c=1 sm=1 tr=0 ts=6a0dca87 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=CoZj-JnWnDGe1ZqNdgAA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX4YlwZ1XlEX22
 nKh3iWOPP0UM/xJ7aq+AcgcmN+W0jIL1qpCi+6VKOxCI0DZXrpv8MFfMHQ4Ay6uIhGw5nBt38xY
 2sAcb3w+JH0N9udthPEKF03ZherdJpgh3dIjVx3ajZBRll8mnRRWKgyimLpKrCIT+0yKTfydQRK
 O8ti0gTTKRr2b7fZD55/RSWO4fe/CAWag8o0ExpyIwpJPdxUckyVRt19VwkiFScs2K/1xJGHarN
 3Oun1sqH+u0TDy0/nKdXPLGQrwslQcH/jbcrVA5Dj9lpJDjzpuinv5iUMR7tu3IgH+jGIJMylBf
 PQQAsczzPrsdRzTYncfFAvu5EjLvscQ1C6NySPq5NitlW4ryGu7pMeoBe4/thEvNdmr1fUeyOHn
 DXaUzPcaC3v8BxPEgor54GL9xWPpTB2n2qwCtBikd1ds5cX4pxqyGdWEtqPQA1Ym93hT4UG+Wi4
 whxPsIZ7lkDhIb+OmXw==
X-Proofpoint-ORIG-GUID: qOf5A41wHZ1u0SdgJSo5vjTVIuW6FJtt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
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

The fp16compoptdis bit should be set if the system targets UBWC 3.0
format in addition to UBWC 4.0.

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 7a6223ddd8cf..867c7d05f670 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -303,6 +303,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 		break;
 	case UBWC_3_0:
 		amsbc = true;
+		fp16compoptdis = true;
 		break;
 	default:
 		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);

-- 
2.47.3

