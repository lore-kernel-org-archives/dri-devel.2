Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D802C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB30410E1E0;
	Mon, 10 Aug 2026 11:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FbF2g1EG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2AF510E1E0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 11:15:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6BDC943A0C;
 Mon, 10 Aug 2026 11:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D576A1F00A3A;
 Mon, 10 Aug 2026 11:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786360537;
 bh=XRWYCBrquG5DAJ/NRjL4Ab5YIiDOl41JyD/GrEtkEME=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FbF2g1EGDtBAiJBqPJ5WaDnXn6cNxWdLUur1yuHRZkxjiv8NbCxcgYMbQg6xDh8Y9
 90cUL+Zk5CelWEdd8DaT+TaqGsnxCeDsqtZ9zRRC6dz4sFeKTW5eFUUPtJLVyiMn+n
 AF8N3399oDc9Zi4rDndmkW9q6ZxWMdZ2WPYW9LrhxQxgkmfxhL7Yokbt2iA7XbvPVe
 a/VfRMCyUjxH+2E7kDZOfdb/SdAQgvbvvoAQrJCeRqiQcObgsA/oYtCOP9Mvw8RFNj
 HOZ5OrmR70XEWAa/ETwQmLql5aOLGbIxcW8+2fkwOfSaOI/s4ts0bhckNHoUqL2Y04
 a+bJ6ww3sn1Xw==
Date: Mon, 10 Aug 2026 12:15:33 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Levente Szajko <raedrimhun@proton.me>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: backlight: Use sysfs_emit() instead of sprintf()
Message-ID: <anmy1YLtzj89bqfb@aspen.lan>
References: <20260805135027.43890-1-raedrimhun@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805135027.43890-1-raedrimhun@proton.me>
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

On Wed, Aug 05, 2026 at 01:51:39PM +0000, Levente Szajko wrote:
> Replace sprintf() with sysfs_emit() in the sysfs show callbacks of
> backlight.c and lcd.c, as recommended by Documentation/filesystems/sysfs.rst.
>
> No functional change intended.
>
> Signed-off-by: Levente Szajko <raedrimhun@proton.me>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
