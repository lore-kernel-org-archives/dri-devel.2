Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACC606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CfOBKLTq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gMNl1QLj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66BFD112973;
	Fri, 23 Oct 2026 06:10:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F0610E529
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:10:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1Eumc772900
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j02O+rA3xQoYjF/F2In/L8d0y/DZT/FPkbnV0NEuAEs=; b=CfOBKLTq43SYoTq3
 xFm/ByUO8H4PCeF1BROv++ZE4sszAt7aSpb0rufwMzKMvo8ltLmQCzXZwGmnHUKG
 XclwPuBt3ccUwY5FsDjmkRETam7AhpQ4hp7V3RBjR1Lzq2jJ3tbY3M1Py33lXF1e
 Ru5UUEGUzy4FHMjKfq8yIoBMMJx7CWbdOynEA99W4KXuCwzIc0QFwGxQy2XRaa3f
 PV5aigPW20ItejiwDfc/UA/s2vMfec6nRrVF6XJCkKgxphIXrzPHJgvIrFSFLL6J
 5dVPFgYIaEy91RBtZX9jWZqZCp6dbH+dcr3hjkZgqZiKTbvCBt0Hygs9ysrhZ1X2
 1Qij1w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtt5sf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 06:10:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a46f0f158dso852913a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 23:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792735844; x=1793340644;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=j02O+rA3xQoYjF/F2In/L8d0y/DZT/FPkbnV0NEuAEs=;
 b=gMNl1QLjQ38l9VWhsm+1um/NcO/NWRR88lQ5N/G/N4wFWbXbH+U2MrCb0Msi9uGM1F
 1WpDkFWsqzdD1eUgXQDo36zF/3RS6IvfGdPI/tNBXoy9dGMxsTAn19Y+ij3UHQ47VOFM
 7HKgV/t9DKQUxCG6wbBJlFq0Lo/wN/+72PjyJHaMrys0Zw5N5iS39vMZpHsQL36GERkw
 8Hy0tmm7BRljRw0L1sGYAPirlvazMC9mIbi0KGPES+9h9BER+17fm6rzuVglTy9YoxlS
 8uaPNHBCOL/dB9M2iSrY16QvckXjmEMk+TO8OhH77EZP+pa9kXf/EWr9+ULyzNWPR6ld
 ALoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792735844; x=1793340644;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j02O+rA3xQoYjF/F2In/L8d0y/DZT/FPkbnV0NEuAEs=;
 b=XzWCXUxGHauNyXc3LBvU81ZRgTSkHg6wZe5qjOfL+X0MXHryM6RdD5uBsoqEriksTG
 Al2mPkBXx0LnjBU48WKITn5JvY7fF1Bw5LPIb9OAB6iiKVJw+NTtDAOyCjU6pwS/v9wy
 BTvS1HRWFiSOqpW7Co63qiJ6w0qJsjDY0u/R9DYBFOj/o5vLJuBzox7ChVimm3p2uH3Y
 UmhFxee2k2xiQwJG6Z6msCiT+jAnHwCpKF8x1hGlTCEOAURW2ACWsFacpPhunEPp+ao8
 n0Rl65OHT456rfCvbp6KS/nb5+I6cGcIsExq7OOr0dNi4ZklEZptAWpM9hbwCQeqUhmj
 K+kw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsS4Jd7kHabrwa82WQK5cRVXn69JLc9fj0xxl2+w+rN4RBgp1IfBR8oC8Piv9fM4vUleDfjw5NepY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI61EW1hQFipTALlb31gEgnaCfeIh1LRRWrcXw/tQ1YW+Y/b738
 z7662dBDLrP/Rr5BRowoGAz2IBlmQ314YPjECqTwR5lYzwHee1c7Lj+BodUaScWl4doM6FRrbJJ
 ecpd01Vtks097H8Gj1u5b6CcEXeLqFdRyeZX0D0LPCfDfolj/bWGTgSpax5TWCG528tGJmRo=
X-Gm-Gg: AYBFou1zLJcI733rJpJ8kgYh/Wkz1Z5If4JF2oWgJOW1Je2BbmZGXsfysAmUVCvVlhg
 ZNgMOJrAS5Qlt7JYp6I8wt2i6gcJLmpx4VFJdsiX84jM81vQfw4f3CmtzUny/yKGG95a30DP5MQ
 KfPmlH1sqkYRXqY5GB523kEMsOmbB/l8uijVZ3KzAJoKRjQ0dR9jJlw39cGBdedNb6i10Bj+Kf3
 jF6GOcRv+i3YB8qR/xhyTaaj+DGow6/ep+M4DatyXMtQYmUXn1XtQdTFgjBr499RO5ewl+iU0M1
 3qnOxpa/ruzoymx/NBqbhj6jvd4vMrxG8k1SutMvQne1mR8OB4mjsGnBKMP2IVVNphfOtx8SPcT
 edoVrVyEL1zG2Hhyoz5no5naMsns=
