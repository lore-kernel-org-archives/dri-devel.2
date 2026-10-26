Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8B6606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LP/truvF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jmgj3m0k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95CC310ECE0;
	Mon, 26 Oct 2026 09:16:29 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54CD10ECEC
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:16:07 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4arIp3303602
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uaZlVt/ieNnTy4lKgdgeePVaxkhdWiw1YPAbOzp690s=; b=LP/truvFDk/rQffz
 yVuRh62lx8QD5jnKtVRVhVoai8OxoYkoaC8QH5jMbnmGV+1JP3SDgwMqR3PNY52T
 Bo7hEBO+s+sVhxb9fRgxbMiLYFfOzyjyu/Mcputw7abLiT9A0udkFXaoh7qBBCiQ
 DFPVLVYR1jYXDeWwH3aFya5CB+RXVUz0lWY/hZZEXx+1Pf9ckkNyXBHIcFXKZFiu
 +Z80vH9u7ebRvGr+8TPl9Gt6+RCu4LcypuUooY6/x/iRphdNbIDdAMK/KCZ73iMR
 t3p75X0UntWaCt0jWXbOm7OBdYF1phf/xTzk3/5B/9gHa26L5a2ppEH/2gtkEjol
 kJo+/w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkmsdqw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:16:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1440e081so35203485a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793006166; x=1793610966;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uaZlVt/ieNnTy4lKgdgeePVaxkhdWiw1YPAbOzp690s=;
 b=jmgj3m0kO7RcV0IoDl9uKH7DQB/PM3Ntk797muqiXWIMB/WZT5YtXZ0YyX23EmwKUt
 80zgfIHb0l5I6M+t7tzbS3eM4BjxNz+ebbIBBMONZuZBwArHrr/7UCFggeWAX/5RPaPP
 /dEbHwmRKWwrKkXwCNRZ8zqJGP/dTfXPT5QXmDbrtK5KILMRZVtsswszpY6cEY4aZX0F
 uqm5kXD/2GoHhmMmkzPlt0jUfp0D5iCFqzcn/n/byIFQhejPEZfNPArkpjnCO5axxJPV
 LZy4HrU5NqZfopNtC3SPrF8ZYqlJSksfjfYA2hj243XYmT6PkaqIrRLG5nd3LMfdOdCG
 u0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006166; x=1793610966;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uaZlVt/ieNnTy4lKgdgeePVaxkhdWiw1YPAbOzp690s=;
 b=rmnZJZl/XrMLmSt2CyKNjxgrMbgsNUZBqxuDHZXYNXkXfsTv6InBNlRSN6N5kwDnng
 aA5+6g1CAoRHedROsmGf+Q/BN7ift+NfDqpoNxExDNuxp+aBCKrDwV5gCTtGsH/NLfHj
 yAh6vRjBF2JwHaFfDi4syv+UT8EXLfIPw42K+dxATU9w9IQAriC9adlRUF+TEKpH/1or
 fWMR/v6qnQirICzoCoADMMurcN31sXVfRa4iJCBU+WMP3lrvytk3NCchmB2DCurih5Vv
 91MYICv7a25s+MLiYXZNwgGg64Q7ACNp+eNMBdwE3ufG92GV9zAtJUoogQ5cfu+XUUC0
 /MOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMU2+SQvBP1+HoaR9C+FuuleHXngXlh2UROQEtjB8EfZqUP0hmgygPgXXwYtOWan1gGJmS3s9b6hE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlMA924ivYzsb5sszWOqW9sIVLnjLj1CrXupAEp6kAq2FR7lVD
 tTlv0trZIo/JJIuFSgxPEDu3e2zMntiZDlvON6aeaufL2XSXU1Y4BDxcTvGPu0J11FDuP8BeFYj
 zjz/X0/c0gqqu+DGxbC1oeIfJaG9VDq14MY0HkyXSKRm7g9EXIc+2R67xGkBXWuM+TMvSW7o=
