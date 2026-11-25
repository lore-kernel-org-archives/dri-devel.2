Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A11606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6SWBrU5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3608110FCF7;
	Wed, 25 Nov 2026 16:03:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919AE10E956;
 Wed, 25 Nov 2026 16:03:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1515A63368;
 Wed, 25 Nov 2026 16:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751DF1F000C6;
 Wed, 25 Nov 2026 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795622610;
 bh=30XKkNhBHtAMZ1vAF0bhL3GbSzopE2QJq9kezQdjGYg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=i6SWBrU53SoAoY4XVv51y4e4x0Jp0sD5V7g3exv5dhvF3IoVwyfcvYj8wnOxpbHm3
 vAkPEU4OiboV/4elRz6moNKq0g77W1eP8t6VLEm9ewAPYKAdbT5yhkg1Gtwtc0j0r+
 9m1dooFw5bc9CPOET6zEV0xPjdMW9IH4nZIyOJI+tKr0O2nqyS/1ieGKX6LjZVeOxT
 cT9Ttay1gmej0EPnl983itB3LINzno+ewMiwD65zAqYgBskXDaJjqOXWrcXADwNeSv
 MhQqjWfSMyLT7BCYAU5WL5BG0yIhyikmgPsUX5ohJAfJvTROUExNNHVHCPKF8mm4Dn
 e1La2Qot17ENg==
Date: Wed, 25 Nov 2026 06:03:29 -1000
Message-ID: <1357055318f5d596a81026dc1e2a7ad6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: fix cancel_work_sync() on ordered workqueues
In-Reply-To: <20261125-ordered-wq-cancel-v2-1-13620a09773f@google.com>
References: <20261125-ordered-wq-cancel-v2-1-13620a09773f@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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

Applied to wq/for-7.4-fixes with "# v6.11+" added to the stable tag.

Thanks.

--
tejun
