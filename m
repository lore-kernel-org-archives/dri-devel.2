Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230311061B20
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 20:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800D410E161;
	Mon, 30 Mar 2026 20:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eXvOf1TI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N+kuopon";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3799210E161
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:27:36 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UIwfSD4053882
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EzrJyb1gVN/4tm0vA1K96mY4OKgfW/vr9tGl8NUqDQI=; b=eXvOf1TI6dbzFYA7
 YvK2ZIq5YV0inm+hOZ0OjAyLbPu6mPpzwqro5GloE+xCQGJtfWn8pB3B1NXHFLbA
 OQJVVF8zIKl1k3/MAmHSulaBXMeMyPVMW4mp0psAEPkHjpHLl398mK+xxzFBdi18
 8113PMT2N7PtZXjPDVVksytgroqYpl1Xh/2Gt/CCxaIymz/y73ymn5lC3WZXT7eO
 n3pS+6F6wF5r+Uiiefzmo4t9mvTQNYqhtxCMcHSfz6KugKzwxN+KVZetb+IO7rns
 ZqZKnVz11vNkGnFU7DQ8ZQVcbaYjVp+5/zIKjDSMuLWf1JTaawQXi2Bht4CBn0tt
 E4HbdQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7xx389fs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 20:27:35 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24a00d12cso21739225ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774902455; x=1775507255;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EzrJyb1gVN/4tm0vA1K96mY4OKgfW/vr9tGl8NUqDQI=;
 b=N+kuoponcTe/oq1RCbnWXCt0wCAAz+b4EFZUiZiz1p0pXXA4QVcry4iBCm8byd/ciO
 hALTtDefudRlMEoBPjx1ccqmZ7lWMLtEqBe1Sia6TcwCstNpdxt5ViIs5ETGc/tFe3Re
 U97HIFUda3MK49Vk8mvNCXTp7m1rEep+g8XRgLtjp2zc2zaDw4cONjjgR+oTU8ISmMq7
 azxu8SizMZttJtF0GNjrozXyzfh/iEwcvLD52bI3aykXE7ekZ5TyWF2Czra/Jz4owDe4
 Vy62RDOTGyU0ENxuXIzI9dG0RRLLEZvxTjGTOBnDn6dvslRJNyd7sNTbEXnfmfyx4sSs
 eqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774902455; x=1775507255;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EzrJyb1gVN/4tm0vA1K96mY4OKgfW/vr9tGl8NUqDQI=;
 b=IC3ikgzF0Yy9EqycCIn/7hI906z+cqXOzErpUPZviJR2jR/HwIuq5+hIq1/i26hH1m
 IlfLyMvxjWyV/4bYKU8doBzeGHXOX5ch4i9bi7UZft0z+Zbi3Tt2/Tr57J/FzQEP9wuS
 +kHdmXIDXAeqhNa3rlMgYTRRqirRSXDBp7zFWStyk6Q+jdQS/mD5WYxo43rf9dQESFBw
 pbN2sIo0KctE4/zQvIUGN0QQY0tM9ciUGdPImW8PSGyGnNO7QKkXmEQkITQJgM6bmjtq
 295rfeGpnf1VhWTH7GlUv+3GmEL47ydT3wamBHtv95jcuTq5Bg/TGMd0ofAmVPiXOJP6
 xxSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlfPzfSE4JeiwPexGJPTTLM5HN1NeHXVEcmqsfZDIx+PeV/ntLjOZWFsW4rPMhlryyRNQrzLcxMy4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjfKXz+Qr46/ZoE28dA5NEU4WFnNlS3IkXZBkJtZlGrnVvyGZQ
 Rc76dM7cQot+nyHZSXIcH/NryxyrVlynSl2rbn0jSm6kmJID9c6blrPQ5q5PdDDeQOW6rbtTgKv
 YMstyGSn28RbcKajv2lT49d15CrWAi0RprtFEcR+lrd/wjAqh97WohoTMjWU7XCziOVI8UL0=
