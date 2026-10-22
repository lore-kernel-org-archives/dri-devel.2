Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8052606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a3BtI7f2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q6KHK4cs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F1910E23D;
	Thu, 22 Oct 2026 08:04:13 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3974B1123B3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:04:02 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M703DR2714471
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 exPzNu3p9/IZE77xM5zZ2CBcVgSGazYkvGmm0/QzwBA=; b=a3BtI7f2KXL74Buu
 aS5SOqqimHaSDYMMRfgtO+xlDpAMllSVmpaNRr++jcXpW1LIvgq/cEAcGy9SDw/7
 pP9oSg4VcnrbQmzE044o0rPWtB1tKSt3yPzRLeqFEhA7N+iVsqkxLqPkHLQfyMn/
 K2Ek9uGDL42k+2mM0za33L+j7kXHnH08/20PnCyEqa0Ba6ITWC9GqpvF7N6W5Ma9
 8J3Yn+I4J4VxcosI+1XvBVH/YFJWvC2MGzx44rcp+rVNQtWFhqjYks74YPfyNvVX
 SDxY06CUImMYKIyXk+v40Mv9ibKaKAE3oKL+S8AWBD9yiqtHS68NbcCDQQ9z5NYZ
 N1WwJA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93bsbjv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 08:04:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e629c7b16so36203585a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 01:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792656240; x=1793261040;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=exPzNu3p9/IZE77xM5zZ2CBcVgSGazYkvGmm0/QzwBA=;
 b=Q6KHK4csih+NRgidKdTrXmL9KZIdCjoDwvn9MWnwHSGC5pfHborm5Zj6l3ehAeqx0f
 Of06LzrYrr0imcj9bogJu8f3+ROgxUzAaqfIbX187cYyqZ6fQEVvFOsmQuj3xoWZAfoz
 bwB2X3DXTA39vnYiFnUc24c9H1U5v9m5pa8H6qr6iOvpZiU31ODh3rclW6kk4IlRgWFX
 io7QcT75lqrmwi9W1RDdcF9XGCcSiVvw6autoGdz0a49RB7tQLnx3bK9G87h2+Ok8Lg9
 DC+EN1kgZZEd61Dbjp1nPEBF/s0lfAhY9hYR7AcdrWsHjANvHAPwLxL95YQ0VMSlpsbb
 CEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792656240; x=1793261040;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=exPzNu3p9/IZE77xM5zZ2CBcVgSGazYkvGmm0/QzwBA=;
 b=Wme7/8cx7F2JPPFvg9eVNGiZXwloXJEqibSTKfWt+eViIAJz/soXsiHX20t5iR22RS
 S27yEJPrrDecFaHhGhBAKkPQe3uZUAdknE0AYJYg7orsFG016LDc+NI7m2FNEVfgY2M9
 6xhMuFdiTJx9PNQ7TaDPOe3qCPx16ZEImwzaAMGyiQJs/BYiRoNwNDog8tV4cIuZpcH0
 A5qbJg1M/QAHdoOtceb30X7Tp6v59xwyhadTFMaoFKmzNw3hJz3V7VaDI/bEOv3/EdV7
 OvpBYifZUlvcCBZ/xn1SfFqUpyu5gthf/lYpt8h73cpSW7RHefAU9AGRZTrXJW9AUS9R
 mdCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4230nQeYqOrk+/FfJ64ol6tG9VX1HWQ+ON3FA8M2jl+ncoHqcpN1SW53dtgqp0c8HD+e5mHKt9Kc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIToG9W3oaDVqaLq5kXPR5l9UQbyKD52l07DLS4PjoFdX2nzZ+8
 xWWxoPr4Cj6cBpM6BWK/KUY30HdiIujYyvCD/AB6mLm6NY5M7AEaW+7/6UOS/1qRts0yXHFMUxn
 ACO3kb3TOn8twxHz9fGkFFhaZqAbhPru8vcqp6zGc2xDliytqzcj46iPMxsdf3maJwePzcoQ=
X-Gm-Gg: AYBFou29144WmyB9Mi7NhgIDRwzWE+WYt8Xh5POyBIM9fcA1sNpkMdhpsF+1fHduK8f
 Hp8VHxD/KdBQRBNv3tDi6h2XyFkNzqjWCN8xKIXj870Pv7tWGYfCEJmYTZrNdFufhexI95rB6wQ
 z+kaXVKv+891ctmwGfITCJrVoPWrXUu+glCP0Cd6YqoF1RRu5Cj+DmRoxyE0ogj9SA/lsb5FVaK
 0giNVd6xAUbEqSmG9ebk0+xdqiLJKykxl9ArLEtTSsGvdx9diR+IlMVJizGkFOAM5LNJdyiZ4LZ
 k1UMFhIAmVr5ZG425frkWnfuClFYNnAQR3LW7jsUXM0MqfvuDavSasuvstM6u5yHKe3r0NFqYKt
 LWto/0FfU4xOSybuPwBbRWg==
