Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB095CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08F5F10F7EB;
	Mon,  8 Jun 2026 17:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XQNG40QC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649BC10F7EB
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:36:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EA2D40ADC;
 Mon,  8 Jun 2026 17:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF801F00893;
 Mon,  8 Jun 2026 17:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780940202;
 bh=5lfr28QiDGhTqyG9eIeYlwhwDp5Q8cRi03fbHAnOibE=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=XQNG40QCArX1FXi2xgauKq9GSLDcU2yMFO3MazgovE0r5tEQxn4ukqt/FT1HXM+iS
 gyp8soKq2cLyksg1xBxJEp93ZWCZxT5EmVQQtIeuRNUL4s/iHtN2dqLuP+Uonbd7Zs
 FQ9Fxw7EJ58r3aNzngaOXO4mqQuJ2MHhEZcaely7sPPG+1Wq0jFg29oOTGXpZGShRH
 IQcz1QVEta2kmjo1/giIZdTAwa4l94G9d6/qRqpURkypEhFsBgHTEZvTiI1FMLMoRq
 XtAVh3lqDhUNjMLwbZ3PeASpC9ORAHaNozaFFgGeS5fgQQS843cdzyycyP88Av/guO
 0lsvqkbFaJGNw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 19:36:38 +0200
Message-Id: <DJ3UM0KW4AUJ.1K14QS8R7LXJV@kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: Move gsp register definition
 into gsp module
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>
To: "Antonin Malzieu Ridolfi" <dev@nanonej.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260607140949.152575-1-dev@nanonej.com>
In-Reply-To: <20260607140949.152575-1-dev@nanonej.com>
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

On Sun Jun 7, 2026 at 4:10 PM CEST, Antonin Malzieu Ridolfi wrote:
> Split the gsp register definitions grouped in nova root
> register file to the gsp module which actually use them.
>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Antonin Malzieu Ridolfi <dev@nanonej.com>

Thanks for the patch, the contents are fine.

However, the patch is mangled after fetching it with b4 (probably caused by
multipart/signed with nested multipart/mixed); please prefer plain text (se=
e
also [1]).

No need to resend AFAIC; I can also fix it up on my end for this one.

Thanks,
Danilo

[1] https://docs.kernel.org/process/email-clients.html#general-preferences
