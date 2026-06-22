Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3928BCDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969F410E6DA;
	Mon, 22 Jun 2026 13:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CXmV8iUN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KnRPW7LZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A27C10E6D4
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:23:12 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MDGDXR1261030
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CphGddleZtR7hEzVNCHN3RYvRxeTDa6IKrCwZ8q/dJU=; b=CXmV8iUNNMjpfiwY
 gGasiUzLCR8+U5VzGes7i5Kv5P0noNtoD4UvQrKA9zcUUtSCOrmVsGYshLRK9LLS
 1zhebOrFndOr9zAJR6MWktOQLNj7kY1BH049lBVVvLEgwsMn+LT9pwuvf2NaqBkD
 kVyJIDepXDL7Qun87fY7GQ5V4WuwSquTvmny2eVM6LQAH12rZ7DQcyp0FqRZTxLt
 vYlQRb/x/BVTFPVDbZIBicaFDBPNhVYvT1ZGmSOOdX1Ua1185H9f51ODEyIkHJ3L
 2OfMAVdLV/WgEHyLSoWDg+V8eLnxdADxmO91wpPZ3ghcmQKBWPdegEUb3dZRNFLi
 GM8kEA==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3eb8hm9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:23:10 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6a0ea6e29d6so3097002eaf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782134590; x=1782739390;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CphGddleZtR7hEzVNCHN3RYvRxeTDa6IKrCwZ8q/dJU=;
 b=KnRPW7LZiVwTSON60QF/cTmxF/Dzz3jZRrgcdV4Vcv7FTIwmZHbJD39rlUkbE8r3Tg
 OwW1l+WZ1eU+OwaUvaHuYXdjW5WTa20v5fq+ECIUAjZkLgw7C85e8jgIuaBm0ktt2Y5F
 NXXmfMbCzLgR2zmh80AAw5RPPh9XPIPc0f1U6cb4W5BCChf8chQvqWxi0pmJVNLdLQpU
 IrU2tFzS+Ukj8SXKLHO3mU8+gUP3r+ioODSb8Gy+UlNk1NmnkEBUVWAxaZZhNuxFyF8h
 A8eU50uMm8KeVlBQCh0En5tbdi9VSFijI/92r7J5XAIm51DVLYGY/fNxxKjWw5LliF1n
 UwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134590; x=1782739390;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CphGddleZtR7hEzVNCHN3RYvRxeTDa6IKrCwZ8q/dJU=;
 b=n0gVi+FOznkvc2/hjfCGo3z6+MSFSYmZ+FihwkiNLsS5apzP4d/K6bY6uYur6vSBg5
 90Lt3PvlWBNcHVblQtmTn826uvBeGY4oEGunAo3wWrf9ESQrwCH1kKJFLO9gM8ZcpAyW
 RuRSGpOGvrbTvtD6Sryiz1zzb+T10SkZXABkGFRIS6GRjmP4hY6/krSBxfzJS2cdT2lT
 rdlrIRAsDRcPqraJXgAjM+yfqjIaBkb4ykEuyTW47aA04eDWfEoagNqKtLw9MghUe4NT
 Nbckfl6ddFCOkz9IBOsC9TOocqpabvJ0z/Hn0bOXwA9eJY86YbDl5pkKVzWuGNdQ3EIW
 gdJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9g+BADu7ei6KARufLlQGrUg3p+91f5XRmCYwhuFEbezkFPNmoHJsKPHvADadqjXr1jMCnAHIMO1xw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6ujNMeX3ZhMEEltF4tOfNJDiCBl/wwPBaF1Td59YgucBfEp+t
 5H56i8vKZMUsZTG8BSs6Pp47LAWIAf0hlIlkZa5jgWqhYgRPQn9SlCc3AlqiBXmgXyohEQcph3e
 ZPNN8fk97kDlB98sg4Ykc/MY3ljnfyubxJWA0f95ZJNCvxdMhMDcETsZ3y7TV967IsKKcZ6M=
X-Gm-Gg: AfdE7cn3dxobu8ATJBhtgy1FX/IU1NusRauJRWWfjbExZ01h16/XNT/2DY0hWXvjj6v
 XQMWrzUaeesI1PDkaYzhLXYBapwjKJWJCo8mAOQ8ZWMQCrUBFvBgpHGeOyf4RH3caT9gHi+uQ7G
 arwvi5cEDZmvn+wfUnGFKIxELhRd/OhRxuRU+Z7kqY4OAtqVXOQEQivI2+RPC8KU78+NyAFUprQ
 /kFIU2KdTHUJS9Iw2yNt/Ek37E8EdQPTjcKEU0iIPOmeT1OgJFDehf76c+0XgemhYOmZH5Ox0jS
 IpjL5TnS46UKmdameuK4NOofJQG9kkbGXCNiEMswFNYsRxEvZ664gz9QHOw13NBDtwVULMWftXZ
 f0eF2frVAtjA7PfL4O/KhFqVt2FQS7prluOJz5aSP
