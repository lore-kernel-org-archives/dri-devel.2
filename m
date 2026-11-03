Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12360A3838
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpYfA8iv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B3C10F655;
	Tue,  3 Nov 2026 15:01:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95DA310F655
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:01:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19CFD609FB;
 Tue,  3 Nov 2026 15:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD2A1F000C1;
 Tue,  3 Nov 2026 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793718079;
 bh=pruwCsX2Nj8P2A3ZkDZfqhhveDP+NyBs8rSomhgGUU8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gpYfA8ivu0EAnWhduZFmphtcIFZSGsJJkhZlvzy5YyKRExQz2lKkkw8OFY07G7zhl
 QXK+/wAx2e3lUZBCumPvDuR1/CWFBc91Z6WG2Hpe/KA3keAWuqHeKEckj6rl+uRvUm
 0DD2mqqO1kQPWJtMH9mgPG2OwfUnYuJ9j6ikz9y+dNaFMbCTYjhiXpIP4eWCi5yjYi
 Hz31AyUaH/D1IdodghQ/+cQxG+cvoF7GjEMSxwIAcogBIdrkyj4oC8VJmOIa5uaDa8
 BqiLNz4agF5A0jKeip5ntCNO+LfhUsYbiRyktw0MpTevQA8rbeHsgsbIZcoz3mCr6C
 TOSw9p+fDzh/g==
Message-ID: <sashiko-outbox-195535@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 08/16] selftests/proc: check that a faulting reader
 doesn't hold up removal
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jann Horn" <jannh@google.com>, "Josef
 Bacik" <josef@toxicpanda.com>, "Chris Mason" <mason@kernel.org>, "Jeff
 Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Eric Dumazet" <edumazet@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>, "Jonathan
 Corbet" <corbet@lwn.net>, "Christoph Hellwig" <hch@lst.de>, "Greg
 Kroah-Hartman" <gregkh@suse.de>, "Joel Granados" <joel.granados@kernel.org>,
 "Kees
 Cook" <kees@kernel.org>, "Jan Kara" <jack@suse.cz>, "Jan Kara" <jack@suse.com>,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-serial@vger.kernel.org, "Takashi
 Iwai" <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>, tytso@mit.edu, dmitry.torokhov@gmail.com, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Anna Schumaker" <anna@kernel.org>,
 yukuai@fygo.io, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102-work-procfs-core-v1-8-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
 <20261102-work-procfs-core-v1-8-75df35e4f8b8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:01:17 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/proc: Makefile and .gitignore entries in wrong commit
--

commit 9de4ed28fcd6656e6c6c2bb55f1514d9aa6600f6
Author: Christian Brauner <brauner@kernel.org>

selftests/proc: check that a faulting reader doesn't hold up removal

This commit adds a selftest in tools/testing/selftests/proc/proc-remove-slo=
w-reader.c
that verifies removing a /proc/net/dev_snmp6/<dev> entry does not block whe=
n a
concurrent reader faults while copying to userspace via userfaultfd.

> diff --git a/tools/testing/selftests/proc/proc-remove-slow-reader.c b/too=
ls/testing/selftests/proc/proc-remove-slow-reader.c
> new file mode 100644
> index 0000000000000..a201645beca9d
> --- /dev/null
> +++ b/tools/testing/selftests/proc/proc-remove-slow-reader.c
> @@ -0,0 +1,133 @@
[ ... ]
> +TEST(remove_while_reader_faults)
> +{

[Severity: Low]
Should this commit also include the corresponding tools/testing/selftests/p=
roc/Makefile
and tools/testing/selftests/proc/.gitignore entries for proc-remove-slow-re=
ader?

In the current series, those entries:

  tools/testing/selftests/proc/Makefile:
    TEST_GEN_PROGS +=3D proc-remove-slow-reader

  tools/testing/selftests/proc/.gitignore:
    /proc-remove-slow-reader

were placed in the earlier commit ("selftests/proc: check that a faulting
readlink() doesn't hold up removal") before proc-remove-slow-reader.c exist=
s.
Building tools/testing/selftests/proc at that earlier commit or any interme=
diate
commit before this one fails due to the missing source file, breaking bisec=
tion,
and cherry-picking this commit on its own leaves the new test unbuilt.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-core-v1-0-75df35e4f8b8@kernel.org?part=3D8
