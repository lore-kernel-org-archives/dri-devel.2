Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC48E10AB830
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48C110EE97;
	Fri, 27 Mar 2026 14:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1FwemYYR";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C76510EE91
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 14:47:02 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id C319E1A301E;
 Fri, 27 Mar 2026 14:47:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8F74460230;
 Fri, 27 Mar 2026 14:47:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 207F91045138A; Fri, 27 Mar 2026 15:46:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774622818; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3cQMpGWhfePuLI1DRAc4OIsyHawvSQuhzTPrg+IGa2c=;
 b=1FwemYYRdkAI9ssSa/55QsZ/bB2rqanJ5E4Fg2SpbQcpbLtcohH1K1kUdJ8OfoVIxyPJQO
 Y4unsvTe+MLYV9+91I57XGH39wmpDjeATZ/GSzr7X1oR0QLaWFyUlMm3Pf/t+ml1HHOe8s
 c4uaqy4Bnpz8CZM9vx/7NJCiCwA6ISUDuwAjIf/nLSm/Cu9gyvVT4FU54di5GSKt1ZU85N
 JI9zSp1A2HDfoyjtY8CG5wZsXdxZyf6V5du1MHxMuC2EMmV1mC0pzJc42gCujs6vrdJAhF
 ugMVTLGN+FCVRzR1baq7udna8LJXPN9VSBQvuTOn5Ezm5p+zm55CpKvslQppUg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 15:46:43 +0100
Message-Id: <DHDNA5HLQPIB.3F21G9QPBUQG8@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 7/8] drm/bridge: imx8mp-hdmi-tx: add an hdmi-connector
 when missing using a DT overlay at boot time
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, "Adam Ford" <aford173@gmail.com>, "Alexander
 Stein" <alexander.stein@ew.tq-group.com>, "Anson Huang"
 <Anson.Huang@nxp.com>, "Christopher Obbard"
 <christopher.obbard@linaro.org>, "Daniel Scally"
 <dan.scally@ideasonboard.com>, "Emanuele Ghidoli"
 <emanuele.ghidoli@toradex.com>, "Fabio Estevam" <festevam@denx.de>,
 "Francesco Dolcini" <francesco.dolcini@toradex.com>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Gilles Talis" <gilles.talis@gmail.com>,
 =?utf-8?q?Goran_Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>, "Heiko
 Schocher" <hs@denx.de>, "Joao Paulo Goncalves"
 <joao.goncalves@toradex.com>, "Josua Mayer" <josua@solid-run.com>, "Kieran
 Bingham" <kieran.bingham@ideasonboard.com>, "Marco Felsch"
 <m.felsch@pengutronix.de>, "Martyn Welch" <martyn.welch@collabora.com>,
 "Oleksij Rempel" <o.rempel@pengutronix.de>, "Peng Fan" <peng.fan@nxp.com>,
 "Philippe Schenker" <philippe.schenker@toradex.com>, "Richard Hu"
 <richard.hu@technexion.com>, "Shengjiu Wang" <shengjiu.wang@nxp.com>,
 "Stefan Eichenberger" <stefan.eichenberger@toradex.com>, "Vitor Soares"
 <vitor.soares@toradex.com>
To: "Liu Ying" <victor.liu@nxp.com>, "Marek Vasut" <marex@denx.de>, "Stefan
 Agner" <stefan@agner.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Li"
 <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Rob
 Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>
X-Mailer: aerc 0.20.1
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
 <20260320-drm-lcdif-dbanc-v1-7-479a04133e70@bootlin.com>
 <544112ab-8ca0-4622-b680-233457198e3e@nxp.com>
In-Reply-To: <544112ab-8ca0-4622-b680-233457198e3e@nxp.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Liu,

On Thu Mar 26, 2026 at 9:15 AM CET, Liu Ying wrote:
> Hi Luca,
>
> On Fri, Mar 20, 2026 at 11:46:18AM +0100, Luca Ceresoli wrote:
>> The imx8mp-hdmi-tx one of many drivers based on dw-hdmi. dw-hdmi in turn
>> can operate in two different modes, depending on the platform data as se=
t
>> by the driver:
>>
>>  A. hdmi->plat_data->output_port =3D 0:
>>     the HDMI output (port@1) in device tree is not used [0]
>>
>>  B. hdmi->plat_data->output_port =3D 1:
>>     the HDMI output (port@1) is parsed to find the next bridge
>>
>> The imx8mp-hdmi-tx driver falls in case A. This implies next_bridge will
>> always be NULL, and so dw_hdmi_bridge_attach() [1] will always fail if
>> called with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
>>
>> In fact case A assumes that DRM_BRIDGE_ATTACH_NO_CONNECTOR is not set an=
d
>> in that case it adds the connector programmatically at bridge attach tim=
e.
>>
>> Support for DRM_BRIDGE_ATTACH_NO_CONNECTOR is implemented by dw-hdmi.c i=
n
>> case B. So, in preparation to support DRM_BRIDGE_ATTACH_NO_CONNECTOR in
>> imx8mp-hdmi-tx, move to case B by setting hdmi->plat_data->output_port =
=3D 1.
>>
>> However this change requires that port@1 is connected to a "next
>> bridge" DT node, typically the HDMI connector, because dw-hdmi won't add
>> the connector when using DRM_BRIDGE_ATTACH_NO_CONNECTOR.
>>
>> Many dts files for imx8mp-based boards in the kernel have such a connect=
or
>> described and linked to port@1, so a connector is added by the
>> display-connector driver along with a bridge wrapping it. Sadly some of
>
> Hmm, display-connector driver is a bridge driver so it cannot add a conne=
ctor.
> I assume that you mean a connector will be added by the bridge connector
> driver.

