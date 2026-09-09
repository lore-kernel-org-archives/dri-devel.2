Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F39EC79FB7
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD5E10F162;
	Wed,  9 Sep 2026 13:36:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2PJImAPi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D7B10E565
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:36:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29E5A6020A;
 Wed,  9 Sep 2026 13:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B87A1F00A3A;
 Wed,  9 Sep 2026 13:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1788960966;
 bh=WnpS2yGxKI44jYHhvDpX+wa+5acQMRQRU+9l/6MzidY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=2PJImAPiXTNHRQ7hP2x3oYT0BLtP1K511PRmOlIgApf57TwmUNurL976ZqzkF7JMQ
 zy4BCLjinkulIlTgqoBJgyVxudGDsCtY59l8Qa1OWHGGCsPRBhZgpNIXk6vmFDs6Rg
 YxtEK2boO7fMsSbWTfcTPazN2t+BJk3gev9PCSB0=
Date: Wed, 9 Sep 2026 15:35:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Li Wang <liwang@kylinos.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Subject: Re: [RFC PATCH] misc: fgds: enable GPU-NVMe direct I/O via POSIX and
 io_uring
Message-ID: <2026090924-corsage-shout-833d@gregkh>
References: <20260908131545.105987-1-liwang@kylinos.cn>
 <2026090913-landline-encroach-c544@gregkh>
 <6aed7ecf-d125-40d1-a82d-1a7f62049605@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aed7ecf-d125-40d1-a82d-1a7f62049605@kylinos.cn>
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

On Wed, Sep 09, 2026 at 06:42:03PM +0800, Li Wang wrote:
> Hi Greg,
>   Thanks for the review!
> 
> > 
> > That's not really needed in a changelog text, it could be in the 0/X
> > patch :)
> > 
> Sorry for the clutter. I will move most of them into the 0/X patch in v2.
> 
> > Anyway, you didn't cc: the io_uring list, why?
> > 
> `scripts/get_maintainer.pl` didn't output the io_uring mailing list, likely 
> because this patch doesn't directly touch the io_uring codebase itself. It only 
> enables remapping GPU memory buffers to CPU virtual addresses, which can then be 
> consumed via standard io_uring APIs.
> 
> I've added io-uring@vger.kernel.org to CC for this reply and will keep it in v2.

Great, as you are using that as the api, there might be some parts that
will need to be reviewed by them.

> > Nor why "fgds" is the name, that's going to be hard to remember, does it
> > stand for something?
> > 
> "FGDS" stands for Fast GPUDirect Storage. GPUDirect Storage (GDS) is NVIDIA's 
> technology enabling direct I/O between GPU memory and files on NVMe, 
> widely used in LLM workloads to bypass CPU overhead.

That's nvidia's specific solution, but this works on other devices,
right?  Or just for that one platform?

And you are using this as a "bypass" for the normal accel subsystem,
shouldn't this be part of that subsystem instead of a custom user/kernel
api like you are creating here?

thanks,

greg k-h
