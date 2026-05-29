Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87041CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 11:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93C310FD28;
	Fri, 29 May 2026 11:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JEkG/OZh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F0C10FD28
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 11:15:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0108D600BB;
 Fri, 29 May 2026 11:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633071F00893;
 Fri, 29 May 2026 11:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780053348;
 bh=N5Mhwu56fACKBFI/ybtg1k7sKqLtp73anF5nOE+olEY=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=JEkG/OZhSeqgRe7b/76jf0sGMfVWPrdypx401L12VmmA+ERwDx/OPQaUmIpu3dFuJ
 G0c1jqbzyw2TY/ywjTmlx6VcJVhqsyfsrHq0bjrsXWnClEspF3c90gEJyrlFeqNAGW
 z2cqWUoWZNNIG27zMnG61wZIWtmzJyTOKcoAvUVhx2ngwD8q/se1Elkz3dGQK+Yk9U
 J9pfG2dh01eklOrMfzIyNaFqVB95I0DfHR2AiAPq/eniBDfC6rN68+0/fKr6ikT3PW
 5cHn3y0BeaK1DAWCECTMZf2J0ELbalCxdMD7o+YKWn4t0301qHkLGAdslFyzd/v+U6
 E9na2k+KED1uA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 13:15:44 +0200
Message-Id: <DIV48XH2KKI4.1AI7LJQBHVGM3@kernel.org>
Subject: Re: [PATCH v7 0/4] gpu: nova-core: run unload sequence upon unbinding
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
In-Reply-To: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
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

On Fri May 29, 2026 at 9:33 AM CEST, Alexandre Courbot wrote:
> Alexandre Courbot (4):
>       gpu: nova-core: gsp: move chipset-specific parts of the boot proces=
s into a HAL
>       gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP command upon unload=
ing
>       gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding
>       gpu: nova-core: gsp: run the unload bundle if Gsp::boot() fails

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

NIT: There's a few places with Result<()> instead of just Result that could=
 be
cleaned up (including the moved code).
