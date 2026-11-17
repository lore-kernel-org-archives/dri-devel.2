Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCBA606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I9TG3SCW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VvqzWUY0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C1410EB74;
	Tue, 17 Nov 2026 15:53:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8109410EBB0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:53:39 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQuFD652069
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bZ1zWBA9tA8t4f4f40scSE62yaKcTCU2KrPmKEa3n+k=; b=I9TG3SCWJ6lkD1NR
 pUxWMa9d0lcG2X6bj2TbToPcltL1ru8l452fZfi4Erb8sl/1l8pQEACc9xQSrIQW
 ekDh0qCEb0cgMl42yqXr/te5CS9YWlhGBWGcIcTZErGDYkdZUOiocd+DlGq/28xG
 D6LdlMHPELugGS7gN6BxduVu3nmcZCZGvDJuDUh2COwd5kY7tuwoNhU8s0ZvcyFR
 K4e+N3H86zyCS5OCaDntRfREwKYVlT5/pI84NiobWRewqyNe8q3T0TQ4xD3p4K3J
 tNcUarnBm6uVkaf6yMEkiiDygKa/A651EU4ci5clv+qrDzpuer8Dv9AOS4/g6HRk
 ohxwPA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0gehakw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:53:38 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7d2cabc2086so109038137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794930817; x=1795535617;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bZ1zWBA9tA8t4f4f40scSE62yaKcTCU2KrPmKEa3n+k=;
 b=VvqzWUY0JW7vWV4Zk08xY0J2NWVbp48Hez8sburXmJS7vSLygnAUGWDTcIwXziAPct
 4cCiX1e+beNTbroqjMrlJMRHq2gHK2drR0w1g6KWIO9xIq1Nq4wlraadrY1bNvI7X5wC
 CEHqlCePvgMpgw/+iAiO899fGm1K4qnOxiBZf9mcScmvcnQhP24i9hCMB8eYbCjIDfqd
 CTQzCQl4ExOLvLUE99HR0P8h6mFkwM6TKJrkDAMTVOMTaAgd6BneQTFklJgxOgv40gbG
 V38hsP69zRKzyyFrVkenQHXXJkii1XXUxT28xvLdQjLhGcB5YDF3/W4ONTQi9TVDIIX7
 Gdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794930817; x=1795535617;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bZ1zWBA9tA8t4f4f40scSE62yaKcTCU2KrPmKEa3n+k=;
 b=hTTiBbjYFrTs2xQwQKhQ/TsalAimWnewR+gDOPH/ZtPhjPHkFzdkzZ1Yok22AGE3zt
 lzHoFgMnEqyiztkg3APR9ta7hmhuRa2yl+pjCaL1qhooupQPsFwkh/gysrQQ1eF/Lpns
 06n9/Ui7Sl9XVdnf9Fih4Xyao09eQqCuCWPmpLZFbXhD+4cGb2W/JPbEPOGELZgn6qzs
 CZU4+fm0EsJ9iHf1EDmUkWysO+twKpW+rR1ySPnony8dK9YoOPh+QjyqsPtfL75vdj7+
 cPbwWILMNpkS7mAVhpuU0OOuohb7lMKobbRIfsWIl8d1HwreaPAbCCoh/fxuPFB5ez/1
 OaZA==
X-Forwarded-Encrypted: i=1;
 AL+hErGbwwy4vyyQefyYcmRecRGc09LRCG66csxhIMW+fjGV8TqW+ZfLiuOdqnHNpLKb3GJI2sPhjAb/QXA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z93kmR4Nh8JJ5x5KdSBLceP6JGIl0srRe0Ekr0z4vnuiaYGNXXF
 FqWt6Glq2xqQCf43pOj2mn/Hf7IdjwTmqvjVomMONB6esw7wWo2Uixuuye998tynO8Hhud8FFau
 cOa775BF25tco1T6wp00F+0WL8M8bfpKre5Tx1PSbvm0XyHGyO98zKKlMqJ+JWH8UDs6LMx0=
X-Gm-Gg: AYBFou3GPF9Vavt87VVCzRmOoGI0soC41pBWpgrZmeX7gLt4k5568UP9Gd8ZuhXRxea
 Y5C3VpQ0TLdh22qXLn4sAb453dKETJ+ZEoZVTdKf1wETKgVY+K8HtBdqpsGjAdPnKmQvgKdHzuL
 HmyFpCxLf73Uq5Ha0rbzmQVnVAUqczINmSh9HiX67axJoUL+21kqWI7oUfkUIEwub6gnOdNTxkn
 qxGp3caeCZqR3wHYQJv5TXY/7Q2aYJEkacE/zMaOds2CJN7zJWaLW3MAFI/pdR6lub4h8StmTf5
 UAYLZCJQ262p+1b72tx20fRxODrJ/QJoREJ05OfsLgYhDMKrPzDCr4b382iMcECk4E5VjEJJPFg
 3g/Cycucd2ymmK+Hk6H3LAydVmbE0pAiPom3On0/aLeuxCbafdo5mIjA00n1px8Yd3pdKc4seh4
 g7guA=
