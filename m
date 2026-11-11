Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095BE606A8A4
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nf80FLcf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kxKYkoEL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C29810E34E;
	Wed, 11 Nov 2026 17:56:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582C010E34E
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:55:59 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABHtEcU2498813
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bJecVvbaLRg2W6zbI4pyRP6H
 L0WXZDqT9D9QDN12sBo=; b=Nf80FLcf101GVkP6snltycki0xll/7xnV/48Ns50
 Pn6JfTrg5JJI2qyOCN5xgr6MgSFczD7Y78XlCL3jIea8P1Xhh32LyLJe3wInvZ5W
 IoBF9gMqaKu6WfXFiG0hsKvYk1HUu/4ABEG56i7QAtoSu5pkiarIMP3/9HEzhVjZ
 iE7yEX5Ahv6Fk2ha8iMdMXVZbLQ9f3/2riTMHkiphllQzfTEqiLN3xU3cmRPjuLm
 XHa8GcBgecjsP6Ugl9pRzAoAHB/weWDvkGNcufrEguH6EAIAfiguFFGFKYHH3WG6
 QoYEs/L4UjwcROyMJeUwO4A4Dld+tDUrhgK87F8iYCYShg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawkcsq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:55:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f26dd2165so873323385a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794419758; x=1795024558;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bJecVvbaLRg2W6zbI4pyRP6HL0WXZDqT9D9QDN12sBo=;
 b=kxKYkoEL81LaC9by+WOv6zoBI0DE391H7GB6n37G45Ji+tvdW7gayvLmkUcWm8brkQ
 4mdWkng6exogvECVH3I62rXxltV8ES4eDdIt3rJYLK+G3QUqWWCDwteAwrgVQDg5ALnZ
 fvQZyANkHruarf/NiXikKHmltORvPjQyk3mucBWZxoslKWqEmLvo83SSBiENnH4lIcsC
 nR5fvg7TzTddwysII1KtqCKHY7ckgzK4nrsELDn/V9RQHLV+89rKR9/wc3GFuawR8GoB
 kmmllP6zRJipWoUaKd8xwtsPuzUr69wWJhOh7/+oGM9D/DlhCx1bxi+SbzR1nx6SXAuS
 q+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794419758; x=1795024558;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bJecVvbaLRg2W6zbI4pyRP6HL0WXZDqT9D9QDN12sBo=;
 b=AMtdtcgU+B2jHo4VkwHSBHyjJ/BWoFnHvta/YdTDDIeDox+GhXZ2mZOcNXCBzO3Vso
 q1z3CAlBAcJNTSOBjD7jsV55hD4EITjO4weRf+92/N6N+Z8LPjgEwwU3WSoNERwvo4jm
 1JKXn8/AhAYHXbsM7z/mofv7sJ8lk3hnxxcv79myXhTjh8FmCrPo/UvyLPdl7A57+k2u
 q2S7ElRe3nvU35vdJyq6THwsiZN9sdApXK6bnLcomdQGQimdaqApimiK8ctyo9ieSgbB
 eYNExlHjk7WmBa4NK2yCt0aD3chElWdiPr9x0H0XVswfKhGuJQ+V87debOY5555DTCYS
 qTig==
X-Forwarded-Encrypted: i=1;
 AL+hErF0OtE2Y5LxkL1DboMMdNDGA9e7gln+oB4YRVR4EcF7kmGgdAQ1sMJMg5hhZgCpJjkNi/0K/dBC/Z4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8KRUnmD9+2yZ0x9h6mUYLwmXkTs8VudoSlQHi0/bpHOoqUlTpX
 XVvWOMh8yYcRzg6l6I1iQw0Ij4iu0RvzHE3+DI4vdVoKBX3bkLoa9mCujxMltsu+xLVVtDKkMP6
 tpTus+kc7nQ23MtKvS+qFrYLAhdwZ9XUJQzA2a9MCVaQtsp4ztd9diW0kbXvuZq5kwrSaLt0=
X-Gm-Gg: AYBFou3r2gqi7ZfsPg56bTGfMcTOqUZzhRwV/quR49gakiSPYelaY4c5Z+UWRMzJ+ew
 /FuN5dy6g4lBoQUves24V9Yxl5pOKAKsap5N2AUl2BH87n8mU9QgdVJitWHxVurHB6BjfhFwBGL
 6eabXHuhnWOWGQhlxXs0EzAOCjMQLJrt2fF/xOGCxVY+bmsQJp9kdKhEk5azNtCgGvFo7EDVQP6
 HoWJe2kE5wAxgxaQBnhMpeVLAgbnCn0R2ggx7W/BQj9AIQCRB1Mhp0/Q9YC0ufa2guMEWOVEjOd
 PqMui3uwPofLH7j9DmxlEUoHXo8Ulf/GkEQWNxbAjRW5YTS2U6ijqRwZMQ7j5AyAnF32+NgcweB
 r9oDjNCZ6Dphs1VNGU4AI8se0Zev6SM8SUoKUvbBe8rVxGeVL6NahukQjLzZoZe/y+dgWm7pbBZ
 v9vDH8t7PinogA8L6Pz6Rq76e8ur9ShqfUYrd8mx4ErydojHCSQdTH70X/ic0Xmg==
X-Received: by 2002:a05:620a:2544:b0:93f:3829:8492 with SMTP id
 af79cd13be357-947b006ea1cmr485343985a.78.1794419757368; 
 Wed, 11 Nov 2026 09:55:57 -0800 (PST)
X-Received: by 2002:a05:620a:2544:b0:93f:3829:8492 with SMTP id
 af79cd13be357-947b006ea1cmr485336585a.78.1794419756700; 
 Wed, 11 Nov 2026 09:55:56 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae177150c8sm4479411fa.40.2026.11.11.09.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:55:54 -0800 (PST)
