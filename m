Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67E2CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D72810EF5E;
	Mon, 12 Oct 2026 08:39:35 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DE510EF5E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:39:24 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8KnSo1593601
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XVUoLgw50wiXKmSauCJw+oW9dk2W0d36IZAjmGS1EnA=; b=nOxZY9bVEcslPexO
 /+2oxnw9SLhb8czQEzGDJQ+9CwLaSs9zQYATncW8xQJZUGUebUNcmqEt8d2IRFNK
 eWS3saHtrEnx0T1WiT7iy8TBODk7qaLSPXaeHPUKgmANfmxtRNoDOkAiAgrrWDYq
 i1c/IJeXe+BmKdwCXHaAOapuep+6AWnNj+qVPFouV+GsxxOcocIHvQrzqPNMBYJM
 zRfmP3SLZBzmXQGo3azaPK0KuAnaj/iwFPtnh00LZVlnOcVPj15ycmWB7VASI+Ey
 Knu5DfibtyXzNIGBVE9PGAR4SZxggUtlTwqB+YXf/eRAqp2mU9CWyVfNnok8QeRz
 2eJ8Zw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sgu0tgs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 08:39:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-533962f6bc9so3972301cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 01:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791794363; x=1792399163;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XVUoLgw50wiXKmSauCJw+oW9dk2W0d36IZAjmGS1EnA=;
 b=jaDZdusCorqKlqa9HBrBK0IfY8K5E6n6hkAmrlUWz6Wx7Yxz+Z3afM6SrfCI5uWZKr
 P5Ml5lO8o2b2eFmfvnnQSQB/dlSiPJBUYuqqwlLXDaWRuqSe8G97M9i0Mu3cgCbjEs6J
 RnO0m47mkSa1+u8TqciUUtHdE1Px3ubfWy+ql6MXpqfh3jRnhpQQWdwHB14uOvUON8Vi
 CW7Sfi+kVsZm80dFj8cRm6vo6Q8avFBg1hK5SGomWiCuRwfZFCRXjRE5rCY+Orl9PHYd
 VIIlfGiPJo3hAY9fLH7FjuyvPgdP728FmB5eRdEO8Aj4N2Lzgqa3GZX7MgjjuZgly2M3
 3RTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791794363; x=1792399163;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XVUoLgw50wiXKmSauCJw+oW9dk2W0d36IZAjmGS1EnA=;
 b=b/IjsttLQpwu9uMY4ilTp4zQ3nZ6yFh6InXrxO/hgmT6HuhDHm+tIKb1bBsbHUNkHG
 hcewotobrCh6I0CnH2ugXPQ2ogJ634E7h8Wf5sFlE4EaoR2pLQ04wI6SZqyi74x2jbkB
 zrtDpsLk29LBLeofdeVgS3+n8HY5LW2yzOBbWzfNB1mbGyHd4w/pS6tlWvBttKjc/N4L
 LSdLjeh1JFlgCZjuj3PjnaokzojPJPVPC9VIqGbLb3/5E0KzRGM3yx/1xWsf7EPXkdnB
 +FkGu2RTKES9KVl0cj2IzBppUWz5NwvnAfXlhpIr6lVMOqKwKNJwY78QK6Hj8X8hSJZV
 TLHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEFIkx4gjqkv0Mbk3B82pkMcyiFFijBkHZKc9/Hy327invVDSd2st0JCCT+EYQPQ7qzJxD1tsi/Hs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIjSRTDn0d/wUBJpEtO2ZZRtNaAH0+4si/rOLIXd2paUWHHUH9K
 UWFHxLnLQPaYA3phMWfAbHJQGdF3e5ERECTTj+qqnT37lfmqT20OQ7UUHYnQmw5DtF3qW9t0mRh
 w/I7NKnN6+MZO8DP9yYKIoIrL1PXSAOopUNuqcrM/vGMhouJOivQe6Z8j88Cz2iehuemegLE=
