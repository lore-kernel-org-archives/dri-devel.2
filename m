Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4899BCCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B5110E051;
	Fri, 16 Oct 2026 09:27:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F5261126FA
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:26:54 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69G8m5tZ1465311
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P0mXq9SsEMF4c2zjn7YAZ1SKL/E/fKdDfWM/bk/8SfY=; b=OuLnzm+BerQHtwer
 XkrUhZ9Y37HuXJT8L+xAat3ARvQGijgXk48l2FegLkCmX3FKdBo4d3oced4pcEJf
 l44wKqteOznEOkut79/5g27joD2jSdm9/x9tQZR+XY1d3V0ZpSjfGYgnEkpGy9+o
 rT9rEujkOYzleVZ9B02VO9eznXT4Dl+6gFy/lOWBDpUZAn5mQZE8YuWbDRBMkhRs
 AydcYef63U5H48RIBo2n/r6ja1iXyIxfw5gVgrwYRaKcyiy72W9CN0bAruaPI6yA
 tbPaxovQ1ONFwK2k7EG6ZYCurlkMbX6bR5i1Z5v5zAoXtIX6e3SsQ4nOnwg68lbJ
 IX0+Qw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb21wujp7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:26:53 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd5ca3840c5so7636553a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 02:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792142812; x=1792747612;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P0mXq9SsEMF4c2zjn7YAZ1SKL/E/fKdDfWM/bk/8SfY=;
 b=CBrOOx52FcZZW5wBgmIFM8exgxEJhUAmLWOPi3Gg1oy3qIh8oerhfXVM+BXZ0n6Z3G
 lpTs7uSigjmjWusb+WK+34Ioiw2MPr/PL3S+1+LKoxSQmbjBKZsNruru1ftHVmdoLStC
 UmEV0rilk/amLQyqGz2mUrhRWe+vZG5Si84Gh/1oMObGber9F4R3GsgCfhSb3NArC9Q4
 ox+S/nqI2BaVRoQv8iU/vxtV1qeKFw3pl0wzaO0hphoDPhWFAG/CeXMVmBpuDbGEtC2N
 VpuAK0lymoBFmnylNOGeAURn8uxZSwG0Ebse1rb5NsKwDG5CASHKC+DubnhAKVlOLDDQ
 1ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792142812; x=1792747612;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P0mXq9SsEMF4c2zjn7YAZ1SKL/E/fKdDfWM/bk/8SfY=;
 b=V/hkOm2Vp9nVKbl3RIATXLEHn/18iaLWvN0lWWPsSCcrjrUdsrtg6xRXKgv7lDm01h
 jPeYz0wpTXJLCBlsT0ynYXFxnU1arI1m/6RyBz5TRfIDX7P0h1Hycs4irmmN3Rkiodh4
 ToPOgUhVaCZ+gSJxoin7m8VsCQFGVs9Fhrlz/v7t2iAZFb54js+Aqt+2P+J7GON6ki7w
 agaVahq9stRrXdEAfO8cnfYTyJN0JyXUfhxxPwGkj5qA9W/LlqcqfaiuU4ftavTLP2PG
 IBmJOBi7PMNos8E78bgts3OUIdp4/tXGmhOtEm/5UkeLE2IDPy+qgzLmshMuBQMrHk5I
 fKwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIVnBStwztVFqKDD37dKwlL6P/IxSRPAp2Tw+THtizRq8l/A+LAHuvwaxf4zKI3zwNV3oSBwvJt6s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYITvgc9ZpN0HBA9RH1jgqjnKVoVS0Fw6KGjxyLBi2OueY0EXYI+
 zlzvib1S05ClKgxepAMwXCxvUQ+2l6IeIGL4Nhqv+5uaihTULg0A+HTMrRl5vR+Rl790+3wHT28
 8zPn9LH2InegztnVdcCADLV8zLqHgzv3+5EBbymD76Vui/XCuoycXh3Kpz1MlNgih0B3hIvw=
X-Gm-Gg: AYBFou3LMFFY4rQ+rEBhwQpAX78oPE0D8fCkXLsCzGe9qi99iwuScj3DaMTyE4BvHYF
 YKD0esi1PJYVAr1HL1l6Gp7mCRhxJmr5/Ve3DEeG4DrW8MNeQNzTv+MOwGNC5rJ/xzOs5z3Tbdt
 b/YpOQXjZEoTU8HMWfrJiHPv6REc7+SB3nXwq+XlOAXWPK32AwQCmTk5v8Digji0qaSmBR8dbfe
 GWuuieoFlT6/irh01JiSnTAKbOidMuRO5Wu8S6nfi/tvey6bvKf5r7BWrMNIuSv3mV6kvKbUVoy
 dK/jyZ/iydWaYS06ZQ4h6aHpliA1sAPInwFmMrlMnqhrzDF/MT14tyVMAH9qAnEXMmJmtxEJ7yQ
 vuIfUC5oy2ecLz79yZ8YNk/kUsNOUZA==
