Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A6606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PvIFPMvY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LMonklnK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD5D10EB82;
	Thu, 12 Nov 2026 15:07:10 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7ECC10EB82
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:06:59 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACEWZ7l126929
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=fnFzrMim3PDRjGWuhWaZm46ozSVNqIG/Ol5
 S91LrZcs=; b=PvIFPMvYjd26rsXy+/7UbGlnQXhFmwDL4Am1KwYdbqrwASYC6YO
 FcPqngxlSTQ64y5dv7jXoe6GWecHUSvFKDX26HlG5QkXO2LCsTJwP4zjYyRzCrVT
 9zTivjlzjPP1kaf4EMSlxIWpcS5LT549OPapyF5RSMRoWbj8m3kicaRQD90UebD+
 lYqOXnsnrl3l+4+gn+PoLloZdF1XAz8TQ4xZnmC1G1emTQFksjE6nGKthQlz+vXH
 QyPISJK/wU0OJV3SAHj79kYjzQ+26oc92mjn6EiWbyppD3ImxrLx/laY2ryg4rQd
 Y0CxVoaNK7sCTX1Azc6ko99LzYKVZm55acg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw9a09jp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:06:58 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eab0467c89so5718912e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794496018; x=1795100818;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fnFzrMim3PDRjGWuhWaZm46ozSVNqIG/Ol5S91LrZcs=;
 b=LMonklnKIct/ac9hUj5LxxiL/053+Fh22bnWQTZviMn/umZjAVy2rn5wyDC6dl7Xsg
 kva72cp0mc7/2Dvur1IeqyJlr8ioFXANGp6tdTSUvlHz3CR/HMjliehDAJKrycuUYKf8
 YXqwJuJyQu4okCWui8bCSdE1xPI4fvozDjkXcu9RvFKXl3JZygo1PBnlZiJdYHHVnF/Y
 6yzkRZh75yvSdGQlHCpEFeYhWLy1Gg88abheZN9thFfcwsa7gih5GlA1voaV18t71RCq
 va0kDnEdRcTFsCkTxgJOJdJya4gks/AaXci4yOmFnYFBwvb3vuoimo5iBVleYqPKm3yg
 c+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794496018; x=1795100818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fnFzrMim3PDRjGWuhWaZm46ozSVNqIG/Ol5S91LrZcs=;
 b=FABl3NQ7TrYTObyAP0ZYS+dCnCecyzEKMDCxVZf6VEhRbHO45Dh/jOR/wEs8WUqCW7
 N813DuV0aUVfqsK12Ek9/gGnlsiHvK2sKhqJcNBw2p3NzFwRo1nq7MSTyhXE5Nhgk4LS
 YYgskF4nhrpr4hlcp9A193wBU+kQNdgridmjJZJUO5f2l20pdfAwmIVqo3CUO0vP/zec
 iz0dauERumjCC7zIw66OJFwkeZUk+3nT7O8FtjoDz0B4D2Y9NNtf1McNDLxdgflBz9KT
 jtHzrr5gLkRV9joXXxtwyWvM3qQxXjHiPmiV98g0cIDHNLuqKAjfMN224x6umUnujZSf
 LwaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGrD4Chg8NQd1Tz0rCILwJ9iyUYbEouXA/UCM0LtfSbtxWJIxGuv/mcSXaXJmoRGe5c8T2AKHYrIrY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z84xZncbvr/QJoAKPiDGuxXAaSBt+hPGB1aKyi5YWjv8RswTGIb
 kj150E4Sqo0QISANRKClwoeehGCegGUUVSkekYZI5H98UomWWTtu0tZye6OImV6dE1V9lWxJ0hw
 7bmetMp1Yw5rj4TacaYNJHD+2Jj6j1bCp1zOZWKpq4TlNXyXnLMwpKNzI+8wIoOoyZiaXbf4=
