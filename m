Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FD606A327
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M8YkKQJz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S1oWGDzc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 096FB10FB72;
	Wed, 11 Nov 2026 12:31:49 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF22810FB72
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:31:37 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCPxAF1229580
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 18nAmy0Rw3+8ZydYCQnphip24SphiKWNlEUNCb4K9EM=; b=M8YkKQJzuae/NJV/
 myZr/ObO1tyiVD4Kg4EGhWc6KoHQGb20zdsWicCyoLKMeZhcUCke/QJMOjNT5jmu
 fB776SPGIbuzhCGAIJ8KLoAU8JVtR2lHaqj46EwazLtjQWts370Lb/g/NXbEWVoB
 zboCxylr04BUsBum/wyv48LoDD0iMCViAnbvtS7Xjzkh5d8VU/fBL9f0RZqgasNe
 r1hG/116uhf/78bQkcGhl2HCRRjJttIrDHvVjRVMLvsWId6Lv7tqoxOXpIF0AyO8
 Fc4QUi6POKw2ZWLdD5SCZJRLZ1VeRbvaCGQFyP2YeziOMnzpA/9g+B/tpltJwqvt
 SFrtkw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5m93d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:31:05 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99062be02ddso481912241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 04:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794400264; x=1795005064;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=18nAmy0Rw3+8ZydYCQnphip24SphiKWNlEUNCb4K9EM=;
 b=S1oWGDzcnfYNJdMzQwD9pEFYWX3Huass7ncyNx8YCHtJ0vfD4IggyQr48B2wweFrvm
 zQVmn9bgq+tsNp6/Wqfx1l36maYaZKc5t8U796H8PzprNbvDCeQlku257X2UzYvnjfuE
 SUXdo7ywrFEWFJznr5O2vDkOMnva+Rd/932v40SDK1+xNDHs+AzYOmN8zy90CpYBObuI
 ocGQiaWSHBF8KfMkYEbnBCd3zfCPlTLMPgTjvQC1qEBzeP7ASID/82wdXgLe63aRwkQc
 eMFGtst7Ic1cyo1ZpNp6fBhg7/Vx+9cNF0fsIE98ODT+vxLb0UaO/XDWhFzi/Vn8Nf9F
 YVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794400264; x=1795005064;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=18nAmy0Rw3+8ZydYCQnphip24SphiKWNlEUNCb4K9EM=;
 b=xgO1gnFwPvyWK07t/RTAO/XMgAXwGNRE68hfzNzwjApbgH1xZL6d1Cui8Z+XTOmiOA
 oFGlPrXqOtiu3R7HALKnVb0m1S3MjjGGK8nA8HMrDY++iqbtiMQqL0GXd7hy7lj29/KK
 aI+izk2FE8E5UZd0mryccWxF/3VaCrw4m90FSWFOm2iwA2aBcYWwFRG/1BdecCWmJIZ+
 9SxE6/QVB5uCsBnSeEHidlEBRRjdxXtJk3ymM1SViEqP7RcsXhIljCQ+XM7XWLlxnbpZ
 /Z4Xa7T0x8rXxlUjY2/lb9ic3DXhKIxaettPSkdVzYaMHktl2Hr+1+ZBA05vlEhFSdYf
 +BIA==
X-Forwarded-Encrypted: i=1;
 AL+hErG2Cd/ev0/4oxT+XKqCs6e1znEybFv2KBrSlvAQgekxXZqhw6YAqCtwMg8wcc43IzV/t973z/vaGD8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/7bK+Z+nPAw8hPnkYuJu3jTSpDWQqkI/Zi+tCbAcMsY75IhePP
 R+MYhummOITY/FWtKx4DeJeqPV5ElKnbvyjBFdt2JuTpJxJ4dEel0ME64cSh4MreRxA5HsBx5bt
 jLE1lddF2c3n4RkV8EmptVGssASYdyW5JCcZhojO2NzpiQdLSiUroTrDwMweY8uHA2HoqKEM=
