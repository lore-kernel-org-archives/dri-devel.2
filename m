Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03A606EE8D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 21:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iQQS2O2A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097AC10F214;
	Mon,  2 Nov 2026 21:15:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C460310F202
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 21:15:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B1E5601EF;
 Mon,  2 Nov 2026 21:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B7D1F00A1B;
 Mon,  2 Nov 2026 21:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793654100;
 bh=IboT5prE1F2zgLUjN3M8JJkwTsSKYt9w9Q1ZY5Lm5jE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=iQQS2O2AfQi+b0NdK1c/IizthlwDmBEQCWvAB+m+GRkBQynljQMNycIudYc/9h+f7
 Vawkm19O3oDCTmBHyvNQu/VA+okB5t8Z9fKADvjwmVYg9kIDcYS0RGx7iOgEusCIt0
 sSUI2zMCBo8GTTgwELt8DWSNAXGAXBVX+K5v7+akC4NonZ2T53NHL1PfwdD1coLE4T
 UgMKhDsPZNnCe/lwhxhJk5/Y/IQS2vyCvDzuusO+IC/e8MHzZliwnwssfEHb72ld6S
 NYbu/taiK9urXN1VFBXtl6MzT92tBVkBKu03gGwf0I/CNsbIMUlES7wZk9EI6GVBLy
 iYqmaA0XMCbyQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfauth.phl.internal (Postfix) with ESMTP id 3FB84F4006B;
 Mon,  2 Nov 2026 16:14:59 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
 by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 16:14:59 -0500
X-ME-Sender: <xms:U_3oagUAPKL0KahIhejOYJwKEPfYb6twqYG_HHugM7_eLn8Er-TgPg>
 <xme:U_3oavZTuzGHMfK0qXbinG0nc7CYskrIhJQ5eHOz_Ha7XvQtwnXU_T7hJPsGo9qg4
 BhXiwA3Pdzj3QiIOE4JzHYJnc55BkwZtZcinLkFBcrDsA6sylLxQvo7>
X-ME-Proxy-Cause: dmFkZTGSCWblgfsMhzNjEIN00ph1bmXztXGhYrK6FQCSJysx8m5mqsCTJHkCuZD0tpZuBG
 pYnx6qST1krVMCyjpYhoMBo2TltjSYVP2LKGOkZnOBb4t//k/nGoJ/SIXKKJyIATQl84il
 BuXRlRV3aPeB88TAd/llIDq/9PMZ1EzorVjUV4ox06mXS/IOKUqdbOTFcr2gFtJFq3Gx7F
 Zq0nEujwlkDiPcDOX28riG6oQW7iLTgD6BaMnfnV9H0ADvTknFe8adm4EFa+o6I1mSuG3K
 LJ3epAVfTBg3DuzNRu88aZuYWYeuI7KoVJah/eioVIkx6sAoHZjqyTVRvcNhYqHYgvNdOh
 F7RoapMXPpPy7fnRDGp1EnOzRafp7mYLbQvUWevKonPpL0zVugnrni/xwOB0ZUdq15K6LL
 U4eIWAyGEDjfaCYO/Dppo1HoBBuP1Ugp4Zki+kXZHcTkA1gjEQVaV70KrwrPcut26vPd/h
 q5yJSVyn3x/Ch0xklWbVCXPbWoaIS17brwWPL/guaVzJxizQ0P/jgX0plm53NXTsLd+70V
 110yVl467ZsRMKGBWdC4JnWQHbcxAMHjeZkhkyAsfOuCVSLebxwzvInrQKLcoImyb5UwHY
 pO0Oc+d4/j2oJCRnrCOkOe51eLIclfMVgyBLq7y/6qqZiV8XA97NvuTzr1lg
X-ME-Proxy: <xmx:U_3oatxqYhX0hWpcSGJgdTO64UmbQLn1zkSvkgmn2QN3P9YNu5WJ0w>
 <xmx:U_3oav5HgW2k6KeJbHXAdQUNPTjXcBKAkESvLUwa5JME7gNZc5c0tQ>
 <xmx:U_3oasSgNqIt2BaGeBZ12VcERyFoy0lpk1cdl0eiT57vWKlvWpphXg>
 <xmx:U_3oaifZ0cTDaYHT72Jch7KjTqrgvVpyqwgckwFzCeMt7Uwl9HyKaw>
 <xmx:U_3oapwU7EvPML2sBaImLYgTk9SsDSGibfYemkcHEOBIYG1GVrkdWT-b>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 181AE78273B; Mon,  2 Nov 2026 16:14:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlKaHQIBeldV
Date: Mon, 02 Nov 2026 16:14:38 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jann Horn" <jannh@google.com>, "Josef Bacik" <josef@toxicpanda.com>,
 "Chris Mason" <mason@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, "Eric Dumazet" <edumazet@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jonathan Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>,
 "Greg Kroah-Hartman" <gregkh@suse.de>,
 "Joel Granados" <joel.granados@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org,
 "Linuxppc Dev" <linuxppc-dev@lists.ozlabs.org>, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org,
 coreteam@netfilter.org, kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
 linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 "Takashi Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org
Message-Id: <961e7e3d-2117-48ee-8a7e-a7a851ec8ef8@app.fastmail.com>
In-Reply-To: <20261102-work-procfs-fs-v1-6-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
 <20261102-work-procfs-fs-v1-6-d09a996317b3@kernel.org>
Subject: Re: [PATCH RFC 06/27] nfsd: let procfs own the seq_file of
 /proc/fs/nfs/exports
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, Nov 2, 2026, at 10:07 AM, Christian Brauner wrote:
> Declare the seq_operations and let procfs open and free the seq_file.
> ->proc_open() and ->proc_release() only set up ->private and take and
> drop the reference to the network namespace now. Reading the file then
> no longer holds up its removal.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
