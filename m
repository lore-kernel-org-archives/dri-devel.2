Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCC8108E1FD
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:12:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C095510E9A7;
	Thu, 19 Mar 2026 12:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oqZ9KWr9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X4oUfrjt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A6B10E490
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:12:32 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J744eK1998880
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 baWfbRXsKflr2jzBiIdSLJdaYlUjsJoV4djDyFz0xvc=; b=oqZ9KWr9O0AtQLX0
 04pGTc/SBzmAFyoxoqu+9KX/pTkGFoubvBplSyHIuEnf1jkpDP93C56F5IQlLjWr
 pZNtB/kRsYFu389J1J0+k/Pd++rm0cCjzJkUaxMSAqDTALbEFWIZZJoVsiJFaRDU
 Ll1yKRCmVsELA1b9CBeKuMmmf/5FkL3i1QzAQONPTvjzI4y99T9Z6vGBIRfDTk7N
 xBUP27Rpj0Sg/HJD6GRoaW89j1AwdPaiLhuq24oA+f+UphIZKiSwl2BRHxMexq8I
 W8AHd20S+Wk0K9UVx67GjFZTRf7bpugB7Lxk/vSE8ct2wlqlpfjPGcuzrWbPuH+v
 7XEwhA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyscb4wu4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 12:12:31 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-5ff04e26bd9so182223137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 05:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773922351; x=1774527151;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=baWfbRXsKflr2jzBiIdSLJdaYlUjsJoV4djDyFz0xvc=;
 b=X4oUfrjtG9ajcI2xWARIsWuyB+Ayyhp3OMIglyXtspeHVyj3BkgieMOZCb18qimmq/
 zOexp9R/Fb3gWEDU0uufk8qlwmk9SSf9puktV4hASAZrNWk7qypsC9RYPcxkm1wPLM9b
 0+7AxIoRBPHeMAGS3aey3CBfW5yftmEqNA8XohvsjP/SmePKJR2xfJlX99aiJ9PMySH1
 NPALrdNnAifVNFBPTlwum0ur+cebxra4VsDklY8a66p5fT9xjBjp1VYG2fcXrdPUhBvf
 s9jbeQoZEH9GVuunt2ne1VgoA2gnEEn3Xo7ZdG+nC9oJ7Z/m8Ez40hIpslpXJZwgJ7+m
 bAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773922351; x=1774527151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=baWfbRXsKflr2jzBiIdSLJdaYlUjsJoV4djDyFz0xvc=;
 b=bQ3nj9HH+zPPi5NDuS6/aIinT/pb3zkARHwMKu7eXCt4IjAjRaQBEBu9DvY5n0P9bw
 WLxAMyCWybKsqoLi1hF7q/3oRyjR8CRC5Dj73CGAlUpS0tEreVytV5X4OFHzUKPsAF3p
 rZqH8MtXFWGC3Wp7eC1q/fCgAr1P+H6TyJs8S9Iyj45WTOSbCTPa3L1ltRJ4H9C9pmH4
 xgo+yJEEV8p2I3F9bRnNouSWhOQHKy7ewrUcHzsz/SoKTScFxA+fMnTEZC3J4dHE/HtE
 qNJ71AF85UMs467ZkjmBuivxhwT+FK+fh09sj6A/yEOLwSsuMQZM1FbGaYrrme9RF8+q
 X1xQ==
X-Gm-Message-State: AOJu0YweUDCdLaa6Dz9uMEQI8YmBYAQgDq+isMzXfC3KKR2+hatiLwxn
 6+tQoDoX/+ZXjhk5KAcyliCyN5ZvPhIympnjyVo/opw0zTEmVhNWJ3GieRX4jhCEDDcwXDWjpng
 ZdswfJ+QOIo+sPfGsrnGLcsC6mnNz0P8bJsCRVy6xTq5dedT3jInT7604Zx55R0n8cSe6w+4=
