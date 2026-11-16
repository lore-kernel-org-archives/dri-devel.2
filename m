Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB924606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VzV4EIZi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28CBF10E942;
	Mon, 16 Nov 2026 13:57:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A3810E97E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:57:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B0C162C84;
 Mon, 16 Nov 2026 13:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C171E1F000C8;
 Mon, 16 Nov 2026 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794837436;
 bh=VfRZDaWu3mTeK1q7W9hztmEL/1IXE/SN2J1h/Ct3wbM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=VzV4EIZiG19u4MHeJLjqMGDXH5euTIdK/SELkr8O05rPjl/9nusx4QLkVUHaUM5rA
 kE8jNVOLBIgzLyOKSr3jM8TZevBUvgH/tsq00gO23bxB77ao35zzdZxGI/m1gSKz29
 utpXu8Smmhvo4yyf0Rfv1g1I5BHpnqVbJAX3yt8F/ODGuXe9Ux6gUON1G+TMy9lYVT
 wbv+9ThOq9pUwU/N/sdSDw1U9yj77KwUBsBHfAW6IzSiSteQSb4CXIuB12/CnbCgBT
 fzOLkmeqTnnab91HChXjYToi7Tz/WJMQfbUttRWySpWqGg7PcshDJlSHJPtpH27iTq
 qTyPXLU/Ken4Q==
From: Srinivas Kandagatla <srini@kernel.org>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thierry Escande <thierry.escande@linaro.org>, 
 Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>, 
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Tyler Baker <tyler.baker@oss.qualcomm.com>
In-Reply-To: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
References: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
Message-Id: <179483743344.37272.11839722342354246118.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 13:57:13 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 16 Nov 2026 18:57:29 +0530, Vinayak Katoch wrote:
> This series fixes two races in fastrpc_rpmsg_probe() that can be
> triggered when userspace opens a fastrpc device node concurrently with
> the rpmsg probe sequence.
> 
> fastrpc_device_register() calls misc_register() before the channel
> context is fully initialised. A concurrent open() in that window hits
> kref_get() on a zero refcount, and because of_platform_populate() has
> not yet run, sesscount is 0. The error path then calls kref_put() on the
> saturated refcount, which kfree()s the channel context. A subsequent
> IRQ-path fastrpc_rpmsg_callback() dereferences the freed spinlock,
> causing a kernel panic.
> 
> [...]

Applied, thanks!

[1/2] misc: fastrpc: fix NULL rpdev dereference when session alloc fails
      commit: 2b22e3266386190d2027d9f12f317e0662a40711
[2/2] misc: fastrpc: fix init ordering race in rpmsg probe
      commit: 1bf78aac760fd25b684153f8c477aede9b9dd634

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

