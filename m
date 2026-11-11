Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E910606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M+fYDss+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iqYK0NlK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D29F10F9C7;
	Wed, 11 Nov 2026 12:31:58 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5256710F9C7
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:31:47 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABCPcHr3270926
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HYqCJGzgAv646u429yCqw4YAZhdaQondpXuCRwFFu90=; b=M+fYDss+XW4jSr8y
 zRCACHgf54Tzk75tMzpDYfNl9Dy4PPZIf7DnKhHSB2HhViYPzPyEqllRWe1AaHBM
 AGi6HGO1425ISVleGuGzGEdpez7TuZAPuKvNWPUt5vI/2GI7Wd/9rB/mu0QBkzYv
 pgDOR7sgNNgoNClMBBACIXYQ2cdFP2r0hQP3UXUQuLnZlrTBN7FeROainvJLALb3
 PgY9sM5ccD2nGqKC9d91wjPJNlTrBsxb0PWK+FKfhUiIP6/QpKjhp9VXZXvv44Ll
 nTnTHOOJXPJvLFVvOFRxvWFVgZjeTrymTgceT1hO3F94g+1eklrWHBGEE4EX5AxZ
 A+urLQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvdnp2fu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:31:46 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eac42e83e0so761958e0c.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 04:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794400306; x=1795005106;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HYqCJGzgAv646u429yCqw4YAZhdaQondpXuCRwFFu90=;
 b=iqYK0NlKe+AXIYs/thL9gCU6KeOZbG2QYslpRVSyDECdSGiwiOna64QG0tyDmt8lmn
 1mvDW3KADGHNHiOgoNjdncmEue4prqwAcEC/qjh/MsH8NQ3ODj5kdF2F/UwP07Tp152G
 OCdvJDQGN9yYXmnonzu4/mATZdhhc7RBWww6dID0y+UqBwRtFTnzgBnu6jMqdvNqIYSz
 BkYhoSJZTHqhGlIjUo/Jimk9ZcpkxVAEGbC44fPMyZozxA2Y5hYwjdUREws31EWqVgva
 /MkRK/Gg7iQiB+0nn3KAfBhAMjnespiMiMGgQPluft/9Kzr2vFy25eM5N00TkLF1obGh
 AWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794400306; x=1795005106;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HYqCJGzgAv646u429yCqw4YAZhdaQondpXuCRwFFu90=;
 b=EZyZ3TyyT62N3RcZBGg5LdHZK8nAIT1iKjKbF9pUcoKq5xeaa31PPH3TKxzMR/BjKW
 8oiJa/LWQXvOISbMyUK/N37UzZfT0FR0O/AbkCq/UVRGEeRyCNbCw7Q2sL5EqaUP5tZl
 pO2PgQepI5Kk6RAyJvVOXheU+5lDSdaojJtbzxf1F6s62B8h6x82p593AaMWcvMh6S6I
 Dr1GXmx24iFSZxqjFmGYiBiTzPbC5x0bk5cHrLf3+vqAWVl28axKdqhOLj43MoheGYdE
 +zr0F4sdEs9U8InAtd+3qO5w2GnfPAURm7morixkpXtMjYkKAk5MyxV/nZ4EejkvP7vv
 4ASg==
X-Forwarded-Encrypted: i=1;
 AL+hErGJX47YAQmsi8FOiQIXS8UglumY4QTaBNrnMM9w8+qO6mbXzid0Mpznudqn4vM0rWVrWKKPr7duvEU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/f7CMvJtzMpN3V2nZpSLJwOrVwjh5z3bGDX6mTdqctuVlIY80h
 E7eaaZ/Bx8NnahxgO2F8UVpkBE2Z5Rcl00RgTwjLvHITi+V8DNU3115XprSP0gN8gjHTbg6zg/P
 fzI0wOthZz2j8IqlZdumOWtWEkUzJZXi95wjYVsVKyXS9eBslbrWbHA8P9FjIWiq8rcexRcU=
X-Gm-Gg: AYBFou3CAotRhpNw2aPzf3yaX4+0NM/O+xDiAl0Wv5YEnAj1W1kiy1xQ2B25kKakbaP
 KBTvUAmE0f/t1ugP9VniNMjUJmeXv1r0lqIiYKtGIhbyRo/+rKUVN77SRF86GmUcjk1yDYXMlQi
 o8vu9mOPmlWvf7QcM1q8NsVgiF0CppVwOOpzG0ttmNrSdGSypYzXrqvahYmkqYem/xtS3hP2YTe
 F84UsIpAgHfUx+TfmnSDw/OcyREmhTMTyMhwCb1wSrcHS02FFK3QRAgboMp4ETBLNuFe6m+IDQS
 knXkJxZau+UK7hRbqxh6O2OWG0J3ehU5hhrM380Hmz386SoVU7cNwn8PKJg9FowuEjyS4Lajvbi
 9EgaZJE6lyJKbzC+xWQsH4OpcI4s4PPU4aQPli5mf37G2pSH5LEaJPzs1gliGn5SydEKTKaqaQw
 g=