X-Received: by 2002:a05:620a:6844:b0:93f:211f:7ba4 with SMTP id
 af79cd13be357-93f57fb9f56mr887371385a.5.1792656240217; 
 Thu, 22 Oct 2026 01:04:00 -0700 (PDT)
X-Received: by 2002:a05:620a:6844:b0:93f:211f:7ba4 with SMTP id
 af79cd13be357-93f57fb9f56mr887366285a.5.1792656239728; 
 Thu, 22 Oct 2026 01:03:59 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4031104adsm1477349a12.14.2026.10.22.01.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 01:03:58 -0700 (PDT)
Message-ID: <4069a590-607b-474e-9e3e-f7e744d3dabc@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 10:03:55 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] drm/msm/a8xx: Switch to generated nonctx regs
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
 <20261021204244.67160-13-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261021204244.67160-13-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xaX0bGrZ-SElHk74gVsbGYJzzYluwkwv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzMSBTYWx0ZWRfX+wZ5D7q4ONiE
 g4ksS2fhrNqXj9NocV1b8iAQubGYizvFn4/iSA3WJM3kLYJEAyzmH6OHYLUVD/+OkJdW8XJoKbw
 MgG418gKvMLA3hg6rVLeNkLWYrbrBfZ8HrKjaaaQljETxsi6tSq8txehXDa6SFsid7oSximg50/
 z3X1qb5HpXmh0qS8xkwcGRHbcSB4cMT9xCB+XZw08+7Cr6ff/2ApoTT+7xNPrGfSFs7XiuHBRaV
 hYM2ijmJRh65BleKgu2XkCPqx4lhGGuBpWWZ5rkpdvA9Db2zPiMyiXBKjX1XX4x8L+JVmo/xPrM
 TTQs6V4xsgt4BbwSGrb33NxgtDqq0O1EvPiPNy0P9g+ERPoh4I7h9smDt8I0WnDLKeR9syS2PWy
 ulcsj6VjuUgfZM/Z/aRNDjGDsuSchmNvuUGoiYCArJ3hZ69GQcydyXCtgwTJzusXjGuCHXmxlcp
 6QVUoRHkOBwmHge6+sQ==
X-Authority-Analysis: v=2.4 cv=HJxWhYtv c=1 sm=1 tr=0 ts=6ad9c371 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Ek6KEbicoYwQu6oDvHsA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzMSBTYWx0ZWRfX9mOw+Rx63cTS
 iwCFjTilvTa0e8FTfK8PGeXz2ViybBCE7Du6R7yHYyHq/cEUyQzdMMbYIqAQVQiAjrhlf8lnLQC
 3QgoHkNGZgabBxP+r7LLtfQGGgDzEW0=
X-Proofpoint-ORIG-GUID: xaX0bGrZ-SElHk74gVsbGYJzzYluwkwv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220031
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

On 10/21/26 10:41 PM, Rob Clark wrote:
> The generated headers contain the current (at time of generation) hw
> recommended values.  Using these directly makes it easier to stay up
> to date.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

For context, here's an LLM-generated change summary:

What changed
- RB_GC_GMEM_PROTECT is gone from every generated table. That matches the code change, which now computes the value.
- Every generated table adds GMU (GMUCX_*) entries, and most also add RBBM_INTERFACE_HANG_INT_CNTL.
- Several hand-written entries are missing from the generated tables, for example RB_CCU_DBG_ECO_CNTL and UCHE_MODE_CNTL on a810, and RB_RBP_CNTL and SP_HLSQ_DBG_ECO_CNTL_1/2/3 on a840.
- Some entries keep the same register but change value or pipe scope:
- TPL1_DBG_ECO_CNTL changes from 0x10100000 to 0x10000000 on a810, a840, a845 and a850.
- TPL1_DBG_ECO_CNTL1 on a830 changes from 0x04000724 to 0x720 and from PIPE_NONE to PIPE_BR.
- PC_CHICKEN_BITS_3 on x285, a810 and a840 changes from 0x500000 to 0x400000.
- GRAS_DBG_ECO_CNTL on a845 and a850 changes from 0x01000800 to 0x00000800.
- UCHE_HW_DBG_CNTL on a850 changes from 0x01410000 to 0x01010000.

Konrad
