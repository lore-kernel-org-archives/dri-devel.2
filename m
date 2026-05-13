Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA860CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 19:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748D310F019;
	Wed, 13 May 2026 19:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="LKQv8VEB";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="nAAVujk1";
	dkim-atps=neutral
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BE410F016
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 19:18:37 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 3093214001DA;
 Wed, 13 May 2026 15:09:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Wed, 13 May 2026 15:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1778699352;
 x=1778785752; bh=dUE4QjuDvAG3ZYTCQ2+yRiAVPToiCx1/5ddNt3VIM/s=; b=
 LKQv8VEBWtcH2qa80Lj975XxxOnoZDKgarju4CBGDgIAYYHohn3L2QV8k41iFcST
 06iTjmn05bL9GOESaNEyDnt8mTPJDd2N+EE2zLCqwO7q5JYehDruXfme6ZH3HYHW
 udYOrqlJ+XHx4G6z5Uf/lf3H5jSRquucue6s1kYcyhyOqec92kLRbMKNsGPxS9d2
 A66vIq7yjjCfYSi0+Fj40iJotATJjFuxR/GpIt4ngYKF6w2EqWmtlN7DrBE+K75z
 EvFBUl2fsNyLK1Y4knG+Cl/I8u5+xur8jiwJYlahxtZM8SrqhHiTqz1IhdEGRbx9
 9xjjekHzNGXVPt6hmR736w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778699352; x=
 1778785752; bh=dUE4QjuDvAG3ZYTCQ2+yRiAVPToiCx1/5ddNt3VIM/s=; b=n
 AAVujk1XxOJ8W62GwtM8KxoXEs8zp6DhiwqisrBVYnWdVFMWPhrbdj+67i8+1/AJ
 botKkj9iGiLtwE9kZwmFPoiaeTAjCKHFjT+DeDZySEwmWlgxU5IYoNS2yUsATvqP
 AbaAPubkk9QeYgT7pfSfOYoZvjPsF2sPmLtcj7DLvKQMQfGDhfWLR2PfD+fY4Doo
 LAEAf8O0LbtqE8xJWuufbHjgjRZOlLpzS6G4t7tm078PsirLDFLm8lloN7f8mW1R
 rVUvdX6ea8ppPuDPUW4jldxbxBrnl36qSVszLMrZJb80fnSYBPFvdCWeRdxWPG4y
 rokFRpaYIUaUdDR/BmPDQ==
X-ME-Sender: <xms:V8wEalQwTgDDDEEbidvncfICfgAhWLNBd2FJ4ieO4sLxL4fIU5M4dw>
 <xme:V8wEarXy8T3Dl2BMyUOWFOgEKtuchqM5vWD5FuEsJRVRa1DFLTtJttHPBZxnF3dwk
 F_Lp6AWAXEI-aw7nZF5baGj5NyFiWaVe0xGpadW0wyf1aL43RWD4PE>
X-ME-Received: <xmr:V8wEavQtlej87VM0uuJ9hrfoOE1nAsb-VFr4U10PTzjAX81KW7_CQvbvNBspzzDB7rwa7WWGDk8iouBl0SQ_WtFMoMSBr1Vjo9zC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdehgeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhklhgr
 shcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugesrhgrghhnrg
 htvggthhdrshgvqeenucggtffrrghtthgvrhhnpeevteegtddvvdfhtdekgefhfeefheet
 heekkeegfeejudeiudeuleegtdehkeekteenucevlhhushhtvghrufhiiigvpedunecurf
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
X-ME-Proxy: <xmx:V8wEaj3KMjQZEyrlY6kn8MNEuzmeMnIRXPIDhZl2Ezfnu5XCAlDiSw>
 <xmx:V8wEavfBrI0gsD6G2quoECSdIybbYoKy3d2imLvYRjGUfFHWdwE8lg>
 <xmx:V8wEarP3iGOdVwDazoVs5M9Hx974LSUhTBSFYhrIYT0588jn8DYOyw>
 <xmx:V8wEajWyoJaJh6PzUJh8fHbmjJ3Gd6peHHBcKBXgif_x6bu_sajKng>
 <xmx:WMwEagege9GecuXMGeRaihZ-u6-wQJCz3RJ70Js_tIWwzwksbQNLT3YS>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 15:09:11 -0400 (EDT)
Date: Wed, 13 May 2026 21:09:09 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 01/11] media: renesas: vsp1: Avoid forward function
 declaration
Message-ID: <20260513190909.GD332351@ragnatech.se>
References: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260511235637.3468558-2-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511235637.3468558-2-laurent.pinchart+renesas@ideasonboard.com>
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

Thanks for your patch.

