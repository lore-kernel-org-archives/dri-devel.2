Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5E9FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3EA10E071;
	Wed, 29 Apr 2026 08:55:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eZiNcvG+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Aet8sObl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FEFA10E3C9
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:55:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63T8qc2n870134
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0IiUqcsSbUFeSqI44l0FUgFlUNzldUc41Ls0DEJQw1I=; b=eZiNcvG+jfL3M20i
 443BEuTj/iuq5th8B1fCFuGfqCuVEszl4Op/iLHEbzi6Eox3R4Rql7Kg1x1FA3/c
 scRe9MqUh5c7SAJ6Gr6IJ+XFxIAdyi+q5kMiFMkTgKNmVPz2ZINsjjzfOQ7UcUwj
 EBO1K+L8FEluZKeaAfRVaTWxHdE4sAjG8Bh6vtix/UWU54H2kb4cm0ywqaHOKm93
 02pJFpBSAWQ6ChsfsACSRABHQfXooMzJtXSu90N0jDg8xVV8vZVuBxXqGeon3tkq
 IW1EOsK2lG8OT68haSrH7LDf/uE5WUF6gZ5PhYGg6CCtGfs2ANyCMBjPiHU16Zzk
 Oac7NA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du0u1u2wb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:55:39 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9568c79b893so715708241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777452939; x=1778057739;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0IiUqcsSbUFeSqI44l0FUgFlUNzldUc41Ls0DEJQw1I=;
 b=Aet8sObl0g6vPBHjHpk0VwRpamOobkkiplep0TVeIIZDENZBeBSnSpMjH/8CQr5rM5
 P8YM2A7H/ZDhHoEcqIHj/UQK6Dvxqd8RBVab7Y3K5LlZm3ElFLRZ1z084XvCDfOiAwFZ
 02I8S9p07Za0B/0QGtFyNHSev1raKmYuGQ5YkTvlV5tJqOAV4Eb7zohoqN16o62cy5L7
 hEHb31kglC38hfp+zTvENKbD+P4xlQaR/bS4xxUXDFn9BkY8o02Arj15+AxuJKKmOpsu
 foC0cApnBe4eCx11zGq0FP2snrg1/KsdtlDlRIWeeMDOUp0UtZjOWyaxGP3rHhk0b1Q8
 I3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452939; x=1778057739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0IiUqcsSbUFeSqI44l0FUgFlUNzldUc41Ls0DEJQw1I=;
 b=mzgXcBPILCey4SQbVO+1qDWttUGeN4UF9txCMmJfk2pHjNWtKa2iVsxdbepbCYjkEl
 nQO1c9budEqn1H105Yt0Ak9uTZYQ+besc9vKhGiEqxgVyVqSYvy0Lj2xEl2bDd4FVcVu
 yYcmFid3JjfuCvu8V8ame9WC1quFW7zWx12joYYV5WoRLEodgjTklCrRUs/P2WISZdY5
 5RVGcngVuBrh7UopQa93fQwt0Xyb2m0QKJ69h2KwijPqMu5RQw1TM4DkPXYhf3pDO3Wx
 cruxc623Y7KPXYfjuB6kn6s7HbRaRuLHa3woUYefGbGW9Rlt8VWHyA81aDftME/KMRxG
 orFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8L0/Mk5RXo0U37FEHjfO/AsyzP0eLaedRTcJTQG372ISZRseCFVUVlWMtzCdA+GaAGqFmD8Ipe61o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2lBlAG5dfTEXD6Rv9ChEXkYVhDpBI4BvMhQL9oAD3+EqaZKFN
 D+kM1rEVcNs9alo347JzjxK7hgp4C7zuoOE1bOLVtpnt4L3YA9MCeeOU0eIcEosDe9SvpeOfJSd
 GRpj2FktLZdQQfdTYBYfawqKVG4UldRaydzmjcu/aI486q4rABESsUHlZAAGF9wcwpPHI+oc=
