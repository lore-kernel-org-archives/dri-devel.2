Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F6FCD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D2410E78D;
	Mon, 22 Jun 2026 16:44:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MHhIZbOG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE5E10E78D
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 16:44:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D562601F3;
 Mon, 22 Jun 2026 16:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98F81F000E9;
 Mon, 22 Jun 2026 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782146639;
 bh=VeRf5a1JjJThLLC8DXHxL+lf7PQW42Pqa0PPW6PYmus=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=MHhIZbOGeBK9U1PN933ovM8rwgZtCOWwm5gDSKyBc4FrO8FEKGqYq9vfaS+ppc5Ob
 SO9uyefZxk/2nWuOBmGA42rQPU+0jRDxoR6ftbZjpwjiUkM4s7+/qxUk1qQs55jHln
 9Sgo1Vg2/uGvDKNpFTK/s0jUzm3zzg5oom0vMucJ/gACj3fUsPYJCdm0T5jvQ5PUVK
 HYxngmkWDW1W4iniPFpF1wlKSGb87hdoem7fwGTQ8OOHOzF+xWH+MBWNFboHHV2uyM
 oAC700Ekuo/F+SwZDiZuj/Oq8ugE4fqnMjQUwYj/DIHoAHCk/q/XmerHQBoXPP0I12
 cACL3I/1T+vWg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 18:43:55 +0200
Message-Id: <DJFQ99U8SXA0.1LYOKI1A4F0NB@kernel.org>
Subject: Re: [PATCH v3 3/3] gpu: nova-core: gsp: Extract and display usable
 FB regions from GSP
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260617-boot-vram-v3-0-20b9ec5fe9f2@nvidia.com>
 <20260617-boot-vram-v3-3-20b9ec5fe9f2@nvidia.com>
 <DJDUCF0FN8M3.OKSUDWCKJ4PR@kernel.org>
 <DJDXNDGXLZZY.8IEHLBTRKCQO@nvidia.com>
 <DJDY31W202BF.4OHIYPH1MEDX@kernel.org>
 <DJF6F4194K7C.P89RQTXATU6O@nvidia.com>
In-Reply-To: <DJF6F4194K7C.P89RQTXATU6O@nvidia.com>
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

On Mon Jun 22, 2026 at 3:11 AM CEST, Alexandre Courbot wrote:
> I took a deeper look at OpenRM. The zero FB region error is emitted when
> mirroring the list of FB regions [1], which is a default HAL method.
> Zero-VRAM chips like Tegra replace it with an empty stub.

Thanks for checking! With the dev_info!() logs fixed,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
