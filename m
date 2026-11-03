Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E77606B262
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lt7kWY0w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4072610F652;
	Tue,  3 Nov 2026 15:19:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5B4410F652
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:18:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BD644392A;
 Tue,  3 Nov 2026 15:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224A01F00A2C;
 Tue,  3 Nov 2026 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793719137;
 bh=pXYmXnE4YnSZAwVsghhJ8qwzD8WHMLT3acK3fEE1c5w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lt7kWY0w9ieExJiXhsRbswLZTk4I62Ut15H6kMqjEztfFu4VGWWEAsyq1h1RunGi7
 quYJ9gon1XZinTxL/vkjGOaRSh41+Spy89HkKrIkDLVlyQ2DPkr57UTA8uNv7ZJQPX
 Gkb+9Ork4a09lK3yz7JxXHSWqFcBarBUl6xpojcbcZ6LCj9+K0W6f0I8igzSlL1ee7
 HOzooULSEPo6yfs5dQxOzgo+Ck2+yelQJNljZ0d/RFz7CfzGvoYCRRMJGyc+UGPBSP
 xmtleTQuYNol2touf60/WN8WAXQ5Y7pfGj4AOYhP5EA7RtetswDsaHw6Wd78ymD48r
 5m+hEjoe7SkUg==
Message-ID: <sashiko-outbox-195594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 14/23] scsi: esas2r: let procfs copy the ioctl
 argument of the ATTONode file
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
In-Reply-To: <20261102-work-procfs-drivers-v1-14-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
 <20261102-work-procfs-drivers-v1-14-a994bd4d3b1a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:18:54 +0000
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
- [Low] scsi: esas2r: split declaration and initialization of __free() vari=
able in esas2r_ioctl_handler()
--

commit 0fd79b7040b09fc840e0499afbc88e68b34a3e18
Author: Christian Brauner <brauner@kernel.org>

scsi: esas2r: let procfs copy the ioctl argument of the ATTONode file

This commit factors the core logic of esas2r_ioctl_handler() into
esas2r_ioctl_buf() operating on a kernel copy of struct atto_express_ioctl,
and converts the procfs ATTONode file to use .proc_ioctl_buf and
.proc_ioctl_args so procfs handles copying the ioctl buffer in and out.

> diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esa=
s2r_ioctl.c
> index f99318f61c934..eb39ba8263b31 100644
> --- a/drivers/scsi/esas2r/esas2r_ioctl.c
> +++ b/drivers/scsi/esas2r/esas2r_ioctl.c

[ ... ]

> @@ -1515,19 +1501,43 @@ int esas2r_ioctl_handler(void *hostdata, unsigned=
 int cmd, void __user *arg)
> =20
>  	}
> =20
> +	return 0;
> +}
> +
> +int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *=
arg)
> +{
> +	struct atto_express_ioctl *ioctl __free(kfree) =3D NULL;
> +	int err;
> +
> +	esas2r_log(ESAS2R_LOG_DEBG, "ioctl (%p, %x, %p)", hostdata, cmd, arg);
> +
> +	if ((arg =3D=3D NULL)
> +	    || (cmd < EXPRESS_IOCTL_MIN)
> +	    || (cmd > EXPRESS_IOCTL_MAX))
> +		return -ENOTSUPP;
> +
> +	ioctl =3D memdup_user(arg, sizeof(struct atto_express_ioctl));

[Severity: Low]
This isn't a bug, but in esas2r_ioctl_handler() in
drivers/scsi/esas2r/esas2r_ioctl.c, ioctl is declared with __free(kfree) =3D
NULL at the top of the function before the argument validation check and
assigned later via memdup_user().

Per the Cleanup API conventions, could the __free(kfree) variable definition
and initialization be combined into a single statement at the point of
allocation:

	struct atto_express_ioctl *ioctl __free(kfree) =3D
		memdup_user(arg, sizeof(struct atto_express_ioctl));

after the early return check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-work-procf=
s-drivers-v1-0-a994bd4d3b1a@kernel.org?part=3D14
