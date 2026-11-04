Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E3606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=alKTGqUn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE7810E364;
	Wed,  4 Nov 2026 09:28:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE56010F746
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:28:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 596F8605F0;
 Wed,  4 Nov 2026 09:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB561F000C1;
 Wed,  4 Nov 2026 09:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793784532;
 bh=T01zQUJSjbZp4aJnpwJVQI9JvpnXX6u13mZcG0ZeyDQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=alKTGqUnuzoexCqwA81KPAyGy0rneY6r5MbFqbvV697+Ik/bjfxk9LHef9GM+MQJQ
 QlHwwMzWgTBR+V1EVZkBqvL2y+0fpSnZdIRpFx1eImmWwcDpXf+kwZoN+KfbPRIwjh
 GLUEX2tS20NdiCJARKDNfWQpLYmSC9HacZQpjtFGF6DQjakJaImqqw+1NVIZp8Jkve
 rhjW0cKAwa0rgro+T+KAxTAshgpXhyosdPn/BLM1fw2d0BZ8BRed4fxkWyQdPz2E0I
 sRYd32Lzz24ZCjwV4++8ADyzClHdrBNXy/ODBoctV+0gtJXx39Cw7SDphwQ7RfGct5
 fVZStrNkhDPHg==
Date: Wed, 4 Nov 2026 10:28:38 +0100
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
Subject: Re: [PATCH RFC 11/23] selftests/proc: check that a faulting writer
 doesn't hold up removal
Message-ID: <20261104-miterleben-erdaushub-insel-df331d74044d@brauner>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-11-a994bd4d3b1a@kernel.org>
 <sashiko-outbox-195591@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-195591@kernel.org>
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

On Tue, Nov 03, 2026 at 03:18:48PM +0000, sashiko-bot@kernel.org wrote:
> - [Medium] selftests/proc: fail and leak scsi_debug host without CONFIG_SCSI_PROC_FS

Fixed.
