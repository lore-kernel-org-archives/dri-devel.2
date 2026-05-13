Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F034CD4F35
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 11:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0ED510E333;
	Wed, 13 May 2026 11:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WOl+l/WY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gOgHkzrk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A9210E333
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:10:49 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64D9jfMP3007267
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KTnOsN1aNa26nsuPQvXFuQr8/FdfroaO4RQWoGorweY=; b=WOl+l/WYwwUflFCw
 7idcPFCq+EwdBra14lr6AiXdJ1aU2h4xLKd7QJzjqyiae22ZJCHk+PujH4rmXgef
 GsjUeWJ4zYwDJyZgswLnTvTjwqqob3LqAd17lRtV4fvXNeSC0IQTphAjwh7oOnhM
 Ndrr6Dvxe9KxY0zljqec1Eqssl8VHhWtRubw4etAnOPTY5KBrnLmrL2rg/H87U0O
 g4yZYYi+nblmousnlHDXEMCbd8YHaK7gVYwvXsvJIY0u5H4W47FU1D1RQuXz7FCe
 8ijFlzIAzyxDEFht8pTLtZsnUDqnJLHeZFdB5h6fcSX3XxDHQJX1fk5FkbZyFqbV
 13nJ7A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4py0ga2h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:10:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fb3c7b989so102648491cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778670648; x=1779275448;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KTnOsN1aNa26nsuPQvXFuQr8/FdfroaO4RQWoGorweY=;
 b=gOgHkzrkIR81bmOYPVBTca2FlYvBtZLiACSWb5jRLrjNDYclbojWvmAk7kxBh2TvPI
 Nk6XRIHk+uG83OJD3IyaH/JplpI6miLb7SiUEwJvbhzF6OUKO1VElxHzrm0cA1Zkn82+
 LFGxEd28jmP/dm7juCxPmUmVgJMv6dPjqqYncYD1QrqiMJDlMzG2qL/soOdEao1f5xK5
 WrhxDO2B6HIoGN4Vesr5dBCgCSqbuqUX8kxpPNThYPIY+azolQEfaPC/ugf6eJUOW3WN
 Z+lLgYAkiaJ8ygmvAcMIWGKQpGZvGXxVRnCQ3+KErWy97O79/k00D6rjv0CkkTyUxkYd
 B6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778670648; x=1779275448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KTnOsN1aNa26nsuPQvXFuQr8/FdfroaO4RQWoGorweY=;
 b=r3dLsZpBZmkNiI5tpaJzDmmTr8iIgqXYMIjXsJl2M2dLfnPTbTtyy1jJic+aRfWjgH
 H9fEk2GZlve+lYdOSfFT2SZ6eAAMQfERoEUgSDcWCsZUwTH7TN3VSDokGUWEz40ultkY
 a8tNye7EphEsRkbmnqhWcBq7Djqk+VJR+fo31TFkN+qZJlDqzLG8Mc8yBtAX5QGszyKV
 JypizPFOZMqW1gMbbBczwDj5v10XHab3y+Wehj/AHyc8SlCKPPpQU1KEegzkdEEWCaea
 /ie8xQT5113M+YcypObuhq1+9KuK3liQjQuKIPZgKOIUs2SUALi37IMzhMDxHPfERhOx
 Hgpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2oGjTC8/VZO+NVNHexqyhs1DOG4ekGuPNOK3IeaahwLAFPk5dZt3IgYvaAiX2k4od03/vgQMeCJM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSYxW2FTZeqKutWpTMa7G5dOgyAvmMNfzcsoRp4LDcprnxzEnT
 kFKs/xHCsXC9wcRSF9chYDbTrqd+K4uC/IsBkIH93UsPvydMGCLtDizXdtjoup1/vmySs/JrzSQ
 lLGrNZPenpnlusKtM50roFW+IU4DQD7VAwnMcht4/xD70zE09yTBFMH4dqEwOTijBow2b8IQ=
X-Gm-Gg: Acq92OG+TpqHBq2/AAxu21luO3zCiLY9KPArKudNNhcqgBSPoObwTTWWehFQkk66xIb
 ppR9WGXYXXykWksvintQwIg0EeGWgL+wd5j8TUGDGXNQQarrRzzLKEVPmZrOzEAJ6qEG17pWJY0
 TexqQ+g9BbnHP4cMhYVYHnYGc7lP4uGx72LPQV9wY4V/XF8bBSM9OKhrt8m1eeGTYYxTeW1Ko0A
 UhgGlsVYmofiKWbBlAwla9Ok/xdE22+UJ/p4t9wpeuLPn+NjjofbNR71OJR8tLq4EzWc6Oyh6m+
 lh7az/A0834YiWsc/czAjpW2+POaCnu6QQqLwp8KGSLKE64rXZQutb3kLpGT8KgPrWm3z9O8byI
 M7F4Ue+6Lq/F445akpEkaWA00tokSqmjY+eQ62Sk9gQ7tOBCeICmaT76O8lsh/rp/5Z742CL0j6
 //7ua6AfbP5kXZET3vVQp5l4I/emjIAFiYTTjsOXco9aLupTPJrDiePG8cTy5J7w==
