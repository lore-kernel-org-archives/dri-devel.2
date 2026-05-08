Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14695CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 10:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2CB10F3DC;
	Fri,  8 May 2026 10:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Edcdzhfa";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d8VRXPFX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 774A110E30A
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 10:02:33 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6485ABq42199545
 for <dri-devel@lists.freedesktop.org>; Fri, 8 May 2026 10:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qn0u2rVFSmOsPw9dKW2MjjRKtDspoihKo23AtaIa+f8=; b=Edcdzhfa9YeJJ2fm
 kPuf8ifwD735IONFXJN7W1dMaBgDUFYb8vIVJQ9fUCbPs53BXwoLtdtvYueP8ulb
 j8Q8zaUoWw9ekmlhXjmMbb7GFbSkq7xzA1P8jZvQz31winjEIw0/quuz+J7eUozS
 O70Xa/Ouyi5UofdpWvRj2x7uaxFM4bqaQg32YfD0xE6MkTPEplcjquVULFcwjP8C
 kbcC+4VL1oB6NFqvm2DgW2x3qUGdeGVfMHSzrWtV/oP9g+l1auvlpRLKEu3GgDXz
 T0vNEStEcI0DM9gJAqFR+GxkqnRXa7wehlcEV6Snf1scd5P05TMHjNfcPoKwoBpf
 6/jc0w==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e119sjruv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 10:02:32 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5753c3390b3so225200e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778234552; x=1778839352;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qn0u2rVFSmOsPw9dKW2MjjRKtDspoihKo23AtaIa+f8=;
 b=d8VRXPFXlYvfciSjTnZesJnLhTRBmK7eC8BvYq1Fly8TUK3e68QgqVT1/RnaeqBrFL
 1Cv0rrNnvOZhMvTaeXDKhicWjUTgR3NQAN8LV+Biz4UwmxBgcIgYzXSuifvhAHwv6pVC
 h0WU6ZWgcVH/RNSD2Aqu4ICnmc44czrt6VhM5P0wQjtUoMX8TNmPx/vNrFOH0LTtKvyU
 9SDN0kyOKjter9nGjTF2ohBUDe4kbASZZY0aoBzIfhAtqgZ0bztFsTX4+jMdHXuLcgKI
 9WXvUa+TorgMhXDGL6T88sBL0EW//LeYxadNiu5ZS5VO1hrhJEqgqNBMYYgVl10To8Nu
 gUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778234552; x=1778839352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qn0u2rVFSmOsPw9dKW2MjjRKtDspoihKo23AtaIa+f8=;
 b=W4P+YBzNpLw43J4JnZUWKKyZWg+ZnuXwQCUTdRX27uxuRsJxrl6cnyI04HIorjYXiG
 kNMd/HdpLqouMBqYVy5gGx68gJhg0/DEvR+D4Re2wyiH/wfefBbytg6wB3bS3KxdoD7a
 nWGPIHx0ONnXwpb/yeR/5TvqCNik+owqz1/XGhVjrcLquHImwG6io3rqcptyLf1b70jT
 m5lr8fZ9OrjAhXTTGydhmbZyBGeLoY70XH0Cbobyg7QFIs9E3kAFoYSdN9x4fH8FeqHO
 VS+15r6cXU1pd1ZZzVEVBWNElWSmgkz6cq5ErPTCEX5dMdAmW/HMzxeBaDjKls4W7b/j
 NTGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ87TufMORbVtomjZT2N6uf3d+yHEYhj0D+4PtTnk6mfaQqydboSD+ZFvwFXALWZx6XKPbQ42qNJtSk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWTENTWafA3sDk7vOOW+BBif5LwMRhltRMdzugXwwbbtlwiIim
 aqRwtlc0Oq+ZhoMJuUdFrKW/mR14c8bYrww40kXSO2H0J4qpICZuL6GXx5ftZf9pPH918WD+8IM
 2ydtfXZcIiPXF+KFuxt9ZqPXZIo/8qBnIYPX3UI4ik0COF4As5eU+ucKCon643UpHxABCRtk=