On 2026-05-12 02:56:25 +0300, Laurent Pinchart wrote:
> Reorder functions to avoid the forward declaration of the
> vsp1_du_pipeline_configure(). No functional change intended.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  .../media/platform/renesas/vsp1/vsp1_drm.c    | 90 +++++++++----------
>  1 file changed, 44 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drm.c b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
> index 15d266439564..79b85968b061 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_drm.c
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
> @@ -57,6 +57,50 @@ static void vsp1_du_pipeline_frame_end(struct vsp1_pipeline *pipe,
>   * Pipeline Configuration
>   */
>  
> +/* Configure all entities in the pipeline. */
> +static void vsp1_du_pipeline_configure(struct vsp1_pipeline *pipe)
> +{
> +	struct vsp1_drm_pipeline *drm_pipe = to_vsp1_drm_pipeline(pipe);
> +	struct vsp1_entity *entity;
> +	struct vsp1_entity *next;
> +	struct vsp1_dl_list *dl;
> +	struct vsp1_dl_body *dlb;
> +	unsigned int dl_flags = 0;
> +
> +	vsp1_pipeline_calculate_partition(pipe, &pipe->part_table[0],
> +					  drm_pipe->width, 0);
> +
> +	if (drm_pipe->force_brx_release)
> +		dl_flags |= VSP1_DL_FRAME_END_INTERNAL;
> +	if (pipe->output->writeback)
> +		dl_flags |= VSP1_DL_FRAME_END_WRITEBACK;
> +
> +	dl = vsp1_dl_list_get(pipe->output->dlm);
> +	dlb = vsp1_dl_list_get_body0(dl);
> +
> +	list_for_each_entry_safe(entity, next, &pipe->entities, list_pipe) {
> +		/* Disconnect unused entities from the pipeline. */
> +		if (!entity->pipe) {
> +			vsp1_dl_body_write(dlb, entity->route->reg,
> +					   VI6_DPR_NODE_UNUSED);
> +
> +			entity->sink = NULL;
> +			list_del(&entity->list_pipe);
> +
> +			continue;
> +		}
> +
> +		vsp1_entity_route_setup(entity, pipe, dlb);
> +		vsp1_entity_configure_stream(entity, entity->state, pipe,
> +					     dl, dlb);
> +		vsp1_entity_configure_frame(entity, pipe, dl, dlb);
> +		vsp1_entity_configure_partition(entity, pipe,
> +						&pipe->part_table[0], dl, dlb);
> +	}
> +
> +	vsp1_dl_list_commit(dl, dl_flags);
> +}
> +
>  /*
>   * Insert the UIF in the pipeline between the prev and next entities. If no UIF
>   * is available connect the two entities directly.
> @@ -224,8 +268,6 @@ static int vsp1_du_pipeline_setup_rpf(struct vsp1_device *vsp1,
>  /* Setup the BRx source pad. */
>  static int vsp1_du_pipeline_setup_inputs(struct vsp1_device *vsp1,
>  					 struct vsp1_pipeline *pipe);
> -static void vsp1_du_pipeline_configure(struct vsp1_pipeline *pipe);
> -
>  static int vsp1_du_pipeline_setup_brx(struct vsp1_device *vsp1,
>  				      struct vsp1_pipeline *pipe)
>  {
> @@ -541,50 +583,6 @@ static int vsp1_du_pipeline_setup_output(struct vsp1_device *vsp1,
>  	return 0;
>  }
>  
> -/* Configure all entities in the pipeline. */
> -static void vsp1_du_pipeline_configure(struct vsp1_pipeline *pipe)
> -{
> -	struct vsp1_drm_pipeline *drm_pipe = to_vsp1_drm_pipeline(pipe);
> -	struct vsp1_entity *entity;
> -	struct vsp1_entity *next;
> -	struct vsp1_dl_list *dl;
> -	struct vsp1_dl_body *dlb;
> -	unsigned int dl_flags = 0;
> -
> -	vsp1_pipeline_calculate_partition(pipe, &pipe->part_table[0],
> -					  drm_pipe->width, 0);
> -
> -	if (drm_pipe->force_brx_release)
> -		dl_flags |= VSP1_DL_FRAME_END_INTERNAL;
> -	if (pipe->output->writeback)
> -		dl_flags |= VSP1_DL_FRAME_END_WRITEBACK;
> -
> -	dl = vsp1_dl_list_get(pipe->output->dlm);
> -	dlb = vsp1_dl_list_get_body0(dl);
> -
> -	list_for_each_entry_safe(entity, next, &pipe->entities, list_pipe) {
> -		/* Disconnect unused entities from the pipeline. */
> -		if (!entity->pipe) {
> -			vsp1_dl_body_write(dlb, entity->route->reg,
> -					   VI6_DPR_NODE_UNUSED);
> -
> -			entity->sink = NULL;
> -			list_del(&entity->list_pipe);
> -
> -			continue;
> -		}
> -
> -		vsp1_entity_route_setup(entity, pipe, dlb);
> -		vsp1_entity_configure_stream(entity, entity->state, pipe,
> -					     dl, dlb);
> -		vsp1_entity_configure_frame(entity, pipe, dl, dlb);
> -		vsp1_entity_configure_partition(entity, pipe,
> -						&pipe->part_table[0], dl, dlb);
> -	}
> -
> -	vsp1_dl_list_commit(dl, dl_flags);
> -}
> -
>  static int vsp1_du_pipeline_set_rwpf_format(struct vsp1_device *vsp1,
>  					    struct vsp1_rwpf *rwpf,
>  					    u32 pixelformat, unsigned int pitch)
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 

-- 
Kind Regards,
Niklas Söderlund
