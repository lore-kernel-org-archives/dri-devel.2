Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06736606D82D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BS3XZKDa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680BB10E293;
	Thu,  5 Nov 2026 19:29:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF09C10E293
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:29:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9619643BEE;
 Thu,  5 Nov 2026 19:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BECE1F00A02;
 Thu,  5 Nov 2026 19:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793906940;
 bh=bwgr0VzVaD2N9H/j3vgcXycx8H7hODk9Lndt/rv7J/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BS3XZKDaZFqTzEkNK9cZ527vT05nQuRqIDjUKiUIf9jx85/EdPLYb0Z0y2P1F/dSr
 cLz8PVwZTDq2+LckdmqgyJzYBdcLi6vbD+TgraxVJ/TKav0Apjdcte0M2LitavcWXu
 31sb0JElkWITsGXKzYHHXBcox2SfnEE32gjOr2QsFbRND4hlqQRt2MMTyGa/6k8cHB
 YEmqHkJb3KndD7l0LYWjOi4ddQ9wbEk5wPLHn/WamkFT57rjTzOkA05yE70xCSrR5q
 981HyR3mf5h9r4lxyP6tj4pIri36VruMAV5ujmeRAKVrr3ZhUPLCXFzWwc1wxgznlM
 PAXiCJ1oQKLsQ==
Message-ID: <sashiko-outbox-199869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 06/51] powerpc/pseries: put the node that the
 ofdt property commands look up
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
In-Reply-To: <20261104-work-procfs-bugfixes-v2-6-021c84d852e0@kernel.org>
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org>
 <20261104-work-procfs-bugfixes-v2-6-021c84d852e0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:28:58 +0000
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
- [Low] powerpc/pseries: __free(device_node) declared =3D NULL at top of fu=
nctions
--

commit 3c337546ce05e068449f95031255af375235286d
Author: Christian Brauner <brauner@kernel.org>

powerpc/pseries: put the node that the ofdt property commands look up

This commit uses __free(device_node) in do_add_property(),
do_remove_property(), and do_update_property() to release the device_node
reference obtained by parse_node() via of_find_node_by_phandle().

> diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/pla=
tforms/pseries/reconfig.c
> index 18e3f1a036e35..5a0c9c0b6253f 100644
> --- a/arch/powerpc/platforms/pseries/reconfig.c
> +++ b/arch/powerpc/platforms/pseries/reconfig.c
> @@ -271,8 +271,8 @@ static char *parse_node(char *buf, size_t bufsize, st=
ruct device_node **npp)
> =20
>  static int do_add_property(char *buf, size_t bufsize)
>  {
> +	struct device_node *np __free(device_node) =3D NULL;
>  	struct property *prop =3D NULL;
> -	struct device_node *np;
>  	unsigned char *value;
>  	char *name, *end;
>  	int length;
> @@ -296,7 +296,7 @@ static int do_add_property(char *buf, size_t bufsize)
> =20
>  static int do_remove_property(char *buf, size_t bufsize)
>  {
> -	struct device_node *np;
> +	struct device_node *np __free(device_node) =3D NULL;
>  	char *tmp;
>  	buf =3D parse_node(buf, bufsize, &np);
> =20
> @@ -315,7 +315,7 @@ static int do_remove_property(char *buf, size_t bufsi=
ze)
> =20
>  static int do_update_property(char *buf, size_t bufsize)
>  {
> -	struct device_node *np;
> +	struct device_node *np __free(device_node) =3D NULL;

[Severity: Low]
This isn't a bug, but in do_add_property(), do_remove_property(), and
do_update_property() in arch/powerpc/platforms/pseries/reconfig.c, np is
declared with __free(device_node) =3D NULL at the top of each function and
assigned later via parse_node(buf, bufsize, &np), whereas cleanup.h
conventions require defining and initializing __free() variables in a single
statement.

Since parse_node() is a static helper only called by these three functions:

static char *parse_node(char *buf, size_t bufsize, struct device_node **npp)
{
	char *handle_str;
	phandle handle;
	*npp =3D NULL;
	...
	*npp =3D of_find_node_by_phandle(handle);
	return buf;
}

could parse_node() return struct device_node * directly (and advance char
**buf) so that struct device_node *np __free(device_node) can be defined and
initialized in one statement in each caller?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-work-procf=
s-bugfixes-v2-0-021c84d852e0@kernel.org?part=3D6
