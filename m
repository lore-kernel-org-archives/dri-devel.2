Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3AF606A327
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ni1xOfH1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Grhjhqc/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A76110EE47;
	Mon, 26 Oct 2026 11:11:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5026B10EE48
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:26 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAt9OH3049897
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 29ZzQSjtj8SzRQNyfVhwQ+UKXNPKZY6nAYJbOt0bugY=; b=Ni1xOfH1RLz/tYR2
 YyZiUynTNURyfK6kseHb0SgLgFDezlK7yYro6R4WhRbZ6fuHndygy6f6QKzmcbxp
 EPwx8P6YZnYQaigMZyQ5F8qdDw8jaih/6BmPR2X/yc7oAIpahCqllqXBoFZASRG+
 eBWL9vsfjqNVFdp6sRy9tGkJ8bxs6xKlabRgIx+V5+ZN+dL+fP5g+t71hYe//Ps4
 mASUDAg/F2AjvxkV2TVQV54qiBrE6Lv2KoKaOHi4xnYFjFF21KvPVvvdJAEzRfJU
 o+/3HkQqbjaVFYTclnkS29GV4GBE+6Nao1o/V2wEcDadmli+0vACtgL2ptJab6+n
 i/riwg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9ub7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:11:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f13c143c8so531224185a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 04:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793013084; x=1793617884;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=29ZzQSjtj8SzRQNyfVhwQ+UKXNPKZY6nAYJbOt0bugY=;
 b=Grhjhqc/B2iWKJjGe9ZQO6oITRAAcG+u9ObMovSrnE3tBng7XBSmihSUNOoGp6WSqE
 P9+1DMkBOc1aMCelJqNv+VnQsfLUe9urcErJxcK3LQlUtqjzpEkHQO9L5n09chy6GWB2
 aM/JGnRzLR+pT5PrvQGlQIap5sr7sBMOlU6EfU5K25ZGBooB8UXigAFYrEAOoYqgc77z
 s4CiNEMJz2IQHrDCB1k6MjfX6/XEwk9loI50VVsWuMGk6u9N2qpf7+AHqeYFuG2zyy32
 njnkMVJ106fswCwwne9dOG2g26D2bKE6t/nHBlU+0imYsnqwcF4VoOTkyf2M66x+ib/h
 HuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013084; x=1793617884;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=29ZzQSjtj8SzRQNyfVhwQ+UKXNPKZY6nAYJbOt0bugY=;
 b=TIZZPC5nqeIoXdJ23Gu7NYeN+THjxoHy3o0ZF5xiOWBwOy3XB2MaEggIt/uHGA0rN/
 e/cFQlV+Vl8KsS/0sJ8AuuoQV3r1B6C3/RvJ8fCQTGoXI2BXTgz2AIb0ZzxF8qemN0mM
 IekrA3qi7F+iP1EYs7+ApbbvMVHkf51f0eafVRMNkYP5mN9yfXlWszZvFHy3/XbDl5+F
 /CHg48cdwt+G1bKdjSU4J7/poGkLh+eQ0JnRNMLATGnSCkEDso8QpL1rD/4ZJWLBw3PT
 kKDxT2e3HLWaelCLX2Tp+ddcUAZmwlQ4IjhiFCV1zKq3YFzrLL5fW7UwkGGvdie4KBQz
 4X3g==
X-Gm-Message-State: AFq9FYKPcTN/lZEPpjuk26RqaZnUgzWo0VPCokcs9FSvKwbi7LWt+rvT
 GdLrpq7WRVhM/aMy1DFJMysK1FMzFQLfHeDtMIGetPKY8Icc/eJBqcQXVmb6CYMMBwBfZ0Y3taq
 4VtNHnY5x4jlU1/z4ghQV5UYdfbeOLI+FyH7Nmuomx37v8YObENbQoRI/f8koPpf/9pid1Ic=
X-Gm-Gg: AYBFou0ypAcoRfJDHUe5wFi38ptY7LSio1cJd88U6dp8NjG8NFffWEpqofY5V/OJAnV
 aXS8pDeb+GlNeG/m/bdmEDLWAcmwFJ7jvNVVPA57eWZyWK9s9ydz5LX0vC9YazFLjAcdfHqc2tg
 aODNx3Nh9DqwWowqk3JqHD/vMM4vrXyDe3aorl0WaJ7XLvNk/lj/uSEXjtwWYdYn7MqHOV4w1u0
 B2sNCu9RiYEwdcnGrTE3YAi3Pz3actuBH1Z6Z4aiLJxI1Wkomxg7bFuq/Fez1DxQCCBhBRrBbAP
 iNuft9Jx2c4CcpB8VE11f6WVW1sUls4qWfRhrrthsalJZhgSUmIdI9TRWghlFKmQ0gkRdJuIt+4
 51OuuQRq8SAMjfrRRcUbdHB+gU4xd3uE/S9qfG2C6x34FDJ4CoOhvaKGDWegvKNYLZxIRqpqXpO
 8it/mbA9vD1Vsv
X-Received: by 2002:a05:620a:1991:b0:93f:c0d:40a4 with SMTP id
 af79cd13be357-940ef9aecacmr925886885a.75.1793013083689; 
 Mon, 26 Oct 2026 04:11:23 -0700 (PDT)
X-Received: by 2002:a05:620a:1991:b0:93f:c0d:40a4 with SMTP id
 af79cd13be357-940ef9aecacmr925873185a.75.1793013082739; 
 Mon, 26 Oct 2026 04:11:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a950a3sm1455459e87.68.2026.10.26.04.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:11:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 13:10:13 +0200
