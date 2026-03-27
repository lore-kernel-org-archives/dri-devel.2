Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A524210F2870
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE0010EEAB;
	Fri, 27 Mar 2026 20:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SyAVrX2b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11CC010EEAB
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 20:44:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B450443FBE;
 Fri, 27 Mar 2026 20:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4CFC19423;
 Fri, 27 Mar 2026 20:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774644270;
 bh=kR0L33jdEWvScd5lZZ2m79e8K6o7vwUb1mPuNZDhkGU=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=SyAVrX2bNenPqTeESGYm8VpRUg1AjjlXWuUmTRw5p34AcewOEm4ZDb1l0djRfFMam
 cQPXKYaE1taVtpGCmzSgcpDnk88RhUEUdCKzgW9KgraS4kMpPHtmOX5bnB1zeQzHBL
 bxVmfKKQFDAHejqtCsnO28JMfK28G7Hb1yyH+DOw9fKpuM+WSIMdb9eQsySv64t3Ba
 W289J73eMx9e2Ja1lF8gpkEni9J5DnS7aP7GLZi8S+vyGrko1BcgsmpCeGgVIsFwXy
 M0MOG54FG8qxQejW7rqG7OXzLyTvISp23dh3L+4oEqOhbbhg4hEQ6bV2PneNIP8xPp
 E1+U3hw2ea1SA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Mar 2026 21:44:26 +0100
Message-Id: <DHDUW10P5BMJ.QNFRFHLHOH6H@kernel.org>
Subject: (subset) Re: [PATCH v5 0/6] Rust GPUVM immediate mode
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "Janne Grunau" <j@jannau.net>, "Matthew
 Brost" <matthew.brost@intel.com>, =?utf-8?q?Thomas_Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, "Lyude Paul" <lyude@redhat.com>, "Asahi
 Lina" <lina+kernel@asahilina.net>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-media@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260320-gpuvm-rust-v5-0-76fd44f17a87@google.com>
In-Reply-To: <20260320-gpuvm-rust-v5-0-76fd44f17a87@google.com>
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

On Fri Mar 20, 2026 at 5:08 PM CET, Alice Ryhl wrote:
>       rust: helpers: Add bindings/wrappers for dma_resv_lock

Applied to drm-rust-next, thanks!
