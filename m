Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A8E606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UgbqD2XS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B9610E159;
	Sun,  8 Nov 2026 23:10:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C6D10E159
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 23:10:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C92D461826;
 Sun,  8 Nov 2026 23:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0561F0089F;
 Sun,  8 Nov 2026 23:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794179444;
 bh=SJrTRZvefBM+D9+/dd7LygrzgO1jMHec9WFWbzhuafs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UgbqD2XSdyGktVJEJhI8+QvVyWG+cq/0XfiKL6PYXQjacoO71WmQpzpgK3T9NEgyL
 MCW+PU/nk2t29laNSG6YPzxo1waBrUXmR3iybjEjV7laQEBl1mK9n4vocFBccU1F8x
 j5tfv+nVhTD9ayYbH3pP9d7ml5VNKgv86aTSnvuVPM24VoRdKG/Sh9EV2xMnMzesbI
 Un8OivitWJrCoqvBYuaXCIeM+Q7+RExpdXNOupt3EphzCBK7sK1wOsnoAGf8P2Qkug
 oTppSKhkwSZAregyJkTePZWKDOFT/ho+EHYl2EIR7zmYMenPpJddSOjHCFBoz2qAfD
 McA00Yi8UNxNQ==
Message-ID: <sashiko-outbox-204152@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] ubifs: sysfs: Use kset_create_and_add() for
 ubifs_kset
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
In-Reply-To: <20261108223913.3624571-8-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 23:10:42 +0000
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
- [Low] ubifs: sysfs: inaccurate Fixes trailer in commit message
--

commit 05ad573fa4719a7a6e36bb8dcf3c9060b5c194b0
Author: Ian Rogers <irogers@google.com>

> ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
>
> ubifs_kset was a static struct kset using a custom ubifs_ktype that
> had no default_groups and no .release callback. With
> CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, unloading the ubifs module while delayed
> kobject release is pending causes a use-after-free on the static kset.
>
> Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
> allocated kset via kset_create_and_add().
>
> Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
> Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

[Severity: Low]
203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()") only added
an error-path kset_put() when kset_register() fails.  The static
ubifs_kset, ubifs_ktype without a release callback, and kset_unregister()
on module exit were introduced in 2e3cbf425804 ("ubifs: Export filesystem
error counters").

Should the Fixes tag instead be:

  Fixes: 2e3cbf425804 ("ubifs: Export filesystem error counters")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223913.3624=
571-1-irogers@google.com?part=3D7
