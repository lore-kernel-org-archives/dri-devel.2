Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E6606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2wkW/amK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A64389089;
	Mon, 16 Nov 2026 10:27:02 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91C6890BB
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:26:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E5CAE4E415DC;
 Mon, 16 Nov 2026 10:26:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BB0406023F;
 Mon, 16 Nov 2026 10:26:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3B15A11BC1801; Mon, 16 Nov 2026 11:26:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794824809; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=smzNFETvZmiq84ADVssam0d3wZhZl64hu2ffrxSSLdI=;
 b=2wkW/amKQhFd1XrIBOv2a9aAfPAEGjpqr0VloY3Eukh5LG4IBths7faDMnCTWv1CiRL2DN
 3hCJXG8hf/NIW/nkRqOrGf+dy19Fw6mDjOGXFy3IZUIgzSsAjZwrrTvL84l01H/5ZodxA3
 r5d8lqRfUWul+nI/WgqPLELJuBvsohsCc1IiEjfga0sGYLkFatahDYabsswUzOpESVqs6i
 wnfNNiYTchyyBLdsr9B2tzD3A5cKbCyMuTqM6HuYzX9dg+0alaQ9MUpGUfPf7tipmoYuRc
 3+5I8t0U80i9IcWJ+1cgGRFT11EQE8qeVq8wK+MYDPSO3n8kVac6UPysVy4O1Q==
Message-ID: <a81d01a5-d755-4ce9-902f-dcd75bc0916e@bootlin.com>
Date: Mon, 16 Nov 2026 11:26:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as a VKMS reviewer
To: Oarora Etimis <oaroraetimis@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
References: <20261116091020.88281-1-oaroraetimis@gmail.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261116091020.88281-1-oaroraetimis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 10:10, Oarora Etimis wrote:
> VKMS has been kinda quiet lately: the last VKMS-specific change is from
> 14 August, and the commits after that are tree-wide API conversions.
> There is little review activity on the VKMS patches too.

Sorry for the long silence, I was going trough personal issues. It is 
mostly resolved I am currently catching up.

> I would like to try reviewing VKMS patches and help move things along.
> 
> Add myself as a reviewer so I get copied on VKMS submissions.
> 
> Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

Thanks a lot for the help!

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c4f4e48774d0..44397af566da 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8842,6 +8842,7 @@ M:	Louis Chauvet <louis.chauvet@bootlin.com>
>   R:	Haneen Mohammed <hamohammed.sa@gmail.com>
>   R:	Simona Vetter <simona@ffwll.ch>
>   R:	Melissa Wen <melissa.srw@gmail.com>
> +R:	Oarora Etimis <oaroraetimis@gmail.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

