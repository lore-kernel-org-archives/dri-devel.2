Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776A606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KY82gwWr;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DfCYaBL7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCE110E5AB;
	Fri, 23 Oct 2026 09:07:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDEC410E5CF
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:07:24 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7F8UT3154072
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dqGyeZV3oX3j3YBuq5s/ny+BKNGQxGrSV/QQaPdBNdA=; b=KY82gwWrd88cyQoO
 N6VlcU0gEPxvfRxtihd6fFVUqe/HVjFBPuj5QU6HCwf4iUSVGmrmoodDM615Fv/L
 5WF5N8yYHJ3QOop8lFziY7+6bQQP68JTtZSiwhEW1ppn2yQNkLNUeyi7xPEqkF6D
 aJYeZK9W0tXW2vYv4rk7a/kLW0QbGepz1AqaX4JoB7b4OQTDjLxNtOAmeXc7ZWDE
 9Q3sVrH/80ogpAiFWvkTc0Ol08FB3G8RqjkNpCWqj91cqcXnVgX6Bu9ICK/M//aY
 czsMLj0lcdJVA9Ff9gi7aygTYcUW411MmtqbYTOPS6JT5MQprgdcav8W7WoQbqES
 OhHC3w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrav7a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 09:07:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9179ef12a03so3330636d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792746443; x=1793351243;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dqGyeZV3oX3j3YBuq5s/ny+BKNGQxGrSV/QQaPdBNdA=;
 b=DfCYaBL7NEJMll6Z4C7dmPJFtgTBaJSPX9+2xssL0EEhYdP4CvAB6haYlJ+7NqAt4P
 w0GdQKyaUzSTtlWVXAf9ZRekGpbDBAOuqYWxUXrho2UEurg1mqz5sQOD8gNDTo9l+PFX
 3T+TQR4IwixY0H/FlYGuTd1/WMk53/nj7EMIQqRAT92+9M+nNReW5GYWoV2kPv6kFl8i
 daXx/0WlC+jgVx7sLhs8C7B1DVdm2YavweCMXR/7FFOZeZOJwmDd9iU3JTuWRnX/OQY4
 LIxN+REsnjMhOhnKkYR3jBbgik8vts7VIXFSNmf1/AAaWRChIwEn0901KYKwLPmWrIU4
 knFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792746443; x=1793351243;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dqGyeZV3oX3j3YBuq5s/ny+BKNGQxGrSV/QQaPdBNdA=;
 b=r6ZSBQIUz5+JStM7nuV51qFnLFNDDEyzjejs1wj6OqolE3PJml3qYpycBuh9cmOmJy
 j9qjHEO//1/JQByTV8u9esVfadruCZoyqRYhBEI91il4DKO8iPuE1xALEMurSus0GM35
 bDVApw5hYnsV2Lh6rsG/CQwixxe3Zo+HQgeARNWsalw7vQa5wjIdqZ/McRJK0JMZYYWA
 jbkj1c0n8EYqLrKagxsgVq6sIj6raCa7kvdh/WY1hi9ySbk/omYxuXdq5PykiuuHJFSV
 kcqFYNXOxsfEFEXR7NP8myRXWg/XtwsSxtXJ4eUuxwruEbGM4hg0G+KvmlrxmszJrWRz
 jVmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDQzf9iVf3Z0HlqP83zUWCXNqDTpz1HZWIhN9IAIOouwwMXVORpiQtATx8tNZa48TKfn4s0uLRAM4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJfnwvr+alIAkZ81g9PY8LMw+saSTwh1CiiidKIOpBa2majgFT9
 iakI2wRlGdmei6hOYUQFmGNQNrOPsM9pn3NwUQchgv7p00w3X5NE0t55gxbVTXuWFbhydrwZmIP
 tyI4I3b+1B6yR19hHd6ARX/FOrEUq+CQAV6kE5GXIH9YVOhAsmmJPlBNxuD7MmAZFPbIK0y0=
