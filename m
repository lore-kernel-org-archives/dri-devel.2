Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE8DCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32D1210E325;
	Fri, 26 Jun 2026 08:51:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZuN86shS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE71D10E325;
 Fri, 26 Jun 2026 08:51:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0C03600AE;
 Fri, 26 Jun 2026 08:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C131F000E9;
 Fri, 26 Jun 2026 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782463886;
 bh=dczgg0EG8SzCmQOx10ra7Wu7tyi/QlMQ5W656css9gI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ZuN86shSSyy0XeJHxDjAleAAh3O8h5DItrYs4TSav34bAuZW0MAx9ZBBE9S3nKp+q
 JUucAqzuWIOp1XCgdpd9P3oFXnLbWNeWduuAN7d3BLmln+qoARZNZxKF2O06nPeYv4
 1dAdVGA0JDyuC0sJVCZD2wvL+fK7VqCql7n7upa+dFP/qqyZ8tCeX05jqkcgPFDC5w
 tFX0+2mg/DvZd1BW9undZCZbfHnid5R0fV0ghRYpjUgkCITPyYbrNbnJWUD3Su88Bu
 iGHlEwHR4XUomu86ZdOshDLSTLNHrTMNbY7gs9BX+9uYtxaMeTpyySj/HlKZUt2HrK
 5/RKab/63CQEw==
Date: Fri, 26 Jun 2026 04:51:19 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v4 2/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260626045119.659d1e6b@fedora>
In-Reply-To: <20260625234158.GA261868@ax162>
References: <20260625104007.041432666@kernel.org>
 <20260625104402.210473477@kernel.org>
 <20260625234158.GA261868@ax162>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Thu, 25 Jun 2026 16:41:58 -0700
Nathan Chancellor <nathan@kernel.org> wrote:


> The following diff resolves it for me, should I send it as a separate
> patch or do you want to just fold it in with a note?
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 621566345406..2301a701ffbb 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -10,6 +10,7 @@
>  #ifndef __LINUX_LOCKDEP_H
>  #define __LINUX_LOCKDEP_H
>  
> +#include <linux/instruction_pointer.h>

Ah, so the reason for this breakage is because lockdep was relying on
instruction_pointer.h, that just happened to be included in kernel.h
via trace_printk.h.

This is a separate issue, so it should be a separate patch. I'll add it
as patch 1 of this series.

Can you send me the config you used. This didn't trigger in my tests.

Thanks,

-- Steve



>  #include <linux/lockdep_types.h>
>  #include <linux/smp.h>
>  #include <asm/percpu.h>

