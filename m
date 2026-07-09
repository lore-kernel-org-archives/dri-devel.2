Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F80C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D740910F5D8;
	Thu,  9 Jul 2026 13:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F9Hch3o4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Um5DXYBZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14F2810F5D8
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 13:42:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669BNVC11667893
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 13:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g8bbQ0UFrJNgIEmJIIRtCAu5z0XVNIydSzCgLYqggsw=; b=F9Hch3o4T7NJsf1P
 wYr85a/DCvN6Lk4nLUGhMp6PTQ8FGNyRBL4yiBFkchly0uHRxjitwucI7vHbO41Q
 tJnar2UtGCxsFj+B9TnV3UlOd8lNnGyad1xFdI9HqkhQGq1dnAAE75yCjkndoECa
 R4gcK36CkRDIXEBDX1V7M1Han+SiynAuFBVvkiZwvIWLJuLueTQRYwWZH1yDT+z2
 4fLwJINlvXvRhk4t6gZnB0o7DCb9bUdfxln07nk7QowDBzRE+SHAg+wyvCC9DSbz
 Mmq2P3Ufltc2M6WYNQiyUmUJ/CIbHY6mcohhCoLsG2pqULDA3YRb2fhaUH9vjLSW
 DbQShQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6m1j3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 13:42:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so2668608a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783604570; x=1784209370;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g8bbQ0UFrJNgIEmJIIRtCAu5z0XVNIydSzCgLYqggsw=;
 b=Um5DXYBZvl7rkKJpf2zDQKh6nKY9gX83zj96XkRpwxBB6hn5IdckNzvfwZ4CMW8uig
 JZuNXyH9mPCsiN/opW6LCDPvOs4hBUZhgUdNyfbDq3m0EIQ76FHNARkv6q6k3chEgSJs
 uSQtBBuKVUK/gY7Onu4pyIbkJNh3Jl9uSt5SmlgiTbmX6xcFt4cC13jNZfqIv25EDZyb
 ybli23wbFKOQjJ99wwVXeIiGIrYKaNgyU0hud/K/Wd+ds0/Hug4WMTG5KdxqCWL3EiMJ
 kzx+x+I5w6s4obPjeLZtbviiMMYp9AIJAwzsEU1rnjLjCsZoC6E/Ki8SgExgFQ+UYyxb
 RgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783604570; x=1784209370;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g8bbQ0UFrJNgIEmJIIRtCAu5z0XVNIydSzCgLYqggsw=;
 b=gtKfZKsjTtRvJBrrxoxJpK4V/U6W7ORIU+bBYARFrn2aUomQRhK1+5J+Ya8nXxhOaB
 tCErNfg0nyDXXSQy363Guz84C9hYoDZlZ0lYW6Vp8BEQdfozqBxh0tCNGRYZhn70qptF
 E0Ipj6W+Y+EKLEdKtpaiJiRnwF92zc2X0OIxjRmrgU58caNZfMFmnnr2DzJzoCdkHnZ8
 TyvRmiPRf4CsZJq8RqUWMwpRR/0FmaFytTXIxqHCsyodIsTdebJVoQ5m33Lu2F+EPbNL
 IqD7Vcj9frw67lmfyW2mTcFhx0x54eAmB6EP9D9xNba+cTwJrantIXAkXwYpa3n1rr11
 ZBNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqjX2F11WMxb8T4k2PGqwryOypUSBOBBT6G5XxuYTJdJ+ixO1zoe9heBpt2aGOFJHJ8BgNraNVOxaM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcEGUfeDn36OCy+Mp7OqdUt5LHgiaQjZmJMAwO/bc6SGliMM/f
 6XAs2W0eCHbrSbHOQhqPWIA7sDLcfR9Y/ne3hNQ1u8zcq6xSTG7fBvgb/h1MXmDZ/tS+mySweTD
 HBx22Zp/NvSm/qgHMOPLCe0k5DoR1SyNRZf9PfXCyeddLAFbT1Usy/JwhxG8JYoW4vR4pV0c=
X-Gm-Gg: AfdE7clg0lagaKYBlRcheutEQufDM7Tj5naGRlXn6OaRiZL8rEKHGar3oucuDKwLxzO
 iyOo0j1kvilxpqzszKKkTYbqFgKpV6WZq/S+FjjO5lXWmKPIUlko1CXZ/2AvS8j/+k/1sJcxTx2
 Mq03a2h5eo78JyQO+HEQK38dIukr+LhyajG4Y2Yxv/irgDyWWgqZPrv7VZs6cat1R2GuG073dx4
 JneoP5N+8IjjnpJc5Hz+eCcE+Xxfz5fIT7V20Grl7RyTGgf1ofi6JyEfccx6dqQ8PpgdfCWtvKE
 KSdkX2BtKdNEriQ9m0n+mqVzkkATPhLvJbeujIp+ej944E1hDHLOrnf2DGup+PW82yhrS8Ne0kl
 z6648+U4++nBVqeHgPCOrbu86WGq0iDHal30=
