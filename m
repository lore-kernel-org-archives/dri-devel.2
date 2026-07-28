Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B285C54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8784610E2FD;
	Tue, 28 Jul 2026 09:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SDQlRKRI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bi5P8uNv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A44D10E2FD
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:26:13 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82N7U2318446
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=fnIH3WbTdhyMXPyCfbIebbCFBNPAjwd02tb
 c+TY94Fk=; b=SDQlRKRIgtB7kzRA2fjMSmeP8FXVb3D0iNOZbRVhhL45apXOT56
 d6Ewv3bArvNcRqsZc/kIrIpCE/un+IbTHaUlOSW7mYuIlAmzWqhfuB/IjzMn+pny
 XstC1PMJkQoIvOqoLs2U2sfvXQwyKJBF53jfg7TO4aXW/ByvQSD+VKE09rG5twML
 n/nmKkGcn+dMVQ69qg0MG4DQjOgC+ilCuebfQ+8qiadDrGz3b1voT+zIPJmZFvrT
 wkDMgKksXbhBrAhcGStAQ3v7lCrTK3Hfbxlu3PTTX/NBnfLJZ69ekErSXcRwkpyV
 a1lnrZlpqMGO2Oj9j+MftY1MglLhWG75TpQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkm1hr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:26:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f27f49bso349743585a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785230772; x=1785835572;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fnIH3WbTdhyMXPyCfbIebbCFBNPAjwd02tbc+TY94Fk=;
 b=Bi5P8uNvBuyEIQi3KFYh2Lu4ZcKGIFojNEqjuO9nxo8HdDr1KFseH5z8v5dPa+NJw/
 fDjJ4Xwg9+3Ru1HS/H4ZzmAZLnHYx6l13piOKKgT7eAYLBRl8E6LBd1LYZs0HhEvSQCq
 upHaNE7/IV3ucllqyE+ekiR7/it+DTDiUpPXp7a2bk6Q0u0hTDGxEAi8u79w7/Rh04Hj
 yceBBiQY9nYLFIvxZt4bkKGN155IfTVwt57/4flF85foXZoSQX97gavjsV+HBN5WDOdS
 HUKxErim8qVRI9Bi1f3jD1i+fMzGwtMbsZoqa0G/9R1I4TQh1xHyEtlRNEagjmh2ccxx
 jSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785230772; x=1785835572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fnIH3WbTdhyMXPyCfbIebbCFBNPAjwd02tbc+TY94Fk=;
 b=IgyUaeEIGNOuKzMdlpUsP0pBPZ7oiJPFgIdff1eZgOUouucVR9p4ANh3OghA1sfKCx
 GtqM7gQYdsAO/kwxHuyJQjIGB8HwoJ8x6vBABTcpwM1nqP1uVG1N2320k0L+WVae2yBD
 d0GkoOjo3W1QQ4gNr1UKLShOn9b4XOIMIR++Tbn+cd/Y2nDfPSZFixiPmaBTjGDtHG3x
 Og8W0WSov9+ElMGUA4sC4EvvNbXPMk7mbZNdG3xGjaCL/UU8Ldg6E7wxhMPvvTSAJpBW
 A4E09kum+cFZLHGf85qNe2m8lQlgA/antVZw5yIopK0qbUz/5aaUXQyBK2Xpw+niyzHP
 ZqEA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2APkDnkrih4fKobnGtcJcSfKAbrzlzjfstXoIpZb0ppbBpQLkJpahl0zC3btUmdRZT5pWYezesJk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1r0lVEBjUDvlSFb+UBNOKzoqRRisBGX+40cr4YiKfSXhNkM8h
 5Yd0K2APdD4dO62GNhN0VtmhdErIe/LEVqn/S1sOLqbkRFe32wszM26jjbUoL/HjYsNLnmA/CtZ
 7STpnWWhJLBgOm1biwTXkvwFCYj5y+8ENtAVdCQXnauq06CdGPlyOpi2q4WBcFEf+cp8KhcY=
X-Gm-Gg: AR+sD10iiRgAWnGGjakwPDakM17bQqloeuTQyGhf9Uo+IZH8OrfKQczHB6zHr/VT+v3
 L5vqJ3qp6uBfp3mowJEbPNrNDGs/TwkqxX7KM/eteHSPAL5viTXlaDy49xB1+wrpUnbBdJCrfXG
 +1CHR6UTlese6Xm3ixcTwMfWzqmdoKITK8gvwidLsT5sWWIGaparMS6okPW9Hd1N5v8qDwKyefl
 NHUwZgdKWFT37XYioYJx+wzw5Qxu1aHRz2jy4/ZrZDhImz4tqSKOokMa90A9qyUTth7HR5/X7Xw
 q40W7Yqn2ISe+xsC3b8t6GdCx0QNxIp1j2YsOaYZtAC7JyJVH6OLLl2V9gT6avuU5b/uXBHja/v
 +riKAB8nw2LxkN3KYNMw+yJJrzQNXatf0jkCI0at9QbUgVt030CkWaHdXJx3RFOTXxJKodqsbru
 AuG4zn/lqyrmbHtY4=
