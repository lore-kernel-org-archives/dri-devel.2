Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F308CD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 21:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2DBD10E661;
	Mon, 15 Jun 2026 21:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dzy+gkH2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D7710E661
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 21:57:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 36C834064C;
 Mon, 15 Jun 2026 21:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16521F000E9;
 Mon, 15 Jun 2026 21:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781560679;
 bh=ZybuVlKws8hgVhXg4VsJD/g+orod/d6HM3+PwcKNxVk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=dzy+gkH2/qCX8JT+F7lkPuVsTM3L6UsLZ8D86wt4w/t6ROOeQ11iGwlemG01ax3k7
 I3lQv0qdtOM1xOIsd0YpO4wl5CvwzYMNHZSErzo2fTighoGj5SutfOdQTlr56nMSQ6
 K+dfaC1nJCANxJPr33HAAvJ5VnWXGtjXlvRLS1iQNDran5OiR1w0NBBg8EfQCAckBt
 rbMdrrfKi6CkZO6yfDSmwrWLnPmUTQ2m8VUg4Tq6aajwW45eYznRqiZ7gIK68YKq8j
 CTusxYMFdNGCTFdoRamtFeGmiXeZb+n3ZrL3WA535cracAT9NMx4hhvzlCuRLPgGkq
 ej+6PFkFapxTw==
Date: Mon, 15 Jun 2026 14:57:57 -0700
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
 dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 2/4] udmabuf: emit one sg entry per pinned
 folio
Message-ID: <20260615145757.0b2ddcf3@kernel.org>
In-Reply-To: <20260612-tcpdm-large-niovs-v3-2-a3b693e76fcb@meta.com>
References: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
 <20260612-tcpdm-large-niovs-v3-2-a3b693e76fcb@meta.com>
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

On Fri, 12 Jun 2026 09:25:58 -0700 Bobby Eshleman wrote:
> dma_map_sgtable() does not always merge contiguous pages for us, so we
> do this internally before exporting.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  drivers/dma-buf/udmabuf.c 

This will need at the very least an ack from DMABUF maintainers,
so it's a bit late to consider it for 7.2
-- 
pw-bot: defer
