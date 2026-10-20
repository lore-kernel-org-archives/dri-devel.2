Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D8606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hmKULjJG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TldAk3Fe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A02A10E9F4;
	Tue, 20 Oct 2026 06:19:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BFD10E8B4
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:19:20 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tTN44178291
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pqZQfZiYxPSu/7WSL1QBG0oS8S7CYXTdmoMJsV2CUPA=; b=hmKULjJG91h85Eb+
 MfL31RtrWFg7XMCJzYHN3/oRNN/AW5rGAi6phBylb6dQtxaCvE8f9cFiTN1VQzFt
 qNeSlf5/usy5Dr8DUUXUOFQdQU3wInGz6PUmIRq0TTvKWRJX4PEGpnUxXIxpVC5Z
 ifVzNSoAOq5T5HkOOJjtOVXEGHKEz5Fd9tHQdyq9hNglfK1L1CCTdYbqtWp87416
 cWE3HRY0iteBKVFC4LZiZwF0C8ysGu0lMhasaYOrxw1HlKDNNHnwxKK5NKLUyJIB
 FZbThnKBmEWocSibznkXIqopJ3LX8YpW2f6r1tuVaZw8XeF7AiKzdOA5vB87RPKN
 8TMIBQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n1413-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:19:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ea6b66e53so59040485a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792477158; x=1793081958;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pqZQfZiYxPSu/7WSL1QBG0oS8S7CYXTdmoMJsV2CUPA=;
 b=TldAk3FejKE6l7AZ6kXockEB8bB+8briU0AYUE7/WpN39S7SMUAD+bSo8mWgq30jD5
 Q0iS0s+ndfKuuItnlQzmpwcHE7JGTtkxRqJK4Q6P1+iWoK4A7loqcQnx/ohZE5PiTCwZ
 6cmnwQq3BUoyONvrXcUtoMwbwgdFeqW/SQCPAkTIQhfYHVKLJ/0alh7jniwip3Tx4TyL
 LpcRRJ4M+8ARIudRsUaiZs0XPFpyzL16h5uRKQ1eTzRIV09MFO999yShztIMQD8xyIIt
 YSQGDZmdgNfP13vaGRGXtuvh0+OPT2H1Mtn9MpE3Gy3wBjIrz9hcfHGJ4Kz38lREdTkI
 jGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792477158; x=1793081958;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pqZQfZiYxPSu/7WSL1QBG0oS8S7CYXTdmoMJsV2CUPA=;
 b=2Tnwnt8qQdl8jmjdMUuuxaeORJPivSLl5lSm1o1v4wkEe0ee+hkp0ePEvCpcL0UirS
 PoI9axDWStNMPXlh442eVv25L0MTMQoh85ZuxwdMypKlAgjp3wqyxY1sq98l8vaTa37A
 cwGMTgDSa00IMbe2cx9ZPZ4LdThttJnJjdGGCRzzxI9ZxU3vH0tHMSqC6jURX0nKV8YN
 kHK+d9MYw3iuubulFFMDN9Abn7W5U1SHXRBHbECv0kwrcRAWIU2QlP/g2bHJecJrjT2B
 /IZWq84dzRJimWGbVwuj+UGneH7gwjexnzPucidQrZWKa5+lw5DD1Z5RLy+QuubgoVna
 ADkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCfomldxtKBy8quck1ufpPvSCUKel8edFCmjIr16Dj/WfSAi70tdjCOZtY3OuQ2NdGllRNak7kL8Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYICZiCkh/NmcrBin1u+z/pBlTy2GK+KT2PXUcUYieLm0p+drNJl
 7NVKJkpwhPT8yyortFAsqLRyZWZm9PBusxQ10YSs6CK0ENyGe4hiJMtQD8W9Lu6AOhZZJlhNEz9
 w/CoOtIwJZjX1cE7khFuEi4qzjAHoEXTZU3EWPg58M2QhPYYK4QlTw8aOErnMsIzQhcRbujE=
X-Gm-Gg: AYBFou1ryaLMKiHjUG0MqnIxi/9ATScPyQvJ7ueLTxI3Du6hwF/atCqMg1fv8LXR6DE
 G4O3EbKMDaQWnxOe89UohnKdIRZ9abtIsMI9kFLn8jRm7wdN/d+NOLO4qYbzQruSRRKf1qimLFp
 E1vDQzS6afXoWZkSUWl2nzSPm6S/WaIUaYen8kRRfS5pPDnDR4V3rAr4yCd1WnU7j624TxYDR/v
 HP8+8OVbg7eBzuw7H2GV9MhKc8xRcLRGFbITrMnww91Cu8lIy4mnCJN1zLcErnUgeGjvFwEjo+8
 FR+JH3ZzJsfygzerF2yXrNH4+cZqtiRWYgH84h94iYC1U3LjANj1p9ioCa+OG+n67m8ZsIcx+e2
 GHK4ep6FQXSZ0JwmhU9vVvQ==
