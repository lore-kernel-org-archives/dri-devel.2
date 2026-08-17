Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BA4C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C45E510E6AF;
	Mon, 17 Aug 2026 08:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X6WqELsg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="So27DiSS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AAA10E6AF
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:01:48 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H73KK3164932
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E8f2R7uAkkm58Igw9twxKgRRf+vTxm7dlB/hN8w5EL4=; b=X6WqELsgDmfc817u
 RWHmT88QxmrDY2V5cXRZcxKWIkOewsmsSD/kA1mC4v6EQ/0Y1A+ftbHNQRXAKTSK
 V4qUO1NkYHUVYS1Bf8eZOSgym8wfIScwiJaIebVhsuhyHsWK0CxGsdK/K3+l+g/8
 xsUAuHjHE5/SJsclPejggLavZ9d1Uy5WJs7lGb0jdw+uwVfqZbRWGx5Av6sQOmNX
 Uwubv1SnfZP2qVMlQ5l81b9rKoU/7TPDDKOn+AZunCkf6fTU81xhBy+C8ggJAglu
 qkrS8GSJIJbNDMUEM8J+NzKq11Pw2LB6PFrD3aHLASPG039fHsniRu988oXGQTWt
 wwSU4g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghk5xxy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 08:01:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso58079421cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 01:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786953707; x=1787558507;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E8f2R7uAkkm58Igw9twxKgRRf+vTxm7dlB/hN8w5EL4=;
 b=So27DiSSUFYYURtL6yM7b5d8+/Lp8p4tEhr5+oStwl2DlJeUCJNJ0a0+HTQdoOTVrL
 Sj6V8jroiRypstWW9cGnPiAkWxBnL71JmkUZ6ATTfn8mtlTMsFgLY6+C04Qk2/N5pwDh
 m/s7CUqSyuIJdZyVGA/gsWk5VgXwXuJweM/qyn2izdRIDNfRf3R9nvYrVp7sKO8vmROR
 RA22pKFhr4S/vVld7FoVd1L+WuIiqQ7/oF7QCuc3Q0AKPv3TTCaDOXzOToJc3Gw4Jlrg
 gbcWucP6kINCAFzIy7F590et1OHxqGjzXaZwJg8g25EXhzNi0WnrqnMl3tKz3MhaBqe0
 q1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786953707; x=1787558507;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E8f2R7uAkkm58Igw9twxKgRRf+vTxm7dlB/hN8w5EL4=;
 b=kjeZLWcjo1itt6Rrrau7+vJVG7BizzoipdD47KWz6QWhXeW/KiwA9J1N4do3iXtDyO
 tI2dJndOEiQnXWN1TlkyoejUja20wZXhZH+n7rm/LlHBX4pAV9EH4bgxbpl+B0xedhgY
 dwBr+Otyuc9+/s8cn7gNR5exIMR7qUPDvjty8m4f0n2nMUzaIQ3hfcqArGiNtkY7wHsj
 csuaztCdVuqk0geDc0x9E004c+w026X7NaPHzWBKXvJZSBZBGqfANbPxvKjxWFzc18k/
 qOQ/4tgbLp1TTdmS00hpJCDbT41HeSETq0bO1YfThlbfuAREBM4z087pMdeV/FMaQCWZ
 +agA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeDEXaSeu1PCO7Vxm/I5Gn1gJH38C4/LL5QTRFEE5AhIDeprAysWSYMCbBvCKhzEvwaHz4+hv+ifM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMIOexAe9BcbXxoSlCkLw4WkTCGgsm9vkxC/Uos5kNR9DLRe0q
 RIebh4HDNkYf4LEcUDVFZiU5H6mBDfdhnmaDjlvyVxsxgP4VPeJskhgslpXoVponVCG3TMifQ5X
 /GLDedPzw/EMmQb6SSoJMeLyRomjXfMx7fsl/0YjVNAYPW6ZWDSciPqBafKP3n9WutGrTUiA=
X-Gm-Gg: AR+sD13yJmeU7ll1xGw//AIoh61eUJAqTlRz6sRA6cWodvq2ERACNUwI+ymXeuXLtSt
 hVgS4J988DkLLQStkSwIOp1/Q8DCec6AuHbkB+n5w9H1rP0e2NHJSHfvzvj8dzaY7J/GwxLlyAH
 7gZnYscZfFBf4ZGTADNrvXGPItmLKqUPEvKEK6LdRw/Fu+SGOlTokoLtt9W0QxM2G34UllejsnN
 eM8TnzwvSpml5TcDeYVJp4Sb2pv35TQkSukHwgJoGdfpVg57u8VfskubXtCHETqGnglR9K8Ompr
 AQRvpaNA0FX6tOE+0SZLa57w8OFJkMLiKFuNNwUAsr7NmdFvPXCmL47hZmyEfaLQ8NizdmMrR1d
 B5nXTCdz+KEAEyXIb9tI3gZqVvl0A/JX4XCGoafG/SCbIyBehkju95YnIK+x2gAopVA==
