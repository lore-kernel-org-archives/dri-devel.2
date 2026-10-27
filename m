Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB0606A337
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E+1n6Gi8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IzDctT+A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C05210F425;
	Tue, 27 Oct 2026 12:03:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B887F10F432
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:02:57 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAeBvt1936092
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=RreJT6OdWgxLLvGlC2N7bmJy
 Um9m4QYaD4O3KtIV+1A=; b=E+1n6Gi8vcyP3M0k3o5Wgql4Sq04nvrDDWa2FIWu
 sLVnyHOl26uyu0ziRm33cusRsQ0idxUnBjgHJ2RO/qvSp1wHmhCKSkhP2PX9UwFl
 D8NaLY/DpIx2crNESacLyxTZ9kQuhMfSxglvu3e1a1oKGG0W6iSjx1gw/r1fp5Xd
 k7OrLdTHpGWvnjK4pATqvpF/9fOaMQ/AzNNTTONZty1mBXLBsphEF0jiM2RS8p4p
 Ry8ZVgJBxRqe4K/+tP9x6nh0kIssyfUW4f+D5JWoBKeWW8s+5tYb+3xWnGf/RmGW
 fXR54qk1SYsBEQyZhnU16D8nBTna1kcthL5pM8W1wcnJSQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjfavtpyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 12:02:56 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9905fc56b60so747145241.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793102576; x=1793707376;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RreJT6OdWgxLLvGlC2N7bmJyUm9m4QYaD4O3KtIV+1A=;
 b=IzDctT+A0OhCG0rIdpU46f9ibe1uyILGuozfcxVeLhh8URenXR/+XJPGjYgwqUhBEv
 WwCzoMY6uzorqko8cRiI/fG3Ri0X9W+FE85fyWCg460kQd41Erc4H1BNdnY62ubpEoG1
 8pWNzP5R4011iVNkHHM7HcvyZznUvSA26QpneOUkfmbLdiS4hEosXp6joxMs2uRP9g9s
 X+zmcVVKe0YpxZesUk3+VgK+h2ZWppuECWwpr9y0CrpskBeplOxHHDLNrv73y57MbWGM
 osWmOd2EVQBZnZgeR3qOPNP3YgOGrBbBKS0OZXFzUd3qEHjwK1/VPFhaMpDVJae6oV0X
 Cf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793102576; x=1793707376;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RreJT6OdWgxLLvGlC2N7bmJyUm9m4QYaD4O3KtIV+1A=;
 b=L7Om+M0VkPaHBRV+msQkfCDdwuekJPBT82vRPp4pV/XabtfRuyTIJ55HrhETHqFTMP
 7MwlajI6Sw0kfJnvsHTPYfMey+8spYN85txFozfZVabyXSpi3M665R4HhWHIfJP8c2vA
 6s2wXY39tcLv/3pNKa+vHyMc5t3xFFXyLdBo4l5BbmHOWc6LZMDJgJN8zILbmou3Adzw
 c4zcEA6s/KB5z+kTvhwuCyODwE+Y7Zk8oQqNwVyeOmAIr737rM/TUwGxtlsZM7v9AdHM
 j7q8RcvPcULvQxT5JIW1LVNh15dCMykUZXJkKLf8Imd5JYrHHlatVUDXCrn0vt/MRUjV
 +YvA==
X-Gm-Message-State: AFq9FYIDaMliSyJ7Ye2O/tlpX+oPhCwuhoIyX3grxa7lV84eaJlYkljV
 Et7eQ3R8Rgiq3Hm1Aa3Xft2rL8JLkXWgwJQaCCX+/IpPYbrxbg9soQAqxRw+5689VVWxsA9xq2p
 vDOLjjvANHQqzZpCRmLvj+ZfxN0luRkE/DKRx/9lnGxYJIqNlGPPhaWhDdldaQv1aDZfrHG0=
X-Gm-Gg: AYBFou2T1NDl9pKL+Yabt92XYBI8oqmMkJsnTA8Ve77POhENtE8SHsUhN1MTjl//gSt
 Ni2Bg+3I5vbXi8au1bHa0M480Qi+LHCVqWOoNT5taVb71jqO2r4gGZ4jyyokGZ4tPQOV2vh/Vkj
 ixaBrImt/bvmDFUmd34ywWP9/giDxWyEe0lZKY6qIZh4Ou4/3mc7SzPPtvA5RE+OW/cqMTUgaBL
 cWn6zdtzuhmzpkDZpMIeR9VGm2ioXiQAIlbDpblmGJgVWjVNcj0hDpcfaQ5Ujack9NMULd1RdLL
 pri7ocAeL0+LtqaXndPlUEUR8MF90UVMjES1vUzKrEH2AxNEypOo9OOFxe0ELlFjdPyJU+iXaIc
 zRIsfIUL/HZJtNo6C+aVL5Nae7xGhuDVkJpXuyWGOpMGkc8LRCC7AYMA3AP972XXB7khHVwsqsd
 jFeJwB2FTbJB6x
