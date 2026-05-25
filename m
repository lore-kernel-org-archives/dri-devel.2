Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4608DCD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 18:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B9410E351;
	Mon, 25 May 2026 18:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZkdbRh2/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9451D10E351
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 18:35:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A2DF40DD3;
 Mon, 25 May 2026 18:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AE21F000E9;
 Mon, 25 May 2026 18:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779734124;
 bh=8I9hU33bJQ5PLTuDLN2eC0OwStTxwXRA6BUZDh0Otn0=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=ZkdbRh2/HgrEbR1pAOgG7yM9JHR2Yt2zro76hRt5WXIN1/XamIR8XYo+wxBURzQv+
 sPBHbG8Eq7WNYs7QyPjeQ/G+qiUwneuNFw9r+ftJ+2rKnDsLmTLVM2bnUFampd71og
 CeXOB8inqmfymgq9uF/ehdpV3dtevXcvfngnyVfkqzB7+BV9L43XbJ7feu8+z6rzVR
 E5d37vx6vc35yFHZL6d9UhY+NwAWPjOOOCQrB95yI+LUxMO9qwE44X4eNIheTzAoUd
 sJLEMSJjfyWDpEV3yj9IaByBB1t//QWbNwUKO3XcCDpjMVyFwqcC/6TaBr/DQwdsoC
 CCx0jAdBaQX9g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 20:35:20 +0200
Message-Id: <DIRZ3BPC3RP6.14SNZGB7O9P1G@kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 00/22] gpu: nova-core: vbios: harden various array
 accesses and refactor
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
In-Reply-To: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
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

On Mon May 25, 2026 at 3:57 PM CEST, Eliot Courtney wrote:
> We have some code that accesses arrays based on values from firmware.
> This patch series makes a bunch of those accesses more robust. This
> series only touches accesses that are not guaranteed to be safe by local
> invariants - some accesses are safe due to earlier checks and I haven't
> modified those.
>
> This series also refactors and removes some code that can be simplified.
> In particular, it removes `FwSecBiosBuilder`, removes unused fields,
> and moves type and constant definitions closer to their usages.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Going to pick this up now, everything else should be easy to follow up
subsequently.

Thanks,
Danilo
