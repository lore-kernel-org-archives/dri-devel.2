Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4217C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 02:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3639710ED66;
	Thu, 30 Jul 2026 02:16:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z12ZPJp0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA9B310ED66
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 02:16:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 859DC43E81;
 Thu, 30 Jul 2026 02:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3771F00AC4;
 Thu, 30 Jul 2026 02:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785377811;
 bh=6tGaLHu0EVxq2PjCuK3R5veUeuraNN9YsqvpMJewVOg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Z12ZPJp011u3s3PDprGcf1a5zlmaiUeaUierOQGXq4dQfYMLMO/04zzgLXJkmCVym
 StBAqim4ZI8cxUY+XOxoaXosmPgz8mnQvg6ALmBwvJjxqzOmrVkcWena8klv20OXIZ
 kj8fSG0CgKyfnmkkMM1JQ/hBblyh+bmUtI7HRD/cW75OwlZFEv8cW49WVzYPIM7Gxs
 dTl3PGH953kS+VotnYVDf1m+ThNPd2o5ddbEKXrGdq/B7OP19qkk6pD4KNoDBrEZhc
 ZjwMfXUH3gx+t4Ne3u5UpcLW4KVA6+cXFy8r03U3rGWz8VPMpYsFE4iriobjTuG5Cr
 sc3XohhZN0vjw==
Date: Wed, 29 Jul 2026 19:16:49 -0700
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
Subject: Re: [PATCH net-next v6 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <20260729191649.55ab7942@kernel.org>
In-Reply-To: <20260724-tcpdm-large-niovs-v6-3-7975f62cdfbb@meta.com>
References: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
 <20260724-tcpdm-large-niovs-v6-3-7975f62cdfbb@meta.com>
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

On Fri, 24 Jul 2026 14:21:17 -0700 Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add a new devmem test case for binding the dmabuf with rx-page-size=16K.
> The test sweeps RX payload sizes straddling the niov boundary to cover
> the sub-niov, exact-niov, and multi-niov RX paths.
> 
> Silence pylint invalid-name (`with open() as f`) and too-many-arguments
> (ncdevmem_rx grew to 6 args) at file scope.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Hm, odd. In NIPA we're getting:

TAP version 13
1..1
# timeout set to 0
# selftests: drivers/net/hw: devmem.py
# TAP version 13
# 1..5
# ok 1 devmem.check_rx # SKIP marked as disruptive
# ok 2 devmem.check_tx # SKIP marked as disruptive
# ok 3 devmem.check_tx_chunks # SKIP marked as disruptive
# ok 4 devmem.check_rx_hds # SKIP Test requires devmem support
# ok 5 devmem.check_rx_large_niov # SKIP Test requires devmem support
# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:5 error:0
ok 1 selftests: drivers/net/hw: devmem.py
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

https://netdev.bots.linux.dev/logs/hwksft/BCM57508/results/755681/config
driver: bnxt
fw: 237.1.148.0

Any idea?