X-Gm-Gg: AYBFou2JRL0sUbOugfkPROc/r0RAzJK8htTBkkkeak3jZBBRE4PPIQDovbqnpDS/PUa
 SD5TwAMNvsv/uz/2CK/X4ZnDfUgTKpl6JQgDliQRnfshnPJKcbS4Hgiw5L9sBs5K3w5X4Ml8/qz
 QjBWm318W4nwZCj2P6ho1Eep9+scdRtPpEBPohZQ9er/4ZcJCy8qUgkB+pHk2+H9ln8vHrG7+2B
 hSZxHqaibuiHtbQbn/rhEZ0dq2e4cvta+Z5gBtliENZU7fi77+1rzvPRWWVuGloJbJcFLPKs/s2
 hkWmGi7qau6ndw8M6rVlSVOCBv2u+Ty9QfygzC28qcOTKCGGx0HUNyVq+ZQA9wdR9klki7ZB+mH
 RBjUlGB4rUggqSgulYPyHNI7bNMW0TileX+YcKX2AjFExIKve1jtO7l8Ns4Mx8A==
X-Received: by 2002:a05:6122:ca0:b0:5c9:a60b:e5a6 with SMTP id
 71dfb90a1353d-5ee1c476f52mr2711092e0c.17.1794496017764; 
 Thu, 12 Nov 2026 07:06:57 -0800 (PST)
X-Received: by 2002:a05:6122:ca0:b0:5c9:a60b:e5a6 with SMTP id
 71dfb90a1353d-5ee1c476f52mr2711004e0c.17.1794496016979; 
 Thu, 12 Nov 2026 07:06:56 -0800 (PST)
Received: from quoll ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3fd2sm17919272f8f.52.2026.11.12.07.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:06:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Selvaraj <jo@jsfamily.in>,
 Jagan Teki <jagan@amarulasolutions.com>, Ondrej Jirman <megi@xff.cz>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ryan Brue <ryanbrue.dev@gmail.com>,
 Nickolay Goppen <setotau@mainlining.org>,
 Robert Chiras <robert.chiras@nxp.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Heiko Stuebner <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>,
 Michael Walle <mwalle@kernel.org>, Ritesh Kumar <quic_riteshk@quicinc.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Jens Reidel <adrian@travitia.xyz>,
 Michael Srba <Michael.Srba@seznam.cz>, Shawn Guo <shawn.guo@linaro.org>,
 Alexandre Mergnat <amergnat@baylibre.com>,
 Alexander Baransky <sanyapilot496@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Romain TISSERAND <romain.tisserand@gmail.com>
Subject: [PATCH v2] dt-bindings: display: panel: Make DSI panels port optional
Date: Thu, 12 Nov 2026 16:06:51 +0100
Message-ID: <20261112150650.137216-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22776;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=ZKLb5vyJxJkcc9MHPukILqFjzOnaQcQBF8fgwCbqjMs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq9dYKHx2XEjfhh/l23iQT8eE5/woxO54UbShX2
 0IM6sScSXiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavXWCgAKCRDBN2bmhouD
 13PxD/9ge/spf3r1E9i1Rm8l7UWuc3lu8uXHpkkqtW7XVBfmjBClbIJZ7zKQmioXPq+eZKAf0uw
 L+0P9o7rA69s8jmwW8B6BEiMZIjAyFeyzpopL5gYY18Fvym63o6ehIMZLGBWbjH2G6AhFLUyx3v
 p+r/YPXCXaY1FoSmmmTjeD/KADZgB2q2X9z5wNbI985ltOJOZT5y8bcrSivz10NS8nhl5W/FABb
 4YT42vSveKniTg7Zgx6ipMB+TCg+51veG379nokYJnxf37yIxi9yMPp1OXpLBeaDb9jiFueYnnt
 cWaoxGUpVxdxmaVMYNI9S5CSVP/je/dWwwu4/UMHQqvKcfrulXSnt3nAzzJIqPj3xdzw2QgXkXK
 G6ldC4/XNvlsemv4QHl3sJqmaMjgFf+h6VAw0caEth6uF+Ugxofa8sBBVeC3DwCXM4JzoZ1m1v+
 cl5Mn6gvwtL1JqkMrLVGUeFZ06Jz1QPBjbjL5fPmRmrAPUVf0nfN4a5XTZh6tLLAXLUfCGfkvu+
 9LnBj77J7+BJwPP6i1stc6h0Kx9uit3h8IxlfLeG3sAtAH/9FjJiR+tKB7e42F/8I3wUkf+Sj0/
 jXQx0Nzqng83YFzVAbTEJNXlPOGyGzlI0maQ0xh+Blp3HQFGUb8WufFzg7OcVN0N45kfOK172O/
 42/NtXoEztupnkA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MnayCe-rtxYuZS5r5HtrtiSTVCnogbWd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2MCBTYWx0ZWRfXxnyru+8ofHZJ
 QUySufeIRZAuCCjK6mxOAGewgg5OfUpQWZVujsVVgAeCpkPOJzxkO8vOuYb3do4geMXpDMnREbW
 j9hMCAWLXY4crrH1EAzVDVE9FEXBVc0GFjXHnnVgMesdp0NN51RxjAWmgnv0pfHMZfI16L6A4fJ
 g1YaOL82h70sMWNCvbAbGXa29ynkBMTEWEP1ov1S7AiGjXN3Dm3ZWXVPk8OPHVBRuqReY8XQhMS
 Dbn7g7vpPckNspcemhweqo69peU2q9ePiC22SBk17BMm3BxX8RVMF4YZ3SBT5uhYhpEVvBP0vDR
 Z9wJudUo3ax0UaOwP+VqaHzgjtb2MyfUQM3fO3Q87NrLUpPik8oWXl92ZG9gJyTgDgBqNDsDzTl
 yfmI63rEF/zs1Rkq6ZFlYadXKhDM3Fj7mncMryh9Fa8QAeZC88d+glvX1H3meLQX3HS8gnAEVRC
 WpUZS7e+GdNz5HM5mgQ==
