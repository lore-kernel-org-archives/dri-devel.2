Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6158DC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 23:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A401310E2B1;
	Tue, 30 Jun 2026 23:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SzVMxtqi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CAA310ECF0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 23:12:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0253D43A53;
 Tue, 30 Jun 2026 23:12:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F8E1F000E9;
 Tue, 30 Jun 2026 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782861119;
 bh=YouuZLEIEO5m2YlgfAG02ZFNT62OJ7IdcU08Y0jQvzM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SzVMxtqip/rJUliRR038d9RAA0FCcpgF6HkBqJeAZ4y5MtONJKEM8i/YEhtnSHkt7
 Qd26cnG4AQfv2ITuISIUtpgXv+pWhRuEwCKGs0FXNjTD+JstCIdw0F5hb/6s4Mr3jW
 raxRnPerBpIN9PhIIOr/kdjrEwrZ/OG2aT89IrbRzvBi6PukFE4ahJQan5giK5o6WK
 NeR4a7XsaPiCSTRRtw7+FcRVb9cP3n4OdBdpub6AlGUNo7Ci0TFh+106+hZrXDKdjK
 3frdZqViiyfRepU77kF+aJ0Rr9PQ/a5CNefoRBzTouIGGo61ueEGLjUaz6kfOSuBIc
 QRoS8eeVIRFgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/4] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org
In-Reply-To: <20260630224328.3218796-5-zhipingz@meta.com>
References: <20260630224328.3218796-1-zhipingz@meta.com>
 <20260630224328.3218796-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 23:11:59 +0000
Message-Id: <20260630231159.A1F8E1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of `struct mlx5_st_idx_data` in `mlx5_st_dealloc_index=
()` when its refcount reaches 0.
--

Note: Due to system recitation restrictions, this review report cannot quote
the original patch diff inline. The findings are provided as a free-form
summary below.

commit 9ada3f634918f1f6bc02c86bed9350c775185dbc
Author: Zhiping Zhang <zhipingz@meta.com>
Subject: RDMA/mlx5: get tph for p2p access when registering dma-buf mr

This commit wires up mlx5_ib to query dma-buf TPH metadata at MR registrati=
on
time to program requester-side TPH on the outbound mkey. It translates
exporter-provided steering tags into local ST entries and ties the extra
ST-table reference to the MR lifetime.

[Severity: High]
This is a pre-existing issue, but I noticed something while reviewing the
surrounding code in drivers/net/ethernet/mellanox/mlx5/core/lib/st.c.

In the mlx5_st_dealloc_index() function, when the usecount refcount drops to
zero, the code calls xa_erase() to remove the element from the xarray.
However, it appears the dynamically allocated memory for the idx_data
structure itself is never freed.

Could this lead to an unbounded memory leak when a user-space application
repeatedly registers and deregisters a dma-buf MR with a TPH tag? During
registration, mlx5_st_alloc_index_by_tag() allocates a new struct
mlx5_st_idx_data via kzalloc_obj(). If deregistration drops the reference
count to zero and removes the pointer from the xarray but fails to free the
structure, could this be triggered in a loop by an unprivileged user-space
process to deplete kernel memory?

Would it make sense to add a kfree() for the idx_data structure immediately
after the xa_erase() call in the refcount_dec_and_test() block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630224328.3218=
796-1-zhipingz@meta.com?part=3D4