X-Gm-Gg: AeBDiesL7rJOa6nKZ2p5GJ76KxWyhVKtxBXwcpcBLBe4S3evKlXpktH6kezXpT9v0e5
 kLPxX0YIOvO8PoKoecOO/Ml4Q7VwDVoRmpuVO+baCSCbwExgWPurcozeaN0+sGZADpByzY+vcta
 FYZWpcrvKi5ZEWcb1n8WliSNUPAy9OwZF2B6CjOKctIHYAiEb6aeieM8bbBtjVSWRmlpXh2KWcL
 qz4pwbiDXlxnpxSa1kz/pjMCkMaO6aLBdChjlu2PktdMLbJAxrFMwygJ7AE9OPxzi3heDdJCf7+
 LADmCyD4O1xNCwUOO9YEuvlR5LoGIms+jcbpd64RpAgVkstxaj4thphCVIt0sBkh5zIaAwnWe2t
 TnUJCfrRdgQnH72Lbh1nEoRrhEukgfpcfIpxrrzlWy6VVSsqFobtK/TtYfdVsZ17K/s9CsShBPZ
 MHco22C0DWJYLzAg==
X-Received: by 2002:ac5:c985:0:b0:56f:8cf9:33bc with SMTP id
 71dfb90a1353d-573a2ba0fe0mr1301874e0c.1.1777452938748; 
 Wed, 29 Apr 2026 01:55:38 -0700 (PDT)
X-Received: by 2002:ac5:c985:0:b0:56f:8cf9:33bc with SMTP id
 71dfb90a1353d-573a2ba0fe0mr1301862e0c.1.1777452938311; 
 Wed, 29 Apr 2026 01:55:38 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb98593774fsm61116966b.42.2026.04.29.01.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 01:55:37 -0700 (PDT)
Message-ID: <e33c2b46-d65a-47a0-8595-b2d42dbc47c4@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 10:55:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/dsi: don't dump registers past the mapped region
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260428-msm-fix-dsi-dump-v1-1-5d4cb5ccfac7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-msm-fix-dsi-dump-v1-1-5d4cb5ccfac7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: W_gGppHq8U6oew2Nlo6N-of5IpT1KpOS
X-Proofpoint-ORIG-GUID: W_gGppHq8U6oew2Nlo6N-of5IpT1KpOS
X-Authority-Analysis: v=2.4 cv=aPPAb79m c=1 sm=1 tr=0 ts=69f1c78b cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pSQ9VKN1VO86L-afhjsA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA4OSBTYWx0ZWRfX57pUy2K2CajH
 Ap8a1U0IC87BITA2bLZeymeF5dYXfaLipcd1QkR1oCjU8ADolMa70oDJFusBd3Kb5HIl22gJabl
 JpOMnf8i9MKrpEuChILn7bJ5QZOYxKR95Pfx0Gc8xCiTrMi8R0x1hK1cWdGgabg8igLxW8UN5d1
 VUxIWTwtT58y7OyRinPnWRCPDiD1Ir7G2XjZ0uwA9/9BEWLTegiAm5/gE3B8eGDXGz1uSWfKeUi
 zksnsdBlLnD9VmF5uplJLLy57Mf7z8wlpiQqO7TFhpygJSwMi8MJCV09JzYpiqGbj8GXb13Z9Th
 cv+C1KQ3Uz+vMa2+Uxy5mOqcFYR/50XyoBcz8Kt+Pq9XYo64BFSoHGAH0V69razpCPra2iLlLQ9
 bHmVzpBmHxNlxBE+7+Ifygdp6zrtj2nCk1/TsPBNleNbnwVrfYpcZFl5KRO/XSIF0O/r0UABV/T
 LjLQW9Jm+HYA0CxC6CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290089
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

On 4/28/26 7:21 PM, Dmitry Baryshkov wrote:
> On DSI 6G platforms the IO address space is internally adjusted by
> io_offset. Later this adjusted address might be used for memory dumping.
> However the size that is used for memory dumping isn't adjusted to
> account for the io_offset, leading to the potential access to the
> unmapped region. Lower ctrl_size by the io_offset value to prevent
> access past the mapped area.
> 
>  msm_disp_snapshot_add_block+0x1d4/0x3c8 [msm] (P)
>  msm_dsi_host_snapshot+0x4c/0x78 [msm]
>  msm_dsi_snapshot+0x28/0x50 [msm]
>  msm_disp_snapshot_capture_state+0x74/0x140 [msm]
>  msm_disp_snapshot_state_sync+0x60/0x90 [msm]
>  _msm_disp_snapshot_work+0x30/0x90 [msm]
>  kthread_worker_fn+0xdc/0x460
>  kthread+0x120/0x140
> 
> Fixes: bac2c6a62ed9 ("drm/msm: get rid of msm_iomap_size")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
