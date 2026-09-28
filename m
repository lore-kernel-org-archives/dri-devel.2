Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94120C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD01910EA8E;
	Mon, 28 Sep 2026 13:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HHsOIZ2K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D8E10EA8E
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:56:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A73B8407F0;
 Mon, 28 Sep 2026 13:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4771F000FF;
 Mon, 28 Sep 2026 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790603768;
 bh=tSm+YTD742o0zfj6zDu82eqC0y8uINQoeZ9wBJfEDbo=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=HHsOIZ2K4oD0hfXATZ4G5wrt8ugd2HYGvi2DJtAXYENvo4O5iDdfDf+Jnf19phXRf
 2CutW1X1+t52SVnfs4pxsGwzwxzC/LBCJgvH1u5/5MwGc40SkaZyD2IVn9aVIy7FAZ
 fdYt1RE5zzGa2z8KD+NKpcdbctd+y7iKL9G1vgsZz3AiOItv0w/txKJFFxXCKWXrWb
 CDHFlZZJoKy79KaZSXcbJCwHRhCPWIde1fGuHq9Li9MNz+CiEAST01WwZDPHtoNzKI
 VO4dbkCHmySG6fcViV9qd23nHfh7Tocaqx+eVub3tTpxyiR9yQXgtCDvJ3CzfhFVPI
 NdZKGpQgg3TbA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 15:56:06 +0200
Message-Id: <DLR0263QSRRB.L2EQ3NXDYBT9@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: use a single try_pin_init!() block in
 probe()
Cc: <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Gary Guo" <gary@garyguo.net>
References: <20260927144417.1280385-1-dakr@kernel.org>
 <DLQX3FCYMAGD.3MS8E1JK5J7D2@garyguo.net>
 <DLQXLV1FYMQS.JBP531K4P4T8@kernel.org>
 <DLQXTBWUJWGP.WGY6G88ATQM7@garyguo.net>
 <DLQXWXRP3P1J.28SLFOJJQ2EDK@kernel.org>
 <DLR009WMVVQ5.26C5V2E6GFD40@garyguo.net>
In-Reply-To: <DLR009WMVVQ5.26C5V2E6GFD40@garyguo.net>
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

On Mon Sep 28, 2026 at 3:53 PM CEST, Gary Guo wrote:
> Does this fix it for you?

Yes, it does, thanks!
