Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1E606A33D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BFxv/2el;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KqCaN72T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D65E10E7BB;
	Fri, 13 Nov 2026 08:42:59 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D71810E7BB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:42:48 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD8VJTu2515636
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Zj6Lfev/TdBU/zEXLj+kc1uAUPkAbh/imhN
 2XQWfV6I=; b=BFxv/2elWgyFmeXiRUl/ZnEYw5Asosf2uGldsRiBRR2cxr7JO8C
 JY0Dc2mZS/EtPpamG0M1NW9gMrao70oNCbr9XRWcGCvks6v6Xj4TE2Bz4oZJdXmV
 cXbP9XDVwPco3wPRm7Rf9MsOUV4y9OkIBGm/jsC78B0ZIPfJhqIks08UK0VZ6VPx
 lW8HUu/CY96lcV+Kh0dRNp3SWTklDEp0FfZVM0g3txP4G6rwMyie17zr4vHtsqho
 GH0JdtCJ5zOw0+SdPitM09FRnC3sIvQqwl0eRvvzKL2alexDmiQTUog7HHn9NbiC
 GgUOpNVrRoqZbkj+03JTUSPKBXN9QrCir9g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwg1bb98m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:42:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e92aad34aso156102585a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794559366; x=1795164166;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zj6Lfev/TdBU/zEXLj+kc1uAUPkAbh/imhN2XQWfV6I=;
 b=KqCaN72TOmO0ibIMF7CKZE3r4ZMb3Op5UBleg956kCTOb3w/EM2DVG/ERmP+AIEUvT
 0ervCgYh4leiPMnGnQtsJTYo/+u1TGEYesIjOz/HYt49nDQ01bggIJ1DMuer7d8BRAPu
 wyvP6rtMamhfOEMJW/4NeJiqXmrwxM2ERWF45yvsPKgd3N8XjwElygduOZJ2WeInr+ek
 X530P4RoeaUY+AANsGizH7OUSsIzHA1+ZZRRisOBynmQis8xu6G8ECf/0beAO0T64Pdo
 VfGmrFbOllIrWXEMpBfkvjbbu1ze5cZ0CUsv0RuEcq9asvk5IlwjekeNlhhJoXw46qwR
 UqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794559366; x=1795164166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zj6Lfev/TdBU/zEXLj+kc1uAUPkAbh/imhN2XQWfV6I=;
 b=Be1j1fH23S30iVfIEeTPV0laLxVFB8Ybx3nmrFOEWSLsr6YbGOA2psNrIGxC+g/1K8
 SA1fp1pLg4WjDZWedlKc2tTDSsJj7C9okraXmAgK0ZZhAominuMojpWSufKwdKuq+0Xn
 rIpOad2qoC+v+u3FOeyz+uqmTDUqqxd86FlsW8/39HiEkLnbz4tl5O0e2y+h+VMiL1oz
 cSWPSkExsyU2suYiuhH7OYGz1SEXxGaa6Zc1uysIpM/+zdxAU7+r5PtiJ0bur1oCvmwW
 jyhSSqWYfZfSTY+fHrkJoXp3A57YEC6KhLW2trm2FSZ8hgpbT4LSnarzBuFwmnUkTmyP
 Oenw==
X-Forwarded-Encrypted: i=1;
 AL+hErHC7d4Wz0bwTZNI/icSLj6DuBXFBFe/D3hJRzdhlbEp39QKhaCT7StTgV42hrW3B3spBy8zXKrQUY8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/6vywpT56jR7yYuk/6hXsqspfqi/h2F6XhbeuqIa+etoPsvfQh
 zMDhfFI+tAJaRpHmi+YtlbAXq5IWeaNkIh5kocCxOZp5uuthAkkYYiJD0SaaHo89oSdIKz0sJf5
 14agUf7/YwXudjQy0ohTwCWR9VUoKRM5XwwEyDq16OQZruSQ9+KDuMpigKvCT/iSuGgcggto=
X-Gm-Gg: AYBFou0mdDz0cutPlYrOIN1b5FkO0IGZaiFlLbLKvHtEUOuu2eW/ZO/J8qYX0lGsyK/
 e1o6TxjH3y/P9WKxoWc4UM1eqeoxiARKoau1eAeawM87l7ZDYVfzDqd7HpyCme9O8iLqwR/PuKN
 Wt8RxErgUatZvl15eK/+2Ue9bXdzLQyMV/tVwaNvbUm+9T0j9DEFUW+mEcMMqWnaQDvtImvU+Mo
 cjzZOtpDoWn7VMkHCh45N6Y6eYqnTrgDZeUUcpmcsEJpdi8VRGroj0hJRWGVaWvf7ieLVTXSu8t
 seWDkEYXEl/NNlQrm2cKd3UHx3itSBdqQ1vgRsnWMA4sO39cCJSOasUwEoA8TeJFGxwKvjc/T2i
 onGC6Yc9sIuER6pmv/D33ny4Sob7BGYnZoJQSkcaacRAnWHG/R9N4+mQSjoJFFw==
