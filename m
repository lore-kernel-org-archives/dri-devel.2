Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441A8FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 20:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A098710EC09;
	Tue,  5 May 2026 20:04:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g2LvAKyW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0431310EC09
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 20:04:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6BA9743D0E;
 Tue,  5 May 2026 20:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3627C4AF09;
 Tue,  5 May 2026 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778011495;
 bh=rWPKB4bZLjFCeMSom22QRVBLTFkyMwURrfqgJpqRbK0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=g2LvAKyW/y5VZs9zrTWgXkxBExnwtuhI8PmFhEdxeYGEE06tjpHwTc5qZP80tEnr5
 Da1whhBVflJZIEuTJAfG8UXLGBUL2DsWL8TPS6o4uTzHHK72TiweMvRDYK4gjqL/XS
 jZaPga/HxLyD8BJZ0+BzYwHkUE1lFNdkkNbAcZ+/+GBAXuxNt1/loD0ntKTQRL8RHe
 yYHYgbX10XRyH3qxlHYOeVAeYEl5WmDSIk9UDtppd79WoEP133YmD2RM1FRDMsJyKd
 RjtrdwuedpLWRY4xg3FfCqML9RjTcBKZOkCZEwkWeIIfIFnr0/fM2aWRrUB1TaIDHF
 F9KaqX4GKXEEQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 May 2026 22:04:49 +0200
Message-Id: <DIB0GYCMV121.2VPS75GHH082B@kernel.org>
Subject: Re: [PATCH v2 1/3] rust: alloc: add Box::zeroed()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260505152400.3905096-1-dakr@kernel.org>
 <20260505152400.3905096-2-dakr@kernel.org> <afoRXrwKjZAJuMaQ@google.com>
In-Reply-To: <afoRXrwKjZAJuMaQ@google.com>
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

On Tue May 5, 2026 at 5:48 PM CEST, Alice Ryhl wrote:
> I suspect some of these imports can be removed when you add the prelude.

Yes, but I want to convert the imports separately, so keeping the change
minimal.
