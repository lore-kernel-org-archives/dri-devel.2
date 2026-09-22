Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F21C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C98110ED1E;
	Tue, 22 Sep 2026 14:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DhgkK8MU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E6910ED53;
 Tue, 22 Sep 2026 14:35:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 496A160200;
 Tue, 22 Sep 2026 14:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499E61F000FF;
 Tue, 22 Sep 2026 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790087700;
 bh=KlbmuMxkLkoxuH6oBTyGHj5Wu5Zm16Y5Kw/5vSn8XIg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=DhgkK8MUcycLpRmE6lKgjwUAQSEMQlBlYhu8F0yUAhEOaR3ya3vwei4H3JmHqqqCV
 yCRLObzvCszsYxMELOFj91Vxv6hQXsiKkVqBXRzKTXgUoORkELo/PnBv7NK2sZLvyU
 OluB9RoD9ac8FGdL3meQeq6eVCLjlD/h+99ZYq0pUSZ0XUkAzdmpcbSk+jJ8tkaqCT
 fkgKY8PkKUjugPCXUBb9Yl5q03WyxZtkTSl9ewmIR24j/yJc3HP4CLvRbMp5/PNwbj
 MriE240BfaQUp5tespqgyhztYV3IGo+Iz3Hi19TIy44b5Up3rRFygj3ijWwPZK7Sbz
 TB9a3XOMhA9hA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Breno Leitao
 <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir
 Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>, Matthew Brost
 <matthew.brost@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi
 <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Dan Williams <djbw@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-coco@lists.linux.dev, linux-acpi@vger.kernel.org, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 0/6] configfs: Allow the registration of const struct
 configfs_attribute
In-Reply-To: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
References: <bHvLFyR13nE7HUTBaSLSUZOfB-goGIQLnTtXl9nIQ_beVuvnPA2GpKpdWw-JM4MamQAdiSxOnCc_msKnwqqISw==@protonmail.internalid>
 <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
Date: Tue, 22 Sep 2026 16:34:46 +0200
Message-ID: <87tsnh2w3d.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:

> The attribute structure defined in driver code never need to be
> modified. Allow them to be marked as const.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

For the rust parts:

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>

@Breno, will you take the entire series through your tree?


Best regards,
Andreas Hindborg




