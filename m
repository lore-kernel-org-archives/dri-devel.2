Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C06606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0X8ySZX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD3E811257B;
	Thu, 26 Nov 2026 16:01:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E0C11257C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:01:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8C455628B3;
 Thu, 26 Nov 2026 16:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B3F1F000D1;
 Thu, 26 Nov 2026 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795708899;
 bh=MBbUTxFA4mvfBMgr/0WWHEsgu+vniTSqXklSzU/9Eyc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=L0X8ySZXvcLsLb8PRLA+6xaDCxDmy4Mb4CXrGLYLeKMiU5FfPQMG2zZfimnB8lqoO
 fD81vlJlD0iMEY08VEUVo38TR/Qqx1tsvoexHkE2DYzAn3xHsciJW6PIDCpT+Mi7mX
 RjgOzSQiEou8R2Pl0G7V7iTbb9IR9HoQzemwBpaqZHdstfAE+izstgoSwn/Ejntz/V
 3TY9UBTpBSzqjaxe1wmrbDBSPiTsrKFANp2QWuHFsw7qn51vG5g9vpV9RHntnGfpLS
 FG/wxj3hXxBw8CVSIbEi2sOxugKoTFDET8Jka7TWD/bnLSr/gZmEenzMC18PVnfLes
 UHcxx/l4WS4bw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 17:01:34 +0100
Message-Id: <DN59ODLBQ8MW.35935L948NFQS@kernel.org>
Subject: Re: [PATCH v7 3/3] drm/tyr: add Job IRQ handling
Cc: <daniel.almeida@collabora.com>, <a.hindborg@kernel.org>,
 <acourbot@nvidia.com>, <airlied@gmail.com>, <aliceryhl@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun@kernel.org>,
 <deborah.brouwer@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <gary@garyguo.net>, <kernel@collabora.com>, <linux-kernel@vger.kernel.org>,
 <lossin@kernel.org>, <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <simona@ffwll.ch>, <tamird@kernel.org>, <tmgross@umich.edu>,
 <work@onurozkan.dev>
To: "Laura Nao" <laura.nao@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261126111145.117769-1-laura.nao@collabora.com>
 <20261126141830.215638-1-laura.nao@collabora.com>
In-Reply-To: <20261126141830.215638-1-laura.nao@collabora.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 26, 2026 at 3:18 PM CET, Laura Nao wrote:
> Result<impl PinInit<Self, Error> + 'a>

It'd be nice to avoid this and just return impl PinInit<Self, Error> + 'a. =
I
think in this case you don't even need pin_init_scope() for this.
