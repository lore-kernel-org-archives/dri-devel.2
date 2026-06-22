Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D688CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24A210E6AF;
	Mon, 22 Jun 2026 13:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a20FWXNV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DC710E6AF;
 Mon, 22 Jun 2026 13:08:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C8B5601F0;
 Mon, 22 Jun 2026 13:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB651F000E9;
 Mon, 22 Jun 2026 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782133715;
 bh=Wl8mD9+xZA8nx14eIBmWbrmAKkBoa2SL0k1i5niNjQs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=a20FWXNV5UIOVvZQK3oYlnmbhvnGanajAqGfPBzgq1mtLmcUE0p/4+x6YU7Shadgl
 mqi/3qM8CCBEc0VEfdgQBopeHXXuKfZG+uiDCEbuCYUpTv0SvsiCbiGCb/9bB4KhEW
 DRUlVIjPKW+wSj99mCg6leZnz6Tlv8BmEwq+uZD69jaXsaAzuDy40c4nJO/LtwTgIV
 HkMCM8iVWaXizhCkYCbfvhIXZ4Fc2dHPUyzviYNP1yPfWv5E/7zB3cUSfjt3Sls1ya
 Bk1Z9eNqEc0O10dh8knMYEWL3e8V2fAD+NW45w3IWR+66cvzU66jHpfTiQOKBsif7e
 TuRZv2ou5tdjQ==
Date: Mon, 22 Jun 2026 09:08:26 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
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
Subject: Re: [PATCH 0/2] tracing: Move trace_printk.h out of kernel.h
Message-ID: <20260622090826.20efadb3@fedora>
In-Reply-To: <dbb5915e-6587-4de9-87f3-76bea5024da8@kernel.org>
References: <20260621093430.264983361@kernel.org>
 <dbb5915e-6587-4de9-87f3-76bea5024da8@kernel.org>
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

On Mon, 22 Jun 2026 10:05:13 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> > There's been complaints about trace_printk() being defined in kernel.h as it
> > can increase the compilation time. As it is only used by some developers for
> > debugging purposes, it should not be in kernel.h causing lots of wasted CPU
> > cycles for those that do not ever care about it.  
> 
> Do we have a measurement of the increased compilation time ?

I believe Yury does.

-- Steve
