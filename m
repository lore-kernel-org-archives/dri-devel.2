Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBBBCD4F25
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 15:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F7C10F560;
	Fri, 15 May 2026 15:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kroah.com header.i=@kroah.com header.b="KGzEdeeQ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="vUUYdJJV";
	dkim-atps=neutral
X-Greylist: delayed 573 seconds by postgrey-1.36 at gabe;
 Fri, 15 May 2026 15:19:16 UTC
Received: from flow-a3-smtp.messagingengine.com
 (flow-a3-smtp.messagingengine.com [103.168.172.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3E510F560
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 15:19:16 +0000 (UTC)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailflow.phl.internal (Postfix) with ESMTP id 9610D1380407;
 Fri, 15 May 2026 11:09:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Fri, 15 May 2026 11:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1778857782; x=1778864982; bh=6+an2USdyD
 9t0kgsNTq9hUpwB+SKKvHxpjWKIph/mlA=; b=KGzEdeeQavICjW/L3u3Z93W2g8
 NAxIjNbOg8evVayx7N1VVfB7a2juK3pM1a//LIl3FmSqp5F1DMJBaUQGyL+19yMa
 B7+Ed3WgDLqB3ZTceDTfDiMoh+J4xIVVASRwY50MUzt8ztc1EwJGu5VviQiw5pKD
 MvPA4G8H+Tw2/EPjSoxVmp75Xh5xyU816ITRNEyujJFobcVbLMnbaPoXoSfdG8ER
 qPvDXiyPkK69U9FNwxBWfTYqOLJPJtCVHO0wkDCrUekvS7OB9jhpDeImmqksNoo5
 1Sd+Kh56lUXUT9gYZcZbw1t2tNissveJpJ747VOiov4raFYMH5NmX3ghu/ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1778857782; x=1778864982; bh=6+an2USdyD9t0kgsNTq9hUpwB+SKKvHxpjW
 KIph/mlA=; b=vUUYdJJVvh5OK+i2gylaeiyDEMAXACk1sATJPY8dhMCzjdBxFgg
 hmMo1AbgSpk29vPC4KSkn2CInPRj3c/qxF+W5xYBPDwSLDOODqN47KM6iQmPCg5t
 GYNijgCBaLnAdic+mhBP03guaePTJy/hbMzYSyIdkHyVhqi7vGuTaq1BwUURePKy
 py/NBZGofXszH8b5RsaifW93/BA+h0eEm002YQy+RHIKU3asDwqgexsfr52UDFCU
 yhLEued3eECb2E1VPej9JCIOXk5KTdkTLnqs1CFL1vM6kSaXT2BajjO5UPCyUcN/
 oqxuQnt5NjqIXWyu0wvuOFYW7UIw0+b+t2A==
X-ME-Sender: <xms:NTcHaje7IIqBxVKZPAAzW4V_LOQ7X-Z7lDScjGGDUx2PN7ujce6ThQ>
 <xme:NTcHaqZz-r1Y7X6OSmO3q6IOARRj_N2fn-9Mzu1IWdz9gt_Ex9zwszVKqTwA-TEFl
 6vebV2RKYJJ0p6IOyNPLnhDIUlRNN-OOXe5MLn0WAeja8yyPQ>
X-ME-Received: <xmr:NTcHas9LTV1JdCaUQn3NGJCamgUR8vdIwJxR2mM0uSmBOBY-mDC5RzHXhyMSfSOZp_5PsX77EYXKi4igqo4Ifw925g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedtjedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
 dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
 ucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhf
 dtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepvdeipdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopeifudehfedtfeejgeeitdeivdesudeifedr
 tghomhdprhgtphhtthhopehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtoh
 hmpdhrtghpthhtohephhgrmhhohhgrmhhmvggurdhsrgesghhmrghilhdrtghomhdprhgt
 phhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhgvlhhishhsrg
 drshhrfiesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhh
 ohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhrihhprghrug
 eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgv
 rdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:NTcHauXEJA1qP7mTKyzVroESBYpnF3U4eoKqj83czwDsh-7SfGSYqA>
 <xmx:NTcHalf7Duf17mC4s7AxmtNXF9Oh5SzyVhb2CaWV_qVCTSnHt4_YJQ>
 <xmx:NTcHajUObWtXqhtOvuYYO505ENApFTyI212b5lehZGIi_aRzFiotiA>
 <xmx:NTcHasUI5cG930eI6MKcOysUDGNJF1Qw_O3DMif7eNhE0lw6pNOMWA>
 <xmx:NjcHal-kYPCNLu6CUnLfCgl18ln9nyoGAj8XklDYFLojdbAypt-_bTbX>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 11:09:40 -0400 (EDT)
Date: Fri, 15 May 2026 17:09:46 +0200
From: Greg KH <greg@kroah.com>
To: w15303746062@163.com
Cc: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
 melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH 6.18.y] drm/vkms: Fix ABBA deadlock in vblank disable and
 timer callback
Message-ID: <2026051557-thermal-petite-7da0@gregkh>
References: <20260515131826.388154-1-w15303746062@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515131826.388154-1-w15303746062@163.com>
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

On Fri, May 15, 2026 at 09:18:26PM +0800, w15303746062@163.com wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> [Note: This patch addresses a legacy VKMS implementation deadlock specific
> to older stable trees (e.g., 6.18.y). Mainline has removed this code during
> the generic DRM_CRTC_VBLANK_TIMER_FUNCS refactoring.]

Why not apply those upstream commits here as well?  No need to diverge
from Linus's tree, otherwise we will end up having a mess that nothing
can ever be backported to.

How many commits need to be backported?  Have you tried?

thanks,

greg k-h