Indeed, rewording as:

  Many dts files for imx8mp-based boards in the kernel have such a
  connector described and linked to port@1, so the pipeline will be fully
  attached up to a display-connector and a drm_connector added by the
  bridge-connector.

>> --- a/drivers/gpu/drm/bridge/imx/Kconfig
>> +++ b/drivers/gpu/drm/bridge/imx/Kconfig
>> @@ -25,6 +25,23 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
>>  	  Choose this to enable support for the internal HDMI encoder found
>>  	  on the i.MX8MP SoC.
>>
>> +config DRM_IMX8MP_DW_HDMI_BRIDGE_CONNECTOR_FIXUP
>> +	bool "Support device tree blobs without an hdmi-connector node"
>> +	default y
>
> depends on DRM_IMX_LCDIF ?

If the imx hdmi-tx is not enabled then HDMI won't work anyway, so users are
not affected and the overlay is not needed. Am I missing something?

>> +	err =3D of_overlay_fdt_apply(dtbo_start, dtbo_size, &ovcs_id, NULL);
>> +	if (err)
>> +		return err;
>> +
>> +	hdmi_conn =3D of_find_node_by_name(NULL, "fixup-hdmi-connector");
>
> Do you really need to find the node, since the overlay was just applied?

That was to ensure the node is present and error out if it isn't. But
thinking again about it after your question I don't see how it could be
missing if the overlay was successfully applied.

Removing this check in v2, which makes this function a lot simpler!

>> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.d=
tso b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
>> new file mode 100644
>> index 000000000000..ee718ca1b11b
>> --- /dev/null
>> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
>> @@ -0,0 +1,38 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * DTS overlay adding an hdmi-connector node to boards using the imx8mp=
 hdmi_tx
>> + *
>> + * Copyright (C) 2026 GE HealthCare
>> + * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +&{/} {
>
> I see build warnings(W=3D1):
> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:25.8-37.4:=
 Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0: node has a u=
nit name, but no reg or ranges property
> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:26.16-36.5=
: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c00000=
: node has a unit name, but no reg or ranges property
> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:27.18-35.6=
: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c00000=
/hdmi@32fd8000: node has a unit name, but no reg or ranges property
> drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso:29.13-33.8=
: Warning (unit_address_vs_reg): /fragment@0/__overlay__/soc@0/bus@32c00000=
/hdmi@32fd8000/ports/port@1: node has a unit name, but no reg or ranges pro=
perty

AFAIK the device tree checkes just can't work on overlays. The tools just
cannot know on which base tree the overlay can be applied, so they cannot
know the existing properties. That might change in the future, but for now
my understanding is that it is OK to have overlays which produce such
harmless warnings, at least for driver-specific overlays like the tilcdc
one [0] which is already in linux-next since a few weeks.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?id=3D0ff223d991477fa4677dcb0f1fb00065847e2212

> Here is a patch to suppress them:
>
> --- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
> @@ -10,6 +10,9 @@
>  /plugin/;
>
>  &{/} {
> +       #address-cells =3D <2>;
> +       #size-cells =3D <2>;
> +
>         fixup-hdmi-connector {
>                 compatible =3D "hdmi-connector";
>                 label =3D "HDMI";
> @@ -23,10 +26,25 @@ fixup_hdmi_connector_in: endpoint {
>         };
>
>         soc@0 {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges =3D <0x0 0x0 0x0 0x3e000000>;
> +
>                 bus@32c00000 {
> +                       reg =3D <0x32c00000 0x400000>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +
>                         hdmi@32fd8000 {
> +                               reg =3D <0x32fd8000 0x7eff>;
> +
>                                 ports {
> +                                       #address-cells =3D <1>;
> +                                       #size-cells =3D <0>;
> +
>                                         port@1 {
> +                                               reg =3D <1>;
> +
>                                                 hdmi_tx_out: endpoint {
>                                                         remote-endpoint =
=3D <&fixup_hdmi_connector_in>;
>                                                 };

Thanks for taking time to look into how to get rid of the warnings.

However the sheer amount of lines added, by just duplicating lines already
in the base tree and no added value, reinforces my opinion that we should
keep the overlay as simple as it is.

Also, what if one of the property values that your diff is duplicating from
the base tree turns out being wrong in the base tree and gets fixed later
there? The wrong value would be re-added by the overlay unless someone goes
hunting all the duplicated lines around.

Based on this, do you think we really need to get rid of those warnings?

Side note: this discussion made me think about what would happen if
DRM_IMX8MP_DW_HDMI_BRIDGE is enabled on a non-imx8mp board (as for
distribution kernels as mentioned by Laurent). I think it makes sense to
add a check that /soc@0/compatible matches "fsl,imx8mp-soc" and not apply
the overlay otherwise. I'll look into that for v2.

>> +	fixup-hdmi-connector {
>> +		compatible =3D "hdmi-connector";
>> +		label =3D "HDMI";
>> +		type =3D "a";
>
> What if a board uses another type?

For boards affected by this patch, currently the connector is created by
dw_hdmi_connector_create() which hardcodes type A [0], so there would be no
difference.

OTOH how can a common module know the specific connector?

Boards with a different connector should describe the connector in the
device tree, if they need to instantiate the exact type.

[0] https://elixir.bootlin.com/linux/v7.0-rc5/source/drivers/gpu/drm/bridge=
/synopsys/dw-hdmi.c#L2601

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
