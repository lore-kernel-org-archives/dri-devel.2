Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8B60A2612
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Y6+EEKjy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6843810E82C;
	Sun, 25 Oct 2026 05:55:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933D610E82C
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 05:55:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EE34600D4;
 Sun, 25 Oct 2026 05:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8855D1F01828;
 Sun, 25 Oct 2026 05:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1792907738;
 bh=WTcOXp7jRbhT7DDBNRcTdM1HTdeP3FAq6cpW563Fmvc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Y6+EEKjyNojqgRd/Lim4Ovq+wn39ENkOzqvd1qnW5Ml0ht4Ey7ac2qzwJro3+D2MY
 2m5YlnulKjoPqy7Xy6QrpTfheaXhxlJrxGtIkYulsHyV3ngoImhEXurtef5IEQIXY5
 IPIx90sW2fJqut7V8fXgvrTrScQ45H0bDFvDBXso=
Date: Sun, 25 Oct 2026 06:55:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Aditya Nagar <dev.adityanagar@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-staging@lists.linux.dev,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: remove unused argument from
 FBTFT_SPI_DRIVER()
Message-ID: <2026102519-polymer-gorged-bc90@gregkh>
References: <20261025052136.389541-1-dev.adityanagar@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025052136.389541-1-dev.adityanagar@gmail.com>
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Oct 25, 2026 at 10:51:36AM +0530, Aditya Nagar wrote:
> The _compatible argument of FBTFT_SPI_DRIVER() is never used in the
> macro body. The device tree match table is created separately by
> FBTFT_DT_TABLE() in both callers, FBTFT_REGISTER_DRIVER() and
> FBTFT_REGISTER_SPI_DRIVER().
> 
> Drop the argument and update both callers. No functional change.
> 
> The argument has been unused since the macro was introduced in commit
> c222ea5d2f33 ("staging: fbtft: Deduplicate driver registration macros").
> 
> Found with checkpatch.pl (MACRO_ARG_UNUSED). The change was prepared
> with the help of an AI coding assistant (Claude); I reviewed it and
> build-tested all fbtft drivers with W=1.
> 
> Signed-off-by: Aditya Nagar <dev.adityanagar@gmail.com>

Sorry, but please read:
	https://lore.kernel.org/r/2026080354-skater-urgent-31b2@gregkh
