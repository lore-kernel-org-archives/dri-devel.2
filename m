Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE4DCA5FE3
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E54C10FA79;
	Sat,  3 Oct 2026 00:30:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HeR+XBB2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wipx0XJh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6C510FA71
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:30:55 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Nf7sQ3187836
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 csdoT9oCeHS//8bD/6QO58rYEQChTDH1xyFYL1OZaT0=; b=HeR+XBB2BmtkTBMj
 kgKUfe+C2kJgo6tREiNDkLKkx/IsXZcvDaPPSwb7J2IQJrIqDbR7ALHjVFB6wL2h
 5ZgSI4/g2iqNancJaT2vAUujFJQrFhOphvsuT7leUBJ5/mAzqbtvBUvHFj9IRcgz
 eJa5gXqQsFFpSgTAMSMr8vZ6UAt+pTnYDzOPp/ToHuYO+55IrQf5JnZYvXydLy9d
 RK2R5DFZu+89L0jVBHGs74gwDuXMTaFiVmy1qtudZZabF+rE+73krJJsINlwljJb
 VQPTyOAdlcvRNNMoWi1ucj44yoNVqqvTOgHq+V1ze6VOLvqYLMuMkHUsEGP/gO0Q
 ZMA+Ug==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh4v3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:30:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91786869e8cso6786786d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987454; x=1791592254;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=csdoT9oCeHS//8bD/6QO58rYEQChTDH1xyFYL1OZaT0=;
 b=Wipx0XJh0gGTUYBtQfpcbvs4s/P6uZnVKEs/OmIe+jRji+9m1BNLc6fMlk1sjHFMJT
 IH7GYFP9DHnpMPB02GW8o7p/Bsz04FQ+qc027/B7TqeCGuaoUbaqQekPPRBYbOHqhmPM
 RaEDNNBpo6b0anQ7ffyex4ms4HYMZdC1luHhW/CGOH4gPQcAvHuQPpy47sfyCdQL3BWU
 m2lxKWlCqRC/+ms+Fah5hKLWzOsqqPndmPrnEW9MNOq2kyzy+YiU6ajDlCO2pEwwE49n
 AOpNVQMry4F7TjdXaIRV2C9yTT+BEfN8yxv3ZNsCzk453dh75hJtOCNs48uadbP8/Pdg
 gP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987454; x=1791592254;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=csdoT9oCeHS//8bD/6QO58rYEQChTDH1xyFYL1OZaT0=;
 b=RJvrVAKaxk5QD8h9BXP4Wv7YlWeGSPCavEd+dyQ6M/Ek2OgYNfp4bYl4O5qm45ywOe
 AVjkP7N1y8tkWVTNr2b/YJxM0oGiYy21GhhGNGdqpjsnLhs17D1g2hK9RKSCPjAI4uW/
 EzYJw5Yzsh0br+1lWi7iPE9ggLpYRLZVpvrPh2zy3PF9Y1G9I73sblalPUfusVlep/wY
 njJwy6bvTLelxolx7pY0qs8ejc3J7VVc7xSb6zzFM3qhm2/MBsRK3VtUCMiTBPhWlxEC
 4rTEaz7/3ImljqrnGsVRSiXW2Gy/PcBeGsxkMbOIAunjtvWLppJ7M8QbaO96v9hWPXE2
 I9zQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwE2fLgqggueg0SFlStbEAcJiTObJB3X9m1UOHaOj8N80WIfHrUrrfvx0DAREeTBZitpp2z9vzbUX0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nI2Kh6/XbojrpeWo1Lfh01tmaxwDwTk9adOhBNdmtnfsWMg7ip
 KxCLLtRHvYMKvZ4a7s9OJdAAcLsKSyc7t/w2vJQvwVGdFAXeoY3drf0EGQ3sd/kmDJPj1GQYVPw
 0EStcWtJJrDVArGnjD+alESoL2DltPWXWvTw+9I6gkuVXMXA7I9pfybir+5PeBvR2UMEw3fk=
X-Gm-Gg: AYBFou2OYPTNNYKPgyj1cz3GFwlZgyTlzjA+8mfl2dLXJI0RtUv3OX6sddImtNjldvU
 ZnyeEH6XZ/J6NBvKnqGO2DjVZX3GXX5r/W+sZDgeyVo/MBJOAdpzjbBYmZL5w0Z/g7wSjAUc7XR
 GxlG8apac6uHSL3AR4fJUL6/CP7lPW5zcJmBMx2hBcquqEEeoRK0dVkdusfhBqeg10QJ/NcCdtb
 0TX9r9xa7+jq6MV4ZQ2IxE4DhNQWai4a8RLofyKML1RdGDEvZIaDvy1dFBClPMGdFHWuF4d44zI
 bb/e6tXRbY3OSQaRpgN1PQp/WQO72gBfIy80L9SnlGodHsxe4jXgsI4E53mibYpr5LSoVvC8BfZ
 TXzcZGLfB2jTNA6F+Atzn+TOAN8wSSSk9fATEgCQmAFhuCwvdFeFMn4DW7HvjqSyBBIa3tE7m9K
 WHhgCDCle0NIV/