X-Received: by 2002:a05:6122:124f:b0:5cf:dd67:cb32 with SMTP id
 71dfb90a1353d-5ec3ea462d5mr652288e0c.6.1793102575666; 
 Tue, 27 Oct 2026 05:02:55 -0700 (PDT)
X-Received: by 2002:a05:6122:124f:b0:5cf:dd67:cb32 with SMTP id
 71dfb90a1353d-5ec3ea462d5mr652238e0c.6.1793102575110; 
 Tue, 27 Oct 2026 05:02:55 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9558esm2089787e87.70.2026.10.27.05.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:02:53 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:02:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
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
 Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
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
Subject: Re: [PATCH 00/35] drm/panel: let the panels use the atomic state
Message-ID: <cxsgo7u2hfb4jskscqcbeaaneiyfh7bdmlvku2wxwtduekwhxz@3vsizgxvekw7>
References: <20261026-drm-panel-funcs-v1-0-5e3070a3478f@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-drm-panel-funcs-v1-0-5e3070a3478f@oss.qualcomm.com>
X-Proofpoint-GUID: C2k69H9pAAmFSBAcsRzFwG5GJhoyBhl0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfX2O3fE5LPJ5IH
 Lu38BmEWRKtRnYJYRC+dHVBhhV4nkIgQGBFD12qFY8CtaDrbqeQbw/HlwZGzgkph4XPltQr7+eZ
 8z6AAkfJk8i/jJXwsXRiSlLVrbGze6U=
