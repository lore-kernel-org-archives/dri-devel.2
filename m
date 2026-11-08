Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E65606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 23:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uk3vcV63
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A676C10E255;
	Sun,  8 Nov 2026 23:07:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169CC10E1EB
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 23:06:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 236D161826;
 Sun,  8 Nov 2026 23:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F47C1F0089F;
 Sun,  8 Nov 2026 23:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794179212;
 bh=+hmt8D//cWlFZIK2gd8XAWnqPSRmuN+AV7WN05g2ZKM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Uk3vcV63rJrfwcgVsOd67WdpIIzLM6aI1T6mxDWcVeAp89KEIrK1qs1Jo/0CXbfVr
 fcB5OfUYm6A1ofkxHDIimthku5D6up2AwfJclwou/xfssTEksmoTFCPh6qRYO822DJ
 EhRnEjLYzoTsnLBGoMmRlIqxXhO3J0qU3a9xkOUBKZ62/7E7gXpM0Y1/YVI0vshtSY
 52prOE5oxeqq+KikhS0twOVm/jLDvQ4iNuV2r0zebHqOHd4g3oUQfCNUivQzCX6XdT
 UZFL6joCHzaV6LEr0rX1ZFk73a5tAndxwCDhfrV5IIcrXvBmWzHu1pyVC9JiNPnJot
 j+Mjz2sYtcMPA==
Message-ID: <sashiko-outbox-204150@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/9] dlm: Free dlm_ls in kobject release callback
To: "Ian Rogers" <irogers@google.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Kees Cook" <kees@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>, "Nayna
 Jain" <nayna@linux.ibm.com>, "Srish Srinivasan" <ssrish@linux.ibm.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Juergen
 Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Zhongqiu
 Han" <zhongqiu.han@oss.qualcomm.com>, "Alexander Aring" <aahringo@redhat.com>,
 "Felix Kuehling" <felix.kuehling@amd.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Zhihao
 Cheng" <chengzhihao1@huawei.com>, "Sumanth Korikkar" <sumanthk@linux.ibm.com>,
 "Bill
 Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org,
 dri-devel@lists.freedesktop.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108223913.3624571-6-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 23:06:49 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dlm: wrong Fixes commit and misleading subject for
  dlm_ls_release()
--

commit cebf1bf6f5d4b67423eada980e5a294abe491cc6
Author: Ian Rogers <irogers@google.com>

> dlm: Free dlm_ls in kobject release callback
>
> struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
> .release callback and dlm freed the lockspace structure directly via
> kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, freeing ls before the
> delayed kobject release runs causes a use-after-free, and unloading the
> module while the delayed release is pending results in an instruction
> page fault.
>
> Add a completion ls_kobj_done and dlm_ls_release() to complete it when
> the last kobject reference is dropped, waiting for it in free_lockspace()
> before kfree(ls) and in the new_lockspace() error path before module_put(=
).
> Also delete the kobject via kobject_del() before stopping dlm_recoverd
> to close the window where concurrent sysfs writes could wake the stopped
> recovery task.
>
> Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
> Acked-by: Alexander Aring <aahringo@redhat.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

[Severity: Low]
3514faca19a6 ("kobject: remove struct kobj_type from struct kset") only
removed the .ktype pointer from dlm_kset while leaving dlm_ktype.release
set to lockspace_kobj_release().  The commit that dropped the release
callback from dlm_ktype and started calling kfree(ls) directly after
kobject_put(&ls->ls_kobj) is 8a4cf500f1dd ("dlm: drop kobject release
callback handling").  Should the Fixes: tag point to that commit instead:

  Fixes: 8a4cf500f1dd ("dlm: drop kobject release callback handling")

Also, the subject line says dlm_ls is freed in the kobject release
callback, whereas dlm_ls_release() only signals ls_kobj_done and kfree(ls)
Still happens in free_lockspace() and new_lockspace().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223913.3624=
571-1-irogers@google.com?part=3D5
