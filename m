Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CDCCA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BEE10E70A;
	Sat,  3 Oct 2026 00:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YHMbUlCv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VQySrAB+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF73A10E70A
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:47:05 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692Ne2Io1956290
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VG//oFdfsErBkvF/P9Zl6qRt20SthIydDI5DgQhlbA4=; b=YHMbUlCvA+71nHeF
 cWHRlu1iRBUBxr6B5qXD2rYN29UKxsJ3SUHCncvzfYda9IHPl6Obg3zHOU37FOIy
 jW2xhXRVYmwtGz0kcCUWSmwTIBnoYyoAHbRda1gb6OTR9lly0Y45rvmim7zLdaYD
 iUceoz+jjkBNMv8KPrOslhVfWNEDPInmdPD5srmeqyDBePro/3echzjmBnsikTTL
 oI9Qv9GSYIhdYlLhWe7g6wFdifKazjCwHMePJIu8jYPkwq4KM1LYgI7F1qfyS4Io
 DyRmenDfbnMITXPNPigp9m1CpW9oePdrtWsxZEuoMUD6NOcjk+CmXa8iGJ6jpaGj
 qF5y8Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2j0ks55j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:47:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5ab5c136so12178485a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790988424; x=1791593224;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VG//oFdfsErBkvF/P9Zl6qRt20SthIydDI5DgQhlbA4=;
 b=VQySrAB+8VsgaDOtCjP134R+v1BuDGCtsfvRGt1uiKL8AG3nbhP772ExDJLdlv4/OP
 fODSC4ZYd/+jJWm9MorJjs33wPhP/t7JKAklW0bA0ygpuULp8pThKnwKFJrEU30Cvnfx
 q8bz++W5vG+mWD8R8Ao9eEtci9vEOXfsw2aQPq248H9sVEyOVx3NK2+4pQXvr3cjTPet
 nJCnG5yYQCfMvU+yli0s6vhndAHIB1X5Q+sPCk62AjVL8JVfac6ZevfeKoET8B0XvgaA
 8xAjjOd6V5Bjsc14x+jchp0umF/GZ+vj1xVOlv0+w9aiOwiAonU2YeQFLRwAGNrx14NS
 +45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790988424; x=1791593224;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VG//oFdfsErBkvF/P9Zl6qRt20SthIydDI5DgQhlbA4=;
 b=EuxjNH78ABLsplYz30EIPsSRWzy387BRPNvKyElCpyhx+7yqSmig6FTz8fsEP+S2DA
 CuaQ1oe4B0TrpfU6o6R77FhGueUQAAIhjPSNTBIVKN16JLqeLxwR/slsQb780NFwk4y+
 lLpF2uQ0YGIi8Lnjh5SE1JwoLROYCHiA3b2geejqsIBSC7ZhjlFR9j2S0MBfXchsZo64
 vuDhPgE9KdM3zzUpltGxiWbnrwcb/74h69ZHDqHTuwYqm46ethH9yTFbaJdCFuDUAanj
 qCvZ0pQPB4ybWbBfWeVDfYm5zXqqrTG1cuFK/BXo7Vtc0Y43lFjUH931vElCR2TImLF9
 PQAg==
X-Gm-Message-State: AFuF++kfvCkEr+kZRcOkAKzSMYZeNx5vgwrNRj+xKxz7jED2b8ZLBgnd
 5o7Ub6G+0f/YCzZt9M2h5pFyCnQtpJoTIv2IaP1cMPgaCWn1qqiEo//qiZlVktMYslyUcNwrK+o
 kQ23S8Vwr/YwFvCrVM1PAlYyxkMojlB43bq+UHmwdQJWBBTHDuqX6pR23u5qQBimACG9a10k=
X-Gm-Gg: AYBFou3i/i5OtvsX4RHrD8faucdxmkk7LkoMJiAwIeQUBWT59i5yzGCYSOEl/txwCkP
 70Ac7g6uy/7LIAwuT+RU8vUbpFrIVczNLLzILSz3MRj7f7QGU2fViygDBloLklqrwbEhkyP34y2
 xmiIqtoYdCg6Of858VpePCBVaSdKU26/U5wQkSV/pefGs4UVA/2/NAse1Cig7BOyue+Ku9JJvJp
 V+16mr3t4Oum6oTHBFYYIZrlfAUzlceg7JdT+ZJWr8yGFIJDU+PqY+NHlztvv/c8qreLgpSRBBv
 fpFobbN5AxqkUXseppWc+4Z0KfFsHMmZdh/hEcRQQMpNHnxo2uAQS9uzPNsVNzU4CzBKZRM9hWP
 LieS7zrylWhxhi4p0aoS5C5xgalp1UB48sMOhjqIp+LR1QF2204xAtjr7AvSJh69yY2Edcu6pRA
 HMRiwuMFAhBrN0
