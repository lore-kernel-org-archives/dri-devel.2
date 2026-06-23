Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0A3CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 05:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2BB810E95E;
	Tue, 23 Jun 2026 05:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NW/6UN83";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="COu1gwKD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46C4D10E95D
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 05:49:09 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N1Y31D2672603
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 05:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JVEyJPEKd+xfdNe50U6LLMuP6LB9ZfnvXc7jr9pkP9A=; b=NW/6UN83Tvl+J1G1
 wBqIrsaxZBw2QnMk/w0AQtf7JGebl5I2vK+13758BaSy4ut22nT88OMLE4LhcDn8
 cLoOAOoZ+VJ2lpvjOfvD1A7fl1Oz1K7cLswhW9EJfxUFEkIxQ6vjIKVo+T3LZPgA
 qL64+vGQ9oQKdgafRY2OBgAGnFOsrUqD3MpXjvAAozxCHh3IgUizf247ya5hAHBz
 +CU95Q2NzQSCCjyKevqFNcs12oz3xwUjv9wjLDiT538JoE6hHFGazy5pzF5DNFtf
 OwbqU/a5lzaASFBCGx5SvLm+FY901G9/gbjmwtw7v/9Izpiu/1XD2gJN3CxKIeoi
 5mGu0Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eygkjgr68-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 05:49:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-921ed86ddeaso573578885a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782193747; x=1782798547;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVEyJPEKd+xfdNe50U6LLMuP6LB9ZfnvXc7jr9pkP9A=;
 b=COu1gwKDHUKeSaaEMKLutPitIGYdfa1mqe3oS9RAYJhHQcufolo2ze6J2ai0NysVWI
 K77fa2bMBMMuWHvjcrjRB1RhC1/zh9ILEadicGRI5txE5zxTk6tXCNXTlPoyasCXBwxC
 vbAGW12LeR07CAP7ZQKsKjeWQ5yamB8Yh0NhUMuPl/QTi2NhYFSdjgRFbUKfvOc7O4fQ
 lzu0BIFhf1T0vLPA+OpsaS98HNfIfoRX1Irhp8WKmzWxkDvKoCoC2vAbqUkl3EVL/y7p
 ll87Vhr0ugzP4mpf15ra0zX69DlzSlaQOU5IltObiKEIxyNU3Y8tHjWm6s56WE6RouW1
 t4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782193747; x=1782798547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JVEyJPEKd+xfdNe50U6LLMuP6LB9ZfnvXc7jr9pkP9A=;
 b=DlFRUq1hPkZuzOfAYOOhiBuJ7WphCZEPbhdttgc0g3GbPQUzKl34va360cfCeKIzIz
 Y+pXGfqv9+i7tNWzy7YIeWnsoigQVPpefNH6L8Dw8kzI7JOhgdhyVSzlHwW2ofr73ofA
 SnPcJWbtQtBJn+8IPXeH9sH5x/8T9/WYFHx5MQBVyhmIZ8oxPb4hoy39uFc5v8AwnMV0
 MS/DFycr59iS8XAvVRQRW30vDrIvgb1w6ZZGUN6k1iHlrpUta0LRzZZoM8+F8PUF8JcV
 rospRozbWbIOWsbl3iu1FCz1D6xqjDOHALf5VpeBlIsY4nhjtaItT7+qgmFJT1fyBXe7
 j3nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Er13Ca9BdhpWGHBJQF2jkOgl9wzVyg1yyORprcKzPPdy6armnYE7d2qnXZnOEeqeugNVX2Haf72g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3eZ4F4OePwciLpvdbo58WiRaCsxfZRR9LKzaQ4FxqzZGOArFw
 IfV/ShqdTWiu7ImzMWErr112UtYRzGo73OjFgBDLX1RhTMWxcZczTdM+JfvUM0nK/HpOauV4ojj
 JQJLgkI/x0fowCm90CGJxDl6L7BSFvFfgETt68hSEOd18Jq+DSLtP+ctbl+vew4Y4mVSSYZ4=
X-Gm-Gg: AfdE7cn2C+SYRJMRgWHfvFCHVilyyXYnQuJPNGaEVKDjm0u9HyoOhdwm94dZ4e10zeB
 bKD7ExyShJNTGcutRHslaIXY0RRfk8N78wiL/Iea8LUnb9XKj1Hu8FcfEDH5odTe/353zaoag0F
 eOMw5iXr+jY9ZV3IWyCC3e1jjn1XSmpKfr7E8L06aLFL5cId6c8S6D1KVT5ohUdQlIU7gs0OMKf
 aJpLnS8mJevpTrg2CaRlOYkFrp5aSm49YGf1Jcqp/E+9oJNptYwmix4YYZZL2D/GneBS2nVs+yC
 ahhlDfCz4FX9i4UYS6I9Sqklv9atZWlBFxPSVldXilVDqDx5F4W1Du4U3iThPmgyiVklL7aBhOk
 XeCahjyTF4KtGzCMWetozeKFEU2U=
