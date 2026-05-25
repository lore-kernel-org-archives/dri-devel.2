Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8C6CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 05:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D9810E3BC;
	Mon, 25 May 2026 05:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vQo/oiqv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438C710E3BC
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 05:07:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DCC3D4418A;
 Mon, 25 May 2026 05:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F701F000E9;
 Mon, 25 May 2026 05:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1779685646;
 bh=9qz1XxNLgLXlie+yDue6/iylP0UaVCWrlyJibFlcePI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=vQo/oiqvnlz4wgzl3QIExeu9JT0hvGeRJrESr6KXbCLXf8DT9NO2OiKRyzxyrcH2S
 slpmlHLCTkYBzRt9PBliPkSD545q/EZtLZV6fTaTSqG3cJun/E52u6MLTzFWhAEjRU
 PP/7/laDCmpY8uCpvoPIi+Ag5uQxLX5exmpfK5nQ=
Date: Mon, 25 May 2026 07:06:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 amahesh@qti.qualcomm.com, arnd@arndb.de, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: Re: [PATCH v5 2/5] misc: fastrpc: Remove buffer from list prior to
 unmap operation
Message-ID: <2026052541-moaning-dioxide-d5c7@gregkh>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-3-jianping.li@oss.qualcomm.com>
 <xnkycubizpoe4rmhc3jt36ulx2fb3tubjybu3djovafkqqttmc@o6vw2so5ctxr>
 <37146a3a-b18f-40f1-b95b-0ac19bf6c07a@oss.qualcomm.com>
 <2026052211-pavilion-compost-5fcd@gregkh>
 <d9248bf3-ef48-4c04-ad7d-debc8854bae5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9248bf3-ef48-4c04-ad7d-debc8854bae5@oss.qualcomm.com>
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

On Mon, May 25, 2026 at 11:30:43AM +0800, Jianping Li wrote:
> 
> On 5/22/2026 3:03 PM, Greg KH wrote:
> > On Fri, May 22, 2026 at 02:55:29PM +0800, Jianping Li wrote:
> > > On 5/15/2026 9:36 PM, Dmitry Baryshkov wrote:
> > > > On Fri, May 15, 2026 at 08:42:14PM +0800, Jianping Li wrote:
> > > > > From: Ekansh Gupta<ekansh.gupta@oss.qualcomm.com>
> > > > > 
> > > > > fastrpc_req_munmap_impl() is called to unmap any buffer. The buffer is
> > > > > getting removed from the list after it is unmapped from DSP. This can
> > > > > create potential race conditions if any other thread removes the entry
> > > > > from list while unmap operation is ongoing. Remove the entry before
> > > > How can it remove the entry from the list?
> > > Multiple threads sharing the same file descriptor may invoke unmap concurrently.
> > multiple threads sharing the same file descriptor is a horrible
> > userspace bug.  If you do that, you get what you deserve :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> I agree that concurrent unmap on the same buffer from multiple threads
> is a userspace bug.
> 
> However, the fastrpc driver is exposed via ioctl, and any userspace
> (including any random apk) can map directly and then call multiple unmap.

So there is no userspace selinux permissions settings on the fasterpc
device node at all?

> This patch is not intended to support incorrect userspace usage,
> but to ensure that the driver remains robust against invalid or
> racy inputs.

Isn't control to this device an "admin only" thing?

thanks,

greg k-h
