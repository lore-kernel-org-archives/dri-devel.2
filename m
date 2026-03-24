Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5552AFEC0E1
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55BA10E143;
	Tue, 24 Mar 2026 17:31:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XvxZDYe3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DE810E143
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 17:31:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EA37843983;
 Tue, 24 Mar 2026 17:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D909DC19424;
 Tue, 24 Mar 2026 17:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774373508;
 bh=ihjorTWBm+kJapN1+7d1UWus07r4dI5md9Ppt6Y2Oac=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
 b=XvxZDYe3TJjGPtlpRZn7iNHTgNNHTUoDeIsBKnLE2+C/EIYxphlNrnsFFUg0+IATD
 NChq7jiLi6wEe8fladTmKnWE+UXAz2w94l4m0N4//DBkIAxLTJBBRJRtRCPlTqg378
 4nJlvl4z9byWu9tT9nLeHjZXpHtUS3f63jboQPdB8bTD00Dw9JhGr0WSNcteGhJpkW
 HxLiqvCvLR4Mlv5XoH/sE3fJoNMJMUnbnTO+13w+ZTA2jvK8u+/96ZvDsEgHc/bmWb
 nMqj5t3yLot1KTxkBWZoYmQjzd+CBlBOnG5lmg5HwYqDZJaZpxX+h7DMCoFkR8eUWn
 ddw5b6CmY/dvA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Mar 2026 18:31:42 +0100
Message-Id: <DHB6WU5SYXU7.2QMPFZG1KDOT8@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 01/12] drm/tyr: Use register! macro for GPU_CONTROL
Cc: "Deborah Brouwer" <deborah.brouwer@collabora.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Steven Price" <steven.price@arm.com>, "Dirk
 Behme" <dirk.behme@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>
To: "Boris Brezillon" <boris.brezillon@collabora.com>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
 <20260323-b4-tyr-use-register-macro-v3-v3-1-a87daf9e4701@collabora.com>
 <DHAZ380DRB8A.19SI1OUABRWTP@kernel.org> <20260324130653.74f9c2ab@fedora>
In-Reply-To: <20260324130653.74f9c2ab@fedora>
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

On Tue Mar 24, 2026 at 1:06 PM CET, Boris Brezillon wrote:
> It's defined in ascending bit order in the datasheets we have, so if
> we're ever going to auto-generate those from the xml, we'd likely have
> the same definitions Deborah came up with, unless the script re-orders
> things in descending bit order.

Huh, that is very uncommon; is it actually

	15:0
	31:16

or is it

	0:15
	16:31

in your datasheets?
