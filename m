Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963EDFEA837
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 08:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC5DF10E838;
	Wed, 25 Mar 2026 08:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n01fXQBB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YiPZfBhq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F4010E836
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:59:16 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62P4hAxr2340459
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 birThX4xRYTiUjDh/VakZgxRYC/a1HKA0k4xAl+tawI=; b=n01fXQBBBT/as8ur
 XU1uQtnR+rrA2yOpehml5WjbkdPaX7b3n9fVatWbiegkDXLCpoi8rQM5NThQgAq8
 kes0hWEOI2GV7vlCRD6mYYWzFblcvo4oRfyXu90d/PFGxqD/mEcnHdxCgRw6ZhNY
 SFn/IJ5VBsTkhubeKa2Iqbk8Y2pS2OIgB/Op0amhgf/Pi2z12UeOSC/aBA8m54up
 J/o22VAyCpYhHZCWcUvvOWkP5AlsZ1/enr11xCSlUqFIuEfxvRugvtNi83ynwLLL
 JEaSU1CqJd7r+g6llowEpt2xgb81XFwzXSNKIgdyv7qWzYvnC80vgKguSdU7B3Gs
 4MtD8A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3sw449gc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 08:59:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b89e37e2fso914651cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774429155; x=1775033955;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=birThX4xRYTiUjDh/VakZgxRYC/a1HKA0k4xAl+tawI=;
 b=YiPZfBhqiIHPmEl3RlnHqTIG671rSvVnQ8i9JpBuQB3MRZMSsMoVnymXadtrR0u/+x
 fuR5cM/44VWQXjytjMVIsIqSePkTRYDcBL8cJ46Ffgz0+SK3YEg7mZuAYINLv2w/smOk
 BNqCeM1dvpP5SjbJi8GmTAJBCRk87OJjaaowULy66UAI4rKr793VtdQ8jdfOhfCe3/Uu
 mlFdmV24QmUylPHpgd8pzJD29UckV9BAUpZdRd9GvufRyHkUCwLQH25i9oQEgGBfWp5l
 FKL94c7nJFtT6c0x+8AUbdeIr4rXgtGUdZWUgt/qfqxkW0A3H8w5Wyp+4/76KOuaMGhl
 Q7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774429155; x=1775033955;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=birThX4xRYTiUjDh/VakZgxRYC/a1HKA0k4xAl+tawI=;
 b=nrw+fQR4GsDdl2/PpGFTnDo8wc9sOvwpz5EfdcLddEsJ/olUq74LCPPr0APRyIc0AG
 s1cWQXEtHt0ewDRQF18jEhUfHS6sYmbVomIrywFnlSPzpAPxTJ0dFRY3eU/rIRkC3Kfs
 8oHPxaM9xHXqXHAEmOdnvjTjnd40K/sk3+H4FgSv/gb8/iMnGbGPx2nEudxJCit0EZsN
 E8kbRY8zXfE+Em86/hnfz6l/nOj9MKC9uXEVfXRO+NhqzPJ1JMw5vyApn0qjyZI9i4pK
 gXlNPXQssdsJfIT3irFjhdzVF4A+Zu1NEDTwQ/kmbQzjLpPCmsDhw1nLhknkIj2AoR9h
 gPlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMEkgAfOt1HmWLCaEwhIcDLVPu+Em2MjqKgcmFGdKvsaQxEei4iQhoJ2xsLoZfgrJr4BlmtPFrHmc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzo8JgaletxT4wnDE3SkrVqqD8N6JSJNX3H8azyjtYJ0jNvefOU
 FAv2loz3FB27npSj7pSLZ0erl+go2sy7DPbJRJYve9o02nfq28JEwtZBcKYioCroZSH9fbm1FD0
 o4PsASvocmo98yyvHjoDFsPaEXMh+s1dOmV/fgEW6NILl4CBtGCl4YVpJcIHJKuMdsCNTBSs=