X-Received: by 2002:ac8:5a03:0:b0:51d:deb9:b0a3 with SMTP id
 d75a77b69052e-529d7198d17mr12090771cf.84.1785230771718; 
 Tue, 28 Jul 2026 02:26:11 -0700 (PDT)
X-Received: by 2002:ac8:5a03:0:b0:51d:deb9:b0a3 with SMTP id
 d75a77b69052e-529d7198d17mr12090491cf.84.1785230771255; 
 Tue, 28 Jul 2026 02:26:11 -0700 (PDT)
Received: from shalem
 (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32a79c59sm746487866b.13.2026.07.28.02.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 02:26:10 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/msm: Fix stale comments in uapi/drm/msm_drm.h
Date: Tue, 28 Jul 2026 11:26:09 +0200
Message-ID: <20260728092609.22049-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Vx6gpXRNPVNcVquiN3ZABMx0AJoH5aNV
X-Proofpoint-GUID: Vx6gpXRNPVNcVquiN3ZABMx0AJoH5aNV
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a6875b4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=q0cpryLMvERTGWlQnhwA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4MSBTYWx0ZWRfXxhN8VjPQ/+Uy
 d3Z+SkXEb6pbw7UEhAL3vyDC/tN3v00Z6wH0WPeiyKwrd+cKaOW6KVlrz1t4rudm5bSnJnDgTf5
 NDr2RUhN6BbsKCjnBt5b4TmORXPDklbZBolzcvHvkRxrL84/cNE0SFw3Ec3/ovi8KoKu1W5zmgI
 +4n+4bYqshdgvw284QK2PkvwhGgB83I041hIvbP+2h/iRqdYYDRciyZAjF7iMSF8djMU7O6MsAZ
 i2D5NX6eaRUjhXXZGhhrAS2QYNyCfBH4Lo2TzA6egeDv8BF45WuKa6DPdfmDpaUEURPccLiwp2k
 k4oLSc7xp2kM5hADIBtXkgJAiOJWCydqQr9c9Jln32w44CgIHSIiANwJRdbYaC5oro/B/6orp+K
 eE3y5lWPWDevWdZxuN0JTm1kEr8AvBumRR110HaMp+Nueb1y5xRVd3P5C4hHTl6zQcILcrlAF5n
 ZSJAk8Bi0M+finx8URg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4MSBTYWx0ZWRfX7V9YefUXJuKs
 myyaUEyHO59jqSkxfvxr/DeSaPbFWoSvb5+btQj4Xjle/poaTCm+c3LRDE749jn8kO3WQiuuJGY
 jedeRpxu6DdbY4BcxJedRTMuwaYBv7o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280081
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

At some point drm_msm_gem_syncobj was renamed to drm_msm_syncobj and
MSM_SUBMIT_SYNCOBJ_FLAGS was renamed to MSM_SYNCOBJ_FLAGS but some
comments still refer to the old names.

Update the comments with the new names.

Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 include/uapi/drm/msm_drm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 7f2e594be4eb..3d363f12f66a 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -228,7 +228,7 @@ struct drm_msm_gem_cpu_fini {
 
 struct drm_msm_syncobj {
 	__u32 handle;     /* in, syncobj handle. */
-	__u32 flags;      /* in, from MSM_SUBMIT_SYNCOBJ_FLAGS */
+	__u32 flags;      /* in, from MSM_SYNCOBJ_FLAGS */
 	__u64 point;      /* in, timepoint for timeline syncobjs. */
 };
 
@@ -393,9 +393,9 @@ struct drm_msm_vm_bind {
 	__s32 fence_fd;
 	/** @queue_id: in, submitqueue id */
 	__u32 queue_id;
-	/** @in_syncobjs: in, ptr to array of drm_msm_gem_syncobj */
+	/** @in_syncobjs: in, ptr to array of drm_msm_syncobj */
 	__u64 in_syncobjs;
-	/** @out_syncobjs: in, ptr to array of drm_msm_gem_syncobj */
+	/** @out_syncobjs: in, ptr to array of drm_msm_syncobj */
 	__u64 out_syncobjs;
 	/** @nr_in_syncobjs: in, number of entries in in_syncobj */
 	__u32 nr_in_syncobjs;
-- 
2.55.0

