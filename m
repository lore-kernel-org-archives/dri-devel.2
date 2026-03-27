Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E0410F2871
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB73310EF91;
	Fri, 27 Mar 2026 20:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H1croIWx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9D410EF8F;
 Fri, 27 Mar 2026 20:58:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8284A434E8;
 Fri, 27 Mar 2026 20:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92E5C2BC9E;
 Fri, 27 Mar 2026 20:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774645126;
 bh=XlLsEYpYc3Vn4BgPPTHxnqP+JoOWIUm9HXvlVN0npB8=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=H1croIWxsEJ20G4Gy7O3hhhngoHXMBTUmNYSsKkKGmiV+t2lO72QbEHcVYKRfJDVM
 Y035/OIt2XP2763dUGyjfa3ULjb6KOrYSZFaHBv9Vp3e0t5gp6DBCqIXgpKecOT12m
 wEO3egtP7TTjNxyUcVeDtxb5ADFusrXREyuCXsBOuOcgOvzhs02kUVuiZA7TUVqcp/
 pG58TmvQXwSrPRguQVYCfoujBFMM0+6OihTrREW1pIdy2Z8wwKpDQooLFuTp0ByYrx
 cNBAqAvfg6ZeKl7I/1hyue2AcP5s8fHaX52JdPt0672z1h/aYsRGHZuX2uEgMCo+H4
 icWnUDgHj01Kw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 21:58:41 +0100
Message-Id: <DHDV6XWT2WII.14MZGICR8SYIZ@kernel.org>
Subject: Re: [PATCH 3/3] gpu: nova-core: use sized array for GSP log buffers
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
To: <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <tmgross@umich.edu>, <ttabi@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260325003921.3420-1-dakr@kernel.org>
 <20260325003921.3420-3-dakr@kernel.org>
In-Reply-To: <20260325003921.3420-3-dakr@kernel.org>
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

On Wed Mar 25, 2026 at 1:39 AM CET, Danilo Krummrich wrote:
> Switch LogBuffer from Coherent<[u8]> (unsized) to
> Coherent<[u8; LOG_BUFFER_SIZE]> (sized). The buffer size is a
> compile-time constant (RM_LOG_BUFFER_NUM_PAGES * GSP_PAGE_SIZE), so a
> fixed-size array is more precise and avoids the need for the runtime
> length parameter of zeroed_slice().
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Applied to drm-rust-next, thanks!
