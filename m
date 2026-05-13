Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783DECD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 19:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C822A10F016;
	Wed, 13 May 2026 19:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="UUcrX97f";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="KHVf0XrB";
	dkim-atps=neutral
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A767A10F016
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 19:21:07 +0000 (UTC)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id E8EAAEC00DF;
 Wed, 13 May 2026 15:13:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Wed, 13 May 2026 15:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1778699590;
 x=1778785990; bh=hFSkC2f1bbi8Np9MfeUj+ngXepPzDLqhURPaKLcijYU=; b=
 UUcrX97fZA1UnFEAmycSiJD5QSrHWKb7VNQyqqn0kDmchRoOU0B3VmM2q/kgmm2J
 Lz3uecegItmtiPliE1fXR155nRwaCTdHLdahlrcJhke7wZ5CQYA1YnmBqHSmOHz9
 xJkibz28g74SYJA4DsZ6CnzXPHSDT9t5D7AqejstCIXDVibG0IpTApjfRiB3NFAg
 DdWCqAot5en/IwnteNM+aYZYZYKfdoLS06LGvX/YsCvphe9gJEj6FUk5f9Dqs7QA
 +sdUz6i5FJvmK87Um79C+L0WO7KS+DdNoAMPa9n68RAEDCIsGQR5A1MoIxXEY7Ei
 Gg/8wMBolqCEXi6ziw+1eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778699590; x=
 1778785990; bh=hFSkC2f1bbi8Np9MfeUj+ngXepPzDLqhURPaKLcijYU=; b=K
 HVf0XrB0nw89Z/I0GUdu8d9GUwkw8LwiJBCjjEJso5glrCIlkSbonn14G85qcaTM
 TqZJH8+6kElPALcoWlCNM3MlxdD7mpWLW699nksrK2OkTZeL2N4NQ3V7FlZG2t3s
 jXujfiyuoM406Bgz1rIeddywntHG5QJDmKhUf0sP+8hpAKUOYEYR94TBCyaKeyYD
 1q0rdXGd6gy9VzN13srax4387sKkgXycbVNpgRGH/HgOiQtCIGWKe5lPQUDHe55H
 4iJURUgD7MnzeUzI0cdKBhIpgifsn08jXB2vHA5HTjA+xTV1oREVESFAo8JawB7Z
 GlpmwRqU/X1gvQUaEvI8A==
X-ME-Sender: <xms:Rs0Eau_rquKkp-yQw9UIYXU9yEY_4OQ-44btaUVmwlxamFh9rqjG3w>
 <xme:Rs0EarQV30yuaxzrHnsz2IEXZH7-EPQDN8zL5l7e095hh1dNuMAL4lZ-KgU_M-ztZ
 17eQeJ0q7O3tU-IZG1KMVtVJLOf580qIDClCxrF1VNrd--wtNfv9Q>
X-ME-Received: <xmr:Rs0EaocuErbSUvJnZsqAgbYISUCpd92v0qL18e52eHASY-CiLjRvj3Ya_JZvZ44SH5igFVi8Lfhkok5WLnH_lLk9yuCE9KcTyE0T>
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
X-ME-Proxy: <xmx:Rs0EatQadAIQoLQ6p3URumPtHRIO9nNjPJ8xLDxxbNCK2L1qcDCy6Q>
 <xmx:Rs0EakK8F0vWlEsIGaRPtbId82OH65flsGKVXYDfzEza9TSi6Ylg2Q>
 <xmx:Rs0EaqLrGO6stRQJ3-JSMK6ENsQ6tmCVnRhaEXCCKGHFdwgKSpMLzA>
 <xmx:Rs0EavhIaA14B9CFLAoShpDuzyu9R24KvUPBXAS8_bzMhlRV_ZYNUQ>
 <xmx:Rs0Ean1n61-pkY_YFf7D8UuuK-qI5fmiZkt9TQcijno7kyKRraGhuQDB>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 15:13:10 -0400 (EDT)
Date: Wed, 13 May 2026 21:13:09 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 04/11] drm: renesas: rz-du: Switch to new VSP API
Message-ID: <20260513191309.GG332351@ragnatech.se>
References: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260511235637.3468558-5-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511235637.3468558-5-laurent.pinchart+renesas@ideasonboard.com>
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

On 2026-05-12 02:56:28 +0300, Laurent Pinchart wrote:
> The vsp1_du_setup_lif() function is deprecated. Use the new
> vsp1_du_enable() and vsp1_du_disable() functions instead.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Biju, I would like to merge this for v7.2 through the media tree instead
> of the DRM tree. Would that be OK with you, or do you expect conflicting
> changes to the rz-du driver for v7.2 ?
> ---
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> index bd486377f037..d5a1d36db2c1 100644
> --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
> @@ -55,12 +55,12 @@ void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc)
>  		.callback_data = crtc,
>  	};
>  
> -	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
> +	vsp1_du_enable(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
>  }
>  
>  void rzg2l_du_vsp_disable(struct rzg2l_du_crtc *crtc)
>  {
> -	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, NULL);
> +	vsp1_du_disable(crtc->vsp->vsp, crtc->vsp_pipe);
>  }
>  
>  void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc)
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 

-- 
Kind Regards,
Niklas Söderlund
