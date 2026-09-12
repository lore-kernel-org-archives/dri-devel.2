Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8743C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0846F10E4DC;
	Sat, 12 Sep 2026 12:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="0nwgTC0r";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAB910E4DC
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 12:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=Fv7tj6aG8jAawVe8iLzkv+Y6H9ZiYdHzOwXKk3pLt+A=; b=0nwgTC0r4UbwJjdY6W4Hyd3tO6
 s62DWq4AZit8moZw4HOICLlyD6ZEVDDksbgZo5P2q/U0SP/8CvkfXVSjKjsE+gMTVF9UyyT67Ur0C
 x8rYYoNDyk3ahNVczWODpy4kvCBC2XuxQVCrcsY5eC5AFI7lr9lXTj4kB09gcv5cpXKG8t/GzDdpj
 6N4uU6vmWI1N/MgkdGvI1ziSMQ8umzZIF0FzM1lIs56EYkvM8TMDvWAny/GQBVni8XuLaeFQ5dNnn
 /6w6DJd6jPLBt1KpmXiACZ0qMJbPMCXZy7MOapqqyMZEtYrQvspHn0iLJ9FeSYuuySQ0OjuN+WSm0
 MJWif9Bw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chaoyi Chen <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH v4 1/3] drm/rockchip: dsi: Add maximum per lane bit rate
 calculation
Date: Sat, 12 Sep 2026 14:32:56 +0200
Message-ID: <9674763.CDJkKcVGEf@phil>
In-Reply-To: <20260812073002.328-2-kernel@airkyi.com>
References: <20260812073002.328-1-kernel@airkyi.com>
 <20260812073002.328-2-kernel@airkyi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Am Mittwoch, 12. August 2026, 09:30:00 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Chaoyi Chen:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>=20
> Different chips have varying support for the maximum bit rate per lane.
>=20
> Add calculation for the maximum per lane bit rate for various chip
> platforms.
>=20
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>

[...]

> @@ -573,6 +574,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
>  	unsigned long _fbdiv, best_fbdiv;
>  	unsigned long min_delta =3D ULONG_MAX;
> =20
> +	max_mbps =3D dsi->cdata->max_bit_rate_per_lane / USEC_PER_SEC;

As the value is called max_bit_rate_per_lane, I guess Sashiko
is correct in that the max_mbps check should use "<=3D" ?


Heiko


