Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF0AC44532
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8806C10E0A5;
	Wed, 22 Jul 2026 10:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lSsq1pLE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dqQZlw0C";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2157110E0A5
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:59:40 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8xdrv123873
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6NLD5QZZ8/I4Gf7f08HT3hDB1lW6nFAOR1yB7m8BKXE=; b=lSsq1pLEodEksU4Z
 w1qorF4Kr9l0Fb5xhfsH5Jtmmoh4ftLrU2OvnmPqGGd+4CwSHJh0K7Wkfm2TZ6B1
 E+AIK82r/PW7Q5FWizV6Yxhq4CP1bCFFpDNiGPDuf1sbB768zdvgroaHqQQrKCmM
 xg4WUOVoq4f+wkN8TqVaIQ9vAkzuELjAcQQTeXWsxOriJrpht9F1nZW+QR/fa0qa
 Oy8HRurwbLnRHG6hkKvzBh6Qw5Kz1KhvnzBYBBMaBF4bUwYVyMkHkSZcDG03SAjS
 7eh2P0x/zNU923fjjnGkuxpw1Pmz91OVJ0clwR/Gg39tjV5c6mRtXqjnKnZjhx/K
 fmLNjQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4sr48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:59:39 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso30241311cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 03:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784717978; x=1785322778;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6NLD5QZZ8/I4Gf7f08HT3hDB1lW6nFAOR1yB7m8BKXE=;
 b=dqQZlw0CUSPPaGYJR6WFjt+ABzf2fVPsrYtq8Qf3+ep0C7F7qS2EC4Rm0Lwi9U9kjC
 VUfIcJd0+y+dld0uhMaUM77CrqvXmpbaTfcQ8jp0NQpRRBOEiKTEomSihOcScSBgJA3s
 46Q+fBnocIb+DFhKn9osltQw7Z844ykeua3m14DdtgtJN1Rsy8d2AEnZ4E8dPDmVBc+E
 VViAlPgV5+1Ar4iQCT8RJ+NTWqBmXga/Ee1p5RvjEDQKFQBDTsRQbz0T0qIHtqhArFO0
 AETc6IO5GPnA/TjuA5m1LsDMUti2CpoO7NqimcFEAqdFs13Xg5RPI8+0HFqMF23ZKvmT
 my7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784717978; x=1785322778;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6NLD5QZZ8/I4Gf7f08HT3hDB1lW6nFAOR1yB7m8BKXE=;
 b=lzj4SFBwvFVKRVYQkHqqI3unGOJdomH2OVJdJlRag6IxqLZt7IEFNvw5CcI/4wVG3T
 8si4nKWDDuhQUzAoVg1qDo9OjcngpwuZTg62Kduke3T3gEYTjetvhAmJCbowJpWc5lb2
 VztMTYotJTHuevozm20NpWHontodBNRMs7LqyvzC+sGmGvhUQZFcR523FBr9No0W9OwA
 I+yWMy6m2ALGJdiO102ekAhz9nXDXwDR0Pl2SPbwBzsK+DQ7Jjgi7C0wSRRz0T0hiRbu
 on85aBxMwr7V81cbUz4Fu/mIUhbGNvY67/nz6gOPsYp+omnMOqXmRDD6Z/A0wo/AaUw/
 +Ylg==
X-Gm-Message-State: AOJu0YydjGyBQZYPWX6bb2pIDJWyk+hg3LELUPoV9hshIkRqVQnxEpyc
 ilsEHX3O/wHxeuiZ9KBBNVvtEOVkSuiDjOsB5p5hv4CMoOJ79tVb+l1erbK05zWNAQFGlggpG1C
 mV7nyGCvTcAboirNBGYm6x65J78TVkbUsZeoDZQxzNFDQr/Tkg9y/vBcI7ejEZs97V66wpUE9mE
 9j7bU=
