Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6C3606A332
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OJwLpcqz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=krMyLrr+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3EA10FC60;
	Wed, 11 Nov 2026 18:06:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984BF10EA7E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:05:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHtH1T1952668
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5gealjh6ZNGo6eLjGBgtYQumk7p6vPIIjmFui9l+xfg=; b=OJwLpcqzCAs4cZ9R
 z79WRUa3kfaODLgha23FN8hrLdUhGKs74uKbdt+Yf4oI6veasW64FLMOCaf6OAGk
 mFD6WbWeItjFQqohIZRDhLa/oD1OJ01Vp+BQZhIJvAJBcY96SJ8tVICiiVsbF1qP
 2QCBcEpHn9TtvGFPszk4VAPyBbrw5FQsLLF6++mJ9pfOUhwaZrXCQ8dfcoiFHKMa
 Li1a/UZjBq58QfHz7MzQg5nOZRS8xt0uJNha7EGAQkdau2p3fWrWHyoys+6z5lQc
 3hWEcFu4wnISOXhzfeqWm7eBMhW/FIRcVup46XwiRSjbNG6JPpUduS9BM2AEeHho
 ED0h9w==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvs4m1aau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 18:05:55 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5eaad8219b0so1103421e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794420355; x=1795025155;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5gealjh6ZNGo6eLjGBgtYQumk7p6vPIIjmFui9l+xfg=;
 b=krMyLrr+7Bs/0XLqbfVvrF8zA96pY2nnWym53MHqcD/XXUpg2LpT9H1QSHNZo/WvwX
 r+x/nL3VlpHrs3XT/Txw9z26t7rLyGxqFOIGcc/X5wP+y95CwLpYK5eCeNN+6QrS1TkZ
 vokpbstPOhTrOgcH80XHAu5hx7Nd7RQ1JO94vm5zS5Eifqf/3JXCl+ipLaFmCK/KoPOJ
 NzK26C8Fsn2GR/m59CSZ/4OaSjTkYIhTqxV0+jBC0MTxqy6yE+7hhmLdbok9o51LIY51
 1btvLQ19PsURx0t4oGKmia2ManQcnwyUzu7Nspvy6IznmCoSmJ6JZsgZNROfgMxFZR8f
 gNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794420355; x=1795025155;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5gealjh6ZNGo6eLjGBgtYQumk7p6vPIIjmFui9l+xfg=;
 b=L7wFFd145pndsd2C07U1PQmoPg8PbykbqUNqCSFWQ3R7nj/XU0SeAjHUUmloMVV3xF
 f0DYvLtlkh/gLrrW9Zsbddz/V9tmWanXGXGi/rnsIpnwEbvqkpmmwRm2iF0pMmpBrv5J
 dEFlAKzeobv1wTZ7zLldP8xVaTe4N7sQI/LtRMtLnkK0MxgkmGLnHam7CiMzlTZq4SWf
 mxcu+Z+7K12M6spJIZgNdNcE5PEot6SSsjAgx0A763mQ1J3kNjM94Ic39bwDAE0gzKV8
 oyZle7WJgo1l45nDrATSpSsa3M7eAaWZrfMxJr/nrorFiMAFC9lF5WFIwCkhLCgS0FRY
 cXqA==
X-Forwarded-Encrypted: i=1;
 AL+hErHDn71VdacWyV3aB46v+2SJaJWo2hdLY5qiM+EvttTlkUEpobDSLBi2LitCCEWf29QiaS74gW75A94=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8e5GmWHeavGIIbHakqyDMNSteBEODQgb59+zH/9xEADch3s38k
 XBy+Lb9fvP6YwCeqUAZuwDZAfyhP0UiJIejmRCSgMnT0+HxxiyJEjIPc0luYM7k68hwhMHtiH9s
 q2X0yyY9j30NMIkm6ytfi5qSwXZzsanwXkcWKjf5Ko5wZSVojpPkRLbDJmSjPlAMln5CX2C0=
X-Gm-Gg: AYBFou2EEPEy4f2PGBw8TSLP2F5F9570LNXJHHtYRkwy4FEN/Uh+QaT0KMwWy8sk1fG
 0Mlyclf6vhPnipT1shhsDGwYK1Jyks0x5LOQTbvJQCStN9T6EJBZv9uR/GN9viYplDQdSxKqPO1
 +nGYYICdnMNyeI0IepgYQKLBmTxIrfG56sYt4Dt7BbMXBeTWKF23elxZBIweyAx848xV/4BIXc/
 Bot3SfWTs/ENWApBAyCVDIqe5KmjjZNstkjf65UsNQyZxqZ8/ksb1pedTYVJP6rfhIRlbyg3A+o
 27kDrDVc98FY2LfxobHjOQwi28FMiRDWJSrkgCi4QGVYME2U7R9dKmt4I1ki7AKZ9h4+04eLp6/
 oj6oc8vz+zYMOBQWu5Kf3twozPUMann2JoxsX6xhG3hxTXkzdTljg1E5SZhCgd4VWJ6UjaECOy8
 8=
