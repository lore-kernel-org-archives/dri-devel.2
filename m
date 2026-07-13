Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC01AC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 17:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570CD10E631;
	Mon, 13 Jul 2026 17:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cx5T0bBQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F63B10E62D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 17:08:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A631601D9;
 Mon, 13 Jul 2026 17:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDB01F000E9;
 Mon, 13 Jul 2026 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783962530;
 bh=mu3FeJpom/od9roSeWVWo0wh6ADbWqMooWxoSkpYrWA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cx5T0bBQEa9KC5N7S3XaA9B3Y4rA5AD+Gjtv0XJb9KDWDEY3X/J292jVgw6T5eqdG
 9OY+PnFipzJa3pLYKiQwiHRAoq5Bxn8l9ZcSDpiy+ioJqcPkMDb7cRT5X7Pz90rVuW
 NYHKcWiEvI55U3i+mcDz6ppq7VKqt9y0gmQ4AJcCpl00NjGMaaSxYGgXhv+/h8yxiR
 V6ezsVSmwbEMIkwyteBwDD4xWURzBUfAWPTNA0RxcyA+TzopIgDEM2ogXwC5fOM3st
 g8vVOdpxTfiTcmLde2ThAd4k36lwkOwpubYYIoqmGiGF8rK7Hm7z6g1UUOdoyZFN6c
 L6MFHAY4gW2NA==
Date: Mon, 13 Jul 2026 19:08:39 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Kishore Batta <kishore.batta@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
Subject: Re: [PATCH v6 7/7] bus: mhi: Expose DDR training data via controller
 sysfs
Message-ID: <wkuia7mvgcwtemuib4abzjffrceekzheuyksqdzrykusxzvgxe@77ggixknltoc>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
 <20260701-sahara_protocol_new_v2-v6-7-3a78362c4741@oss.qualcomm.com>
 <n35ouuyvy25ocbfaedksryoz5d53cylk2pcsxz7f25us444gh7@7ybkifq3fbae>
 <fb34c262-5c91-4beb-a792-f00da203d1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb34c262-5c91-4beb-a792-f00da203d1b6@oss.qualcomm.com>
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

On Mon, Jul 13, 2026 at 01:00:27PM +0530, Kishore Batta wrote:
> 
> On 7/9/2026 12:27 PM, Manivannan Sadhasivam wrote:
> > On Wed, Jul 01, 2026 at 04:07:41PM +0530, Kishore Batta wrote:
> > > DDR training data captured during Sahara command mode needs to be
> > > accessible to userspace so it can be persisted and reused on subsequent
> > > boots. Currently, the training data is stored internally in the driver
> > > but has no external visibility once the Sahara channel is torn down.
> > > 
> > > Expose the captured DDR training data via a read-only binary sysfs
> > > attribute on the MHI controller device:
> > > 
> > > /sys/bus/mhi/devices/<mhi_cntrl>/ddr_training_data
> > > 
> > > The sysfs read callback serves data directly from controller scoped storage
> > > and protects access with the controller training data lock. The attribute
> > > lifetime is tied to the controller device via devres, allowing the data to
> > > remain readable after Sahara channel teardown and ensuring automatic
> > > cleanup when controller device is removed.
> > > 
> > If this training data is RO, then what is the use of exposing it to userspace?
> > 
> > - Mani
> 
> The userspace component will read this from sysfs and save it to a file
> named mdmddr_0x<serial_no>.mbn.
> 

You need to mention the exact file name for the read data.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
