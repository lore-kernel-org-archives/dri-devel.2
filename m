Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFA0CDB46B
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 11:30:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115BB10E0B4;
	Sat, 20 Jun 2026 11:30:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QiroeYfC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E57FB10E0B4
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 11:30:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCE54600AE;
 Sat, 20 Jun 2026 11:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7E91F000E9;
 Sat, 20 Jun 2026 11:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781955049;
 bh=EH+Um+Qh9d/qm5Ekr4h7boqJBdnm9jaLYT6h4CVUUZo=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=QiroeYfCPXnXr4ZGETMecj03X+Cl4/fNxMR6bk46XGoaLNaisI3Gi7TLWbhnIYxfU
 qBke0ifdpjPLNDj/+O+dS5mEOXlAhpLXOLYNIT2ud9fXnYtytHMj7zKZYplp2KpeUg
 q3HA8mpFI2ufLU0Avn4aa8nGK+bi5OzB2pnP6U8SpFLLN703nG8UatbwDzJOK8Sy7w
 X8t5ESlM+DDzIhRJV62cnHUB4uFxpTYPpmyMAnFG8ZF7Yz67Lbkr2wzi7aMQcmkio5
 QJ3p7474knia6t93mK6yFFOuA79jUUDYnUr49Ce4+pOsW6/yvS10r4b2JALWUa5y1w
 aq4xCkW/lsMvw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jun 2026 13:30:46 +0200
Message-Id: <DJDUCF0FN8M3.OKSUDWCKJ4PR@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 3/3] gpu: nova-core: gsp: Extract and display usable
 FB regions from GSP
References: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
 <20260617-boot-vram-v3-3-20b9ec5fe9f2@nvidia.com>
In-Reply-To: <20260617-boot-vram-v3-3-20b9ec5fe9f2@nvidia.com>
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

On Wed Jun 17, 2026 at 3:24 PM CEST, Alexandre Courbot wrote:
> @@ -377,6 +378,21 @@ pub(crate) fn new(
>                      Err(e) =3D> dev_warn!(pdev, "GPU name unavailable: {=
:?}\n", e),
>                  }
> =20
> +                if !info.usable_fb_regions.is_empty() {
> +                    dev_info!(pdev, "Usable FB regions:\n");
> +                    for region in &info.usable_fb_regions {
> +                        dev_info!(pdev, "  - {:#x?}\n", region);
> +                    }
> +
> +                    dev_info!(
> +                        pdev,
> +                        "Total usable VRAM: {} MiB\n",
> +                        info.usable_fb_regions.iter().fold(0u64, |res, r=
egion| res
> +                            .saturating_add(region.end - region.start))
> +                            / u64::SZ_1M
> +                    );
> +                }

Drivers should generally remain silent when they work properly, some except=
ions
are fine, but this seems too verbose. Let's use dev_dbg!() instead.

Also, would it make sense to (rather) warn in the else case? (I think OpenR=
M
treats this as error, although the check in OpenRM checks whether there are=
 no
regions at all.)
