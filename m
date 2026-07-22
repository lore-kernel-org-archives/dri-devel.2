Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50685C44532
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A08AF10E429;
	Wed, 22 Jul 2026 10:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c36GvnUt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aN+E6elb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1656710E429
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:55:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8xde7123853
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LPDGN1eDhV0cM2OKKPZ5QUdzqEuIcsRmODO3PXGRRAw=; b=c36GvnUtGVL/AuIy
 EWnidWC9uyBJbjugFm+g40UN9rLF+9Olk3E6lYKTxTuli6s9XOx4qL6n9gFrwkK6
 56hm2uQppvAUegsm/uvisNsbB8i9XyAXwVvOLP4Aj3jEVfaUKparM4Hp0snEreU4
 zQyqW5yn9xaGjQKDrDB/qkicaBsumlx0UlhUMzvFcZZ0pCfHJsWbRXCf+9CUFxk/
 aCJHkmbC7wjM7N6GA/EWy9S5JIyLT+R/MaCj+gsyupYyLKcYU4A0EasdFhesgKV3
 T9NLspTeF5W2hdB4WNdga5xjmZQstUphCgZkeDuKMvzwG3dxhME7RxXO61OLACca
 GY04ew==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4sqmw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:55:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ec91dc265so885051785a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784717701; x=1785322501;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LPDGN1eDhV0cM2OKKPZ5QUdzqEuIcsRmODO3PXGRRAw=;
 b=aN+E6elbBpoNDYAmIgFZXasy7qyRNNVM1lkHJiCXappL+kn+qAeqmxfTLhfICSKmBX
 VUfgS8dUTUw4NIqAJN0AgOXxK+oY9YK1g1S3ppWP6t2lttz9B4CmCruZbGa4ulE8YSK6
 L9E5JLZkR4ZRN4YV3zg8JBgNevkGcZAleioFFqoUWi+5KT+uf2yyRJOUGbPGhDT7zpXT
 /swQzXfai+mQRd+4K/kKOWec+nERJnIjolnwkhtPrZCZkPvtKVxBhZKe5o1E8wIFC2Vw
 BCQubGwoPaZz4qP5l/LRlQEiSXZOSlkDtAUIrEo6e8wN1bUAf6A9yBBwMpD/njYc0FrX
 hP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784717701; x=1785322501;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LPDGN1eDhV0cM2OKKPZ5QUdzqEuIcsRmODO3PXGRRAw=;
 b=qI1G2wuagb+HjH+lpc2GHMAh6MhaNpuF8jRhHN5NtFHvBEDr+BT3liCBneMylBlyqF
 yjwn0K36dsg6m9dzHNMXjpBvwXzRrKBh+1/AXcvvlCOLG3apw38nFqW8BwF8cFIDVMiJ
 9Hfqr+Cw3BxHHVk3f15xV5MgkhXQF1p4rpCTSCQAr+PgrqjooXyWofuspTihPor3dQCj
 rzZ3duUCp2rvDVE0WTu0YHBjY2CNRE6KjnoCoturmsgwIV+zpcorLLzK2ebJg9lB3TQD
 aJUZMBSc38KQVp6dygBQqMH4yAhcIEDUWt7LBT+gRJ13+pE8KJ4rzhZuq2F6GV4OVNCf
 ES8Q==
X-Gm-Message-State: AOJu0YzOx/B07orQXGRQcB7gtrNIG99eIH+TYpUFzWuIMcL1NsU+79Hr
 zX/oQJ51U9vw7zBlC6ZRCiLoD4vFoIlFU9wof9hD0vkrulCXoRZ1PvYFH415TWwUslAwazd5u+S
 AwAJ1P2O6D/WDyqZPB0YbuZTUaT6qoioNYlDzxUj/NWVgr71JSS8m85c292E+ocKBpVWkm1M=
X-Gm-Gg: AR+sD10JvEl0HJLZX7NHsajjYKbgiwi4OoJIDJmBPG30rZVoPLKMv07wiLk15H1tXWq
 yv6jQtUsNCpJSXj1tLSVgI5/yO6PaG0m4QfMTEw14Xyvoo3sPfbXkyI+yGECDu2PT/QD9/qZJXl
 w9Hhk5XnLYFXaPmsZYC8GXx8RIeNq2pm8wX/Gl+5Vy5wqXYASdqRQREYb7kFjGJzcLiV7CoBnui
 xhpx/ufJli2cpivmEgxQxU2fLRWtO1dDXjE4lRX//JBBOgh67Wo/LIqKdVxgsthOuLvfDRFy9xk
 zW0QrOhx1Aw+5enb+eNyzDsorj9evAaQSzrJS0a6UUaP6X7fIUZ3yx/NeH8bPon/sF4PAA5vkNp
 YMaTRWF67oX0mwmHU8gR3sIB3vOfOkW92+aBYG75r7CHvX7tKYToRUO+yRkAkGnP1oQ==
