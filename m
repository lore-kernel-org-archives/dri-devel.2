Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF99CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 336E610E040;
	Wed, 30 Sep 2026 15:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XE6fwnUA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 900C810E040
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 15:48:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21DB940498;
 Wed, 30 Sep 2026 15:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4B11F00899;
 Wed, 30 Sep 2026 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790783299;
 bh=Q3dyweEFIw9MMaAQ3qtHiJGRvzjhtsRVs97Lrtaxxi0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=XE6fwnUAwglbhcdAUGpYMPdG6pAocT+0GJ5tREtciyKq9M/ayirFD3z5tatqi/m2y
 XdnU+DEV3c5XAPWOkwrLafhvFCPr+WvbtIWvwMFLr8oJJpojVgbaRASMJn5fVHsRN6
 TslBl21/rtXKG4Bvps/fJmnjganr3OjcNR2VXt9jURpgGNhl0y2wLQf/JRbdHHPo7C
 Ra8AJpFvppqxFtYgVPFoyzk+GNHG8yTfdcMxAY2+zGOzicmp7EiQkAxuzvZk03oRdO
 8D3na2MB1l0tLPvqflMEvx3Pm41YQ605NginVf9qZWEzym/LrxgeI6AZ/rmr/nZrn3
 DGtyGapgXY0kA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 17:48:08 +0200
Message-Id: <DLSRP1M7HK6V.PJ3SDXZ991JU@kernel.org>
Subject: Re: [PATCH 2/7] rust: pci: expose the VF index within its PF
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
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir
 Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>, "Peter
 Colberg" <peter@colberg.org>, "Simon Song" <xinmengs@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1790764573.git.zhiw@nvidia.com>
 <5828df56a42b784ce9da005b338e8580ea63294c.1790764573.git.zhiw@nvidia.com>
In-Reply-To: <5828df56a42b784ce9da005b338e8580ea63294c.1790764573.git.zhiw@nvidia.com>
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

On Wed Sep 30, 2026 at 12:57 PM CEST, Zhi Wang wrote:
> @@ -40,6 +40,14 @@ pub fn is_virtfn(&self) -> bool {
>          // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
>          unsafe { (*self.as_raw()).is_virtfn() !=3D 0 }
>      }
> +
> +    /// Return the zero-based VF index within its PF, or an error for a =
non-VF device.
> +    pub fn vf_id(&self) -> Result<u32> {
> +        // SAFETY: `self.as_raw()` points to a live PCI device; the help=
er checks VF membership.
> +        let id =3D unsafe { bindings::pci_iov_vf_id(self.as_raw()) };
> +        to_result(id)?;
> +        Ok(id as u32)
> +    }

In my PoC I had this implemented for Device<Bound>, but here it is implemen=
ted
for just Device I think? It's not visible from the context, but IIRC you mo=
ved
is_virtfn() in an impl Device block (which is correct).

So, if this is correct, please move it under Device<Bound>, as offset and s=
tride
are not guaranteed to not be concurrently modified otherwise.