Date: Wed, 11 Nov 2026 19:55:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Romain TISSERAND <romain.tisserand@gmail.com>
Subject: Re: [PATCH] dt-bindings: display: panel: Make DSI panels port optional
Message-ID: <dki5db5xizrwwijmjbnbx7irg6if24l7punctr2wx35j4toi5c@4rip7azwzt2k>
References: <20261111110338.81717-2-krzysztof.kozlowski@oss.qualcomm.com>
 <avRM_GhtR8vMdTO4@houat>
 <c8dea6ad-ce41-44d2-96ab-233b0a4b1340@oss.qualcomm.com>
 <43373a9e-9ff3-4641-b961-b63f4de21cb9@oss.qualcomm.com>
 <oubzclitudtqiv64wvg5lvxvbhuffxmc5bgbsdz4ou24pfhbb4@decarhvjzl2a>
 <0f2c0eae-ed05-41a2-8688-e4b6fe1b7ff3@oss.qualcomm.com>
 <avRy_D6MTK5u01_9@houat>
 <8a557bae-42ae-42bd-a149-cf854b7af9d5@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a557bae-42ae-42bd-a149-cf854b7af9d5@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX5OLtIEvqZNz5
 x+uWeMMZqwAtx1wO/8OPFdJEDfll3rdkER4AFuVkM21Z4wgyL1sJBt7PpfUJfuNlBhdbNWdQGil
 vkRLoDbTJt8B8h2osWJ8a280L2MprVA=
X-Proofpoint-ORIG-GUID: 0uMnDGEKZz7YvayXO6ZTZbuuSTxZcJbC
X-Proofpoint-GUID: 0uMnDGEKZz7YvayXO6ZTZbuuSTxZcJbC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfXwbdHL0QXohOp
 eFb+z9VbhRm2bjTXr9TptvMt5uCNps9qptlildV9b4EAKYCuTPrhuKY4MC0FEi0OOFeuE/xxBj4
 LQnD63zrhVMgC67JbxPKYukY4Bqypi/yd9jEEZy+Pu4QkHRk4ckuBLmD+SQEARffBts2BEwDroB
 Xd2E7ndb+1RWjSPIfFe3BvuvY1O8Q0BnW3aSrOwWy1s9P2tMr32JVpsWznCYGhu+OgrWEaGDvxh
 Lcguvd5qWf4Tk50cOfWXwrTuJR9wOYt+zuDe4gOJZxhowq9hAFzCA3DQKfRhOKzrTBMF+8WuZrX
 ox/9Snix+qzrmkDMw5zpMWo/hctUQvBFfvQooVZynVton8J5BQhh7jzBDx607SZMK8w10Qayuyx
 r+sjsyxpznnnzrn+8Npt9AYFfdKyr9N5vbsL43P8RKPeiW2WoL8JHhOXXNenPLQWeDf2uY0VKcp
 2KVmLGTkHsdo/sGQ5Hw==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af4ac2e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=b1Xqci6IJw76lUnxh3wA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110071
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 02:54:54PM +0100, Krzysztof Kozlowski wrote:
> On 11/11/2026 14:52, Maxime Ripard wrote:
> > On Wed, Nov 11, 2026 at 01:44:23PM +0100, Krzysztof Kozlowski wrote:
> >> On 11/11/2026 13:37, Dmitry Baryshkov wrote:
> >>> On Wed, Nov 11, 2026 at 01:31:39PM +0100, Krzysztof Kozlowski wrote:
> >>>> On 11/11/2026 13:30, Krzysztof Kozlowski wrote:
> >>>>> On 11/11/2026 12:13, Maxime Ripard wrote:
> >>>>>> On Wed, Nov 11, 2026 at 12:03:39PM +0100, Krzysztof Kozlowski wrote:
> >>>>>>> DSI panels can be placed under DSI bus directly and many Linux DRM
> >>>>>>> drivers will work fine with it: mipi_dsi_host_register() adds device for
> >>>>>>> such panel and DRM driver does not use OF graph to configure lanes.
> >>>>>>
> >>>>>> That's not true. We do use the endpoints to configure the lanes through
> >>>>>> the data-lanes property. See drm_of_get_data_lanes*
> >>>>>
> >>>>> Some drivers use endpoints, some not. As discussed on other thread,
> >>>>> there are more than which do not.
> >>>>
> >>>> "there are more than one which do not."
> >>>
> >>> Which means that those should be fixed. We have legacy cases where the
> >>> drivers assumed that, but we should not target legacy.
> >>
> >> These legacy drivers work fine for 10 or 15 years, like Exynos.
> >>
> >> You can improve them, for sure, but if no one does that then requiring a
> >> graph is a mistake there, from the panel point of view.
> > 
> > At the very least the commit log needs some work then, because the
> > situation you describe in it is simply wrong, and quite different to the
> > situation you then described.
> 
> 
> Commit msg said:
> "many Linux DRM drivers will work fine with it"
> 
> So many->some? Is this the only problem? What else is not described in
> commit msg?

The commit message points out that a minority of drivers use and require
the port, while majority of the drivers don't. I think up to now only
the Exynos and sunXi were mentioned. From my point of view, it would be
better to change corresponding DSI host bindings to allow port bindings
and then define the OF graph connecting DSI host to DSI panel (which
might be done gradually, etc.) even if the OF graph is not used nowadays
by those drivers instead of providing a false signal that it's okay to
have DSI links without OF graph connection. It's not future-proof and
not okay, especially for the new designs.

-- 
With best wishes
Dmitry
