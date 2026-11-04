Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0BD6075DC8
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQyj2k3l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D96F10E1EF;
	Wed,  4 Nov 2026 20:37:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D434810E1EF
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:36:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F255C60DA7;
 Wed,  4 Nov 2026 20:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA74D1F000C1;
 Wed,  4 Nov 2026 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793824614;
 bh=molaxxSlyqGgz4uBias4mBVkzNOljDY00RtNc7qBpVk=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=aQyj2k3lWyOeTjKWdAFZjRq5vb3hLRfSE69ir1W/UiZbad3Lm5N65cOzeV0cxMNmK
 BTLHvVNru3HldjTMSU+QGhGlhAF2X31rweGCKtM7kZ24IJTU3DQ9DqZi6tbb0LO2az
 ICKpcNvV4Rp1yplZxS9/lXtxTJ+7F5b3VRSo5jxyW1mSPJlTueXJl1ZLOt3mnzVVIW
 AttOaVSIc+mVCKd4pzpmBdS9IctQ9Xfsi0i3ZQh7PNV5rnLcv/pfKO4B0pTgOLhgSM
 RzHfP5x5EYlcEscSgIrODegWAbqoZwppbtACjtxAdE86nJJoBp3keruU1koHjgCtXM
 vOFNQlfMOJbGA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 21:36:44 +0100
Message-Id: <DMMPR2NCVOPR.36BPE8I92CIXB@kernel.org>
Subject: Re: [PATCH v5 6/9] rust: pci: add typed SR-IOV PF registration data
Cc: "Simon Song" <xinmengs@nvidia.com>, <acourbot@nvidia.com>,
 <kvm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <linux-pci@vger.kernel.org>,
 <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
 <apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
To: "Bjorn Helgaas" <helgaas@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261030171230.196717-7-xinmengs@nvidia.com>
 <20261104202810.GA1422371@bhelgaas>
In-Reply-To: <20261104202810.GA1422371@bhelgaas>
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

On Wed Nov 4, 2026 at 9:28 PM CET, Bjorn Helgaas wrote:
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# include/linux/pci.h

Thanks!

> I assume use of vf_registration_data_rust is meant to stay
> encapsulated in rust/kernel/pci.rc and rust/kernel/pci/.

Yes, this is private to the Rust PCI core code.

(I may generalize this via generic private data pointer for bus abstraction=
s in
the future in struct device_private; there are a few more cases that will n=
eed
something similar.)