X-Gm-Gg: Acq92OF5vMGBbjeBgPGPDk7oTlxQR90KnZ3yUDAO5HxtaZe68Orp1L1DSBqzdowDEg4
 JUBfglrhCHOz/p8zyY9ju1SmZiEnpgzzhCFywvHsVsO8B3SQZSY5uniBWOM82RbDoh6e8wfYHtC
 odcRtB79oDFTmeHhSMkY4uOUmbfTZddMTxsELImIh+WWmhAi7XkXyqxxJzWI7kMMjTEHDx9QGuT
 ZavPPFR2HVL3WRgjPpn00pO4imyV140HNEMg3GLaULowmDkjP14jDYxTGDx0tmhc95gwWlixwuA
 19sBi+RtuMMPhDv9i9bChyYWLVEHdQkIKh8nkT8C5KMDxYNdzDqm/3guaXihB/1cYCSvAxWQwAM
 rD0Rgsa74A8bbVXPzOe604HS/WOHODS2Jgsw2Me/oVdDDwS721u+4B207YdvEPTglfjViEI74mc
 OUkVH5tWG0e3bsCw==
X-Received: by 2002:a05:6122:c215:b0:56f:7eee:1914 with SMTP id
 71dfb90a1353d-57559508f4dmr2276995e0c.1.1778234552015; 
 Fri, 08 May 2026 03:02:32 -0700 (PDT)
X-Received: by 2002:a05:6122:c215:b0:56f:7eee:1914 with SMTP id
 71dfb90a1353d-57559508f4dmr2276959e0c.1.1778234551403; 
 Fri, 08 May 2026 03:02:31 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcac48381dcsm62814066b.54.2026.05.08.03.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 03:02:29 -0700 (PDT)
Message-ID: <9c1b044b-f7eb-4ec6-a201-1a1aca19e68b@oss.qualcomm.com>
Date: Fri, 8 May 2026 12:02:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/29] drm/msm/adreno: use new helper to set amsbc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
 <20260507-ubwc-rework-v4-18-c19593d20c1d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-18-c19593d20c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEwMyBTYWx0ZWRfX1EIirgoBjdlj
 +kj+qEkLX35u5I5wqVyjgVewlJy80UY52XcFD73Su1tzTyy6JutnHwcaSNkX6TskbE2wf0FjzpI
 0jTtqxELR08kVZ2wASHZbepasaKza2u0cvc74sz7NFRPORYyKunE4NdPi7gTUFSvTPQmczWO/K2
 ZHCjPaerwdFTS/KskmD94IUs3ytfa20SYM4jKTKWkKVDjq0ox5e2TLzd4r1OEnW9G1h/QVR8SXJ
 BmwV64e2G+/4KnzMf2AYBeDAEqN6qlEysfx3vcsp4qLKc/m+p1RSnUrTn5SZiMYghQukHrMWkDk
 jGjVD7xNV18wPj0DRva24XsrAPHfg067XIBQEN8ocRrnHynnlytDsobBcMtG1fY4VrWYgxuJ8QZ
 1RIYmDESHn2lVHlSyx1swKnXUqUDmPb6xyBH3Ew2w+9JM8Ba9xRUNnDBlGThFrgWAZS/EXWQyba
 mLMm11o5c9/NgCHF7aA==
X-Proofpoint-ORIG-GUID: k4sKqr1WB8alVSEnVgN-YnKN-O3Zk396
X-Proofpoint-GUID: k4sKqr1WB8alVSEnVgN-YnKN-O3Zk396
X-Authority-Analysis: v=2.4 cv=Dd4nbPtW c=1 sm=1 tr=0 ts=69fdb4b8 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vz_rfR1X6w8aG-yi8FgA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080103
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

On 5/7/26 3:03 PM, Dmitry Baryshkov wrote:
> Use freshly defined helper instead of checking the UBWC version
> directly.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
