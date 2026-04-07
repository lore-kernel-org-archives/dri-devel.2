Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C39EEDB7F6
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89B9910E3D9;
	Tue,  7 Apr 2026 10:56:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AOx/AhKD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CFA10E3D9
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 10:56:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B5B4741AC0;
 Tue,  7 Apr 2026 10:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A42C116C6;
 Tue,  7 Apr 2026 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775559412;
 bh=vi6h+oU1AtrPwyy216NypW9GBaAGILDhZ2QBErEvkOA=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=AOx/AhKDiHc6IPL8eZ5Cd6yeXHwdWLO3q5GG1rdSRd/jHZxzoL8qHbsYf7HZvBK9n
 0wBDJDpKUAXw9z4seUzHWKdix3T7F8h+8NChay46FX2CeeFBXfy5+jRe45QOnSJBRr
 15Az0YFG4qP9Xi5pddsPUn9e1Nmulcur/Q5c66jTK1qQcn4idCudOK76BT3WXmDLp9
 f5rZOziSDVpsT3Qkr7SpCmkhayGEIPmLPfOJDrS/zjN+m2DOkcHHepjTb+eotXs8Yr
 PzePGTHE4PoYZUUptxUscWVwe879QSoMrtEr3sbsxKgwTtwqsyTCjMEizhCNrINRoG
 SIfocU1brVXOQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Apr 2026 12:56:48 +0200
Message-Id: <DHMVA3S2MZWV.1JN7WUBZLRWLV@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: require little endian
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
 <a66916c8-8e82-4e54-8e21-b312a7badfc4@nvidia.com>
In-Reply-To: <a66916c8-8e82-4e54-8e21-b312a7badfc4@nvidia.com>
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

On Mon Apr 6, 2026 at 6:30 PM CEST, Joel Fernandes wrote:
> Nouveau does not do this, and no other GPU driver afaics either.

Nouveau has nvkm_device_endianness() [1], which it configured before everyt=
hing
else is done.

I assume that's not an option for later GPUs?

[1] https://elixir.bootlin.com/linux/v6.19.11/source/drivers/gpu/drm/nouvea=
u/nvkm/engine/device/base.c#L3111
