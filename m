Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E01EFB5173
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 23:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BC210E2FA;
	Mon,  6 Apr 2026 23:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UxB9+sDH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YY5TbSv/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D585910E2FA
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 23:42:17 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LQYU63402372
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Apr 2026 23:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +FX3hFxbsXLzmQEVBCnMj3T3W1aaATGH4hCY8cpIBj4=; b=UxB9+sDH5/AEHOuT
 ZvIvt9iSxYL7a/BHSVMoTw7QoW4P+LF5vZiS/ANo/t2mJqheOw7XbfgLumzwmi/5
 9vTlO1ZHDK/3E4IL+8ZPJH7pbGy0qeCt34SIsecXl2O170AkSscEd9+74mXca7aL
 1X/dy1zF6K1DZVBbXsRGKGIvyhxTm3qVLAX9CFqm7V3Jh7qoaQGUPvPhyi7LxPnm
 2xqAAKZUgvWMW8+20PlnqpRLO5F6d+9mrSzVuHgIZNXMTEKJkAOX5WFPDiJBqrVz
 uDlN5ZhMJjbMqBM9X/gn89jo9Bcs23rXFEefRXP+B5cIu0FuvyTiG7dscuTHMMw6
 EdvqwQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhr8qh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 23:42:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50da529ff48so1238251cf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Apr 2026 16:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775518936; x=1776123736;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FX3hFxbsXLzmQEVBCnMj3T3W1aaATGH4hCY8cpIBj4=;
 b=YY5TbSv/25Fa2D5P5rSXUPqW4Uw/9tfSxjNQFDb6xtuD3bhFFy+DIQwSM3Y6NvnYYN
 1QT6drbReXTDngPQldIFOvH7Fb358/56gCGvm6eU8GzJfvUl8/U7/saSpooX2LELOkz+
 Ds+SJ8b7bF/gdnHBU7u3iZk3D6XbWqAAyGGw4fzkceEjkFWOc1S9iLMOlLOHgGh5Ta7d
 juinem5vdQhqrZp9XiLwInp7rlfWaO4THsA15WrlT9DLSp3qMylxMP36fYVNrTP+qI+F
 CeIkm9zkjswnygSIh3O/x/X1kQgXy2HXmohqZstuNiNYjcynJ8LdeWs7bXgyyhDGhww1
 mv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775518936; x=1776123736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+FX3hFxbsXLzmQEVBCnMj3T3W1aaATGH4hCY8cpIBj4=;
 b=cWbBTXbLwuEDlTm8j8YPX8urHYRnc59M08Do7E6W+ZRXR4ZG+cqdBodN54xsJz3pOF
 k5XliBMUw5oAD/oQVKTXn7mbqtP8RAG1RbNgL6HUnTSEeODMaCH7dwRF9ozZN3NtlK+V
 rTZDg270u/nIQukW1TYu1335dGgzjMPLdZbYODlREM6WXrt005AXDGkJTRKYm3UzZc+U
 87kfyKLkbxmmBbfaM2zlHsZTiZA5Th2H6HgK9PFlZHYIGra5JiQUwkHur6if9F8j51NC
 zbhg+ZxD8nsm0M85mO+zsamLdLcIYHUosT7GioodGMjA8kqQjpx0fKspjXC4p1DSlrE1
 TEJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKBKy8YDFWVjvYfvtof1WZzqBxqatJO0fGEQxa3/8f7jk64KCUTXZEWCIriFEK0D+EBgSBVfS6FcU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx60IjPuE2xqZd9VJ/W+3cKFgzHbGWv7VxgP+wEoRJRXIl3Zy6T
 0+9Bd0vz20aMlymVHbdh4crdaKfhICxN/xk+7/5pQhFZcLepTy+/2Z9vQjJ/1iuWnQet2T2N926
 Kerxzl26+6ZMIUbk41vRuFl/S8/Phz+teQ9bQ0HWgmxWSJJkrq6OU75jwKCExll8naSmhcA4=
