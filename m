Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58086082625
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+DHogNG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3130A10EFEC;
	Mon,  2 Nov 2026 15:24:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4299A10EFF5
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 15:24:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13B2243E56;
 Mon,  2 Nov 2026 15:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2A01F00A1D;
 Mon,  2 Nov 2026 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793633075;
 bh=hWdxbpN4QmmVdM7UmPZX8KG1qjYZ0FQqqjiDA/VJnOE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject;
 b=J+DHogNG8xdnEszNWTq5MBT4owxXd0VhSVou4mawVRGShPKy66993z6LsyBYM0oY9
 0C9VWdQ76OI3OO7cGfgJhCJNhefggAs4sUh4CONV/qDGqgihgOF1PnXUKtNqbKn0kP
 7gEiURkvoZ0y6HIwI4hm+VDpZLqoFWP0MtUvV1+pZ82BDrMqYKfV214O+TPFh28mzm
 v96OqDsW8SRd4fYSEdOiiPPfA1jG3KBDO2LlYhebX00EokY2M2AJ9X5lWyNjYtY/Z2
 cJZ9gagufAYDvWXS6/1D7s4Tt9v0IV7oVPNDyfmBRUrvojw6KUfHR+aU5D/0doL4ww
 OWnvINfbietzQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfauth.phl.internal (Postfix) with ESMTP id DF743F4006D;
 Mon,  2 Nov 2026 10:24:32 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
 by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 10:24:32 -0500
X-ME-Sender: <xms:MKvoamktWPzVHfGfqMnfBUnX12mAfqCNpYg1mnZpsjjQlytnP_GDFQ>
 <xme:MKvoaop_snACaCPsp8UbIkrX0VuTUqCS69NZfmyEg5VuQEMOwP74tDssm1mbMC7Na
 L4psiUcO7zb92ZqJJXrSnVU02K155UK_Jvir1-pnBpDMj8LrjlTIfw>
X-ME-Proxy-Cause: dmFkZTF7ntWmEwgGBlbXwlipOb1DEBDQAhhX0OL7W3ESE1c4Y58F5UnDJyEt8dnhIEkW49
 bSUNjezLoMpeptFAstes/dup+GOJHwOWVb/CWlJyXGn193f8h3l5hsZNShVjOQjsTRohCX
 A7NtHx/zL2ejOFY7nM9kfOFgoikYlrAckYOu8f7hASCDsja6Hrk1rI2T70O3iMDfg2SxYY
 Zur9L5i46jczvGC4EKxzEWA1pfFm+yB6AEfDhOzVlEFraYBZk0g/TI7U6Rq0NVJniUPAx0
 Ms7uiqAKvKWNclTSyqDyA2iZMVN/pSNwwcfh4DKH9umqsend9fzIPoI/wbZ2BY53mtMFZy
 zDHyo9usdkoEZaEpmTNoGa94y6UWs06X2+Vvayf+hT5Q00wB62DyIvXiaKtIAqQyvgezJX
 gMQyOIOZt2s0Ka06QtKc3yinHtSyP17AYeV498V+x9QPrcYPy/IjcANtd5PFTt0p4ZP/mb
 BYBzvQSBaIjqqrl6pc9hfHnF5W5BzvpNOjFH5WhHliptZEM76ApxkAEWqTQikHqy9MLimT
 SOmvYcd4EnPUd4aMEDJn0RYBZW3qZ11uB8PJIkz4XPQ45DzjQhNh88B7wEg8tgVl/zJsOZ
 8EVVdmAwwXqghCDy2L29cKu7oFIfpgdJuXdxVYsukJyDY7oGAc97hUYTlUrg
X-ME-Proxy: <xmx:MKvoahKh4Qxz2XET1vMc0TgeYLzxxsBqS_5-gXCDYyuzFKNMCpL9Gg>
 <xmx:MKvoajCApUsLjsSQE9T0YLW3NG1H8MteSFyAcNeQhGG7lN4po_K-oQ>
 <xmx:MKvoasLUqk4CAxihafDuvBm16uXYM-rD8PxB1Cn0GLv2DlrRcrPt0A>
 <xmx:MKvoajioD5IUkBoHBGTIovYDFn5dB2KnImSD1Ef9OftQO8lfEDDkGg>
 <xmx:MKvoaos93Fcbt_R095IT3GL8KWMxtU_fU-6c7khNrkI4NMTo4hEWeMfk>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id AE2CD782738; Mon,  2 Nov 2026 10:24:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG7Lg66T4xgg
Date: Mon, 02 Nov 2026 10:24:12 -0500
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
Message-Id: <097f592a-d943-4740-b99b-8983527095eb@app.fastmail.com>
In-Reply-To: <20261102-work-procfs-fs-v1-4-d09a996317b3@kernel.org>
References: <20261102-work-procfs-fs-v1-0-d09a996317b3@kernel.org>
 <20261102-work-procfs-fs-v1-4-d09a996317b3@kernel.org>
Subject: Re: [PATCH RFC 04/27] lockd: let procfs copy out reads of
 nlm_end_grace
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
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Acked-by: Chuck Lever <cel@kernel.org>


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
