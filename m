Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C1C606A326
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIe3sTAU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF85E10E38F;
	Fri, 20 Nov 2026 08:55:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC6A10E06F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 08:55:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4425E612A9;
 Fri, 20 Nov 2026 08:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D139F1F000CF;
 Fri, 20 Nov 2026 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795164914;
 bh=bCjbTJGJI6ex7wHpDHXP5CHa6gyVnPTie7nxrKBqj3Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hIe3sTAUxPep7q7CdZ7dgYYzpLC42CPAGCE7Zu2j2i5XkdVVDULvzZuXDkngRBGP4
 p32zP8LmRfeNPODzvd99T7g5E3SV4W+hvEbkCzoKBS7hAeuvYQx8hriflXSP/VrCfB
 L8irnBPoukEEW3Or/+EYOrfgEfLqYq3rs8FUQRwbY8KLYrWkGuH88y/Wv40Q0D94iH
 a5s/4rdxXvf1woagFGDzfjxSS/M5IPXVp7VdwQO7YW6TefiNnAoI9zSYte+Gy0ZhpT
 XzZ62mOlCNNBF6hkfingEKwYnsQBwCH/J8+VcQUVbNU0Z+TpKa1EZbUqmOKukoPRFJ
 Xllja9LUcbXtw==
Date: Fri, 20 Nov 2026 09:55:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com, 
 acourbot@nvidia.com, daniel.almeida@collabora.com, ojeda@kernel.org,
 boqun@kernel.org, 
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev,
 lyude@redhat.com, j@jananu.net, alvin.sun@linux.dev,
 deborah.brouwer@collabora.com, 
 laura.nao@collabora.com, beata.michalska@arm.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] rust: fs: add iminor() helper
Message-ID: <20261120-nahrung-wandmalerei-signal-8dce8ca30754@brauner>
References: <20261118163203.2483856-1-dakr@kernel.org>
 <20261118163203.2483856-5-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261118163203.2483856-5-dakr@kernel.org>
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 05:29:45PM +0100, Danilo Krummrich wrote:

Seems fine,
Acked-by: Christian Brauner <brauner@kernel.org>
