Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4B9C61DD3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 00:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EAB10E31D;
	Wed,  2 Sep 2026 00:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="hDRPL60R";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0280210E31D
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 00:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788308059; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Sud1lIN0877KOQr2c4mj7GP84xRNZJf2RvgvS6jdjTcZXgaKFt8oMqfFXMDs0IpBVrgqhqOgSVY27KaRpKHuDt6JrfcAM+lWogZNaln0RMlSQwXCylZP+6VwMhzmLL3qhPz0K/tF67tIBZWIyg+jr9hfg8lWaxwoXMvMNWBg7Tg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788308059;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9v9K7xAFlRpojhSRY8CZl+bL11FYUJs3WgBmJ4SVq6A=; 
 b=EkDloI2yC25Mr8Hpq1WUQaqYBERoRZa3yN9vaWASDogZY5OmpqqwT+e6axzTXGGPEHsPXEmMP9xXI/LT/IY7XIsHWMjqnAi9X3+V5igxoaOpGIz5oBNAY9QLgp1ATcKUfyCGI+8RiTV9EL3sYScoS8PHVXReasbbIwdxJ2BbLNE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788308059; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=9v9K7xAFlRpojhSRY8CZl+bL11FYUJs3WgBmJ4SVq6A=;
 b=hDRPL60R407Og0rshUwaKg4xQlSMKK0NIlBlrIjuMCP+Ea9rjisMeis1Byk91wAr
 BgASNV/zMDnwJN8JgvlOeTwnfSCP7FwxOgLz/MBRQddVYirwuBNyP1MiIdlRwlFE8Zb
 G0RUGNOICvI2KidCTmglHvjqPcdKkaSWGx22Ce8U=
Received: by mx.zohomail.com with SMTPS id 1788308056394418.9753833639205;
 Tue, 1 Sep 2026 17:14:16 -0700 (PDT)
Date: Tue, 1 Sep 2026 17:14:14 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Ke Sun <sunke@kylinos.cn>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 Alvin Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH 0/9] drm/tyr: add VM and BO ioctl support
Message-ID: <apdqVvvsWvzfNmiL@um790>
References: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.303.58
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

On Wed, Sep 02, 2026 at 12:08:59AM +0800, Ke Sun wrote:
> Add the VM and BO ioctls to the Tyr driver, aligning its userspace
> interface with panthor. The series is based on Danilo's `drm-file`
> series on `drm-rust-next`, and uses the existing IdPool and xarray
> abstractions for per-file VM management.
> 
> The panthor IGT tests pass on an RK3588S device.

Hi Alvin,

Thanks for sending this series, I am still reviewing it but this is what I
noticed today:

1. Do we still need a separate pool module, since this is just for VmPool,
could we put it in vm.rs?

2. We might have a problem matching panthor’s 32 VMs per file, since the
minimum capacity of IdPool is MAX_INLINE_LEN. But maybe it will be ok to
extend this to 64 VMs per file. But then when we drop the vm pool we
better not rely on that PANTHOR_MAX_VMS_PER_FILE constant.

3. Also, I am not sure, but do we need to call vm.kill() when we drop the
vm_pool? Does it depend on the vms being activated? And if they have been
activated, should this go in Vm::drop() instead? 

4. Could you use dev_err! instead of pr_err! please, we tried to convert
over to that in the booting series.

5. We should be able to compile each patch in your series separately (to
help with future bisecting) so use the annotation #[expect(dead_code)] for
patches early in the series and then remove it in patches later in the
series when you actually use the code.

6. It would be nice if you could give a link to a repo where you have
applied all the prerequisite series and fixed conflicts. Could you still
update the branch from:
https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/64

Thanks,
Deborah

> 
> Signed-off-by: Ke Sun <sunke@kylinos.cn>
> ---
> Alvin Sun (9):
>       rust: sizes: add SZ_4G constant
>       rust: mm: add `task_size` helper
>       rust: sync: arc: relax `ForeignOwnable` for `Arc<T>`
>       drm/tyr: add per-file VM pool
>       drm/tyr: add user and MCU VM specifications
>       drm/tyr: add BO creation and lookup helpers
>       drm/tyr: refactor new_dummy_object to use new_object
>       drm/tyr: add VM-related ioctls
>       drm/tyr: add BO-related ioctls
> 
>  drivers/gpu/drm/tyr/driver.rs   |  14 +-
>  drivers/gpu/drm/tyr/file.rs     | 394 ++++++++++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/tyr/fw.rs       |   8 +-
>  drivers/gpu/drm/tyr/gem.rs      |  41 ++++-
>  drivers/gpu/drm/tyr/pool.rs     | 102 +++++++++++
>  drivers/gpu/drm/tyr/tyr.rs      |   1 +
>  drivers/gpu/drm/tyr/vm.rs       | 158 +++++++++++++++-
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/mm.rs               |   7 +
>  rust/kernel/sizes.rs            |  12 ++
>  rust/kernel/sync/arc.rs         |  12 +-
>  11 files changed, 714 insertions(+), 36 deletions(-)
> ---
> base-commit: 0b0aa9dcf17b6cffa9e325ff641e843b20d40c31
> change-id: 20260901-tyr-ioctls-f10ef0dcbfa6
> 
> Best regards,
> -- 
> Ke Sun <sunke@kylinos.cn>
> 
