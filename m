Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE576075280
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=bLoGyWGd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD1C910E092;
	Mon,  2 Nov 2026 16:59:08 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97B4110E092
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793638741;
 bh=CL8t3c6JLDGRR3T0QVgRjVlabSJH7qyJQ3Ydz55euyg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bLoGyWGd5rx6L7H9iLz5O1gc9zmLZqtiSNZ9D4eZXoFydq10BOPzjlAdV695cDKNV
 YMtUccFIMB6MHKsja8kI2ISszG8miTcchRB3RrG/X9EVBIGEV5jxRKMvBp1uC2H2QE
 NMpSfaOQSf8UlUmk/BhITRogrby+JF7I00lia6DLMfkniAZuOLVrrwSezIhPaXqxU3
 mBEZiV8Bj3IJVn3bkT7NNzoxoBHjqtP+sC7MED3HnejtV5zE3eg5QuLxL8mNsYkKNu
 U8jJFwd+r1ihj/bzSZk39sWpK4sg2xKDkRY50TySvENmSgNNWOTk8AoryXU42JXjUG
 TlhnPGpicFtlw==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9911817E0240;
 Mon, 02 Nov 2026 17:59:00 +0100 (CET)
Date: Mon, 2 Nov 2026 17:58:56 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Akash Goel
 <akash.goel@arm.com>, Karunika Choo <karunika.choo@arm.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Florent Tomasin
 <florent.tomasin@arm.com>, Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH v2] drm/panthor: Add more reviewers
Message-ID: <20261102175856.39e4b36d@fedora1.home>
In-Reply-To: <20261030144805.667158-1-liviu.dudau@arm.com>
References: <20261030144305.666845-1-liviu.dudau@arm.com>
 <20261030144805.667158-1-liviu.dudau@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 14:48:05 +0000
Liviu Dudau <liviu.dudau@arm.com> wrote:

> We now have more people that can do reviews and contribute patches
> to Panthor, so add their names to the list.
> 
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>

> 
> ---
> v2: Forgot to add Chris Diamand to the list, fixed.
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 89ea35a35c680..ef92c462a8381 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2321,6 +2321,10 @@ ARM MALI PANTHOR DRM DRIVER
>  M:	Boris Brezillon <boris.brezillon@collabora.com>
>  M:	Steven Price <steven.price@arm.com>
>  M:	Liviu Dudau <liviu.dudau@arm.com>
> +R:	Akash Goel <akash.goel@arm.com>
> +R:	Karunika Choo <karunika.choo@arm.com>
> +R:	Lukas Zapolskas <lukas.zapolskas@arm.com>
> +R:	Chris Diamand <chris.diamand@arm.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

