Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0925BCD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 19:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A34110F03A;
	Wed, 13 May 2026 19:44:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="Zb3/J8Gq";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="fehknpLB";
	dkim-atps=neutral
Received: from fhigh-a5-smtp.messagingengine.com
 (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B79C10F03A
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 19:44:08 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D3D09140006E;
 Wed, 13 May 2026 15:44:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 13 May 2026 15:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1778701447;
 x=1778787847; bh=vq8AplGuZyE7KuVYiOXha2pA1P/pIeAOsJq+kKq4w+4=; b=
 Zb3/J8Gq/8zSYeRanwmBPSFsHZjwgyRNVu7twLGs3O5eNCO/7zPgsM6jgpOW/Lqx
 iY1zs+uYoBIlBouYZcU1aEaddmVBArGdaM1JsCZglWTg93zh0l3OuCvT2WQxFNUy
 npbJ93jgWhmSwssK1gcyXcJASU3KbcfajyqhrsI7s/UX6wrlZuNKLGSQKPKsrK1/
 TVC+Cud5LdUfX+mJxiyfT4fgH3AUvNiwqdNBwF1DVh0XTQ5b3XJTxBvjxh+FHkyn
 bn7mdiqDhAOXM5tc4d9MBbUNZa71uJ/hkC3pbilS5rmr6u1U6uV0W/cpzJucR7yy
 +TZRufNi2fSHhviSiJ2CfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778701447; x=
 1778787847; bh=vq8AplGuZyE7KuVYiOXha2pA1P/pIeAOsJq+kKq4w+4=; b=f
 ehknpLBOJv+ow/RrtKmrZebrmw8JgzeYhn7K3QgbWmiIF8e2Jwj878AGpiSuaymi
 wRFX+As/3sNHetQb+AhN+nPmVaRm2T1t01q/khthzDBjTDW3ErG0zmXbTfveo5zS
 Cr+vVdONgRfcjRIDhWHLAvZ5HuXRS06PGWYA0V9Z3x2KN+565AzKVnehFKzSGMrE
 xCBdVia8tUWbZcSIhAPM5/VZvr+ucMIol18yh81rr9Fe5V8pxGR3jxCORNu5BqnG
 7heSKn5q3T1oh1RooK9DxXBIjnJfOSfgWccheHOyXEij0g+jf7Y21J8/yiHeTQZ2
 o1IHIuPG1d9rhegfg/zmA==
X-ME-Sender: <xms:h9QEalkBNqR-oZTH-NOFrTkA7QaNh3SqTrw1m3lXjZbfh6Eihx1b5g>
 <xme:h9QEatZvDFRzEgHNQmwuHnpFP67U2gRwS8FrJrYcm0oaUmswqe2pPAxs69kM4NQjw
 BD9GtTMaJwnIlO1G4AQf9mUzKOj_s2luDOAPQLYowewAi4HlSGonzo>
X-ME-Received: <xmr:h9QEagEbtBZg9qZrnYocWVkXbAgg6_T1g5apN34jm209eA3Wa1m7CHiNkRa1We5-k4KEWvFvB1J5-Rl7-uifgF5LVCidUngxQdn0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdehheduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:h9QEasZmU26Rp4jroqQGWSTJG3TYnyElUrCnAW9ed04fw14IJozkig>
 <xmx:h9QEakx-frbMlqLb5-X2jW3faASm7_TD2RtebZz6Ji5NUVc4r8xWhQ>
 <xmx:h9QEauSFZog46_N5G6LcWv7B3IFXDNKFWwWPH-YxwYxAz_ggRLKKZg>
 <xmx:h9QEahJD4umhOBy5Pq_aQpUw_zUWmxlQh0MoydzcofYWMrLX5E5iaA>
 <xmx:h9QEat-HKxK0cRwJy2_T4ON9G21hMmoieOGYnc53AyKS_Hjf7vvSOA2g>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 15:44:07 -0400 (EDT)
Date: Wed, 13 May 2026 21:44:05 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 09/11] media: renesas: vsp1: Simplify iteration over
 format arrays
Message-ID: <20260513194405.GL332351@ragnatech.se>
References: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260511235637.3468558-10-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511235637.3468558-10-laurent.pinchart+renesas@ideasonboard.com>
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

