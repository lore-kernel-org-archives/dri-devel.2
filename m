Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A17C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF0C10E4EC;
	Mon,  7 Sep 2026 13:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P8+KyANs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OVkV6okd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946A310E4EC
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:19:41 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AnAdD4064241
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2YcGSOzVcathbMGrauMsKb7vtcdXz92tDZk77j/tjWA=; b=P8+KyANst6/u4em3
 KEliQpfBJueTsQAYAW8Xg6mfTWf9Yu8MchBPPBU/S3bXuQfjXDHJib+dro0o4lRs
 f8abG8qk4knhhwiEh8dY4zpFsD1v3epK1vJ3D1KjVn5fADPydXIVUTTBdZUO8vR+
 5KEgXydBz1K4e6/JbWndbIqxTyNgV2YZbdYIBSsIULAsLmNqvro3lGifxIzu3LYF
 1NBD/BtVNbrtxV9e6RxZivp6u9BK73hPr5kWVGlvnfXDge73J2furTlHt3Zr1zg9
 DZUfUz/xBxvTW62Bm3aX7MTpTXH/6gzxOWsGnbYmxY9fRkAY3OZco2yuFou9VVF/
 qMcrNQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghs86sc41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:19:40 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c6725e7891so945848e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788787180; x=1789391980;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2YcGSOzVcathbMGrauMsKb7vtcdXz92tDZk77j/tjWA=;
 b=OVkV6okdi+ytQvv4Ww2l9ymlxJDnCHAMFgErzYKNLvQNsKMBzmYUR/MG/n+eMXDDDR
 2AuuTTgI/pkMVp3H0EcQvD+5/reMI8U+yxLhGoyjYJ/L4/g3aFew+tohcaNeOlFavW0X
 i78plV2JuR5jAmR3R2/jvxJn5Vk3ueStkRt4npzVcospiDc55nAwF4QHieBeahIei1me
 mcIxlIS8C6ki9N7yx/459kuOs+Sm0xMHYjiq3RvyPe8Nq053LJlsLcfjL5u/Ir5DXCZE
 K69+QTfoe7Rj1cgjFBz7e/g/bh8jWdxHsCsjMQoL2KLeNpyHJGwUVoun8nZOGFcD27SK
 qd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788787180; x=1789391980;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2YcGSOzVcathbMGrauMsKb7vtcdXz92tDZk77j/tjWA=;
 b=FBd4fGvFIoQja6edd0syN7Bwx3adx8YUIckKWspQ89xvcICDthFzjowFQU2z7WQuBK
 ysvXcbuU8UbcVtXMRjtH4Q7/1fR4PZ05drZIIZMWpFyUDCEYvcMhMsD98VBTBESsIujJ
 pa+H1RmAgXH1ccD6ibYPcsJ8k9xwqO0LC2v6RfM+oAcPVdjFeDsfPprpflVjLzB0BB5g
 C8O4v/dUS9GRcuIdVObOFhLCAbvTvguG0m0SY31W3eAa6+jp0yKwrvY9TW5vvbA8B6aT
 UizQcOSWEtcEZOSyhYzWymOIQAS2ave0cmLsUYybcONzG90WxfYf7pTrLWsrdLS0EuwU
 Nm7Q==
X-Gm-Message-State: AFuF++lzaalq8QmPokAPMi07sT535XDx/+D3zMzrgxM9C3G3kIYDITfB
 eVW/pauqewLUfEopbgUqpqHqIPBcNCikbG/8ZQI63TH9r4pObaSdmyaCcb2dpaQreZcp9RLEiQ6
 MBoWOqOEy4DfMCPimJXRHLS4F5rYfVv1rtxnLLmJ8/B7wUIC9saSNoZyJ8Gh8G0UfmVq9TbE=
X-Gm-Gg: AYBFou1koJtdoHTul9pA6HY9T2PW/9OKvWrCHNmbepUjNHPCYAmtMsTf17uo6ptcD4g
 SajMIiGgzVRMoJmK2E3j/7gdTfOPxjxroz9ikpu2EMSbPu9v/fLIzhVtSg6ymNwErsRHf2ZMMEz
 vXAxjgXd9ii6DaB+QBZUKDnj2UL5XV2FwDpYL1K1O5LGFbD1gsideDOZqM2PCxpKOttcQ0szt3f
 yu8ha1gK+6UAwMGyUbIR7O3EOLzXx93S+oKrwd4w0xZwGiJHylSDnADe0DXLMO6Wi+OPIrI5etu
 ErSzRYJzS7EldXedXnt9ZaEplrH4PV2BKis7TonEPbbZGY0PxBu3xTfCETLWd292MwA1zrBYBCl
 43vfG7pt+SQEFhg6vkkd4dV3skqNK
