Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D208109B46C
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC65F10E986;
	Tue, 31 Mar 2026 13:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DvFqTxS7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F38410E986
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:36:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 23DCC60133;
 Tue, 31 Mar 2026 13:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9347FC2BCB2;
 Tue, 31 Mar 2026 13:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774964192;
 bh=WKjhZEkOWd+HfB3a5V37QImO1M2O3x4mbu4VMHRoLEM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DvFqTxS73uQndFQgg9uWPmagl2RBoWcgB7li1FUrQbwQRnpbi1w+ut65PSmMjgA0k
 EP396r5ukiQkEGM8O9/kwMqcBKGQkeP1rvi3LqhleePZb7Jz7X0FkbZUnXqWs4B0eG
 +tjqVHAGcRUgqqIcKcZ8WOEQIOCnOppElVeZ/phRqVQVs5CY1iKYT0jYk9E5B31l0M
 v6baC9YZhOpr92HPkdTcI73Z6X2X1zuSyXGf28vJMkik0jRQG+R/bMIS7hA6wIlBfI
 icCRdrbYsaw5gwFwrYeoH2WcMNtUYYSU6aIBNmBXHWZj97fD1GbAFxYzBJQuItOEDp
 Igrjmbhrg1KqA==
Message-ID: <adae6d13-e70b-4377-a9fd-4bfc985e3d89@kernel.org>
Date: Tue, 31 Mar 2026 15:36:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: bitfield: fix broken Default
 implementation
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl
 <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260331-fix-bitfield-v1-1-ebe1a72b4fae@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260331-fix-bitfield-v1-1-ebe1a72b4fae@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/31/26 9:56 AM, Eliot Courtney wrote:
> The current implementation does not actually set the default values for
> the fields in the bitfield. Set it and add a test.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Thanks for the fix!

Please add a Fixes: tag and separate the fix from the newly introduced Kunit test.

Maybe it is not worth adding the Kunit test in here as generic bitfields are
being worked on, but I don't mind.

- Danilo
