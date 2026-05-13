Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECAECD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 20:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1363010F054;
	Wed, 13 May 2026 20:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ragnatech.se header.i=@ragnatech.se header.b="gRvW0KzB";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QsxjluoI";
	dkim-atps=neutral
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3E010F054
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 20:31:43 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id C3F14EC0183;
 Wed, 13 May 2026 16:31:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 13 May 2026 16:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1778704302;
 x=1778790702; bh=lli9ZPyy82yRz3bDLmc4Yvy+5kmt8dvbijiAE1NqGLQ=; b=
 gRvW0KzBI01BHTwOXcYfWcK2tykh69e2Hs2gVrIbSSQkCjKb1ovLsIITYETuiGax
 awOITSQEf93FWq7OZRTjBw6Y2diVuCpsoAJ5oowpCpgXhDeQPfrFz1DAgPMnsByb
 uPgNwexgLP7OkjViz5yNO18mrCJvcKJvtJjZt68W2FiQ96EFP6ZDvcB2r4NzvbRq
 0Ek1C/cnSoW4XaXE/aZZjDsEtMWVR3Qt74XKU1774XVTBHD4wE7QNoAbzOE55TZr
 mnpwTDAvBaQ8hlw/o5wAwb43f688HZ+2JTXiASPhF0TOJP7tiXhP4P8l33g9/drD
 iwutbUmAd3R6IHVSiuh5gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778704302; x=
 1778790702; bh=lli9ZPyy82yRz3bDLmc4Yvy+5kmt8dvbijiAE1NqGLQ=; b=Q
 sxjluoIxV9jD+FegyBvE/Kau0niAls2lpEBtotWxWR7Q7wdMVwU4I++oAHKXVrZW
 1X/Wm66tONL35lkNsXwpsSgQA7Jh7+laZkwWULLCurGIPpU8+SnbKygukDFjso8s
 jWV3tNH2j+ZwIpQbGbtNJi8LRaPI+mH22vaePwukXw4w8dJiU954cGL8FF0dA7NW
 dbLKYn0ae9Fym/TidEWj7TSIuNnMu4xJHUcokEYtFJGkrMN6xVAXcbjVtJtCQvyD
 vG7TVoubE4vEQHgwng9kWNUmvgKfTooDeEXd23vtI/8oGikWEtWZANINluD0n63d
 OyMVa25g+EzECUZt4xVMg==
X-ME-Sender: <xms:rt8EatIGaYOz7_vUAB34kQBciJIiCor8lo5RHoZYy5pvo6aGVg1jwA>
 <xme:rt8Eak3MFilurBwTP7JSHE_DfvxfBKY7E4jf6BK39b09BCdAJO6yr4Lt50pPkibeG
 VSnqj2Ttq_i-8IuP503mblL1t5EpbuBrSII7acTveV8mGYg5vkDClU>
X-ME-Received: <xmr:rt8EaiIss0fNXIjsn7jPUOR02FIV2Ke-3sVJx9zzXYjFuqqUFn-Qsb4HtAevJa-YF5gIikThqlVl7CJ_E3ZusV6l8CldxJYwc6LI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdehiedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:rt8EanguZgj9mvv7gLlwujqxYS_VbsprgfCd0dwBD9k0Omqr1-IJKQ>
 <xmx:rt8EaqAQ5CBdvzGtujH715HuxSfHRYpDaip9HYAcdQOUJqjehATORQ>
 <xmx:rt8Eah49S4_L3Pg33m8riozymWa-zkLqXNUPjN_VzIeUhoYiO7lqxg>
 <xmx:rt8EanEKDLoDY9TM2i0srQacvrQSpXlHo2Cs6tVh1WIxHzy80FY8Tg>
 <xmx:rt8EaoCST7pLUSOpP8kE2Fg2idGgS_jIa26XF116cUD9SoRQa-0qshoF>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 16:31:41 -0400 (EDT)
Date: Wed, 13 May 2026 22:31:40 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 11/11] media: renesas: vsp1: Drop deprecated
 vsp1_du_setup_lif() function
Message-ID: <20260513203140.GN332351@ragnatech.se>
References: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
 <20260511235637.3468558-12-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511235637.3468558-12-laurent.pinchart+renesas@ideasonboard.com>
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

Nice series!

On 2026-05-12 02:56:35 +0300, Laurent Pinchart wrote:
> The vsp1_du_setup_lif() is deprecated and its last users are gone. Drop
> it.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  include/media/vsp1.h | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/include/media/vsp1.h b/include/media/vsp1.h
> index d2085cdb7fcb..98089e0a4385 100644
> --- a/include/media/vsp1.h
> +++ b/include/media/vsp1.h
> @@ -48,15 +48,6 @@ int vsp1_du_enable(struct device *dev, unsigned int pipe_index,
>  		   const struct vsp1_du_lif_config *cfg);
>  int vsp1_du_disable(struct device *dev, unsigned int pipe_index);
>  
> -static inline int vsp1_du_setup_lif(struct device *dev, unsigned int pipe_index,
> -				    const struct vsp1_du_lif_config *cfg)
> -{
> -	if (cfg)
> -		return vsp1_du_enable(dev, pipe_index, cfg);
> -	else
> -		return vsp1_du_disable(dev, pipe_index);
> -}
> -
>  /**
>   * struct vsp1_du_atomic_config - VSP atomic configuration parameters
>   * @pixelformat: plane pixel format (V4L2 4CC)
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> 

-- 
Kind Regards,
Niklas Söderlund
