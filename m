Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C3606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6zrtbC1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68B3410F26F;
	Mon,  9 Nov 2026 13:08:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 340EE10F26F
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 13:07:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59A81618A5;
 Mon,  9 Nov 2026 13:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6F21F0089F;
 Mon,  9 Nov 2026 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794229678;
 bh=6EqaVezyVPtXvMeQC6ap3fEShaooSz1/C+wEJuwQn0Y=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=N6zrtbC1rX7wVQPI4Te1xgV92K6rFOhSt4qjXWKvCQa47vcGGxJFUEi9BP0hMZd3L
 0jFWiF/OlRb0WYNb0Ytek6HndakXsYE1cjzzKbBWoIEqOB57fvVwXBuzCt9cDPgpjT
 yy77EyQVx1zNl0aqxFAzYAkVOc/UfEb2AGb5MZeOtm0Gv6kmrSACSmL0qgatnEhPfR
 8J9dOwDNVHHp3kH8p/HwsIZB+6cTtiTwS/H/KsF6xs/waR+7VQsyeLGFOCutVQH4Xe
 wt+TqhSeSAo6uWhHacDWircctvmHZgDkCIdvpxDTJWG7wM42b4r2WulvbhzA0gSc4/
 yOeCFdn6IHIQg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 14:07:48 +0100
Message-Id: <DMQPC2HXYEZF.2NIJVLP4URRA9@kernel.org>
Subject: Re: [PATCH v5 7/9] rust: pci: add SR-IOV enable and disable tokens
Cc: "Simon Song" <xinmengs@nvidia.com>, <kvm@vger.kernel.org>,
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
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-8-xinmengs@nvidia.com>
 <DMQNRGDHAK0A.3EZQZGAHKYF47@nvidia.com>
In-Reply-To: <DMQNRGDHAK0A.3EZQZGAHKYF47@nvidia.com>
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

On Mon Nov 9, 2026 at 12:53 PM CET, Alexandre Courbot wrote:
> Do we want to return the token back in case of error, so the caller may
> try again?

I'd leave it as is for now, I'm not aware of a failure reason that warrents=
 a
retry and I haven't seen any of the existing drivers needing that.
