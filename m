Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB2410ED659
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FAE010E14E;
	Fri, 27 Mar 2026 11:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wp.pl header.i=@wp.pl header.b="Fut8Pt2f";
	dkim-atps=neutral
X-Greylist: delayed 399 seconds by postgrey-1.36 at gabe;
 Fri, 27 Mar 2026 11:51:49 UTC
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 799B110E291
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 11:51:49 +0000 (UTC)
Received: (wp-smtpd smtp.wp.pl 26322 invoked from network);
 27 Mar 2026 12:45:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
 t=1774611903; bh=ClyMAST5Ou9swdngfYyP3nxlyzXf+yDAbxpymoT0Rjk=;
 h=From:To:Cc:Subject;
 b=Fut8Pt2f2FcKLZeKZU6PsuAH1IcmaM6XxqTkZQ8XewDKGzJKsPg+X/Axp2vAWRCc3
 3qnAY22THiRL5JSsDnOi6LQ5NhDheTCBhr6BOTjaYeOZ6LBEdep/O+evxzNJJbYD04
 K6A0diSmzXF22FjSBUU+0UZq99GX+WHfShkvuWqv8mc7O75d/HgkPLFkPzouFhag4n
 1YaqJDXLW+SaLHU1+xH4m1VlwmeT/qC1MOuFnaj01GZlMeDtJD8dOe/Dc4s25FKJFi
 OYova3fSHcfORauEu1dzJScFTX/KaH+Jbztse2qvin+3/6KGVc+cqlQ0xYFlhoy3qE
 i1MDyFUefqg3w==
Received: from 77-236-5-223.static.play.pl (HELO localhost)
 (stf_xl@wp.pl@[77.236.5.223]) (envelope-sender <stf_xl@wp.pl>)
 by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
 for <jackmanb@google.com>; 27 Mar 2026 12:45:02 +0100
Date: Fri, 27 Mar 2026 12:45:02 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Brendan Jackman <jackmanb@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com
Subject: Re: [PATCH v2 2/4] iwlegacy: 3945-mac: Fixup allocation failure log
Message-ID: <20260327114502.GA16800@wp.pl>
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
 <20260326-gfp64-v2-2-d916021cecdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-gfp64-v2-2-d916021cecdf@google.com>
X-WP-MailID: a5b414377b8f46f1eed9309472d3c6e9
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YTOh]                               
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

Hi,

On Thu, Mar 26, 2026 at 12:31:58PM +0000, Brendan Jackman wrote:
> Fix 2 issues spotted by AI[0]:
> 
> 1. Missing space after the full stop.
> 
> 2. Wrong GFP flags are printed.

We should also initialize gfp_mask = priority inside the loop.
But this can be done as separate patch.

> And also switch to %pGg for the GFP flags. This produces nice readable
> output and decouples the format string from the size of gfp_t.
> 
> [0] https://sashiko.dev/#/patchset/20260319-gfp64-v1-0-2c73b8d42b7f%40google.com
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> index c148654aa9533..88b31e0b9568c 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> @@ -1002,9 +1002,9 @@ il3945_rx_allocate(struct il_priv *il, gfp_t priority)
>  				D_INFO("Failed to allocate SKB buffer.\n");
>  			if (rxq->free_count <= RX_LOW_WATERMARK &&
>  			    net_ratelimit())
> -				IL_ERR("Failed to allocate SKB buffer with %0x."
> +				IL_ERR("Failed to allocate SKB buffer with %pGg. "
>  				       "Only %u free buffers remaining.\n",
> -				       priority, rxq->free_count);
> +				       &gfp_mask, rxq->free_count);
>  			/* We don't reschedule replenish work here -- we will
>  			 * call the restock method and if it still needs
>  			 * more buffers it will schedule replenish */
> 
> -- 
> 2.51.2
> 
