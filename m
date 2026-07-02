Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D249C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF1A10F277;
	Thu,  2 Jul 2026 09:59:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VQCwzO12";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C6jv76XB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4B910F277
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:59:12 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6629KNKK4115619
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 09:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5nL/rNcQHZd91kva335i8FIWuDnFWjipBa3t4Wt/gio=; b=VQCwzO121TuMAd54
 sSwlCB3QU1ZqROvmirrDIgHrcMB7OiYreq1qcIohxFFyWt4LXgVR0vftN55VfVlh
 ENmtiqpBRYzfEycul2C1ja4pynl8J+VxWxxRuSc6MDxpebgOILFs2DVReGOvdzbA
 IxRBijUCQnJ163QuxYbn0owJiTK3ijYwO8Yp0UTkaFgsLqtlug1+eTXBP2dvf/b7
 Go5vfkB4Z9ngoeOfdK+eftv9YvLlESjo9fURjzTAzdF3Yq0XwNemYgO+NjlDT/xg
 abGHYBT+pC/sOhMx7ahSgvoZkJUnAX+uY4IW/ugo+dkjG7BcJdod55xxcaV3bZ/p
 j01VhA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9404ny-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 09:59:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e4f27f49bso151265085a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782986351; x=1783591151;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5nL/rNcQHZd91kva335i8FIWuDnFWjipBa3t4Wt/gio=;
 b=C6jv76XBo1HsaEZ2zogbqYFFC/PdXhIEvXbxN8dNR88JiXrLoK1fW5+5fSW/X2Gzfo
 XZcA3sDEga4JNZ0/8t0o7NVv9uerCjBSanIWk2io5EaOWm3FtZpNpFKhI5S02HQzA6bR
 /mTsw0n1aHyn9Q6clzXV3Nr0l3Ooo+oN93oD/Ha2EUFWnLeei0MVd7ik71c0ZZ0pvQw6
 QtU/GyMz+92IIJjiwobR3CarXoHXnOPYmQoWRh84yEHf2pcHEM7cNG4rP9X8wyyd8q/k
 6VwgyvOn10hCSuAQRfr5MqbCYc7n0hQUYyhP5sa8895Va862Ep2+whvZKntyzr0UB8W2
 ry5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782986351; x=1783591151;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5nL/rNcQHZd91kva335i8FIWuDnFWjipBa3t4Wt/gio=;
 b=OOh4PHWDHpH/zQn3+JtWH5emwniToB0E7DdJ1azq74gZ2wdYLZ0PZCmKky2xtQHIHk
 vZyASiH73QfdIe46SnZ8tThwobpRMr8IlXW+RQBkT2KFriHVv0Jg4y1UAZKPJtobPFQG
 LRGz1HfQkWywcY+ZMp6lMQEKyBr3Bx6bW/H7e5SkrqEsvkN4PYivR/6g+BdiNkH2IQym
 DHLdCGrtbhtn1qaDMHrJdSzcEenE0E1lLLGOXwhVQDQ2d+79co2A+6MRpsFzD7gsUzrk
 +9aan/Q3sDdK9NYFNEaLE+Rkh8jTyE6++cMsArdbalsKfifbnBc4Ts2BgpM3vYyewhMd
 a/ng==
X-Gm-Message-State: AOJu0YyC+E8I6h5TP7wJ/5Wx96v5bVDZaxAFyipIyaFxcdjYFJOtgyfs
 H1e1AhQJunQu1S548P+9lzOlSVfZrjID8SGGbt/MFnRFrEjua0vsY02mErUGvXxlThap/Ytpo3W
 ZYrOnWShTzALU/OKnXIWXpjZnHSDViVdwJVDX3anx7Mre264jLV97L1p36XrCe6yYQ9RS9uZyvq
 Vj0qY=
X-Gm-Gg: AfdE7cnOpjf9vgf0C/C6uuA6QjIIR2B6//Z2J9zUM5tw0MDITTUy7CgDEirItL3ORo6
 P+rBpd28bSD9lDSaONth/X7CMcKm20zQcRrZiWbLSKE/vvMWCbi7iHdJDYxuesf3ZMSM55ng8pb
 PFSOCHG9PvK4ntIrxWl4ocLlU37UJRYE6UlajxYv0kWKC0VTouFzAeYnYGzVUqnyQVlhYTvUqmp
 IeLrvs/x1gye0tWL2eYlhN1fAY1YugMwCtSE2QmySpK4vOWjbF9okaa0b2KffoMVhuBrqfnwALI
 UHtZ9ePNJO5IpVogkW7kMyJU0w+2nejka3A9ZTYgNe+3WThkt3Hp6qzJ8Rm+m5++23xRug4pL88
 2xAZ4CMeQ/ApAdTmW1NCdtRPycVgbfpY8XSEWU54y
X-Received: by 2002:a05:620a:46a1:b0:915:9fba:878f with SMTP id
 af79cd13be357-92e781d690bmr758801185a.5.1782986351112; 
 Thu, 02 Jul 2026 02:59:11 -0700 (PDT)
X-Received: by 2002:a05:620a:46a1:b0:915:9fba:878f with SMTP id
 af79cd13be357-92e781d690bmr758797585a.5.1782986350449; 
 Thu, 02 Jul 2026 02:59:10 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.223.174])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477ddf0f310sm7269238f8f.31.2026.07.02.02.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 02:59:09 -0700 (PDT)