X-Received: by 2002:a05:620a:c4d:b0:93b:d79a:c463 with SMTP id
 af79cd13be357-93cf19eaaf4mr853843185a.59.1790987454124; 
 Fri, 02 Oct 2026 17:30:54 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:93b:d79a:c463 with SMTP id
 af79cd13be357-93cf19eaaf4mr853836585a.59.1790987453473; 
 Fri, 02 Oct 2026 17:30:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7957d0sm1133979e87.31.2026.10.02.17.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:30:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:30:25 +0300
Subject: [PATCH v4 10/10] drm/ci: mark pixel-format tests as passing on SC7180
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-fd-kms-fix-smmu-v4-10-2a44d4d8ac77@oss.qualcomm.com>
References: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
In-Reply-To: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=b0Cqqqr5RXysOo/IlbQaAaOsD61faw7dj63ogkvFqxI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEyeHIY6JzEfoBXelvMyLt0GhJs6WBbfmyToW
 58gCXsj33OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBMngAKCRCLPIo+Aiko
 1ewRB/9QMiXQ2RF5FMkCqo9388QolNpWArGRtwxcQNexXbptnrnXbm00so3tPbGHp9Xe3sjFZSM
 fgu9EO31fYY8UGT0wvdu3RULeDPfBKUhDpRwd/nf4N46VTFoAQrO9JsU/vBhssPtNfqOFIKVJ5E
 xiOpFshhoTtTaPOYEAsGALFlAAt5lts6iPFP7nQAMs9BhlPm6H3EC+s4uAIodIUa1JDOgsMtX80
 SmkXeyHpmwJAUq1X7hlr5BfAQS7Y+XBSHIptqwVdLKug5Gv48nZiB/2NyebBfKt1fT+9E7nl/Jg
 FFoOJx3Korh/Xzktb4+AWvorIaHh1HTaJnBVwBI/4beSwuia
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX/+9eHfpoUk1g
 LYO4lxWzZrHXqD+4SvTrhJXaI2hL0t/aW/GDc15kGPwT0dw7mThQ5gjlWZgih1LLuYejUdFSKiM
 N0hrcVCW6052WTPVKr3Q7vujFvYkCzI=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6ac04cbe cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=_1_hEmUK9n4M9CbZuSUA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfXy1l5Nd0VjCWT
 OkSz55vRpisEX8oSG8+VEuRbt5ChpfmxafwOU8fODcX5tWZXw3SidAEyPLsxD7AgwEziH0z8vTT
 NphJNPPLlVonxcC+wHI5ko61FykOh/zXyqIRRJHlRT00z4BCBzkmJVtnxSZJIgana2fKhkvpymj
 Xdm/l2q8z9Y8ST0+1drccWpXXIRiTQam4GbwYNrB8eF8A2boBzfpsiEv3OYZpxEnqytxIKuHcGY
 0dgYnUhzNbjxmPzCEMyFjCjEN2acwY3kAxaHbF/s+LP/hrI3SUGRuiUt9qWz2OVQUmKL0QQ0iLB
 0aULUiPA8zomHzW4O5lWVOMb7kBBTGQyu4r03yYoYGOvBk+7X63TKb2MsI2ZU8zB/Thc8x3sPPx
 ws+3aJD6fapdWtLlxS9WhKv4jBgSOLa1UauELlSCHZ0XKibkMnagHVCHEeyy32MqAK3F4b8V2yd
 sPkKZ0Lyqgippht4wRQ==
X-Proofpoint-GUID: dj9ZoH6sw-ol1g-TzbFFRBD-BnQ3d4ZA
X-Proofpoint-ORIG-GUID: dj9ZoH6sw-ol1g-TzbFFRBD-BnQ3d4ZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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

kms_plane@pixel-format and kms_plane@pixel-format-source-clamping timed out
waiting for the first CRC once the test had set a legacy gamma LUT.  They
pass since "drm/msm/dpu: only reassign resources when the encoder is
reprogrammed", so drop them from the expected failures.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt     | 2 --
 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
index 2daf4ab879a9..ea3013faa37c 100644
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
@@ -18,5 +18,3 @@ kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
 kms_plane_alpha_blend@alpha-7efc,Fail
 kms_plane_alpha_blend@coverage-7efc,Fail
 kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
-kms_plane@pixel-format,Fail
-kms_plane@pixel-format-source-clamping,Fail
diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
index 2daf4ab879a9..ea3013faa37c 100644
--- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
@@ -18,5 +18,3 @@ kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
 kms_plane_alpha_blend@alpha-7efc,Fail
 kms_plane_alpha_blend@coverage-7efc,Fail
 kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
-kms_plane@pixel-format,Fail
-kms_plane@pixel-format-source-clamping,Fail

-- 
2.47.3