Subject: [PATCH 24/35] drm/panel: use the orientation from the panel core
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-drm-panel-funcs-v1-24-5e3070a3478f@oss.qualcomm.com>
References: <20261026-drm-panel-funcs-v1-0-5e3070a3478f@oss.qualcomm.com>
In-Reply-To: <20261026-drm-panel-funcs-v1-0-5e3070a3478f@oss.qualcomm.com>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Paul Cercueil <paul@crapouillou.net>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Linus Walleij <linusw@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Alison Wang <alison.wang@nxp.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Ondrej Jirman <megi@xff.cz>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Igor Reznichenko <igor@reznichenko.net>, Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@edgeble.ai>, Jianhua Lu <lujianhua000@gmail.com>,
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>,
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
 Joel Selvaraj <jo@jsfamily.in>, Icenowy Zheng <icenowy@aosc.io>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Junjie Cao <junjie.cao@linux.dev>, Ryan Brue <ryanbrue.dev@gmail.com>,
 Nickolay Goppen <setotau@mainlining.org>,
 Stefan Mavrodiev <stefan@olimex.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Robert Chiras <robert.chiras@nxp.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Markuss Broks <markuss.broks@gmail.com>,
 Artur Weber <aweber.kernel@gmail.com>, David Heidelberg <david@ixit.cz>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Yedaya Katsman <yedaya.ka@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=43928;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=LxQLZltipuOMHgM1jxOdE1vhe2Lyneon2rcVok3JpBo=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9Z9U6EoZV3lJ1tK6/eu4rLhW9Rt1S/Jof1p+qtZtTqt2
 XoX7ld3MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAiF9XY/+mWXCiYGaMiP/El
 T6z0HPUwrgcrJ3LzScsWMZ8/YFoqwpuwya3Scq7DJFFdAaYg+ZOnrDuOZvb590Xa6R/1zY97fKG
 z7Nei2RFNW0tqTolsXpD8SbHVQuFVQtdx75MXtoddiH/18MZik6L3L1YEy0UX6xws79zYyP/pnN
 u7vz2Hp/2JVhKIul1b+Uaf83eUlFf3iY0rJe2Ox7g312fI+qkL1Itq5h594Xg2g+F6R+ucZ7V5S
 cWXQnnyZ4ucalofeNDSI/mCduFLzr2Bj+49nV+QFrTVcY9CgGT3Ge24q1/mnc6ZfJ7vXWHDsatt
 ew9qNibEnBWYdHvuPj2+olT/7ZN1vm/fMdm162O/47kwAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: eb_bGmjXKi8BNjhzgc7jMSRDmNLfz-nr
X-Proofpoint-GUID: eb_bGmjXKi8BNjhzgc7jMSRDmNLfz-nr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfXy+CW+K4vnQtF
 5WNaMW4mGfMHooYKs9u64hZZGrsEXy6+3JjFTOaiUcSP1AyxXyJNZqz09ngg5d2PH5Ya18xavP4
 ltaujTCKWJreY/B1HEneYdue+GFgehqTVsR3TKtG/i6wj3WEyJ1Mcjl0TnPufkA3zqOfah54vFT
 3Nkzv0Y2B/F+7xIVpnqoLfM8zvI9JMLte5+NcppHeLJKMGcXxuF3ldeeIzMzFtc5tAbgYhp+Ayo
 2LmTiztnn+RqCZmS4e/HBX5HD3DrTba5szrwaLJrh3RFb2ClXpULd75/V3glhXa9cNbJ8Zsop4F
 hBM9cWslPNjUAxFw8UZwLMI/1aWOt4qdK/UaQfVpUwXs/+S9PmtgKeyHxZRdTt5zFP80iURus/X
 OThWiIcXiIEwf6FfCvnfBNhYxH1ZUfX7UObW+I496G+tdP4IvrTPAYl/az1Z0rr2LyjorvD9uiA
 3UVa7KU4rSyEf6VQ5Sw==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf355d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=pQ-wOJpx4gPXxIu0Us4A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NCBTYWx0ZWRfXyS+/vWDpzZAZ
 VmMbZ4c7GuQF+0k2oo8vyf1Lgz7vk6t+A1uEEhiulekfAVBltQTZ/ZF1rac/fV+PWhdVHsPzhSt
 f7T9Ebi1zcV+WBqWT5Yau8s6CyvjOFQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260044
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The panel core handles the "rotation" property now, so the drivers' own
copies are redundant.

ili9881c keeps overriding the value for the 180 degree rotation, the
panel performs that one in the hardware. The -ENODEV exemption in
renesas-r63419 was dead code, drm_of_get_panel_orientation() never
returns that.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-anbernic-td4310.c       | 14 --------------
 .../gpu/drm/panel/panel-boe-th101mb31ig002-28a.c    | 19 -------------------
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c      | 16 ----------------
 drivers/gpu/drm/panel/panel-chipone-icna35xx.c      | 16 ----------------
 drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c   | 16 ----------------
 drivers/gpu/drm/panel/panel-edp.c                   | 16 ----------------
 drivers/gpu/drm/panel/panel-elida-kd35t133.c        | 16 ----------------
 drivers/gpu/drm/panel/panel-focaltech-ota7290b.c    | 17 -----------------
 drivers/gpu/drm/panel/panel-himax-hx83102.c         | 14 --------------
 drivers/gpu/drm/panel/panel-himax-hx8394.c          | 16 ----------------
 drivers/gpu/drm/panel/panel-ilitek-ili7836a.c       | 16 ----------------
 drivers/gpu/drm/panel/panel-ilitek-ili9488.c        | 14 --------------
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c   | 14 --------------
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c       | 21 ++-------------------
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c       | 16 ----------------
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c    | 13 -------------
 drivers/gpu/drm/panel/panel-lvds.c                  | 15 ---------------
 drivers/gpu/drm/panel/panel-novatek-nt36523.c       | 16 ----------------
 drivers/gpu/drm/panel/panel-renesas-r63419.c        | 17 -----------------
 drivers/gpu/drm/panel/panel-simple.c                | 15 ---------------
 drivers/gpu/drm/panel/panel-sitronix-st7701.c       | 14 --------------
 drivers/gpu/drm/panel/panel-sitronix-st7703.c       | 14 --------------
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c      | 14 --------------
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c     | 16 ----------------
 24 files changed, 2 insertions(+), 373 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-anbernic-td4310.c b/drivers/gpu/drm/panel/panel-anbernic-td4310.c
