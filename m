Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E47BFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD4D10F2B4;
	Thu, 30 Apr 2026 09:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ezr6zvFA";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8ED10F2B4
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:12:43 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-43ff0eb2b2aso582760f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777540362; x=1778145162;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vy8Z/q685PmwcT3tK0xjwvFofcgEB05Cfirscbd47U4=;
 b=ezr6zvFAiSs37VH5tLtVszaFnhK1NIj6lAV3FZ8sI+AhqqG/SWnjlg26exR8ElKBzv
 ozZuPjpHFNyw4tblTAU0J8Rl/3szNtUntDKLhZuu5hakLDpHkPDyg2WZ9iL7nmbp9XFS
 6YVgTkSGvo/4ZElVBhvy2emS8dwwu4sPTNMROo3rUbtrziNkoUva1D7WUYf4tijxhrzi
 YjvY4igYUqBX/LOmjsVjchMEO1dstszKVnDMw18VBhExJ+buWv9J46dMVsdRHZpJTi5/
 dv7T9q3YahmS0aKuPCi6HFWJiHa9xNHgUA8mZu5W6pVXCRDsby2NMOkLNPk6PlbzneA5
 ckmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777540362; x=1778145162;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vy8Z/q685PmwcT3tK0xjwvFofcgEB05Cfirscbd47U4=;
 b=MLKSVagxI7PzozAKXydSyc3CbbmC8yDAfYGO8HmrPnrqSTOt0ni6dQLfqbxvuaSV76
 hMW15u+4yotG5vquBZAkG5F1JjUpwneDh2fSKTYI8Eu2n4X4Ib3UtMUAnYq5pbtAGkUU
 5NI/IDEW4r3rW+NC4QKqV8LQJE3/3OiSex/8qhl2VE5MJrCV0UsjSQK49wDpESo2kB1f
 VebqNCvJBVcwzTY/W3KotzQDrLvuSRa/fJjsQA6V6h0NWZV+iX26OZ1faUWi7VZIC1ID
 q5wSTF4mroNHPIkH4Uv4mFpe33LjWoTY7vBeLRMETYk1zvn75WiSVOabCIdOpfsIcYdm
 NVFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rpaanM3/0G077KfaFRvJzuObeyFzWhV4Ao5luIGSYI2W+omV6nZixSwaJ2fbn9VqpBUM45blEL+Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxykFOsQ2qXWT8EI8uskIqWkYvkGaGDp0Gn30tWip5+N03w/hRT
 8prJRUoxBw2Stdpe1LFTmfOqOmVCr/gFeJ3yWaDzm+scGaCb+/M5sGxx4k8T+JarYJaVonnRf97
 8mLAO1q4JZdsYa00Bqg==
X-Received: from wrtw10.prod.google.com ([2002:a5d:608a:0:b0:439:d5c9:3b63])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f89:0:b0:43f:e22e:e8da with SMTP id
 ffacd0b85a97d-4493d7fa1b5mr3355911f8f.5.1777540362054; 
 Thu, 30 Apr 2026 02:12:42 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:12:41 +0000
In-Reply-To: <20260427221155.2144848-2-dakr@kernel.org>
Mime-Version: 1.0
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-2-dakr@kernel.org>
Message-ID: <afMdCU06-Y2d_LXh@google.com>
Subject: Re: [PATCH 01/24] rust: driver core: drop drvdata before devres
 release
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
 viresh.kumar@linaro.org, m.wilczynski@samsung.com, ukleinek@kernel.org, 
 bhelgaas@google.com, kwilczynski@kernel.org, abdiel.janulgue@gmail.com, 
 robin.murphy@arm.com, markus.probst@posteo.de, ojeda@kernel.org, 
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Tue, Apr 28, 2026 at 12:10:59AM +0200, Danilo Krummrich wrote:
> Move the post_unbind_rust callback before devres_release_all() in
> device_unbind_cleanup().
> 
> With drvdata() removed, the driver's bus device private data is only
> accessible by the owning driver itself. It is hence safe to drop the
> driver's bus device private data before devres actions are released.
> 
> This reordering is the key enabler for Higher-Ranked Lifetime Types
> (HRT) in Rust device drivers -- it allows driver structs to hold direct
> references to devres-managed resources, because the bus device private
> data (and with it all such references) is guaranteed to be dropped while
> the underlying devres resources are still alive.
> 
> Without this change, devres resources would be freed first, leaving the
> driver's bus device private data with dangling references during its
> destructor.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/base/dd.c             | 2 +-
>  include/linux/device/driver.h | 4 ++--
>  rust/kernel/driver.rs         | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 5799a60fd058..be59d2e13a15 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -593,9 +593,9 @@ static DEVICE_ATTR_RW(state_synced);
>  
>  static void device_unbind_cleanup(struct device *dev)
>  {
> -	devres_release_all(dev);
>  	if (dev->driver->p_cb.post_unbind_rust)
>  		dev->driver->p_cb.post_unbind_rust(dev);
> +	devres_release_all(dev);
>  	arch_teardown_dma_ops(dev);
>  	kfree(dev->dma_range_map);
>  	dev->dma_range_map = NULL;

I seem to recall that we discussed a plan to have two classes of devres
callbacks where device unbind proceeds as follows:

1. Run first class of devres callbacks.
2. Device is now considered unbound.
3. Run second class of devres callbacks.

Is that still the plan?

Alice