X-Gm-Gg: AR+sD11zZaiW9fIlTr7jdFvaoHVYZzFQS/7N6blEkC0/YvsU4PRTOr6IZArfMUKI/a+
 ECzmuD5elVTolqT1kGeXVNUvaXM/gbsyi9SnZZWwlIHN0tqLmHrJYlvOKIrWbr007gIJYD2v8K+
 fdJHgGIZN8g50g6pxYW9P0Imo+s6St9WW6DO0YQjxd9pC7GqdmcMuTK6Stom4qHBQanpAQYAULW
 D7924kLq+gNp32HCk7rMalFsBing7xKLEQfQIMd7ZIt6Jr+2EAkClATbE39naUBjfbCUv2I6Wy0
 uQ3o4+pa0ARjdwPul/T4DZhHK84nrG6XxsixROKdcwPcH1AhP2/QgNA4zhJJeL3QtdQW2n4O+1c
 AFr+UFYKdEsYTmSmOSChJ0jdMbktrs8w2Gc7gOui6ACr0heJFMr2c4qWwvrtI/qrO2g==
X-Received: by 2002:a05:6214:5d0b:b0:8f3:469e:5051 with SMTP id
 6a1803df08f44-90778358215mr238108386d6.18.1784717978460; 
 Wed, 22 Jul 2026 03:59:38 -0700 (PDT)
X-Received: by 2002:a05:6214:5d0b:b0:8f3:469e:5051 with SMTP id
 6a1803df08f44-90778358215mr238108116d6.18.1784717978006; 
 Wed, 22 Jul 2026 03:59:38 -0700 (PDT)
Received: from [10.111.173.228] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba9e18d4sm18438546d6.23.2026.07.22.03.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 03:59:37 -0700 (PDT)
Message-ID: <fa4eda4f-a492-467d-86c7-98b9a6d35344@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 18:59:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/15] drm/msm/dp: allow dp_ctrl stream APIs to use any
 panel passed to it
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 sashiko-reviews@lists.linux.dev, freedreno@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-10-bea261bf4e7d@oss.qualcomm.com>
 <20260720062405.E079D1F000E9@smtp.kernel.org>
 <3k7xz57peytyda7cvzfpao3j6xuhn4gyf7f43wnspdpgnrel4r@vipemh3nkoi7>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <3k7xz57peytyda7cvzfpao3j6xuhn4gyf7f43wnspdpgnrel4r@vipemh3nkoi7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RgUW1TQUVQs4bwOOjPSZMvc4N_Brx4HD
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60a29b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=fjmCN9aIutHrqzZMW0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwNiBTYWx0ZWRfX64ky5QQicLcE
 oSkW+pa3l8RqO345O8wvfbsIqyu3brSc+2Uskige1wkf3Lr+NPUf+1zkkpNGuL3bUdduHcJgekL
 Bxuf7RB7gAy9crb7LGAFIUd6yZalTnIOvgufyuz2zi+kZR/jG2Im71/6OWRck1YwkgJqdO8Slhk
 HGq8nwq0ZEzeI2TnZqlJuc8afe1hZwZZjn8BDJDFIGrRYIp1wZCY0H6zIpRClvYAICCa9/zJoFM
 3upRwCv7nYcD10z/aDnSBpPwC2Ul37gYB3hsPbfTQ9IheFlPNW8KhScGMlaXCunM7HkycMJcibI
 CIFQSftla6vrabWt8iU0Qv4CPmuZeXRPTaRt9p1YOgAuoRaNGgK6VHJ2JCIf3MUuArbDGfoF2qj
 HCqmhJiEcK8co9NyY23M5xzACVigPfCUrDtHDqR2EdCUOjEXNQIkDAxsumQTZ8tQeMvP2bAFT9d
 1vOvYcnB7a16TPfH4jw==
X-Proofpoint-ORIG-GUID: RgUW1TQUVQs4bwOOjPSZMvc4N_Brx4HD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwNiBTYWx0ZWRfX+60InKQDt5m3
 gMyLUiskC1vhitBXwKpQ829z5kZhg8Xwat2nDdf6JVvNwMq6RXpkDbDP2F19shcLQIRk9RV8nvI
 mVctopwdDHYLQi6FeaonJU1vQUsaOwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220106
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