index 3b6de1b2fbc6..89e5698e1094 100644
--- a/drivers/gpu/drm/panel/panel-anbernic-td4310.c
+++ b/drivers/gpu/drm/panel/panel-anbernic-td4310.c
@@ -12,7 +12,6 @@
 #include <linux/regulator/consumer.h>
 
 #include <drm/drm_mipi_dsi.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -42,7 +41,6 @@ struct anbernic_panel_td4310 {
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *enable_gpio;
 	struct regulator *vdd;
-	enum drm_panel_orientation orientation;
 };
 
 static inline struct anbernic_panel_td4310 *panel_to_anbernic_panel_td4310(struct drm_panel *panel)
@@ -134,18 +132,10 @@ static int panel_anbernic_td4310_get_mode(struct drm_panel *panel,
 	return drm_connector_helper_get_modes_fixed(connector, panel_info->display_mode);
 }
 
-static enum drm_panel_orientation panel_anbernic_td4310_get_orientation(struct drm_panel *panel)
-{
-	struct anbernic_panel_td4310 *ctx = panel_to_anbernic_panel_td4310(panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs panel_anbernic_td4310_funcs = {
 	.prepare = panel_anbernic_td4310_prepare,
 	.unprepare = panel_anbernic_td4310_unprepare,
 	.get_modes = panel_anbernic_td4310_get_mode,
-	.get_orientation = panel_anbernic_td4310_get_orientation,
 };
 
 static int panel_anbernic_td4310_probe(struct mipi_dsi_device *dsi)
@@ -166,10 +156,6 @@ static int panel_anbernic_td4310_probe(struct mipi_dsi_device *dsi)
 	if (!ctx->panel_info)
 		return -EINVAL;
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to get panel orientation\n");
-
 	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset_gpio))
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index a67e0e57d8c3..9e7b577b7be3 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -15,7 +15,6 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -46,7 +45,6 @@ struct boe_th101mb31ig002 {
 	struct gpio_desc *enable;
 	struct gpio_desc *reset;
 
-	enum drm_panel_orientation orientation;
 };
 
 static void boe_th101mb31ig002_reset(struct boe_th101mb31ig002 *ctx)
@@ -321,22 +319,11 @@ static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
 	return drm_connector_helper_get_modes_fixed(connector, desc_mode);
 }
 