X-Gm-Gg: ATEYQzznIqQunhn9OB8RGBHofEOuyvne+bjgRNydFwL/5qtaeDI7hAMOUlp1XSGhV9c
 V3MfL19V/OYvQkqcuV+IfmHPnxbNsRQTvSq+3wXmSg7gPebnW2wrFXr3+Ga6XTMRyFq2fhLdE2g
 PmlWNcs87YcW5RZk1u1/1Tah0VbATR8TXH8XjnpOD4fih1cGxuESzrJuFCyk6Dx75as2ck4/Ovr
 a02i8sAt1QZMaPD7TVIOZbmz8rA/bjG/z0AG8UjGb8t3/FuAQasQCzWfuSvLiAUoGrLNUv09hHl
 bycCNMhD2d1UhALtl4kVoVzBFFA5o1OP8xdENfX3QeXOdsUI5veVFa9aBWDYXAjRZ4zcfWFSZKR
 OEgEPs07Q21EwUPT5kBu6F1OpcJv8lXQAiEPhQq2/K8aR90dCEwTT5RLyIAbX4aOh5PUlx2hNPd
 MmFdY=
X-Received: by 2002:a05:6102:1682:b0:602:8894:b76d with SMTP id
 ada2fe7eead31-6028894c2e9mr809586137.4.1773922350412; 
 Thu, 19 Mar 2026 05:12:30 -0700 (PDT)
X-Received: by 2002:a05:6102:1682:b0:602:8894:b76d with SMTP id
 ada2fe7eead31-6028894c2e9mr809583137.4.1773922349980; 
 Thu, 19 Mar 2026 05:12:29 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl.
 [78.88.45.245]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f17036a0sm432633866b.49.2026.03.19.05.12.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 05:12:29 -0700 (PDT)
Message-ID: <9e8e366c-c48e-46b3-8d72-cbcca1c48008@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 13:12:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/msm/dsi: Add support for RGB101010 pixel format
To: Alexander Koskovich <akoskovich@pm.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-3-85b99df2d090@pm.me>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260319-dsi-rgb101010-support-v3-3-85b99df2d090@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: V8LdbjqdiQjAok5z5gP5eeBRLnCZcEHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NyBTYWx0ZWRfX4vjWFH8dbaIq
 bbf8gP9IFTXtqfbB2IUgWDR5VzH5syia3AvBKnj1+a7RlWK/cF37N5SzdB1PKcrib10mp850PUv
 czVVGQ3W724dbHgTCfhIW37A75bbNovINleTDjjvqjToVq3kA/ho7hRlQmZ61cff0665FX3Crrf
 4+nEgv/xcRYakyirbBvOVZKogTcKvFC6/NJS+yfMfXZnh2q9HbbO31QVKEcDBhU3FdsgE98CRCp
 +yGqt6nEwDyLISRweqCWNCdu25RhFArajCO32WrKcD9cxmBqFj/DNWfm2KVoxCwkJk1yUYuhuV4
 6y7sHYaKDChuNdjNXbBU3746nvtTsA4wtBjH99XSM3aPHMVWNdpY2y+NXGKdTr89ss1Ongy2Two
 2AF+ywfzn2fkK2Hym1iF6h9oFqYlfRsqJf8e+WZjp6cC46U5Dk77/Fw5ZUBP0yxSMjnkLnC1mzf
 /uqkEIERaIJVMUAK2hg==
X-Proofpoint-GUID: V8LdbjqdiQjAok5z5gP5eeBRLnCZcEHs
X-Authority-Analysis: v=2.4 cv=PtCergM3 c=1 sm=1 tr=0 ts=69bbe82f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=dHkJIz5KlUVh9OC2PNkA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190097
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

On 3/19/26 12:57 PM, Alexander Koskovich wrote:
> Add video and command mode destination format mappings for RGB101010,
> and extend the VID_CFG0 DST_FORMAT bitfield to 3 bits to accommodate
> the new format value.
> 
> Make sure this is guarded behind MSM_DSI_6G_VER >= V2.1.0 as anything
> older does not support this.
> 
> Required for 10 bit panels such as the BOE BF068MWM-TD0.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
