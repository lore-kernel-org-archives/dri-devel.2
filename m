Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067B606A328
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AQeXbXSj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F02210E171;
	Fri,  6 Nov 2026 09:06:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A7010E171
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:05:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ABBE960224;
 Fri,  6 Nov 2026 09:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99D11F008A1;
 Fri,  6 Nov 2026 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793955957;
 bh=WPuD57JlYcSeWtGJ9evE1GvVEReb3TMJbzr2AWb1TC0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AQeXbXSjATO/WDYBekds4BBIebSW0WG9iHKpPgnTW28ettxwmkwQ0/xjfwFmL7Mmc
 zLaFuwzibEv7sVucctAshKhoqTa6Y4F6CLIuyt2xUHcgwjPUiVEAOB7ZRwHuevtQK8
 tEuLn4+B+ovonEjxMceVJMNt9vz7ECPKWvy9Ty8m0BHZuoXTH9KFJF1o4a3OYhNHkk
 uBa8bjFXC/gqDwQcsxJeeMaTzTNN7wG1thV9mmryXl+VTCGomvbaTMxgO9r1LHKgQZ
 Kg1I3zPLD7bRNkuNuGRQaNt/Xvb9uxKdWEZJGv8FGjdqIlS/3raZEGUBuHBhR7wh/4
 CB2tL81t4MbvQ==
Date: Fri, 6 Nov 2026 10:05:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Bence Csokas <bence.csokas@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/2] Add scope-based cleanup capability to eventfd_ctx
Message-ID: <20261106-hinein-lagebericht-abbezahlen-cb826d68d175@brauner>
References: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261027-efd-autofree-v3-0-caa2442e1beb@arm.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 05:22:00PM +0100, Bence Csokas wrote:
> Add __free() support to eventfd and update drm_syncobj to use it as an
> example consumer.
> 
> A minor discrepancy I encountered is whether to put a semicolon after
> DEFINE_FREE(). It seems some in-tree code does, some doesn't. In the end,
> I followed the example set in core-api/cleanup.rst, and omitted it.
> 
> Signed-off-by: Bence Csokas <bence.csokas@arm.com>
> ---

I'm really having trouble seeing how this improves anything
significantly. Probably others have the same impression which is why
this doesn't get a lot of review.
