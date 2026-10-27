Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F4606A31F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CxhXrxeR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LvZJD1R/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE33910E3E0;
	Tue, 27 Oct 2026 11:31:16 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB3C10F40D
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:31:04 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAe4tU1935912
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EZV999AdlRRtqkxVlOTuk2BEEI+idcTU+X5XEmWLzBM=; b=CxhXrxeRo0uHosVs
 d+YypxksBHMEuil3Lvq31ZAu7lZ5zUP/I0rhgeninKTHNegcPkDehC1Z7x/MhcqX
 57rao/AG897OTeTj/a9DdWqqBSTHHw91oaItygxwnh09mzR4dcnYfEusq7oakmi4
 FWOfMn7mEva1j6baGb424lXhwteRHSJKCoBsVedhOpCK/lmJ2MBEffZybvel80zJ
 bH6cvvvrVab2E+l9IiJCtjN2ijbQFSiSRSa663uHNgj1u4zlfyVdrv+zl4oLu9xJ
 zO0kxS0pnLRkwyxXHI9oS8iOJn0V7FDavUjXJfXEmAzVV3xC0fqx8YdITd1Zb7G9
 NRZCyg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjfavtkgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:31:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2bdebfc5so120134185a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793100663; x=1793705463;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EZV999AdlRRtqkxVlOTuk2BEEI+idcTU+X5XEmWLzBM=;
 b=LvZJD1R/m4WTzGxMKohtgRh/I3P58nNa5JS7TdADorD4fwlWs2Tx/rPKb0ZScYm5lE
 CsLiT5PUmtEiozMoWmD0QKhfX6tPRjbrGbAz8TClsF0+vdBUwiiXt8GY4uLzvf5pUOR3
 Re66aBGwtoHFWsKBcs6avruQ4Dg8zLOtgnvWbu60/WufuYXhcfv1nSR32jVToyiFdGi0
 OEEjrbDjnTwPkkAqt928GeI8+54J1BrLV8TgdHI6aubzg4ze4ssSQItydko2/pmZAA9K
 aZ8MVqrNiofcXpv9Kb65n+3EIvIxHZiHCxkq+/GKlJaczYe3Jnrms9pYl2B2fakn69z5
 +2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793100663; x=1793705463;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EZV999AdlRRtqkxVlOTuk2BEEI+idcTU+X5XEmWLzBM=;
 b=mR3/HgwF2L5600MsUaG7kQeTj0ESd/0XObTKY0YeWR/hZk6udTXNp+zyZjOLbnp99g
 hV17DZ4acTMlr2RnbtLDoHx5aC5epYiReSe6lNXZ59kdusfztug9dvIf6tchzOGvckjc
 NwQOExMg2V9vVH5vuSMsXQkPRgeC/iUUfjvKJHZ1hmzAsirXXKAwDepzh8+vFUX2GSnF
 hP1XSKhEXqkIjjLqf8QubYCyqUTxE9QGPfL0hmFzGxvQU4rfqN6pqQsP2IwkSZrXD2eD
 3MKtkoeQt9Gw3UF7dXdAby/v9guV+EYqzgx8zFqYhqJ61uZd6+efhi4KmZGG3rb4WzNY
 sV7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUnVrwQFiFOa93XiASkLVtT2rO2m09e+GZeeI7qm99QbD635u5KdGx3zqo7QfKVJj1njnrJ/LNmZk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ05pl70os41ueGyYbFSqi9PbSHyfONKNNG7DgiPYHU1js4vxOE
 l092J0YvQXD0Zi1G+3yTCyxHbz9ic88QjtP50kwYtFSpJPF+jvoCZGUgSc7UKJFl1yx3N6TILi1
 1YZR14mUMCGYv60ME8N5tgTVBkIsoWhvD7a+TJIvf2kkDCUlx5vzadyciEANI+Bn+KrAiB4A=
X-Gm-Gg: AYBFou1Guesru7U6EjvNuZwJ4VOZYm/aWTbHepkNRv+1CeD9jH+36U1zy0GXLnOCWwQ
 tmSwxFlMZ6j4qmVXwRLjGiJSvloQnmJFmZWnzu0cd6evWa8I8lcfZyhJe+yqBSghloR2eVIz/Bk
 Ft3hQq9noYZlG8627Zy8e5V74Sia3ZEMIHvhxd+jZt6QqY+9oTdOQ8q1yesXlLHj3EpZh1TZwCQ
 9O3lPj6UqTEDjl5uTXSBQaVNSmEpezU26eHQUHPS+ZKBJySskvsDxTpjEYoPT+xKRndbErlVjfP
 XmHdCPUqZVlEr2WX9WWPXfZ7gaYyaw141TFD6koI4De1ogWCuej9FUPgkoN4r1idDy9H17z5d/n
 nSZz8wGMTQQjNEaoqTgXGQQ==
X-Received: by 2002:a05:620a:57d1:b0:93f:25c7:a4e7 with SMTP id
 af79cd13be357-940ef915dc2mr1745444585a.4.1793100662924; 
 Tue, 27 Oct 2026 04:31:02 -0700 (PDT)
