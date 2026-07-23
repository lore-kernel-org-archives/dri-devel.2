Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC03EC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 23:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB09C10F25A;
	Thu, 23 Jul 2026 23:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="INis+lHa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 867BB10F25A
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 23:42:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4828A4160E;
 Thu, 23 Jul 2026 23:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9391F00A3A;
 Thu, 23 Jul 2026 23:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784850122;
 bh=Mayn871PRe1pifeQ8rBg4N/wfjGRFgjD+eK0paexWds=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=INis+lHaqMWELGoDpFEazhy1b3P5wOCSYmdydM/CdbCN7oHicXnkeZnKWmj58zuOh
 rl3TYgS6YX0/4JZiZ12P23oztAuccoL6TDTP+uS8/MQatqymhRla7PE5s+fctMlgYh
 9Y+EglWxuKVtVYcqTLMxbhR6y54eC4r0cwNZebC53hWupziZ+1VNefiW8wCHcNrgnL
 Kqcaehy95A0+14UT786338AWwrrQ70NWDglkil0xF//PryEs+ApsixzcyKWpYFzDLR
 snUCcRg+8UpAWsGuV/JHcw9JUNXdEkLvHVWmnEVStWUge/qZm5jIA15WOlW02q2zSm
 w0TKsCUfLeDlQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 01:41:57 +0200
Message-Id: <DK6CK8OAMJB7.B7BWH6B6U8SR@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: fix packed registry table size
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>,
 "John Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260723-nova-registry-size-fix-v1-1-8f471ba00ab4@nvidia.com>
In-Reply-To: <20260723-nova-registry-size-fix-v1-1-8f471ba00ab4@nvidia.com>
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

On Thu Jul 23, 2026 at 8:54 AM CEST, Alexandre Courbot wrote:
> `PACKED_REGISTRY_TABLE::size` describes the entire table, including its
> fixed-size header. `SetRegistry` currently initializes it with only the
> variable payload length, omitting the 8 bytes header.
>
> Fix this by using `CommandToGsp::size` to obtain the actual command
> size, including its header.
>
> Fixes: 19b0a6e7c2be ("gpu: nova-core: gsp: Add SetRegistry command")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260722075253.B6DDB1F00A3D@smtp.kernel=
.org
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
