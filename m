Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF99606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=KcklkUXa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5082710FF17;
	Wed, 25 Nov 2026 18:50:03 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A359610FF30
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795632593; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q/vgguqfpuRFU9tNviYG3WPmTeozjtgKRbqw3UxCbx+6KPKCBjKSONfzeVE6/rw7aMd78gt41KW+6J9uXuMg6Z84F6EOjBPddD0Jg8b6RCxIRo5MrrJ+eynrMlDriRIoG9U71ypZw5HwNt0+Y1Zgbr6I8jI9fpF1V7jN4IFsUWU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795632593;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=T4QJdIAnF8cgQyJ1JK7OVxMUlUSq0t75T8bZ0NcrZTs=; 
 b=Fd0AShZ0UNNMo8EozlE1i8uEmJ+YgOtfBZiVdMyD1CkXmYecx5D5qRpdmn2oXr5xf6NolXK7WOvK6M/xJ9tgLA2dI0DuCpwRsq7bIAGas7SRXg6lBy8Qqppd/p5UPciNU7zmoA3qvwwOTOJortpbz1ROBEDIitcva7GOHdD+i5k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=KcklkUXa+vK/5d3ehydqeO09yLe3wAnSUn7X6Hvwmz/Z1uZesaddCSn2u/vritIVGyGYhkKbTvBsqv639gKPAqxqMK4Usb4OPyKC1xNCY0xshVX1A/bHC/gKHhXe7re8a5/CWsemLQeT40nU0wIasYrrK5nkqQP/xqBhzAT5OaE=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=T4QJdIAnF8cgQyJ1JK7OVxMUlUSq0t75T8bZ0NcrZTs=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179563259167510.752161362890206; 
 Wed, 25 Nov 2026 10:49:51 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v7 07/10] drm/tyr: add VM-related ioctls
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261122-tyr-ioctls-v7-7-3a2af624b992@linux.dev>
Date: Wed, 25 Nov 2026 15:49:31 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 Ke Sun <sunke@kylinos.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2395489A-A2DD-4740-818D-60636E5CA872@collabora.com>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
 <20261122-tyr-ioctls-v7-7-3a2af624b992@linux.dev>
To: Alvin Sun <alvin.sun@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alvin, thanks for working on this! :)

For v8:

Please rebase on drm-rust-next and list these two series as
dependencies:

=
https://lore.kernel.org/all/20261124-rust-drm-gem-shmem-imported-sgt-v2-0-=
000f7a9ccb8d@jannau.net/

=
https://lore.kernel.org/all/20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@googl=
e.com/

Please switch the ops array to KVVec, as Deborah suggested:
https://lore.kernel.org/all/awYgh-A8JtN899eB@um790/

Please do not add new "as=E2=80=9D casts unless absolutely needed. =
from_safe_cast(),
UserPtr::from_u64() and cv!() for the uAPI constants cover all but
VM_BIND_OP_TYPE_MASK. For this last one, please use a //CAST: comment


> On 22 Nov 2026, at 09:50, Alvin Sun <alvin.sun@linux.dev> wrote:
>=20
> Implement VM_CREATE, VM_DESTROY, VM_BIND and VM_GET_STATE. VM_CREATE
> hands the new VM to the per-file pool and, on insertion failure, the
> caller tears it down, so an aborted creation never leaks a VM.
> VM_DESTROY removes the VM from the pool and kills it, even if =
in-flight
> jobs still hold references (matching panthor: such jobs are expected

There is no way to have in-flight jobs or any jobs running at the =
moment, so I
would drop this part.

> to fault). VM_BIND runs synchronously for now.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Same comment as previously regarding the commit message.

Here is what I would write, as a mere example:

---
drm/tyr: add VM-related ioctls

Currently, the only VM in Tyr is the one the MCU runs in, and userspace
has no way to create one.

Add the four VM ioctls of the panthor uAPI:

- VM_CREATE creates a user VM and adds it to the VM pool of the file.
- VM_DESTROY removes a VM from the pool and kills it.
- VM_BIND maps/unmaps BO ranges into a VM.
- VM_GET_STATE reports whether a VM is usable.

VM_BIND is synchronous only. DRM_PANTHOR_VM_BIND_ASYNC fails with
EOPNOTSUPP.

=E2=80=94

Note how this says _why_ the change is needed, not only what the change =
does:

Currently, the only VM in Tyr is the one the MCU runs in, and userspace
has no way to create one.

=E2=80=94 Daniel

