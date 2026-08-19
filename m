Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FEBC5DF7D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 03:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B33810E03A;
	Wed, 19 Aug 2026 03:23:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIj+EX7D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YfcDvKKr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B316A10E03A
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 03:23:15 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J2lY353507954
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 03:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WtUkidXAHsAtf2q683tbZrQMA8Y4N68xpw5aqwFTrYc=; b=gIj+EX7DG2A9G+Cm
 bYLzeJziUIJxdojXGIz5LBWIByO+8fnEhfMBkF/dxk3oil/upPUO8JRCoIkWflLe
 lZZK1lUhQ36toIeCDGNjc8Rj9wx9Qs7+1mA1qs4PEa1aIwot2kekC1ohyBFp0O15
 yAEayAqvYvjMZrAHzjkan9bOQX+rIL9yblsP0ZUO0h+hjig+T9VdtTNK0/b0Yy/t
 mVtGESKYtHQ5Fey3Na24iwX0ywkFo6rVrUOVTic53Tg+S6gQ8r4TrwusnepceVjV
 2XRdrYjD5Ao82Nv0pVk2DJNg60HDDVW6EO0GudjpXx1iFNu+4gco/vIxpnO0C3Zz
 3bclWA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm92hp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 03:23:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-848474825ffso600571b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 20:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787109793; x=1787714593;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WtUkidXAHsAtf2q683tbZrQMA8Y4N68xpw5aqwFTrYc=;
 b=YfcDvKKr9LRRqTIAlJUxdRDcaj5eE3/ebab59Fp9qyMMSEQkN4vr27z/rvkH4hHt/d
 Yo5Se2MgPIzGuqil7VQQs10AgEY1orzQW0H9dxuxuEIEo+B7jGDHT6EBHSdVTtXCR8PT
 rSYDXFNqa5J3LbsTmUBSh9UgqTAGArIGsfalR9upAjWoBcnkzUP5qzmBUn40BKFr2gqp
 NKsU6N6mvTRe6upbu+oBbcZq9/ODmynyk5R7DgdLnUfZLgLt6scPm3cv8ykrY3Ae9kN9
 KBHtQD+rCFOl1C5+vXv4M7qYYWrWDC3ej12HZX+Ii32X+RpGIOXNS9IuQWOGTKrUrit3
 Tagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787109793; x=1787714593;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WtUkidXAHsAtf2q683tbZrQMA8Y4N68xpw5aqwFTrYc=;
 b=pbvbPW+2MsAzlg8Wvs3M25iPVuwnVJtvJnP7Xvd43RRXJIuSv+0wAtM/kbbRnTxE4M
 zDzaqyIedpLHonXigNpCNPtYsFZhADjawR2J8w5A5qBfx2Shl8x0spsxuvVnZFBwZ57T
 jW9STJpsuJGZLw2TeSlR7XgCiQN7gY/tWP4AdEmW2FuxW3cM9JAsbz3d6AYoU/ToVQ6W
 OggvHmk1QQaagmsKWbKR+CmShZ2C/cNEzBpPFIFoF1k27VtNj3w3DtRJJ9OgsiBDbEcF
 OiQ4K21c2LylWQDkSDHUo7XmNSvuoYchgkt6YQyjbJzHIEkf7Kz7BhejzgOJVPxnfnVj
 /tJw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZhQXvRdrs7MC0qt1PR97puGf7vkfdJLM7R2xzA919xWyfvg/IFBERisRufTektDEs9oEVXYis2UM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIErDX/uNJgQj4fR1GruRMa9tgsM7dwTj5hCR0Hg6c4xSWlWY/
 GF5/Z4Boe4mVBlmJWpfG6PFE6VoFLGZa1Muu/eM902H3GiynMiKwpchBZdCCZQjbfnu7Z366OwA
 eTmFDZxL063/X41qNorejwxnqC8F6db2zYYjVK1hy7I9uQ57rFIs7zi+F0Xof9JDyiLzuqMw=
X-Gm-Gg: AR+sD12JR3KaTf5E/FWJ/GIIRG0MKROX8mVPVOn5/8m31JT8NqjIotCI0BUh+C8KMyr
 bLp3pIHm7R70VLuWcfr58v0mATvTcCRgsnWeR2RTaLAdbOm/AdSnKBZbT1LiXqh/eAzLlEX6lU+
 ZbTQwXIPcMqeax9wzzLUIeiS6e5VNUXpSJz8oUkmxRcjpbVClWeOjTHIAJLak2uUiQKi9oQmVIg
 GVdyrm1wsl2LM/BmoU6HoI2E4Km0uE1fcVAe/KR8fCvbIJeagK41BNWP29Z0/lCbBEiImI08dB7
 wxW/H400P8Kq97tcIaDdZgu/i2guhnGKklpaRNb0liomiq5ljHkJWALAw2NgB4/lTTMO85hNhow
 4Y2vbPn01DY/78B39Pbc5h34M0NA=
