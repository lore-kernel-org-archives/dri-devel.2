Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE82C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B8F10F5A9;
	Thu,  3 Sep 2026 13:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="jWyuip5R";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7344910F5A5
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788441190; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=k7etm9LDlJZNiWzdK/AdPOIgZ8l9WeQ9tY+28rROGbZ9KIepmYpmVR/plJwsI44rZnKz0T9pXbaBmKYuzSx/RmBa3O05aB0V0CMr9zPz/kozZ+AqTxjxyTA3S1gzVdF3F7fl9DgCfFSKieJTC2kd0U8q29VC00o++CgtzNMZ10Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788441190;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=uJI6JQLsYv4HW0vAY5ug+uBCPvyVy4swuM+6iRXROac=; 
 b=FYhQvYaQfyJOPBpM3jQVMgEYyck06k5108qpCbpBXIdddmEfUC8feoKoKjQVQl08We+SE5ljVHkVViJe7L4s8JXqAw22el26Kj8oU6DF7seV5mv9GOmrgoKqWOTiraRj9khbHjpnGtIla9eGmJHOikyIST8XVuBFwu4WKq6R+PE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788441190; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=uJI6JQLsYv4HW0vAY5ug+uBCPvyVy4swuM+6iRXROac=;
 b=jWyuip5Rj1hTP5EM31wAvwmwxrq+E/qbzPiSS5nDZZLDbQN89z913aeHoOExPMhd
 A/R3hq042q0lRByXU+EA7uJnAW9xxf8cFZEuVYMX/6gKHO4xSQI/swNxrX1P6z/xWIs
 21mI+cgG3gAhZwSCkblVIX4aVniKwtTGHVijLwbQ=
Received: by mx.zohomail.com with SMTPS id 1788441188698154.96329628710419;
 Thu, 3 Sep 2026 06:13:08 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 3/9] rust: sync: arc: relax `ForeignOwnable` for `Arc<T>`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260902-tyr-ioctls-v1-3-e0fdbf8bd108@kylinos.cn>
Date: Thu, 3 Sep 2026 10:12:49 -0300
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
Message-Id: <012145F0-65B6-4017-8EE8-0D94E428BBF0@collabora.com>
References: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
 <20260902-tyr-ioctls-v1-3-e0fdbf8bd108@kylinos.cn>
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
> Drop the `'static` bound so that refcounted values borrowing from a
> driver registration scope can be foreign-owned by the XArray
> abstraction.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
> rust/kernel/sync/arc.rs | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 5ac4961b7cd20..cd6faba84ffcb 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -363,11 +363,17 @@ pub fn into_unique_or_drop(this: Self) -> =
Option<Pin<UniqueArc<T>>> {
>=20
> // SAFETY: The pointer returned by `into_foreign` was originally =
allocated as an
> // `KBox<ArcInner<T>>`, so that type is what determines the alignment.
> -unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
> +unsafe impl<T> ForeignOwnable for Arc<T> {
>     const FOREIGN_ALIGN: usize =3D <KBox<ArcInner<T>> as =
ForeignOwnable>::FOREIGN_ALIGN;
>=20
> -    type Borrowed<'a> =3D ArcBorrow<'a, T>;
> -    type BorrowedMut<'a> =3D Self::Borrowed<'a>;
> +    type Borrowed<'a>
> +        =3D ArcBorrow<'a, T>
> +    where
> +        T: 'a;
> +    type BorrowedMut<'a>
> +        =3D Self::Borrowed<'a>
> +    where
> +        T: 'a;
>=20
>     fn into_foreign(self) -> *mut c_void {
>         ManuallyDrop::new(self).ptr.as_ptr().cast()
>=20
> --=20
> 2.43.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