On 7/22/2026 2:54 AM, Dmitry Baryshkov wrote:
> On Mon, Jul 20, 2026 at 06:24:05AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>> - [High] Secondary stream panels fail to have their `hw_revision` initialized, silently breaking controller-specific hardware workarounds in MST setups.
>> - [High] Stream-specific panels are incorrectly passed to mainlink APIs, corrupting shared link state and misconfiguring the link based on leaf monitor capabilities instead of the MST hub.
>> --
>>
>> --- Patch [10]: [PATCH v8 10/15] drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it ---
>> commit 07d3f4b80ae5875a958a8aceb22c9ffab07db108
>> Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it
>>
>> With MST, multiple sinks share a single DP controller, so a cached
>> panel in msm_dp_ctrl_private can no longer represent the per-stream
>> sink. Drop the cache and pass panel explicitly to all stream-related
>> dp_ctrl APIs.
>>
>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>> index ae79cbec26d19..207643fa73063 100644
>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>> @@ -219,7 +219,7 @@ void msm_dp_ctrl_reset(struct msm_dp_ctrl *msm_dp_ctrl)
>>>   
>>>   	if (!ctrl->hw_revision) {
>>>   		ctrl->hw_revision = msm_dp_read_ahb(ctrl, REG_DP_HW_VERSION);
>>> -		ctrl->panel->hw_revision = ctrl->hw_revision;
>>> +		panel->hw_revision = ctrl->hw_revision;
>>>   	}
>>>   }
>>
>> [Severity: High]
>> Does this leave the hw_revision uninitialized for secondary stream panels in an
>> MST setup?
>>
>> Since ctrl->hw_revision is populated during the host initialization for the
>> primary panel, any subsequent stream panels passed to this function will bypass
>> the assignment. Could this silently break hardware workarounds that depend on
>> panel->hw_revision being set correctly?
> 
> It does. This should be fixed.
> 
Got it. I'll move the panel->hw_revision assignment outside the conditional.
>>
>> [ ... ]
>>
>>> @@ -414,10 +414,11 @@ static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
>>>   	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
>>>   }
>>>   
>>> -static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
>>> +static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl,
>>> +					 struct msm_dp_panel *panel)
>>>   {
>>>   	u32 config = 0;
>>> -	const u8 *dpcd = ctrl->panel->dpcd;
>>> +	const u8 *dpcd = panel->dpcd;
>>>   
>>>   	/* Default-> LSCLK DIV: 1/4 LCLK  */
>>>   	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
>>
>> [Severity: High]
>> Can the direct write to REG_DP_CONFIGURATION_CTRL at the end of this function
>> erase stream-specific configurations established by previously enabled streams?
>>
>> Since msm_dp_ctrl_config_ctrl_link() is called on every stream enable from
>> msm_dp_ctrl_on_stream(), it seems this might overwrite the shared register and
>> corrupt the state of active streams.
> 
> Hmm?
> 
>>
>> [ ... ]
>>
>>> @@ -1810,11 +1821,12 @@ static void msm_dp_ctrl_link_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl)
>>>   		   str_on_off(ctrl->core_clks_on));
>>>   }
>>>   
>>> -static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private *ctrl)
>>> +static int msm_dp_ctrl_enable_mainlink_clocks(struct msm_dp_ctrl_private *ctrl,
>>> +					      struct msm_dp_panel *panel)
>>>   {
>>>   	int ret = 0;
>>>   	struct phy *phy = ctrl->phy;
>>> -	const u8 *dpcd = ctrl->panel->dpcd;
>>> +	const u8 *dpcd = panel->dpcd;
>>>   
>>>   	ctrl->phy_opts.dp.lanes = ctrl->link->link_params.num_lanes;
>>>   	ctrl->phy_opts.dp.link_rate = ctrl->link->link_params.rate / 100;
>>
>> [Severity: High]
>> Is it correct to use the stream-specific (leaf) DPCD to configure shared
>> mainlink properties here and in msm_dp_ctrl_link_train()?
>>
>> This appears to misconfigure the link based on leaf monitor capabilities instead
>> of the MST hub. If a leaf monitor doesn't support features like enhanced
>> framing or downspread, but the hub does, could this break the link to the hub?
>>
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com?part=10
> 

