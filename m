Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF943606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 01:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/IdNdDl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49DE510E09A;
	Tue, 10 Nov 2026 01:04:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B0810E09A
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 01:04:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB0254594B;
 Tue, 10 Nov 2026 01:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351B11F0089F;
 Tue, 10 Nov 2026 01:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794272674;
 bh=Bv0ooEsqQhG/+6pm98YOZvLWwFhBUu/sWcsdtUoLwy4=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=Y/IdNdDllQ8txzmqlTq5n+jUNGUsT1AxrfTY2ikBxw33Ci2JnCEerTvPmnB/3QMAl
 OjNGcxMFLFoWuhjU9RzXBnDylktnvyRr7vcG/VsWjAmjC3ARmbReleTmjFt1KWirol
 utOgbEJ1hwQVm7nJ3+hkfywBaxif6Gd9FPgyDuJH+X4x56JZVehKpU2+hi4qtwbwin
 jSQfm77qQHMo+h+nG9Vf6+/1Ffoekt6SHMkzEwJUypYrjKykbmUp3ukB6J7sduL2i5
 wGnTT4nFjBjWBgxpiuYPx4ghgn2dIsiLQSdxNPvuZ29n5zLB/eObLqV1Cz2xMqSEf7
 vf4f15+YNFK4A==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 02:04:25 +0100
Message-Id: <DMR4KREJHY3Q.4VWNF1EO3UE0@kernel.org>
Cc: <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <boqun@kernel.org>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <jgg@ziepe.ca>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <peter@colberg.org>
To: "Simon Song" <xinmengs@nvidia.com>, <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 00/12] Rust VFIO PCI support and NVIDIA vGPU driver
References: <20261023154009.2246627-1-xinmengs@nvidia.com>
In-Reply-To: <20261023154009.2246627-1-xinmengs@nvidia.com>
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

On Fri Oct 23, 2026 at 5:39 PM CEST, Simon Song wrote:
>   rust: vfio: add PCI variant driver abstractions
>   rust: vfio: use the PCI adapter for variant drivers
>   rust: vfio: separate common device handling from PCI

Those three commits introduce quite some back and forth in terms of deletin=
g and
refactoring previously introduce code.

(I won't review them individually for this reason, but I can go over the en=
d
result and provide some feedback.)

For patch ordering, "rust: vfio: separate common device handling from PCI"
should be the first patch which establishes a shared representation of a ba=
se
VFIO device; the other two patches should be squashed into a single patch.

(I think a separate adapter type for vfio-pci could still have some advanta=
ges,
but this can be a subsequent consideration, for now I'd stick with the core=
 PCI
one.)

Thanks,
Danilo