X-Received: by 2002:a05:6122:4317:b0:5ea:e196:272d with SMTP id
 71dfb90a1353d-5ee1c3db8d2mr575833e0c.6.1794400305565; 
 Wed, 11 Nov 2026 04:31:45 -0800 (PST)
X-Received: by 2002:a05:6122:4317:b0:5ea:e196:272d with SMTP id
 71dfb90a1353d-5ee1c3db8d2mr575799e0c.6.1794400305032; 
 Wed, 11 Nov 2026 04:31:45 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c2793sm10687527f8f.45.2026.11.11.04.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 04:31:43 -0800 (PST)
Message-ID: <43373a9e-9ff3-4641-b961-b63f4de21cb9@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 13:31:39 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port optional
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
 <c8dea6ad-ce41-44d2-96ab-233b0a4b1340@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c8dea6ad-ce41-44d2-96ab-233b0a4b1340@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0OSBTYWx0ZWRfXxg+Wp0We+tDK
 5hajU4Jl6ket6myz3/qkeGeP5kqBEf8MHco4fJ5HEBqdm70rgVLQ0x7ixjqUH1FOil5aoAqc2OD
 T/oVI9b6SmnQ+zAIZCTnckuTkiyp5asMCL6Q+PpfcEypKasDIQsyYGO+CUd51sWWHTnxt+iiD4k
 GdnBKm/rIkLAvJA1PLJjYS2xxxvVXsX8FjMEYdEcnhGMHL8EPYrLUZyRfOX+lPF6EcrxujVLl45
 J1o2YsR8yg6V3Mq++9IdH53ZGtmy4eKmlCNdqNa48/EcnRVFWyPSPyF9dT+QbYaOXbV9s2hxLKK
 qfH5Ih9hTs0za24eiKGzVi6oPTtsgqXgskZqDehayHBkCrXIxS2usmIAMklWMW8O3d5MaG2PYhA
 eNhcPFAyXsX5WY+VsYuZhYVcizeHQv6OxFcqSP5xY/01KgS8HY50/eGJlG+l+0/8XIw0a7SVnL9
 5IqA7LRgVVmtx0fET4Q==
X-Proofpoint-GUID: D_P6J0iebkIUJ0n-1VvR323W4i3ihqaX
X-Proofpoint-ORIG-GUID: D_P6J0iebkIUJ0n-1VvR323W4i3ihqaX
X-Authority-Analysis: v=2.4 cv=NK1AaE6g c=1 sm=1 tr=0 ts=6af46032 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=P0j__KAnszyX0y2xDOYA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0OSBTYWx0ZWRfX4sNm81vm3U0T
 DI99//g9l6Fj6rMptlcPzDN8didIp49XjAN//bzmZ4lHDauVEGyywDhFMpq2sVsMchv0XxXUdGO
 WelKLJHmzMyV9xN4U0tlQq4fh0yEdFE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
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

On 11/11/2026 13:30, Krzysztof Kozlowski wrote:
> On 11/11/2026 12:13, Maxime Ripard wrote:
>> On Wed, Nov 11, 2026 at 12:03:39PM +0100, Krzysztof Kozlowski wrote:
>>> DSI panels can be placed under DSI bus directly and many Linux DRM
>>> drivers will work fine with it: mipi_dsi_host_register() adds device for
>>> such panel and DRM driver does not use OF graph to configure lanes.
>>
>> That's not true. We do use the endpoints to configure the lanes through
>> the data-lanes property. See drm_of_get_data_lanes*
> 
> Some drivers use endpoints, some not. As discussed on other thread,
> there are more than which do not.

"there are more than one which do not."

> 
>>
>>> The affected here Linux panel drivers do not use OF graph, either.
>>>
>>> Requiring graph port for such panels is tying the binding to one
>>> specific implementation of Linux DRM drivers, e.g. Qualcomm DRM which
>>> requires the port.  The port is not needed for the hardware to operate
>>> and for some of the Linux drivers, so it should be optional.
>>>
>>> Suggested-by: Romain TISSERAND <romain.tisserand@gmail.com>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>>
>> DSI busses can handle multiple devices, and multiple data types. If we
>> were to drop the port node, how does the upstream video device know
>> which device it should send its video output to?
>>
> 
> We do not drop the port node, who suggested that?
> 
> You do get, that we are not talking about the DSI host, but the panel?

Best regards,
Krzysztof
