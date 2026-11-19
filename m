Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A5606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRNGci51
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0DE1125F8;
	Thu, 19 Nov 2026 16:38:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 002B810EB8A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:38:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BEF5C44D77;
 Thu, 19 Nov 2026 16:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6986C1F000C4;
 Thu, 19 Nov 2026 16:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795106296;
 bh=Qnkd9IzUfJL6pRotEqKRjb0AkZ6zIZR7+fouUqriiqA=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=XRNGci51SIE3oHtCwVfNl9mHrt8swIeharTSKW7ZEipwvJPmMMTY/u4m+xSmybe81
 0e1jremmE+JIRXM1/gEcx5D5ALBVbPsBj28iDjBk0WA7amgdTeg0XyjR6PIOai6faU
 LXz5B0JhwzqbdsNiUahHS4zU7j15/4hgD1KL43ptpqkXjPUHJun4YO1K1TUtUlcvsH
 JUMDEEukfO0SrO+IIcSmxHzy0ZjsSLmDruuQQHg6AlKlJzVUY1tvApUjOBeKOjoI79
 ruskHQz5joYYEGC0V/pIRZG+99xpE4Jqa4qSemjidlwvh5HdFpOLC/lNX1jCSFy6kM
 IpOdMESLGtPdg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 17:38:11 +0100
Message-Id: <DMZC2LXTA7IC.5BU39FYHJU1J@kernel.org>
Subject: Re: [PATCH 1/4] drm/tyr: name resource lifetimes after their types
Cc: "Gary Guo" <gary@garyguo.net>, <daniel.almeida@collabora.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261118233727.3147222-1-dakr@kernel.org>
 <20261118233727.3147222-2-dakr@kernel.org>
 <DMYTKRS80NRC.18PBQHK9SZ8K9@garyguo.net>
 <DMZ4C3GGD9U0.360KJBSFLEK61@kernel.org>
 <DMZ5HM326EKD.1I8KUFD65L91Y@garyguo.net>
 <DMZ6RL5X2UXE.33EY9MDLO2AJA@kernel.org>
 <DMZ7CHWBWU4O.3EA040FFBVCLG@garyguo.net>
 <DMZ8NNSPL36I.15O2JQR7M65T0@kernel.org>
 <20261119154430.918072-1-aliceryhl@google.com>
In-Reply-To: <20261119154430.918072-1-aliceryhl@google.com>
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

On Thu Nov 19, 2026 at 4:44 PM CET, Alice Ryhl wrote:
> On Thu, Nov 19, 2026 at 02:57:37PM +0100, Danilo Krummrich wrote:
>> I think in the end it comes down to personal preference, so this is fine=
 with me
>> too.
>>
>> Though, I'd use a generic name in the latter case too, such that it does=
n't need
>> to be changed once a second resource is referenced later on.
>
> Agreed, using a generic name like `'a` (or borrowed-resource names for
> invariant lifetimes) sounds good to me too.
>
> Also, when updating this for v2, note that `VmAsData<'drm>` in
> `mmu/address_space.rs` and `GpuVmData<'drm>` (along with `VmMapArgs`,
> `VmOpType`, `VmOpResources`, `VmOpRequest`, and `PtUpdateContext` in
> `vm.rs`) were still left using `'drm`.

Before I respin I'll wait for Gary to look into how the existential lifetim=
e
could be moved to Vm (which is what I considered initially, but couldn't re=
ally
get to work).

I think having it on Firmware is reasonable, but I think having it on Vm wo=
uld
probably be better.
