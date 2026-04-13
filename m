Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ADAE9381E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A3010E028;
	Mon, 13 Apr 2026 06:03:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HM2+d5KG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 307E710E028
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 06:03:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6572941922;
 Mon, 13 Apr 2026 06:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41F8C116C6;
 Mon, 13 Apr 2026 06:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1776060191;
 bh=+DPhsLBBr6AVydYKg13IxgF99bqlwElolEyMA8nzvkI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HM2+d5KGugbLjCNpBQ/HCi/7c+Shj1UmJV/P4QoiDPXZPjTAhPkSQMkPjunxmSz4c
 sSGTsgm7CBOcLusRB/rIgcJq3dnQr3UUlQm5peqZRXdoGqybDCnpXVz5WMoAR4BcIP
 dAy12TR7iNoxtKomBxJWg/KFMbDnf7W/gEoirq0o=
Date: Mon, 13 Apr 2026 08:03:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Baker <mzndmzn@gmail.com>, andy@kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: replace empty macro args with
 identity converter
Message-ID: <2026041338-guiding-concur-3831@gregkh>
References: <20260412173317.3329-1-mzndmzn@gmail.com>
 <20260412173317.3329-2-mzndmzn@gmail.com>
 <CAHp75VcdWMvvM-oKTqRACSXSUiVsEh1Ep_82MsJxfbrG4thUdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcdWMvvM-oKTqRACSXSUiVsEh1Ep_82MsJxfbrG4thUdA@mail.gmail.com>
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

On Mon, Apr 13, 2026 at 08:58:50AM +0300, Andy Shevchenko wrote:
> On Sun, Apr 12, 2026 at 8:33 PM Baker <mzndmzn@gmail.com> wrote:
> >
> > The define_fbtft_write_reg macro calls 'modifier' as a function.
> > Passing an empty token as modifier is undefined behavior in C for
> > fixed-arity macros. Introduce fbtft_no_conv() as an identity
> > function to replace the empty args in the no-conversion cases.
> 
> This trick is used in the kernel (usually for u8). If you really want
> to improve, use _Generic() instead.

No, sorry, this code is fine as-is.

greg k-h