X-Proofpoint-ORIG-GUID: MnayCe-rtxYuZS5r5HtrtiSTVCnogbWd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2MCBTYWx0ZWRfX0AbNBE0+BP6i
 ekVovdXRz6hJOhRxmYss5hqoWXWHwtikBEQUNuRqsDVWRGYFWFQ7l7PF4/1bjfFrqpkFXVxZNgU
 zlzZjRuv5FhQHRJSaPl+gt1SfhAY4/E=
X-Authority-Analysis: v=2.4 cv=COG/zhrD c=1 sm=1 tr=0 ts=6af5d612 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=r20e0feN5VoI4vvULvEA:9
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120060
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DSI panels can be placed under DSI bus directly and some of the Linux DRM
drivers will work fine with it: mipi_dsi_host_register() adds device for
such panel and DRM driver does not use OF graph to configure lanes.
Examples are Samsung Exynos and Allwinner DRM drivers.

The Linux panel drivers affected here do not use OF graph, either.

Requiring graph port for such panels is tying the binding to one
specific implementation of Linux DRM drivers, e.g. Qualcomm DRM which
requires the port.  That's a mistake, because:
1. It prevents usage of such panel in DTS for other platforms,
2. Places the constraint (port requirement) in wrong domain - the DSI
   host needs the port, not the panel.

The port is not needed for the panel hardware to operate thus it should
be optional.

Suggested-by: Romain TISSERAND <romain.tisserand@gmail.com>
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com> # renesas r61307 and r69328
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Change in v2:
1. Rephrase commit msg
2. Tag

