Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACCAC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C2910E2F5;
	Tue,  7 Jul 2026 17:14:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ORVn9N7W";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4DB10E2F5
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 17:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783444482; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=II9cW/m5Vv18fw/Fz0WLyRsiGR6pKU06k+7ZwMGqReK255ZDRP+Jcp5dBlcizDWNyvEanGLJAxhtbX2689uNiQHmw6Wa9j+MeejeWwFXdRa3Ncl0GBynkxxAnywIU1y/SXh88KtqABYgZGvhyTmTfatUwJ3YXgWTJFyTLnnGjLk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783444482;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fEaD+gRjp8aYJ0as2zjJ9AwHePMS8+98otLPU9UgGEY=; 
 b=NF3cGoe+89Uz0P9E6l0xjqep6c1vBs5OJJ3jFlQYC94rlcmLovPksrhYRmUI7e/1t+kOWHicCBLvO14LH3btunv4gfXdtllXAcfzHSRxzc6+82CHXvuaV37slE/Y56sDnPSRM9Us1YGpWIGEFGfxdFKZavuEJ5VgKK5GzuUw+ms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783444482; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=fEaD+gRjp8aYJ0as2zjJ9AwHePMS8+98otLPU9UgGEY=;
 b=ORVn9N7W+sewhCy0ODkKQiTiYiIu8blGoZgZYks+GXl3DwIhze+UBxhL88yseY7q
 KZsWnlwNvAalMQUWiqQ/AUv+RVX3Em9Tfc0Exhem3ygzUzXJLA3rbf48HlVJnyoKL0X
 dhD/xcgwYmXTkDul9KnOmpl+HpUxZDMb/qKpIKTM=
Received: by mx.zohomail.com with SMTPS id 1783444480458298.4850949227821;
 Tue, 7 Jul 2026 10:14:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 01/20] rust: io: add dynamically-sized `Region` type
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net>
Date: Tue, 7 Jul 2026 14:14:20 -0300
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
Content-Transfer-Encoding: 7bit
Message-Id: <9AC77170-279D-4C0A-89F7-8D07F418AADF@collabora.com>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-1-72cd5d055d54@garyguo.net>
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

Hi Gary,

A bit late to the party here, but going through this series one by one :)

> On 6 Jul 2026, at 09:44, Gary Guo <gary@garyguo.net> wrote:
> 
> Currently many I/O related structs carry a `SIZE` parameter to denote the
> minimum size of the I/O region, while they also carry a field indicating
> the actual size. Proliferation of the pattern creates a lot of duplicated
> code, and makes it hard to create typed views of I/O.
> 
> Introduce a `Region` type that carries the `SIZE` parameter. It is a
> wrapper of `[u8]`, which makes it dynamically sized with a metadata of
> `usize`. This way, pointers to `Region` naturally carry size information.
> This type is required to be 4-byte aligned.

Why 4, specifically? i.e.: I wonder if this breaks u64 mmio accessors?
> 
> Expose the minimum size information via `MIN_SIZE` constant of the
> `KnownSize` trait. Similarly, expose the minimum alignment information via
> `KnownSize::MIN_ALIGN`.
> 
> With these changes, it is possible to add an associated type to `Io` trait
> to represent the type of I/O region. For untyped regions, this is the newly
> added `Region` type. Remove `IoKnownSize` as it is no longer necessary. Use
> the same mechanism to indicate minimum size of PCI config spaces.
> 
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

If MIN_ALIGN = 4 is actually intentional:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