X-Received: by 2002:a05:6122:c2c5:20b0:5ec:e2a2:b70e with SMTP id
 71dfb90a1353d-5ee34a7da4emr5532926e0c.4.1794930817580; 
 Tue, 17 Nov 2026 07:53:37 -0800 (PST)
X-Received: by 2002:a05:6122:c2c5:20b0:5ec:e2a2:b70e with SMTP id
 71dfb90a1353d-5ee34a7da4emr5532897e0c.4.1794930817117; 
 Tue, 17 Nov 2026 07:53:37 -0800 (PST)
Received: from [172.20.97.52] ([195.50.164.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7ad9430asm47416065e9.15.2026.11.17.07.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 07:53:36 -0800 (PST)
Message-ID: <079897df-fa2c-4ba0-bd45-7b357783b0a8@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 16:53:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/msm/a3xx: report CP protected mode faults
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261111-a3xx-fix-me-v1-0-d81f50f1ba1e@oss.qualcomm.com>
 <20261111-a3xx-fix-me-v1-1-d81f50f1ba1e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261111-a3xx-fix-me-v1-1-d81f50f1ba1e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BDxkz9P9ThZi2XriTJzWBqFLIMDY7i9Q
X-Authority-Analysis: v=2.4 cv=dLkzC+Zb c=1 sm=1 tr=0 ts=6afc7882 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Pyg9J2lIzH036oXokOIA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: BDxkz9P9ThZi2XriTJzWBqFLIMDY7i9Q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfXyCyHJ16NP40W
 g+Rw6y9BBvnkY92kO4O4MsT6H32XJKByqNqTjp1hKr9Ig+k3d5Tdg4He+Tqx1UgbhIQBSMv7io8
 QpG7OjGCgTuZzST5jr68GAbuO7u2hLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX5haC16H1ti3I
 +Hld9U+d8bCejd2Kmz5YqdAb4dyw9SVXMDl6fX0w77geZc+xceUhvdpgCU978ADEC7Yee3cLuwf
 s++W45jTc+7HEdGia9w5rSnkmKxO92WL/rfC27Qyr69YuVTpoar9ReQAAXFFRohvTTL29IXSuu4
 GVs3C966txxttefcEiiAFDgM/HqUgUk/7u3hXGg2+LDow60enAcWtgC5mlyudJKX4I6lS2gLMn8
 +Xsb+wOhQc1aBhpsxev7d30dwkldNUYUUWXtaIbGupiJvHvG5TnH4Vn/KD7ZL+7a53lFs5JiOjp
 j0dx6QHqAohOESHHzfK0ZuPUz3BqG96L5PAIoVwPcN2Xvwo5NZP/ZmLXzZDG8pbmjKBf2AjSOvP
 dR+bUjMNcjsQDfI+L7rVRP1IStfhzymVxO1owad0J26rodeb0fo5yMno8po6DiQuJXIxUm1zTDw
 5zcMJlbVVzVwygMg9rA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170063
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11-Nov-26 14:05, Dmitry Baryshkov wrote:
> a3xx_irq() acks every interrupt without looking at it, so a write to a
> protected register shows up only as a hangcheck timeout with no hint of
> which register was hit. Print the faulting address the way a4xx and a5xx
> already do.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> index 160d302e16a3..7e03b7305493 100644
> --- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
> @@ -419,7 +419,14 @@ static irqreturn_t a3xx_irq(struct msm_gpu *gpu)
>  	status = gpu_read(gpu, REG_A3XX_RBBM_INT_0_STATUS);
>  	DBG("%s: %08x", gpu->name, status);
>  
> -	// TODO
> +	if (status & A3XX_INT0_CP_REG_PROTECT_FAULT) {
> +		u32 val = gpu_read(gpu, REG_A3XX_CP_PROTECT_STATUS);
> +
> +		dev_err_ratelimited(gpu->dev->dev,
> +			"CP | protected mode error | %s | addr=0x%8.8X | status=0x%8.8X\n",
> +			val & (1 << 24) ? "WRITE" : "READ",
> +			(val & 0xFFFFF) >> 2, val);

I would really like BIT/GENMASK here..

Konrad