X-Received: by 2002:a05:620a:2a06:b0:948:e2fb:8ffd with SMTP id
 af79cd13be357-9494bca2bf8mr306700985a.75.1794559365872; 
 Fri, 13 Nov 2026 00:42:45 -0800 (PST)
X-Received: by 2002:a05:620a:2a06:b0:948:e2fb:8ffd with SMTP id
 af79cd13be357-9494bca2bf8mr306696785a.75.1794559365289; 
 Fri, 13 Nov 2026 00:42:45 -0800 (PST)
Received: from quoll ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55afb6absm47272505e9.15.2026.11.13.00.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:42:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
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
Subject: [PATCH v3] dt-bindings: display: panel: Make DSI panels port optional
Date: Fri, 13 Nov 2026 09:42:37 +0100
Message-ID: <20261113084236.53336-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22989;
 i=krzysztof.kozlowski@oss.qualcomm.com; 
 h=from:subject; bh=vyEXcnZlyz2BzCHBQuQsLKzJktBY7VmoyeJZnBh4mpg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq9s18BfhzPnHdOVmlTpnspDEoI7fz49K2Ntujz
 YIuzIUebiKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavbNfAAKCRDBN2bmhouD
 1zz9D/9CLmIgwmNedvhYPlFE+Vrso9oUGQvw56usemijYw5KhF68NY00YOtVlJHK1Qnsus61qOM
 3urYa+wS0ZAueSwyz6qw9wHhWlCgucji+sm4TdUhSfZnayHv7EXRm2X4HU735TAYkh9yn6TxxuD
 53jcYx77JBRE7DiYwBf8fv/+ZEbO/zpcKUkDr0fatGxcz7kESTNKx9HAh9/ZSaz2D4hiMrpJ+QP
 JV1O0p507sBPgbGooSTyolEYD3lGsF+P0LIDOkaDXOwTvEnI1eqSE9T65rrPICa1t558cdMC3xn
 6A8PLAiF8qDLoD9LkYXRmQpQp/NZtfAgAateqi41l9WboTDGHHt/8bqF+XjPAbhY+ARJIhBszXb
 xBIHDryY2rxpQ81Lcp+tDywqu7jYqvsJIzYyuoxongGrle9eCYSf3HBPz3CwY+0B/XnG8RNKfaQ
 VarGsXLl0mEFGbyZ8hjC4ex9NbhRT/1JtfDIZnYNehuNHnxIRQWCYzWpfG1yMvp0OOXovWPkcKI
 k21v0crkffIjWWYfef69C3ppr8ciwIwrVR/T5lSHephYagwckaotY3rV4jDUOkTQl5MXPUM33c3
 IeCBfPhBGr189Ejv/pmi42RJ0a/bvSSvHT/3qCEXJU2Jew2MMBlr9AVJqZlmrtJWS9EiU2A0eBi
 jKVs+Kcui26IFhQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6Q+0h9l c=1 sm=1 tr=0 ts=6af6cd87 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=r20e0feN5VoI4vvULvEA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: xcu7Fuw39om_Mk4A0yhSfu-t257ryvA9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX0i5+c0nkYaOG
 35GjlizwMfPuu8K2+ZWjYBhiGH4w3miyj430Zm6DV45zWvqZOlaOpeRMyvNqLMyqUJuFnjKeyMM
 i9g125WclqsOM6c6lIseThn6b8Yim0taG+FO4id2zVJqYwkIXPAbguo5CjKfGZ+G6bFGMrHUYDU
 BXJGC1QUmbK2H+bjeWBcSmo24fnl0pfHv73WGAh8ryjLxbIjctK3vjBQUYLBeX02D4YxpARfm4m
 xhRxr2xcqsi8Hb/8X2qBxfE/LTKHEtM3lKk3Rd1IZEd4YKXyXvZy70Silyi+hpvLpE63t1Aou+4
 x+XbfTYk4230LiXxwbCxD+o5oqGd0bfIKs3rrAtiUrcRG5I/onN3U/D2nkuIcQFM9Amgb5MVz3A
 TbthQODqy7FSNs1U61mwj7cXMaA+RRBycSkgSWTCI3zNYaPZqpPhY3jlrxIiDhiiRoQx0m20+sW
 /FyLVKc2CNItJVf9jlA==
