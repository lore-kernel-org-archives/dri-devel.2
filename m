Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481FB106FD98
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:16:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B484210EB0D;
	Fri, 13 Mar 2026 08:16:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T1HtgXV+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NhIP4FST";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680F310EB0D
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:16:06 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D7iLDr2262552
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E6XQvfblihOcc1wQzj+YqUTaImL2h2nzL92tytTnM/0=; b=T1HtgXV+q8QS/Q42
 t+N2lGQhJN73Y7VPlTxLj/DDPYsS1i7Pr4dbIzePY3dKdYIuiS1EzpEC237sh9H4
 SCmTSCsaCk+7I9Je0wy8eFoX0J7IOia6llGr2fc68kqoWXxg6c/OSdF1a4IWwXDy
 B7wbbizjQp9VjDjXjb3o+OmyLfkoV4vyckdBJnEaqhfWPCYPlI8xlLtjyD80p9GO
 kHPebfwU7aA0+yZLyfcHSFDCCRCym0XFFGziZ2XwikDok6onuYv7H4DdUKcbOrG+
 o3I99uLjyGS6WWAND1tZVqZZV+Y0IF8Xu3ZPY2vZeigd/fnpfLDtsEKH8IWQmC9r
 aL1sqg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvef4r4bm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 08:16:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cd85e08fddso1862271185a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773389765; x=1773994565;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=E6XQvfblihOcc1wQzj+YqUTaImL2h2nzL92tytTnM/0=;
 b=NhIP4FST0H68MZf9HfH0IcMNSPsh6wTyWLssvNJ+SlHk24faWDjp7I/R95UGthUomA
 TY+gMjboUsxnj0MvWmYK/xlR1E1BRMLA+D2Q8++UCkLdY61rndATYJLRdupxnBb/KNVh
 hGkOGyufNpkhRkcaWluwMNNPDTTWAFDVEHTUMqMWZUmgfM16obh+12NgLVMpv6clCuo+
 HN0ZvRQ9SsgkwVaJpLMzaMuv+ZxeeQ0ZE/QQxtLLZ/XOq84TdMtNZ/iOvCZH5UEeyKmx
 Aa22s+UQiomv+7yt6M5RqfrtiH3/LVJbDzl1GJPA0nXREbrLwU2cXRbXoeeAmbI9MqZg
 e6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773389765; x=1773994565;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6XQvfblihOcc1wQzj+YqUTaImL2h2nzL92tytTnM/0=;
 b=JOUQzsBT/JV2/iSlEmx45HtAETY/RAB4YYpHLE3XIhug6Rit5B1hyI0Ga3UEMHlyPT
 kCh+4pL/wyJl4238T1yB36gYLZTELz93PjFngheBhn2FM2k8+/+Kr792cJvutNfY80ob
 pyd4HtzBAD1Bey5ohu0+hqcMcI7IM537p+QmheBGUI9il62EPoIScmnnAxL4wcJsWCo8
 hw32g4zHLS/FwxHZostUkdFOsFwUrSSvp+hSmtZhWuXU1ZFR4iFI3J0QoTVlIPgk9URX
 lu548TiJbBGT1JGX5s9AgwJh3DRnlnxaG3ZM6Qk2mJ6T2xc+ayABIMJtISV8G+lLBmC5
 E1oQ==
X-Gm-Message-State: AOJu0YyHlsIOob63A460Q3CPY3oqejUSfAE5FxBdOgTELJDRl/ITXqgE
 DjsEF6bcgdXZtPxdwWmZ9Ul10dFUN4U11H0OFhcGze8PWDkb1LCr2VKrYI9mWQ4g44Khe+MJoYS
 yGhW7IoyPIeFAUjgcokMeGIRhOTPTNBUnrT3B68reOHq3pfBQPtnC5nTqCWWwS3I2Qc9BUpg=
X-Gm-Gg: ATEYQzxafAdzEJu6EJCYnCJJA1bipZ/avSMmT2IYF6tdYSEiRk/s5qzKdd+OfZrxXPQ
 x3KV9U1sBzLN0kNjWVY3qoOFDFItXyIS20EO77ntJtzJV1/nnOz2mdl4c0FmhBvw8/g2tbN7Bkc
 zyLyUMWKYzsb8CiFHazPS/r1ao7M50C2oQmkpNmm1WkBKpZqy7pvW2oZM+k1kogs5Tajtg95gLo
 i+mAPHKLxa7nJGsCO9tuda1S1UJ+RLgpIX2GT7rOBVGf1JoFgH5bjppb+a+busK/Qs6kBiP2Pnb
 h0x1ssG3ycepjyR6ov1YNtGZ/PqF6KrtM8fLfNrdn9DzMyiN/MwpLAu99KWxnjjseEkLqPFwvy2
 YXtMcxkdBAwBqtyWLn5BoDU+zoAtgiRBTKs67GcMVbxgXaisu
