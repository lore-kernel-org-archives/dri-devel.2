Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60286CCF2C4
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9EB10E68F;
	Sun, 18 Oct 2026 14:53:40 +0000 (UTC)
X-Greylist: delayed 36141 seconds by postgrey-1.36 at gabe;
 Fri, 16 Oct 2026 15:29:51 UTC
Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA644112886
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 15:29:51 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=OXcwsbUzBCV1qMJEwdgg0XN927gF5DfKWZ+QuW4wci8=; 
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792164589; v=1; x=1792769389;
 b=h4cgrdHUe0mvUvY+012fKlkrV6lmLHtodoiBs8mW1pausRX4u/keCIB/zQ4t3zafzDYPHgJW
 pamCKOIP3N2KkpDMVTlYUYfXih9ziG+Af+WPScVlZ01bHjs1vKQU9uSF7+U9PzKsc05z8AZzdGB
 Q3MbGqkusOgxHLsUx2bKfyZED7YxwfE5YImMRPcbRvmBlfAgOfwZdito5bMCXjquzKPWbb5c4z9
 bFNJ8yM3Bt4qa+/9fRQfqF0/0GSGq6G5cmX9LWVP5vvyoYc3bt9IbybL8/eDUcGK+BVMETBxFFZ
 fytiN4lmdf/Tp3OJXaTV7wFAHeuVu2RYaQMV3+dPP6KPQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 6621dcbd1f3090c6;
 Fri, 16 Oct 2026 15:29:49 +0000
X-Mizu-Trace-ID: 6621dcbd1f3090c6
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: sashiko-bot@kernel.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/panic: Fix kmsg screen hang on a long log line
Date: Fri, 16 Oct 2026 08:29:46 -0700
Message-ID: <20261016152946.130384-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-173828@kernel.org>
References: <20261016052722.60051-1-lucid_duck@justthetip.ca>
 <sashiko-outbox-173828@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

On Fri, Oct 16, 2026 at 05:39:51AM +0000, sashiko-bot@kernel.org wrote:
> Does this code underflow the pointer arithmetic if kmsg_len is 1?

Yes, when a chunk holds only an empty line. The pointer is then only
compared, never read, and nothing is drawn.

> Does the strict inequality prematurely terminate parsing? It appears it
> would silently drop 1-char lines.

Yes, when the one character line is the first in a chunk. Anywhere else
it is drawn.

> It also seems to skip the first log line of every kmsg dump chunk,
> because the loop stops before processing when start reaches kmsg_buf.

No, a normal first line is drawn.

Both real cases need printk timestamps off, and both also happen without
this patch. QEMU on drm-misc-fixes, timestamps off, 10 runs each, with
and without this patch:

  normal line at a chunk start         drawn
  one character line at a chunk start  not drawn
  one character line mid chunk         drawn
  chunk of only an empty line          pointer one before the buffer,
                                       nothing drawn

With timestamps on, the one character line was drawn and no chunk held
only an empty line. Every run rebooted.

Devin