X-Received: by 2002:a05:620a:28d1:b0:93e:5017:d505 with SMTP id
 af79cd13be357-93e5017ddfamr265252085a.19.1790988424146; 
 Fri, 02 Oct 2026 17:47:04 -0700 (PDT)
X-Received: by 2002:a05:620a:28d1:b0:93e:5017:d505 with SMTP id
 af79cd13be357-93e5017ddfamr265249885a.19.1790988423717; 
 Fri, 02 Oct 2026 17:47:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c71911bsm1160748e87.11.2026.10.02.17.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:47:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>, Xilin Wu <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH 00/13] drm/msm/dp: Add static HDR support for DP and eDP
Date: Sat,  3 Oct 2026 03:46:54 +0300
Message-ID: <179098834069.3641559.2753228491265144134.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfXxoLCvuWgYlhr
 oZ6cNvpodq54tr9oRigzSVZ/6vsgl9OBqjc5Reo5fh3k8bxrlJytCjFBa1yg0VOzoIBcSoWBkXy
 Shgv9lwwjKHiqB2CiQuSbz7MQNzZEaN1cEo2ndkFT8bihYfVDjVWTZPihridiHqOAM0HUtT3a72
 h928EyrhZw8QM0D/XjZy1aVLngBvwdCwitoL6+EdrREHKJ5fVMLnkN8ATvLicNPSx1mpAMk8Fpk
 bxbz/YaxT7t6AoxONcCRX6iYsGx9M5oxwhUg8cvRFvpBXrqYZJGmzanyS4mvt+qPcArualUl3AL
 awneQOL/Cf9lE+MfCsrC9lHK9cV7Er6JMNKOiERhfj6KyDDKvoGAb3P0b/rBbiEfUdgXW4XICSi
 z1iQ/Qz7k43GMHg4feuptwOThEzy+NcXkmUqa3BCnz1ZVrJWPv1wVHlKIhA/lFwjcixHdycUP1W
 ZncDgQW1K3sAC4s4u2A==
X-Proofpoint-GUID: AShk5YpQFdxhxWkt8DvVSv-7-qE_4Kmf
X-Authority-Analysis: v=2.4 cv=Z8B5j3RA c=1 sm=1 tr=0 ts=6ac05088 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=e5mUnYsNAAAA:8
 a=p6THbNBqQQInXpZJy2IA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMiBTYWx0ZWRfX2UCSYn1MLIfo
 wXRJ3CykmBlx8bcRF5sULwDd++R1JHaRY9UeMPKHHuDhQW5/2iDf5CU1hEuNYyd7YlcBbKHBlPn
 MGMdR5RpJ20u/FJDw2RK22n0tiYwRFw=
X-Proofpoint-ORIG-GUID: AShk5YpQFdxhxWkt8DvVSv-7-qE_4Kmf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030002
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

On Wed, 30 Sep 2026 20:41:44 +0800, Xilin Wu wrote:
> This series adds standard KMS static HDR metadata and BT.2020 RGB
> signalling to MSM DP and eDP, with HDR10 as the intended use case. It uses
> HDR_OUTPUT_METADATA, Colorspace and max bpc. Userspace supplies the HDR
> pixel content; DSC, dynamic HDR and tone mapping are outside this series.
> 
> Patch 1 allows max bpc registration before connector state allocation and
> initializes the corresponding state defaults. Patch 2 prepares generic
> SDP slots. Patches 3-5 establish PHY power ownership, serialize HPD state
> updates and add complete stream enable rollback, including AUX recovery
> for a connected external peer. New error returns are introduced together
> with their cleanup paths.
> 
> [...]

Applied to ttt, thanks!

[04/13] drm/msm/dp: Serialize HPD state updates
        https://gitlab.freedesktop.org/lumag/msm/-/commit/62c6146e5fde

Best regards,
-- 
With best wishes
Dmitry