X-Received: by 2002:a05:6820:1999:b0:69b:5486:e85 with SMTP id
 006d021491bc7-6a0d8935983mr10656623eaf.36.1782134590298; 
 Mon, 22 Jun 2026 06:23:10 -0700 (PDT)
X-Received: by 2002:a05:6820:1999:b0:69b:5486:e85 with SMTP id
 006d021491bc7-6a0d8935983mr10656589eaf.36.1782134589908; 
 Mon, 22 Jun 2026 06:23:09 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.218.240])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c5e4a14d4sm362337866b.7.2026.06.22.06.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 06:23:08 -0700 (PDT)
Message-ID: <0a6f92ba-de8c-48ae-9025-a7570e53e453@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 15:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: Drop incorrect usage of double '::'
To: sashiko-reviews@lists.linux.dev
Cc: neil.armstrong@linaro.org, vkoul@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 linux-phy@lists.infradead.org, olteanv@gmail.com,
 devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
References: <20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20260622101959.37DB41F00A3D@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260622101959.37DB41F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEzMyBTYWx0ZWRfX0JZefTgTLasQ
 Ci5pRiCt1b2FQu2mmaVUJvzktJB/I9jHHnZPYBlFB620lmv9/SDGzFzVBCUNdZKX65fsfLQ2EQE
 /CWp99Ox+HagW74PUVttDzDbc71IwgA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEzMyBTYWx0ZWRfX4iq3cM1WS+v3
 HC0l1JxMPITP4ir0Qm8Tj7ZpEagpP3ELNJK/j6LJzBeqgnduSfTnY7a9MZOe0ZWqwl4/mh98tFj
 yYT0hkdPkblm8IRrBfneL/0SEUdT1vMhWTwz1fhL20UqROPRbKYdpy4Ahea/9TN4K7wEqN3S8v/
 htj99RkL2iyw9WaDtc7T53K7licQBqhp35q93I4NPjkLMOvE+C/6Xgu7yRrMqLhWn3Pe1002PNI
 bc+zZiWE27/R3n3G9NG9Xa+SYnqFabbkCf/2q7YkSL2pfHYmvazLmDIQmxmZuY7CVJiJbkeRvsK
 EEO5QGJHhtJ0ckVk197/U2VUiKBJifDb0RQZ3QTHK9C7kjORouXUWLbdO7FTnz2IyL6lTSFwGA9
 6xBeZvBv1g0ooXG8+dhGOe3g/YCfwrBGSlwBureNfheT4OQ1t5UjWzJ31EBlygaQYuL1jyrqa+7
 RV0KDFMPvhdEHVI8oYA==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a39373e cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=qMZSjPy+XpteAuilWfML4g==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=fqWYVyBuAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5ID31NFv_XroeS7ycB0A:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22 a=3EkFFxAVN7Xjp7FSp-fE:22
X-Proofpoint-GUID: 1WYSHR9PBsQwHS-4fKEH9vv987FoisKx
X-Proofpoint-ORIG-GUID: 1WYSHR9PBsQwHS-4fKEH9vv987FoisKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220133
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

On 22/06/2026 12:19, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Unintended replacement of BNF notation `::=` with `:=`.
> --
> 
> commit a9fdd0b065eb5b6394a9c33ffba0fd5194e80115
> Author: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> dt-bindings: Drop incorrect usage of double '::'
> 
> This commit cleans up device tree binding schemas by removing the redundant
> double colons at the end of descriptions inside YAML literal style blocks.
> 
> Link: https://yaml.org/spec/1.2.2/#literal-style [1]
> 
>> diff --git a/Documentation/devicetree/bindings/mux/mux-consumer.yaml b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
>> index 9e2d78a78e409..769243a2bf046 100644
>> --- a/Documentation/devicetree/bindings/mux/mux-consumer.yaml
>> +++ b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
>> @@ -13,8 +13,8 @@ description: |
>>    Mux controller consumers should specify a list of mux controllers that they
>>    want to use with a property containing a 'mux-ctrl-list':
>>  
>> -    mux-ctrl-list ::= <single-mux-ctrl> [mux-ctrl-list]
>> -    single-mux-ctrl ::= <mux-ctrl-phandle> [mux-ctrl-specifier]
>> +    mux-ctrl-list := <single-mux-ctrl> [mux-ctrl-list]
>> +    single-mux-ctrl := <mux-ctrl-phandle> [mux-ctrl-specifier]
> 
> [Severity: Low]
> Does this unintentionally change the standard Backus-Naur Form (BNF) ::=
> operator to :=? It looks like a global search-and-replace for :: might


I wasn't sure about that... and indeed this should not be changed. I
will send a v2.

Best regards,
Krzysztof
