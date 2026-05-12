Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77EECD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 21:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 001F310E08E;
	Tue, 12 May 2026 21:15:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CsQIoHEB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D273510E08E
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 21:15:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2762D60120;
 Tue, 12 May 2026 21:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508B2C2BCC7;
 Tue, 12 May 2026 21:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1778619934;
 bh=mo6e8Tl7INL5treUcIkpAfOY+0nT4RQkp/YxRTbOF7A=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CsQIoHEB8oaEHcAMFfdBryz0a1eiebYrMmN+ZI44OCVnR6E+YcN/oFEnuMH+jF8mL
 +Edt3gUZ7QqMMLtvW3HlcoJSiNJNWZv+LWR2rt0xoSG0CV1D7QQvsc3ETwZmvXUkqm
 3q3WEw97mCEI6T1eJBIQMdOn0NalAzj1VojejrbI=
Date: Tue, 12 May 2026 14:05:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Stanislaw Gruszka
 <stf_xl@wp.pl>, Alexander Potapenko <glider@google.com>, Marco Elver
 <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Allison Henderson
 <allison.henderson@oracle.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <kasan-dev@googlegroups.com>,
 <linux-mm@kvack.org>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>
Subject: Re: [PATCH v2 0/4] treewide: fixup gfp_t printks
Message-Id: <20260512140532.f16379be75ab006f2cca4747@linux-foundation.org>
In-Reply-To: <DIGPS83BGEGA.5I7VLH8TV7XE@google.com>
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
 <DIGPS83BGEGA.5I7VLH8TV7XE@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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

On Tue, 12 May 2026 12:58:20 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> On Thu Mar 26, 2026 at 12:31 PM UTC, Brendan Jackman wrote:
> > This patchset used to be about switching gfp_t to unsigned long. That is
> > probably not gonna happen any more but while writing it I found these
> > cleanups that seem worthwhile regardless.
> >
> 
> ...
>
> Any chance someone can take these?

[2/4] is merged into the wireless tree (I assume) and the other three
are in mm.git's mm-unstable branch.

