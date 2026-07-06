Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49A3C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4009C10E00E;
	Thu,  9 Jul 2026 08:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="UENmX/bk";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.b="ScKYGbLW";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=sf.net header.i=@sf.net header.b="kLIlzklG";
	dkim=neutral (0-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="p9zCbIcw";
	dkim-atps=neutral
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 471BF10E00E;
 Thu,  9 Jul 2026 08:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
 List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
 Mime-Version:References:In-Reply-To:Message-Id:Subject:To:From:Date:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
 bh=hipEE2Pu7dnage5BZIPP04u86L+2oTFuPxZv5a3+xb4=; b=UENmX/bk5GWSxpapLsfab8SiOt
 xRksfWWPd4wqcAzGHWgM/QFnbWw5dtSAU2M3lobZztqnSUFVts5rZcj69xJJgMmJV/bBmPqCmlI/J
 pEM1SeZm03ki9g7d8Or3k8MDiacdR0ZSQAf+cRlkjTGWNv1eKotepRq2yub9c6nTbkio=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
 (envelope-from <dri-devel-bounces@lists.sourceforge.net>)
 id 1whjvZ-0004mu-9M; Thu, 09 Jul 2026 08:16:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <akpm@linux-foundation.org>) id 1wgnOi-0005rM-7e
 for dri-devel@lists.sourceforge.net; Mon, 06 Jul 2026 17:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version
 :References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GT8eYR5FX/yxO0AzIZtWTpOPmt1HL5HPg0mx9YGGq9A=; b=ScKYGbLWWhA4sr9oIfltqHpByV
 mDujN1V8M7sLk3KTWD77/MUYSxthe36CAFQVV9l6f1l21EtU3NruAGGu4lUr8pmVRUV/OlivBmSHH
 FkEnR+HFgTDgVIt81bcZ6rflhGVNfgtgiH7JHVHDbJ2Vb8Dpy88dQdG9gP75INXYthTk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GT8eYR5FX/yxO0AzIZtWTpOPmt1HL5HPg0mx9YGGq9A=; b=kLIlzklG4K0IgDt2AC1ewGWg7T
 4XQ6TH374sCksP4MnT4YQbkniRK/T9ib5VcrVwZzcmqCXcATcrLfb4Fs6Rtsg6FZS9ff/ypKsfWBG
 ywkmHudJiBhNuXG7u8U1NuIGKHzlr8m6YhHmXDztAEhYXFYcWfMiAXzRB2N/m2rI9+UQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgnOg-0006bp-Q1 for dri-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 17:46:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E6CD60098;
 Mon,  6 Jul 2026 17:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F081F000E9;
 Mon,  6 Jul 2026 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=korg; t=1783358478;
 bh=GT8eYR5FX/yxO0AzIZtWTpOPmt1HL5HPg0mx9YGGq9A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=p9zCbIcwLHK6Su6y0C2PJV/4Z9wCXnlM3TBQJUPMnEqq0cRCBacrKuCaisJ7NNhfp
 CyjhcvOoA8/98yZrJhr4x69/CVDtRimvcjjGprSg1lWm30zU0wCw048/00EtZr+lta
 XsXdagwOrZlFzKqzYL+zXcoLWlLGSUZeV3UQaoig=
Date: Mon, 6 Jul 2026 10:21:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: better block swap batching and a different take on swap_ops v3
Message-Id: <20260706102118.6b6ecc0557edcbb2839e2ab7@linux-foundation.org>
In-Reply-To: <20260706132206.935272-1-hch@lst.de>
References: <20260706132206.935272-1-hch@lst.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Headers-End: 1wgnOg-0006bp-Q1
X-Mailman-Approved-At: Thu, 09 Jul 2026 08:16:13 +0000
X-BeenThere: dri-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
Cc: kasong@tencent.com, nphamcs@gmail.com, baoquan.he@linux.dev,
 usama.arif@linux.dev, shikemeng@huaweicloud.com, youngjun.park@lge.com,
 chrisl@kernel.org, linux-mm@kvack.org, dri-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
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

On Mon,  6 Jul 2026 15:21:52 +0200 Christoph Hellwig <hch@lst.de> wrote:

> this series makes use of the swap_iocb for block as well so that it
> doesn't do inefficient single-bio I/O, and then rebases the swap_ops from
> Baoquan on top of the now very different method structure.
> 
> When running doing kernels builds, which is a workload that doesn't
> really do much THP anonymous memory it still gets 2x clustering for
> writeout and 1.2x for reading back swap in.  The overall times do
> not actually change, though.

Thanks.

AI review might have found some pre-existing bugs in 
drivers/gpu/drm/i915/gem/i915_gem_shmem.c
drivers/gpu/drm/ttm/ttm_backup.c

	https://sashiko.dev/#/patchset/20260706132206.935272-1-hch@lst.de




--
_______________________________________________
Dri-devel mailing list
Dri-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/dri-devel
