Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094C606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 01:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AWgQ/GVF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0CF10E320;
	Thu,  5 Nov 2026 01:35:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A05310E20A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 01:35:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E506402D5;
 Thu,  5 Nov 2026 01:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241DA1F00919;
 Thu,  5 Nov 2026 01:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793842540;
 bh=KttBQIY3CoR0oa+wCZDATiCKgDh41PjVmh/fyWWpT0g=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=AWgQ/GVF2EPfjjBRjUQl2TwhcDoTOHFhv4OThVqNUfe1HHJvlheooMr1GzMztQ1C8
 bdDigN/E6YS0yyDelrJfaAIPa0JM11JKsCj8P4uSdsuxbHNF1qTouqAxgvw+zkM537
 QgN/gxgocgD/u5ZKcmMrLh74pqTjPNGVyBCnsQ0njBfmVN7OfPe7ZVU0Gz5FRlAA1M
 j3VMkH18Qu2YN5aWhNsHX4MBDUcZvl4D8c5OZ9Wfczmt2I7kKzud6TJLW4NxnmLipM
 LmmSf0MPFpE9Ql48nCc4qVKSW2FQchsBokmjMO7ac2tdXGudifv5z+Bx4kyM44HXuY
 hMeQ0Yhhy/GJw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Nov 2026 02:35:29 +0100
Message-Id: <DMMW3TIIN8OI.3MZC03PWC1MRK@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 9/9] samples: rust: add Rust SR-IOV PF and VF driver
 samples
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
To: "Simon Song" <xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-10-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-10-xinmengs@nvidia.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Oct 30, 2026 at 6:12 PM CET, Simon Song wrote:
> +# Follow the nova-core/nova-drm cross-crate rules in drivers/gpu/Makefil=
e.
> +# Export Rust symbols from the PF only if the VF actually references the=
m.

This seems overkill, please make it two separate files, but a single kernel
module. We can always make them separate kernel modules once we have the ne=
w
build system.