X-Gm-Gg: ATEYQzwIEJXpOFLMssfeROpPEzx7jlWjF0YDOMaRbw0ogHkSTsuGlnWknC5obOF8v4f
 gaGmusM5gnNV9VKEeDNa9PJ7NVgqwTTfGXRTmAZavFjbK/Yk/9mX/P3FY1O6SzJffwovkCEjUau
 osY8H4viQv5SNte+L/BF+N9S670hYBNQqKQC5jGXz4wVY6TiN2r413ioZ8H2hxxZUMqyDEpEzmG
 L2zB4oRg9HfabtUgvNHzut8Lp6SxmXrVNn0UR4mUhv0+vIbDbJUNHrSvPT5Sz0K8LaCIcyOJgeH
 +S1EH0XTtGqZoCAIpRjcqWYuoWvh/5xTbbKPmfIXl7/9qvigzijDuGRiRacotRD1kG8He1ocRQc
 mSVJsTL6aAF/Y9r3ZItAZ7aguGnoo2ONd3S9hlg3i35ZAPK9ewkg3Sqr9DJI6dDLBulUgyVNR6R
 1nFLM=
X-Received: by 2002:ac8:5852:0:b0:50b:1e21:1733 with SMTP id
 d75a77b69052e-50b80d33668mr28746371cf.3.1774429154902; 
 Wed, 25 Mar 2026 01:59:14 -0700 (PDT)
X-Received: by 2002:ac8:5852:0:b0:50b:1e21:1733 with SMTP id
 d75a77b69052e-50b80d33668mr28746051cf.3.1774429154425; 
 Wed, 25 Mar 2026 01:59:14 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f43c3bsm761885066b.2.2026.03.25.01.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 01:59:12 -0700 (PDT)
Message-ID: <ad8ff7fc-f7f9-42b5-834f-9dc2f247c306@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 09:59:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/mdp5: drop workarounds specific to MDP5 1.0
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260325-mdp5-further-drop-mdp1-0-v1-1-5ccee47fd1aa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260325-mdp5-further-drop-mdp1-0-v1-1-5ccee47fd1aa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA2MyBTYWx0ZWRfXwJ4dGMTVVS9g
 YBCP6aXg9BnNmZUEDpARAhsz/nzsd4yqn+t1yeUbvw7c6wx1vIcBo5GHYhHEXc8zDTwCgwsNZCK
 3D6bRW/aO76CHXAon1ybuGE5rT/RJrh8LvQKNVHGKGtAIrfEzCSzrYF2S8Z6A7dGiBpy0WA+gfR
 ufbeNMJlaymxWUL2mocNrFmnsEslbMK1QJ+OihiqFi+axWqfAB6AhRrWxNIP/IU4sD0DsMwe+y2
 GTWQm/6fOFGKN8Vl6UrroOX4Zd/jLYg9sMzig9CqgYHcnjwaSEDeTpLuVDjKFv0yaICYsct/7N2
 qtP70d4lyuL3IOr2zLYRZNHPdMnSwazt1TYGE92dmTwqy/+aJBLFsl/oZj54HknY4kfsUkbCx9e
 tTckT3YGLeoVEmHKi01To7xWeR6gHPhktOlCwbS4HTQl+xz8xfMuwJHE7NFwJS7yohln7K/Efs1
 x0WjJ23WDEvpGjrPtRw==
X-Proofpoint-GUID: cN-S2yCUqy6kZbDJgzuUC-pPE-FqbYCZ
X-Authority-Analysis: v=2.4 cv=bpVBxUai c=1 sm=1 tr=0 ts=69c3a3e3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=-owB3-D08_1IoEjBxTMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: cN-S2yCUqy6kZbDJgzuUC-pPE-FqbYCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250063
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

On 3/25/26 4:06 AM, Dmitry Baryshkov wrote:
> With support for MSM8974v1 being removed from the driver, there is no
> need to keep workarounds specific to that particular MDP5 revision. Drop
> them, slightly simplifying the logic.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