X-Gm-Gg: AeBDiesQMRKmmO0eH5UX6iaMzmGhy9BF6kgNffkagHMOG0DCBDWn9N7EOSMtdSX134+
 Jv9NpXImnb/PUV0MgA65Z8WykrZkljeEFTC3YXzqhMhb/Y8ZMvHi4zzLjxV/bK09+ntZ9r6Y8ld
 k0ECMv8XT5ENH+AzqaHiPSVHQjrVhsHNmxyYlaLEJf9VQUNsuVPqsuRm1StmEK9CmwYNifMRMpj
 fnmw4WFQetLs2LYTDcp4WmXDJGRX0Fdb8QeHmdjGVSA7UCKrqpmxvqGAo+lCeDTV16pE2w/q79Z
 Vya7OSAJucP01erpGCa+IhDo2f7IbMQzFEWBHQXhavPAq4JpLpPfKbkKPcKktcV8e1PEth0vWZh
 fcqyY63PM+tZrVHnGGNbIYiw4BYAO2YvAdgKmEw5HYpfP2lBUyxSNJhP0B9dXnIlZDTp1NxyaVd
 PsgQXUD65snJXIDjL0bfcsAlEhKZ6cJ2RL+lk=
X-Received: by 2002:ac8:7dcd:0:b0:50d:8389:c3f4 with SMTP id
 d75a77b69052e-50d8389c6a9mr132214181cf.55.1775518936249; 
 Mon, 06 Apr 2026 16:42:16 -0700 (PDT)
X-Received: by 2002:ac8:7dcd:0:b0:50d:8389:c3f4 with SMTP id
 d75a77b69052e-50d8389c6a9mr132214021cf.55.1775518935725; 
 Mon, 06 Apr 2026 16:42:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cd217c708sm33512011fa.39.2026.04.06.16.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 16:42:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: drop INTF_0 on MSM8953
Date: Tue,  7 Apr 2026 02:42:09 +0300
Message-ID: <177551403361.616257.17730405730725411988.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325-drop-8953-intf-v1-1-d80e214a1a75@oss.qualcomm.com>
References: <20260325-drop-8953-intf-v1-1-d80e214a1a75@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIzMSBTYWx0ZWRfX4l0KXjf6wF3j
 doJKKklNaCx9S6IvG4zxg5bcad4wAmmcKmHtvjmCMvlw5RtfpVuTmJYP6xU/6cdBWL8566V+FIx
 Z0quGFN6kaZ7sk0CKkRVrpoLfW2/MjlgG0ivOje+TwNoL8H3SKlqbpjLVvvGUt+iGQCN7OMglOx
 WN4QsOBxZ7ZS4wIjka+jshLpJXOY4XpYQMIHw7WHhj1zAGNFwx237qdfoYn1BCFoqWHwEMaYvg8
 +nYaw2cKmPUvDQkldrZzv/42EOZeWAOMwa2p0y9nxaukV8sMMysG/XJo/ZP10jTDK2WH7o3Y+47
 r5nV88nZOte3cxzagI1wf5jmPVYrrT4+mJ2Fsnta+7AYBj1af2BR7NQ1RLJN7xI0PfUJlVIanco
 NgxnpglCcX17ZIJJS/Xvp74PY/UR4pl2Qij9r3ntHdmKWj92H2GP3I+xQeNMhjhD1C96jnzGVWD
 XeGMkZ8OOc/+DOSspow==
X-Proofpoint-GUID: alyCRVXLtPqwA1RIl6moCgnE44jKJUH4
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d444d8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=hk87uI6hEoqpmA19PHYA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: alyCRVXLtPqwA1RIl6moCgnE44jKJUH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604060231
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

On Wed, 25 Mar 2026 07:35:44 +0200, Dmitry Baryshkov wrote:
> There is no INTF_0 on MSM8953. Currently catalog lists dummy INTF_NONE
> entry for it. Drop it from the catalog.

Applied to msm-next, thanks!

[1/1] drm/msm/dpu: drop INTF_0 on MSM8953
      https://gitlab.freedesktop.org/lumag/msm/-/commit/7090420420d5

Best regards,
-- 
With best wishes
Dmitry


