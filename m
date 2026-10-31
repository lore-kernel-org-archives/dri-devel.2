Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA5606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mym7SJzv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OFRwgywG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9090210E1C8;
	Sat, 31 Oct 2026 16:19:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFAE110E1C8
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:19:45 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VD026n3174201
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=zvoaKP+xUkSGJRscR5IFcdre
 CABepZREPTFbnRV1kJ0=; b=Mym7SJzvPJhBrW8cTjXDr3bK0JGoqkt9BOS67c9H
 AZsqbfCMihN1+Nnb64lqybfcq1t6P3fuqhRNPe4cbhfvNEsAwr+aXeQz7KIiVmOZ
 y6hpGPvDX/0Tm6yC8PcRy37IPLDwoGiLsX/G4SlKxq7/kkk6Ac6MSmXubqc3gwLE
 rVFQ3IeE1FRc3g6As8OjO0KUeklXIsmdvXMj8p12gJosHwJMgVb9r9YHH429jBqQ
 kQrIUFT+6LBDdr/FdpxCEWjLCfqiYFCBXo0lhlwQ6OnNsViWUejIKg1eac7xszF6
 8OcJsSUAO+yAIIg01Iw/gZopm0LimI9h4jcFJYlYQpYKpA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn61fsuu8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:19:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f32050e72so455707385a.1
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793463584; x=1794068384;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zvoaKP+xUkSGJRscR5IFcdreCABepZREPTFbnRV1kJ0=;
 b=OFRwgywGk3oSnubDZ2W2fnzgBxm+eh/IEZ6St4n4Y5gi2pYgzWiYKC5m6Vymwxgev5
 /SXlZ8ooJNIwLIrhrMfocOGPPHfB84ld9YG+oHBEfb4gTiavhJvXeRiDqPE/96z0HeKj
 3mjvrxbrmL9jAvlmj7Un3QjZBjvRPEEfsa5fp6VAc7P4/6G57ibzLqKKpO7SRjcszkDP
 aWU1pZ5Bz3+K4gCDkI/RfHL0UtaOP8tq+gkY2dlO/EuBsbcxkUs2AeNQJfOUJzWWF6Xm
 2GuWHDJauqKIwqICPypti17jf0X0LUdu1HsNSucN2sZ9LM1Wnz/+D9C93fD7yuCndrM1
 Clow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793463584; x=1794068384;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zvoaKP+xUkSGJRscR5IFcdreCABepZREPTFbnRV1kJ0=;
 b=Tvd0Jul2L1bntZT4/Xux9jNEaZQax0aXmAaDohNY8T08E/LWUKKaj38PyCW4njtrOY
 soDstWAvmJsnXZuDFHv4GMm5MvAPlI95rQCE1J2jP9x7OaRpjl1ogXVuGKcCRsKIZZjX
 dnfahwdzAbx/8yAwpcWYOs2p1byZC8hrsuwH98qlqu64kYRYmC8/m9btwcCe7vBgCi/O
 m9Kzv+fZhkPb/Sb+8NFt/2AGjMmUgfOzHnR1OwEFj1F6avU5JOyrHX0FHXpbeD5tV3js
 zoaH1BGoBjT7B7wvF5dJDI/1lZ5YYkvIchkCiZTlz9g/nWmKpS3dc4Mb26f08h6C9yJn
 QQ8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiwoYa4Ruh7VYKEiwdgxAaO9wk8i5GE15nVaQJYWPEhvVjct5oD10eqj0LWNfccqhmzintkg4ql10=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI7IkCzd4q6HDODA7bJrrvGb2p6KkAiH0De5mHR5GTfj+3Y9LVz
 eXOjoQn2K6kdRo8w81Cn8unLGQa/FsJm0QbC/BwngPXhIdt86HBzHTBUrL4ZCststD0n847PNZO
 zPZzNLGLNKRqCZCmVHFmUqmCFezGsVk9EetCVL08C2ZX2kCOHj0YRlQBwqs42ZsrI276oiEk=
X-Gm-Gg: AYBFou2x4arok2wD90ingUmaov+sXi8rs+2g7IiKoW/U/tMpMBmJk54dPep0WTJlO57
 imAlvEsBqZxSjmMpzwwzcNsctkW5OfzqztYUm4vjaPKnBHVbH/4KYbLKORW50bK/K+X019K6Jjs
 N3f6SIRABIPV2kSKl4feH424iBkcd0yz0srZDyISSX88Zbh1ox9TsOMu5TiuXRjf5D/KHwVG6TY
 Ry4Su8O3p3OEGEbYQnaxQ2hvmVy8Njop5HyITwmg1hmQZHuIoOSbZF/zIo/auwFnTdsRnMKvNps
 ErXBvp8YjGQz455z6E2Cli7amA2kzTbEyPHcVX+mpKKVmCXY0r2Tc/dmh8cOvWLhhaK0hC9PsI9
 XY5aP5n2j4t/nUEmK4Nfnh7egFiQzQvK9PS0elHZR71O77iqkquABKr0HWeUcWCunRBBDtzBZoa
 992d3sfbREaHYoTsoz4HYn6XwaXH6TSbkLnZmHrP6R5tB7d8wc5FHCwQw6f29keA==
