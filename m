Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869C606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=murfKBxV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OTS/1wDi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9E410E225;
	Mon, 26 Oct 2026 13:10:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB79410E120
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 13:09:58 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAsuon2732724
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 13:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n7yxWtPMUXi7IWlyGxpU0TZfSphuR8DxMIcDIMKDNB8=; b=murfKBxV5uzBPNCR
 T54ppeH1fTQLM3q/mBgRjDF8P1SH6AV3rdnDYWH0i3t5OJ4iY28DaWIC0mFxcNi8
 vIUm3Xi8GEy6U1GLXNSYwCfDdsmcWOf6r1tGAwS23/MyH3LgIKQu5bGDcqsukvzm
 O7zJfhIsDdGbP4w/2nm8TOW7PClBA2eXKAlD0ygEM72cSir51B2owyLYK/gLmcKi
 u6IH4uc9plP5f6e8X9gbHpgVL1tsneix2Ae5+YHmzmJ+mX7+S3bAiTlHjc9FXxkM
 AWf6368sFLrAjH9BrUG3rB16k7h5ia7hPV9HOkOGcv0zD3ajUxcGqMBsHOfQHH9U
 uRiOhQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cp8st0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 13:09:57 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6e0063e7a02so3569461eaf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793020197; x=1793624997;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n7yxWtPMUXi7IWlyGxpU0TZfSphuR8DxMIcDIMKDNB8=;
 b=OTS/1wDibWCiO5u3Ko9iAc74NxLQzEIR7MLZcGUkBOHeMToOK551OgahZD6SPfwkLa
 qfAdyJkvDDkrdBQ4M6Y/vMhLdSFfBqCikaNxjsJtETkz0JVQqmcGxavi56twnYECemuf
 cHPFZ4Oi48Xsge/6nP/CHpGARQjxhnlKTaQeWVppF7j6L07lcXZJkBZkEyjnyXv4PK80
 C6a7TfWNWRAM5JSdkDTlm5otDeu1z0cvMK6AaSerne9X+QcdYNYc4dm75aC8RO+L/nkp
 CX3xveAmkqkx6/Wh/EXHM+A4kAOrdE3wY+a8/j27qXXezY5JELZtLY+rQLQqdo1oqA0n
 aLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793020197; x=1793624997;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n7yxWtPMUXi7IWlyGxpU0TZfSphuR8DxMIcDIMKDNB8=;
 b=Cz4lL5m/JeteZXTGJj5GYVbgblZ2IzXhfvseMD6+R/d4K+pP43k+IUE1HIomcx0+Mb
 5zE5Ijgu47d0eqDgMX05KF9Z3QTN8tmUsy+HZPeMN1+F6rMrcgfsN7DHc9HxZJaa6W3s
 WRcw+wNAZPSS7y3PqrHMEPt3Eypc//va+0dh7/A6kzL0puz8IBKWwKg2c2WHYvu2JUBU
 N7crDd/QLnzyCoW5l95ov8ASk7FpDRIWLLEO3ChSvD2of1hLSQ4NkXKYq/+heKBUbCuu
 PC9tDc+SMDiu/I/5S07+TTHxGjuBUge2K14+hMliN6ljx34C8LiA5amtT0Rk6YcpmL2T
 CLYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxs2TXh8ta7GMpQz7jpxbQLk6GIKYbLyzDAJq+WdAEu1LLSN0AnvCLgtpUKWfq5/baXqkdgyQXd5QA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKhTgRWbn+FblOlPZZ+lH1tIprdR2ap6k3D1FEa/I6W3Bi8ErXc
 sZiyrAOPTUc9oD69JShq9Qiiqiy8w2UCaO+lqInOc6Loo18xfFHEA546SuIWmP2QEifQV4zLjr/
 RdP5w97F8+y9PeaIrxbxOdy/Es8BSYSKAUDjpXgsfbAgEp1n/UO/lspzMlr+rzYgWyKPPneA=
X-Gm-Gg: AYBFou1zfXhn/QFnCb+FX/DjxjTq/UM2L1yPrRZgTjdcoe2Or5rAgjTTm4WM9ZkkrH1
 blg8NwHxwbqPfWJV8jmq/velr0u9cd80G02jz65Xx8s+/RCKg3m1YgtvGwxDTwko6QrZlv4aSOr
 0cBcRIENZiwB37Ygv6iCofpForapbAOUEO/hDIViF6PLM93nUk8LMlv69YpFUdJqhGYqAUP+UYy
 S4nCrvHpexi0jwEVVZWjtf+E73bI28oofCcUBcZrAQp8fCvNv5JvcthC7oBDCKvYD872HFIz41J
 COq+uP8hXMIPgthwN7gv8Qi8eUsX5VyJAvCYjp5GKETakyM+E0Y+JJiesxZXYRrHLdywZ3mPXz7
 n9re+Oc43FsDpIUO9MQGAADNdgpMi9yEYaUNbBfEJ+naf+MmZIH44Ln3OdirRaUsgFU8tRXSdan
 sgK1MgKTCJLqIvS7CDuDFjAAXoQTI=