X-Received: by 2002:ac8:5f85:0:b0:50f:b978:82e9 with SMTP id
 d75a77b69052e-5162f48880amr34365611cf.14.1778670647660; 
 Wed, 13 May 2026 04:10:47 -0700 (PDT)
X-Received: by 2002:ac8:5f85:0:b0:50f:b978:82e9 with SMTP id
 d75a77b69052e-5162f48880amr34365091cf.14.1778670647149; 
 Wed, 13 May 2026 04:10:47 -0700 (PDT)
Received: from ?IPV6:2001:99a:252:3300:d706:9b57:5996:15b4?
 (n2i9bzmlzk2z87merp0-1.v6.elisa-laajakaista.fi.
 [2001:99a:252:3300:d706:9b57:5996:15b4])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a955e1fdsm3984374e87.47.2026.05.13.04.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 04:10:45 -0700 (PDT)
Message-ID: <0636aa3c-5240-44a7-a551-4740956ba5cd@oss.qualcomm.com>
Date: Wed, 13 May 2026 14:10:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: bridge: Add Lontium LT9611C(EX/UXD)
 MIPI DSI to HDMI driver
To: Sunyun Yang <syyang@lontium.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 mripard@kernel.org, Laurent.pinchart@ideasonboard.com,
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, xmzhu@lontium.corp-partner.google.com,
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com
References: <20260508142500.4922-1-syyang@lontium.com>
 <CAFQXuNYq5QYAXRzcUBnyvVh5ofPBVYONCs1dM6qPgK0BDja5Ow@mail.gmail.com>
 <vly3gbft3k76mrcztcn6vxuqadz647hsaz2q7qpmpofowofodb@nnxrr2cdueru>
 <CAFQXuNZKoahwq0zoWg860Z-amTKEefBFuen2fDG1htKjzE7ymw@mail.gmail.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <CAFQXuNZKoahwq0zoWg860Z-amTKEefBFuen2fDG1htKjzE7ymw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDExNyBTYWx0ZWRfX6aHCxFZzqeBq
 sT7te/MP6Abb6dBv12jPAIrHQn8SnONmBLaD+3PTeVYa2WzaMWOmwec0rSwQGfj+BiGeo5BetNE
 BbjaFwvvWJiffy7Zj7wmLX0yeHnqGVprW7ffNMZiBQujtgPBReuiENEmMaunjpxd3ZVsLC//cFp
 XnQBhxeEu6XhLfk8kPRn9btUGlg/rUIyN9pM1VCoQ46aIoGTB5wkv43x3g/TUZX26CYvh9l303V
 bd7ZkTPrz53wVZejSRG447fexuuDeH0dXy6YgAFJxRZ71sKew8wCjZwVyIPAnSih10EhRDD9uDB
 rg6wNgPFycQrh5dj/i5fnWXj9/52c7lRvysD+iy4T/zgBtqvhyv4pIb9eVYziRPl2zzkTxnMHcX
 PFWuLkjwLrvY5FMm1jAvwNoWEqU57lcpY3xMpybkfaNkGD3/AkjddJAcZ9xmEi8PJG8ALeqLdnb
 XVtDcUSW9dw7zWMvFug==
X-Authority-Analysis: v=2.4 cv=XqXK/1F9 c=1 sm=1 tr=0 ts=6a045c38 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Kz8-B0t5AAAA:8 a=2kvw8oITFPD5c3g4VIoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: BbtJI6OUq3KOD3UeahpTiOmqBpnpSR12
X-Proofpoint-GUID: BbtJI6OUq3KOD3UeahpTiOmqBpnpSR12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130117
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

On 13/05/2026 14:07, Sunyun Yang wrote:
> Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> 于2026年5月13日周三 18:24写道：
>>
>> On Mon, May 11, 2026 at 11:28:06AM +0800, Sunyun Yang wrote:
>>> <syyang@lontium.com> 于2026年5月8日周五 22:25写道：
>>>>
>>>> From: Sunyun Yang <syyang@lontium.com>
>>>
>>> Gentle ping.
>>> Thanks.
>>
>> You've posted the bindings on May 8th. Please give maintainers some time
>> to react. Not to mention that you posting the bindings 4 times in a row
>> (once together with the driver and other 3 times separately) doesn't
>> help maintainers.
>>
> Sorry, when I submitted the patch on May 8th, I received bounce
> notifications from devicetree@vger.kernel.org and conor+dt@kernel.org,
> which is why I sent the patch again.

And some patch trackers will now have incomplete series, others will 
have duplicate entries, etc.

In future please use `b4 --resend` to resend the whole series at once.

> 
>> See https://lore.kernel.org/dri-devel/?q=bindings+Lt9611c+v6
>>
>>>
>>>> 2.34.1
>>>>
>>
>> --
>> With best wishes
>> Dmitry


-- 
With best wishes
Dmitry
