Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E604606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtCghqTk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC88610E70C;
	Wed,  4 Nov 2026 09:24:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF42E10E884
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:24:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AAC8241A8A;
 Wed,  4 Nov 2026 09:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00EB1F000C1;
 Wed,  4 Nov 2026 09:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793784259;
 bh=gRXRlKwKxN+fSCr/T6i8djt87uv7sYA7hvMrxndI77U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DtCghqTk4F1EE9ZiaGiOl/CLyemjVYDJ+E2iTwlEuHko0AF2WQqNB2tyP1et6JQZd
 /s/kPoz0A0zF+b5fFAIFD3ImxnjD/VWhr5VSKRweQqln4RDl4AQZ0FVMn/i/yt7O88
 Ps9wlo2Fnfedf7faqa4SwwEANP4Q/4diwjkTX3mMumkt7VPx2Dq0vxvGBgDryWLmiO
 5lerAYpepz4/m8aYVA7ag928SM+ijqD5yy+IBJRJI2YPtpIITX1SvmPZzKqLhu/h1W
 WugE4uZByige6JL65yaTwMSDm+rRPo4EHgbghVb7x5+GS84YvD8WL3izKpfkYLWK0G
 hw+mR5o35+RDA==
Date: Wed, 4 Nov 2026 10:24:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, 
 Eric Dumazet <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
 Christoph Hellwig <hch@lst.de>, 
 Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados <joel.granados@kernel.org>, 
 Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, 
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org,
 sparclinux@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org,
 Takashi Iwai <tiwai@suse.de>, 
 linux-input@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-ext4@vger.kernel.org, 
 linux-modules@vger.kernel.org, Chuck Lever <cel@kernel.org>, tytso@mit.edu, 
 dmitry.torokhov@gmail.com, Petr Pavlu <petr.pavlu@suse.com>, 
 Anna Schumaker <anna@kernel.org>, yukuai@fygo.io,
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH RFC 04/16] proc: let procfs own the seq_file of seq_file
 entries
Message-ID: <20261104-hiebe-ausmachen-express-e9c87b962865@brauner>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-4-75df35e4f8b8@kernel.org>
 <sashiko-outbox-195531@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195531@kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 03:01:06PM +0000, sashiko-bot@kernel.org wrote:
> - [High] proc: unpinned dereference of pde->seq_ops->next in pde_seq_next()

Nothing in the tree returns ERR_PTR(-EIO) from ->next but moving the
check up would remove that possibility so yes.