X-Received: by 2002:a05:620a:800b:b0:939:eb09:4458 with SMTP id
 af79cd13be357-93f29ce0b63mr1993128785a.3.1792477158437; 
 Mon, 19 Oct 2026 23:19:18 -0700 (PDT)
X-Received: by 2002:a05:620a:800b:b0:939:eb09:4458 with SMTP id
 af79cd13be357-93f29ce0b63mr1993125685a.3.1792477157890; 
 Mon, 19 Oct 2026 23:19:17 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4090dd10ebsm448275366b.22.2026.10.19.23.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 23:19:17 -0700 (PDT)
Message-ID: <3dd32c54-eb1a-410f-8c42-9152e87ecb2c@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 08:19:14 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/msm/a5xx: Reset the GPU when resuming it
To: fabricioakio@gmail.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Paul Sajna <sajattack@postmarketos.org>
References: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
 <20261019-a5xx-gpu-pm-v2-1-457aafbb28da@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-a5xx-gpu-pm-v2-1-457aafbb28da@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8GMuUxcU5SyZ72z95ttJ7W4CLTAlu_GP
X-Proofpoint-ORIG-GUID: 8GMuUxcU5SyZ72z95ttJ7W4CLTAlu_GP
X-Authority-Analysis: v=2.4 cv=L7qI0OT8 c=1 sm=1 tr=0 ts=6ad707e7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=IPAj4E8Ak8Ehd_2eMQ0A:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyNCBTYWx0ZWRfX7Sfcb+AuweTz
 b6qC2CQQxZKz8rKkXcGpRdJSdHuwTZIUPVgmQNksfHJ+0lwuH6i8oRmeXZ0VPI5hvQSdYP8KPH1
 fIS2kGKrfZjDA/Kp3SZnZgCL3Hj1PPlEbuKa+CzpW+fjA1VdXAP7q1XNL2Vd4qCOLeMXZ1UYf4X
 1g4MxyIMFdqA93OPjNjJjw+40yWqSYyQT206Gfw2rUFGGR9k/H7cLlt+DAqnbTJgnaa/mNTILaE
 FZrUYKiW6Xukz+5ALsJqQ1yJBtcBsDen/LAzbcQIk+CGEXWKDC/I27w5hqndT3OfoOuuaDSnHuJ
 uFWv2t+mpdTACBvSWcV2tNK42JHeUOEyDNDrPnDvqR1pUaOAxcBeUN/DkgYpBEC5Jh1rJCVPF7V
 0PLJWhsnsb1Au9YG8jWLxmpCViPz6/cglWLmUJJWTvPE9JUo2kDM3GBVmVHg1ihwxavzJj9gF2G
 RVREVggUEgTTiMLsuEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyNCBTYWx0ZWRfX98l0ncz9moq/
 MWBFXYURMYXgnz+XGU5bnkf+dEymjOOCT7lPajd8c0/dmxDgIr/A0Q5fat6vazWtUVwpeZPMgBC
 aLdxFjY0D2tNfJGIWnZSvr5yhwNWzsg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200024
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
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 4:05 AM, Fabricio Akio via B4 Relay wrote:
> From: Fabricio Akio <fabricioakio@gmail.com>
> 
> On SDM630, SDM660 and MSM8998 the GPU's GX power domain belongs to its
> SMMU, not to the GPU, so GX switches off only once the SMMU suspends as
> well.

This is because the DT part is a huge slop (artisinal free-range
grass-fed slop from before AI times which I partook in.. sorry!).
The ultimate fix would be to land:

https://lore.kernel.org/linux-arm-msm/20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com/

on other SoCs we scrape by with overzealously assigning various
power domains, as all of the power requirements are managed by
RPM and other pieces of firmware. On msm8996/msm8998/sdm630/660,
that requires a long chain of HLOS-programmed values:

- VDDCX/MX from RPM
- GFX_LDO
- MEM_ACC-GFX
- CPR3/H-GFX
- GPMU on the bigger SoCs

I believe Dmitry is working on getting most of that in order and
should have something to show in the near future.

Konrad
