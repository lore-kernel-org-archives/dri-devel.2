Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D535C5B572
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 08:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 608C610E3C0;
	Sat, 22 Aug 2026 08:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y1Dt1mrG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="es0xfdzC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0540410E3C1
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:49:05 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67M7xwWg475136
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=NwPcLGIyQ2TcFXPWJo+/PU
 HE35UurRlilrmlN7QREiM=; b=Y1Dt1mrG9ogBjzJJGRftXHIvZHi5mBTxfznDiL
 vZGEhEsUhDDa7AgHpyk3Wo/2Mgsa4q8XCSpxTyg3LgOSwBJSe0sj22TOaqBa5WuI
 CsV7UeOJV4hvoBF6mQECKphWcoLSKvHpVeR3XOILMhR8z6FstFu85FYijZtJ6WgP
 b5p/qYh9PMWeBy7GfqQsRrzTuPtUP8gD5FZ+IoOSjH3oByfDejxNIsDc3xK2O9Jr
 WtVwhQcCjTpa87Q6hNlkNsrf2BoEKGvcO2StqHWYhhugQFfLIRzMuxYb2QfJRGmb
 YQx7OT7dIDqdBuGOUykDCNPK2QWz9Wph0lkz6pHkoVVAUbLQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g740f0p7b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 08:49:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930b6bdcb4fso259696985a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 01:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787388544; x=1787993344;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NwPcLGIyQ2TcFXPWJo+/PUHE35UurRlilrmlN7QREiM=;
 b=es0xfdzCCggMYAI12Axy/x3zYyeAtnyE0BJcZDtu2ngNlDMCpU+iDNRC6Yc71dQdjs
 FFwwaU8eqSl+MpG/u3xq86wyHzcXGyWdOZUHGM+FwGv+bipEYu5Rs9jFIb40j4k5nJsv
 1uZiOgssNCbICb0xaJesBLy8+fp8f19qOo8XRSbFwSwjHbpI9Zv5ivqzh5FvR7r9Ma+K
 sGEOrjBYtGp7sCR2gfBv3C7LgpqTXVyuXCkexjvzCwlXgZOBqoIx2HDvgDbB/wRoBppf
 nlLfh2T+R/xXKyPEqBWKZ97Kkf9iHkTKsc2OLw86vjdd3OKb8SsZCokvVIKBzQp4ofV1
 fF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787388544; x=1787993344;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NwPcLGIyQ2TcFXPWJo+/PUHE35UurRlilrmlN7QREiM=;
 b=WYXY873fzKZ2P26C9yW+LFywgWfwylef+eAzp/rlaRgxgUSOdqVxrdknXKQe2JU2nN
 bTeOJO+KCfCzGkoRLPgvqt4mzKB1o1jZBP7m7gyxP0iOR0/nTRVKb4qihS1cmrwpAOdJ
 ld6SXx3rNCerdgSRMjeIW7SKEaajvOszBwT0hRzQ4pdjywtFWXdz/fBXAYkdT9ThzObC
 eB1a9ByuvtII9V0EIfi+k5KOOqPxVzFp70vaTgmIxuUGXzKYYX2CRgYRVncsL5iXuFQk
 hTWQm9CkUhkpxGdiPVC/PZ4TKGdURVrCDC3AjM0XBSZx5AWRq9BxdSbmmRbOJuw/R3GD
 QMbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGAOdYinhVhb2/5yRIIvBxp+uYYvekF5GkKxU7tliYeQ7RLVM4XEqMRn4CeaPzOzBi9mGYPYu1Cpo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mV1AtaYe0PksXFCCYp/tgu/BXpUQldSqNRM8wPRvuS9pzSUXrS
 c5EFm2NTEI0krVTvUWqHM/Y9EVQRhb8ne5+pElx89r7RnBTzQeA6ibuQiXlxAwdESWep4WB8N3V
 C5diKMp6VBXYLVg/3hNe0u2siWtm9LgpinH0i4CqVd7xWxlxuxoqo0v/sJqFIo1bKu76VU6nMhw
 o6f+kVBqPP
X-Gm-Gg: AR+sD10ng9kWFypNRhPqBow8DMWNel0ZoWZMayDMXkwxcYBOmCYMwATdBoWt3PeAvue
 J2ht4xmoGTndGI+j7Np46Cv7lcaj/ei6P9TXrtqyeaT/+uJwf86mL51wS1vi+lH13Pard8IMLVD
 ekdELZu85X8t2/dIPcnkmbF6QBp5aOHEHl0xUqP5pIiIcvF5Ye2ccBp6jjy4Lu6Jioz9U+wR+he
 hXWPFGyWAGaEzpXwWbjQnd28jy1xAWTPjcRxaU1qGZukFvDlEdThSH4wvknaj7kqj5Em36/du5N
 ejmXvtwOCRgJl5kFWUuh1J9uSjNIt21YZkgF9PApHe2TQJt0lBVCRrHKdGEVp+ZEwQJzeo2rWwI
 6Wd7wF8xZM8+Q0wugnaBMSX0XE/bVb5zRhkkceAGT/IEo55NxZydAfwiS2tXzYzB2oYRTTi/CUI
 HVuGnGWz+NS36m
X-Received: by 2002:a05:620a:172c:b0:92d:e54e:72d9 with SMTP id
 af79cd13be357-93746853dc0mr385201185a.1.1787388544179; 
 Sat, 22 Aug 2026 01:49:04 -0700 (PDT)
