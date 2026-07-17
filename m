Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70880C44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB4F10E2DC;
	Fri, 17 Jul 2026 12:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="Vl0pgyvK";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ap7zGyqn";
	dkim-atps=neutral
Received: from fout-a3-smtp.messagingengine.com
 (fout-a3-smtp.messagingengine.com [103.168.172.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1963610E2DC
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:54:27 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 57D39EC008F;
 Fri, 17 Jul 2026 08:54:26 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 08:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784292866;
 x=1784379266; bh=LUE3xvI9WnG4wfW1qjmUpSALuflTGWOBIEZ6pQZGWbQ=; b=
 Vl0pgyvKZv851YD5ETOsngLs+8or2EyrM5UrM3h9Ben4jN5AJD1L8gBUdtS5UPZa
 tptZL2t3JQ+Crr2SD2web3JlkBYFxuXo1JOEotFZUxFmSrLcjIN4WQ54kRHVOtmA
 5I9Drlj5kWMBO8Tj2MBWn75CAAM+NZ792786a1x+2fXCVkk1ivCkBJwtdOGvYB7n
 WbnMIaa4F2z2OSO+okzcuIutPPomaN3GMtxqeaVlDEDx2A556KYQWAl0YrfnIMd5
 WBQUMWdZsujQpw2b7ZLvy2CTwi9cxku/Av+0S24ZecrVF0LUVdnOWoga/siAHOFx
 7YQHB+PhuEC0/1+kcTvhpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784292866; x=
 1784379266; bh=LUE3xvI9WnG4wfW1qjmUpSALuflTGWOBIEZ6pQZGWbQ=; b=a
 p7zGyqnL1Wqwv9TC3nbvWu+VuXEPrccVKLxRMY1weva7VmOaUPwqrC4UM7zJoup/
 0CHiC15LJAuakstLBDtnzHsaJcmGAXsjDl7Y1R2DSgEQdZ9BMuzFKFpfbp9FTPRh
 EOvGph+qMtyxpUp2b9VjgZl7gX0G6AHmq/fH+Yk0BHjmtvADfm/lHG+6sUrrpeKY
 IVMWuxLUnGuku9jijZ7uQa5M0QWAx4U5XOEGqSeh7N/srOEnq1KdamhIbhVt8koS
 8Ty1L8/35NTNqtkqkX3aL7MjyStAfKlOJ2yEZEVAuJLsxsm2CHFfnp9o9I+egua/
 K8c5BKvUAAEPAouMV+i9g==
X-ME-Sender: <xms:ASZaavb8zAR-KtXTfryjDMJxyDh7klFj0verL6h5kXZgIZVRejOUdQ>
 <xme:ASZaapOM45ivXCTskB-p7VmI2bXZVWTDsPVvjcvcF7ZDwaab9MjmI7CbNwwzvhJmB
 TD439xZE4ju85YCT6awkXvbTs6QraZBivZZgdHxWYOr14QrTZZ1D10>
X-ME-Proxy-Cause: dmFkZTGwlSs5d3BxhmDB6MoQetvnKiQaOVFHqFn+tFAqkpbPEryOjSnt5dxm8hgzW6q6gN
 0c/Xim3bYp49YTdx/dsJbafYVydv6Rjw2mnRp8nT4ODOdRnSgwe99/lSNTaXi8rF+nK/oS
 sR4yFqAnsBmEfEGLGxAPDYlcqUPCKr2t0UkATRDx3AzwJ4RrOWzkPAnmrSiM+8IqPxHKXV
 u1QTBvBVCIZCD10j/lZMVFvwovMt/grkJOzXWigu3owpldG4ahTOPETlM7IQAMlayV6M6b
 dcrdzL0IQLpmG1WQPzYQ4vstp9QEKzy1Ly7/pann87GGRucPC+6cYfTNH3YhVJd8nUgMCs
 sQ0EJuNoKIJOW5DsLGTqPUfT8tcRzBxUzdzFew1c533BIq7YSA2YO0Xf3xSv1A0G3t5ytC
 Fw7fo9fgpCkSyW57PkeHWfFDWtMLj9aTXZrMwkZNqF9/aFstsjjWaEZ0YIdbTHyCZ0fCXa
 jX+CFLBjOu6TX+F/NF796N6XWDQd/KZEK5bvEfQPXvice2GWyFXzIB0wJk2MwCMgH1ARu7
 VM/+YN4EtgqUmE0bc3okxNH4NTlw7FbywoybFHeNFvFz3X01df6D5AlgCrNBVAfu2mLw3Y
 5t+B3ByLJt7qe5hGv5zx4eP73LmJK4YN1t3qowvwD2yMReofq763ergLzm6g
X-ME-Proxy: <xmx:ASZaajo5sEzQP6hmijR0w0JuCsE271BHkQHoxjWgWZfxNmvbVlux8w>
 <xmx:ASZaakIZWG1bG9kxR_GDM_pG7X8a7_9fcUl851nfbdFnoWO6KPHCQg>
 <xmx:ASZaauMX9tKposqhSyRcLxSM1WKWjIkQoaVBUHYdwE6o4vnBfgIiOg>
 <xmx:ASZaapppLNnmBTjcrlQ_FWF98OERbqq2zG0QiUPUY9S-YI2Y8fl0YA>
 <xmx:AiZaalvjfzySEawg4t9U_vbixhR8zM_NTmcP2yuQPHXVYAXrcPdG5Eqe>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id BDAD8182007E; Fri, 17 Jul 2026 08:54:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AVTSZ6OHPQ6F
Date: Fri, 17 Jul 2026 14:54:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Roberts" <ryan.roberts@arm.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, 
 "Mark Rutland" <mark.rutland@arm.com>,
 "Jean-Philippe Brucker" <jpb@kernel.org>, "Oded Gabbay" <ogabbay@kernel.org>, 
 "Jonathan Corbet" <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Message-Id: <404d2c6d-4a18-40c2-9da9-fb030c39536f@app.fastmail.com>
In-Reply-To: <20260717104759.123203-9-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
 <20260717104759.123203-9-ryan.roberts@arm.com>
Subject: Re: [RFC PATCH v1 8/8] misc/arm-cla: Add userspace interface
Content-Type: text/plain
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

On Fri, Jul 17, 2026, at 12:47, Ryan Roberts wrote:
> Expose CLA devices through a character device so userspace can enumerate
> the available hardware and map accelerator register frames.
>
> Define version 1 of the CLA UAPI with a GET_PARAM ioctl. Report device
> topology, CPU affinity, domain membership, mmap offsets, architecture
> version and attached accelerator masks, together with the IIDR, DEVARCH
> and REVIDR of each accelerator.
>
> CLA registers can only be read from the CPU local to the device, while
> enumeration may occur on any CPU. Validate the supported CLA
> architecture version during device setup and cache the CLA and
> accelerator identification registers for later ioctl queries.

This interface looks very raw at the moment, I expect this will have
one or more larger redesigns.

Most importantly, a single character device to expose an arbitrary
number of underlying hardware features is an inherently flawed security
model. If any specific accelerator is ever found to have a
major vulnerability, that would mean administrators will have to
disable all of them by default.

> Support shared read-write mmap of one or more CLA register pages. Create
> a context for every domain covered by the mapping and resolve faults
> only while that context owns the domain. Queue unassigned contexts with
> the domain scheduler, drop mmap_lock while waiting for assignment and
> retry the fault after the context is woken.

I still need some time to better understand what this means.
Does a CPU have multiple concurrently running contexts? Is a
user process able to starve the allocation of other processes
by just requesting a lot of them?

> +static long cla_ioctl_get_param(unsigned long arg)
> +{
> +	struct arm_cla_param __user *uparam = (void __user *)arg;
> +	struct arm_cla_param param;
> +	int accel_id;
> +	int dev_id;
> +	int ret;
> +
> +	if (copy_from_user(&param, uparam, sizeof(param)))
> +		return -EFAULT;
> +
> +	ret = cla_ioctl_validate_param(&param);
> +	if (ret)
> +		return ret;
> +
> +	dev_id = dev_nospec(ARM_CLA_PARAM_INDEX_DEV(param.index));
> +	accel_id = accel_nospec(ARM_CLA_PARAM_INDEX_ACCEL(param.index));

Why is the dev_id/accel_id not a property of the device node itself?

> +	switch (param.param) {
> +	case ARM_CLA_PARAM_UABI_VERSION:
> +		param.value = ARM_CLA_UABI_VERSION;
> +		break;

UABI definitions are not versioned, you have to stay compatible
indefinitely. If you need something else, add a new command.

> +	wait_event_interruptible(ctx->waitq,
> +				 READ_ONCE(domain->assigned_ctx) == ctx ||
> +				 cla_ctx_is_dying(ctx) ||
> +				 READ_ONCE(domain->broken));

If you call wait_event_interruptible(), you have to check the return
code and deal with it being interrupted.

> +static const struct file_operations cla_fops = {
> +	.owner = THIS_MODULE,
> +	.mmap = cla_file_mmap,
> +	.unlocked_ioctl = cla_file_ioctl,
> +#ifdef CONFIG_COMPAT
> +	.compat_ioctl = cla_file_ioctl,
> +#endif

No need for the #ifdef here. Technically setting .compat_ioctl=compat_ptr_ioctl
is the correct way here, though that may change in the future now that
s390 compat mode is gone.

      Arnd
