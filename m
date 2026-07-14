Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB54C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81B5B10E742;
	Thu, 16 Jul 2026 08:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rhRhefO6";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C95D10E0F0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 20:05:51 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so3006663a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784059551; x=1784664351; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2TZmO5aEOGXmRgWMClTIlhAZCzNX5InAxzEzEi9D4GA=;
 b=rhRhefO6i0t3wzj2b2bbqUQtRbgB627OdEu82PJGCFYEQCo0WG3tKBk9m3jcGlr9/X
 IrpoT9CES46PsfyFNoAINxMyh4o44C2FVr4NWyvvFnG9QTXMWLc7N/Df2epXGIBVuH1S
 Vkc64do2oUdB0EkWUmjXN5mPARO4Pd7NO4kNpVnzrnUy7txa+fMaJIFz7ZQGXSrypL1n
 1H0AnOhHXy8yhPNN1RXp9Y9XiRfmyZ/iQecESHyqL8ALJLYNBOEBluv99JJPS/mOiAfz
 1FrTkMMA6nfKwC5m2k2z6n+cc9/gmKqPG8YIfRlBeHNHyNxNZHi2IrXpq6G/R3OHcWmZ
 T3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784059551; x=1784664351;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2TZmO5aEOGXmRgWMClTIlhAZCzNX5InAxzEzEi9D4GA=;
 b=Thgbl47nsv6XFxDAcidM666VQBVcXuShOQZR2YGknIgD3/9jT/zE2RhD3VSBxKPJC5
 7OqbksfEd30FLsgQvWaXgDj9ggn6atuFNo2tIJoz46Y0rPHM4MlsI9+/6ktM5DChY+98
 vAXSP2sPSNxdywTrpC+g0ezG6siSU7tRRvYA/bOwDuPj/AV5kKU6gIMhnh08cdU+8G6W
 YCwPKJaTxG5rxkNov+PvwSdIwdBLkTeQPH2082WSebcJfZFZPGhJG7SwRo5i7lkqKSaY
 NCTFcuN0BjRRhwwU8plsNS90z0WRWnxINwVRBHAtZYx7nVgtRw4UVWMtDMW5hlTHQlYG
 t4mg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLHtaXovLHx5jvD9FTTl4BM5ZIglDIDR/jndc4PS3JlfrCEsnKpRikwmLv1qB210LiElN+9eHv7CA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSPrwlyVj/Tvr2DSdlgyvro1MQ03B6irUl3IYcG04KZ4bv8f+m
 NTVP+UB79CouU5HgsxKpjOkC5RteXvzIgYJOtyNTpzlS3ZXkT0fVxlib
X-Gm-Gg: AfdE7cmbyqqFxCesx+RvX3a83xWJ/F6VGE0BHVsZ2vxZAEsZG8Pz/bMD3vAfsHOrgWD
 w4klbwe5QpOjOxvnQihJful09OUagRzYIbDjDwX4Mhk2dhU3JzB1eFFFvxS5ngZoWt9AMLPYVA+
 4yZ4/CORJOXPrtdHBFdTr5erlzmrS+slrqK/PRoG/LtKhGcYHPQqR9r4LciKCtIE1h+WhorFqII
 YEk74Lt2CNiClcB0J5bflz19O6xDGoovM5NQ0ErrMI5JDRXY4XLJWf+OkS+NvOFZbwlGzgYi67o
 DYXV6MGN7Man1g+rRmv5nczOD8zFYuMlHzimvWY6oq1W/3YwEJLhyQGxSBzgWHp8QQJZrdiIeX8
 Y2BbdytWu2oGioYTJ34Txw9xHOEenLDhhrX7etojc8lmvu9hyI8df4FM4IQ6CCNZ82qK6b5fSTF
 SBa781blbzvoTFPCrBzndzmg9vgr/gWbI5g2L44NgS47GNN2PYzjf7l2g=
X-Received: by 2002:a17:90b:57e5:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-38e29ff93eemr138372a91.2.1784059550783; 
 Tue, 14 Jul 2026 13:05:50 -0700 (PDT)
Received: from skinsburskii (c-98-225-44-182.hsd1.wa.comcast.net.
 [98.225.44.182]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e172b6cfbsm2007674a91.3.2026.07.14.13.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 13:05:50 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:05:45 -0700
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, corbet@lwn.net,
 dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org,
 kys@microsoft.com, leon@kernel.org, liam@infradead.org,
 lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
 lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
 vbabka@kernel.org, wei.liu@kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
Message-ID: <alaWmUEeIBeSkmO0@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
 <20260710151151.1e193eedd0cf2591ae392f76@linux-foundation.org>
 <alG2-RSitzPWClAX@skinsburskii>
 <20260710224950.53bcb43ce7e564f07a1f6a8c@linux-foundation.org>
 <alVRU38lMfvmUFqJ@skinsburskii>
 <20260713154535.7656b3a630e2f6f076b4e76e@linux-foundation.org>
 <alZfTxfypj39OrCE@skinsburskii>
 <20260714105751.f45ec4c70702c222febdbf07@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714105751.f45ec4c70702c222febdbf07@linux-foundation.org>
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:18:22 +0000
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

On Tue, Jul 14, 2026 at 10:57:51AM -0700, Andrew Morton wrote:
> On Tue, 14 Jul 2026 09:09:51 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> 
> > On Mon, Jul 13, 2026 at 03:45:35PM -0700, Andrew Morton wrote:
> > > On Mon, 13 Jul 2026 13:57:55 -0700 Stanislav Kinsburskii <skinsburskii@gmail.com> wrote:
> > > 
> > > > > > I rebased this series on top of mm-new right before sending it out.
> > > > > > Should I have used a different branch?
> > > > > 
> > > > > mm-new is good - Sashiko attempts that.  But it's changing rapidly at
> > > > > this point in the development cycle.
> > > > > 
> > > > 
> > > > I’d like to send another revision addressing a few comments and also
> > > > replace the `max/max_t` check with something simpler.
> > > > 
> > > > Which branch should I base it on so that Sashiko can apply it
> > > > successfully?
> > > 
> > > mainline Linus would be safest.
> > > 
> > 
> > Looks like linux-next/master has been updated with the v8 of the series.
> 
> That's because v8 is in mm.git's mm-unstable branch.
> 
> > I have v9 with a few small fixes, but it is too late to send it out already?
> 
> It's called "unstable" for a reason!  Material in mm-unstable is still
> under review, test and the latest stages of development.  Getting
> things finalized for movement into the non-rebasing mm-stable branch,
> then into mainline.
> 
> So altering or replacing patchsets while they're in mm-unstable is
> perfectly OK and expected.
> 
> > If it's not, then what should I base it on?
> 
> Well it's a bit tricky to replace a series when it's in mm-unstable. 
> One can do a git-checkout of the commit which precedes the v8 series. 
> Or base on current Linus mainline, which usually works out.
> 
> Sending little fixup patches against what's presently in mm-unstable
> also works.  I'll queue each one immediately behind the patch which it
> alters then squash them into their parent patch before moving the series
> into mm-stable.
> 
> A third alternative is for me to drop v8 from mm-unstable, then you
> wait until that has propagated onto the servers or into linux-next,
> then base on that.  This approach is OK but I kinda unprefer it because
> there's a bit of latency and it makes it harder for me to prepare my
> "here's how v9 altered mm.git" summaries.
> 
> 
> Which would you prefer?

Well, given that Sashiko didn’t pick up my series based on mm-new, I’d
prefer to send a few follow-up patches in the hope that they will be
reviewed in the context of the original series.

Thanks,
Stanislav
