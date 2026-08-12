Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10070C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E66310E44B;
	Wed, 12 Aug 2026 19:56:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EbgFM+o5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3EE910E44B
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:56:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 048B3600AD;
 Wed, 12 Aug 2026 19:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627851F000E9;
 Wed, 12 Aug 2026 19:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786564568;
 bh=qWAwXk6XLjTZEV49YgLVHYdlotoUwcqlQh9BZ+9HocA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EbgFM+o5xvHPBP548NBcW4GOB/FAiOJuLfoywmC4boUWlgq3JejMoz+qfirv2IR45
 tKYSj68iyTy/qHrB14TDECcIUrrFEbWFI1Sf6OQrY0HsyHIt3AGtaw4wdZlxpCfdJv
 dK5KKc8F255opKGOf2opGXHgX/uKXBnmp81KWKmQApoq1EmtEnZw8oSbhoDP3LEFx0
 NZ/dCqnLbUpj7uz5beKJOeTA4FB1OniZHYhWQRHjPVkjoJbwOamPmQqWMtSpBt9qSp
 XRvrIVaygL5P3473DQhZVUR+Ix7mz23ZE7Uw5XkwRRgQiPOCqopKfN4cBZeC/z6CE0
 pekML9ruYUbBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] rust: completion: add complete()
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-4-5d0b5594e52b@mailbox.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
 <20260812-b4-rust-pci-edu-driver-v3-4-5d0b5594e52b@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 19:56:07 +0000
Message-Id: <20260812195608.627851F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> The initial completion abstraction only added complete_all() and
> wait_for_completion(). complete_all() marks the completion permanently
> done, which makes a single Completion unsuitable for signalling the same
> event repeatedly: once complete_all() has run, every subsequent
> wait_for_completion() returns immediately without waiting.
>=20
> Add complete(), which wakes a single waiter and increments the internal
> counter by one. Paired one-to-one with wait_for_completion(), it allows
> the same completion to be reused across multiple cycles, e.g. to wait for
> consecutive DMA transfers to finish.
>=20
> Acked-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-b4-rust-pc=
i-edu-driver-v3-0-5d0b5594e52b@mailbox.org?part=3D4

