Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Lp19sFVn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4395D10EB6F;
	Mon, 19 Oct 2026 23:38:14 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1952F10F103
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792453082; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q9CIDi9fCUFgqY0uS/7OL+qn0attrEAh+92cX9w2dXPDS5L50EU7mdVCwH0gyCzRSqdKm6rrOydq/zo6ycMb8RoIEYvcxZ63KCz5N1xdC4YG0m79L8znzwLkr3UAVCVO3qA3octqrGU4lRH22zxPUqSkaYFA58ATFzjygiObAdg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792453082;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uShKQUWFwgSh7DQhGWBd/23uQd+cee0N/l3UrzJ2TbM=; 
 b=GJv5x3O+WvZfrEs869ebbE9Whj6fpT1145jHXp2L4SIQL2excS35tYrKU26xrvU+BBksWK4tNv9lHVKMWfIKBG7YcgtIbG/421iwRScHe5GAFuEdvMIY3TwTmqQVNhj8dl3b8qaHRdk8LEalrQsaecPW0WD62nYlpkJ8ppS4Jp8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792453082; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=uShKQUWFwgSh7DQhGWBd/23uQd+cee0N/l3UrzJ2TbM=;
 b=Lp19sFVndvpCIPXLe+5AZvSQ1xqq6gEgf2f8k1LTFRHKDJZhUC4jYcLdZYhPDmnk
 FREedBJW9fofhlel8bZOO8PHOHxx495zSLyR4CKn3YqaIGOAMrK7d66Fgoaifo4n83L
 5yxT2zPpuO1+Y5y8+zBI0OpoNXHgDKdZ7BquMvXo=
Received: by smtp.zohomail.com with SMTPS id 1792453080386614.7316189103576;
 Mon, 19 Oct 2026 16:38:00 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:37:59 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm/tyr: allow userspace buffers to be mismatched
Message-ID: <atap18Uo7U2OY92b@um790>
References: <20261015-b4-dev_query_fixes-v2-0-e3e6d25050cb@collabora.com>
 <20261015-b4-dev_query_fixes-v2-2-e3e6d25050cb@collabora.com>
 <atHwZg245MM7l9Ty@google.com>
 <DM6Q8HOV2J6Z.19M92D448I2JQ@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6Q8HOV2J6Z.19M92D448I2JQ@nvidia.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.448.41
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 17, 2026 at 10:36:49AM +0900, Alexandre Courbot wrote:
> On Fri Oct 16, 2026 at 6:37 PM JST, Alice Ryhl wrote:
> > On Thu, Oct 15, 2026 at 11:35:21AM -0700, Deborah Brouwer wrote:
> >> +// If the user buffer is at least the minimum required size, then
> >> +// copy as much of the kernel object as will fit into the user buffer.
> >> +// Don't fail if the user buffer is smaller than the kernel object.
> >> +// If the user buffer is bigger than needed, zero out the remainder.
> >> +fn set_uobj<T: AsBytes>(usr_dst: u64, size: u32, min_size: usize, src_obj: &T) -> Result {
> >> +    if (size as usize) < min_size {
> >> +        return Err(EINVAL);
> >
> > Use `kernel::num::casts::u32_as_usize` here.
> >
> >> +    }
> >> +
> >> +    let mut writer = UserSlice::new(UserPtr::from_addr(usr_dst as usize), size as usize).writer();
> >
> > Avoid casting to usize twice.
> >
> > 	let size = kernel::num::casts::u32_as_usize(size);
> 
> Or `usize::from_safe_cast(size)` after importing `FromSafeCast` -
> `u32_as_usize` is useful in const context, but for regular conversions
> the `FromSafeCast` trait looks slightly better.

Yes, since we aren't using this in a const context I will switch over to
usize::from_safe_cast(size) in the next version, thanks.

> 