-static enum drm_panel_orientation
-boe_th101mb31ig002_get_orientation(struct drm_panel *panel)
-{
-	struct boe_th101mb31ig002 *ctx = container_of(panel,
-						      struct boe_th101mb31ig002,
-						      panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs boe_th101mb31ig002_funcs = {
 	.prepare = boe_th101mb31ig002_prepare,
 	.unprepare = boe_th101mb31ig002_unprepare,
 	.disable = boe_th101mb31ig002_disable,
 	.get_modes = boe_th101mb31ig002_get_modes,
-	.get_orientation = boe_th101mb31ig002_get_orientation,
 };
 
 static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
@@ -375,12 +362,6 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
 				     "Failed to get reset GPIO\n");
 
-	ret = drm_of_get_panel_orientation(dsi->dev.of_node,
-					   &ctx->orientation);
-	if (ret)
-		return dev_err_probe(&dsi->dev, ret,
-				     "Failed to get orientation\n");
-
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 681a2418f154..1e3a6b8bca1d 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -13,7 +13,6 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
@@ -47,7 +46,6 @@ struct boe_panel {
 
 	const struct panel_desc *desc;
 
-	enum drm_panel_orientation orientation;
 	struct regulator *pp3300;
 	struct regulator *pp1800;
 	struct regulator *avee;
@@ -1669,20 +1667,12 @@ static int boe_panel_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static enum drm_panel_orientation boe_panel_get_orientation(struct drm_panel *panel)
-{
-	struct boe_panel *boe = to_boe_panel(panel);
-
-	return boe->orientation;
-}
-
 static const struct drm_panel_funcs boe_panel_funcs = {
 	.disable = boe_panel_disable,
 	.unprepare = boe_panel_unprepare,
 	.prepare = boe_panel_prepare,
 	.enable = boe_panel_enable,
 	.get_modes = boe_panel_get_modes,
-	.get_orientation = boe_panel_get_orientation,
 };
 
 static int boe_panel_add(struct boe_panel *boe)
@@ -1717,12 +1707,6 @@ static int boe_panel_add(struct boe_panel *boe)
 
 	boe->base.prepare_prev_first = true;
 
-	err = drm_of_get_panel_orientation(dev->of_node, &boe->orientation);
-	if (err < 0) {
-		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
-		return err;
-	}
-
 	err = drm_panel_of_backlight(&boe->base);
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
index 2cc16494a4ce..e58d66ef9c5b 100644
--- a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
+++ b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
@@ -21,7 +21,6 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -30,7 +29,6 @@ struct panel_info {
 	struct drm_connector *connector;
 	struct mipi_dsi_device *dsi;
 	struct panel_desc *desc;
-	enum drm_panel_orientation orientation;
 
 	struct gpio_desc *reset_gpio;
 	struct regulator_bulk_data *supplies;
@@ -284,19 +282,11 @@ static int icna35xx_get_modes(struct drm_panel *panel,
 	return drm_connector_helper_get_modes_fixed(connector, pinfo->desc->modes);
 }
 
-static enum drm_panel_orientation icna35xx_get_orientation(struct drm_panel *panel)
-{
-	struct panel_info *pinfo = to_panel_info(panel);
-
-	return pinfo->orientation;
-}
-
 static const struct drm_panel_funcs icna35xx_panel_funcs = {
 	.disable = icna35xx_disable,
 	.prepare = icna35xx_prepare,
 	.unprepare = icna35xx_unprepare,
 	.get_modes = icna35xx_get_modes,
-	.get_orientation = icna35xx_get_orientation,
 };
 
 static int icna35xx_bl_update_status(struct backlight_device *bl)
@@ -375,12 +365,6 @@ static int icna35xx_probe(struct mipi_dsi_device *dsi)
 	pinfo->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, pinfo);
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &pinfo->orientation);
-	if (ret < 0) {
-		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
-		return ret;
-	}
-
 	pinfo->panel.prepare_prev_first = true;
 
 	pinfo->panel.backlight = icna35xx_create_backlight(dsi);
diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
index 562dc573528d..38f8c88e527d 100644
--- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
+++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
@@ -13,7 +13,6 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
@@ -31,7 +30,6 @@ struct ch13726a_panel {
 	struct regulator_bulk_data *supplies;
 	struct gpio_desc *reset_gpio;
 	struct ch13726a_desc *desc;
-	enum drm_panel_orientation orientation;
 };
 
 struct ch13726a_desc {
@@ -191,19 +189,11 @@ static int ch13726a_get_modes(struct drm_panel *panel,
 	return ctx->desc->num_modes;
 }
 
-static enum drm_panel_orientation ch13726a_get_orientation(struct drm_panel *panel)
-{
-	struct ch13726a_panel *ctx = to_ch13726a_panel(panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs ch13726a_panel_funcs = {
 	.prepare = ch13726a_prepare,
 	.unprepare = ch13726a_unprepare,
 	.disable = ch13726a_disable,
 	.get_modes = ch13726a_get_modes,
-	.get_orientation = ch13726a_get_orientation,
 };
 
 static int ch13726a_bl_update_status(struct backlight_device *bl)
@@ -269,12 +259,6 @@ static int ch13726a_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset-gpios\n");
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
-	if (ret < 0) {
-		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
-		return ret;
-	}
-
 	ctx->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, ctx);
 
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 493a76f7416c..be19a7e862eb 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -40,7 +40,6 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 /**
@@ -254,7 +253,6 @@ struct panel_edp {
 
 	struct drm_display_mode override_mode;
 
-	enum drm_panel_orientation orientation;
 };
 
 static inline struct panel_edp *to_panel_edp(struct drm_panel *panel)
@@ -640,13 +638,6 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 	return num;
 }
 
-static enum drm_panel_orientation panel_edp_get_orientation(struct drm_panel *panel)
-{
-	struct panel_edp *p = to_panel_edp(panel);
-
-	return p->orientation;
-}
-
 static int detected_panel_show(struct seq_file *s, void *data)
 {
 	struct drm_panel *panel = s->private;
@@ -675,7 +666,6 @@ static const struct drm_panel_funcs panel_edp_funcs = {
 	.prepare = panel_edp_prepare,
 	.enable = panel_edp_enable,
 	.get_modes = panel_edp_get_modes,
-	.get_orientation = panel_edp_get_orientation,
 	.debugfs_init = panel_edp_debugfs_init,
 };
 
@@ -863,12 +853,6 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 		return dev_err_probe(dev, PTR_ERR(panel->enable_gpio),
 				     "failed to request GPIO\n");
 
-	err = drm_of_get_panel_orientation(dev->of_node, &panel->orientation);
-	if (err) {
-		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
-		return err;
-	}
-
 	ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
 	if (ddc) {
 		panel->ddc = of_get_i2c_adapter_by_node(ddc);
diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index d23002b5a2d7..c44d6cb5b7d7 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -21,7 +21,6 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 /* Manufacturer specific Commands send via DSI */
@@ -43,7 +42,6 @@ struct kd35t133 {
 	struct gpio_desc *reset_gpio;
 	struct regulator *vdd;
 	struct regulator *iovcc;
-	enum drm_panel_orientation orientation;
 };
 
 static inline struct kd35t133 *panel_to_kd35t133(struct drm_panel *panel)
@@ -187,18 +185,10 @@ static int kd35t133_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static enum drm_panel_orientation kd35t133_get_orientation(struct drm_panel *panel)
-{
-	struct kd35t133 *ctx = panel_to_kd35t133(panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs kd35t133_funcs = {
 	.unprepare	= kd35t133_unprepare,
 	.prepare	= kd35t133_prepare,
 	.get_modes	= kd35t133_get_modes,
-	.get_orientation = kd35t133_get_orientation,
 };
 
 static int kd35t133_probe(struct mipi_dsi_device *dsi)
@@ -234,12 +224,6 @@ static int kd35t133_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
-	if (ret < 0) {
-		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
-		return ret;
-	}
-
 	mipi_dsi_set_drvdata(dsi, ctx);
 
 	ctx->dev = dev;
diff --git a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
index bbc870b8fda8..25ae76a5ad48 100644
--- a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
+++ b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
@@ -17,7 +17,6 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -31,7 +30,6 @@ struct ota7290b {
 	struct regulator *vdd;
 	struct regulator *vcc;
 
-	enum drm_panel_orientation orientation;
 };
 
 static inline struct ota7290b *panel_to_ota(struct drm_panel *panel)
@@ -135,18 +133,10 @@ static int ota7290b_get_modes(struct drm_panel *panel,
 	return drm_connector_helper_get_modes_fixed(connector, &waveshare_dsi_touch_8_8_a_mode);
 }
 
-static enum drm_panel_orientation ota7290b_get_orientation(struct drm_panel *panel)
-{
-	struct ota7290b *ctx = panel_to_ota(panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs ota7290b_funcs = {
 	.prepare = ota7290b_prepare,
 	.unprepare = ota7290b_unprepare,
 	.get_modes = ota7290b_get_modes,
-	.get_orientation = ota7290b_get_orientation,
 };
 
 static int ota7290b_probe(struct mipi_dsi_device *dsi)
@@ -182,13 +172,6 @@ static int ota7290b_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->vdd),
 					"Couldn't get our VDD supply\n");
 
-	ret = drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
-	if (ret) {
-		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
-			dsi->dev.of_node, ret);
-		return ret;
-	}
-
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 3ef052571ce0..02c887c5adbc 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -17,7 +17,6 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
@@ -62,7 +61,6 @@ struct hx83102 {
 
 	const struct hx83102_panel_desc *desc;
 
-	enum drm_panel_orientation orientation;
 	struct regulator *pp1800;
 	struct regulator *avee;
 	struct regulator *avdd;
@@ -1173,20 +1171,12 @@ static int hx83102_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static enum drm_panel_orientation hx83102_get_orientation(struct drm_panel *panel)
-{
-	struct hx83102 *ctx = panel_to_hx83102(panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs hx83102_drm_funcs = {
 	.disable   = hx83102_disable,
 	.unprepare = hx83102_unprepare,
 	.prepare   = hx83102_prepare,
 	.enable    = hx83102_enable,
 	.get_modes = hx83102_get_modes,
-	.get_orientation = hx83102_get_orientation,
 };
 
 static int hx83102_bl_update_status(struct backlight_device *bl)
@@ -1265,10 +1255,6 @@ static int hx83102_panel_add(struct hx83102 *ctx)
 
 	ctx->base.prepare_prev_first = true;
 
-	err = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
-	if (err < 0)
-		return dev_err_probe(dev, err, "failed to get orientation\n");
-
 	err = drm_panel_of_backlight(&ctx->base);
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index 4180d4aadf5e..2d4eac396b41 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -21,7 +21,6 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #define DRV_NAME "panel-himax-hx8394"
@@ -71,7 +70,6 @@ struct hx8394 {
 	struct gpio_desc *reset_gpio;
 	struct regulator *vcc;
 	struct regulator *iovcc;
-	enum drm_panel_orientation orientation;
 
 	const struct hx8394_panel_desc *desc;
 };
@@ -959,20 +957,12 @@ static int hx8394_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static enum drm_panel_orientation hx8394_get_orientation(struct drm_panel *panel)
-{
-	struct hx8394 *ctx = panel_to_hx8394(panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs hx8394_drm_funcs = {
 	.disable   = hx8394_disable,
 	.unprepare = hx8394_unprepare,
 	.prepare   = hx8394_prepare,
 	.enable	   = hx8394_enable,
 	.get_modes = hx8394_get_modes,
-	.get_orientation = hx8394_get_orientation,
 };
 
 static int hx8394_probe(struct mipi_dsi_device *dsi)
@@ -992,12 +982,6 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset gpio\n");
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
-	if (ret < 0) {
-		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
-		return ret;
-	}
-
 	mipi_dsi_set_drvdata(dsi, ctx);
 
 	ctx->dev = dev;
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c b/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c
index f6331129dadf..0aa245947514 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili7836a.c
@@ -11,7 +11,6 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -29,7 +28,6 @@ struct ili7836a_panel {
 	struct regulator_bulk_data *supplies;
 	struct gpio_desc *reset_gpio;
 	struct ili7836a_desc *desc;
-	enum drm_panel_orientation orientation;
 };
 
 struct ili7836a_desc {
@@ -172,19 +170,11 @@ static int ili7836a_get_modes(struct drm_panel *panel,
 	return drm_connector_helper_get_modes_fixed(connector, ctx->desc->modes);
 }
 
-static enum drm_panel_orientation ili7836a_get_orientation(struct drm_panel *panel)
-{
-	struct ili7836a_panel *ctx = to_ili7836a_panel(panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs ili7836a_panel_funcs = {
 	.prepare = ili7836a_prepare,
 	.unprepare = ili7836a_unprepare,
 	.disable = ili7836a_disable,
 	.get_modes = ili7836a_get_modes,
-	.get_orientation = ili7836a_get_orientation,
 };
 
 static int ili7836a_bl_update_status(struct backlight_device *bl)
@@ -250,12 +240,6 @@ static int ili7836a_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset-gpios\n");
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
-	if (ret < 0) {
-		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
-		return ret;
-	}
-
 	ctx->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, ctx);
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9488.c b/drivers/gpu/drm/panel/panel-ilitek-ili9488.c
index 6ab8ae72abbf..31120c560834 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9488.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9488.c
@@ -13,7 +13,6 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -34,7 +33,6 @@ struct ili9488 {
 	struct gpio_desc *reset;
 	struct regulator_bulk_data supplies[2];
 	const struct ili9488_desc *desc;
-	enum drm_panel_orientation orientation;
 };
 
 static const char * const regulator_names[] = {
@@ -193,18 +191,10 @@ static int ili9488_get_modes(struct drm_panel *panel, struct drm_connector *conn
 	return drm_connector_helper_get_modes_fixed(connector, mode);
 }
 
-static enum drm_panel_orientation ili9488_get_orientation(struct drm_panel *panel)
-{
-	struct ili9488 *ili = panel_to_ili9488(panel);
-
-	return ili->orientation;
-}
-
 static const struct drm_panel_funcs ili9488_funcs = {
 	.prepare	= ili9488_prepare,
 	.unprepare	= ili9488_unprepare,
 	.get_modes	= ili9488_get_modes,
-	.get_orientation = ili9488_get_orientation,
 };
 
 static int ili9488_dsi_probe(struct mipi_dsi_device *dsi)
@@ -238,10 +228,6 @@ static int ili9488_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to get regulators\n");
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &ili->orientation);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to get orientation\n");
-
 	ret = drm_panel_of_backlight(&ili->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get backlight\n");
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
index 89915d58f69d..75dc1aed0818 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
@@ -9,7 +9,6 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -28,7 +27,6 @@ struct ili9806e_dsi_panel_desc {
 struct ili9806e_dsi_panel {
 	struct mipi_dsi_device *dsi;
 	const struct ili9806e_dsi_panel_desc *desc;
-	enum drm_panel_orientation orientation;
 };
 
 static int ili9806e_dsi_on(struct ili9806e_dsi_panel *ili9806e)
@@ -99,18 +97,10 @@ static int ili9806e_dsi_get_modes(struct drm_panel *panel,
 	return drm_connector_helper_get_modes_fixed(connector, mode);
 }
 
-static enum drm_panel_orientation ili9806e_dsi_get_orientation(struct drm_panel *panel)
-{
-	struct ili9806e_dsi_panel *ctx = ili9806e_get_transport(panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs ili9806e_dsi_funcs = {
 	.prepare = ili9806e_dsi_prepare,
 	.unprepare = ili9806e_dsi_unprepare,
 	.get_modes = ili9806e_dsi_get_modes,
-	.get_orientation = ili9806e_dsi_get_orientation,
 };
 
 static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
@@ -132,10 +122,6 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = ctx->desc->format;
 	dsi->lanes = ctx->desc->lanes;
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get orientation\n");
-
 	ret = ili9806e_probe(dev, ctx, &ili9806e_dsi_funcs,
 			     DRM_MODE_CONNECTOR_DSI);
 	if (ret)
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 9e64bdb403ed..86c19af3c1f5 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -16,7 +16,6 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
@@ -56,7 +55,6 @@ struct ili9881c {
 	struct regulator	*iovcc;
 	struct gpio_desc	*reset;
 
-	enum drm_panel_orientation	orientation;
 	u8 address_mode;
 };
 
@@ -2523,18 +2521,10 @@ static int ili9881c_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static enum drm_panel_orientation ili9881c_get_orientation(struct drm_panel *panel)
-{
-	struct ili9881c *ctx = panel_to_ili9881c(panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs ili9881c_funcs = {
 	.prepare	= ili9881c_prepare,
 	.unprepare	= ili9881c_unprepare,
 	.get_modes	= ili9881c_get_modes,
-	.get_orientation = ili9881c_get_orientation,
 };
 
 static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
@@ -2569,17 +2559,10 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
 				     "Couldn't get our reset GPIO\n");
 
-	ret = drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
-	if (ret) {
-		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
-			dsi->dev.of_node, ret);
-		return ret;
-	}
-
 	ctx->address_mode = ctx->desc->default_address_mode;
-	if (ctx->orientation == DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP) {
+	if (ctx->panel.orientation == DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP) {
 		ctx->address_mode ^= 0x03;
-		ctx->orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
+		ctx->panel.orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
 	}
 
 	ctx->panel.prepare_prev_first = true;
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index bea5ca70c775..e4d88d6085eb 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -13,7 +13,6 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
@@ -52,7 +51,6 @@ struct ili9882t {
 
 	const struct panel_desc *desc;
 
-	enum drm_panel_orientation orientation;
 	struct regulator *pp3300;
 	struct regulator *pp1800;
 	struct regulator *avee;
@@ -978,20 +976,12 @@ static int ili9882t_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static enum drm_panel_orientation ili9882t_get_orientation(struct drm_panel *panel)
-{
-	struct ili9882t *ili = to_ili9882t(panel);
-
-	return ili->orientation;
-}
-
 static const struct drm_panel_funcs ili9882t_funcs = {
 	.disable = ili9882t_disable,
 	.unprepare = ili9882t_unprepare,
 	.prepare = ili9882t_prepare,
 	.enable = ili9882t_enable,
 	.get_modes = ili9882t_get_modes,
-	.get_orientation = ili9882t_get_orientation,
 };
 
 static int ili9882t_add(struct ili9882t *ili)
@@ -1024,12 +1014,6 @@ static int ili9882t_add(struct ili9882t *ili)
 
 	gpiod_set_value_cansleep(ili->enable_gpio, 0);
 
-	err = drm_of_get_panel_orientation(dev->of_node, &ili->orientation);
-	if (err < 0) {
-		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
-		return err;
-	}
-
 	err = drm_panel_of_backlight(&ili->base);
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 5202c1ffc6e1..4147ce81da3f 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -45,7 +45,6 @@ struct jadard {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
 	const struct jadard_panel_desc *desc;
-	enum drm_panel_orientation orientation;
 	struct regulator *vdd;
 	struct regulator *vccio;
 	struct gpio_desc *reset;
@@ -164,19 +163,11 @@ static int jadard_get_modes(struct drm_panel *panel,
 		return drm_connector_helper_get_modes_fixed(connector, jadard->desc->mode_4ln);
 }
 
-static enum drm_panel_orientation jadard_panel_get_orientation(struct drm_panel *panel)
-{
-	struct jadard *jadard = panel_to_jadard(panel);
-
-	return jadard->orientation;
-}
-
 static const struct drm_panel_funcs jadard_funcs = {
 	.disable = jadard_disable,
 	.unprepare = jadard_unprepare,
 	.prepare = jadard_prepare,
 	.get_modes = jadard_get_modes,
-	.get_orientation = jadard_panel_get_orientation,
 };
 
 static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
@@ -3235,10 +3226,6 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(jadard->vccio),
 				"failed to get vccio regulator\n");
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &jadard->orientation);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "failed to get orientation\n");
-
 	ret = drm_panel_of_backlight(&jadard->panel);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 92d397b131ba..127011807390 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -37,7 +37,6 @@ struct panel_lvds {
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *reset_gpio;
 
-	enum drm_panel_orientation orientation;
 };
 
 static inline struct panel_lvds *to_panel_lvds(struct drm_panel *panel)
@@ -101,18 +100,10 @@ static int panel_lvds_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static enum drm_panel_orientation panel_lvds_get_orientation(struct drm_panel *panel)
-{
-	struct panel_lvds *lvds = to_panel_lvds(panel);
-
-	return lvds->orientation;
-}
-
 static const struct drm_panel_funcs panel_lvds_funcs = {
 	.unprepare = panel_lvds_unprepare,
 	.prepare = panel_lvds_prepare,
 	.get_modes = panel_lvds_get_modes,
-	.get_orientation = panel_lvds_get_orientation,
 };
 
 static int panel_lvds_parse_dt(struct panel_lvds *lvds)
@@ -120,12 +111,6 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 	struct device_node *np = lvds->dev->of_node;
 	int ret;
 
-	ret = drm_of_get_panel_orientation(np, &lvds->orientation);
-	if (ret < 0) {
-		dev_err(lvds->dev, "%pOF: failed to get orientation %d\n", np, ret);
-		return ret;
-	}
-
 	ret = of_get_drm_panel_display_mode(np, &lvds->dmode, &lvds->bus_flags);
 	if (ret < 0) {
 		dev_err(lvds->dev, "%pOF: problems parsing panel-timing (%d)\n",
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index 34b9123d3fd7..69f5aa7ead9a 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -19,7 +19,6 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #define DSI_NUM_MIN 1
@@ -28,7 +27,6 @@ struct panel_info {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi[2];
 	const struct panel_desc *desc;
-	enum drm_panel_orientation orientation;
 
 	struct gpio_desc *reset_gpio;
 	struct backlight_device *backlight;
@@ -1087,19 +1085,11 @@ static int nt36523_get_modes(struct drm_panel *panel,
 	return pinfo->desc->num_modes;
 }
 
-static enum drm_panel_orientation nt36523_get_orientation(struct drm_panel *panel)
-{
-	struct panel_info *pinfo = to_panel_info(panel);
-
-	return pinfo->orientation;
-}
-
 static const struct drm_panel_funcs nt36523_panel_funcs = {
 	.disable = nt36523_disable,
 	.prepare = nt36523_prepare,
 	.unprepare = nt36523_unprepare,
 	.get_modes = nt36523_get_modes,
-	.get_orientation = nt36523_get_orientation,
 };
 
 static int nt36523_bl_update_status(struct backlight_device *bl)
@@ -1207,12 +1197,6 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 	pinfo->dsi[0] = dsi;
 	mipi_dsi_set_drvdata(dsi, pinfo);
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &pinfo->orientation);
-	if (ret < 0) {
-		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
-		return ret;
-	}
-
 	pinfo->panel.prepare_prev_first = true;
 
 	if (pinfo->desc->has_dcs_backlight) {
diff --git a/drivers/gpu/drm/panel/panel-renesas-r63419.c b/drivers/gpu/drm/panel/panel-renesas-r63419.c
index ff3846d574e5..c3a4f06502fd 100644
--- a/drivers/gpu/drm/panel/panel-renesas-r63419.c
+++ b/drivers/gpu/drm/panel/panel-renesas-r63419.c
@@ -20,7 +20,6 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -32,7 +31,6 @@ struct renesas_r63419_panel {
 	struct gpio_desc *reset_gpio;
 	struct regulator_bulk_data *vdd_supplies;
 	struct regulator_bulk_data *vcc_supplies;
-	enum drm_panel_orientation orientation;
 };
 
 /* VDDIO/VDD Supplies */
@@ -215,20 +213,11 @@ static int renesas_r63419_get_modes(struct drm_panel *panel,
 	return drm_connector_helper_get_modes_fixed(connector, mode);
 }
 
-static enum drm_panel_orientation
-renesas_r63419_get_orientation(struct drm_panel *panel)
-{
-	struct renesas_r63419_panel *ctx = to_renesas_r63419_panel(panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs renesas_r63419_panel_funcs = {
 	.disable = renesas_r63419_disable,
 	.prepare = renesas_r63419_prepare,
 	.unprepare = renesas_r63419_unprepare,
 	.get_modes = renesas_r63419_get_modes,
-	.get_orientation = renesas_r63419_get_orientation,
 };
 
 static int renesas_r63419_probe(struct mipi_dsi_device *dsi)
@@ -292,12 +281,6 @@ static int renesas_r63419_probe(struct mipi_dsi_device *dsi)
 	ctx->dsi[0] = dsi;
 	mipi_dsi_set_drvdata(dsi, ctx);
 
-	/* Get panel orientation */
-	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
-	if (ret < 0 && ret != -ENODEV)
-		return dev_err_probe(dev, ret,
-				     "Failed to get panel orientation\n");
-
 	ctx->panel.prepare_prev_first = true;
 
 	ret = drm_panel_of_backlight(&ctx->panel);
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 0bd0afbd562e..e15e8d36d868 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -161,7 +161,6 @@ struct panel_simple {
 
 	struct drm_display_mode override_mode;
 
-	enum drm_panel_orientation orientation;
 };
 
 static inline struct panel_simple *to_panel_simple(struct drm_panel *panel)
@@ -399,20 +398,12 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 	return num;
 }
 
-static enum drm_panel_orientation panel_simple_get_orientation(struct drm_panel *panel)
-{
-	struct panel_simple *p = to_panel_simple(panel);
-
-	return p->orientation;
-}
-
 static const struct drm_panel_funcs panel_simple_funcs = {
 	.disable = panel_simple_disable,
 	.unprepare = panel_simple_unprepare,
 	.prepare = panel_simple_prepare,
 	.enable = panel_simple_enable,
 	.get_modes = panel_simple_get_modes,
-	.get_orientation = panel_simple_get_orientation,
 };
 
 static struct panel_desc *panel_dpi_probe(struct device *dev)
@@ -669,12 +660,6 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
 		return dev_err_cast_probe(dev, panel->enable_gpio,
 					  "failed to request GPIO\n");
 
-	err = drm_of_get_panel_orientation(dev->of_node, &panel->orientation);
-	if (err) {
-		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
-		return ERR_PTR(err);
-	}
-
 	ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
 	if (ddc) {
 		panel->ddc = of_find_i2c_adapter_by_node(ddc);
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index b6e62a4c67fa..7ab10bc9815b 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -7,7 +7,6 @@
 #include <drm/drm_mipi_dbi.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <linux/bitfield.h>
@@ -139,7 +138,6 @@ struct st7701 {
 	struct regulator_bulk_data supplies[2];
 	struct gpio_desc *reset;
 	unsigned int sleep_delay;
-	enum drm_panel_orientation orientation;
 
 	int (*write_command)(struct st7701 *st7701, u8 cmd, const u8 *seq,
 			     size_t len);
@@ -638,20 +636,12 @@ static int st7701_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static enum drm_panel_orientation st7701_get_orientation(struct drm_panel *panel)
-{
-	struct st7701 *st7701 = panel_to_st7701(panel);
-
-	return st7701->orientation;
-}
-
 static const struct drm_panel_funcs st7701_funcs = {
 	.disable	= st7701_disable,
 	.unprepare	= st7701_unprepare,
 	.prepare	= st7701_prepare,
 	.enable		= st7701_enable,
 	.get_modes	= st7701_get_modes,
-	.get_orientation = st7701_get_orientation,
 };
 
 static const struct drm_display_mode ts8550b_mode = {
@@ -1291,10 +1281,6 @@ static int st7701_probe(struct device *dev, int connector_type)
 		return PTR_ERR(st7701->reset);
 	}
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &st7701->orientation);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to get orientation\n");
-
 	st7701->panel.prepare_prev_first = true;
 
 	/**
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 70f7282471e6..63c1365c08b0 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -20,7 +20,6 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #define DRV_NAME "panel-sitronix-st7703"
@@ -62,7 +61,6 @@ struct st7703 {
 
 	struct dentry *debugfs;
 	const struct st7703_panel_desc *desc;
-	enum drm_panel_orientation orientation;
 };
 
 struct st7703_panel_desc {
@@ -878,20 +876,12 @@ static int st7703_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static enum drm_panel_orientation st7703_get_orientation(struct drm_panel *panel)
-{
-	struct st7703 *st7703 = panel_to_st7703(panel);
-
-	return st7703->orientation;
-}
-
 static const struct drm_panel_funcs st7703_drm_funcs = {
 	.disable   = st7703_disable,
 	.unprepare = st7703_unprepare,
 	.prepare   = st7703_prepare,
 	.enable	   = st7703_enable,
 	.get_modes = st7703_get_modes,
-	.get_orientation = st7703_get_orientation,
 };
 
 static int allpixelson_set(void *data, u64 val)
@@ -969,10 +959,6 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->iovcc),
 				     "Failed to request iovcc regulator\n");
 
-	ret = drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
-	if (ret < 0)
-		return dev_err_probe(&dsi->dev, ret, "Failed to get orientation\n");
-
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 4d28efeafd64..410bf43175ab 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -14,7 +14,6 @@
 
 #include <drm/drm_device.h>
 #include <drm/drm_modes.h>
-#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #define ST7789V_RAMCTRL_CMD		0xb0
@@ -130,7 +129,6 @@ struct st7789v {
 	struct spi_device *spi;
 	struct gpio_desc *reset;
 	struct regulator *power;
-	enum drm_panel_orientation orientation;
 };
 
 enum st7789v_prefix {
@@ -364,13 +362,6 @@ static int st7789v_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static enum drm_panel_orientation st7789v_get_orientation(struct drm_panel *p)
-{
-	struct st7789v *ctx = panel_to_st7789v(p);
-
-	return ctx->orientation;
-}
-
 static int st7789v_prepare(struct drm_panel *panel)
 {
 	struct st7789v *ctx = panel_to_st7789v(panel);
@@ -601,7 +592,6 @@ static const struct drm_panel_funcs st7789v_drm_funcs = {
 	.disable = st7789v_disable,
 	.enable	= st7789v_enable,
 	.get_modes = st7789v_get_modes,
-	.get_orientation = st7789v_get_orientation,
 	.prepare = st7789v_prepare,
 	.unprepare = st7789v_unprepare,
 };
@@ -641,10 +631,6 @@ static int st7789v_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	ret = drm_of_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
-	if (ret)
-		return dev_err_probe(&spi->dev, ret, "Failed to get orientation\n");
-
 	drm_panel_add(&ctx->panel);
 
 	return 0;
diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
index d0db128cda81..85c1f44691ac 100644
--- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
+++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
@@ -11,7 +11,6 @@
 #include <drm/display/drm_dsc.h>
 #include <drm/display/drm_dsc_helper.h>
 #include <drm/drm_mipi_dsi.h>
-#include <drm/drm_of.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
@@ -22,7 +21,6 @@ struct visionox_vtdr6130 {
 	struct mipi_dsi_device *dsi;
 	struct gpio_desc *reset_gpio;
 	struct regulator_bulk_data *supplies;
-	enum drm_panel_orientation orientation;
 	struct visionox_vtdr6130_desc *desc;
 };
 
@@ -370,18 +368,10 @@ static int visionox_vtdr6130_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
-static enum drm_panel_orientation visionox_vtdr6130_get_orientation(struct drm_panel *panel)
-{
-	struct visionox_vtdr6130 *ctx = to_visionox_vtdr6130(panel);
-
-	return ctx->orientation;
-}
-
 static const struct drm_panel_funcs visionox_vtdr6130_panel_funcs = {
 	.prepare = visionox_vtdr6130_prepare,
 	.unprepare = visionox_vtdr6130_unprepare,
 	.get_modes = visionox_vtdr6130_get_modes,
-	.get_orientation = visionox_vtdr6130_get_orientation,
 };
 
 static int visionox_vtdr6130_bl_update_status(struct backlight_device *bl)
@@ -447,12 +437,6 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = ctx->desc->mode_flags;
 	ctx->panel.prepare_prev_first = true;
 
-	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
-	if (ret < 0) {
-		dev_err(dev, "Failed to get orientation %d\n", ret);
-		return ret;
-	}
-
 	ctx->panel.backlight = visionox_vtdr6130_create_backlight(dsi);
 	if (IS_ERR(ctx->panel.backlight))
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),

-- 
2.47.3

