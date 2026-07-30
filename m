Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B2BC55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:01:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6E910F094;
	Thu, 30 Jul 2026 21:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b+Xb36Ks";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCDA10F094
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 21:01:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B13434350C;
 Thu, 30 Jul 2026 21:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413C01F000E9;
 Thu, 30 Jul 2026 21:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785445288;
 bh=duaBY51tgKC8NQcPGLknzwB/0a/mPotPPUB322nfeqg=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=b+Xb36Kst38BRaBcSTjkgIfYPG61U1867WRbeuQ7X58KWBT3Wp5AyV8HqIxv55jAA
 ifhH1sK7XTbkXzX5/Lb9n27OAq9jJoY3BAoYpAGUPDGFYDRNeJnpjF6i1iEEUGBPpc
 CjadtKffVREjSEm65ZK6+PaP36qcOq/LcvIxgJHKkN90DJoplqCqZ7su/n8dXrrWX9
 QA+45Nikmfjj2EasJ3zMHMvsBMaSE/XBRdMHbOWgNnnNCPnro0XKFoYCD/q/1IaIKW
 yS9Z7tGN7+8e9aOzjTbUVd8+/a/yEmhf9eCkiC6EFb7yhKLkuF8yjzWF62M68rBofr
 gd1qddSNGuBMw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 23:01:18 +0200
Message-Id: <DKC7J1TB8TZN.1LT1GJ0WP9LR0@kernel.org>
To: "Gary Guo" <gary@garyguo.net>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 05/11] rust: net/phy: remove expansion from doc
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Dave Ertman" <david.m.ertman@intel.com>, "Ira
 Weiny" <iweiny@kernel.org>, "Leon Romanovsky" <leon@kernel.org>, "Len
 Brown" <lenb@kernel.org>, "Igor Korotin" <igor.korotin@linux.dev>, "Rob
 Herring" <robh@kernel.org>, "Saravana Kannan" <saravanak@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, "Drew Fustini" <fustini@kernel.org>, "Guo Ren"
 <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-usb@vger.kernel.org>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-5-56fccbe9c5ef@garyguo.net>
In-Reply-To: <20260629-id_info-v2-5-56fccbe9c5ef@garyguo.net>
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

On Mon Jun 29, 2026 at 2:39 PM CEST, Gary Guo wrote:
> The expansion serves little purpose and it can easily diverge.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

I did not pick this one up, as it is not necessarily needed by this series.

However, I agree with the intend and I think it did diverge already before =
this
series.

FUJITA, please consider to pick this one up, or let me know if you want me =
to
take it.

Thanks,
Danilo