X-Received: by 2002:a05:620a:2b95:b0:8cd:b78a:9ef9 with SMTP id
 af79cd13be357-8cdb78aa58dmr220130785a.82.1773389764969; 
 Fri, 13 Mar 2026 01:16:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2b95:b0:8cd:b78a:9ef9 with SMTP id
 af79cd13be357-8cdb78aa58dmr220127785a.82.1773389764549; 
 Fri, 13 Mar 2026 01:16:04 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20c0b4sm17171372f8f.25.2026.03.13.01.16.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 01:16:03 -0700 (PDT)
Message-ID: <dd927887-bb19-442d-9ce4-d80f91d88fb4@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 09:16:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] dt-bindings: display: panel: Few cleanups and fixes
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Artur Weber <aweber.kernel@gmail.com>, Jessica Zhang
 <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260306-dt-bindings-display-panel-clean-v1-0-3086eda1efaf@oss.qualcomm.com>
 <177314934075.2052605.970030122356003827.b4-ty@linaro.org>
 <95ac5123-32d7-4e87-825d-5ebb424e2641@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <95ac5123-32d7-4e87-825d-5ebb424e2641@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aYEH3g-CK47C0lmmtjegqz3EsAUSj_9R
X-Proofpoint-GUID: aYEH3g-CK47C0lmmtjegqz3EsAUSj_9R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2MyBTYWx0ZWRfX/Tb6Tcfmbunx
 Q8S0aD4zyisfBONZLWRojDVp1wKMOFJl43KCFrt1V9mU0oq4V6XYI6pxCDP7FL3pGSpiV7UlXbe
 PKbzh5uiqHeDm7gOo5wcbDybbIZA1umFz1a75l+jwklPRcwfl1yDqqiW+dunIqdpsEWPmUq+NZi
 bNwW15ow2xHeMhU2Pn+YT+hZmj0b2HsbhVnVSRLxY1pswOCz8oxrI4T0L7CYTNad6ScnD+OH3aT
 3EwU4aeBGSIZciszPrIEOCBYwOuTiB9Lt61oZgWxAgRS6MOpNttsxT1Wn4xWhhFPDDAnK+Nyz4Z
 4lElkhr+PvCa0IvPCaMmKDrsd0fzls6n2OPkGc24JFl0VTpcU/8HP5/bIot2Xi6cjXSQwfHBjpV
 OErQAtl/llsQPWvH56c8iKIur2zxccL8aMCbI2LdMk+clgrMcsyAk53dUSstqRIZoBIQs9W2w23
 p6bKNeiJnXyLcCticOw==
X-Authority-Analysis: v=2.4 cv=S9nUAYsP c=1 sm=1 tr=0 ts=69b3c7c5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=e5mUnYsNAAAA:8 a=5EsEI0ad1I_aHy4ySaYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130063
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

On 10/03/2026 14:32, Neil Armstrong wrote:
> On 3/10/26 14:29, Neil Armstrong wrote:
>> Hi,
>>
>> On Fri, 06 Mar 2026 13:02:53 +0100, Krzysztof Kozlowski wrote:
>>> I would expect this going via display, but that does not happen often,
>>> so Rob's tree?
>>>
>>> BR,
>>> Krzysztof
>>>
>>
>> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)
>>
>> [1/5] dt-bindings: display: samsung,s6d7aa0: Document port
>>        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1f5a1ebddc170197348d203b11a05799966dbef6
>> [2/5] dt-bindings: display: innolux,p097pfg: Document ports
>>        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/32003681e575a9a02cb6814e99157dfab0b9f70d
>> [3/5] dt-bindings: display: panel: Drop redundant properties
>>        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/72cfe73347fac6252ab77d8dcd405f0a5b1a5a24
>> [4/5] dt-bindings: display: panel: Align style of additionalProperties
>>        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/66b0baaabd35d302698d0a2c98671bf4e1b87f92
>> [5/5] dt-bindings: display: panel: Align style of "true" properties
>>        (no commit info)
> 
> Last one did not apply anymore, could you rebase it on drm-misc-next ?

Sure!

Best regards,
Krzysztof
