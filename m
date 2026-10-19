Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860A5606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEv2Seq5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC2A010E664;
	Mon, 19 Oct 2026 21:35:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E597F10E662
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:35:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1EB43601F6;
 Mon, 19 Oct 2026 21:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D90C1F000C4;
 Mon, 19 Oct 2026 21:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792445744;
 bh=1qEZivztIKOLrsjPrgUw33BYXR9pb4u5TrZ3uAfthG4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VEv2Seq51oYnar7BMQy/Nay5mHX5jtbz6S9YMe5P7Z4fpLExSwBITqElFD/ivOW31
 bVJOVjKZL56+dyU422Jl9WtgvkSANfzj23zmbOE4wNBd/Kst8P4m3NIYLTIpT3GSSb
 IWTD0FLGGXfA6ruA0UwE8UtHlXoDFeLasPRF+8z5TAeERKZa3LvmUo/QL4kYiE37q/
 UYllbDjK8d9gzwqZDicvYUmMNN6wn/CbaqMNH16zsO49hf2vZ5iRmMmb9DHWwlUXJI
 /fcS9bEjXXJbSwSFd0zkeK4HXOBx9iMdie5/uS41w047fJ1rm6RtOtV4WQzaJopGMA
 MGSppocBrKcBw==
Date: Mon, 19 Oct 2026 16:35:43 -0500
From: Rob Herring <robh@kernel.org>
To: Aryan Sinha <sinha.aryan03@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel: ethosu: Fix kernel-doc for
 ethosu_gem_cmdstream_create()
Message-ID: <20261019213543.GA4157247-robh@kernel.org>
References: <20261012152118.33548-1-sinha.aryan03@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012152118.33548-1-sinha.aryan03@gmail.com>
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 12, 2026 at 08:51:11PM +0530, Aryan Sinha wrote:
> The comment documents an exclusive_vm argument the function never had, and
> leaves out data. Swap the two so the list matches the signature.
> 
> Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
> ---
>  drivers/accel/ethosu/ethosu_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Rob
