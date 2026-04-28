Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8F2FF8867
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 00:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 475DB10E9BA;
	Tue, 28 Apr 2026 00:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gHZ0eoeQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2776510E9BD
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 00:06:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1141760052;
 Tue, 28 Apr 2026 00:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378B4C19425;
 Tue, 28 Apr 2026 00:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777334799;
 bh=v5xF8URNYI+qlU0ksb3uicajfE3SlBSLk0529expY4o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gHZ0eoeQFQH4znXi7HqJMe9zkwZIwxKJpTjBhUhdD0yM4bc3lj0VQSFpMr6ndEdwd
 VG+jCzNLRTJThF89EhxHWG43FULj42Wugi1Ny6K7WTmEJ9C8KR8pfqHQUZjZzpdJE8
 Hwc2Tb51pbA1GmycPtDdUYjyIUDoSpGooR/sChVHYhx533Ag+rlAL2Mk5iw79L99PE
 xk4Vt7IdqF4Laa0JZzmG4pE9bBcZt9hmwNHuDaAwVGBJh82SiHHAcXMmgwNraPlTUS
 KhF4BM7qGOcQGexFDfwrBbxmJjX4xMvDVpM0/xCX5mD5BJkJT/jL6K5+rhwptkCnPR
 1qrby/ooxv2gg==
Date: Mon, 27 Apr 2026 17:06:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Stefano
 Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Himadri Pandya <himadrispandya@gmail.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, Saurabh Sengar
 <ssengar@linux.microsoft.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Deepak Rawat <drawat.floss@gmail.com>,
 dri-devel@lists.freedesktop.org, stable@kernel.vger.org
Subject: Re: [PATCH 1/2] hv_sock: fix ARM64 support
Message-ID: <20260427170636.7a02bf9c@kernel.org>
In-Reply-To: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
References: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 25 Apr 2026 11:17:18 -0700 Hamza Mahfooz wrote:
> VMBUS ring buffers must be page aligned. Therefore, the current value of
> 24K presents a challenge on ARM64 kernels (with 64K pages). So, use
> VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
> hold all of the relevant data.

Please split the fixes into two independent postings.
They have to go via different trees AFAICT
