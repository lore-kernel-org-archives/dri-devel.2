Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF58C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 05:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2250010E11A;
	Thu, 30 Jul 2026 05:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2oOTcjeM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EB410E11A
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 05:56:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D5CF43A1E;
 Thu, 30 Jul 2026 05:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9623B1F00A3A;
 Thu, 30 Jul 2026 05:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1785390998;
 bh=UyKL5M0dMM5vyBKfscrfqtuVorlI43FZMaFIvbE4VSA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=2oOTcjeM5gAbd5cw5RB4cAdU12TbMA0h5ydtm1eZnjqLDZUlFKat2DjZ6zX9OTavn
 zLDxBoROoOxwu3xA8CTC09RUJTG6tRpLhNyRTa0tGKjCfDEABHScZCkBOhK6p8M+1L
 Uy92elQoaHnl4KEmj76ctA0QrItF+PguXrOk2p+Q=
Date: Thu, 30 Jul 2026 07:56:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: WenTao Liang <vulab@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, carl.vanderlip@oss.qualcomm.com,
 ogabbay@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] accel/qaic: fix GEM object refcount leak in
 qaic_attach_slice_bo_ioctl
Message-ID: <2026073052-salary-art-af19@gregkh>
References: <20260628115119.44215-1-vulab@iscas.ac.cn>
 <19305f3f-7567-48d3-a0b2-6597fdc3c314@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19305f3f-7567-48d3-a0b2-6597fdc3c314@oss.qualcomm.com>
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

On Wed, Jul 29, 2026 at 03:19:38PM -0600, Jeff Hugo wrote:
> On 6/28/2026 5:51 AM, WenTao Liang wrote:
> > drm_gem_object_lookup() acquires a GEM object reference on success. All
> > error paths correctly release it via put_bo, but the success path returns
> > without calling drm_gem_object_put(obj). Since list_add_tail does not
> > transfer ownership, the GEM object reference is permanently leaked on
> > each successful call.
> 
> NACK.
> 
> put() is specifically not called in the success case as data structures
> which depend on the BO are not released until detach_slice_bo(), which
> happens to be where the corresponding put() is.  It is also not possible to
> successfully call attach_slice() more than once without a corresponding
> detach_slice_bo().
> 
> The get() and put() operations for the concerned paths are currently
> balanced, but this patch will actually introduce an unbalanced state (extra
> put() operations).
> 
> As far as the impact of not having this patch per the commit text (memory
> leak) I'm aware of many memory stress tests, yet I recall no reports of
> memory leaks from attach_slice().  You will need to provide proof, from
> actual testing, that this is an issue.
> 
> > Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> 
> This tag seems wrong, as there was nothing I can find on V1 in Lore which
> indicates this tag is appropriate.

Yes, I did not suggest any of these, and the author should have
withdrawn all submissions as they were obviously not correct.