X-Received: by 2002:a05:620a:1793:b0:93e:5e2c:8c12 with SMTP id
 af79cd13be357-944216f3483mr979228085a.60.1793463584131; 
 Sat, 31 Oct 2026 09:19:44 -0700 (PDT)
X-Received: by 2002:a05:620a:1793:b0:93e:5e2c:8c12 with SMTP id
 af79cd13be357-944216f3483mr979220585a.60.1793463583497; 
 Sat, 31 Oct 2026 09:19:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm12126731fa.20.2026.10.31.09.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:19:42 -0700 (PDT)
Date: Sat, 31 Oct 2026 18:19:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Douglas Anderson <dianders@chromium.org>,
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
 Yedaya Katsman <yedaya.ka@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 15/35] drm/bridge: anx6345: set the panel orientation on
 the connector
Message-ID: <45e2lt2ngv3ozvpapexui5gicabcvhsxfhrwwq3pdakmdiyxnf@mag7bgkjplav>
References: <20261026-drm-panel-funcs-v1-0-5e3070a3478f@oss.qualcomm.com>
 <20261026-drm-panel-funcs-v1-15-5e3070a3478f@oss.qualcomm.com>
 <179344372467.9825.11469688608855257522.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179344372467.9825.11469688608855257522.b4-review@b4>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NSBTYWx0ZWRfXzKslf+7U45qa
 pl710BDJnxwNQS7B+Mz/wguARB6B+jRs/HbZ24pk632NRbZTS72+uU6VnwEmhACX9oHFhe1VAez
 CrIDs/xscI8eEJsU6ncHeI30U7RsERQ=
X-Authority-Analysis: v=2.4 cv=V/LoQuni c=1 sm=1 tr=0 ts=6ae61521 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=1b4m9KtQkR1i_e9s8qgA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 3PhjRpok6RQHgX4q1js3lCUrUfvevE_s
X-Proofpoint-ORIG-GUID: 3PhjRpok6RQHgX4q1js3lCUrUfvevE_s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NSBTYWx0ZWRfX1TfYCsRr/KO/
 YwXjj5d0NualNVrbkUiSRX/ftP1Z0UxQ6RO7aeh+zOKT8Pft/di6bOy5ZAlfWIeDVEES2PdurJr
 y5cMWX/biz6wpEYVgYKMYoza9ko0pyZjYao7B1xzXpbcSuQ7FLFNO7K3KHAYQr6Ph1wrq3PHYtD
 ObHNGjsef0Q/nvi7X8VzSLlw/cgLMeDpTfj6QQWiOZuppu04sN1tQ6byVDszh3Rlf78OTeXUHII
 gYYQnpe5P5USo63e9oVno7vsdH4ku6JDpAZLurvOfZEgN0UMKG3FtYO7BHKnsaoQ+Xvw3jxpJLV
 i9f6YDKrMa/S5g0Asp7wuD9gXpn29DxohVXtRToOrWnwYxef1l73CNpjkYTXSDzG5cMS2LI+u35
 PGsWpX7k1p5uG7uVzPsAydPTcLwzjRZkc0NJmRgl14563JODO19pNinbsUEF591MLJ2tfeA66SW
 nmGPeKrHcWgxsRzDoIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310065
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 11:48:44AM +0100, Luca Ceresoli wrote:
> > The panel is used directly, without the panel bridge, so nothing sets
> > its orientation on the connector apart from the workaround in the
> > get_modes() of some panel drivers, which runs too late.
> >
> > Assisted-by: LLM
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > index 407834a03b63..91ce1a877bf8 100644
> > --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> > @@ -525,6 +525,11 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
> >
> >  	anx6345->connector.polled = DRM_CONNECTOR_POLL_HPD;
> >
> > +	err = drm_connector_set_orientation_from_panel(&anx6345->connector,
> > +						       anx6345->panel);
> > +	if (err)
> > +		goto connector_cleanup;
> 
> Muy understanding is that this driver, and those in patches 15-21, should
> be eventually converted to use the bridge API instead of the panel API, but
> that's a significant work and so for now this small change is enough to get
> to patch 22 (workaround removal).
> 
> Correct?

Yes. Refactoring the drivers to use bridge API is different, bigger
project, which can be undertaken later (or in parallel).

-- 
With best wishes
Dmitry