X-Received: by 2002:a05:6122:8f89:b0:5c9:a60d:327a with SMTP id
 71dfb90a1353d-5ee1c443198mr1237738e0c.14.1794420354477; 
 Wed, 11 Nov 2026 10:05:54 -0800 (PST)
X-Received: by 2002:a05:6122:8f89:b0:5c9:a60d:327a with SMTP id
 71dfb90a1353d-5ee1c443198mr1237606e0c.14.1794420353724; 
 Wed, 11 Nov 2026 10:05:53 -0800 (PST)
Received: from [192.168.1.110] ([178.197.218.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49944d646f9sm8588796f8f.32.2026.11.11.10.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 10:05:52 -0800 (PST)
Message-ID: <72bc9dbf-a4d3-45e8-8647-a8c4a41045d1@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 19:05:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port optional
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maxime Ripard <mripard@kernel.org>,
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
 <8a557bae-42ae-42bd-a149-cf854b7af9d5@oss.qualcomm.com>
 <dki5db5xizrwwijmjbnbx7irg6if24l7punctr2wx35j4toi5c@4rip7azwzt2k>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <dki5db5xizrwwijmjbnbx7irg6if24l7punctr2wx35j4toi5c@4rip7azwzt2k>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1gOefh5QtpEMmqJ32ZRelkRQu6b-87wW
X-Authority-Analysis: v=2.4 cv=OYANnRTY c=1 sm=1 tr=0 ts=6af4ae83 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=fswbabxtGTeL9KkrVe0A:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: 1gOefh5QtpEMmqJ32ZRelkRQu6b-87wW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX7SYPU1o2yv+2
 HozJfiYBOMwR31gPEsTQK5NuXoFKhw9Uq83zWh/7N0DI01m/LC3rsDd1gjKHHmWWQvDO+g5yDP1
 MXXhLtzEvTiJAJOam0h1L27HCmR+3t7n+O5M4HZY7L6M221EehVFZ5ze9rzIwn0MJRtvKugP5Xy
 ONbAsSybz9DLeNlNGj5ThIhW7gfLu5bM48txK4fcA/H1Jat8ATUlppjS3cSXRepB5t23ymSUBZE
 IBIilO6XYlIHcV2DoIoHexYs/GSY0w14K27C2ibY4PAw+bjweFRTdJ3aP/bSg37/lWbAz2tZfVm
 hvUMounQFAVadtk3T1+gRUFvm7QTKgddml+wAZWCFU6AtYgyovLNXWUXqbjd4oeoCWTtLcOCRO+
 kb9QKFfNylMuvqIJqva3uuvEBjxmPNty1UgMT1e2C2Y0xfcMfJ/1ia3SfR9hP5oVxfFRKZwBBMo
 YkL7O1i9h9dGxKMW1Gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MiBTYWx0ZWRfX/KH2oYn35v1X
 WSq36qXaskFn49S05om4GsMHPkoouWpV/84P7gJ9yHNg+xksocP4cMygm89GBvFCO8pRqSNDlYG
 CKQlXi0FjbLLowbD66rjmwvUHqdokmE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110072
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

On 11/11/2026 18:55, Dmitry Baryshkov wrote:
> On Wed, Nov 11, 2026 at 02:54:54PM +0100, Krzysztof Kozlowski wrote:
>>
>> Commit msg said:
>> "many Linux DRM drivers will work fine with it"
>>
>> So many->some? Is this the only problem? What else is not described in
>> commit msg?
> 
> The commit message points out that a minority of drivers use and require
> the port, while majority of the drivers don't. I think up to now only

Ack

> the Exynos and sunXi were mentioned. From my point of view, it would be
> better to change corresponding DSI host bindings to allow port bindings
> and then define the OF graph connecting DSI host to DSI panel (which
> might be done gradually, etc.) even if the OF graph is not used nowadays
> by those drivers instead of providing a false signal that it's okay to
> have DSI links without OF graph connection. It's not future-proof and
> not okay, especially for the new designs.

Around 33% of DSI panels bindings do not require port, so to fulfill
above their bindings should be changed and ABI broken by requiring now a
panel.

Even though neither the panel hardware nor the panel driver needs the port.

The requirement of the port is on DSI host drivers, thus it should be
required there, just like I did for MSM bindings today.

Best regards,
Krzysztof