X-Received: by 2002:a17:90b:524c:b0:3a0:295e:6e61 with SMTP id
 98e67ed59e1d1-3adce5ff93emr618403a91.12.1792735844268; 
 Thu, 22 Oct 2026 23:10:44 -0700 (PDT)
X-Received: by 2002:a17:90b:524c:b0:3a0:295e:6e61 with SMTP id
 98e67ed59e1d1-3adce5ff93emr618388a91.12.1792735843627; 
 Thu, 22 Oct 2026 23:10:43 -0700 (PDT)
Received: from [10.64.69.173] ([114.94.8.21]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4890bb2sm7186038a91.1.2026.10.22.23.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 23:10:42 -0700 (PDT)
Message-ID: <8c0dd87d-d054-4423-a62f-ac30d34a23ca@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:10:36 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: aux-hpd-bridge: replay last HPD status on
 hpd_enable
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260803-drm-usbdp-preboot-v1-1-2539b362be00@oss.qualcomm.com>
 <179256808506.89747.16992632119493179553.b4-review@b4>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <179256808506.89747.16992632119493179553.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adafa65 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KstRv3tEx54DabmpsY0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: a3Dzz_KXGFKisijT1F8wrBkAVXa25BZy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyNCBTYWx0ZWRfX8CIv4FCsSs4E
 UGAWWBRj7tKfRdOiWIZgFX3T61AX7JxJ3oXnJZnGV7+OXg7is4FI7RATfGCkYkPhUSYl/d3w23m
 L41HOAUUiRf6IEuB/3VN2YI/+aIlzd2UCB6QP3tGBkX8rRHFsMTjEFxwNbJtyfLTsV/vRobA6h0
 IjaSxo7Q9BNNsLxpqeKru0aP7a08oGslBIoHQ4p8BX9v1v388w1ZRvScSIqSHV+3vtebYHuAKXT
 Y8g0DxIi/Zw9vCaVHJsdHRoyl6/DWW4RzYH9U+WAgDfOWGxWqy5TVAjv7FqKti+NuJ1HBDve2Qg
 hbXDwtfO+HiRZ6aztWNgEBh76OsjZXqsI46JshTZ7wr0kFhOrmj3WPJ9Jp1CFJVj22FigTDtOsf
 WDSUBxNrbYGlOMLmZoxVWQYOqvlZe4FlufCCmXxopDu3SuT4Cp8P501eIp+RWFdSgkptllo42JF
 2MmQapMbUB/yij/3Wpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyNCBTYWx0ZWRfX2IbuKN6xA9XA
 c5UuPfVlNFIMlQxkGCnkIzcOEOGkD8BX881xMB//HxUj7he31o5IfJXWOsAxduWkQanvtZISA5H
 TtyKSo35PIItPKYFV1O//SI36qwm3/8=
X-Proofpoint-ORIG-GUID: a3Dzz_KXGFKisijT1F8wrBkAVXa25BZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230024
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/21/2026 3:34 PM, Luca Ceresoli wrote:
> Hello Yongxing, Dmitry,
> 
>> If a downstream consumer (e.g. drm_bridge_connector attached by the
>> msm/dp driver) registers its HPD callback after an upstream driver
>> has already reported a HPD event through drm_aux_hpd_bridge_notify(),
>> the notification is dropped because bridge->hpd_cb is still NULL.
>> This can affect any user of drm_aux_hpd_bridge_notify() whose
>> downstream consumer arms HPD only after upstream events have started.
>>
>> The race has been observed on Qualcomm X1E-based laptops during boot,
>> when pmic_glink_altmode reports the initial USB-C DP connection state
>> before the DP driver has finished probing and enabled HPD handling on
>> the bridge. The consumer then never observes the initial connected
>> state and the external display remains dark.
>>
>> Cache the last HPD status reported through drm_aux_hpd_bridge_notify()
>> and replay it when HPD is enabled by the downstream consumer.
>>
>> The replay is deferred to a work item so that the replayed HPD
>> notification is delivered outside drm_bridge_hpd_enable()'s call
>> context.
>>
>> This follows the same pattern as display-connector, which also defers
>> an initial HPD notification from .hpd_enable(), but reuses the cached
>> status since aux-hpd-bridge cannot re-detect sink presence on its own.
>>
>> Fixes: e560518a6c2e ("drm/bridge: implement generic DP HPD bridge")
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> 
> Is this patch still current?
> 
> It looks mostly OK at quick glance, but there are issues reported by
> sashiko which look valid to me. If you could reply to those remarks, either
> confirming the issue or explaining why it isn't, it would help reviewing.
> 
Hi, thanks for reminder, will apply AI commenst later and post V2.> 
@Dmitry: I'm not familiar with this code, do you have any comment on this
> patch?
> 
> Luca
> 