X-Received: by 2002:a05:6102:e0d:b0:785:d308:cc0a with SMTP id
 ada2fe7eead31-78a4a91077bmr7376238137.9.1788787179982; 
 Mon, 07 Sep 2026 06:19:39 -0700 (PDT)
X-Received: by 2002:a05:6102:e0d:b0:785:d308:cc0a with SMTP id
 ada2fe7eead31-78a4a91077bmr7376211137.9.1788787179534; 
 Mon, 07 Sep 2026 06:19:39 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cefsm424350915e9.5.2026.09.07.06.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 06:19:38 -0700 (PDT)
Message-ID: <ab27c2fe-1a0b-459c-90b0-62eaab286cc1@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 15:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
 <20260907-drm-msm-hdmi-fixes-before-eliza-v2-2-b097cf1eac77@oss.qualcomm.com>
 <20260907131419.D9BEF1F00A3A@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260907131419.D9BEF1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: G7UXgkOmDwZzL-84UutP89Q_LEJiQWkR
X-Proofpoint-ORIG-GUID: G7UXgkOmDwZzL-84UutP89Q_LEJiQWkR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0NiBTYWx0ZWRfX2NRuqYsdZ4tv
 OFJW3z1GREyxhGoGjHkpsCurWLtfhL25MRjAAys6hmLswVpsQxwXhhPn9/HEJlGapPg2eJyBJ7i
 9hpzNQbIAIAT/EG3rvuTEj9moIgbO24=
X-Authority-Analysis: v=2.4 cv=LseiDHdc c=1 sm=1 tr=0 ts=6a9eb9ec cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cqV9-yYPM6X3oF6Ldn8A:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0NiBTYWx0ZWRfX+DEExoptwiPp
 pCm6+CBNNFq2BRE2O2xWYVx4TMxYVzzOF8Fp7Bj/NuXVMA/SlTkUQJNcCE2Omk+E2RhCZ29B830
 VHwmKOn/LEaegB3Qy30CM+BgrXgFzJ/gf92qzEg9Y5eQZgkvuPpWazRDWiw7YOPhs/XZvRffbLn
 D+gCjAPt+iyRFxBQ6jKhvmOkxYLwhlGtQ2kC8McSMqYAg0QRrDNSkvseVuHAeaSfEb2FYD7nDkR
 TPDo+qVEcUp/qFgBydoArxMl6JIb97dIc0Z9x3MGAF3BosRL1Pj1ruEY+P5EipNcto9qi+CLsvf
 SzxJhIEjh4Gkdx2isUIMsJjBqQ4QZil4VOFyqE9ACrNdLmF3ig9cHu9/nFi7rO9zErhxoa9+aUo
 j+y/O5CW3zNZDzxTHmxCG2woSxJSVfhIw3mZVWrIsuoVQ7f7sJi0VChHFtD7bQZs3wDhBhtoPgF
 8LaezdxZP4WiNn7HN1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070146
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

On 07/09/2026 15:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Imprecise abort (kernel panic) in .atomic_post_disable() due to unclocked MMIO access after a failure in .atomic_pre_enable().
> --
> 
> commit 4f4c185244ef7ea6a900e7c373d8e29c18ab92a6
> Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
>     drm/msm/hdmi: Handle msm_hdmi_power_on() errors during .atomic_pre_enable()
>     
>     Properly handle power up failures during .atomic_pre_enable() by
>     aborting the .atomic_pre_enable() to avoid accessing registers why
>     blocks did not bring up.  Otherwise this could lead to imprecise aborts
>     when accessing MMIO while entire power domain is off.
> 
>> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>> index 157f19bd90b4e..db85400e574e4 100644
>> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> [ ... ]
>> @@ -287,13 +294,18 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>>  
>>  	msm_hdmi_set_timings(hdmi, &crtc_state->adjusted_mode);
>>  
>> -	mutex_lock(&hdmi->state_mutex);
>> -	if (!hdmi->power_on) {
>> -		msm_hdmi_phy_resource_enable(phy);
>> -		msm_hdmi_power_on(bridge);
>> -		hdmi->power_on = true;
>> +	scoped_guard(mutex, &hdmi->state_mutex) {
>> +		if (!hdmi->power_on) {
>> +			if (msm_hdmi_phy_resource_enable(phy))
>> +				return;
>> +
>> +			if (msm_hdmi_power_on(bridge)) {
>> +				msm_hdmi_phy_resource_disable(phy);
>> +				return;
>> +			}
>> +			hdmi->power_on = true;
>> +		}
>>  	}
> 
> [Severity: High]
> Does this early return cause an imprecise abort during atomic_post_disable()?
> 
> Since atomic_pre_enable() returns void, the DRM core will consider the state

That's a atomic_pre_enable() problem.

> committed even if it returns early here. This leaves hdmi->power_on = false
> and the PHY clocks and PM domain powered off.

Pre-existing design.


Best regards,
Krzysztof
