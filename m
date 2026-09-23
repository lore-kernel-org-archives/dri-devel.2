Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CBFC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A1F10E87F;
	Wed, 23 Sep 2026 09:38:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.b="Fk5qHw/G";
	dkim-atps=neutral
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C5FB10E87F
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 09:38:38 +0000 (UTC)
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::4e])
 (Authenticated sender: pza@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 48EA120075E;
 Wed, 23 Sep 2026 11:38:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1790156316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2luf5FpXldw90OHT8OQuHmYGfdfhlpHFtUCjoFB6wc=;
 b=Fk5qHw/GwqojBgyM1RAsKEQvGJucuqJl/0K53H7wYOYFLQEsSFQCBZLaR3HVk0JavRUzQx
 BDOaWCv9djjPVI0cvvZ49K5A4QFYTv7ORPCSaPaXhoXxP56e50tVgTIGb1kUxoPXSBkBU6
 GCCOBYj5yGEZVtjV3Q//z8UKXKQ6dMnQRALOqsH6GVAKIq3R0KOISskMJex/xso53LCkD2
 8WChiNSoe6Nh2+l6DMoozM1PUyZ2VajBkETLws1+HMsPxre7dgQhjbpVs3xrzTS5lTcvkP
 yatb8pORlgr/M6vTPbAw6Yv1DjUlEc7MXRLu50JkRqGMLqdFCazS0cU8qDgf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1790156316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2luf5FpXldw90OHT8OQuHmYGfdfhlpHFtUCjoFB6wc=;
 b=IYeUJbujtGMKfxIRx+ZRlWuuIQglCiRl4RXQgNtwRZ1lzJsgig9Te8S+noB+NPNwJ2aMoe
 qkOFQmxHwynWl4EnyticqudML3Cg4fqsqNoWGZgZtsEFrlGwb47pYKb+2MLS+IUdRy/3hU
 CKj5DcbLhYlNiAD2KujUscOdJd0D9+yab3v0tiOo1nCjzg7A13suYmjV4MKKVeWmGbLYZN
 sNQ82kWdjn0E41UhxS/zQTkM2jSu6anePzGxQ0D+PaQU11+WuiZcoeilpueNjFsMemeMB1
 r+q565QdrZ7OOom+c1TpncU7jtTk5bz1EaI+3lUeywuAXBGt1hRvk6TKauOz5A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790156316; a=rsa-sha256;
 cv=none;
 b=LhQiXJpCcP6Ida7LESO4TzKQ2rW8h48dHwyT1Easm9Mf7RsEPcNmfXqqHdFAoiiTX/wIvf
 xuxiakYloC4ZwThB24fkXpkzk+JHi9xFYOFAUBBtPko+JddH80S0vJ1fUXlD6qGcR46v8q
 bv7ualU7GxkuR0nc6d5vUKw/a2ibICzOZFmcBVjMA0YCXK4I7HtngA+st+QsgYxWUvB5tz
 Aj4nujaQKReuzomiMjrPihuriCalMwTsuQA2SPdRqsnN+d1sU3JFCK+z2wBN+ssFKJRXWQ
 sQ8ATgRmyXcxNdGZ9AdImiRfHNhU5zO1nEW5vyyCmuKhlbcuJVhFdQAhGzqOKw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <bbecbfd1c2e465f5daa6476e8555f373a6e1bd0b.camel@pengutronix.de>
Subject: Re: [PATCH v13 10/14] pmdomain: rockchip: cycle optional
 power-domain resets on power-on
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, 	will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 ogabbay@kernel.org, 	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com, 
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai, 
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com, 
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, 	linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, 	linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 11:38:36 +0200
In-Reply-To: <20260915104328.45901-11-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-11-gahing@gahingwoo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
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

On Di, 2026-09-15 at 22:43 +1200, Jiaxing Hu wrote:
> Some Rockchip domains come out of power-on with their bus interface in an
> undefined state. On the RK3576 NPU this shows up as a hang on the first
> register access after the domain is switched on, and pulsing the domain's
> resets at this point clears it.
>=20
> Take the domain node's resets if it has any, and pulse them between

Why 'resets' plural? The binding specifies maxItems: 1.

> releasing idle and restoring QoS. The resets are optional, so domains tha=
t
> do not list any are unaffected.
>=20
> The cycle goes before the settle delay 9/14 adds, not after it. A domain
> that asks for both is asking to settle before the QoS registers answer, a=
nd
> a reset deasserted after the delay would leave nothing between the deasse=
rt
> and rockchip_pmu_restore_qos(). On RK3576 PD_NPU0 and PD_NPU1 ask for bot=
h,
> and the reset they cycle is SRST_A_RKNN0/1_BIU, the bus interface those Q=
oS
> writes go through.
>=20
> It only runs when the domain actually changes state: rockchip_pd_power()
> returns early when the hardware already reads the state being asked for. =
A
> bootloader that leaves the NPU powered would therefore skip both this and
> the delay, which is why 9/14 gives RK3576_PD_NPU need_regulator and force=
s
> the domain off at probe.
>=20
> No in-tree DTS puts resets in a power-domain node today, so every other
> Rockchip SoC takes the optional get's NULL and is unchanged.
>=20
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 39988efd8..6cc8d6efd 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
[...]
> @@ -861,6 +878,14 @@ static int rockchip_pm_add_one_domain(struct rockchi=
p_pmu *pmu,
>  	if (error)
>  		goto err_put_clocks;
> =20
> +	pd->resets =3D of_reset_control_array_get_optional_exclusive(node);

This should be of_reset_control_get_optional_exclusive() if there is
only a single reset.

regards
Philipp
