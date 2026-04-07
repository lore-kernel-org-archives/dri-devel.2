Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40390105D986
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 21:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B6710E4D0;
	Tue,  7 Apr 2026 21:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9Z7GZ1Q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OKB5Zzvs";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F9910E4CB
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 21:17:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637JoIwe3816869
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 21:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uEwzIG/WP3KfeGGQytAvkF+cLGebDaMgBafkG54molA=; b=L9Z7GZ1Q3EFl1S+D
 FtFp7TyJHqGUwFpXxRrSIYRA6txv+kkIweUM48X00KEOV6T6z0Cfhchg0Zj3BLbF
 Z+e0ZUKbBQyQ+V75gWyVBd+fZvhGxjoRj0yIv5DZ3gaQAQYgls2I/T1q2hvze8lY
 uhtGm2yx691Or2svpfLQvIgv0zFO2MI94EdaY98w+vvBE3IZcAo2GfVrmySKhE6S
 W1hagftbsjrgTXR2AFh6Ic6/f1AViEoBHwQLyY1TnbqddzDkye3o5x6SmE4+2/jU
 p+UNWjbhw9618Fa2eU5S7SOTk2D+ZLu7CQe/xMEZSUtT38ihJ7ier+XgGEceV3oz
 EyD1xQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr4vnp7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 21:17:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c741c4cebf3so3471359a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775596661; x=1776201461;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uEwzIG/WP3KfeGGQytAvkF+cLGebDaMgBafkG54molA=;
 b=OKB5ZzvsGzXmcTXFp/MAEAQ9b8VOQR4b1tVhB8WBfwIuAR8o1VyE4VN7KInUBPTEo/
 e52KATLa7wABNFWaEB0DsqjettqBZ9aKMSyKreLDU6Xl5/WAKF3Li/qTeyDrU/2jXa7u
 +RLoC24nzb4az8oohz4lh4WLE7b/hD6SCv3qjsM+wKBpeF1fjr76Wk+QW6dHTNHFURGf
 bevLgQsUS2PKrUsWLdaxJbBNCCvu2Sz1uRyl2ANwx+tjs121/4rh/Ia3/jabFIFmZD7o
 WLQMERIgl4PaDgPJr50cR16E3/BA7SobGAGxzWGky/fYWSXpns4VcGAuf6IPp/aKFlq6
 NmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775596661; x=1776201461;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uEwzIG/WP3KfeGGQytAvkF+cLGebDaMgBafkG54molA=;
 b=E9SgZvTcxEmJqlTiggw8PEtPJrYpg9y011/A9N4Fvlqrms1Kd6ydmVQG9LCsqe/Blp
 mDci6k9u69b6oIT4/l7OZp3qdQaGlodqU+GO/D6+aCC6tgylfeaCwKMeD1liB4+vNMUg
 mDSS5ajR+Ln1dtcZTUJzokksmtjviv3xXL+WaSrbmjIKuLOkjX44mn/5d14kxS9HtYZC
 1woh3cSNTpGa/dXWsPXsMPfcIxB8YKqOkcp8/bnXgaW8N1210zZxYH5IszOyBUc+2VNt
 YY1BtsB3fEyKRjSDqBD60Mv+Dybgtq21u0OIR0tTj81M0xacRa7GMPZ/il0HyigbQaDS
 VkPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUPsgtiv6Xdk8yimz3mQCvIEqG9Jv+XMJBuGnX1sgM5ga3RMG9Vjb0dJdQkYrHfFoiskVPgCjiUfM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6qNbf1Zo+KaubW/Bx2oX4DhB5yv0uQbtzWDGKO/u/nocsnph5
 kwDAs62TOLbTKB1amapR4DN2Rmq5lXxPs6O1CMyorGV3il0mrv5/wFTjxSJbAcx1oqi7q4Xeurk
 8mnaPgoGElpkoB4kImIHnw0x7b5egqRVPUnGoDHZiZzdwdkgxmmlUlaaiCjFOY1w8yevmTXI=
X-Gm-Gg: AeBDiet9AQwhID6vYeEkNnYjaTmt1bbQX3W2pTfpDyvEcEOf1Chx9lxUM4OP0pIVrrU
 gmD/poZ0J2gNkYaqgmL7NR36/ERFJKgPk/NUkDmLm4lQPRzpmplNLpU4gcH6QUoS1idzbp59ab/
 GsNc0pVbuTFwTX8PbeWH15uvbXwuRHRjIvZnEOqGGZr4ynp1j5hdPM0uuilFZ/PZ/jIIOsf+1RV
 zxlTKv4pJ/5aq9afKx64Jjnef2djXYgCZsLlAdT0RLD7/hcqfASNrTRKqHJDgZtpOSbrLunHFgm
 bBv1hJ+v5eBFgydd41FVgUAbV7yGYTxFLTerIPftht9ZWbzKiNIMQdCbRJ85H37Xho2dBTZxiIv
 0kjE0+UXYOS1M6YcM2JMD8tu4p3A1uojqmhSdDatUpLEdyQ==