X-Received: by 2002:a05:620a:57d1:b0:93f:25c7:a4e7 with SMTP id
 af79cd13be357-940ef915dc2mr1745439485a.4.1793100662389; 
 Tue, 27 Oct 2026 04:31:02 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd0f6f1asm441101766b.0.2026.10.27.04.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 04:31:00 -0700 (PDT)
Message-ID: <a3096f94-ae83-42f8-a9ab-19b185eb9531@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 12:30:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] drm/msm/a6xx: Program the PDC sequencer on Adreno
 620
To: patches@brar.si, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261027-adreno-a620-v4-0-b0095e028c76@brar.si>
 <20261027-adreno-a620-v4-2-b0095e028c76@brar.si>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261027-adreno-a620-v4-2-b0095e028c76@brar.si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lhaHljhtN6wj5r39Uxp4hfiEZ1U0v_VQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfXy/1HxrSta8mE
 kiZyZ2uCSKmR52fM7ta1LWdrxg+GTiZNTA9e9TNMg6yIDcED6CahBxpKA6/h3AHdMwtWUSwhhLF
 TMmH6A9ZRe1TAaOqBAYDIjJCm2PdSMY=
X-Authority-Analysis: v=2.4 cv=EIeTQFZC c=1 sm=1 tr=0 ts=6ae08b77 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=27YcngequVK7hVtoIPYA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: lhaHljhtN6wj5r39Uxp4hfiEZ1U0v_VQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfX8WlV14+3h25I
 ZbrGqdmoBGAmWXsMf/s/aJejdWEDUfAoM8H1KYja+XtsqyyvyHnsIdsQ/pgYozKj/q8e/Y1FJqI
 iJp1N9eheE5Xn2I+2mMeTe0Kj3O44dm3dfdEXbcjiOmG1QrRFOzelT3Hox9w/luWySzVEUlHQEm
 33cLV4lv7MfPicGVubgIIMWo3Ld9pJ2d18cVbKdcYU6TCWP57JqK6+a2eRG8vhpmA0D+8BYw1gx
 NkXraphKVoGMIzwY5U0Z1Rq6RFxNHPIzsgqOaWjwEQTg01EbRJupT4Qm+Z6hLxVtroqFWVdQ4Tj
 bHeJejLflhciLnxJrhcOCHy8x8sW/cM/8r0d1L79TdJ5+u5LskW+3CRk7TZ39oUQ2je2vt+U+S1
 ymWycxaOiXVoyVnyStesP47qnBP/onJuNmTdrOZ6H0/IwyDhQ2WajHm1ccDX1/z1f0fC/IE0rj6
 u5l7UPWRjZvxy0YLcLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270045
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 8:14 AM, Ishu Brar via B4 Relay wrote:
> From: Ishu Brar <patches@brar.si>
> 
> Unlike the rest of the A650 family, the A620 does not get its PDC set up
> by AOP (the downstream devicetree has no pdc_in_aop for it). Without the
> sequence, the RSC never acks the second power-up ("Unable to power on
> the GPU RSC") and the device hangs.
> 
> Program the sequence from the driver, taking the xo, mx and cx resource
> addresses from cmd-db instead of the hardcoded ones. Like the downstream
> driver, also program the VRM command when cmd-db has a vrm.soc resource.
> Add adreno_is_a620() for the selection.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c   | 35 +++++++++++++++++++++++++++------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  5 +++++
>  2 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 662f09bec9d5..8d426f1f127e 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -686,6 +686,7 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>  	u32 seqmem0_drv0_reg = REG_A6XX_RSCC_SEQ_MEM_0_DRV0;
>  	void __iomem *seqptr = NULL;
>  	uint32_t pdc_address_offset;
> +	u32 mx_addr = 0x30010, cx_addr = 0x30000, vrm_addr = 0;

We should grab these form cmd_db unconditionally, so:

u32 cx_addr = cmd_db..
u32 mx_addr = cmd_db..

etc.

>  	void __iomem *pdcptr;
>  	bool pdc_in_aop = false;
>  
> @@ -697,8 +698,18 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
>  	if (IS_ERR(pdcptr))
>  		return;
>  
> -	if (adreno_is_a650_family(adreno_gpu) ||
> -	    adreno_is_a7xx(adreno_gpu))
> +	/* Unlike the rest of the A650 family, A620 has no PDC setup from AOP */
> +	if (adreno_is_a620(adreno_gpu)) {
> +		pdc_address_offset = cmd_db_read_addr("xo.lvl");
> +		mx_addr = cmd_db_read_addr("mx.lvl");
> +		cx_addr = cmd_db_read_addr("cx.lvl");
> +		vrm_addr = cmd_db_read_addr("vrm.soc");

but keep assigning vrm.addr here, as kgsl only ever writes there
on A620, but the cmd_db lookup will succeed on other SoCs too

Konrad
