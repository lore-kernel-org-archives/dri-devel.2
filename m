Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B695EC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3EF210EAF5;
	Tue, 21 Jul 2026 18:09:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cnqsc/RL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA04510EAF5
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 18:09:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3037A600D8;
 Tue, 21 Jul 2026 18:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3101F00A3A;
 Tue, 21 Jul 2026 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784657344;
 bh=rsWQ4FGYd+ZuS4/k42e+/CB05xWi4uLVW1aD7Qpja3Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Cnqsc/RL4F4q2QzFf/7UI1vzYfWvbh90lrJ0Q5GXMq0+sQbCijqnYSvIgVh1ufGcs
 0wabztTWFNX8cJLND1p5N5ICENFTx7qpW1rbTKAAxo9jw3sBRPB2+bWl395+1iWwxy
 7nYeS1MKd53rnz8d7KoOEVDTr4j/28dQ+f0m/mEb8qJMin1vN+qrwsHhNnBo9GeWph
 P/jc7ierl68Bar5rE7vFQa67loxPVIkmrDtSDsHDdM8/f33pklsJf3KIszh2Yny/7g
 f0iUIoLsi6LV6PhGX1Jz8z/gsHTJw65u3ZLkmPfR9IWYXSM2M5obl4NGMga/By7qx3
 5saKo15l8MgKA==
Date: Tue, 21 Jul 2026 11:09:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net,
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com,
 dw@davidwei.uk, Joe Damato <joe@dama.to>, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <20260721110903.34840531@kernel.org>
In-Reply-To: <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
References: <20260708-tcpdm-large-niovs-v5-0-34bf6fac941b@meta.com>
 <20260708-tcpdm-large-niovs-v5-3-34bf6fac941b@meta.com>
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

On Wed, 08 Jul 2026 15:55:06 -0700 Bobby Eshleman wrote:
> +@ksft_disruptive
> +def check_rx_large_niov(cfg) -> None:
> +    """Run the devmem RX test with rx-buf-size = 16 KiB."""
> +    run_rx_large_niov(cfg)

Any idea why the devmem tests sprinkle disruptive everywhere?
Disruptive means we take the link down, I don't think this test 
does that.
