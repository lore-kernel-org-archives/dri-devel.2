Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045CDCA5FCF
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 18:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 430D110E03C;
	Thu,  1 Oct 2026 18:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lKdRi2yu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j5vPEy8A";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7DF410E03C
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 18:09:36 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsdU33109252
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 18:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V9uXDb4OI7XH/Jm42mjZ9uKZxzZj3a/tu0y6m6HKjOE=; b=lKdRi2yuep1oHCGO
 Rg5+jkSakdSc4JS9gjY2OsNjvS7HlidXFaWLQOR9MLQC0FqG0b9LfsNTtGJJqrwi
 xPU9QJPYizmAIbdV/zASeRBsVuHQ1vLGRJCgiJnZowDWpxA56XvA+dr19PgfXClc
 Bc1ElCzn4eOga4BBMgbikr/wD4Lp15IAs7d873NX6YiSOQyp6HAY8BfWbCw0c987
 AN77QIuv2KBR27A6jPDGlusASz2MEun7RxVzGrqYuVxq42pPcTsrsMHd1byWnmWl
 YqoYo5GDYVNVbKcCKtu84WtawT5yNncW9KWq0MiOK5dNgFG4eRGJ0iqd0QpSwtDh
 ZYKaHw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1jcfu2sn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 18:09:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34afa104860so4441031eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790878174; x=1791482974;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V9uXDb4OI7XH/Jm42mjZ9uKZxzZj3a/tu0y6m6HKjOE=;
 b=j5vPEy8AZA3HbrPmBATjzIeBTxXqnlgeBF+f0lsFIyjTeqQZmfYZKo8pDMBmXG1Q0Q
 sCVhNfpmr4GhGkD5Z8nkpYMqRrsKDfyO5xO3Jt5fhg3jptbiuu7ZfC295Ya9EaByzvXT
 UE7hbNGZPQDUtzm7WIoRIhp+83f3lcsE4+VBzUEafz7FYcneyIhXNADhYgukIpnbAbHx
 i0eTF5v/8sSWlIOnrdwJRGXBi7f9Qlt994qKPeVmP3CeqXYC5EAx/IB+SGw+BIIJy9Sl
 3Zgh+edhOnP8rx9wXSnb99mEryW4thUidCzUfCD6geCT26ObGxZzrTAnHZM3mbDs8ArW
 JUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790878174; x=1791482974;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V9uXDb4OI7XH/Jm42mjZ9uKZxzZj3a/tu0y6m6HKjOE=;
 b=DUeizK70QX5hIRfKHwhkT9Qi0tlYjO2OxVhH8vm9EJilJQyFeG+vbh/WMh0dAY9cry
 xYQNT52BiDkZSFicmYDrESio4goyQ5gcrHitLN+bp7Er/BfM6NY0HunDAMwBeD3k4OvM
 aUZzed4ATZSsF38APqs7HQUMTQV1BZXVn/0T9pbCkIK7BLEbwLMvH850f4TIw5zcmu/N
 8NHzlgKxen2S+Bhe3FPCEunB9pMShhtCa9EcpbywODRGCulb4eTFfmBm+AORH1WKpX8/
 IRj1sjfyq+ro+eTDYbMMXEEmsDM53sSLRw2m6Skthe7s0/esJLk/3ufHMv1fJq2AA119
 ZPKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCyHJv5yFBG0fQi7bzpqVwq+nwSP1IsSHxn7APS/kQi1/yBbVZJNANBh/bmjdVUjrg0G+XiklFiNE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlinc4NAlM/84vm8cULiVu4pMnpw880COAZijeAbWoc70L8T9u
 sxiwaKASN0Be/6ccNKO905SJFaAZWyBRzlohiRsd90Ec8dWjJeW4FQO5hEufHtJ59md8pZvi3z3
 H4yIUtfck9aYTevtKB46CZZNFjGvLP4MBvoI8KJshjNmIo9oBQ2Fq/ZJOHYDMIJph4phsSbA=
