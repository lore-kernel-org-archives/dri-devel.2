Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 503E9C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 17:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 218AA10E642;
	Sun, 28 Jun 2026 17:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="yE26HYhm";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EF310E642
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 17:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=lOa9hr9hGQ1OVWLjJuIi7OMpViAhrQPbKPwUJ+q4IOY=; t=1782666059; x=1783875659; 
 b=yE26HYhmcCuZBXMuoG/9zvKV3oiPULAnfYqxOCXOBYB+exIYUfJJEjdEj8JBdj/Z1YNbmPK7v0q
 FijJvQJocSGD0XDfAPx3AKhXkJyFeXwxAQi73BmyuHgsxm55SZ9Y/m2TyufsR0oSwww1B2CoGW1rH
 zFdopOG/XuJ8eTFCdCWE1CWT9o2PPf4Gk4G8YsGfvNwWeDFDXcN+Qt3gOarwJte/91fc3EplHdiuB
 HB2JZ6aw3cr5sK04RNZhn1wV2NWWRhqxDpGrISTnSxJfWPS6kgfHELGjakYEf3R4dl1AjIG45KB77
 m0dY5HngrrdzuUOdEsqTw+VsQhHaIdvAq8zw==;
Date: Sun, 28 Jun 2026 19:00:41 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>, "H.
 Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in
 writes
Message-ID: <20260628190041.4a30f769@kemnade.info>
In-Reply-To: <4cb8a90b-6345-47a8-b15a-a977a33af8b3@gmail.com>
References: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
 <ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
 <20260528190234.4c00b740@kernel.org>
 <37f64c1c-9920-41a6-a8c0-7a84a30c884a@gmail.com>
 <20260528220603.6600d45b@kemnade.info>
 <20260528221912.1771daa4@kemnade.info>
 <4cb8a90b-6345-47a8-b15a-a977a33af8b3@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 29 May 2026 09:26:23 +0300
Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:

> Hi,
> 
> with the following changes:
> 
> user@devuan:/media/user/7b76ddc8-44f5-47b5-af5b-e5e9b5ab39c3/user/linux_openpvrsgx$ 
> git diff drivers/gpu/drm/omapdrm/dss/dsi.c
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c 
> b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index af27339c79f9..8ffcd95c3bc3 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -2199,7 +2199,7 @@ static int dsi_vc_write_common(struct 
> omap_dss_device *dssdev, int vc,
>          int r;
> 
>          if (mipi_dsi_packet_format_is_short(msg->type))
> -               r = dsi_vc_send_short(dsi, vc, msg);
> +               return dsi_vc_send_short(dsi, vc, msg);
>          else
>                  r = dsi_vc_send_long(dsi, vc, msg);
> 
> @@ -3247,21 +3247,6 @@ static int _dsi_update(struct dsi_data *dsi)

do you really need the change from above?
I think it should not be needed with the other changes.
Waiting on short packets seems to work here.

Regards,
Andreas
