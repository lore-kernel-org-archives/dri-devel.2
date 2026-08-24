Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E606C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7115010E19D;
	Mon, 24 Aug 2026 21:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="INbyBMrd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A1410E19D
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 21:38:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 61945414F6;
 Mon, 24 Aug 2026 21:38:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED481F000E9;
 Mon, 24 Aug 2026 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787607480;
 bh=5hl01MgtkWvHB6AOc/glDv17F0zIJF7cftphZyUBri4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=INbyBMrdqFKjOC4q3dh/llMNhx5N5ynfp3rRnMJGR+k4rR0wFR4DIr6BrimMHh3he
 KDw5jxpWaZ0J+IDIeC/dUqURx+2ybDskNTUGhEi4Nmi50NIzEn3MiAglunvw5ZXTwh
 8xs8Q/T+AAAmNe1HiQUR2duK/nX5VzWERi3Egy6RW7ujjnj0zHPnFbgAqhb2z92V19
 7Ey9q34DaunjmnihZi6AZZejVJjZgXuSFe54vrt04OKedpxr8tKmcpTh1g5LfnnKSN
 F1Q1aBDvTUnxbQVwcOZU5fW0almi9KZLDhTWUcE/MwhiMvqngJOkD1VMr92RQg63z+
 rlVVWYbCkqdrw==
Date: Mon, 24 Aug 2026 16:37:59 -0500
From: Rob Herring <robh@kernel.org>
To: Pan Chuang <panchuang@vivo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 "open list:ARM ETHOS-U NPU DRIVER" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] accel: ethosu: Remove redundant dev_err()
Message-ID: <20260824213759.GA50486-robh@kernel.org>
References: <20260710105937.409992-1-panchuang@vivo.com>
 <20260710105937.409992-2-panchuang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710105937.409992-2-panchuang@vivo.com>
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

On Fri, Jul 10, 2026 at 06:59:35PM +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/accel/ethosu/ethosu_job.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Rob