X-Gm-Gg: ATEYQzwjhsdpLz9ukRkXcPRPYQeg907jBWKLv9esVmvk7y0WNDbd0ETdQAfu+Qn/Ofk
 s+gud0bIO4ufXV/28Qtc4UN/igaRIWOuy6LBct12zPOzxTquTAwozsCVZR7PXzGGOjXYJgRtWTj
 zpJUK/mHwhj5TBQWsP0H/BW9dYF48uc5tgC6VVtn0JaIhBET+flbI5enPQzZbJ+CtR6bbqw2PDq
 /4l2lSVxEr0c+c0xzwSQ5Ph9DxKYppvoUfwFu4iEvSamyiLYXW4DY3gubHSo0q2149bu8DZDXYO
 zhF3xhKNCRZG49JjADwPgpEJUCy4i4KYljCUmeF+3MzwYA/lhD7F3NmvZltVVtaAhlPDY9Uo1y+
 zgynAj/ekuT4OpdblTZEXPpqtx3iQJIDJXgkuDqdmh+Ec
X-Received: by 2002:a17:902:ef0c:b0:2b2:5637:149f with SMTP id
 d9443c01a7336-2b2563717b6mr43048785ad.23.1774902454929; 
 Mon, 30 Mar 2026 13:27:34 -0700 (PDT)
X-Received: by 2002:a17:902:ef0c:b0:2b2:5637:149f with SMTP id
 d9443c01a7336-2b2563717b6mr43048495ad.23.1774902454453; 
 Mon, 30 Mar 2026 13:27:34 -0700 (PDT)
Received: from [10.91.121.222] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b24266e487sm88192835ad.24.2026.03.30.13.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 13:27:34 -0700 (PDT)
Message-ID: <67cca0c6-669c-4dcf-be3f-76fc46d1e59f@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 01:57:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/17] drm/msm/a6xx: Update HFI definitions
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
 <20260327-a8xx-gpu-batch2-v2-10-2b53c38d2101@oss.qualcomm.com>
 <3465929e-262f-407e-bc3d-7564787bce3d@oss.qualcomm.com>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3465929e-262f-407e-bc3d-7564787bce3d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ErbfbCcA c=1 sm=1 tr=0 ts=69cadcb7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=IYtLGEtn8_M1e06QnFgA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: g30mFyKO6JgSt8J4Lnyu6MrEkF1urUY9
X-Proofpoint-GUID: g30mFyKO6JgSt8J4Lnyu6MrEkF1urUY9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3MiBTYWx0ZWRfX4/xIdytFH7PE
 x8ndfpoCU6M84sQWFelFH84QgyW6nTrrddnlCPBiU13us0D8hPIiWeYk9Z/jLsVYiGkV6Y68djv
 rkZszphowZH7j4EHQfG4VlqFEjdjhkfBg5nDzIcD1VsvcGPGvpq51qj4mh2q89BcPsYoIlFDgux
 PP/URskTyB6LPpzdI0wK9RNKPM2pvWl80qSKi3r8KrpsIW39QpNB34L5fmNjU2YzTAkxAfoTqZ+
 QOyjCt+BAqxB4Q230TVO1HO8R/1xK8P6/l0xmyZxXhDb/HwGbRBUZa1mnquJUdhfWj4QOgD0/iY
 qCfEpAPRcVb+fxfxJexMVooCIFSYwPaIlRYZa2UHvz5b7TGglv4BWbEG1brVhGR+RX1w1FinL9D
 AOn7K17/4gx0vDFuAwCWS1Tt5iZ0/YTSfGVk+6txDL5fv7yInVooM7DTTFPc4za7L4Hr0T0+rZY
 zHtGzyb7PU7qTShIMNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300172
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

On 3/30/2026 4:45 PM, Konrad Dybcio wrote:
> On 3/27/26 1:13 AM, Akhil P Oommen wrote:
>> Update the HFI definitions to support additional GMU based power
>> features.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>> ---
> 
> Whether you want to proceed with bitfields or not:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Thanks. I still feel it is bitfield layout is a 'bit' complicated.

I did an experiment:

#include <stdio.h>
#include <stdint.h>
#include <stddef.h>

struct packed_u8 {
        uint16_t mitigation_time;
        uint8_t current_rating    : 6;
        uint8_t num_phases        : 6;
        uint8_t path_notification : 1;
        uint8_t extra_features    : 3;
} __packed;


void main() {

        struct packed_u8 data = {
                 .mitigation_time  = 0xffff,
                 .current_rating   = 0x3f,  /* all 6 bits set */
                 .num_phases       = 0x3f,
                 .path_notification = 1,
                 .extra_features   = 0x7,
         };

        printf("Akhil 0x%x\n", *((uint32_t *) &data));
}

The output I got in Kaanapali is: Akhil 0x7f3fffff

This means that the compiler inserted a padding between current_rating
and num_phases.

-Akhil.

> 
> Konrad