X-Proofpoint-ORIG-GUID: xcu7Fuw39om_Mk4A0yhSfu-t257ryvA9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX46beFcLPtb+t
 jkBYXjVqWdgv/1vkgmvewIOfu3rpQU+RbAJxwLsLOVUmxuvLiyJBXQSQ5G02f45WpVjONGodZIy
 dkGYqTOwjPrGTYXW8Su9pwxlHp/5XWY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130034
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

Change in v3:
1. Require port for the SPI-only rocktech,rk050hr345-ct106a?

Change in v2:
1. Rephrase commit msg
2. Tag

Remaining one Ilitek is fixed in:
https://lore.kernel.org/all/20261109160706.2272332-2-romain.tisserand@gmail.com/
---
 .../devicetree/bindings/display/panel/anbernic,td4310.yaml      | 1 -
 Documentation/devicetree/bindings/display/panel/boe,td4320.yaml | 1 -
 .../devicetree/bindings/display/panel/boe,tv101wum-ll2.yaml     | 1 -
 .../devicetree/bindings/display/panel/ebbg,ft8719.yaml          | 1 -
 .../devicetree/bindings/display/panel/elida,kd35t133.yaml       | 1 -
 .../bindings/display/panel/feiyang,fy07024di26a30d.yaml         | 1 -
 .../devicetree/bindings/display/panel/himax,hx83112a.yaml       | 1 -
 .../devicetree/bindings/display/panel/himax,hx83112b.yaml       | 1 -
 .../devicetree/bindings/display/panel/himax,hx8394.yaml         | 1 -
 .../devicetree/bindings/display/panel/ilitek,ili7807s.yaml      | 1 -
 .../devicetree/bindings/display/panel/ilitek,ili9805.yaml       | 1 -
 .../devicetree/bindings/display/panel/ilitek,ili9806e.yaml      | 2 +-
 Documentation/devicetree/bindings/display/panel/lxd,m9189a.yaml | 1 -
 .../devicetree/bindings/display/panel/novatek,nt35532.yaml      | 1 -
 .../devicetree/bindings/display/panel/novatek,nt36672a.yaml     | 1 -
 .../devicetree/bindings/display/panel/novatek,nt36672e.yaml     | 1 -
 .../devicetree/bindings/display/panel/novatek,nt37801.yaml      | 1 -
 .../devicetree/bindings/display/panel/novatek,nt51021.yaml      | 1 -
 .../devicetree/bindings/display/panel/raydium,rm67191.yaml      | 1 -
 .../devicetree/bindings/display/panel/raydium,rm67200.yaml      | 1 -
 .../devicetree/bindings/display/panel/raydium,rm69220.yaml      | 1 -
 .../devicetree/bindings/display/panel/raydium,rm692e5.yaml      | 1 -
 .../devicetree/bindings/display/panel/renesas,r61307.yaml       | 1 -
 .../devicetree/bindings/display/panel/renesas,r69328.yaml       | 1 -
 .../devicetree/bindings/display/panel/ronbo,rb070d30.yaml       | 1 -
 .../devicetree/bindings/display/panel/samsung,ams581vf01.yaml   | 1 -
 .../devicetree/bindings/display/panel/samsung,ams639rq08.yaml   | 1 -
 .../bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml      | 1 -
 .../devicetree/bindings/display/panel/samsung,sofef01-m.yaml    | 1 -
 .../devicetree/bindings/display/panel/sony,td4353-jdi.yaml      | 1 -
 .../bindings/display/panel/sony,tulip-truly-nt35521.yaml        | 1 -
 .../bindings/display/panel/startek,kd070fhfid015.yaml           | 1 -
 .../devicetree/bindings/display/panel/synaptics,r63353.yaml     | 1 -
 .../devicetree/bindings/display/panel/visionox,g2647fb105.yaml  | 1 -
 .../devicetree/bindings/display/panel/visionox,r66451.yaml      | 1 -
 .../devicetree/bindings/display/panel/visionox,rm69299.yaml     | 1 -
 .../devicetree/bindings/display/panel/visionox,rm692e5.yaml     | 1 -
 .../devicetree/bindings/display/panel/visionox,vtdr6130.yaml    | 1 -
 .../devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml   | 1 -
 39 files changed, 1 insertion(+), 39 deletions(-)

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
index 2080d9e0ffac..410322f4ad39 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
@@ -33,7 +33,6 @@ required:
   - vdd-supply
   - reset-gpios
   - backlight
-  - port
 
 if:
   properties:
@@ -44,6 +43,7 @@ if:
 then:
   $ref: /schemas/spi/spi-peripheral-props.yaml#
   required:
+    - port
     - spi-max-frequency
 else:
   required:
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

