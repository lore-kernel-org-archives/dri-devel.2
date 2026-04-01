Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B53110F6FD9
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA0FD10ECAF;
	Wed,  1 Apr 2026 15:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mo/fACUX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F9F10ECAF
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 15:44:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E6826183C;
 Wed,  1 Apr 2026 15:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DCDC4CEF7;
 Wed,  1 Apr 2026 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775058262;
 bh=ZRDfHt+Ok+eRdwZHF1aFyAbSlAu2IdH5At0jrTj5QAE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mo/fACUXQKKCXDhElfBvQNsilYluxvtR2tifOwSA7ZyDKpSZuKPrqb8LUX5IY5z1u
 PPZZIind/7kYlY0Dc3eL3tU3mUO11aPNxczfTv6Ikxh5XHKr57VqQolpce8sQENCcA
 bHbh/7kCzpkVCW6DDsL7gbjnjkSPq9wZauzVc+5UbpW579wxOi+Y5F7/AgOJ7doNT8
 XEpXik9qbaHZnqLi8EsTmqeu/DnoDR1FQ3p8a98HE75zHhDLMgfExQaVqdBUWaq0Wz
 dxEyN8lJN3mu0nJkqTCkEYNNurK7LbplCSs+fTN0a5Ij9Ka3G6++Y0P4/yzDt7QARV
 a2llbRXYLHZSA==
Message-ID: <96e7ec53-9b98-4203-a011-77241c95ac88@kernel.org>
Date: Wed, 1 Apr 2026 17:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu: nova-core: bitfield: fix broken Default
 implementation
To: Gary Guo <gary@garyguo.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Lyude Paul
 <lyude@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260401-fix-bitfield-v2-1-2fa68c98114a@nvidia.com>
 <DHHJ82YDW7FP.2ZFKZUQUZZ2H7@nvidia.com>
 <DHHXFZ05SBVH.2MK50Q9PMTVDZ@garyguo.net>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DHHXFZ05SBVH.2MK50Q9PMTVDZ@garyguo.net>
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

On 4/1/26 5:35 PM, Gary Guo wrote:
> This could go via drm-rust-fixes?

It seems there's nothing actually broken due to that, so no need to take it
through -fixes. But we can pick it up before drm-rust-next opens for new
features as I will send another -next PR for the unsoundness fix anyways.
