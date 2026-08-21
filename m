Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A45C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB6710F37B;
	Fri, 21 Aug 2026 16:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lCSOi94q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B9610F376
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 16:12:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B8CB44070C;
 Fri, 21 Aug 2026 16:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81B41F000E9;
 Fri, 21 Aug 2026 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787328747;
 bh=o0Yr3816jwben7xnbf0tSDUvuveQ1VWwqzJLEkc9Wxw=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=lCSOi94qi0H4mV+QAJvYZ6Xa2SGjUvdZpsfuU/Z9v/fDHcSdGLCUhE6PdiHtBYdY7
 xILfCZH+vEseCUGgu1lGo5943E1lTEcSuHXe/jp1pG+4tJrGNRtj94zRIhT7rpF3Wv
 9Ie824XNy9cC2UZULqN717trNz5MKc4/8ch+uCq7KCUe6NFwQIHJVs+1gkZYAUjuiv
 SM391nl16lFefv2ea98ebkzlkcCxD6+eKRpUxTqMXrGSsdiSu4F78JSM2+QDJJU7GY
 u/xpp01tUca0TvGUn8pfn/n0d6mYla36LkhP01asewQSfHW4H4IvLTGcApD28e2YuW
 G2Ev6AlNdvClA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 18:12:23 +0200
Message-Id: <DKUR5TGKTJT1.3VR0LSG4WWXJJ@kernel.org>
Subject: Re: [PATCH v6 2/3] drm/tyr: add GPU reset infrastructure
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260819-tyr-reset-impl-v6-0-7b4e1e041fe5@onurozkan.dev>
 <20260819-tyr-reset-impl-v6-2-7b4e1e041fe5@onurozkan.dev>
 <653D47F5-0AF3-44B5-9896-F0AA81F67B61@collabora.com>
 <20260821155814.980146-1-work@onurozkan.dev>
In-Reply-To: <20260821155814.980146-1-work@onurozkan.dev>
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

On Fri Aug 21, 2026 at 5:58 PM CEST, Onur =C3=96zkan wrote:
> On Fri, 21 Aug 2026 12:31:03 -0300
> Daniel Almeida <daniel.almeida@collabora.com> wrote:
>> I=E2=80=99d use dev_info instead, I don=E2=80=99t think a reset belongs =
in dev_dbg.
>
> It was dev_dbg initially, Danillo said otherwise and I changed it. I have=
 no
> strong feeling on both.

Why do you think it is useful to print "Starting GPU reset." and "GPU reset
completed." with dev_info()? How does this help users or help with debuggin=
g?

In general, if drivers work properly they should remain silent. A successfu=
l
reset means it worked properly. What you rather want to print, likely with
dev_warn() or dev_err(), is what caused the GPU reset to be performed in th=
e
first place.
