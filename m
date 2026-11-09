Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D4606A33C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iU5O51DC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777BA10E87E;
	Mon,  9 Nov 2026 11:27:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AD010E87E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 11:27:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF2E9630DB;
 Mon,  9 Nov 2026 11:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EA41F0089F;
 Mon,  9 Nov 2026 11:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794223656;
 bh=GTe3rVqqBFubJwfvXPNDDRZX+sidHXepwnZzWomDy5A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iU5O51DC6zVVQKzDHuys9tIxjfbSOhYw8z0UcE86pb//wkXavh32S2N8S2PUurU2A
 o1E3RopKG7W94xtmWo25LA834OkIsoplK5Zc5sWRxNqoMBKXFQxzncUeAVAHVqzYUN
 x0xzl99BebTVjgItzYyFM18S+rvSgi3xMyTZJ/jJZ69X0Gf56Vq2vszIAP9EEsAUq5
 YP1A5SHoyPmQVAQUq/DaV61yYmuj4yVaaeC+HIcZMJhadQiWUxN4AW86j7fp4xdZK/
 SKtdAofdOgM6AVAC0cEZ3+8Z/6By8LpM/kvwzBv9E4RtCHAt3TdDxZIlKuxADBPb0I
 863RWmyUQ6DWA==
Date: Mon, 9 Nov 2026 12:27:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>,
 Josef Bacik <josef@toxicpanda.com>, 
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, 
 Eric Dumazet <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
 Christoph Hellwig <hch@lst.de>, 
 Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados <joel.granados@kernel.org>, 
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-um@lists.infradead.org, 
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
 coreteam@netfilter.org, 
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-cifs@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, 
 sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-doc@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 07/23] proc: let procfs own the seq_file of
 seq_file entries
Message-ID: <20261109-atemberaubend-begabung-bedienen-85aade0f99b4@brauner>
References: <20261104-work-procfs-core-v2-0-76ace653a773@kernel.org>
 <20261104-work-procfs-core-v2-7-76ace653a773@kernel.org>
 <8A21EE2A-F392-40B7-9152-CBC440FDDA70@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8A21EE2A-F392-40B7-9152-CBC440FDDA70@kernel.org>
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

On Sat, Nov 07, 2026 at 08:10:28AM -0800, Kees Cook wrote:
> Please use the new style typed allocation calls for objects:
> 
> ops = kmalloc_obj(*ops);
> 
> (This happened to jump out at me, but please check the other patches for this pattern.)

Done, there are 5 of them in total:

proc: resume readdir after the last name it returned
-		cursor = kmalloc(sizeof(*cursor), GFP_KERNEL_ACCOUNT);
+		cursor = kmalloc_obj(*cursor, GFP_KERNEL_ACCOUNT);

proc: sysctl: resume readdir after the last name it returned
-		cursor = kmalloc(sizeof(*cursor), GFP_KERNEL_ACCOUNT);
+		cursor = kmalloc_obj(*cursor, GFP_KERNEL_ACCOUNT);

proc: keep the open files of an entry in an open node
-		dp->open = kzalloc(sizeof(*dp->open), GFP_KERNEL);
+		dp->open = kzalloc_obj(*dp->open);

proc: own the wait queue of an entry with a ->proc_poll()
-	on = kzalloc(sizeof(*on), GFP_KERNEL);
+	on = kzalloc_obj(*on);

proc: let procfs own the seq_file of seq_file entries
-	ops = kmalloc(sizeof(*ops), GFP_KERNEL);
+	ops = kmalloc_obj(*ops);

-- 
