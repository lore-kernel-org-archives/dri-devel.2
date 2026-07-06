Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448F5C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 18:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F44F10EA58;
	Mon,  6 Jul 2026 18:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MBj1061w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8803110EA4F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 18:26:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D4B86600C3;
 Mon,  6 Jul 2026 18:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA2C1F000E9;
 Mon,  6 Jul 2026 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783362392;
 bh=FDm++NGlD0X7G8TNYLMh0qBiFiboZhD4zWY4vRQWYW0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=MBj1061w1YwYlxADS2WvGpXlKBKSiez16AzyzSwz6FJKF0U1rqz2+buK+hUDd9Bhr
 KestkTbRojdCTh/94OP9cX1ey/OK02DwuosR5sLekFBmpbkEzt2rBfVpl8alZt0etU
 be3rWO289HxL5nsqAP+eMM6j+Z9SesBBg0H1bWM5ObEWpUpIZe3po5+0zmDNIms9++
 4nR8oAqyrbixaMI+1B2DlTWIGutuFbt5AVSzsAAWGLQ1rRBfueCX9E9zQ+vhaNPFWe
 T7pH0ptu8VzM48xiM90WOLx80tP/uueT/5320eVFBw2+aIGc7RiqZnlnuIaPduL/AC
 48SBV0DstyBJg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 20:26:28 +0200
Message-Id: <DJRP7FAGEEWU.26PMTHSN6MWMU@kernel.org>
Subject: Re: [PATCH 4/4] drm: nova: Add a GETPARAM parameter to read usable
 VRAM size
Cc: <nova-gpu@lists.linux.dev>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260706053413.154135-1-apopple@nvidia.com>
 <20260706053413.154135-5-apopple@nvidia.com>
In-Reply-To: <20260706053413.154135-5-apopple@nvidia.com>
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

On Mon Jul 6, 2026 at 7:34 AM CEST, Alistair Popple wrote:
> +    /// Returns the total usable VRAM size in bytes, i.e. the summed len=
gths of all usable FB
> +    /// regions.
> +    pub(crate) fn vram_size(&self) -> u64 {
> +        self.usable_fb_regions
> +            .iter()
> +            .fold(0, |size, region| size.saturating_add(region.end - reg=
ion.start))
> +    }
>  }

Please make sure to run the rustfmt make target.