X-Received: by 2002:a05:622a:1341:b0:51a:8b64:69e2 with SMTP id
 d75a77b69052e-52d8530f131mr247367731cf.7.1786953706610; 
 Mon, 17 Aug 2026 01:01:46 -0700 (PDT)
X-Received: by 2002:a05:622a:1341:b0:51a:8b64:69e2 with SMTP id
 d75a77b69052e-52d8530f131mr247367131cf.7.1786953706112; 
 Mon, 17 Aug 2026 01:01:46 -0700 (PDT)
Received: from [10.111.162.109] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db612c2bfsm8319271cf.11.2026.08.17.01.01.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 01:01:45 -0700 (PDT)
Message-ID: <96344518-c0d3-4424-804a-c315eab3e39e@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 16:01:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/msm/dp: mark the SST connector disconnected when
 MST is enabled
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
 <20260629-msm-dp-msttypec-v1-5-646a10256233@oss.qualcomm.com>
 <sijdmdhcbxyg23gh6c62hspruvbnyqbdrtv2er3bh6n6ftolsp@b6o4khv6dofc>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <sijdmdhcbxyg23gh6c62hspruvbnyqbdrtv2er3bh6n6ftolsp@b6o4khv6dofc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX3n81oSBr4f8m
 ZS08Juv+AoIAv95ims1JYNKJtMfjUZgQcsr/oD/+Bxu3PXU3TfM5Ci7bbO6Sh9gijZhdrw9x06Y
 z0GbSze4bKgHOUamfTIjk2eS8h3/SGo=
X-Proofpoint-GUID: ieHd5FROtrhcKufMgCQgm4Af4JDnli0x
X-Authority-Analysis: v=2.4 cv=f+14wuyM c=1 sm=1 tr=0 ts=6a82bfeb cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=bLWUdw4gizuqmWSpfScA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX5X8Rm1E5X0Jh
 NLlrn5EyujNy3gNKSsOVa9Daeks7rTtEHEEQhM4RUqccPlIGFwMBRNEEvJj8QLMGYeUL6zEFZyK
 nfaFKyk2Q5jvqSkootAwIpzXLhYoLBP8hzfCwKmWOAuHTJQsYV13EfdTEHoRfN08SS6Wp6oHp+7
 olQUXZYVKz28UHryNG0kW/mTygxqbvCpYyf7S1iY/JP1BWKsImF42wC2qYFHzAyeyk7jna7SWRV
 CVu0m/SgBk8NwppOoNbgNK+G528E7l9efDee48GEiF3ZuJsMX+VcMa13WJxLaIRGFeKen+y0ig0
 +aCi4I/twGfFEmP2BTO0jeSGPQsiq2U8AvNSch4hDheu4zZPjfOy6bZGTAYCjDPVmXgQ/V2maVB
 F7Q03nr+uAYjF6qgoKowykfXf+6ePTbb01LW/Lhpvwc0ff6o0kWAAnZOtfGsFBTwGvhNqyArlOx
 FlRCGLGJOVLC83wSlYg==
X-Proofpoint-ORIG-GUID: ieHd5FROtrhcKufMgCQgm4Af4JDnli0x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170059
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



On 7/12/2026 6:56 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 29, 2026 at 10:48:07PM +0800, Yongxing Mou wrote:
>> When MST becomes active, the initial HPD plug notification updates the
>> SST connector state to connected.
>>
>> However, the subsequent SST connector detect path reports disconnected
>> while MST is enabled. This connected -> disconnected transition is then
>> observed by the polling logic and may result in an unnecessary hotplug
>> event.
>>
>> Set the SST connector state to disconnected immediately after MST is
>> initialized so that the detect path does not introduce a transient
>> state change.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 4ee391cc7165..f8ca60d6d714 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -352,8 +352,10 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>>   	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
>>   		msm_dp_display_mst_init(dp);
>>   
>> -	if (dp->msm_dp_display.mst_active)
>> +	if (dp->msm_dp_display.mst_active) {
>> +		connector->status = connector_status_disconnected;
>>   		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, true);
> 
> This should be a part of the MST series.
> 
Got it .
>> +	}
>>   
>>   	msm_dp_link_reset_phy_params_vx_px(dp->link);
>>   
>>
>> -- 
>> 2.43.0
>>
> 