X-Gm-Gg: AYBFou3OUeo26yS0ohB570mxTZOYN6owrnMEmQccPK+CJcoy4dlGnvxej/hmEfsyyAM
 PPF0jp+zVwWF/IbB/M8VHPOTfCbuWtk8SyEJ2LHuHAAebh4arAuZ3ji3vHUGssj9jZUzKzaWqQI
 5JYfiyuKSa3V7B9MEIbuXFktrUWB+5g/fnBAVRZJutlod4eST9TKhiMw4Bb3dmyvYrwpZhDR1hg
 v6YfD9o+SrLxa/gb6VjQPuIvW4/Rok2+hen3H0IxyKWFNdUiR4h/Zv7A7EcDmPS0jfaGWsOtXBt
 NSkb14meqD0xnM/dDtAl/Ym5MeOiaB3TQyI8mUb3L5TTPsV46XUsa1EvlanR4LCwNsz1nwqZz/C
 tSFiRqm0LUHEjgEbB0DFGAQ==
X-Received: by 2002:a05:620a:6e9c:20b0:939:8148:1e3d with SMTP id
 af79cd13be357-940ef81147amr890597685a.2.1793006165665; 
 Mon, 26 Oct 2026 02:16:05 -0700 (PDT)
X-Received: by 2002:a05:620a:6e9c:20b0:939:8148:1e3d with SMTP id
 af79cd13be357-940ef81147amr890592185a.2.1793006164980; 
 Mon, 26 Oct 2026 02:16:04 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4459711d2sm3285541a12.17.2026.10.26.02.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 02:16:03 -0700 (PDT)
Message-ID: <b5848cd4-bd3f-44b7-ba8c-5646f16670a4@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 10:15:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] drm/msm/dpu: clear the DSPP pointer when no DSPP
 is assigned
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
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
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
 <20261024-fd-kms-fix-smmu-v5-7-a5b0b284aead@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-7-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: XEk4kmXslLrMzmGGI2PQiSxmuZwrnjFv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfX7PfpQ+Kuyt0i
 ii9FOv3f8kZvN5PArH/U7wcqdJTcc+cJwGie4P0vHIOUGsBzvEK28oKX+5d+6CMYHHQVAwh07t2
 aiJFSWJCdDc5PfsDKcDOwCWUOLSN5FubJpsLjxjw6ZqQ1+jcHf23R+ibYpZL+rzY4qSkmWIjC1G
 Bvo6tX5q3nBNdFinT39NyZdGrVvH2VJh5o0a545m24EuJdv+sbqXKDOPYwnfOuAYVflwMwJ/Ahu
 FxLfKhBM1M2hJtP+xHnM3/iDv3XQhhuXrzyWrCeetqPfz8gvqO5aMjWvS4yKM4hsvHtAU7mouvU
 +SrxgVdcqsO9eM5+j9WqL4V61sYbI9P/DsWPmtaoYiIMdYhBQHue05MnZgO6i0QvW+aZEh17Rmx
 UO1y2Bclv6QLOvpWGVQTTFLb6+EUPYFiCqDY66v/KdNe858air3z6kQz0p7bkwna9Pllbq/dAqY
 gnaahEaXAG91kahlM1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzNiBTYWx0ZWRfXyIYaCU4VA26w
 WoialrjiAK2VDmgxTJvKGoVlVG+CjBb3KWXazza8nGfMq7OXRzRwENDOtHky06BtCxeQ5+5g2GA
 VjXQCBnjytMzZSMUxjPWqBcUHYQnyA8=
X-Authority-Analysis: v=2.4 cv=UqX2pOwB c=1 sm=1 tr=0 ts=6adf1a57 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=r9vTSbpwzgrkPjDRepAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: XEk4kmXslLrMzmGGI2PQiSxmuZwrnjFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260036
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 1:25 AM, Dmitry Baryshkov wrote:
> dpu_crtc_assign_resources() only stores mixers[i].hw_dspp when the new
> topology has a DSPP for that mixer, and dpu_crtc_duplicate_state() copies
> the state with kmemdup(), so a crtc which once used a DSPP keeps a pointer
> to it for the rest of its life -- across reservations which no longer own
> that block.
> 
> Assign NULL when there is no DSPP for the mixer.
> 
> Fixes: 4259ff7ae509 ("drm/msm/dpu: add support for pcc color block in dpu driver")
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