X-Received: by 2002:a05:6a21:2d46:b0:3e0:e242:5ff with SMTP id
 adf61e73a8af0-3e16bec70c6mr18001897637.56.1792142812191; 
 Fri, 16 Oct 2026 02:26:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d46:b0:3e0:e242:5ff with SMTP id
 adf61e73a8af0-3e16bec70c6mr18001878637.56.1792142811682; 
 Fri, 16 Oct 2026 02:26:51 -0700 (PDT)
Received: from [192.168.29.42] ([49.37.217.198])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549b42b8sm738437a12.12.2026.10.16.02.26.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 02:26:51 -0700 (PDT)
Message-ID: <f624b075-df3b-4862-8231-8fcae7f18d50@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 14:56:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom: Document Microsoft Surface
 Laptop 8th Edition
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>,
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
Content-Language: en-US
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
In-Reply-To: <65f6883d-8ead-4c6e-80f5-81f6857df0b8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GfbekFPnMDjsEBxxf6Jd4W83cbuTGDGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfX/AXrsTHyhMAK
 LJabEbIkQ8Xv8b6NH3yzTxAaPHERn6Fv9LKUoyfM7Po+74kpf51tUduTjuU0WWraawWpZIupyvn
 ejDIJeUHrPHKuX28Wr9o8focqBE0FbC7lChCJPHkUc44yTBAAhDMy0/x1wuQJjD27LIrsLrZwAh
 /n17YAfpA4uwk9fbRk0a+W2uEMc1QUCVw/TOB/4kUEM+jvy4VdVXM7tV2hctcZIndYrGkgIsqJq
 ofxGQb8Fk5daJCoEst0KuSoTPeGqBy0f+9ggO/Vl9v9wY2BawZB3BtGbBuHxc2wUJVLgDQ8jXJI
 OSKYpBhq7OdqcMDqeoZbzo02XMRSspBgoCxI/A0UL3svaoKUx4dPsJ5U5WM928Ne1VDzNUJCEJg
 Zm/9ka5Vv0izQUfrjq43D/AqQarqCDC1H6fm69SwlSikQoPUiEO33++ciJ3dcy+pdLprJC2GkQh
 tIU6iZdMVT0XH7AWEow==
X-Proofpoint-GUID: GfbekFPnMDjsEBxxf6Jd4W83cbuTGDGa
X-Authority-Analysis: v=2.4 cv=R5qWitRX c=1 sm=1 tr=0 ts=6ad1eddd cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=rThwyMTpgoa+SOOJ7TDuHg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=8k6WQxmsAAAA:8 a=uT7-Y2yUXYoXKl3sUa4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNyBTYWx0ZWRfXyCEAYj8x2jSo
 JPFrPR4HBhCC8k2/aHJVbJfubFUoS2D8ZFo2wz+h5YfrgN5Lz1ZFWXOP2Wm6B6MPKXr8TBBAzW8
 2yJs8KhTWAGjNEh1vkDsNYxvSIbrw3Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160037
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



On 15/10/2026 19:02, Konrad Dybcio wrote:
> On 10/15/26 2:47 PM, Gopikrishna Garmidi wrote:
>> Hi Konrad,
>>
>> On 10/13/2026 2:09 PM, Konrad Dybcio wrote:
>>> On 10/7/26 9:11 AM, Gopikrishna Garmidi wrote:
>>>>
>>>>
>>>> On 10/6/2026 3:20 PM, Gopikrishna Garmidi wrote:
>>>>> Document the Mahua-based Microsoft Surface Laptop 13.8" 8th Edition.
>>>>>
>>>>> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
>>>>> ---
> 
> [...]
> 
> 
>> Thanks for checking. The only matches I see are in the MPTF thermal
>> package, which ships"883ROT13Inch.bin" and "883ROT15Inch.bin". Nothing
>> else mentions ROT.
>>
>> I also checked all the ACPI tables but didn't find a codename there.
>> The tables are here:
>>
>>    https://github.com/aarch64-laptops/build/pull/176
>>
>> Following the Lenovo gen8 naming, would something like
>> "microsoft,surface-laptop-gen8-13p8in"
>> (mahua-microsoft-surface-laptop-gen8-13p8in.dts) work? I'm open to
>> whatever you and Krzysztof prefer.
> 
> FWIW the "gen" naming comes directly from Lenovo's product name,
> i.e. if you go on lenovo.com it says "ThinkPad T14s Gen 7".

Official Documentation say "Surface Laptop, 13.8 inch (8th Edition)"

We have to create a dedicated board file for the fifteen inch variant
since it is expected to have a sd-card port and another one for 13inch
specifically to enable ufs. All of them will have only lcd panels. So
how about if we go with the following?

microsoft,surface-laptop-8-lcd13
microsoft,surface-laptop-8-lcd13p8
microsoft,surface-laptop-8-lcd15

With this is mind it might make sense to create a common
file mahua-microsoft-surface-laptop-8.dtsi that all these
boards can import from as well.

-Sibi
> 
> Konrad

