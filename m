Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F44FCC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 22:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEDE10FA26;
	Tue, 13 Oct 2026 22:54:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B96610FA26
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 22:54:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 89D9260236;
 Tue, 13 Oct 2026 22:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8701F00893;
 Tue, 13 Oct 2026 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791932058;
 bh=PPjRPdoXmqcoE+yKsFNTRZ91VsaW0SCaan3CS2orgSM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aD/J83amyEpQPtNDSR5Y7mWcIWtxo0L7j2puj21nguKWbVacHXWltVdWd0wx6FQyE
 XnG3sqn2UllfFA5KFSALl2ZVLQXBK+/PaLXfHHxqPuN1OL21uw0Y2toUIUKShVhH6p
 VweMqeryKBFbRTeJFayB6ymM5m4PoNpkeqYcXglYLI3moQygYDJP6AoDgJ+s6N5Fnf
 ctUQYCfm+kKqaIlsILDzKHfcx3kYthBKYDF8LvMXDMTyvWnGxvSzariGkB9tTpoG1A
 DucOzxqIk7Z8Gq4FptC9R9eu/3q2V01IYy+ORpbuXnoB+jDM4c02fERIzmEljtkuWR
 WqcKRIq0nw6tA==
Message-ID: <sashiko-outbox-170607@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] ACPI: CPPC: Free cpc_desc in kobject release
 callback
To: "Ian Rogers" <irogers@google.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Kees Cook" <kees@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>
Cc: "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>, "Nayna
 Jain" <nayna@linux.ibm.com>, "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "David Teigland" <teigland@redhat.com>,
 "Alexander
 Aring" <aahringo@redhat.com>, "Juergen Gross" <jgross@suse.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Sven
 Schnelle" <svens@linux.ibm.com>, "Richard Weinberger" <richard@nod.at>, "Zhihao
 Cheng" <chengzhihao1@huawei.com>, "Felix Kuehling" <Felix.Kuehling@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
 linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261013223946.1836757-6-irogers@google.com>
References: <20261013223946.1836757-1-irogers@google.com>
 <20261013223946.1836757-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 22:54:16 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] acpi: cppc: dangling per-CPU pointer after exit leads to UAF
- [Medium] acpi/cppc: missing kobject_del() causes sysfs -EEXIST on driver =
re-bind
--

commit 1405c81459a62da53ac116a49a65cbdc3bcdcd68
Author: Ian Rogers <irogers@google.com>

ACPI: CPPC: Free cpc_desc in kobject release callback

cpc_desc_ptr embeds a struct kobject that is registered in sysfs via
kobject_init_and_add(), but cppc_ktype lacked a .release callback and
acpi_cppc_processor_exit() freed cpc_ptr immediately after kobject_put().
This patch moves the sys_mem_vaddr unmapping and kfree(cpc_ptr) into a new
cppc_release() callback.

> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index f370be8715ae2..0fefe1cdb60ce 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> [ ... ]
> @@ -961,15 +966,7 @@ void acpi_cppc_processor_exit(struct acpi_processor =
*pr)
>  	if (!cpc_ptr)
>  		return;
> =20
> -	/* Free all the mapped sys mem areas for this CPU */
> -	for (i =3D 2; i < cpc_ptr->num_entries; i++) {
> -		addr =3D cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
> -		if (addr)
> -			iounmap(addr);
> -	}
> -
>  	kobject_put(&cpc_ptr->kobj);

[Severity: High]
Does this leave a dangling pointer in the per-CPU variable?

When acpi_cppc_processor_exit() drops the kobject refcount, the underlying
memory is freed. However, it seems per_cpu(cpc_desc_ptr, pr->id) is never
set to NULL.

Could other CPPC functions that rely on this pointer being NULL if
uninitialized, such as cppc_get_perf_caps():

	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
	// ...
	if (!cpc_desc) {
		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
		return -ENODEV;
	}

successfully pass the check on the dangling pointer and trigger a
use-after-free upon driver unbind?

[Severity: Medium]
Could omitting kobject_del() here cause a sysfs -EEXIST error when the
driver is re-bound?

The teardown path drops the reference but appears to omit explicitly
unregistering the sysfs directory. If the kobject's refcount does not
immediately reach 0 (for example, if userspace has a CPPC sysfs file open,
or if CONFIG_DEBUG_KOBJECT_RELEASE=3Dy defers the release), the sysfs
directory is not synchronously removed.

Should kobject_del() be called before kobject_put() to ensure a subsequent
kobject_add() in the probe path does not collide with a lingering sysfs
directory?

> -	kfree(cpc_ptr);
>  }
>  EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013223946.1836=
757-1-irogers@google.com?part=3D5