X-Received: by 2002:a05:620a:172c:b0:92d:e54e:72d9 with SMTP id
 af79cd13be357-93746853dc0mr385198485a.1.1787388543783; 
 Sat, 22 Aug 2026 01:49:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a1c2fab887sm3066901fa.25.2026.08.22.01.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 01:49:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/2] drm/msm: fix dma-buf sharing on targets without
 per-process pgtables
Date: Sat, 22 Aug 2026 11:48:57 +0300
Message-Id: <20260822-msm-fix-export-v1-0-917b3cbedd43@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHliiWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyMj3dziXN20zArd1IqC/KIS3WSTRJPkFEsjY8u0ZCWgpoKiVKAs2MD
 oWAi/uDQpKzW5BGSKUm0tACWndQxyAAAA
X-Change-ID: 20260822-msm-fix-export-c4a4cd9239fc
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gOBJwEPeMtlwt03L/ZfhjBd5plqQgtTbCQTqt2MDjRI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqiWJ8+rA9THoLWWDYiClPFjbEoXu+P6VcBYxRW
 S/lXQCfckGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaolifAAKCRCLPIo+Aiko
 1fdIB/4v+MAHJ7Mnaap20AO8FuUibmxnVbVSJejJoLD2Ge4r2qPuAFLIT+1bZB7hrNrwxr732Lu
 rITiRoPqTLRegf56mc0sKiiTMhv8yJ+H57xTZYGd+qMcwoExVp7ccoLAA55wHppiDS5lZMgf4cI
 Retr8aQ9A3frQQ/dLWPcW1TXXXtNR886sTGiCz7nuQP+Ik8Wo56K3EM6GCWKL/m7dEp03Np4qSY
 y/o6oy+WSUqMrKZalsvXCBsfjmASuA04jD2ez6wZvv9ZSaJGupyljANEqtQwdQwoBbsycmHu+0m
 UNVIHUdl5S2tMJ33IoP1DwET9GRXkMo6cg27jDMslCGS9d2x
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA3MCBTYWx0ZWRfXzDGxlx9NLI4c
 Uejgv72SvovxVh/UgPcg8TFiOz6qBJszF0IP5TSw3O6vVlmoLB3aFirLty44zca4CpeaAm8U3J1
 FsmeWrFXDoRoEgAOYHo/itfduYIpFwtt8Jw/KQ9vo33z063m7oHXqfMxh7mWLG9fRVdd1alEe45
 Q1mQ9qFcY//6lxPT3iBBU0bXVnQUsbID+3hsKaSR5gjuPjTpzt5tX2CMBuVgOuJUiJbVgOuLyh/
 PaKP/Bs2ZinflunoQcIB/1QWLlg6fySeNZDI7ObvP5pS1RtfGC4aIKjkVpNqw7Lg45MCZefsq4C
 oWEBSM55iN7nyJK6AJwNKirksw3qyGHrRCGkR1pV67URly/VRoP06bmNfgbr81F4WKUosk/5wxk
 CwuqTFiPaScyCBq4EBQ+67sCRl/EptfR+g4z9qn1CMBVz13og5DA0kV7BRw1g9z5kZKqnIFEv4F
 PrL0MDV51QnGVzLHVsw==
X-Authority-Analysis: v=2.4 cv=BZjoFLt2 c=1 sm=1 tr=0 ts=6a896280 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=wJ2JNn2w0yijhvieVxkA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA3MCBTYWx0ZWRfX0QBkoYWw8rBN
 E9ooxBoTgWo7e5Qaksew/U6XEzOGAfA6vGOpCrFKfXc/A+gjdjmnMkse8BlsinVvL6rKTMenKKs
 WLZsn+HQrd8IpZ0z+plQa3+emeakqSg=
X-Proofpoint-GUID: yikKXXGlcEhuRGQEjxjD2PUHKgnGZy-j
X-Proofpoint-ORIG-GUID: yikKXXGlcEhuRGQEjxjD2PUHKgnGZy-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608220070
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

Targets without per-process pgtables -- everything pre-a6xx, plus a6xx
parts where split pagetables are unavailable -- hand every DRM file the
GPU's global VM.  The rest of the driver still treats a context VM as
private to that context, so closing a handle tears down mappings other
files are still using, and frees the iova for immediate reuse.

A dma-buf shared between two clients therefore keeps sampling an address
that the next allocation has taken over.  On a530 this is every
ext_image_dma_buf_import sampling test, reading back all zeros.

A VM shared between contexts needs the lazy, refcounted teardown the
driver already implements for kms->vm.  Rather than adding a second
mechanism, the first patch makes that machinery reusable and the second
one puts the shared GPU VM behind it.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (2):
      drm/msm: factor out a locking put_iova_spaces() wrapper
      drm/msm: don't tear down shared VM mappings on handle close

 drivers/gpu/drm/msm/msm_gem.c | 45 ++++++++++++++++++++++++++++---------------
 drivers/gpu/drm/msm/msm_gpu.c |  4 +++-
 drivers/gpu/drm/msm/msm_gpu.h |  3 +++
 3 files changed, 36 insertions(+), 16 deletions(-)
---
base-commit: 6b8c8af514d739d0335f5579b585e02babe8a727
change-id: 20260822-msm-fix-export-c4a4cd9239fc

Best regards,
--  
With best wishes
Dmitry

