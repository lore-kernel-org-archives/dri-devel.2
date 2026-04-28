Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F25FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 432BE10E307;
	Tue, 28 Apr 2026 10:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ahaIUlJh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92E810E307
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 10:18:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9475E44863;
 Tue, 28 Apr 2026 10:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B305BC2BCB5;
 Tue, 28 Apr 2026 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777371521;
 bh=uHPyZdCkzCI448zeZqMv+wyuQZjfNzjXPtc17YEXI8U=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=ahaIUlJhSg632TunX/r/O68Yo4SbmrVt4yior8VLXk69Jba9ibkONUKWZOOfB1zWw
 g7lXj77kVrRSt9fD/KiW2ddFAFXjjNUIaqfUMW6xQIGGKxz2tef00LA/dZ+edSb/Pr
 kw/fkvFY6ff6u01bmbSObWtJsMXPQmyWnWXYx7twjW6YKwkYsJnMURdhIkx0pVlG3y
 sFdExSiuJ5GgR3VM3L4CoB8LHm4d6YDqcUzR3ErHcOdV6GkKK/gSPldPTm/h+p2pwS
 gqc5J+9EniuR3uZ+DB+9ohQN5ibMQ8YSf+7EwVrzVZ7rkK2cJnj5DGy9yk1S8+EzYJ
 AwwMdmK2nYdqQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 12:18:36 +0200
Message-Id: <DI4PMAG5RHC7.165W6MJA3R4TQ@kernel.org>
Subject: Re: [PATCH 1/2] rust: auxiliary: add registration data to auxiliary
 devices
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427221002.2143861-1-dakr@kernel.org>
 <20260427221002.2143861-2-dakr@kernel.org>
In-Reply-To: <20260427221002.2143861-2-dakr@kernel.org>
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

On Tue Apr 28, 2026 at 12:09 AM CEST, Danilo Krummrich wrote:
> +impl<T: Send + 'static> Registration<T> {

+ Sync