X-Gm-Gg: AYBFou16H7Jeg5AGpCAb/1sqwU/ab7TdVmLISbllSwFRvfvDIGKpYDEJYW+W3UqVYo1
 Y1wxPbj2AmM8NTEbEiVm7bupVU5IX+Ko8WfSYCaUDn5qkkrOHDTQILkOsefpFEVBvblS5uNGjdm
 djmFcCaqUCAJBielL/fxhlV0+VJrQGQdmtWVO8dwox3dp0sDRvpQTj/s8eE9+ta9DlarsfpRytC
 j9BHnj31wPZcLb59qgxBVLpzuUtO8W3yeJMNuf84ldXkDUXrqhbCRo9bPlbz4eK1j1LpQNqdcvp
 J7hw2EQ6ZH0eg7qQxWUA0vnlUVAV0541rupcctsMvBO9unnt0tz2Ef5lpOWsSZre1OZYV8X4NLy
 KElBHGRXq3VPmgl26e+r9YG21HnFJuuQwwJKNtcT2K4NR4PQn9tTzuMpf31V8olCVueHuYPmweb
 U=
X-Received: by 2002:a05:6102:c54:b0:7a6:d11b:16ea with SMTP id
 ada2fe7eead31-7d4fb255ef6mr538733137.6.1794400264170; 
 Wed, 11 Nov 2026 04:31:04 -0800 (PST)
X-Received: by 2002:a05:6102:c54:b0:7a6:d11b:16ea with SMTP id
 ada2fe7eead31-7d4fb255ef6mr538702137.6.1794400263480; 
 Wed, 11 Nov 2026 04:31:03 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0951f237sm35965765e9.4.2026.11.11.04.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 04:31:02 -0800 (PST)
Message-ID: <c8dea6ad-ce41-44d2-96ab-233b0a4b1340@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 13:30:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port optional
To: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <avRM_GhtR8vMdTO4@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0OSBTYWx0ZWRfXydckwSeom4Gu
 6qCFc4T+ZqVmJkEtbnncZbgMIaMlNyfHtgTbzKcoWBA3NnXHEaCQPyAJMDv2zMHmnQNOm5InCwk
 ZHBfj/IJunnKFuSE7gHFakfuJJ0vZ3HVpMZ0XqDdUjMWag16IE0LtAN25qAL9zJD5hZ/s3TqyUY
 FL8qccGlMuPmQflCj7HC4JvC1qKwM4N8EUMD9o1IUXav6c7l9HUAf1LtTAHhYiLuZOQiPWw9sRO
 KxW89XkrRj1bZh+2Dd0loF71yFwqvCKU/ZXDaoGauDeXinr1VTqYpd1wJVSipxoC+hs3P3h1T6f
 8+8GOrpVwPVTUDemTydSAjjANd6p2m7GGUcZHKMGOJLW7+34bedXUS9KYddxLnpLJcIKW7zlbYI
 F71EJjbOsMHA2oYW1VDFvcf/m7JjWAozOA+0R5oUp2MUIgk5eAIY0VJjGjEO3ixSzg+GLd738x0
 u8rhXsFbgKEG4uwnRHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0OSBTYWx0ZWRfXyJig5NwEfqDm
 Vm7/ctFFbp3fg/ln6YXX33+BGXvvJRM+89NGXcuOCcUWWgzLRFAB74clAnU1n1q6XwKsKax0cQB
 IagleDZHWNaEBbYbWTVTYrRwrIPCMfY=
X-Proofpoint-ORIG-GUID: 2z_s6ifHxJ6F9hYJcToleoS4hgPsOcz-
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af46009 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=iRCOULmDqfF0gFl_j5kA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 2z_s6ifHxJ6F9hYJcToleoS4hgPsOcz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110049
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 12:13, Maxime Ripard wrote:
> On Wed, Nov 11, 2026 at 12:03:39PM +0100, Krzysztof Kozlowski wrote:
>> DSI panels can be placed under DSI bus directly and many Linux DRM
>> drivers will work fine with it: mipi_dsi_host_register() adds device for
>> such panel and DRM driver does not use OF graph to configure lanes.
> 
> That's not true. We do use the endpoints to configure the lanes through
> the data-lanes property. See drm_of_get_data_lanes*

Some drivers use endpoints, some not. As discussed on other thread,
there are more than which do not.

> 
>> The affected here Linux panel drivers do not use OF graph, either.
>>
>> Requiring graph port for such panels is tying the binding to one
>> specific implementation of Linux DRM drivers, e.g. Qualcomm DRM which
>> requires the port.  The port is not needed for the hardware to operate
>> and for some of the Linux drivers, so it should be optional.
>>
>> Suggested-by: Romain TISSERAND <romain.tisserand@gmail.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> DSI busses can handle multiple devices, and multiple data types. If we
> were to drop the port node, how does the upstream video device know
> which device it should send its video output to?
> 

We do not drop the port node, who suggested that?

You do get, that we are not talking about the DSI host, but the panel?


Best regards,
Krzysztof