X-Received: by 2002:a05:6820:61d:b0:70c:f411:409a with SMTP id
 006d021491bc7-70cf411484bmr1858248eaf.60.1793020196881; 
 Mon, 26 Oct 2026 06:09:56 -0700 (PDT)
X-Received: by 2002:a05:6820:61d:b0:70c:f411:409a with SMTP id
 006d021491bc7-70cf411484bmr1858226eaf.60.1793020196412; 
 Mon, 26 Oct 2026 06:09:56 -0700 (PDT)
Received: from [10.190.200.105]
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-70b9e163a5dsm6838618eaf.8.2026.10.26.06.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 06:09:55 -0700 (PDT)
Message-ID: <0cace778-b68f-49a9-b52d-dc632bf3a0ea@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 18:39:45 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Laptop 8th Edition
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maximilian Luz
 <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-1-406fc042162a@oss.qualcomm.com>
 <245e5eef-e18a-4ec5-b57c-65e561101351@oss.qualcomm.com>
 <52adff3a-370c-4445-9797-e0b0dde36fab@oss.qualcomm.com>
 <5568fd0f-e412-4f2a-9f1e-729a469da572@oss.qualcomm.com>
 <65f6883d-8ead-4c6e-80f5-81f6857df0b8@oss.qualcomm.com>
 <f624b075-df3b-4862-8231-8fcae7f18d50@oss.qualcomm.com>
 <5cfc6414-735d-4df3-868d-c8c3c4a98e30@oss.qualcomm.com>
 <5478c0da-e28b-4ea5-9b7a-f7aef2c7f437@oss.qualcomm.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <5478c0da-e28b-4ea5-9b7a-f7aef2c7f437@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MiBTYWx0ZWRfX7E1mf/hRexi2
 F2tcCmR9U1+AVZ7i/wI7P09Acgu61ZcFqx5wfQP1wk8EFLVDfRE8tMO3ERieOkXfv6oQ0sQp8zd
 jM+kRKOz9NyjPkR8n9OUJCTDwCjv+J8SsXBG0xFlVzvkeOeoq+s6al6dl88kINWzsRoxlf+P0Q+
 eMaCfPuq+zWQF2Y80ZoaotH012g8duqJnysBBPLGzNc6gFDypGPb+BzQ6+whC7yzAL9BFy2Q9CA
 ZqOcgCh/LL5fcYOnqliJyBSOf+EORkyjAqhabo9bxFgIk2gnQQ2rViNR3U3LuP2efUC9CMO6k4a
 rohrz5xPibG9cEjprVDYFOniXhj6gEIYDpcUYwPIYtXKptDCgVLkDKjMH+K3xuALVk7NPmv4SP/
 DQr/DKolpPQwq+4YigL7sMHU8oF+95ZG+/nAPZYnRlKA86P+4MW3/1p0Qo6PhyEv0gA+41Mn6+a
 dy7PQRwhdWPByQuATPQ==
X-Proofpoint-GUID: 2HDyLCgj6EwobM_WRGARPdDNiIMnrbtK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MiBTYWx0ZWRfX9i5T2xTE6fKa
 /M1pfCkauZNdZjPPVYYvxBbpZQDRfwczNyvFdtn65d/BoOpc2b5TyL0O1pAKggaeZ0AtOjyA28p
 rQa6TfWQ+pqiY6yAktppN1ihhA4eKXM=
X-Proofpoint-ORIG-GUID: 2HDyLCgj6EwobM_WRGARPdDNiIMnrbtK
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adf5125 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=orzTaoVzejLQ65uNlDkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260052
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



On 10/19/2026 4:02 PM, Konrad Dybcio wrote:
> On 10/19/26 12:31 PM, Konrad Dybcio wrote:
>> On 10/16/26 11:26 AM, Sibi Sankar wrote:
>>>
>>>
>>> On 15/10/2026 19:02, Konrad Dybcio wrote:
>>>> On 10/15/26 2:47 PM, Gopikrishna Garmidi wrote:
>>>>> Hi Konrad,
>>>>>
>>>>> On 10/13/2026 2:09 PM, Konrad Dybcio wrote:
>>>>>> On 10/7/26 9:11 AM, Gopikrishna Garmidi wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 10/6/2026 3:20 PM, Gopikrishna Garmidi wrote:
>>>>>>>> Document the Mahua-based Microsoft Surface Laptop 13.8" 8th Edition.
>>>>>>>>
>>>>>>>> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
>>>>>>>> ---
> 
> [...]
> 
>>> microsoft,surface-laptop-8-lcd13
>>> microsoft,surface-laptop-8-lcd13p8
>>> microsoft,surface-laptop-8-lcd15
> 
> (FWIW I don't think there's a non-LCD option)
> 

ACK, I’ll drop the lcd suffix and use microsoft,surface-laptop-8-13p8
instead.

Thanks,
Gopikrishna
