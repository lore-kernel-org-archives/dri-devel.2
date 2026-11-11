Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8522606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kVyG+dO8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kAoO5csV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F1210F3DF;
	Wed, 11 Nov 2026 13:55:12 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8917B10F3DF
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:55:01 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCZDHE3292254
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VpAH/0mUJUkWVy1SXpnGYdECeWaz3fWTw17UYKA398Y=; b=kVyG+dO8zANLoad/
 wQzD1VvOMsR5njVZRsBUAwr1vGCA+k1kx2rll10semchFO+6p06x2v6hw2XJbuCi
 diz9X8+HNoZpyuReAW57RdbkJcxDD0h27gVlSzcLKSa8fMDztQcZoha2DgXHJTGa
 wDz1IPHcQwWep6bpuI7VEDihm9deUngM6uxwM5HZ7QRwfsOmKUW+/dmYtZo7cmR+
 hoOYlZYrz1KalQs9VTuhI+Fi27Q+Yg71QDkPjxPIZ5No/MB8TvGpM8qQl+xzWyZ5
 fIqgAqGZihkbHZ5beE6FOr3ST5xApgQJcml7GzbF5viuYPQc/rfKEjc9p8s7Afto
 gelvmQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp2rd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:55:00 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99b8fbf29a9so1121337241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794405300; x=1795010100;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VpAH/0mUJUkWVy1SXpnGYdECeWaz3fWTw17UYKA398Y=;
 b=kAoO5csVE/MKG0O4QMeeOHCQbeqU7DdnyoVgl51zOPYsNfVkgZTRp6b0qJdfIR5AbB
 H+vSb8EJSHqq9+wQ46uSvpShVAIEq+KMJ+KRAnDo3jZvWF2T5Ep0N/JlB6JOuKNvBoi4
 ex3pcOfYWiSK6X0i4E8TyQo6epM3+PAdnFzglp3/no7vV7+MRUSdZxjEcGawFEiXP4tm
 Fg+K3eaA+TtD/42ecV1btEy9L4TN9BVJOwh5zxa6Q/fpWynuBgOcalo3QDao14y5GAxC
 eK3Lk0xdDOwNRZoC6RW+wAd5I5S8J/U5SGJ+u9IWp/ZtxZ4EVAPX/xEuBMZul6Mj4xmX
 bopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794405300; x=1795010100;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VpAH/0mUJUkWVy1SXpnGYdECeWaz3fWTw17UYKA398Y=;
 b=K7SgjOD2y0p9A0bK8tLS9DpeW/ph1KON6jeBtBJT6VNo+CO6phDxuUA5lBx40uCf6Y
 PhH1l35MZa1Q4U3ZOTeu+LcFv89r842Xe2DIXt6+Uxcfjbfwewdlp0pDg+vX1sRM2DOE
 XDnNR2hcB0ZgHMWefpDixww/lrPplN4TaM+cTrCC5ZOHvvrUTMVsk+qF+noTOp4KeiAK
 dnTUHamR8NWbtjJEGKLjEH/IMjeOHKSknvM2JJeD2dJ3Zbbs8jkUBDzI8x+j9dbx5X5i
 S3L7FrEvoPdc6SPaCSX6Y+kdn5XicW/nRFGBFc1iFgdSIZm3K/4/BF/O/H+QyjQKbZEl
 Zxqw==
X-Forwarded-Encrypted: i=1;
 AL+hErGiTJqdwWfUxuYZ6qWANU7GHZpnSs3Khb8FRPm/ccELvoVjrcrSm2MeQjAcggyh2Do3J6f9XfnOHwc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9czGEpg0ftenMcjOetkV+cMGKF7UVWvZeGG0SO9kUBglMpyjrd
 p6A99rn0W4cH/RVaJmDw9aEh0tMf3YQrKGdwsSMF+AKG6m4Z+q+lIoqv3VGJ1ZbXnBokB6QaYYy
 hBavUQQ9hMN+WU8Ml+P/0KNPxHmlTGvvxzSrPW4fGaZ4OnaitXs7opBidr7s3hsvnMRnNFiI=
X-Gm-Gg: AYBFou3yGfdgJX49Nz7fdnw8gsmWFPpnwwR2rgrCKUtP8YUMIaUD6hg+4zoWnRad5vP
 L5sgGh9B2gnnrGp1g9XzAN9n1OE9skcTKu1wmdeqWja7eHChzQ6CtuREytxhLN882VTpJFFJUv7
 iG3IgfAGzPe065O3YDYQj2+wlvWTCGYdu6LLcmmJchSM2Rfa3XLU12JYY1CGgnBwqMzw51juIP9
 HtTM2nB/n/J1muraeoQNJtpBLmYQDf0MWW6VhZ72q3DMbr1ItM5Bqfbc7nPqhAh9aYKk3x0ENC+
 SAUyO7Enx5pNBJt8zETaAEDtMtTNqEJj9DAlO9gwNDZ+pHS2YMpJyEpg6AeVeN0sYr+D9k3aoSr
 HovFljh1JDgOjKEiyNm/n+nF9vbuXjHEst9o5TUc4TGVMEdKkRj2ZJklBDbz4OO1zdLG55W8T4E
 4=
X-Received: by 2002:a05:6102:3fa7:b0:7d2:7dcd:7c99 with SMTP id
 ada2fe7eead31-7d4fb22fca9mr601653137.7.1794405299725; 
 Wed, 11 Nov 2026 05:54:59 -0800 (PST)