Message-ID: <01cafc67-adb4-4240-9c45-af835c4269e0@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 11:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/msm/hdmi_bridge: Simplify register bit updates
To: sashiko-reviews@lists.linux.dev,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
References: <20260702-drm-msm-hdmi-cleanup-v2-0-a4a4f0e8895b@oss.qualcomm.com>
 <20260702-drm-msm-hdmi-cleanup-v2-1-a4a4f0e8895b@oss.qualcomm.com>
 <20260702094921.3DC7D1F00A3D@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260702094921.3DC7D1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMyBTYWx0ZWRfXyNeHc7pbTvNx
 UDkL9e3NsgddSKseo1w1zt8nV+5SjtSXQwBmiA08ZBXiAv5oC9V+WnJCSf0WUtwSnSXv35YeE7x
 YGxI1cTddO5zwWxS+feesvr81dpuK54j0n04HPybnfHBNaPR0Rsq0OrzTIOzWBz0KhDq0jp68Te
 9/EsRY91oiMXF9UMwshwuxWo9+f2R7HnPX13dRLw1Bd5Y8FHmBKURkhLvJLOK8qwA60+nVhuXH3
 P0YkYJG83BTAodwhpRldOxm1JetOXqCiDWChRBjwWBaMw+xCUyd5yNB+42F0/bTjSE6JcWXZUbQ
 EhlRE/gilTDsa2Bap0lRPq9UyuQbVmtur/dLr9U2qobR9xBzj+reLibJarHGCcmCYsXq/c0Sl9B
 YCR4s49U5lyWV6aAtgS+3ACKysuKbRC6oNejv16cZLY697vlbKR7xTKq2MkCxBF4LdndJH4S1ih
 hEO66mXTWx4Q/JRiaTg==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a463670 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZVebHPM84LVkS2BvH6IA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: SV-bXmUlNwA9mo3BXcEJJu4Bi5LG6BfA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMyBTYWx0ZWRfX2W/CiHQ4TqVQ
 sRxbax2KUvnb/H1cu8DRP38K4/qREE/2AzGWe0Gm/IF9h/J/lS41nX029UQcWb53amOQGOIfyTU
 A1ymILJEKjkJb3En/FLSNRJcxG5zRgg=
X-Proofpoint-GUID: SV-bXmUlNwA9mo3BXcEJJu4Bi5LG6BfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020103
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

On 02/07/2026 11:49, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] hdmi_update_bits() is incorrectly called with the update value as the mask argument for multi-bit fields, defeating the purpose of the API.
> --
> 
> commit 21923da02c72e54abf3a47df112e97f9d67ce903
> Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> drm/msm/hdmi_bridge: Simplify register bit updates
> 
> This commit introduces wrapper functions to simplify register updates by
> using read-apply-mask-write steps. It updates multiple infoframe setup
> functions to use these new helpers to prevent reading and writing to
> different registers.
> 
>> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>> --- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
>> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
> 
> [ ... ]
> 
>> @@ -231,11 +217,10 @@ static int msm_hdmi_bridge_write_spd_infoframe(struct drm_bridge *bridge,
>>  	for (i = 0; i < ARRAY_SIZE(buf); i++)
>>  		hdmi_write(hdmi, REG_HDMI_GENERIC1(i), buf[i]);
>>  
>> -	val = hdmi_read(hdmi, REG_HDMI_GEN_PKT_CTRL);
>> -	val |= HDMI_GEN_PKT_CTRL_GENERIC1_SEND |
>> -		 HDMI_GEN_PKT_CTRL_GENERIC1_CONT |
>> -		 HDMI_GEN_PKT_CTRL_GENERIC1_LINE(SPD_IFRAME_LINE_NUMBER);
>> -	hdmi_write(hdmi, REG_HDMI_GEN_PKT_CTRL, val);
>> +	val = HDMI_GEN_PKT_CTRL_GENERIC1_SEND |
>> +	      HDMI_GEN_PKT_CTRL_GENERIC1_CONT |
>> +	      HDMI_GEN_PKT_CTRL_GENERIC1_LINE(SPD_IFRAME_LINE_NUMBER);
>> +	hdmi_update_bits(hdmi, REG_HDMI_GEN_PKT_CTRL, val, val);
> 
> [Severity: Low]
> Is val intended to be passed as the mask argument here?

Yes, just like old code did.

> 
> Because HDMI_GEN_PKT_CTRL_GENERIC1_LINE() generates a multi-bit field,
> passing the data value as the mask means any zero bits in the computed
> value will not be cleared from the register during the update.
> 
> This works in the current code because the register is cleared earlier
> in msm_hdmi_bridge_clear_spd_infoframe(), but does passing the data as
> the mask defeat the purpose of the hdmi_update_bits API?

The code is correct but I could make it more obvious or intentional by
using here in the mask HDMI_GEN_PKT_CTRL_GENERIC1_LINE__MASK.

OTOH, existing code is very simple and obvious, so not sure if worth.

Dmitry, you reviewed it, so let me know if I should change it to
dedicated mask following above tool review.

> 
> [ ... ]
> 


Best regards,
Krzysztof
