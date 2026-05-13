Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2B7CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 19:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DD610F018;
	Wed, 13 May 2026 19:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="mOmLSYuV";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="rO5/iAd4";
	dkim-atps=neutral
X-Greylist: delayed 563 seconds by postgrey-1.36 at gabe;
 Wed, 13 May 2026 19:18:37 UTC
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F54610ED2C
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 19:18:37 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id EFEC51400202;
 Wed, 13 May 2026 15:12:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 13 May 2026 15:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1778699553;
 x=1778785953; bh=q25iakKJmoiLl9H91Yu810a7GAJsYzUQnoytW7Rifzo=; b=
 mOmLSYuVf1SKMa+Hc049Tj0N5dPni9zcm/w1GpSfsSz15bbQzpTrFayarRKJS3g9
 w595BPWtz88ZW9QHRALbr/+U4yvjdmyffghfxnv/ubVfUSQ+cPlNCQunAaWY6t8N
 RXJciVOSsgiBCVZ/10PgC9wcoGV2udh5bQKSJs815dYR0m/NIlyxIdAKxyq3X/F+
 x1enye8PSM/iRrjZiHbPo+b+X2DMR0JkA+qBupZm0LyWmpS9kuOFV8cI44YjgEh7
 dqQzvgiOag0tkRp7rSIWW76QeTOmFZrt0zGfh/JJqTV85WjquP9IvhDJqEkOQCYG
 L190/VxzOL3zFyEOfgF+YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778699553; x=
 1778785953; bh=q25iakKJmoiLl9H91Yu810a7GAJsYzUQnoytW7Rifzo=; b=r
 O5/iAd49HVicS6gY7ZgkGBdMmny4vcZBR+Yl24ivbtDu8uQnxFOB6iEdLVBF/DL3
 jabUncjkYrjogSPRvnyJm4ms6XO7lwnxKvvpgK16J1A/Ld/3XXZQ6GsHWMxTRM+Q
 fRvj7/5ZEXYBLsgJF4TPJseCxOCL+l2Sv4+jEEgWX4o82hT9CjRD6NjfK/ieySoz
 8z6kinX40q0zqEW3tF0NfuRxzNHVp39YicoPh2NotmPpW/pe/BcnblGi7WHeaB97
 H34aHo9wKK9APcnhzSxVWiky0s03/ztDiy9XE1kt2d7p8qeWec85NEnzrsb212Q9
 Niv928dFfx5p+D57jwkRg==
X-ME-Sender: <xms:Ic0EaqL_VM7CR413NB8Cah9SPxYPheKo_kMRsRwW5Uc7Lkbtes5J8w>
 <xme:Ic0EautKANVu7hLK8E24SuhktluVRrxmnUM8zPfsL-FmAPinW6aSmUSCQcI6CGws7
 lM__d51CNnWjcGsJHjFL0t3-dLYzeCHefOMbXtsJ_bRZSpJC38J8Og>
X-ME-Received: <xmr:Ic0EavJAuUJcYhUGhhrV9yyedf8sSJ0bd6HwKoZ3AF2OT5xJUrx6cwoo1n9OzkuXJaTMaYLH5n49pjKEqZYUaUjEaoOvhnAm3bJC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdehgeeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhklhgr
 shcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrg
 htvggthhdrshgvqeenucggtffrrghtthgvrhhnpeevteegtddvvdfhtdekgefhfeefheet
 heekkeegfeejudeiudeuleegtdehkeekteenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhn
 rghtvggthhdrshgvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprh
 gtphhtthhopehlrghurhgvnhhtrdhpihhntghhrghrthdorhgvnhgvshgrshesihguvggr
 shhonhgsohgrrhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqmhgvughirgesvhhgvg
 hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhs
 rdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgvnhgvsh
 grshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhmihdr
 vhgrlhhkvghinhgvnhesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepkh
 hivghrrghnrdgsihhnghhhrghmsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphht
 thhopegsihhjuhdruggrshdrjhiisegsphdrrhgvnhgvshgrshdrtghomhdprhgtphhtth
 hopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehf
 fhiflhhlrdgthh
X-ME-Proxy: <xmx:Ic0EamMUx8SmCtBv4f2uoVmzCwXhUsVDiaAl8qOVAZhFXbYf2ELxPw>
 <xmx:Ic0EaiV4dqaJJ0BJ3GrreUd8SJ6vMTlsgiVOODIFY1ronnwy7MSDHQ>
 <xmx:Ic0EakndgAH46b1qoftMd2_ydxh8CkOvw0aOXtpiJ66Rn5tm5o65TQ>
 <xmx:Ic0EahM3uksMmAFkh5tFbCCGhHiJRgkXa0nSVFgs5TLvbhi2c1hI9A>
 <xmx:Ic0EapRKixxPUGevE0rM5GBiIVe3HLvZD5ukfV4aWKvrAP0L4YmrcwaX>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 15:12:33 -0400 (EDT)
Date: Wed, 13 May 2026 21:12:32 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 03/11] drm: renesas: rcar-du: Switch to new VSP API
Message-ID: <20260513191232.GF332351@ragnatech.se>
References: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260511235637.3468558-4-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511235637.3468558-4-laurent.pinchart+renesas@ideasonboard.com>
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

Hi Laurent,

Thanks for your work.

On 2026-05-12 02:56:27 +0300, Laurent Pinchart wrote:
> The vsp1_du_setup_lif() function is deprecated. Use the new
> vsp1_du_enable() and vsp1_du_disable() functions instead.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> index a4a49dcd8233..5cfb4d50bc67 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
> @@ -87,12 +87,12 @@ void rcar_du_vsp_enable(struct rcar_du_crtc *crtc)
>  
>  	__rcar_du_plane_setup(crtc->group, &state);
>  
> -	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
> +	vsp1_du_enable(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
>  }
>  
>  void rcar_du_vsp_disable(struct rcar_du_crtc *crtc)
>  {
> -	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, NULL);
> +	vsp1_du_disable(crtc->vsp->vsp, crtc->vsp_pipe);
>  }
>  
>  void rcar_du_vsp_atomic_begin(struct rcar_du_crtc *crtc)
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 

-- 
Kind Regards,
Niklas Söderlund