X-Gm-Gg: AYBFou13H/K8SDpHTnOwYOyVV3N3K6+uM/ews6diyPgVfrUN5jfqV/DC3k4sIlbMbrS
 eAKsoPvUlxbQK80ojwCsyBoOBxOd6WqoGoYmNo9kjL3kTtbLHu4rXcJozbIZLRaftq8ZH1yiJ9c
 yqCxoasS/IsMqdLeYqM6lW2F3r1H3P3iD7F19lRLw7MhzDQbfv84uwRrRebD0+MgrQFuXHL8pHE
 e8E8Mr8NS9GSdMmSy9L5g2PqWo0lQ2zQrLcU4sALYRIfbjjz3NWxsKavMjndP32JjPB97dr1F33
 JUMe8P5DQHV2WfwqTCDB6NzsPDz6llpfNKN3uv148rvxVTQMHWP2NTAcJSOor3MtuR2TxCI+/FT
 0T43uWRV80dG98JQE9GQpt6PeSWc=
X-Received: by 2002:a05:7300:dd0c:b0:34c:d018:f33f with SMTP id
 5a478bee46e88-34f150aba7amr51797eec.16.1790878174098; 
 Thu, 01 Oct 2026 11:09:34 -0700 (PDT)
X-Received: by 2002:a05:7300:dd0c:b0:34c:d018:f33f with SMTP id
 5a478bee46e88-34f150aba7amr51739eec.16.1790878173117; 
 Thu, 01 Oct 2026 11:09:33 -0700 (PDT)
Received: from [192.168.1.2] ([122.177.247.10])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f308fdsm107784eec.8.2026.10.01.11.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 11:09:32 -0700 (PDT)
Message-ID: <1cd249d8-0a26-45e4-8263-dd4a120fc89e@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 23:39:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add optional wled-supply
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 devicetree@vger.kernel.org, rajeevny@qti.qualcomm.com
References: <20260929-wled-supply-series-v1-0-75d0a83b4b00@oss.qualcomm.com>
 <20260929-wled-supply-series-v1-1-75d0a83b4b00@oss.qualcomm.com>
 <20261001-private-wooden-chachalaca-51aa57@quoll>
 <997cefa0-384c-466f-b318-077939946768@kernel.org>
 <cebrka4ya7u32ntiya42yx4txa3uryf5k2di234zm4enz3a6vy@xhily6qqmevo>
Content-Language: en-US
In-Reply-To: <cebrka4ya7u32ntiya42yx4txa3uryf5k2di234zm4enz3a6vy@xhily6qqmevo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MiBTYWx0ZWRfXxAQPZoVjUFaZ
 Qr/qbYm2veueeKsvbOxHfz8ygRosXPPfzNfAygVpnbv3SdBKhxkBXEyQU7WiUsbaCmPDpVJOJEy
 1dw3mGi1AA0pTX5DwkEdCC+9RX72VqE=
X-Proofpoint-GUID: ojaNPzrzLeEzT4GfQjtLkg80cMkHhxh2
X-Authority-Analysis: v=2.4 cv=b4YncdGx c=1 sm=1 tr=0 ts=6abea1df cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=wK/bf7D/7SIwH/zgYCzwZw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7E6vT_6_9trQ-LPmnsAA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: ojaNPzrzLeEzT4GfQjtLkg80cMkHhxh2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MiBTYWx0ZWRfXzqrle+8YxlNA
 LwJGFxXfvTs3pSqNgyjBzcHDfyC6hW6M7aDemlh9JXWBYWWBjDQKspMmn8KSRftBkNNFEV8UAa8
 vJWthbfZAxw2s8HmjAfemqOTlMlQv5ZC56L9twYBvPmgfzn3jTeSPwrqomT84l07iY6kpiT/j7N
 BwjJjkRdNoHJJCqODZWFVnNuSTmA6VbOLPFPY+JHSOfclLsw3I3Eo/t9T2VljQvv3316tbkiAgp
 0NQ1yNRdCZuY+RGgD5abFU4qk4Mr6nc+7KcFyouQm5hqZgYPIDR3BCut6hYgn04nNkCTpYqPkG4
 l/CgJPkWewqXp3vV0ThiVlI2KcbjaDLqXoJMEfBluYhC/78z/Zl5/S4FgKXn+SqYDu17Nv1xIUK
 3OshIhc78RJip7hJKSj+Wrmie3XKCSu3upOViInSI45bHqW4DLLn4rjpQa3ojkXcQfQkgKkoYBE
 cUgPDM5X4wVU4TPYRAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010072
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