Remaining one Ilitek is fixed in:
https://lore.kernel.org/all/20261109160706.2272332-2-romain.tisserand@gmail.com/
---
 .../devicetree/bindings/display/panel/anbernic,td4310.yaml       | 1 -
 Documentation/devicetree/bindings/display/panel/boe,td4320.yaml  | 1 -
 .../devicetree/bindings/display/panel/boe,tv101wum-ll2.yaml      | 1 -
 Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml | 1 -
 .../devicetree/bindings/display/panel/elida,kd35t133.yaml        | 1 -
 .../bindings/display/panel/feiyang,fy07024di26a30d.yaml          | 1 -
 .../devicetree/bindings/display/panel/himax,hx83112a.yaml        | 1 -
 .../devicetree/bindings/display/panel/himax,hx83112b.yaml        | 1 -
 .../devicetree/bindings/display/panel/himax,hx8394.yaml          | 1 -
 .../devicetree/bindings/display/panel/ilitek,ili7807s.yaml       | 1 -
 .../devicetree/bindings/display/panel/ilitek,ili9805.yaml        | 1 -
 .../devicetree/bindings/display/panel/ilitek,ili9806e.yaml       | 1 -
 Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml  | 1 -
 .../devicetree/bindings/display/panel/novatek,nt35532.yaml       | 1 -
 .../devicetree/bindings/display/panel/novatek,nt36672a.yaml      | 1 -
 .../devicetree/bindings/display/panel/novatek,nt36672e.yaml      | 1 -
 .../devicetree/bindings/display/panel/novatek,nt37801.yaml       | 1 -
 .../devicetree/bindings/display/panel/novatek,nt51021.yaml       | 1 -
 .../devicetree/bindings/display/panel/raydium,rm67191.yaml       | 1 -
 .../devicetree/bindings/display/panel/raydium,rm67200.yaml       | 1 -
 .../devicetree/bindings/display/panel/raydium,rm69220.yaml       | 1 -
 .../devicetree/bindings/display/panel/raydium,rm692e5.yaml       | 1 -
 .../devicetree/bindings/display/panel/renesas,r61307.yaml        | 1 -
 .../devicetree/bindings/display/panel/renesas,r69328.yaml        | 1 -
 .../devicetree/bindings/display/panel/ronbo,rb070d30.yaml        | 1 -
 .../devicetree/bindings/display/panel/samsung,ams581vf01.yaml    | 1 -
 .../devicetree/bindings/display/panel/samsung,ams639rq08.yaml    | 1 -
 .../bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml       | 1 -
 .../devicetree/bindings/display/panel/samsung,sofef01-m.yaml     | 1 -
 .../devicetree/bindings/display/panel/sony,td4353-jdi.yaml       | 1 -
 .../bindings/display/panel/sony,tulip-truly-nt35521.yaml         | 1 -
 .../devicetree/bindings/display/panel/startek,kd070fhfid015.yaml | 1 -
 .../devicetree/bindings/display/panel/synaptics,r63353.yaml      | 1 -
 .../devicetree/bindings/display/panel/visionox,g2647fb105.yaml   | 1 -
 .../devicetree/bindings/display/panel/visionox,r66451.yaml       | 1 -
 .../devicetree/bindings/display/panel/visionox,rm69299.yaml      | 1 -
 .../devicetree/bindings/display/panel/visionox,rm692e5.yaml      | 1 -
 .../devicetree/bindings/display/panel/visionox,vtdr6130.yaml     | 1 -
 .../devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml    | 1 -
 39 files changed, 39 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
index f820dc2f732b..1d6bf6da2ca8 100644
--- a/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
+++ b/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
@@ -31,7 +31,6 @@ properties:
 
 required:
   - compatible
-  - port
   - reg
   - reset-gpios
   - vdd-supply
diff --git a/Documentation/devicetree/bindings/display/panel/boe,td4320.yaml b/Documentation/devicetree/bindings/display/panel/boe,td4320.yaml
index c6bff0ece360..90f0d0bbe91e 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,td4320.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,td4320.yaml
@@ -36,7 +36,6 @@ required:
   - compatible
   - reg
   - reset-gpios
-  - port
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-ll2.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-ll2.yaml
index dced98e1c69a..45f3205ed952 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-ll2.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-ll2.yaml
@@ -33,7 +33,6 @@ required:
   - reset-gpios
   - vsp-supply
   - vsn-supply
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml b/Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
index 80deedc01c7c..9c6a4d5e9f5b 100644
--- a/Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
@@ -41,7 +41,6 @@ required:
   - vddpos-supply
   - vddneg-supply
   - reset-gpios
-  - port
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml b/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml
index f4cb825d1e96..d04ffbba359a 100644
--- a/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml
+++ b/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml
@@ -32,7 +32,6 @@ required:
   - compatible
   - reg
   - backlight
-  - port
   - iovcc-supply
   - vdd-supply
 
diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
index f288fa2390c9..f36e866a1325 100644
--- a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
+++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
@@ -35,7 +35,6 @@ required:
   - reg
   - avdd-supply
   - dvdd-supply
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
index 2c60d0cd704e..008a94608c42 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
@@ -40,7 +40,6 @@ required:
   - vdd1-supply
   - vsn-supply
   - vsp-supply
-  - port
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
index e58bb3d45331..bc1771efb6e9 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
@@ -40,7 +40,6 @@ required:
   - iovcc-supply
   - vsn-supply
   - vsp-supply
-  - port
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
index 83c343b02835..41dc3f39f42a 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -49,7 +49,6 @@ required:
   - compatible
   - reg
   - backlight
-  - port
   - vcc-supply
   - iovcc-supply
 
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
index ba8c5bbf8ffc..3bace821bc8e 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili7807s.yaml
@@ -41,7 +41,6 @@ required:
   - vddi-supply
   - avdd-supply
   - avee-supply
-  - port
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
index ff67129c9466..4bd76a411639 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
@@ -32,7 +32,6 @@ required:
   - dvdd-supply
   - reg
   - reset-gpios
-  - port
   - backlight
 
 unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
index 2080d9e0ffac..9a2602ddd906 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
@@ -33,7 +33,6 @@ required:
   - vdd-supply
   - reset-gpios
   - backlight
-  - port
 
 if:
   properties:
diff --git a/Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml b/Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml
index 226974a4077f..70243c087410 100644
--- a/Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml
@@ -35,7 +35,6 @@ required:
   - reset-gpios
   - power-supply
   - backlight
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35532.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35532.yaml
index ff6fdad7febf..a00aabc7f583 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt35532.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35532.yaml
@@ -47,7 +47,6 @@ required:
   - reg
   - reset-gpios
   - vddi-supply
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index 5d16d8511725..3263e21bf72e 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -54,7 +54,6 @@ required:
   - vddpos-supply
   - vddneg-supply
   - reset-gpios
-  - port
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
index dc4672f3d01d..bb10d62ac2e4 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
@@ -34,7 +34,6 @@ required:
   - avdd-supply
   - avee-supply
   - reset-gpios
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
index 1b38c1d0af68..ff7afe5467b6 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37801.yaml
@@ -36,7 +36,6 @@ required:
   - vci-supply
   - vdd-supply
   - vddio-supply
-  - port
   - reset-gpios
 
 additionalProperties: false
diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
index 7754a8cb1e5c..a50f241e0186 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
@@ -54,7 +54,6 @@ required:
   - avdd-supply
   - havdd-supply
   - reset-gpios
-  - port
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
index 4825792bf712..511cd2b64fe7 100644
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
@@ -47,7 +47,6 @@ required:
   - compatible
   - reg
   - dsi-lanes
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml
index 97b7fbe05c07..cefb5fdee826 100644
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67200.yaml
@@ -40,7 +40,6 @@ properties:
 
 required:
   - compatible
-  - port
   - reg
 
 additionalProperties: false
diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml
index 3c94db88f797..44b416260f20 100644
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml
@@ -42,7 +42,6 @@ required:
   - vci-supply
   - vddio-supply
   - reset-gpios
-  - port
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
index 616a5f3ec9fc..91336e17a059 100644
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
@@ -41,7 +41,6 @@ required:
   - dvdd-supply
   - vci-supply
   - vddio-supply
-  - port
 
 unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/renesas,r61307.yaml b/Documentation/devicetree/bindings/display/panel/renesas,r61307.yaml
index 3d7761717b74..aff691fdb771 100644
--- a/Documentation/devicetree/bindings/display/panel/renesas,r61307.yaml
+++ b/Documentation/devicetree/bindings/display/panel/renesas,r61307.yaml
@@ -55,7 +55,6 @@ properties:
 
 required:
   - compatible
-  - port
   - backlight
 
 additionalProperties: false
diff --git a/Documentation/devicetree/bindings/display/panel/renesas,r69328.yaml b/Documentation/devicetree/bindings/display/panel/renesas,r69328.yaml
index 740185f778a1..c28b671d8721 100644
--- a/Documentation/devicetree/bindings/display/panel/renesas,r69328.yaml
+++ b/Documentation/devicetree/bindings/display/panel/renesas,r69328.yaml
@@ -38,7 +38,6 @@ properties:
 
 required:
   - compatible