X-Authority-Analysis: v=2.4 cv=EIeTQFZC c=1 sm=1 tr=0 ts=6ae092f0 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=dDezlKT4IyV31VqxjHAA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: C2k69H9pAAmFSBAcsRzFwG5GJhoyBhl0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NyBTYWx0ZWRfXxxmcC3RAoyXV
 R7HyedDF8hC7frL4eLEJcF0b84FeoEArBuPLAfAyruocmy3C6Pq5LwZH+ZxEs381nRh3dl+tMRn
 AanyflUJbhzTH4F1sATg93nRdtyimVLGZEXQ/zBhS14WnEfnjKszXbDARGjWuq4peC5HNA0D+pN
 FazMC3S3MSFgdFq7+BN2DIgQfjHzEXibQAhmTvErK3gxHqFCg8rk+2O8XEfVjQ5kyM8EnZkVpcN
 2YWH0Fxsr7KscVW4MCLZuCwuRkmsjn+nBsKUWfdg6AKM/UTjHkhbIfYv2Os0WkstfAWTv45FlRE
 blwLhZcG1LCWybCrkUmsgAtKxGtUhjYVVGv0qBRYJoT8FR51rOBZsownJlHVRmvRzRrwo4Frs3G
 rONgqm+Ddi4NLORaSeUiwBx/lmty85eWEJaph26Hx2L0nZbFXwVUk8sFTDBu9SH+CR2DzbX/oI+
 E2Xr1h20TPPfuP1S7iA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270047
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 01:09:49PM +0200, Dmitry Baryshkov wrote:
> The panel is the only element of the display pipeline which never sees
> the atomic commit. Its prepare() and enable() callbacks get nothing but
> the panel, so a panel which has to be programmed differently depending
> on the mode can only guess it. The NT35950 driver, for example, saves
> the connector in get_modes() and reads connector->state->crtc->state
> while being prepared: without the locks, from the current state rather
> than from the one being committed, and with no way to reject a mode it
> doesn't know.
> 
> Every panel has a struct drm_bridge embedded into it, and the bridge
> already has all the missing parts: atomic_check(), a state object which
> can be subclassed and the commit passed to the callbacks. Rather than
> growing struct drm_panel_funcs into a copy of that, let the panel driver
> provide struct drm_bridge_funcs for the embedded bridge. This is opt-in:
> the panels which have no use for the atomic state keep using struct
> drm_panel_funcs and are not touched by it.
> 
> To get there the bridge callbacks become the entry point to the panel,
> with drm_panel_prepare() and friends calling them rather than the other
> way around. The panel core still has to track the panel state, notify
> the panel followers and handle the backlight, so the driver doesn't fill
> in the power callbacks directly, it wraps its functions with the macros
> doing that part. NT35950 is converted as the first user.
> 
> The bulk of the series is the cleanup of what the panel core and the
> bridge need from the panel driver, so that a panel providing the bridge
> callbacks doesn't need struct drm_panel_funcs for anything:
> 
> - get_timings() had no callers.
> 
> - The connector type was stored both in the panel and in its bridge, and
>   the display drivers could override it while creating the panel bridge.
> 
> - The orientation was read from the DT, stored and returned by nearly
>   identical code in more than twenty panel drivers, and some of them
>   also had to set it on the connector from get_modes(), with a TODO
>   asking for a better place. The core reads it now. It is applied to the
>   connector from the new connector_init() bridge callback, which is not
>   specific to the panels: other bridges have properties to set up on the
>   connector being created too (HDCP, DP link properties), and currently
>   have nowhere to do it.
> 
> - disable() and unprepare() returned an error which nobody could act on.
>   Worse, a failed unprepare() left the panel marked as prepared, so it
>   was never initialised again.
> 
> Behaviour changes worth knowing about:
> 
> - Panels with the rotation property whose driver ignored it now get the
>   orientation property. In the tree this is the Motorola Mapphone panel
>   (panel-dsi-cm).
> 
> - sun6i_mipi_dsi, sti_dvo and the Tegra DSI get their panel after the
>   DRM device has been registered, which is too late to create the
>   property, so they lose the orientation which the panel drivers used to
>   set from get_modes(). None of the rotated panels in the tree are used
>   with them.
> 
> - A panel implementing atomic_check() can only be driven through the
>   bridge chain. The display drivers calling drm_panel_prepare() directly
>   have no commit to pass.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Dmitry Baryshkov (35):
>       drm/panel: remove the get_timings() callback
>       drm/panel: remove the unused struct panel_bridge
>       drm/tidss: get the panel type from the embedded bridge
>       drm/bridge: lvds-codec: use devm_drm_panel_bridge_add()
>       drm/ingenic: use devm_drm_panel_bridge_add()
>       drm: mxsfb: use devm_drm_panel_bridge_add()
>       drm: rcar-du: use devm_drm_panel_bridge_add()
>       drm: rz-du: use devm_drm_panel_bridge_add()
>       drm/mcde: use drm_panel_bridge_add()
>       drm/pl111: use drm_panel_bridge_add()
>       drm/rockchip: lvds: use drm_panel_bridge_add()
>       drm/rockchip: rgb: use drm_panel_bridge_add()
>       drm/panel: remove the _typed() panel bridge functions

Gmail barked at me for sending too many emails for too many recipients
in the middle of the series. I guess, I'll have to split the series into
smaller parts. Please consider reviewing the posted patches, letting me
split / land the series in parts.

>       drm/panel: remove drm_panel.connector_type
>       drm/bridge: anx6345: set the panel orientation on the connector
>       drm/exynos: dpi: set the panel orientation on the connector
>       drm/fsl-dcu: set the panel orientation on the connector
>       drm/logicvc: set the panel orientation on the connector
>       drm/stm: lvds: set the panel orientation on the connector
>       drm/sun4i: set the panel orientation on the connector
>       drm/tegra: sor: set the panel orientation on the connector
>       drm/panel: drop the orientation workaround from get_modes()
>       drm/panel: read the panel orientation in the core
>       drm/panel: use the orientation from the panel core
>       drm/panel: remove the get_orientation() callback
>       drm/bridge: add the connector_init callback
>       drm/bridge-connector: let the bridges set up the connector
>       drm/panel: let the bridges set up the panel connector
>       drm/panel: set the orientation from the connector_init callback
>       drm/panel: make the disable and unprepare callbacks return void
>       drm/panel: don't hold the follower lock over the panel callbacks
>       drm/panel: route the panel calls through the bridge callbacks
>       drm/panel: let the panel drivers provide struct drm_bridge_funcs
>       drm/panel: novatek-nt35950: provide struct drm_bridge_funcs
>       drm/panel: novatek-nt35950: use the atomic state to select the mode
> 

-- 
With best wishes
Dmitry