X-Received: by 2002:a17:90b:2d91:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-38941102108mr6904997a91.3.1783604569739; 
 Thu, 09 Jul 2026 06:42:49 -0700 (PDT)
X-Received: by 2002:a17:90b:2d91:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-38941102108mr6904955a91.3.1783604569291; 
 Thu, 09 Jul 2026 06:42:49 -0700 (PDT)
Received: from [10.204.104.211] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174892711sm32820196eec.13.2026.07.09.06.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 06:42:48 -0700 (PDT)
Message-ID: <54cb37bb-aaa5-4c5d-a563-acca4822dd35@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 19:12:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/13] drm/msm: look for lpac from dts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
 <rwohvfbsw2brpxrfg26egu5arwe6g7n2etelo33eegmu5cz65k@3syofuxzsjrc>
 <dc5aef2e-600e-4e97-b76b-dcc8bd72c709@gmail.com>
 <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <m4vwrqt6yyaawpvkyrqfzs3kbipbhygmtrhphuthl2gmjvkgyt@u2d3dnvl2phy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEzNCBTYWx0ZWRfX00g8/jtbBSZ+
 H5KrAvfFVnVI3R8oqocFm13igrd/0H/OaJoVb0F4GAeO1HGNKu9+GTtrNCf4Z8CK5SdqfrueqBo
 yv5XKyWLG+4PozGppwam8vWmDLXDlQk=
X-Proofpoint-GUID: K9MsCGX_gMqcLSwKt5DLcxOGMbB-uqOY
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4fa55a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=mritAz9d6wIG9kTKuDcA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-ORIG-GUID: K9MsCGX_gMqcLSwKt5DLcxOGMbB-uqOY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEzNCBTYWx0ZWRfX2e89YP20toAk
 zU1NdJ51O3l89YqlZmWMehdi9WY4SITJMWT7FiFTHF2vCIunj/g280qEmM4eMooQYBPfMkqiXaX
 QSC7wMldZ08qkyLdTjfTvtk03B8Fl06ew0bgqccebYyhhj4QFnGdLSyVVLX7QZ0AHrJr4MHN9CK
 W5j1Uj/sHrq/K4+JORxfaJyKiOnPeQawf/3E4SpheQ+PbbaaMk0owL9GYLRm3O17M7bv3ekvqIL
 RGXzc2ctpt+Rre6ZlvFkQoTJgBfKFFvBJ+ko2xnGiQcKmfnDY5KM07onx7hLxHmnHEjTRHxfm7V
 VQ4W3JCPkBGSt6bsE58Y6QiWC4FcI4l5mnFk5aKhco1uW63IB5kEfsMDix9GrKamCBAhQNwQJxe
 utTOZN+70ttwcuWJMFQtl1D5kL8nEL91sZPlNe1l7zjbdgnZuIWOX748h5AQVGvKZqrngFGbt2b
 1th3ZF9qA07oL79qSjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090134
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

On 7/7/2026 10:09 PM, Dmitry Baryshkov wrote:
> On Tue, Jul 07, 2026 at 05:02:43PM +0200, Anna Maniscalco wrote:
>> On 7/6/26 5:04 PM, Dmitry Baryshkov wrote:
>>> On Sun, Jul 05, 2026 at 09:13:37PM +0200, Anna Maniscalco wrote:
>>>> In order to associate the SID used by LPAC to it's own domain and
>>>> context bank we need a separate node on the DTS.
>>> Can we use iommu-map instead of adding a new device using the same
>>> addresses? You provide zero explanations, but it seems like you are
>>> trying to separate a part of the GPU into a separate device, but it's
>>> unnecessary.
>>
>> What I was trying to say is that we need to map sid0 and sid1 to different
>> context banks.
>>
>> From what I recall, so long as we use the same dt node, the iommu drivert
>> provides no way of doing this.
>>
>> What kgsl does is having a node for the iommu and then subnodes for gfx lpac
>> and secure.
>>
>> The address on the lpac device doesn't really matter. I have very limted
>> knowledge of DTSs but I think we could just leave it out altogether?
> 
> I think, you were poined to the Glymur Iris patches. Another option is
> the QDA driver being submitted too. Both ot them use iommu-map to
> describe the same usecase - a set of SIDs which are used by the device
> but which should not be a part of the defaut set. With it in place you
> don't need to have separate qcom,lpac devices, no additional properties,
> etc. 
> 
> I'd recommend following the same approach.

iiuc, the conclusion in this recent thread is to use child nodes for a
similar case:
https://lore.kernel.org/all/20260618151745.GD231643@ziepe.ca/

-Akhil

> 
>>
>>>
>>>> Add the code to look up that node on initialization.
>>>>
>>>> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
>>>> ---
>>>>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
>>>>   drivers/gpu/drm/msm/msm_gpu.h           |  1 +
>>>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>>>
>>
>> Best regards,
>> -- 
>> Anna Maniscalco <anna.maniscalco2000@gmail.com>
>>
> 

