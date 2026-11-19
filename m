Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4D606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0241124C2;
	Thu, 19 Nov 2026 14:37:52 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F8C1124C2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:37:50 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.23])
 by APP-01 (Coremail) with SMTP id qwCowAD3HvmnCf9qfRVHAQ--.3665S2;
 Thu, 19 Nov 2026 22:37:28 +0800 (CST)
Message-ID: <74dd76a7dd4fb3e627b22833b19fad70e52bf3e1.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: fix cmd mode transition when
 disabling
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart	 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ondrej Jirman <megi@xff.cz>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Thu, 19 Nov 2026 22:37:27 +0800
In-Reply-To: <20261030055806.4102994-1-zhengxingda@iscas.ac.cn>
References: <20261030055806.4102994-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: qwCowAD3HvmnCf9qfRVHAQ--.3665S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4fJw4UAry7Kw1rJF4fKrg_yoWrJF1kpF
 W2qw1ftrZ8XF4q9as7uF48Jr15Was8t395tr98G3WIvwnY93WUX3WvkrZ3XFyUWFy8Ar13
 AFn7Jry8Cas7AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
 1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x07betCcUUUUU=
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-10-30=E4=BA=94=E7=9A=84 13:58 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> With pre_enable_prev_first flag set, the atomic_post_disable hook of the
> next bridge (which should be the DSI panel bridge and calls panel
> unprepare hook) is called before the hook of the DSI controller bridge,
> which leads to the switch to command mode happening after the panel
> unprepare. In this case some panels' unprepare hooks sliently fails
> because they expect the DSI controller to be in command mode.
>=20
> As the DSI controller atomic_disable hook happens after panel bridge
> atomic_disable but before panel bridge atomic_post_disable, it seems to
> be a good position for the transition to the command mode.
>=20
> Move the mode transition from the atomic_post_disable hook to a newly
> created atomic_disable hook.
>=20
> Fixes: 05aa61334592 ("drm: bridge: dw-mipi-dsi: Fix enable/disable of DSI=
 controller")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Ping, would anyone take a look at this patch?

> ---
> Tested on Lichee Console 4A with a pending glue driver for T-Head TH1520
> DW MIPI DSI. This device has a always-powered panel (no switchable
> supply and no reset pin), so correct execution of unprepare commands is
> critical.
>=20
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/=
drm/bridge/synopsys/dw-mipi-dsi.c
> index 5dd475fcaacf8..49b6228ca69e5 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -944,14 +944,6 @@ static void dw_mipi_dsi_bridge_post_atomic_disable(s=
truct drm_bridge *bridge,
>  	struct dw_mipi_dsi *dsi =3D bridge_to_dsi(bridge);
>  	const struct dw_mipi_dsi_phy_ops *phy_ops =3D dsi->plat_data->phy_ops;
> =20
> -	/*
> -	 * Switch to command mode before panel-bridge post_disable &
> -	 * panel unprepare.
> -	 * Note: panel-bridge disable & panel disable has been called
> -	 * before by the drm framework.
> -	 */
> -	dw_mipi_dsi_set_mode(dsi, 0);
> -
>  	if (phy_ops->power_off)
>  		phy_ops->power_off(dsi->plat_data->priv_data);
> =20
> @@ -1058,6 +1050,20 @@ static void dw_mipi_dsi_bridge_atomic_enable(struc=
t drm_bridge *bridge,
>  		dw_mipi_dsi_set_mode(dsi->slave, MIPI_DSI_MODE_VIDEO);
>  }
> =20
> +static void dw_mipi_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
> +					      struct drm_atomic_commit *state)
> +{
> +	struct dw_mipi_dsi *dsi =3D bridge_to_dsi(bridge);
> +
> +	/*
> +	 * Switch to command mode before panel-bridge post_disable &
> +	 * panel unprepare.
> +	 * Note: panel-bridge disable & panel disable has been called
> +	 * before by the drm framework.
> +	 */
> +	dw_mipi_dsi_set_mode(dsi, 0);

Sashiko says that the secondary controller needs to be put into command
mode too, is it the case?

If it is, I would add it to this hunk (although it's previously not
present).

Thanks,
Icenowy

> +}
> +
>  static enum drm_mode_status
>  dw_mipi_dsi_bridge_mode_valid(struct drm_bridge *bridge,
>  			      const struct drm_display_info *info,
> @@ -1098,6 +1104,7 @@ static const struct drm_bridge_funcs dw_mipi_dsi_br=
idge_funcs =3D {
>  	.atomic_create_state		=3D drm_atomic_helper_bridge_create_state,
>  	.atomic_pre_enable	=3D dw_mipi_dsi_bridge_atomic_pre_enable,
>  	.atomic_enable		=3D dw_mipi_dsi_bridge_atomic_enable,
> +	.atomic_disable		=3D dw_mipi_dsi_bridge_atomic_disable,
>  	.atomic_post_disable	=3D dw_mipi_dsi_bridge_post_atomic_disable,
>  	.mode_set		=3D dw_mipi_dsi_bridge_mode_set,
>  	.mode_valid		=3D dw_mipi_dsi_bridge_mode_valid,

