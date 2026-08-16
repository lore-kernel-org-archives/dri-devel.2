Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680A1C5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 16:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2701510E333;
	Sun, 16 Aug 2026 16:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MHiSBdTZ";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A715C10E32B
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 16:49:08 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49987367394so1420555e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786898947; x=1787503747; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h1LuoOEYRW0czN5Bz/p4SIeY+1XK0NUMWZ1zoBbq6Xw=;
 b=MHiSBdTZjCfiaClTlY/K0KwyLscHTsYpNbc6DF1fLSpZizkv0BgDYR94mIfWrXtCdZ
 BOoryy90uk5lw+YLmRhJsjFfd5wHOGGcWjgIPP9gl8oIFbMmJT6cDAOJtPuM/jwyESHf
 yTQb26FEYvRQCBlRBJdufC+DY+HZMo6/qXJute5lXs+0p7yrnZZr65DFG4X267JU5uNt
 4m05V8V+jLJL92zohHyB/s2H7UGOABRf4/HSVBxkzGmc38ql04npWNpX5w6PGQ6s1Jw/
 rgdEAyPAk3QuzxhkBs+ogXIQNATksr8ZOsTMQ8hszGPBqPV1dNZUwOWP5VFdzuGYgg/8
 lZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786898947; x=1787503747;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h1LuoOEYRW0czN5Bz/p4SIeY+1XK0NUMWZ1zoBbq6Xw=;
 b=aMxpN7w2R7RbA9yTfjSZ2RA1oEGWuMBhrV3Xm1Jo4FQkpZZXbLmEKKyA7FeSm+BWjg
 f5UBw5j2WMFWpPU4+x/uIQ1/xMTLRWmc5NrK1AAeKXy+cdBh8Ntf0n+y48ZS1ZOVgBSz
 SK0fRe/KySbRd9eRKlMlZCmHgF+zaH4hHztznxoGZVrVuj0bWTUiZfzAt5jBw5tIISCi
 QgUfyP9P4QCXzZ9FvS/ISYVRVkzCOXvsuYNKJzPgUUIExqno+rzdeEzYLNt64jeGgkJ1
 CqcVpwugdLyHuQ+2uYCwjEuRg1K3UDov7QxWAWA0AaZwLFPs1XSzlXZyIO112IGMfoWo
 2aXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHywj/pMYKfFiz1lHyJiyoK4nzMF3gRqfneQNY6SGb3qGs/N8jHlIXGT1NONDzbn3O/ptUgLlJRP0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKf9YuqRODvrQE18RrbPrd0LzHHqj7333TOwYotKNQpbmuhZ5g
 eg+qzKtubi0TaKxSt6UUFcR3Zt3VN5J41ItSi02VQgle4T9EoOlYZEPe
X-Gm-Gg: AR+sD11hsbYRytqTDS2Kk0inMECpM1ddPAcp9KHI44ZssywMbIpPKbvf7sxocrEbw4b
 oe/uU15NLzKAqAgmcjQSKKaMAtfKwci8v+MJBCOlfNQCDdUKEL71pmG0ClQSGu6Tx0yyfSxPd0q
 LHlnpAzcpUFLzXI+PryhKSKAZYj+fg1KQHB7Y1WFT6ZUSNcVrP/f9TnqB2eaD9HII9fJ+UPTEiX
 ZkJ19U6TFDPhRJmXUsG+wSLbBWxFMEkR5aZkUQmvK2L36XxE4FINHCHN6fJXX+8syEtUFuZvGBS
 eOte9gWGY8u3MM3y8fq+P7TT5FGriWdm+8Y/5VBuZa7DpC/PsxhHehSMUbreEOfQErXr1reIPcM
 f2DOMD5TaV05zz2+a1NgvYeN+sknSUUTwzX9gp7UJA7VBBB5JFN1eE2E0dRHLNWMkHRCyLomFA+
 AP/wUPpDACFs/rFMWXiPEbGAsk/6P35CnlGAb21l/umJ/J506nf9wt3vchrl6AZz6yHKKQJVxts
 i1F2Cl30fUNgiqHhP34qot0nksgbyPegI0nIOb17rNtprtoV4N3
X-Received: by 2002:a05:6000:26cf:b0:46d:ff8a:c8e6 with SMTP id
 ffacd0b85a97d-481606f6d94mr14601663f8f.1.1786898946689; 
 Sun, 16 Aug 2026 09:49:06 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f21df13sm20760381f8f.15.2026.08.16.09.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 09:49:06 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v4 2/2] drm/nouveau/kms: guard NULL crtc in
 nv50_sor_atomic_disable()
Date: Sun, 16 Aug 2026 18:49:04 +0200
Message-ID: <178689894484.725775.7881685692020502024@gmail.com>
In-Reply-To: <20260816131755.1B99B1F000E9@smtp.kernel.org>
References: <178688574400.522643.6695278742335367229@gmail.com>
 <178688574402.522643.5471719764843371376@gmail.com>
 <20260816131755.1B99B1F000E9@smtp.kernel.org>
X-Mailer: python-smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

> This isn't a bug introduced by this patch, but while fixing the
> disable-without-enable issue here, does a similar vulnerability
> exist in nv50_msto_atomic_disable() in the same file?
[...]
> If this is called during session teardown without a matching
> .atomic_enable, couldn't msto->mstc be NULL, leading to a NULL
> pointer dereference when accessing mstc->mstm?

The shape is the same.  nv50_msto_atomic_disable() takes msto->mstc
without checking it (dispnv50/disp.c:1079-1080):

	struct nv50_mstc *mstc = msto->mstc;
	struct nv50_mstm *mstm = mstc->mstm;

and the pointer can hold NULL: it is assigned only in
nv50_msto_atomic_enable() (:1070) and set back to NULL in
nv50_msto_cleanup() (:918).

What I could not establish is that the callback is reached in that
state.  nv50 does not drive the encoder disable from the atomic
helpers, it drives it from its own outp list in
nv50_disp_atomic_commit_tail() (:2229 to :2240), and outp->clr.ctrl
is only set in nv50_disp_outp_atomic_check_clr() (:2530), behind two
conditions: the connector sat on a CRTC in the old state (:2517), and
that CRTC was active in the old state (:2522).  A CRTC that was
active came up through a commit that ran .atomic_enable (:2272 to
:2274), which is where msto->mstc is assigned.  I did not find a way
around that, so I cannot claim that a disable with no matching enable
gets there.

The one path I could not rule out is the early return in
nv50_msto_atomic_enable():

	if (WARN_ON(!mstc))
		return;

at :1049.  It returns before the assignment at :1070, while
commit_tail still sets outp->enabled = true at :2274.  That sits
behind a WARN_ON, so it is a second-order path rather than a fresh
bug.

For completeness, the other two places that read msto->mstc without
a check, nv50_msto_cleanup() (:902 and :906 to :908) and
nv50_msto_prepare() (:934), are covered by their callers, which test
"mstc && mstc->mstm == mstm" at :1318, :1347 and :1359.
nv50_real_outp() checks for itself at :889.  The disable callback is
the only reader left without a check.

I am not adding a patch for it to this series, for the same reason
2/2 is scoped the way it is: 2/2 fixes something I hit on real
hardware and can reproduce.  This is MST, I have no MST setup here,
and a guard written against a path I cannot exercise is a guess.  If
the maintainers want it anyway I will send it as a separate patch,
but I would rather hear from someone who can run MST whether that
callback is reachable with msto->mstc NULL at all.

v4 stands as posted, no respin planned for this.  The question is
orthogonal to both patches.