X-Received: by 2002:a05:6214:2f12:b0:8e9:f62b:8fa0 with SMTP id
 6a1803df08f44-907783cfb3bmr246503226d6.53.1784717701421; 
 Wed, 22 Jul 2026 03:55:01 -0700 (PDT)
X-Received: by 2002:a05:6214:2f12:b0:8e9:f62b:8fa0 with SMTP id
 6a1803df08f44-907783cfb3bmr246502966d6.53.1784717700892; 
 Wed, 22 Jul 2026 03:55:00 -0700 (PDT)
Received: from [10.111.173.228] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba8b3e96sm18841846d6.1.2026.07.22.03.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 03:55:00 -0700 (PDT)
Message-ID: <fccb4620-d5b2-4a49-b703-8725a863c540@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 18:54:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/15] drm/msm/dp: drop deprecated .mode_set() and use
 .atomic_enable
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-2-bea261bf4e7d@oss.qualcomm.com>
 <20260720063317.CFCFF1F000E9@smtp.kernel.org>
 <ldznbgwysgo4ya6h2s57wytjjhhljkfyiagrce4z2gvty5suye@bdc3gfzl7xff>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <ldznbgwysgo4ya6h2s57wytjjhhljkfyiagrce4z2gvty5suye@bdc3gfzl7xff>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LlZwwtcx-GZIG88N8XMZqHOfNzRQHboK
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60a186 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=ATxrgLNVpGx5eOw1QnYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEwNSBTYWx0ZWRfX9xFZxAqULMLu
 +EeV8ktsyo+ExAWTz9OXnM1JJ1FxpV5g/6Ul36HlxFPvDY5Y25v78oBc7LWTED/sxmh/NhRPEo5
 v5oimrthT/v4d4WpmGqzC2rKlcEksuzt9MZbK/JlYzodbQTRdFbvC14oR8OEjW1IYj1fxD6RFt7
 /Ikpk08jpKU9Nmr4P5M0fjrSUqYakLQN1avrD0I271UBcB0+9g+YtnRZVtRREurnI+w5MiL7xDP
 IJRlAHbUAEq3H4ZX0M1CgLyU8wCYvv9nrwJ7jU89GLJvy/4gmtBbzjuNaNwHXk2yaVGjXKNVHuL
 cc6TNIaHx2g6v0ueRS9tYt3B3FVWZR+K/4O4CbkfqGLd/29a8JBPkNdQRYpersuHgmqW+loKXpR
 eCX1vaLP/mQ7xIM3kujM8RmR92PmjIHbe1TIIod9yL6MhsGCZ5fxKF7S+jrWMZ4nsWrT0h13QmU
 JUmDKwOWkfCM0l819RQ==
X-Proofpoint-ORIG-GUID: LlZwwtcx-GZIG88N8XMZqHOfNzRQHboK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEwNSBTYWx0ZWRfX7QpGcsZVVxmU
 kGLCooj8Imzh0ZUfXA7nA03S9hwRlS2RcGt16MvH329feQmMloCMnQiZyZmzYmLUJKi4VvLWa7q
 c0QDPxm5/ncUOnPYYhCaL/8+OzWHX10=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220105
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



On 7/22/2026 2:47 AM, Dmitry Baryshkov wrote:
> On Mon, Jul 20, 2026 at 06:33:16AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> New issues:
>> - [High] Moving mode state updates to `.atomic_enable` causes the DPU encoder to read stale wide bus configuration.
>>
>> Pre-existing issues:
>> - [High] `mode_valid` incorrectly evaluates wide bus availability based on the currently active mode's state rather than the candidate mode, causing valid modes to be rejected.
>> --
>>
> 
>>> @@ -1386,7 +1406,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>>>   	if (msm_dp_display->link->sink_count == 0)
>>>   		return;
>>>   
>>> -	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
>>> +	rc = msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel);
>>>   	if (rc) {
>>>   		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
>>>   		return;
>>
>> [Severity: High]
>> Does moving this mode setup into .atomic_enable() cause the DPU encoder
>> to read a stale wide bus configuration?
>>
>> In the DRM atomic commit flow, the encoder's .atomic_enable() (which executes
>> dpu_encoder_virt_atomic_enable()) is called before the bridge's
>> .atomic_enable().
>>
>> Because msm_dp_display_set_mode() updates the format state
>> (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420), the DPU encoder will query
>> msm_dp_wide_bus_available() before this new mode's format has been stored.
>>
>> Won't this cause the hardware to be programmed using the wide bus state from
>> the previously active mode, potentially causing display corruption or a blank
>> screen when switching between RGB and YUV420?
> 
> Indeed, both look like an issue. Please add a patch before this one,
> adding drm_display_mode to the msm_dp_wide_bus_available() call. It will
> solve both issues.
> 
Sure. Will update it next version.
