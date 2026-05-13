Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22074CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 08:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9224F10ED52;
	Wed, 13 May 2026 08:03:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SGTp8Enc";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD81510ED4F
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 08:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778659434;
 bh=Y5n8bGSKCmrbQEOs6skOF2DzphzSJfvrX+kie9+R5ZU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=SGTp8EncZ2pNhGGGSKy133R65QDloB1ezhhzPTRXS/HjXYOemr6J+luTbkiXNdZ8M
 8fextZIRa568Aw967auL48jqVSrULh2jjFQ2AGOU2K1SCICNAVJOiCN8CnbsIQdRx6
 7Fp0EUKhWYYqY8u+VbzTgFUtfbKfXlBQJ5Q7P9vdDOfhqZmiFN8qpI+1346IgP2AMV
 PqcopqIAu+FIA1z3tzqqST2gWx064sJMuxGwwLD2ss/3NDi3hhMEUsRpyNB/9CJ6pP
 rwQTx+MXpIBn4pfXu8XP9gnRtUtznkdMJoRSWKqF2qU6Jjmu3KFoJtWj4faPbnYOUb
 gUm72qPRqAz/w==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0095617E1318;
 Wed, 13 May 2026 10:03:53 +0200 (CEST)
Date: Wed, 13 May 2026 10:03:48 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] drm/panthor: Replace the panthor_irq macro
 machinery by inline helpers
Message-ID: <20260513100348.338c31d6@fedora>
In-Reply-To: <CAPaKu7Q1KDzWgCT-5Eo1vbHtq_qHAKvtNt7isvZA57dqFPfqUg@mail.gmail.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-3-95c614a739cb@collabora.com>
 <CAPaKu7Q1KDzWgCT-5Eo1vbHtq_qHAKvtNt7isvZA57dqFPfqUg@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 12 May 2026 11:58:30 -0700
Chia-I Wu <olvaffe@gmail.com> wrote:

> On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > Now that panthor_irq contains the iomem region, there's no real need
> > for the macro-based panthor_irq helper generation logic. We can just
> > provide inline helpers that do the same and let the compiler optimize
> > indirect function calls. The only extra annoyance is the fact we have
> > to open-code the panthor_xxx_irq_threaded_handler() implementation, but
> > those are single-line functions, so it's acceptable. =20
> We might want to __always_inline panthor_irq_default_threaded_handler.

Yep, I can flag it __always_inline, but I'd be surprised if the
compiler wasn't always inlining anyway, unless you use more exotic
optimization options, like -Os (not even sure that would be the case
with -Os, I didn't check), at which point it becomes a user decision,
and not inlining is probably fine.

> For the rest, do we want to un-inline them?

Most of them are super trivial, and I think there's benefit in having
them inlined. Again, because it's not __always_inline, the compiler is
still free to unline, but at least we wouldn't resort to LTO for this
sort of inlining optimization. So I'm still tempted to keep it as
static inline helpers defined in the header file, unless you a strong
reason to think this is a bad idea.

