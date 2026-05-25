Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B494ACD5BD2
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 14:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F55D10E325;
	Mon, 25 May 2026 14:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nLuxFYtN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FCD710E14B
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 14:29:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 57777600BB;
 Mon, 25 May 2026 14:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96FA1F000E9;
 Mon, 25 May 2026 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779719344;
 bh=gLQfWj4gdS8xSt0BpG9N75xejRxZ4FgzKtxYXBxvJyk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=nLuxFYtNIA16UrSbLesoOp17PKiIIfGRP4fZ3nKpcEGXRtYdLjzLu+eal8yi8snSm
 45nM/v+A8CKfz77f7Dp1Gv4YzCN8kZGfC+zeSrInULiDceGnwD/3cHJpVRRwKRcYC/
 zed1Jlja3xHGsfoev8/WYcYlEj8Y2HwWzCxRtQ0Hx6fC9U6fnH7QaIslL+q4fKpLlg
 DPioLXpMA6gHyI+yMIuxMPu2NgpKKaF/yoUU5EFXAxlj7hXdUYyFlKKogfjCZ7qwXj
 Xlyp5MDp2RHohsMr17eeKj9nqGMkBipMrxZLvcSHHSvpJrjcgLNHf7wbjbjHhdwupI
 J3GwdRMBkhAvQ==
Message-ID: <f2e3e7e6-3e6c-4a1b-aba5-9be0c41e5c6b@kernel.org>
Date: Mon, 25 May 2026 16:29:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/22] gpu: nova-core: vbios: store PMU lookup entries
 in a KVVec
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Alexandre Courbot
 <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260525-fix-vbios-v5-0-e5e455251537@nvidia.com>
 <20260525-fix-vbios-v5-13-e5e455251537@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260525-fix-vbios-v5-13-e5e455251537@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 5/25/26 3:57 PM, Eliot Courtney wrote:
> -    table_data: KVec<u8>,
> +    entries: KVVec<PmuLookupTableEntry>,
Here an in at least one other place the patch series changes kmalloc() to
kvmalloc(). Do we really expect this to potentially exceed KMALLOC_MAX_SIZE?
