Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E693C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:06:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85EE89262;
	Mon, 21 Sep 2026 10:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="l4yUviIS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1135989262
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 10:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789985213;
 bh=qjxNDGZRSox1iiMB6SnmMNagxZd9u/kLfpnd4P1L180=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l4yUviISlNFUpqJsL8dMM5sYb32uoC+XpVNNrwIvWtCfI5HCNTq8mCfuNccddmYWu
 1T8AdiWnWRDWafK20MdNpBExx0MJPRx27VmAY2F3PUhcgxW18MkuYI/zGu+najSO0F
 CgY1nnzPS5NMsu6u4zdVmGx0kbaf5T/msrac9sM6uFxD5+FT24zmiJbWYw8nqPHZ4V
 Scv7SPk/HNYUD8ftMeXqti5Lq6Jixw/xC51PJ7rtYyoDUQXZAU1vYjtq8xKlg6yXqJ
 jOzUcKkyuj2SJXVjuOofjL/pKm6YElLIDgBkW4+g6GdyQgYsnPD7YmVSB/N4yTnY2n
 XBpVGNurTONTw==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DDBAC17E09ED;
 Mon, 21 Sep 2026 12:06:52 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: gary@garyguo.net
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 aliceryhl@google.com, anna-maria@linutronix.de, bjorn3_gh@protonmail.com,
 boqun@kernel.org, dakr@kernel.org, daniel.almeida@collabora.com,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 frederic@kernel.org, fujita.tomonori@gmail.com, jstultz@google.com,
 kernel@collabora.com, laura.nao@collabora.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 ojeda@kernel.org, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 simona@ffwll.ch, tamird@kernel.org, tglx@kernel.org, tmgross@umich.edu,
 work@onurozkan.dev
Subject: Re: [PATCH 2/9] rust: io: drop the CONFIG_64BIT restriction on system
 memory u64 access
Date: Mon, 21 Sep 2026 12:06:41 +0200
Message-Id: <20260921100641.228824-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <DLFUKN84E2XS.33S0LZHBMAWH2@garyguo.net>
References: <DLFUKN84E2XS.33S0LZHBMAWH2@garyguo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Gary,

On 9/15/26 13:18, Gary Guo wrote:
> On Tue Sep 15, 2026 at 11:57 AM BST, Laura Nao wrote:
>> SysMemBackend's IoCapable<u64> impl is currently gated on CONFIG_64BIT,
>> copying the MMIO backend's restriction. MMIO needs that gate because
>> readq() is not available on 32bit. System memory has no such dependency:
>> a u64 volatile load/store compiles on any architecture, it's just not
>> single-copy atomic on 32bit.
>>
>> Drop the gate so u64-backed types, such as bitfields, work on 32bit too.
>> Document the non-atomicity at the impl instead of enforcing it at build
>> time.
>>
>> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Laura Nao <laura.nao@collabora.com>
>
> No. If you don't need atomicity, please use `copy_read` to read the value. It'll
> compile down to the same volatile read, just without atomicity guarantee.
>

Ack, thanks for the feedback. I'll drop this in v2.

Best,
Laura