On 2026-05-12 02:56:33 +0300, Laurent Pinchart wrote:
> Introduce a vsp1_for_each_format() macro to iterate over format arrays,
> to improve readability. No functional change intended.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  .../media/platform/renesas/vsp1/vsp1_pipe.c   | 36 ++++++-------------
>  1 file changed, 10 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/media/platform/renesas/vsp1/vsp1_pipe.c b/drivers/media/platform/renesas/vsp1/vsp1_pipe.c
> index f9c7c75a7ad0..7197f2917417 100644
> --- a/drivers/media/platform/renesas/vsp1/vsp1_pipe.c
> +++ b/drivers/media/platform/renesas/vsp1/vsp1_pipe.c
> @@ -229,6 +229,10 @@ static const struct vsp1_format_info vsp1_video_hsit_formats[] = {
>  	  1, { 32, 0, 0 }, false, false, 1, 1, false },
>  };
>  
> +#define vsp1_for_each_format(info, formats) \
> +	for (const struct vsp1_format_info *info = &formats[0]; \
> +	     info < formats + ARRAY_SIZE(formats); ++info)
> +
>  /**
>   * vsp1_get_format_info - Retrieve format information for a 4CC
>   * @vsp1: the VSP1 device
> @@ -240,30 +244,20 @@ static const struct vsp1_format_info vsp1_video_hsit_formats[] = {
>  const struct vsp1_format_info *vsp1_get_format_info(struct vsp1_device *vsp1,
>  						    u32 fourcc)
>  {
> -	unsigned int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(vsp1_video_formats); ++i) {
> -		const struct vsp1_format_info *info = &vsp1_video_formats[i];
> -
> +	vsp1_for_each_format(info, vsp1_video_formats) {
>  		if (info->fourcc == fourcc)
>  			return info;
>  	}
>  
>  	if (vsp1->info->gen == 2) {
> -		for (i = 0; i < ARRAY_SIZE(vsp1_video_gen2_formats); ++i) {
> -			const struct vsp1_format_info *info =
> -				&vsp1_video_gen2_formats[i];
> -
> +		vsp1_for_each_format(info, vsp1_video_gen2_formats) {
>  			if (info->fourcc == fourcc)
>  				return info;
>  		}
>  	}
>  
>  	if (vsp1_feature(vsp1, VSP1_HAS_HSIT)) {
> -		for (i = 0; i < ARRAY_SIZE(vsp1_video_hsit_formats); ++i) {
> -			const struct vsp1_format_info *info =
> -				&vsp1_video_hsit_formats[i];
> -
> +		vsp1_for_each_format(info, vsp1_video_hsit_formats) {
>  			if (info->fourcc == fourcc)
>  				return info;
>  		}
> @@ -287,8 +281,6 @@ const struct vsp1_format_info *
>  vsp1_get_format_info_by_index(struct vsp1_device *vsp1, unsigned int index,
>  			      u32 code)
>  {
> -	unsigned int i;
> -
>  	if (!code) {
>  		if (index < ARRAY_SIZE(vsp1_video_formats))
>  			return &vsp1_video_formats[index];
> @@ -308,9 +300,7 @@ vsp1_get_format_info_by_index(struct vsp1_device *vsp1, unsigned int index,
>  		return NULL;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(vsp1_video_formats); ++i) {
> -		const struct vsp1_format_info *info = &vsp1_video_formats[i];
> -
> +	vsp1_for_each_format(info, vsp1_video_formats) {
>  		if (info->mbus == code) {
>  			if (!index)
>  				return info;
> @@ -319,10 +309,7 @@ vsp1_get_format_info_by_index(struct vsp1_device *vsp1, unsigned int index,
>  	}
>  
>  	if (vsp1->info->gen == 2) {
> -		for (i = 0; i < ARRAY_SIZE(vsp1_video_gen2_formats); ++i) {
> -			const struct vsp1_format_info *info =
> -				&vsp1_video_gen2_formats[i];
> -
> +		vsp1_for_each_format(info, vsp1_video_gen2_formats) {
>  			if (info->mbus == code) {
>  				if (!index)
>  					return info;
> @@ -332,10 +319,7 @@ vsp1_get_format_info_by_index(struct vsp1_device *vsp1, unsigned int index,
>  	}
>  
>  	if (vsp1_feature(vsp1, VSP1_HAS_HSIT)) {
> -		for (i = 0; i < ARRAY_SIZE(vsp1_video_hsit_formats); ++i) {
> -			const struct vsp1_format_info *info =
> -				&vsp1_video_hsit_formats[i];
> -
> +		vsp1_for_each_format(info, vsp1_video_hsit_formats) {
>  			if (info->mbus == code) {
>  				if (!index)
>  					return info;
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 

-- 
Kind Regards,
Niklas Söderlund
