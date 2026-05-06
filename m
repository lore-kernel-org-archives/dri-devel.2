Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CE9CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 16:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E529F10EE30;
	Wed,  6 May 2026 16:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YS5tB5Tk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8DB10EE30;
 Wed,  6 May 2026 16:49:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 92C5142A64;
 Wed,  6 May 2026 16:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE787C2BCC7;
 Wed,  6 May 2026 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778086157;
 bh=zqAqFen5VqadetPQBTdp38DxpOmtB/64SzLHXItI+ak=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=YS5tB5Tkh2OeWs0QCCxjecg+tlCPkNt91P+5g6NR3YiN08X5RvdixR+JnYttFHAlw
 npP5L0ntxJga6GYPC5nQfvl3WyjIwIPJ9oNQgkzFVluyizR9IXtP9gBuAMEiZ03w5a
 SgzPxajMkszVMSIYtzrBx69l7fTiOKZNLxiOiE8+BOEzWWljrPSBcOZeKlmzrwBpNw
 flmcafFI9OLYj43lmialq0z/jOjXSyT7soQV3n6yi4f92b5zDyJHC97UmDztzMTYW2
 urLM15FEikjyLVeNxbyjOzUWVGvE9cDqXB+jMfem8+Q0CKtO8ZxAurjA5Y1ho0cE0I
 0eMKu19VtWdJg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 18:49:13 +0200
Message-Id: <DIBQXQ8J3N3H.10YAS0C3O6O2J@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Ching-Chun Huang" <jserv@ccns.ncku.edu.tw>, "Chia-Ping Tsai"
 <chia7712@gmail.com>, "Timur Tabi" <ttabi@nvidia.com>
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/2] gpu: nova: rename drivers to use kebab-case
 convention
References: <20260316120820.2117081-1-yphbchou0911@gmail.com>
 <20260316120820.2117081-2-yphbchou0911@gmail.com>
 <DH56PG8GLW4X.2QMHJ91J9D29N@kernel.org>
 <DIBP25O5HJ09.2SRQU8QS7VUDN@kernel.org>
 <20260507004701.G4851@cchengyang.duckdns.org>
In-Reply-To: <20260507004701.G4851@cchengyang.duckdns.org>
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

On Wed May 6, 2026 at 6:47 PM CEST, Cheng-Yang Chou wrote:
> Sorry for totally missing this! Will send a v3 patch by this weekend.

No worries -- thanks!
