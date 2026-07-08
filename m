Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83575C43602
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9CD10E5FC;
	Wed,  8 Jul 2026 12:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="P2BamEQP";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2ECD10E5FC
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 12:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783514132; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IgwsLR4YXBgeg9hdXqWl3cRAQoCUFHeID18vfCW14pLGEsBs2lTGBH0XWXt4+DsG8gkfddyt8lct1gzG8rPkohvfBp0xUXc8UyiD0SjHLoL1o/OfUNp2DcaBZuoXVUOtkM+tuP24oCrkRrd1vtsSRWcVRet7OxiLMFU4+OVficI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783514132;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iVSkh2VwHSzz7wWJRMIJkqotFEcn/VKW9uhYBLa2OGc=; 
 b=lC4muKZKKPm0kaluZqEAn0zONJITLYX5/jK9Q+XVJGg12BIVqNcv8ZaLIpuzMaa7xXz3ZymEDNHjfNSYjUCQr+ShwlBwMkKAmYv2QgVw1j5zYN5xMBcs580ujnMW06riHAXVjJmgUDxEVJA9t3Nepv+2Q7Mywz1LwfQDnJksiO4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783514132; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=iVSkh2VwHSzz7wWJRMIJkqotFEcn/VKW9uhYBLa2OGc=;
 b=P2BamEQP4hm1JT6pEhN1zEc9jKWFUKzPpewzYeYr4Y3RaTGV58Wi7FWb3yGQMlOF
 Mjme7sx7/yU+7mR5by6jGul74PhS3s/Xbi0KKhMkohDU8ebCyJnUZSxQo/ozJAiu7gR
 ECWXYuo4EP2YOMryQdUBFpETza0KZRa+4XvDebzc=
Received: by mx.zohomail.com with SMTPS id 1783514129301929.26979926663;
 Wed, 8 Jul 2026 05:35:29 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 06/20] rust: io: rename `Mmio` to `MmioOwned`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-6-72cd5d055d54@garyguo.net>
Date: Wed, 8 Jul 2026 09:35:09 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A9DE6F3-F8EC-4C85-B92C-619839DD4985@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-6-72cd5d055d54@garyguo.net>
To: Gary Guo <gary@garyguo.net>
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



> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
>=20
> Most users would more commonly reach out to a view of `Mmio` rather =
than an
> owned instance of `Mmio`. Only implementor of `Io` like `Bar` or =
`IoMem`
> would need the owned version. Thus, rename `Mmio` to `MmioOwned` so =
that
> the name `Mmio` can be used for the view type instead.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
>=20

Hmm.. thinking a bit more about this, shouldn=E2=80=99t the adjective =
precede the
noun? OwnedMmio would mimic the English language and there is already
precedence in RelaxedMmio.

=E2=80=94 Daniel


