Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AD3CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CFE10FCFE;
	Wed, 14 Oct 2026 12:39:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C04510FCFE
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:39:06 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ECQCec2088183
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W8LWP4j+bIpY8MUEJUHYxf6cp4BonPSG9HyxtvJUqRY=; b=F09bMLUgmIud66IR
 bGEjfC8h0uO4+ZE471JhFlskW1uqinYqAfrBAyYuSv8Jyq5vFAG9M0ZIsYyuB4x9
 JtqMhSipBbwmHPUFj9YFsoV6b6t5adWkKFl7bpE0G6LdJ0FTFc/np2nNJ+sh41qs
 p+UsDbvk+1yJHsTR+EkUsT7M6tMHtDpS07S6SiliFZSGDjepHAGvjz7PTpTfoUqo
 GYNUoSuflpNuU0FZrpOpVic2HN3MoL6i1/EDA/zlDzMUIPFSm9WDoj3CequkCi3k
 b9ji1OU1/2Fzzmpv1duEsOAnUXKHiNfdERnyakYUHq/PvBZhiFhkbLjVXh/46qMG
 ntzNlg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9x49jun8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 12:39:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so2514570a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 05:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791981544; x=1792586344;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W8LWP4j+bIpY8MUEJUHYxf6cp4BonPSG9HyxtvJUqRY=;
 b=gnEk+jggepRt7uoLQYlaEH9gShD1Ujzxm+Ph3k7UDnH7gBAnLqQynQnZ6B6OoFkS2O
 d1mLwYK9uKEQ2fxLBcKjoi9FptK43p7nTRrBFJsAfK8BMhrcIlicNFPT0+2c8hu3V3ZL
 t6A5vp2vX47/XV3JWBpbTHjI6CumykvFF+2yF9siTx/yPN65bcu7QRVlm7XtY2rIXnbz
 26C9nhfQU+NH4wqF5roufoPCAxwcQnX9+qy3G08OvN+YAgUXTDVMfmRJAJVCgW5la9bd
 uQIztyl9V6d2Nvd4d2Kp1GM5irQNdSWI9GCBE/d5pAJh+yuniffdySmOIgvZl/8Ker+g
 pgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791981544; x=1792586344;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W8LWP4j+bIpY8MUEJUHYxf6cp4BonPSG9HyxtvJUqRY=;
 b=S6MnZosX+AMdAxRgeiA9qsGjskilz/Vlnz6aYE2NehqOGzw690paHrR+qqfzS5mGOk
 IwWkYQu8ZcIgzrtb7klbiPE4kFP8KsSotQcKbwEPBsGLyDiByQsWOaBzN0ap+87BQuwd
 C48y9znglqH+HjH/lwqYDlqkBwQ3SPWLupL1Su85rgu7CXQpnWPc8sJs+11Y2whUA/JU
 LjFDgRbOgQd3OxUnj1qqzMY8WS2l28jO9CTQILsUvE6cwuWvDtFdqG/LcKP7e8XP4VCF
 aJJPDt0IvTGlSVcZVN0kLCVFKItCuIp8BznEXQD6/75fo9wlTAoH0LjKdzaZ6fof2xLZ
 fp4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3qpOVjfKwO2AwkciPJamuIBGgeekRlQ62j6XHeXfLt5K16GQjdwuqxYwaAMOPpW2b+DZrtiLS2X8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJyxmJE5+JkgWRUYiYrFP5/JDayOZUkn8fm4xkE7DkNPlSnet9y
 hbab46TVAMJSzIq9KZ9j3LNcy1Hvde7RgAAKc9dVaja/Oh0xgRR82Qk1pDds299HMOM4Lmp2Djs
 tsHFy0pc6G5OIk5ri88wU0ErxYGk9MZ/DkT5o0o2UHvXXWyJSQ97XgBBg9JKpjp1bReLDLJk=
X-Gm-Gg: AYBFou3R76uhW758/5+3WhwJDeHQrZCdtpmi9hHP4AAfxjozvUCHlYWYiUreEKKs+8/
 8vO7kJATjkC7lpFAGujc3rB4gRCMV5zthFPoewwlvfkelHRwyWElBZ024YYLW7ftvvaWL13LFmO
 H0pktgym/A/O4bpgqSrCRFt3ybm+iUcwGwLRcqj3GQsa0TXZOwwwNodzAjmnv50E2kMo4nIf1bY
 EU82VLywp9q/AVjamJMVdKCv6ohOJeGLayeFdv2S7JWorlCKalU+anvubNProB9EwMF3sHUonxE
 X3S29QVmEWf+N57tIr11gb/K3uO+m3ZiYvet5220Ozbzin9CfpZE8bmwB5ngwBGrJy/RoXIl2gh
 SwZ69Wz6TZ3O8bn1yVJkxhwNVIsj5QOuVUzp+N1ODfiPpKKIV40EhgAEDhleoDhEBcCQL4racFW
 GRD1wtF6hHvz4Sz4x4U/pwar5DlqA=