-  - port
   - backlight
 
 additionalProperties: false
diff --git a/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml b/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
index 694037301583..b17b7ce2b29e 100644
--- a/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
@@ -42,6 +42,5 @@ required:
   - shlr-gpios
   - updn-gpios
   - vcc-lcd-supply
-  - port
 
 unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml
index 70dff9c0ef2b..5e1fb1edb3e0 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,ams581vf01.yaml
@@ -45,7 +45,6 @@ required:
   - vsn-supply
   - vsp-supply
   - reset-gpios
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ams639rq08.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ams639rq08.yaml
index f5b6ecb96f99..3a68324a2b69 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,ams639rq08.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,ams639rq08.yaml
@@ -46,7 +46,6 @@ required:
   - vsn-supply
   - vsp-supply
   - reset-gpios
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml
index 42634fc3b5b2..25eadff02816 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml
@@ -29,7 +29,6 @@ properties:
 required:
   - compatible
   - reg
-  - port
   - vdd3-supply
   - vci-supply
   - reset-gpios
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,sofef01-m.yaml b/Documentation/devicetree/bindings/display/panel/samsung,sofef01-m.yaml
index bccc667aa072..c0a44e69b37e 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,sofef01-m.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,sofef01-m.yaml
@@ -47,7 +47,6 @@ properties:
 
 required:
   - compatible
-  - port
   - reg
   - reset-gpios
   - vddio-supply
diff --git a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
index 032a989184ff..ccfc0513eb4a 100644
--- a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
@@ -52,7 +52,6 @@ required:
   - vsn-supply
   - panel-reset-gpios
   - touch-reset-gpios
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml b/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml
index 85c5dee65383..85977dfe8b72 100644
--- a/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml
@@ -41,7 +41,6 @@ required:
   - negative5-supply
   - reset-gpios
   - enable-gpios
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml b/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
index 7fd9364fa385..4c7677f6b154 100644
--- a/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
+++ b/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
@@ -34,7 +34,6 @@ required:
   - iovcc-supply
   - reg
   - reset-gpios
-  - port
   - power-supply
 
 additionalProperties: false
diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
index 2fd6e0ec3682..6a0c7518531a 100644
--- a/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
+++ b/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
@@ -31,7 +31,6 @@ required:
   - avdd-supply
   - dvdd-supply
   - reset-gpios
-  - port
   - backlight
 
 unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/display/panel/visionox,g2647fb105.yaml b/Documentation/devicetree/bindings/display/panel/visionox,g2647fb105.yaml
index 49dcd9b8f670..ea79ea070adc 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,g2647fb105.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,g2647fb105.yaml
@@ -45,7 +45,6 @@ required:
   - vsn-supply
   - vsp-supply
   - reset-gpios
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml b/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
index 49ef45c03593..281333b781ba 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,r66451.yaml
@@ -31,7 +31,6 @@ required:
   - vddio-supply
   - vdd-supply
   - reset-gpios
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
index f61a528c0413..bcde74217e1b 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
@@ -42,7 +42,6 @@ required:
   - vdda-supply
   - vdd3p3-supply
   - reset-gpios
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/visionox,rm692e5.yaml b/Documentation/devicetree/bindings/display/panel/visionox,rm692e5.yaml
index d4b4672815fe..ec393d15423f 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,rm692e5.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,rm692e5.yaml
@@ -44,7 +44,6 @@ required:
   - reset-gpios
   - vdd-supply
   - vddio-supply
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
index 682f30dc9ee4..979c5b95fac9 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.yaml
@@ -37,7 +37,6 @@ required:
   - vddio-supply
   - vci-supply
   - reset-gpios
-  - port
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
index 9c9743a23500..13ff075bd2a6 100644
--- a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
+++ b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
@@ -31,7 +31,6 @@ required:
   - compatible
   - reg
   - backlight
-  - port
   - iovcc-supply
   - vci-supply
 
-- 
2.53.0

