Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F33CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD7910EC39;
	Tue, 23 Jun 2026 17:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="IUwcPBUm";
	dkim-atps=neutral
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6092010EC39
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 17:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1782237176; x=1782496376;
 bh=s4Is0q7DP6LQ80r/3dZ+cvP75TsKFlNwA4YLWr0Cmjo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=IUwcPBUmckP5rXwZanc2iqSVRvyw2KiD/T2Pka87Rr9k4JwUwaQxuj1ie3YNYlWKu
 5SUso8FzI/8S2nwliVNmKyy5T6vNtzQOOJYflWqR4gKYe/zJeoLkX1HssX7w0KrrYT
 z5a8Xo2nG83wDO9cxhI9ynMlCnHSVndW/Ik3uZsGUjQPd27/DkqV1pdBnZ3kjyDvuw
 hdo6xjK3+Bn32c5Rbvy9noKj25u2gjwfNJsOcGOE2Qoat1hu7dE7fElB44u+harnIi
 XQ9bAQvtPyKSzo8iph+srCyfCU2kULocTMHVEXB5Lq44IPfTpcHPWSVdV2JadFB+qu
 nf58a6hspOA8w==
X-Pm-Submission-Id: 4glCMd2JVcz1DDKr
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v17 10/10] rust: page: add `from_raw()`
Date: Tue, 23 Jun 2026 20:52:41 +0300
Message-ID: <20260623175243.83672-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260604-unique-ref-v17-10-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-10-7b4c3d2930b9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 04 Jun 2026 22:11:22 +0200=0D
Andreas Hindborg <a.hindborg@kernel.org> wrote:=0D
=0D
> From: Andreas Hindborg <a.hindborg@samsung.com>=0D
> =0D
> Add a method to `Page` that allows construction of an instance from `stru=
ct=0D
> page` pointer.=0D
> =0D
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>=0D
> ---=0D
>  rust/kernel/page.rs | 12 ++++++++++++=0D
>  1 file changed, 12 insertions(+)=0D
> =0D
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs=0D
> index 844c75e54134..d56ae597f692 100644=0D
> --- a/rust/kernel/page.rs=0D
> +++ b/rust/kernel/page.rs=0D
> @@ -214,6 +214,18 @@ pub fn nid(&self) -> i32 {=0D
>          unsafe { bindings::page_to_nid(self.as_ptr()) }=0D
>      }=0D
>  =0D
> +    /// Create a `&Page` from a raw `struct page` pointer.=0D
> +    ///=0D
> +    /// # Safety=0D
> +    ///=0D
> +    /// `ptr` must be convertible to a shared reference with a lifetime =
of `'a`.=0D
> +    #[inline]=0D
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {=
=0D
> +        // SAFETY: By function safety requirements, `ptr` is not null an=
d is convertible to a shared=0D
> +        // reference.=0D
> +        unsafe { &*ptr.cast() }=0D
> +    }=0D
> +=0D
>      /// Runs a piece of code with this page mapped to an address.=0D
>      ///=0D
>      /// The page is unmapped when this call returns.=0D
> =0D
> -- =0D
> 2.51.2=0D
> =0D
> =0D
=0D
Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>=0D