X-Gm-Gg: AYBFou2luJ/RQ7xImSwKtO2gxYhjnaNjk251AAlIqC15LUWW71Dq90ajiLjF1TmGcv7
 69LcHBGUjztqHQb2LbbS6X4RfS3P51rQ8F6K8pe1n1hIGmQYu9as2sESMzrAtEmH5y4ufCHCFhN
 imOPV/sjIlPY3BOO0HBlESKdgU8g5st3bzuy7rvR/Eisj9Zge+8JNfaPds8HMSmOG0NxlnUW07L
 Lk8LdcRFkIPgsA9ppiVuvhpeboyOD/UbNFD1fNlB7RdkL51Vrg5vMNmtBqUFNhhhjbrlkcbP8Iw
 u7gNXk2aS7lxWjujTtklhYdVuzQKr+G1HOk/Y+FSNbMw5rcnRVCFTa9r1vknh8WCQkKoRAKss0z
 b/2TE7SJhwt2xuI3RwMRU6Q==
X-Received: by 2002:a05:622a:110a:b0:535:1a6:6e93 with SMTP id
 d75a77b69052e-5359f4e01bfmr173143861cf.2.1791794362654; 
 Mon, 12 Oct 2026 01:39:22 -0700 (PDT)
X-Received: by 2002:a05:622a:110a:b0:535:1a6:6e93 with SMTP id
 d75a77b69052e-5359f4e01bfmr173143561cf.2.1791794362105; 
 Mon, 12 Oct 2026 01:39:22 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9aa8257sm434128866b.60.2026.10.12.01.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 01:39:17 -0700 (PDT)
Message-ID: <cb263594-15b7-4d92-97b6-e0d08e3d7c61@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 10:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/msm/a6xx: Split out a7xx/a8xx device tables
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20261010154125.726149-1-robin.clark@oss.qualcomm.com>
 <20261010154125.726149-3-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261010154125.726149-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QdzzLcbv c=1 sm=1 tr=0 ts=6acc9cbb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ysXiB3iG8gxY7zNvRuQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX4byFpYSDGtWg
 uKer16ehNmzDd2uJzHgc9rGxai9xQ83D36xkRXLVxz96cNtd2QHI1SRmuKLOHQyRaZkLu9dXLi8
 CdH13QPdyLRROmOK4Ijue9Nxllq7Tfs88r7OyE6qJHAAdZdr8e9A/wdIPrYheKygS/pK2UueJyt
 xUcteaSOo4OV0MlklJdzPTI5Lp01rj/t6y3ji41Fj6TyL/TQyBYnVeB5EdlD4YYFQjfatH+rcAt
 I+sRJs2Aq4HDxQajvkR75PV9vT47mwNRQteuZh78cJSdGGQGawZJ6nJwWfgB5pZ423blCu5qoq3
 wDyjovpp+UXNzyedmMkd02bX8KdP2zEiVCx3Eu4x3rXqSdW46t908Kv8iLPnYoiui7njcwnw78F
 Afuh6aLFzXKs3mRL50KKB9FXw0weDikJzoIZZ0O05DQXTsuO4h4XLNzydGkGXL3sIdVBuggzWd4
 TR8PDRU+FX5F2zzvFaA==
X-Proofpoint-ORIG-GUID: 5YwTrqenOwAkAqhWDcYDWYnpqIK9w_q_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX9Hve0NHpa3Ib
 xif/SqMJhoj5aJUsM+iB9oSUvM+8gFOVFHsUoRo7+bG9G2vJe657NMdnED4fK5D0lPhzNdo+2iu
 ATemZ36ir9yk6MgtQs/P/eCJP5qBvTk=
X-Proofpoint-GUID: 5YwTrqenOwAkAqhWDcYDWYnpqIK9w_q_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120034
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

On 10/10/26 5:41 PM, Rob Clark wrote:
> This way we can start including generated tables for a8xx GPU snapshot
> in the device table (without having conflicts with earlier gens if we
> eventually try to retrofit this approach, or later gens in the future).
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