X-Received: by 2002:a05:6102:3fa7:b0:7d2:7dcd:7c99 with SMTP id
 ada2fe7eead31-7d4fb22fca9mr601610137.7.1794405299222; 
 Wed, 11 Nov 2026 05:54:59 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe2c5asm217004135e9.5.2026.11.11.05.54.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 05:54:58 -0800 (PST)
Message-ID: <8a557bae-42ae-42bd-a149-cf854b7af9d5@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 14:54:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port optional
To: Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Selvaraj <jo@jsfamily.in>,
 Jagan Teki <jagan@amarulasolutions.com>, Ondrej Jirman <megi@xff.cz>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ryan Brue <ryanbrue.dev@gmail.com>,
 Nickolay Goppen <setotau@mainlining.org>,
 Robert Chiras <robert.chiras@nxp.com>, Alexander Koskovich
 <akoskovich@pm.me>, Marijn Suijten <marijn.suijten@somainline.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Heiko Stuebner <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>, Michael Walle
 <mwalle@kernel.org>, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Danila Tikhonov <danila@mainlining.org>,
 Jens Reidel <adrian@travitia.xyz>, Michael Srba <Michael.Srba@seznam.cz>,
 Shawn Guo <shawn.guo@linaro.org>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 Alexander Baransky <sanyapilot496@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Romain TISSERAND <romain.tisserand@gmail.com>
References: <20261111110338.81717-2-krzysztof.kozlowski@oss.qualcomm.com>
 <avRM_GhtR8vMdTO4@houat>
 <c8dea6ad-ce41-44d2-96ab-233b0a4b1340@oss.qualcomm.com>
 <43373a9e-9ff3-4641-b961-b63f4de21cb9@oss.qualcomm.com>
 <oubzclitudtqiv64wvg5lvxvbhuffxmc5bgbsdz4ou24pfhbb4@decarhvjzl2a>
 <0f2c0eae-ed05-41a2-8688-e4b6fe1b7ff3@oss.qualcomm.com>
 <avRy_D6MTK5u01_9@houat>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <avRy_D6MTK5u01_9@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NSBTYWx0ZWRfX7WBrGWchTWsV
 1hX7DzvCCtRSLsozkSsLWpJxfpF8skMJQmeEZ9FnRYkoy9r/ZbJnld3cUAaBLhcE00uqFDOeiNg
 s/m/BqRDiTn//1BJ+GKi3uiZulxrDEZSNt3K1UseOkQiaXtDHLLGOygkbrjW7H3RMr15FtTEF6+
 AngDpUd1JNxTYwFfUH1cOFLgnvJ3jDkmoo/hwWHcApdAJAwxa8EPK9Av0e65O7L3yivo5NOsrRL
 fxQ83MNO05tPfSevpgahtHDjTHYcZzZqxyRjC0VVU44fcZnEYxRgfP0Scfs8jsWpemKsyO3sQwJ
 404rUNdTCiRKShTsBMClvBIwIG0oAJg8P85CHl6S6Mgse1+Utb84YgH8BwWi//COf/ynJM2fJu3
 99xG/KdkiH4VSabDq1XBYJbrhJhCV4ZtVFVaadQSAcsn4smGNqUDuXLWsun7FpuYKXVJGQPSp6i
 nM3parawG747cgY6ZkA==
X-Proofpoint-GUID: wVMwBQdAmN8eM8J1iWpzZY-_fbnPezxF
X-Proofpoint-ORIG-GUID: wVMwBQdAmN8eM8J1iWpzZY-_fbnPezxF
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af473b4 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=24t1FKQVs-zwlIjxmd8A:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NSBTYWx0ZWRfXzbccL5urJirx
 NxGJu6K2baZ85OJ8NdYKhFplU+AiOjDQ4ypWEiinWU/FHFF0WB7ZqyWl9RSQOEfTQtGADK2n4W0
 61thEW+ws+iO+5Ywjron1lpHaQ6Ys0E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110055
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 14:52, Maxime Ripard wrote:
> On Wed, Nov 11, 2026 at 01:44:23PM +0100, Krzysztof Kozlowski wrote:
>> On 11/11/2026 13:37, Dmitry Baryshkov wrote:
>>> On Wed, Nov 11, 2026 at 01:31:39PM +0100, Krzysztof Kozlowski wrote:
>>>> On 11/11/2026 13:30, Krzysztof Kozlowski wrote:
>>>>> On 11/11/2026 12:13, Maxime Ripard wrote:
>>>>>> On Wed, Nov 11, 2026 at 12:03:39PM +0100, Krzysztof Kozlowski wrote:
>>>>>>> DSI panels can be placed under DSI bus directly and many Linux DRM
>>>>>>> drivers will work fine with it: mipi_dsi_host_register() adds device for
>>>>>>> such panel and DRM driver does not use OF graph to configure lanes.
>>>>>>
>>>>>> That's not true. We do use the endpoints to configure the lanes through
>>>>>> the data-lanes property. See drm_of_get_data_lanes*
>>>>>
>>>>> Some drivers use endpoints, some not. As discussed on other thread,
>>>>> there are more than which do not.
>>>>
>>>> "there are more than one which do not."
>>>
>>> Which means that those should be fixed. We have legacy cases where the
>>> drivers assumed that, but we should not target legacy.
>>
>> These legacy drivers work fine for 10 or 15 years, like Exynos.
>>
>> You can improve them, for sure, but if no one does that then requiring a
>> graph is a mistake there, from the panel point of view.
> 
> At the very least the commit log needs some work then, because the
> situation you describe in it is simply wrong, and quite different to the
> situation you then described.


Commit msg said:
"many Linux DRM drivers will work fine with it"

So many->some? Is this the only problem? What else is not described in
commit msg?


Best regards,
Krzysztof
