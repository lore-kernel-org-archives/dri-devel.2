Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3247C606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=It3CPMWW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B74210E2F6;
	Wed, 18 Nov 2026 07:26:21 +0000 (UTC)
X-Greylist: delayed 356 seconds by postgrey-1.36 at gabe;
 Wed, 18 Nov 2026 07:26:15 UTC
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81D8010E2F6;
 Wed, 18 Nov 2026 07:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
 Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
 References; bh=BP5uJPFEij5TgQlQa0MnVpdjGYnsN3jkV0Ck605J8vA=; t=1794986775;
 x=1795591575; b=It3CPMWWgUlr79GyrOqohEDfLJ0LM6TtYQHzhd4MzNh8U4e4pfZXtGuPUv5Vz
 CeQrvH9yAyWbcuh/SNNwWOIYFu3nf0zkuC5XYV0EyzCdkhejIXYMGbHYPEwc5kNJpwCJIgnxTdB5g
 R+wYCdV9L9hnz2cWFK/XrfhDQSTGAbakMs44TrC4tGfonOCf1U89a0zPou6ZfxjYx7L7LmAWDsmFX
 zuBmTdQ3nFTGotYh/uFy97W1x/PZHwZqd4t+y7XnCuN7fcad9KXXvHqmdq6k2MfdvOUXkvQTBcpEC
 87TC8loKaWoxmwZIF34btya/3KHxxPJAJVrATVvkNfyBxwHcFQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.100) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1xTZxc-00000000Itt-3izf; Wed, 18 Nov 2026 08:20:04 +0100
Received: from p57bd95b5.dip0.t-ipconnect.de ([87.189.149.181]
 helo=[192.168.178.61]) by inpost2.zedat.fu-berlin.de (Exim 4.100)
 with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1xTZxc-00000000GfQ-25vy; Wed, 18 Nov 2026 08:20:04 +0100
Message-ID: <88645597bb3aeae8d36a7b5c499a0a6d74b4acc4.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to
 ktype_percpu_entry
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ian Rogers <irogers@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman	
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, Srish Srinivasan	
 <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, Yoshinori Sato	
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Juergen Gross	
 <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Oleksandr
 Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers	 <ndesaulniers@google.com>, Viresh
 Kumar <viresh.kumar@linaro.org>, Zhongqiu Han	
 <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Zhihao Cheng <chengzhihao1@huawei.com>,
 Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling	
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 driver-core@lists.linux.dev, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, 	linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, 	linux-s390@vger.kernel.org,
 gfs2@lists.linux.dev, xen-devel@lists.xenproject.org, 
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 18 Nov 2026 08:20:02 +0100
In-Reply-To: <20261108223913.3624571-4-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-4-irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ian,

On Sun, 2026-11-08 at 14:39 -0800, Ian Rogers wrote:
> In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
> kzalloc_obj() and initialized with ktype_percpu_entry. When
> sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
> because ktype_percpu_entry lacks a .release callback.
>=20
> Provide a sq_kobj_release() callback that calls kfree(kobj).
>=20
> Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
> index 908a8e09113b..f33864958487 100644
> --- a/arch/sh/kernel/cpu/sh4/sq.c
> +++ b/arch/sh/kernel/cpu/sh4/sq.c
> @@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops =3D {
>  =09.store=09=3D sq_sysfs_store,
>  };
> =20
> +static void sq_kobj_release(struct kobject *kobj)
> +{
> +=09kfree(kobj);
> +}
> +
>  static struct kobj_type ktype_percpu_entry =3D {
> +=09.release=09=3D sq_kobj_release,
>  =09.sysfs_ops=09=3D &sq_sysfs_ops,
>  =09.default_groups=09=3D sq_sysfs_groups,
>  };

Looks good to me, thanks!

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
