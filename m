Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16F606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=d6mAjL4w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF7110E187;
	Wed, 25 Nov 2026 19:59:39 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1E3410E187
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 19:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795636770; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TfChQJlevYzacqlUs5E50T2a4Ex8FOkFSrYn/uNaxZnlNmkfxt+LKyGS0aWJrt7nAf+WeXyezi2Dv15ISzqAqkJZqEfysX2pNxm+AdwRQAEviVZ68t8l/3iGfu/DwQi5r6YYgb97zvP0VtyY/yKX1o1v9VKq8iIuWXKEyqzUkXM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795636770;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XFGeHnO41wQThwSaa5KXLEiWWiuY84ny09QOskOc0hQ=; 
 b=WwpfBSSagcpQAIirt+1FNN4fOeSTu/B8l5ovgqHJ+K8aEm/2AstsbVQc2t3qHst0TP4dUi26TPbLxX7JP8PeC8s7cXFyCKrEv4TqU2S3n3F4R2pxGeveR4Q/FIrROcVLf83obJiYgUJeW19ZmhJEGXY3Hf8dO9SYBzOsOjRuh5I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=d6mAjL4wHpUEOODbjZ7UfyaaVnxoW2SPYt3uZYQ+vg3HvaBNwI/1z/YAp0TG0Wzz1VYWhz+ETlGpdx2wqt5DZmubBE1PVCjcgYPrUPHfmhlbxMFUG4Y4qGRnFH9OIiUZkZ2qfQaZrH2Ira+CU69KDw+aBHk4GQ3LZY3RKCmK5Ck=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=XFGeHnO41wQThwSaa5KXLEiWWiuY84ny09QOskOc0hQ=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795636767086600.8023695989365;
 Wed, 25 Nov 2026 11:59:27 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v7 09/10] drm/tyr: support write-combine BO mappings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261122-tyr-ioctls-v7-9-3a2af624b992@linux.dev>
Date: Wed, 25 Nov 2026 16:59:08 -0300
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
Message-Id: <992B7455-18DB-46A3-8C94-EE5EE937EFC4@collabora.com>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
 <20261122-tyr-ioctls-v7-9-3a2af624b992@linux.dev>
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
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alvin,

This patch does quite a few things at once and I'd rather split this.

The change we _really_ need in your series is the stale cache eviction
problem. It is unfortunate that this is a problem in general, and not
only in Tyr. For that, using the DMA API as soon as the BO is created is
enough. You can do that in patch 6 by calling sg_table() before the CPU
is allowed to touch the buffer, like you already do in this one.

Two other things are done by this patch:

- Honor writeback mappings -> this should be its own patch.
- Add a "coherent" flag, and thread it through the driver.

What it does not do is "support write combine mappings". In fact, write
combine mappings is the only thing properly supported and tested so far
:)

The problem with the second bullet point is that a) everything else
needed to support coherent=3D=3Dtrue is missing and b) I don't have a =
system
where coherent=3D=3Dtrue to test this. If others do, great, but even =
still,
lets do this as a separate series. So I'd prefer if the coherent flag
was dropped, along with patch 8.

=E2=80=94 Daniel=
