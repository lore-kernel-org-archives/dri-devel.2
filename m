Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B927CA5FA5
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817E010EA88;
	Mon, 28 Sep 2026 13:48:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VvQ0AYQo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51AD610EA88
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:48:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21D7140C2C;
 Mon, 28 Sep 2026 13:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F057A1F000FF;
 Mon, 28 Sep 2026 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790603307;
 bh=DuZ9RG51Y4GEDXhLouoO+o5u6/tFI+61S6wJ7IA4vKc=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=VvQ0AYQouiS0Ta2PPVFnkaQ4fZOiLCISxsCOrJfat5gqE6V1fEALaxJY/HrwJgiRV
 f//Qt/oqzyNJFH3rlATAYaJU/LqhWY5MKqU4c1pGPNL5XOKUJek5wZS0ihWGmEN6pj
 xpOtOWolxKjbxfgNS5hsLJiQ8RMd1YailLKDUZf0XU5edPcXxUJjeyV2xucF5IDboJ
 8sm+TP0veTSdoEJDalDI83u9yvP3VJwKYFGRytYpNsrdNyMNJqqwE1B6D5ESKfApDD
 lfTMSfIPhJjIlDgAX4rSnX+S7Gbz9NsMgwEe4ZEqWSUxhNQUd0e/uU7RaowBlXoCqq
 iyCbXfKOjH03w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 15:48:24 +0200
Message-Id: <DLQZW9ZSEQF8.EFP3CFEMUABB@kernel.org>
Cc: <aliceryhl@google.com>, <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: use a single try_pin_init!() block in
 probe()
References: <20260927144417.1280385-1-dakr@kernel.org>
 <DLQIRUGZ3L4S.2HUCTWWXHIDII@nvidia.com>
In-Reply-To: <DLQIRUGZ3L4S.2HUCTWWXHIDII@nvidia.com>
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

On Mon Sep 28, 2026 at 2:23 AM CEST, Alexandre Courbot wrote:
>> +        dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
>
> Don't you want to put this in the `_:` block below, so it printed at the
> actual initialization time instead of the time the initializer is created=
?

No, because the :_ block below will become the PCI device enable guard soon=
. We
could put it in a separate :_ block, but that seemed odd to me.

In any case, we probably should drop this dev_dbg!() entirely, as its value=
 is
quite limited.