X-Gm-Gg: AYBFou15M4vv3RLnO66D6kOjF85IbgGEJYYyEvU6Ske7LtBjAOzOke/EoQquBWvcKSv
 8K4BDTdlNr8GB+FSAL+aYWTs8CVJiybqAhjRxGiaWnny3Z1GZnv9Zqi9lMQSVzdN13zhM8lCPdD
 FIc5guC98DK4naCKqGCjxUyFQrAd/tG5w7m2im0aEuiCbOjEa3mTjV+AOAFsgGfH2DhSnM1FNwt
 9/Ayw+G72FGtaM6apmvr2K99BQIKPQjUtyz3erb2KIH8foa/Ej5GiQFAZeJWpan5fyBCCMGQzkQ
 CPe7hHR601VBSkM5ubRKK869Thg4cZKvMsfdlaQb4boJ/Wne/SGD+/ltgg52Zl54J40q7TqaYhQ
 3O3N54uv/KdVtE7NIsdzGbQ==
X-Received: by 2002:ae9:e507:0:b0:93f:211f:7ba4 with SMTP id
 af79cd13be357-93f6fa10fabmr286065685a.5.1792746443059; 
 Fri, 23 Oct 2026 02:07:23 -0700 (PDT)
X-Received: by 2002:ae9:e507:0:b0:93f:211f:7ba4 with SMTP id
 af79cd13be357-93f6fa10fabmr286062885a.5.1792746442626; 
 Fri, 23 Oct 2026 02:07:22 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5cf09c7sm80166066b.77.2026.10.23.02.07.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 02:07:21 -0700 (PDT)
Message-ID: <81d21974-9242-4caf-8792-bcd8d59d9191@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 11:07:19 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/msm/a6xx: Add a bandwidth table for the Adreno
 620 GMU
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
References: <20261023-adreno-a620-v2-0-1d654c3f52d5@brar.si>
 <20261023-adreno-a620-v2-2-1d654c3f52d5@brar.si>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261023-adreno-a620-v2-2-1d654c3f52d5@brar.si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NZ8x_T8bVVsNs4c9YL9AuiB3OupJxD9Q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfXzi+EtvERTZaC
 GOtXo780L2M/Qs+SIpIDFlgHJaUdjEA6IsOge+hdnld8uEV01wVS2doKNFpurre9IjsFQdqCMKd
 NZP1ZlBx5HOc8ytn4S74YzKPx5eFrx8=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb23cc cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=uaad06dfl4CJDRj71lEA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzNiBTYWx0ZWRfX+2BXiTrUNaIm
 AqULDrJn1EP0BFIpW9uVSxMWOT98SlY/Wi54nOyiRWJFFowMIqwevG3/FdKlywavM5we7Z2Hn71
 n4RxsY0ahwMKnvQs5s+SMm1TBW/tANGQGa11D4X/LF0iuqllU5edhpmgnuUroTOLiPKzo7IznqM
 CcSLfomfZHtVNuzGC6fNUYj0qkfWXil0yx1E72UkIPYBBIYJOn6anjJXbUsw8K2ckkQ9i7e73ZE
 +1UybHau1HI0tx8HPyd+1OHs8JfdfcxM2pJG9NkvBprbiWP4qQHmnhpE+4ZIh06HZzpVIECcubw
 XMjzkWzlCz+3o3drZ2EGers+toK7GCobTgVqc7cCMAaU8QdRSrjy21cXMEICY8csUbNGV5wGYHX
 SMGr347WbJgFQ3Ces2hE7C4iYZRi/chiz89ENuxr+igXVQGzO1y7xgqckoQaJAw0Nryu/k32GML
 135M+7dgh0rmkXn8fKw==
X-Proofpoint-ORIG-GUID: NZ8x_T8bVVsNs4c9YL9AuiB3OupJxD9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230036
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

On 10/23/26 10:49 AM, Ishu Brar via B4 Relay wrote:
> From: Ishu Brar <patches@brar.si>
> 
> Without an A620 specific table the GMU falls back to the generic A630
> one, whose BCM addresses do not exist on SM7250, and the first GX
> performance vote times out.
> 
> Like the A650 one, send a single "off" entry just to get things running,
> with the BCM addresses looked up in cmd-db. This is only used while the
> GPU OPP table has no bandwidth levels; with them, the table is generated
> from the BCMs listed in the catalog entry. Add adreno_is_a620() for the
> selection.

Please just add the BCMs for your GPU:

.bcms = (const struct a6xx_bcm[]) {
	{ .name = "SH0", .buswidth = 16 },
	{ .name = "MC0", .buswidth = 4 },
	{
		.name = "ACV",
		.fixed = true,
		.perfmode = BIT(3),
	},
	{ /* sentinel */ }
};

You can factor it out since it's common across many a6xx GPUs
and &refer to it from the entry for a620

Konrad