X-Received: by 2002:a05:6a00:1ac9:b0:82d:24f:2516 with SMTP id
 d2e1a72fcca58-82d0da2b115mr16522193b3a.11.1775596661244; 
 Tue, 07 Apr 2026 14:17:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ac9:b0:82d:24f:2516 with SMTP id
 d2e1a72fcca58-82d0da2b115mr16522166b3a.11.1775596660698; 
 Tue, 07 Apr 2026 14:17:40 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.237])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b6113dsm16813935b3a.23.2026.04.07.14.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 14:17:39 -0700 (PDT)
Message-ID: <27e2e6c8-fd8b-446a-9ef5-802e1af0fb2b@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 02:47:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/6] drm/msm/a8xx: use pipe protect slot 15 for
 last-span-unbound feature
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
References: <20260402-adreno-810-v2-0-ce337ca87a9e@pm.me>
 <20260402-adreno-810-v2-4-ce337ca87a9e@pm.me>
 <f85253a3-e03b-4f33-a7ae-df18ba01fd8b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f85253a3-e03b-4f33-a7ae-df18ba01fd8b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dO6WXuZb c=1 sm=1 tr=0 ts=69d57476 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=oIjhDLspr5RTlLLUpj0f1A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=qS-k9e48XBCiOm6aCyoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 8pcCxtnVYhm-NlrKOTc3zYraGAErYsxz
X-Proofpoint-ORIG-GUID: 8pcCxtnVYhm-NlrKOTc3zYraGAErYsxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE5NCBTYWx0ZWRfXzrHmT0ZZiqgU
 DfD9ZEOlUNhT5vz2Bp4rGNHnK0uJPkO+HShO80yt+xUIi9hhatWTYsDfmG/V90WbXFO7EHMln+U
 lE5lLmJOpKz/yqIIJiPvvkpvvt2BUgfmmnAlNX2uUUqY28bMLQbRSrmFXbFGPPt8dtD1TF4DlCf
 8p2jisup2v6qWUCEuuNYGfLxiMWgtMLMO3qN8XPEaTApauqqWDaPu81on7tYs6IeuT2LcJg3uEB
 ilwNzSth/lq6KdPmuT8AJLFsD+cPuZamxhRgyaeLpnQbJHR9eXin/Y1HapfwFNkm83S8fEarM2S
 0fBXX+GQXbNfO/OEbER4ObFXWP+pV9UfAN6HvufX1YA8iQegM/26ZSKUdfuib6odh2Hu4bs+sBx
 ZAE3TJgLrt+csDZHuCQg0eeLyK18qLsu5vTfCXS2dfMCUdyBwB6rGthXGp9sglf2F+M70V8t0sc
 Ap5iTXGIpv+KslOq2Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070194
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

On 4/8/2026 2:44 AM, Akhil P Oommen wrote:
> On 4/3/2026 4:39 AM, Alexander Koskovich wrote:
>> A8XX GPUs have two sets of protect registers: 64 global slots and 16
>> pipe specific slots. The last-span-unbound feature is only available
>> on pipe protect registers, and should always target pipe slot 15.
>>
>> This matches the downstream driver which hardcodes pipe slot 15 for
>> all A8XX GPUs (GRAPHICS.LA.15.0.r1) and resolves protect errors on
>> A810.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> 
> Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> 
> -Akhil
> 
>> ---
>>  drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> index 8b4b022d9a6b..102d5e751536 100644
>> --- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
>> @@ -252,11 +252,12 @@ static void a8xx_set_cp_protect(struct msm_gpu *gpu)
>>  	}
>>  
>>  	/*
>> -	 * Last span feature is only supported on PIPE specific register.
>> -	 * So update those here
>> +	 * Last span setting is only being applied to the last pipe specific
>> +	 * register. Hence duplicate the last span from protect reg into the
>> +	 * BR and BV protect reg pipe 15.

Not sure why you modified the comment. The original comment is accurate.
LS feature is present only in the last PIPE specific protect register.

-Akhil.

>>  	 */
>> -	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_PIPE(protect->count_max), final_cfg);
>> -	a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_PIPE(protect->count_max), final_cfg);
>> +	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_PIPE(15), final_cfg);
>> +	a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_PIPE(15), final_cfg);
>>  
>>  	a8xx_aperture_clear(gpu);
>>  }
>>
> 