X-Received: by 2002:a05:6a00:1890:b0:845:3033:6cbb with SMTP id
 d2e1a72fcca58-851d18a2cb4mr1785945b3a.11.1787109793548; 
 Tue, 18 Aug 2026 20:23:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:1890:b0:845:3033:6cbb with SMTP id
 d2e1a72fcca58-851d18a2cb4mr1785911b3a.11.1787109793141; 
 Tue, 18 Aug 2026 20:23:13 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d3392a96sm124241b3a.20.2026.08.18.20.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 20:23:12 -0700 (PDT)
Message-ID: <f4c52f88-ddaf-4cff-a235-d51cb2c38786@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 11:23:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <b36691d3-e996-4fc0-8955-25beeeecc385@oss.qualcomm.com>
 <ccab8aae-d980-423a-b39e-3ce2a7c82542@oss.qualcomm.com>
 <5341e732-0deb-4d00-9a7c-595e317bf1e8@oss.qualcomm.com>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <5341e732-0deb-4d00-9a7c-595e317bf1e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: VqqTBCfLHEn91EtgH6RUbWEEC2EJc6-t
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAyMiBTYWx0ZWRfX4Z6uYCyj2zQE
 YLPu67XaQXTd+Kt/lYAUhRoK2id3QGZCZvuZL9FPMpnmpy5JGPKFPookKbqqJBxiqlVyXV3yZPJ
 8d/YjPWAFv+OmrYBTEwKNjcNBi0OTN8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAyMiBTYWx0ZWRfXzMdb3Izq4OoJ
 Dps5VsuTuZzM2DFW8Nf9GuhXNj8OC+w9VVPmf1i+NOyLHkdBH4lgE+4MAAMOX4b8Fmxr45/NuFF
 59cRLW/1H3WyT9yXDc6sqpuQ/H9CyUiAIC6vREnF+9NHtF/NVgudSOs8GfTaToGuvrl975kU6gs
 OhezT9rVCZHMVAnOPsCpneEvl3d061m0XumhAc8PKLa04U5s5jh+vxijnqoIsR/D3dgS0AeFoFd
 3dak0PKVBFGZoWQD43eLCV7YykwWmOuCLwYA6nOXTsqhlv9dxBnCUiuOzVj9PxZip5zuLtavpVT
 Mp63+9JO/7LYuiyz6T3TtklGkEkuCIqEzSSYetoNyAg2kxIvQv6Sy2BtpXEy9LdqEkN5Yv39xsi
 j6n2IPsQd2YCD917uB2feD6eKC3GDlXeVYTVrL5VQRyG54eqOW1DbAvRhwfrru/y81Q/a2vopDI
 Q0C2zd06cKmyBpzWDVQ==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a8521a2 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7SNk80zgYqIXXrXIq28A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: VqqTBCfLHEn91EtgH6RUbWEEC2EJc6-t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_01,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190022
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



On 8/17/2026 10:13 PM, Konrad Dybcio wrote:
> On 8/13/26 9:44 AM, Yongxing Mou wrote:
>>
>>
>> On 7/20/2026 4:49 PM, Konrad Dybcio wrote:
>>> On 7/20/26 10:43 AM, Yongxing Mou wrote:
>>>> Kaanapali (SM8750) and Glymur use two display power domains.
>>>> CORE_GDSC powers the main display hardware while INT2_GDSC
>>>> powers a subset of SSPP blocks.
>>>
>>> Can they operate independently? Does INT2_GDSC need to be
>>> powered on after CORE_GDSC?
>>>
>> On Kaanapali, my understanding is that CORE_GDSC and INT2_GDSC should generally track the same state, except that INT2_GDSC may be powered down when SSPP1 (VIG2/VIG3/DMA5) is unused.
> 
> Is the MDSS any useful if *only* INT2_GDSC is enabled? Can the INT2_GDSC
> be enabled itself if CORE_GDSC is off?
> 
> Konrad
I No,  INT2_GDSC can not be enabled when CORE_GDSC is off.