X-Received: by 2002:a17:90b:3c8c:b0:3a4:967c:6947 with SMTP id
 98e67ed59e1d1-3ab3a99b4d0mr11899795a91.21.1791981544183; 
 Wed, 14 Oct 2026 05:39:04 -0700 (PDT)
X-Received: by 2002:a17:90b:3c8c:b0:3a4:967c:6947 with SMTP id
 98e67ed59e1d1-3ab3a99b4d0mr11899778a91.21.1791981543678; 
 Wed, 14 Oct 2026 05:39:03 -0700 (PDT)
Received: from [10.149.108.218]
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f2ba9efsm4368806a91.16.2026.10.14.05.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 05:39:03 -0700 (PDT)
Message-ID: <a60bc242-e132-4d92-9f04-5d234ba4979e@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 18:08:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: Add Microsoft Surface Laptop 8th
 Edition
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
 Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20261006-mahua-surface-laptop-v1-0-406fc042162a@oss.qualcomm.com>
 <20261006-mahua-surface-laptop-v1-5-406fc042162a@oss.qualcomm.com>
 <762978b8-72ce-4836-85f4-2cd3ee4dc5cf@oss.qualcomm.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <762978b8-72ce-4836-85f4-2cd3ee4dc5cf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YJcKWhGx c=1 sm=1 tr=0 ts=6acf77e9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=03qAMiCteCMXZj9sYoEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MCBTYWx0ZWRfX0QwmDqzfIepF
 boM61cdFJAXFhXojutwwoGL0nRtWGvif29ZMUCDjcXxxjXq+gmcc/mmRKzZ7iYM9pvshA0uYDyx
 bwzV238RK+laA/3HA4hBTGNbwlwTiBCH+mUysARYX09locAy4tnuNJhi32m7jHQoTp0YAObbqUw
 j86E2kCz6eQ35GY/NH2Axw5jxZjLgIP2+lST3QEPPTliTyhVKEOWazGKStv1IhnFg5HAsrbjY88
 oXr3GDadJLeUH8jxXXzq4ZGOeg2dd5sTlY8oRTMtobYM+YYo08oGXS8nNH7/4SgTYnkewnAiw4u
 qCuOoaQAcPSJ9UVOsjhx7cUV0n+7atwl33QXP9qwmMx9xPRR5nZnDRzkgKwFXB/BS5PsH5+cH6t
 yEx+AM5YWw+p59d54mnLh+iNKWJeUY9dLnCNgmTLqHvxGcFdlKuINyQYPOCCkfbCLi1w/U4hAdc
 Ynn5JqJgX2ugvbR1BKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MCBTYWx0ZWRfX+JAPbIWeLv4u
 gEbl1ItYy5AgZWtwfOvHkEifzMl4G0lIERqptBJSjiQm6epoeXAjq2dgic8Ut49Z6o4Pn4GrnrC
 E1alGi0hYkH2UPHWwp4Ruv+KbP9yP0Y=
X-Proofpoint-GUID: b7OwKBxwb-9arrIrHaTD1JtzEPfSeVh-
X-Proofpoint-ORIG-GUID: b7OwKBxwb-9arrIrHaTD1JtzEPfSeVh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140050
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


Hi Konrad,

On 10/13/2026 4:00 PM, Konrad Dybcio wrote:
> On 10/6/26 11:50 AM, Gopikrishna Garmidi wrote:
>> Add support for the Microsoft Surface Laptop 13.8" 8th Edition, which is
>> built on the Mahua SoC. Most of the board follows the Qualcomm reference
>> design. The keyboard, fan and platform profile sit behind the Surface
>> Aggregator Module on uart22, same as on the Surface Laptop 7.
> 
> [...]
> 
>> +&mdss_dp3_out {
>> +	data-lanes = <0 1 2 3>;
>> +	/* HBR2 channel equalization fails, limit the link to HBR */
>> +	link-frequencies = /bits/ 64 <1620000000 2700000000>;
> 
> Oops, that's no good - is there a chance this helps?
> 
> https://lore.kernel.org/linux-arm-msm/20260622-glymur-edp-phy-v1-2-814b45089ac9@oss.qualcomm.com/
> 

Thanks for the pointer. It helps, but doesn't get HBR2 working.

The panel (SHP LQ138P1JX61) supports up to HBR2. With all rates allowed,
clock recovery passes every time, and channel EQ goes like this:

               without patch    with patch
   HBR2 x4     fail             fail
   HBR2 x2     fail             fail
   HBR2 x1     fail             pass

Without the patch the sink asks for swing 2 / pre-emphasis 2 on all
lanes and never locks. With it, lane 0 settles at pre-emphasis 1, but
lanes 1-3 still sit at 2 and fail. A single lane doesn't have enough
bandwidth for the native mode, so it seems the PHY still needs more
tuning at HBR2.

Limited to HBR, 4 lanes train first time, so I'd like to keep that in
v2 for now. Happy to test anything else you have in mind.


> [...]
> 
>> +&usb_0 {
>> +	dr_mode = "host";
> 
> OTG should work just fine on both ports

Will drop dr_mode in v2.

Thanks,
Gopikrishna
