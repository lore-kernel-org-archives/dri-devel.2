Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D26C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:40:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB9DB10EE15;
	Wed, 22 Jul 2026 14:40:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="kwtFnuNn";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4377F10EE15
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1784731225;
 bh=RD31tW8LmUG6AZAI01B0tujYL1MNyoRdlJ5f+ELAs0g=;
 b=kwtFnuNng8ib30FqEsJtBwlqWKqy0TO9GBQMxyq9CC5BsNhdkw0VwwzJP4Zw9kzfsm+2zelxc
 HU/m/XJvaIFbfjqMLy9WnL/TYUgegFzFcDlnEGVeYnHLps8h3DCBAC32U7RzsOhZZpQGh9ym2E5
 V4kA2uPX+TXdmKEq2Gx0dfoQMEdLV+5sevaXv+1v1AmEoR+8OzlgzUqbD+nCXHqDP2UgPgoGFFL
 38TRj8/wqHDyTu55eFw/dj1WuYjL+6PWB8+D9ZnchMugreY/Gc/EhgTuYEzEQk0vJXaqKbAWtmu
 4e3/xW2NAz8sUp1UHR/PzE0dMQrJh4qxUFEkaWgxfsbQ==
X-Forward-Email-ID: 6a60d65708d8c87d01d8a86f
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.12.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Wed, 22 Jul 2026 10:40:22 -0400
Message-Id: <DK56F0N1D7ZA.1IYP6RGCYDI3T@ubuntu.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [PATCH] drm/vkms: Advertise PREMULTI blend mode
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Michail Tatas" <michail.tatas@gmail.com>, <louis.chauvet@bootlin.com>,
 <simona@ffwll.ch>, <melissa.srw@gmail.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <hamohammed.sa@gmail.com>,
 <maarten.lankhorst@linux.intel.com>
X-Mailer: aerc 0.21.0
References: <al1pElMQZsDfpAYI@michalis-linux>
In-Reply-To: <al1pElMQZsDfpAYI@michalis-linux>
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

On Sun Jul 19, 2026 at 8:17 PM EDT, Michail Tatas wrote:
> Since we only support pre-multiplied alpha blend mode,
> advertise that, otherwise validate_blend_mode_for_alpha_formats()
> will throw a WARN.
>
> Reported-by: syzbot+6245cb95ae707991bffa@syzkaller.appspotmail.com
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
> ---
>
> syzbot link: https://syzkaller.appspot.com/bug?extid=3D6245cb95ae707991bf=
fa
>
>  drivers/gpu/drm/vkms/vkms_plane.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index 68cb2a3335e6..a2e5ebee729a 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -246,6 +246,12 @@ struct vkms_plane *vkms_plane_init(struct vkms_devic=
e *vkmsdev,
>  					  DRM_COLOR_YCBCR_BT601,
>  					  DRM_COLOR_YCBCR_FULL_RANGE);
> =20
> +	/* Since our composer only supports pre-multiplied alpha,
> +	 * advertise only the PREMULTI blend mode.
> +	 */
> +	drm_plane_create_blend_mode_property(&plane->base,
> +					BIT(DRM_MODE_BLEND_PREMULTI));
> +
>  	if (vkms_config_plane_get_default_pipeline(plane_cfg))
>  		vkms_initialize_colorops(&plane->base);
> =20

Hi,

Unfortunately, this still causes the warning on my machine. In my
config CONFIG_DRM_VKMS is not set.

-Josh