X-Received: by 2002:a05:620a:280e:b0:912:67ca:bac6 with SMTP id
 af79cd13be357-920913955d3mr2773589285a.26.1782193746491; 
 Mon, 22 Jun 2026 22:49:06 -0700 (PDT)
X-Received: by 2002:a05:620a:280e:b0:912:67ca:bac6 with SMTP id
 af79cd13be357-920913955d3mr2773574485a.26.1782193745589; 
 Mon, 22 Jun 2026 22:49:05 -0700 (PDT)
Received: from quoll ([178.197.218.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c579dfsm32588915f8f.31.2026.06.22.22.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 22:49:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Andi Shyti <andi.shyti@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulfh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Linus Walleij <linusw@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Sebastian Reichel <sre@kernel.org>,
 Javier Martinez Canillas <javier@dowhile0.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Marek <jonathan@marek.ca>, Taniya Das <quic_tdas@quicinc.com>,
 Robert Marko <robimarko@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>,
 Adam Skladowski <a_skl39@protonmail.com>,
 Sireesh Kodali <sireeshkodali@protonmail.com>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Anusha Rao <quic_anusha@quicinc.com>, Luo Jie <quic_luoj@quicinc.com>,
 Tomasz Figa <tomasz.figa@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sunyeal Hong <sunyeal.hong@samsung.com>, Shin Son <shin.son@samsung.com>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Alina Yu <alina_yu@richtek.com>, Andy Gross <agross@kernel.org>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Wesley Cheng <quic_wcheng@quicinc.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 2/2] dt-bindings: Drop incorrect usage of double '::'
Date: Tue, 23 Jun 2026 07:48:44 +0200
Message-ID: <20260623054842.21831-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623054842.21831-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260623054842.21831-3-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=33237;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=Vm8XlvRcgjz05PgRySDfUm9lFHZJO0uf5woeuXrLjew=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqOh49aaqvvngOytwYPZzhxV/1ufNdUXOttsyDE
 5804fChdCOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCajoePQAKCRDBN2bmhouD
 18jBD/4zpqbuSHP4s2gxPkGzF2gZz2Lchj7RYYdj5pxfIvq+kQFxdrbGqrNCfAqHv6Ag82YVXn2
 Y/eFoDBuVm2his4m8Do6l7nz76GHsjIBcOTRdsn/BrVSyhLIGcbE80WMrd8D1Q4adN1MKlR1w4N
 f28ec2j+9Fk/oOmPD8rUl8Ua7iFiP7Jxo3Q07lojYAxY8xC1aCebQiF02ZNMgiPPSmLS2PGbGyB
 Tar/wJnPf22oq9/oFtufV2L/ZzPHH1jLabPKvNSo5VPBCla9N6F+5r2WEwiWflPhRwqqGB/BU9h
 hV3G6zVbx1d4En0+LqR6QvmBgj0Pdw/WmE+M1H+nhM/Hozio9T1rWtIb2iqu62WcHGqec/Fquz7
 i6T9/blBduDbqEUmEnxbTjdFnO5qxFTnLbA8qMF0XE+QXCyeVgt+wNHQ16k1430fkwuIeE2J5+0
 FPra3iD6un08lPHN7RpCDZ9fWqtT29isMSOzgjQxriZQY8pYVu9pm3ML2lFYGeBguhggUzN/Wf3
 0/BJrtkiq0figWjbR2MTWzR1uzbGChsp1KM33H2ef817ItbZ/4zo7VsvlVoVmySnqlBegn2Kjsb
 uzrBvkIwZfSFF2ZkalNG5bC5XsZrcuH4gA6PvmFmfdJxSLv/olCpdn9UGM/TN0nSNM/qqR6Nik6
 PB9Ws1RJI41BCSA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0NCBTYWx0ZWRfX+PYUSk8KxIhw
 qc7mrgbIipsbEupfMzwNF5FYt99cTwZxWlsFpLqjGrlepHF5mZ6UH7SQsURGDQZjF3nIND/vYaP
 Ld/5aNmLOY7Gszr5elSHfZNfZazk+U4CFvrfWisrlb6xIEilsk1cB/mvhGRsOhqjyY7JF+xzuO0
 tBKWCoiTiRJiw5C6nyPQLTroTMBlqACdfjnIyu4RAh73XwsOnM1E58CrLr03bNK4TwJJj2Ods05
 NWMNQyL7fQ/HvovFkrWj3ncfdn3mqKx8iZlI4X4wdggVaUIO6BLMuCZmNXqWf/fSPu3FLWZz62j
 AtdRbkFEmvxGbcQ3jYIS3zSgfuA+HI/SazwOpK2kmzn90PFiX9LK8G+WQtlfTy6LBU5aCzae5no
 h5dE5oP832afBlLB0N9+sFmg44M7ZGVhEz0v5qqjiSXwlA1Hg+TAEMV0bpXyI2ypGEIlao8JW47
 D6N+yRu6+j6gmL0QCHw==
X-Proofpoint-GUID: -h7hQv1SGJP--Bq3uORVjIXyoinB2rUA
X-Authority-Analysis: v=2.4 cv=SoKgLvO0 c=1 sm=1 tr=0 ts=6a3a1e54 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=qMZSjPy+XpteAuilWfML4g==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=fqWYVyBuAAAA:8 a=XYAwZIGsAAAA:8 a=hD80L64hAAAA:8 a=QX4gbG5DAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WAwA4AJQovmkF_08t20A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=3EkFFxAVN7Xjp7FSp-fE:22
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0NCBTYWx0ZWRfX/9GHwXIp1i/w
 NV2c36HHzfTL9MfAj0Nos1/xgxZUwh+EsXoWUIcY0qkEkmErM3IJmQJ5aoXDB+/LPPZU96cN8uw
 kMmD6TC3y73dJ/oHJTGKq0h74X41ZP0=
X-Proofpoint-ORIG-GUID: -h7hQv1SGJP--Bq3uORVjIXyoinB2rUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230044
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

There is no use of double colon '::' in YAML. OTOH, the literal style
block, e.g. using '|' treats all characters as content [1] therefore
single use of ':' in descriptions is perfectly fine, whenever '|' is
used.

Cleanup existing code, so the confusing style won't be re-used in new
contributions.

Link: https://yaml.org/spec/1.2.2/#literal-style [1]
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Intention for this patch is to go via Rob's tree.

Changes in v2:
1. Add tags (partial Reviews as Acks, as that's the meaning of Ack)
2. Do not replace ::= in mux.
---
 .../devicetree/bindings/arm/qcom-soc.yaml     |  4 ++--
 .../devicetree/bindings/arm/qcom.yaml         |  4 ++--
 .../bindings/arm/samsung/samsung-soc.yaml     |  4 ++--
 .../display/msm/dsi-controller-main.yaml      | 20 +++++++++----------
 .../display/samsung/samsung,fimd.yaml         |  4 ++--
 .../bindings/i2c/samsung,s3c2410-i2c.yaml     |  2 +-
 .../interconnect/qcom,msm8998-bwmon.yaml      |  2 +-
 .../interconnect/samsung,exynos-bus.yaml      | 14 ++++++-------
 .../bindings/leds/qcom,pm8058-led.yaml        |  4 ++--
 .../bindings/leds/skyworks,aat1290.yaml       |  6 +++---
 .../bindings/media/cec/cec-gpio.yaml          |  2 +-
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |  2 +-
 .../bindings/phy/samsung,mipi-video-phy.yaml  |  4 ++--
 .../bindings/phy/samsung,usb2-phy.yaml        |  2 +-
 .../bindings/phy/samsung,usb3-drd-phy.yaml    |  2 +-
 .../bindings/pinctrl/samsung,pinctrl.yaml     |  2 +-
 .../bindings/power/renesas,rcar-sysc.yaml     |  2 +-
 .../bindings/power/reset/restart-handler.yaml |  8 ++++----
 .../bindings/regulator/maxim,max77802.yaml    |  4 ++--
 .../bindings/regulator/richtek,rtq2208.yaml   |  2 +-
 .../bindings/serial/qcom,msm-uartdm.yaml      |  2 +-
 .../devicetree/bindings/slimbus/slimbus.yaml  |  4 ++--
 .../bindings/soc/qcom/qcom,apr-services.yaml  |  2 +-
 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml      |  8 ++++----
 .../bindings/soc/qcom/qcom,wcnss.yaml         |  2 +-
 .../bindings/soc/renesas/renesas-soc.yaml     |  4 ++--
 .../bindings/sound/qcom,q6asm-dais.yaml       |  2 +-
 .../thermal/samsung,exynos-thermal.yaml       |  4 ++--
 .../devicetree/bindings/usb/qcom,dwc3.yaml    | 12 +++++------
 .../bindings/usb/qcom,snps-dwc3.yaml          | 12 +++++------
 30 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index 27261039d56f..37fdd5a080b7 100644
--- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -11,10 +11,10 @@ maintainers:
 
 description: |
   Guidelines for new compatibles for SoC blocks/components.
-  When adding new compatibles in new bindings, use the format::
+  When adding new compatibles in new bindings, use the format:
     qcom,SoC-IP
 
-  For example::
+  For example:
    qcom,sdm845-llcc-bwmon
 
   When adding new compatibles to existing bindings, use the format in the
diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 50cc18a6ec5e..667607ae2c32 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1215,7 +1215,7 @@ properties:
     items:
       items:
         - description: |
-            MSM chipset ID - an exact match value consisting of two bitfields::
+            MSM chipset ID - an exact match value consisting of two bitfields:
              - bits 0-15  - The unique MSM chipset ID
              - bits 16-31 - Reserved; should be 0
         - description: |
@@ -1241,7 +1241,7 @@ properties:
       - items:
           - items:
               - description: |
-                  Board ID consisting of three bitfields::
+                  Board ID consisting of three bitfields:
                     - bits 31-24 - Unused
                     - bits 23-16 - Platform Version Major
                     - bits 15-8  - Platform Version Minor
diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
index 653f85997643..ab000befe76d 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
@@ -11,10 +11,10 @@ maintainers:
 
 description: |
   Guidelines for new compatibles for SoC blocks/components.
-  When adding new compatibles in new bindings, use the format::
+  When adding new compatibles in new bindings, use the format:
     samsung,SoC-IP
 
-  For example::
+  For example:
     samsung,exynos5433-cmu-isp
 
 select:
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index dbc0613e427e..395425a70db8 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -73,16 +73,16 @@ properties:
 
   clocks:
     description: |
-      Several clocks are used, depending on the variant. Typical ones are::
-       - bus:: Display AHB clock.
-       - byte:: Display byte clock.
-       - byte_intf:: Display byte interface clock.
-       - core:: Display core clock.
-       - core_mss:: Core MultiMedia SubSystem clock.
-       - iface:: Display AXI clock.
-       - mdp_core:: MDP Core clock.
-       - mnoc:: MNOC clock
-       - pixel:: Display pixel clock.
+      Several clocks are used, depending on the variant. Typical ones are:
+       - bus: Display AHB clock.
+       - byte: Display byte clock.
+       - byte_intf: Display byte interface clock.
+       - core: Display core clock.
+       - core_mss: Core MultiMedia SubSystem clock.
+       - iface: Display AXI clock.
+       - mdp_core: MDP Core clock.
+       - mnoc: MNOC clock
+       - pixel: Display pixel clock.
     minItems: 3
     maxItems: 12
 
diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
index ff685031bb2c..729705f419bb 100644
--- a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
@@ -41,7 +41,7 @@ properties:
     additionalProperties: false
     description: |
       Timing configuration for lcd i80 interface support.
-      The parameters are defined as::
+      The parameters are defined as:
       VCLK(internal)  __|??????|_____|??????|_____|??????|_____|??????|_____|??
                         :            :            :            :            :
       Address Output  --:<XXXXXXXXXXX:XXXXXXXXXXXX:XXXXXXXXXXXX:XXXXXXXXXXXX:XX
@@ -132,7 +132,7 @@ patternProperties:
   "^port@[0-4]+$":
     $ref: /schemas/graph.yaml#/properties/port
     description: |
-      Contains ports with port with index::
+      Contains ports with port with index:
        0 - for CAMIF0 input,
        1 - for CAMIF1 input,
        2 - for CAMIF2 input,
diff --git a/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml b/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
index a2ddc6803617..07600b49f2f9 100644
--- a/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
@@ -35,7 +35,7 @@ properties:
 
   gpios:
     description: |
-      The order of the GPIOs should be the following:: <SDA, SCL>.  The GPIO
+      The order of the GPIOs should be the following: <SDA, SCL>.  The GPIO
       specifier depends on the gpio controller. Required in all cases except
       for "samsung,s3c2440-hdmiphy-i2c" whose input/output lines are
       permanently wired to the respective client.
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index ff64225e8281..e002e70580f9 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -13,7 +13,7 @@ description: |
   Bandwidth Monitor measures current throughput on buses between various NoC
   fabrics and provides information when it crosses configured thresholds.
 
-  Certain SoCs might have more than one Bandwidth Monitors, for example on SDM845::
+  Certain SoCs might have more than one Bandwidth Monitors, for example on SDM845:
    - Measuring the bandwidth between CPUs and Last Level Cache Controller -
      called just BWMON,
    - Measuring the bandwidth between Last Level Cache Controller and memory
diff --git a/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml b/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
index 5e26e48c7217..0203959c8995 100644
--- a/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
+++ b/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
@@ -23,7 +23,7 @@ description: |
   The each AXI bus has the owned source clock but, has not the only owned power
   line. The power line might be shared among one more sub-blocks.  So, we can
   divide into two type of device as the role of each sub-block.  There are two
-  type of bus devices as following::
+  type of bus devices as following:
    - parent bus device
    - passive bus device
 
@@ -44,8 +44,8 @@ description: |
   able to support the bus frequency for all Exynos SoCs.
 
   Detailed correlation between sub-blocks and power line according
-  to Exynos SoC::
-   - In case of Exynos3250, there are two power line as following::
+  to Exynos SoC:
+   - In case of Exynos3250, there are two power line as following:
      VDD_MIF |--- DMC (Dynamic Memory Controller)
 
      VDD_INT |--- LEFTBUS (parent device)
@@ -89,7 +89,7 @@ description: |
        |L5   |200000 |200000  |400000 |300000 |       ||1000000 |
        ----------------------------------------------------------
 
-   - In case of Exynos4210, there is one power line as following::
+   - In case of Exynos4210, there is one power line as following:
      VDD_INT |--- DMC (parent device, Dynamic Memory Controller)
        |--- LEFTBUS
        |--- PERIL
@@ -106,7 +106,7 @@ description: |
        |--- LCD0
        |--- LCD1
 
-   - In case of Exynos4x12, there are two power line as following::
+   - In case of Exynos4x12, there are two power line as following:
      VDD_MIF |--- DMC (Dynamic Memory Controller)
 
      VDD_INT |--- LEFTBUS (parent device)
@@ -124,7 +124,7 @@ description: |
        |--- LCD0
        |--- ISP
 
-   - In case of Exynos5422, there are two power line as following::
+   - In case of Exynos5422, there are two power line as following:
      VDD_MIF |--- DREX 0 (parent device, DRAM EXpress controller)
              |--- DREX 1
 
@@ -143,7 +143,7 @@ description: |
        |--- FSYS
        |--- FSYS2
 
-   - In case of Exynos5433, there is VDD_INT power line as following::
+   - In case of Exynos5433, there is VDD_INT power line as following:
      VDD_INT |--- G2D (parent device)
        |--- MSCL
        |--- GSCL
diff --git a/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml b/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
index b409b2a8b5c5..5165bfddcd54 100644
--- a/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
+++ b/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
@@ -10,10 +10,10 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: |
-  The Qualcomm PM8058 contains an LED block for up to six LEDs:: three normal
+  The Qualcomm PM8058 contains an LED block for up to six LEDs: three normal
   LEDs, two "flash" LEDs and one "keypad backlight" LED. The names are quoted
   because sometimes these LED drivers are used for wildly different things than
-  flash or keypad backlight:: their names are more of a suggestion than a
+  flash or keypad backlight: their names are more of a suggestion than a
   hard-wired usecase.
 
   Hardware-wise the different LEDs support slightly different output currents.
diff --git a/Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml b/Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml
index a6aaa92dbccd..65576dfdca11 100644
--- a/Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml
+++ b/Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: |
-  The device is controlled through two pins:: FL_EN and EN_SET. The pins when,
+  The device is controlled through two pins: FL_EN and EN_SET. The pins when,
   asserted high, enable flash strobe and movie mode (max 1/2 of flash current)
   respectively. In order to add a capability of selecting the strobe signal
   source (e.g. CPU or camera sensor) there is an additional switch required,
@@ -39,11 +39,11 @@ properties:
       flash-max-microamp:
         description: |
           Maximum flash LED supply current can be calculated using following
-          formula:: I = 1A * 162 kOhm / Rset.
+          formula: I = 1A * 162 kOhm / Rset.
 
       flash-max-timeout-us:
         description: |
-          Maximum flash timeout can be calculated using following formula::
+          Maximum flash timeout can be calculated using following formula:
             T = 8.82 * 10^9 * Ct.
 
     required:
diff --git a/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml b/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
index 582c6c9cae48..21118e4bae0f 100644
--- a/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
+++ b/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
@@ -14,7 +14,7 @@ description: |
   hooked up to a pull-up GPIO line and - optionally - the HPD line is hooked up
   to another GPIO line.
 
-  Please note:: the maximum voltage for the CEC line is 3.63V, for the HPD and
+  Please note: the maximum voltage for the CEC line is 3.63V, for the HPD and
   5V lines it is 5.3V. So you may need some sort of level conversion
   circuitry when connecting them to a GPIO line.
 
diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index 27c4060f2f91..223fcc9f651f 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -85,7 +85,7 @@ properties:
     description: |
       The value of CIU TX and RX clock phase shift value for HS400 mode
       operation.
-      Valid values for SDR and DDR CIU clock timing::
+      Valid values for SDR and DDR CIU clock timing:
         - valid value for tx phase shift and rx phase shift is 0 to 7.
         - when CIU clock divider value is set to 3, all possible 8 phase shift
           values can be used.
diff --git a/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
index 16967ef8e9ec..87b6a35b2626 100644
--- a/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
@@ -13,14 +13,14 @@ maintainers:
 
 description: |
   For samsung,s5pv210-mipi-video-phy compatible PHYs the second cell in the
-  PHY specifier identifies the PHY and its meaning is as follows::
+  PHY specifier identifies the PHY and its meaning is as follows:
     0 - MIPI CSIS 0,
     1 - MIPI DSIM 0,
     2 - MIPI CSIS 1,
     3 - MIPI DSIM 1.
 
   samsung,exynos5420-mipi-video-phy and samsung,exynos5433-mipi-video-phy
-  support additional fifth PHY::
+  support additional fifth PHY:
     4 - MIPI CSIS 2.
 
 properties:
diff --git a/Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml
index d9f22a801cbf..7db7605a82e2 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml
@@ -14,7 +14,7 @@ maintainers:
 description: |
   The first phandle argument in the PHY specifier identifies the PHY, its
   meaning is compatible dependent. For the currently supported SoCs (Exynos4210
-  and Exynos4212) it is as follows::
+  and Exynos4212) it is as follows:
     0 - USB device ("device"),
     1 - USB host ("host"),
     2 - HSIC0 ("hsic0"),
diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 4562e0468f4f..a1b3d9e6a094 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -14,7 +14,7 @@ maintainers:
 description: |
   For samsung,exynos5250-usbdrd-phy and samsung,exynos5420-usbdrd-phy
   compatible PHYs, the second cell in the PHY specifier identifies the
-  PHY id, which is interpreted as follows::
+  PHY id, which is interpreted as follows:
     0 - UTMI+ type phy,
     1 - PIPE3 type phy.
 
diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index 7b006009ca0e..5e35686eeed3 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
@@ -18,7 +18,7 @@ description: |
   All the pin controller nodes should be represented in the aliases node using
   the following format 'pinctrl{n}' where n is a unique number for the alias.
 
-  The controller supports three types of interrupts::
+  The controller supports three types of interrupts:
    - External GPIO interrupts (see interrupts property in pin controller node);
 
    - External wake-up interrupts - multiplexed (capable of waking up the system
diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
index 347571e2545a..b67aa170b2c1 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
@@ -13,7 +13,7 @@ maintainers:
 description: |
   The R-Car (RZ/G) System Controller provides power management for the CPU
   cores and various coprocessors.
-  The power domain IDs for consumers are defined in header files::
+  The power domain IDs for consumers are defined in header files:
   include/dt-bindings/power/r8*-sysc.h
 
 properties:
diff --git a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
index 965a834a3dbe..00c00ec5ec81 100644
--- a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
+++ b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
@@ -18,12 +18,12 @@ properties:
   priority:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
-      A priority ranging from 0 to 255 according to the following guidelines::
-        0::   Restart handler of last resort, with limited restart capabilities.
-        128:: Typical, default restart handler; use if no other restart handler
+      A priority ranging from 0 to 255 according to the following guidelines:
+        0:   Restart handler of last resort, with limited restart capabilities.
+        128: Typical, default restart handler; use if no other restart handler
               is expected to be available, and/or if restart functionality is
               sufficient to restart the entire system.
-        255:: Highest priority restart handler, will preempt all other restart handlers.
+        255: Highest priority restart handler, will preempt all other restart handlers.
     minimum: 0
     maximum: 255
 
diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
index b704f05ea454..b886495c1396 100644
--- a/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
+++ b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
@@ -22,13 +22,13 @@ description: |
 
   Certain regulators support "regulator-initial-mode" and "regulator-mode".
   The valid modes list is defined in the dt-bindings/regulator/maxim,max77802.h
-  and their meaning is::
+  and their meaning is:
     1 - Normal regulator voltage output mode.
     3 - Low Power which reduces the quiescent current down to only 1uA
 
   The standard "regulator-mode" property can only be used for regulators that
   support changing their mode to Low Power Mode during suspend. These
-  regulators are:: bucks 2-4 and LDOs 1-35. Also, it only takes effect if the
+  regulators are: bucks 2-4 and LDOs 1-35. Also, it only takes effect if the
   regulator has been enabled for the given suspend state using
   "regulator-on-in-suspend" and has not been disabled for that state using
   "regulator-off-in-suspend".
diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
index 022c1f197364..b0aa38edf8c2 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
@@ -21,7 +21,7 @@ description: |
   conduction mode (FCCM).
 
   The definition of modes is in the datasheet which is available in below link
-  and their meaning is::
+  and their meaning is:
     0 - Auto mode for power saving, which reducing the switching frequency at light load condition
     to maintain high frequency.
     1 - FCCM to meet the strict voltage regulation accuracy, which keeping constant switching frequency.
diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
index 788ef5c1c446..bc967ead2350 100644
--- a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
+++ b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
@@ -17,7 +17,7 @@ description: |
   software perspective it's mostly compatible with the MSM serial UART except
   that it supports reading and writing multiple characters at a time.
 
-  Note:: Aliases may be defined to ensure the correct ordering of the UARTs.
+  Note: Aliases may be defined to ensure the correct ordering of the UARTs.
   The alias serialN will result in the UART being assigned port N.  If any
   serialN alias exists, then an alias must exist for each enabled UART.  The
   serialN aliases should be in a .dts file instead of in a .dtsi file.
diff --git a/Documentation/devicetree/bindings/slimbus/slimbus.yaml b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
index 5a941610ce4e..3910327c8ded 100644
--- a/Documentation/devicetree/bindings/slimbus/slimbus.yaml
+++ b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
@@ -29,7 +29,7 @@ patternProperties:
     description: |
       Every SLIMbus controller node can contain zero or more child nodes
       representing slave devices on the bus. Every SLIMbus slave device is
-      uniquely determined by the enumeration address containing 4 fields::
+      uniquely determined by the enumeration address containing 4 fields:
       Manufacturer ID, Product code, Device index, and Instance value for the
       device.
 
@@ -48,7 +48,7 @@ patternProperties:
       reg:
         maxItems: 1
         description: |
-          Pair of (device index, instande ID), where::
+          Pair of (device index, instande ID), where:
            - Device index, which uniquely identifies multiple devices within a
              single component.
            - Instance ID, can be used for the cases where multiple devices of
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
index bdf482db32aa..b663be3ea5a1 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
@@ -40,7 +40,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/string-array
     description: |
       Protection domain service name and path for APR service (if supported).
-      Possible values are::
+      Possible values are:
       "avs/audio", "msm/adsp/audio_pd".
       "kernel/elf_loader", "msm/modem/wlan_pd".
       "tms/servreg", "msm/adsp/audio_pd".
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
index 26d9bc773ec5..1889139a3f7a 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
@@ -23,7 +23,7 @@ description: |
   with a few variations that are captured by the properties here.
 
   A TCS may be triggered from Linux or triggered by the F/W after all the CPUs
-  have powered off to facilitate idle power saving. TCS could be classified as::
+  have powered off to facilitate idle power saving. TCS could be classified as:
     ACTIVE  - Triggered by Linux
     SLEEP   - Triggered by F/W
     WAKE    - Triggered by F/W
@@ -76,7 +76,7 @@ properties:
     items:
       items:
         - description: |
-            TCS type::
+            TCS type:
              - ACTIVE_TCS
              - SLEEP_TCS
              - WAKE_TCS
@@ -152,7 +152,7 @@ examples:
   - |
     // For a TCS whose RSC base address is 0x179C0000 and is at a DRV id of
     // 2, the register offsets for DRV2 start at 0D00, the register
-    // calculations are like this::
+    // calculations are like this:
     // DRV0: 0x179C0000
     // DRV2: 0x179C0000 + 0x10000 = 0x179D0000
     // DRV2: 0x179C0000 + 0x10000 * 2 = 0x179E0000
@@ -182,7 +182,7 @@ examples:
   - |
     // For a TCS whose RSC base address is 0xAF20000 and is at DRV id of 0, the
     // register offsets for DRV0 start at 01C00, the register calculations are
-    // like this::
+    // like this:
     // DRV0: 0xAF20000
     // TCS-OFFSET: 0x1C00
     #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
index 4fcae6bedfff..72a7f8cb09ba 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
@@ -28,7 +28,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       Reference to a node specifying the wcnss "ccu" and "dxe" register blocks.
-      The node must be compatible with one of the following::
+      The node must be compatible with one of the following:
            - qcom,riva"
            - qcom,pronto"
 
diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
index 5ddd31f30f26..57c9d3c57021 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
@@ -12,10 +12,10 @@ maintainers:
 
 description: |
   Guidelines for new compatibles for SoC blocks/components.
-  When adding new compatibles in new bindings, use the format::
+  When adding new compatibles in new bindings, use the format:
     renesas,SoC-IP
 
-  For example::
+  For example:
    renesas,r8a77965-csi2
 
   When adding new compatibles to existing bindings, use the format in the
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
index 47a105a97ecf..bc8c8ba24f9c 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
@@ -45,7 +45,7 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 1, 2]
         description: |
-          The direction of the dai stream::
+          The direction of the dai stream:
            - Q6ASM_DAI_TX_RX (0) for both tx and rx
            - Q6ASM_DAI_TX (1) for only tx (Capture/Encode)
            - Q6ASM_DAI_RX (2) for only rx (Playback/Decode)
diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
index 29a08b0729ee..3f333db72a71 100644
--- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
@@ -40,7 +40,7 @@ properties:
     description: |
       The Exynos TMU supports generating interrupts when reaching given
       temperature thresholds. Number of supported thermal trip points depends
-      on the SoC (only first trip points defined in DT will be configured)::
+      on the SoC (only first trip points defined in DT will be configured):
        - most of SoC: 4
        - samsung,exynos5433-tmu: 8
        - samsung,exynos7-tmu: 8
@@ -52,7 +52,7 @@ properties:
       - description: |
           Shared TMU registers.
 
-          Note:: On Exynos5420, the TRIMINFO register is misplaced for TMU
+          Note: On Exynos5420, the TRIMINFO register is misplaced for TMU
           channels 2, 3 and 4 Use "samsung,exynos5420-tmu-ext-triminfo" in
           cases, there is a misplaced register, also provide clock to access
           that base.
diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index a7f58114c02e..90daee616880 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -92,14 +92,14 @@ properties:
 
   clocks:
     description: |
-      Several clocks are used, depending on the variant. Typical ones are::
-       - cfg_noc:: System Config NOC clock.
-       - core:: Master/Core clock, has to be >= 125 MHz for SS operation and >=
+      Several clocks are used, depending on the variant. Typical ones are:
+       - cfg_noc: System Config NOC clock.
+       - core: Master/Core clock, has to be >= 125 MHz for SS operation and >=
                 60MHz for HS operation.
-       - iface:: System bus AXI clock.
-       - sleep:: Sleep clock, used for wakeup when USB3 core goes into low
+       - iface: System bus AXI clock.
+       - sleep: Sleep clock, used for wakeup when USB3 core goes into low
                  power mode (U3).
-       - mock_utmi:: Mock utmi clock needed for ITP/SOF generation in host
+       - mock_utmi: Mock utmi clock needed for ITP/SOF generation in host
                      mode. Its frequency should be 19.2MHz.
     minItems: 1
     maxItems: 9
diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index 8201656b41ed..d99af9f413d0 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -87,14 +87,14 @@ properties:
 
   clocks:
     description: |
-      Several clocks are used, depending on the variant. Typical ones are::
-       - cfg_noc:: System Config NOC clock.
-       - core:: Master/Core clock, has to be >= 125 MHz for SS operation and >=
+      Several clocks are used, depending on the variant. Typical ones are:
+       - cfg_noc: System Config NOC clock.
+       - core: Master/Core clock, has to be >= 125 MHz for SS operation and >=
                 60MHz for HS operation.
-       - iface:: System bus AXI clock.
-       - sleep:: Sleep clock, used for wakeup when USB3 core goes into low
+       - iface: System bus AXI clock.
+       - sleep: Sleep clock, used for wakeup when USB3 core goes into low
                  power mode (U3).
-       - mock_utmi:: Mock utmi clock needed for ITP/SOF generation in host
+       - mock_utmi: Mock utmi clock needed for ITP/SOF generation in host
                      mode. Its frequency should be 19.2MHz.
     minItems: 1
     maxItems: 9
-- 
2.53.0

