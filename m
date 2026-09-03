Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9768FC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9035C10E0F2;
	Thu,  3 Sep 2026 13:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ZiQX6yMA";
	dkim-atps=neutral
X-Greylist: delayed 87107 seconds by postgrey-1.36 at gabe;
 Thu, 03 Sep 2026 13:09:50 UTC
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED1310E0F2
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:09:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788440987; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fuKgUs9b7JuOO7CEi3lcRc5gF6oqDW0UIPI4gapgwybnAgyJZia5P1bWcOitvwlihCpvmOYU/zxyOepuKq7jw/BpU9Wkj7NI3j+b7MrWtoCHX9GD72fwsWEvR3hLmwZ2xe3kn4x9YNFep4/8Q2jC83BXykndAIFKhKDkQhHGSwI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788440987;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=20L8H017f+X+nMpU/Ghy+Mvvvk1JGSQ75hVtn1pe7RI=; 
 b=blRLJLlkqMO9bRBVDrRu3eQhuoqGkilCKfYkRSPyoK9zPCDfbik0Sg7z0k+Vu+EFc9tfLZkRSd/q+Owd+fakraBfrWmlaU2TjPutjKcXvLz7hWCS04StbSHVm1tT+JB7CoTfkg673ORXJgUeTHIxnVPkZWPMsAJnIKpaKwbTtBw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788440987; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=20L8H017f+X+nMpU/Ghy+Mvvvk1JGSQ75hVtn1pe7RI=;
 b=ZiQX6yMACMu5Ymav6Tus7unvzhLHvJrc+PvXBSEeomEdR7IwoWypoXlaENBHUCYs
 QuvvoqfWauBzNFhWj4NoosOPHQ5/0Zefk0YLOZpIbeyfmqaYDn0cmmYhN9CTWW1abD1
 I917eV/xaDVUIxBBvh8GxIsGd6YpB7KPt5lkJuSQ=
Received: by mx.zohomail.com with SMTPS id 1788440984549371.17029183808177;
 Thu, 3 Sep 2026 06:09:44 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/9] rust: mm: add `task_size` helper
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260902-tyr-ioctls-v1-2-e0fdbf8bd108@kylinos.cn>
Date: Thu, 3 Sep 2026 10:09:26 -0300
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 Alvin Sun <alvin.sun@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E115BCEF-121E-4947-AB17-090C474E15FE@collabora.com>
References: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
 <20260902-tyr-ioctls-v1-2-e0fdbf8bd108@kylinos.cn>
To: sunke@kylinos.cn
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 1 Sep 2026, at 13:09, Ke Sun via B4 Relay =
<devnull+sunke.kylinos.cn@kernel.org> wrote:
>=20
> From: Alvin Sun <alvin.sun@linux.dev>
>=20
> Expose the task's address space size. It is used by the Tyr driver
> for splitting a VM's GPU address space into user and kernel regions.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
> rust/kernel/mm.rs | 7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 4764d7b68f2a7..d2dfbb7d43972 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -149,6 +149,13 @@ pub fn mmget_not_zero(&self) -> =
Option<ARef<MmWithUser>> {
>             None
>         }
>     }
> +
> +    /// The size of the process virtual address space.
> +    #[inline]
> +    pub fn task_size(&self) -> usize {
> +        // SAFETY: `self.as_raw()` is a valid pointer to an =
`mm_struct` per the type invariants.
> +        unsafe { (*self.as_raw()).__bindgen_anon_1.task_size }
> +    }
> }
>=20
> // These methods require `mm_users` to be non-zero.
>=20
> --=20
> 2.43.0
>=20
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
