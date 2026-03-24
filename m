Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED0EFEC0ED
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 18:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0951210E4D8;
	Tue, 24 Mar 2026 18:16:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qkV54Npw";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31A3E10E4D8
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774376160;
 bh=qbH5s9Rn4iAcyiHdsMkvFr7PqdhWrF7n+fRbR3J47hU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qkV54Npw7hUZ28ukwfd1UjH+p2l+TDy78ZLd7MOjCY/nxLt1HGn7Gr4n9sxLEQKzd
 esfHmlORt8FjRrBxwO4THfoujdTGTW38n0JJYiRJqJfn04p9Oa4qG2qxiF17VqeLiT
 6DCFKJJTSf2miULw7ZK4fdeRFJqLZB5psRApiHBP0Oaa8RssndcsTMbN/zLi4fZfZ5
 ktMISfvzpOUd84BwPcDreNLgYazBb/WKfZSp2T0ahc42FeHHWj2ZR4H+pyxIpqVmt3
 g+PqpvWyFClo8Cz4UQjFiQmuzmlCmPEAtWE3e6kgWBIviWY76bDAPnnnojiqxV9e1l
 Rjhgxw+BX40xw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CEF0317E5C88;
 Tue, 24 Mar 2026 19:15:59 +0100 (CET)
Date: Tue, 24 Mar 2026 19:15:54 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Deborah Brouwer" <deborah.brouwer@collabora.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy
 Baron <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>, "Steven Price" <steven.price@arm.com>, "Dirk Behme"
 <dirk.behme@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>
Subject: Re: [PATCH v3 01/12] drm/tyr: Use register! macro for GPU_CONTROL
Message-ID: <20260324191554.39485c08@fedora>
In-Reply-To: <DHB6WU5SYXU7.2QMPFZG1KDOT8@kernel.org>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
 <20260323-b4-tyr-use-register-macro-v3-v3-1-a87daf9e4701@collabora.com>
 <DHAZ380DRB8A.19SI1OUABRWTP@kernel.org>
 <20260324130653.74f9c2ab@fedora>
 <DHB6WU5SYXU7.2QMPFZG1KDOT8@kernel.org>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 24 Mar 2026 18:31:42 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Tue Mar 24, 2026 at 1:06 PM CET, Boris Brezillon wrote:
> > It's defined in ascending bit order in the datasheets we have, so if
> > we're ever going to auto-generate those from the xml, we'd likely have
> > the same definitions Deborah came up with, unless the script re-orders
> > things in descending bit order.  
> 
> Huh, that is very uncommon; is it actually
> 
> 	15:0
> 	31:16

This ^.

> 
> or is it
> 
> 	0:15
> 	16:31
> 
> in your datasheets?