On 10/1/2026 3:25 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 01, 2026 at 08:57:52AM +0200, Krzysztof Kozlowski wrote:
>> On 01/10/2026 08:55, Krzysztof Kozlowski wrote:
>>> On Tue, Sep 29, 2026 at 06:42:20PM +0530, Arpit Saini wrote:
>>>> Some boards drive the ILI7807S panel's backlight from an external
>>>> WLED driver whose enable input is wired to a GPIO, typically modeled
>>>> as a fixed regulator (e.g. vreg_wled).
>>>
>>> You describe something else. What's fixed regulator should not matter
>>> here. Which pin is it in ILI7807S?
>>>
>>> It seems you just want to represent GPIO with a regulator. This is just
>>> confusing and typical downstream workaround.
>>
>> What's more, you basically REVERT the review YOU RECEIVED in v1. Really,
>> just sneak the same stuff 3 months after like the review never happened.
>>
>> NAK
> 
> After discussing this offline with Krzysztof. It's not a supply (my
> fault), it's an LCD driver. So, the best way to handle your displaycard
> seems to add a gpio-backlight, reference it from the panel and then in
> the driver check for the backlight's max_brightness level. If it's 1,
> then you have to send extra DCS commands to control PWM. If it's
> higher, use normal backlight class controls.
> 

Hi Dmitry, Krzysztof 

I have a few clarifying questions regarding the proposed approach. Please let me know if I've misunderstood anything.
 
  panel_backlight: backlight {
      compatible = "gpio-backlight";
      gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
      default-on;
  };

1) Adding gpio-backlight and check for max_brightness level if its 1,

   If we model LCD_BKLT_EN using gpio-backlight, the backlight device effectively exposes only on/off control (max_brightness = 1), 
   we can't support the full range of brightness i.e 0 to 16383 (0x3FFF) 

2) Adding gpio-backlight and based upon max_brightness level of 1 , are you suggesting to register another 
   backlight device that can actually drive DCS brightness. In that case we can actually have the MIPI DCS controlled brightness 

   If so, wouldn't that result in two backlight devices associated with the same panel:

    gpio-backlight device for enable/disable
    panel backlight device for DCS brightness control
 
   Is that the expected design?

3) I previously tried modeling LCD_BKLT_EN using pinctrl states (panel_bl_en / panel_bl_suspend) 
   for the enable GPIO itself. However, Dmitry suggested modeling it as a regulator instead:

   Link : https://lore.kernel.org/all/qkhgg5x67sijiialucvzac275zhpjrtt47a4udjpyzmgvilut5@dcrslq3ai7mc/

4) Modeled optional regulator wled-supply: a regulator that only gates the external backlight driver chip's power/enable, 
   with DCS remaining the sole brightness path in this current patch , the panel-himax-hx83121a.c does exactly the same.
   
   Would this can be the preferred modeling for such panels?

Please refer to this Hardware diagram I explained earlier , 
Link : https://lore.kernel.org/all/bade420c-aeb8-4bdd-b0cf-3ade17b21c18@oss.qualcomm.com/


Please let me know your suggestions.

Thanks,
Arpit


   

  


