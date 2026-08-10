Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E146C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630D310E9E1;
	Mon, 10 Aug 2026 22:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CS2tcSz+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E8C10E9E1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 22:19:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 563C641650;
 Mon, 10 Aug 2026 22:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CAC1F000E9;
 Mon, 10 Aug 2026 22:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786400392;
 bh=6VzMGGCDKZ2c03Qb8RlyKh4sDgz99VXrq656Q+K06uU=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=CS2tcSz+axRoEgTMw8bybfVdLgPQpcHkuaKP2eI6sRWr9ujRcu33nlO062uM1HvjI
 JWhqi61kq0xMaS7LURblKY4X0emgbNZnN1XsJ0b6QN+bu/Ul1wNfH1+eIFqr+yRZP3
 rASH6B5XTMS7k6SLhLM3vBhVu9mMroZqMqvxwEt/Tt2g6IcdClONucpmfr0+/N/bYn
 DaH7BApanFI4CuCgUFw3lzPeB+Puf9xl+lnC5DrnHZQh/2E9uSug8xEmhJ/6BqMDA7
 eekpbrxp+lSk/GepcUjt64yLzXCg7ka9nX0zVb4TZjMwDFDIeWa1wygbzm0Zo0J340
 oqwQtRPnmDWKw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 00:19:47 +0200
Message-Id: <DKLM34SJR4GR.11ABPWKZJSTK8@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 3/3] drm/tyr: add GPU reset infrastructure
Cc: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
References: <20260708114358.957305-1-work@onurozkan.dev>
 <20260708114358.957305-4-work@onurozkan.dev>
 <D388C501-9903-44A7-BFD9-3BFD91502FAC@collabora.com>
In-Reply-To: <D388C501-9903-44A7-BFD9-3BFD91502FAC@collabora.com>
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

On Mon Aug 10, 2026 at 9:44 PM CEST, Daniel Almeida wrote:
> As I said on the cover letter, I'd rather keep the 'bound design for now,
> leaving the door open to the Devres approach that we will eventually need=
 in
> the future.

What exacly do you mean by this?
