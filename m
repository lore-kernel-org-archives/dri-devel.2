Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54644606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2Hc6xFR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3862910E692;
	Sun, 22 Nov 2026 22:02:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8777E10E6C4;
 Sun, 22 Nov 2026 22:02:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A73B7602C2;
 Sun, 22 Nov 2026 22:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DB11F000C6;
 Sun, 22 Nov 2026 22:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795384942;
 bh=sTtlSSaGTpDBtcMHiOircAIvmiTH+Ctop/XsFzGC1x4=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=k2Hc6xFRtkicPKFvuKT7zGdEMFSb//oYzAC6yGi4WET4vMctzGLV95ptNtrt42XPr
 WQXnncoUOn8vCWB5V+5BOCSO1YRgvEGvWFlC6kSpFwx64JgBjdDeDjN8t0GAWjAHIl
 OTUhOZXnH51x9+wu6dE5+5xRqac3uNPyE7pzVVKvZEWUvPhn37jeV+RfXXnvGy2n+o
 5fpjybhz8GWsaKNEldr/b1vfp4LchA2oilYAZk48pyxh0hZg4h3t2J1QwAu6uVH9h7
 a22sYJ2GBWGWAOsKWbURM4twq7Z2FvgS7RP2m5XNLf/srWoFugU+HT+1vi7WOYs8uY
 PaUfPtPCWI/6w==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Nov 2026 23:02:06 +0100
Message-Id: <DN22U90WCTGB.1REAOP1PQUMIQ@kernel.org>
Subject: Re: [PATCH v4 0/9] Add __must_init and require explicit
 kobj_type::release
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Kees Cook"
 <kees@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Srish
 Srinivasan" <ssrish@linux.ibm.com>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "Christophe
 Leroy" <chleroy@kernel.org>, "Nayna Jain" <nayna@linux.ibm.com>, "Mimi
 Zohar" <zohar@linux.ibm.com>, "Yoshinori Sato"
 <ysato@users.sourceforge.jp>, "Rich Felker" <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "Juergen Gross"
 <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, "Nathan Chancellor"
 <nathan@kernel.org>, "Nick Desaulniers" <ndesaulniers@google.com>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "Zhongqiu Han"
 <zhongqiu.han@oss.qualcomm.com>, "Alexander Aring" <aahringo@redhat.com>,
 "Felix Kuehling" <felix.kuehling@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Sumanth Korikkar" <sumanthk@linux.ibm.com>, "Bill Wendling"
 <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 <driver-core@lists.linux.dev>, <llvm@lists.linux.dev>,
 <linux-hardening@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-sh@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <gfs2@lists.linux.dev>, <xen-devel@lists.xenproject.org>,
 <linux-mtd@lists.infradead.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <agordeev@linux.ibm.com>, <airlied@gmail.com>, <alexander.deucher@amd.com>,
 <catalin.marinas@arm.com>, <chao@kernel.org>, <deller@gmx.de>,
 <dennis.dalessandro@cornelisnetworks.com>, <dmaengine@vger.kernel.org>,
 <gor@linux.ibm.com>, <hca@linux.ibm.com>, <jaegeuk@kernel.org>,
 <James.Bottomley@HansenPartnership.com>, <jgg@ziepe.ca>,
 <jlbec@evilplan.org>, <johan@kernel.org>, <joseph.qi@linux.alibaba.com>,
 <leon@kernel.org>, <lihuisong@huawei.com>, <linusw@kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-erofs@lists.ozlabs.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <linux-fbdev@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <mark@fasheh.com>, <neescoba@cisco.com>,
 <ocfs2-devel@lists.linux.dev>, <satishkh@cisco.com>, <simona@ffwll.ch>,
 <sre@kernel.org>, <vkoul@kernel.org>, <will@kernel.org>, <xiang@kernel.org>
To: "Ian Rogers" <irogers@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261119192520.1983406-1-irogers@google.com>
 <20261122215639.1178566-1-dakr@kernel.org>
In-Reply-To: <20261122215639.1178566-1-dakr@kernel.org>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

(Cc: more people previously Cc'd on v2)

On Sun Nov 22, 2026 at 10:56 PM CET, Danilo Krummrich wrote:
> On Thu, 19 Nov 2026 11:25:11 -0800, Ian Rogers wrote:
>> [PATCH v4 0/9] Add __must_init and require explicit kobj_type::release
>
> Applied, thanks!
>
>   Branch: driver-core-testing
>   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/drive=
r-core.git
>
> [1/9] Compiler Attributes: Add __must_init macro
>       commit: b8a53320a885
> [2/9] powerpc/secvar: Add missing kobject release callback to secvar_ktyp=
e
>       commit: 4d5d4dd2a2e2
> [3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
>       commit: d19384f2f3c7
> [4/9] cpufreq: governor: Initialize kobj_type release callback statically
>       commit: 009365942c15
> [5/9] dlm: Wait for kobject release before freeing dlm_ls
>       commit: 48ae948f4285
> [6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
>       commit: ecaf88d385c1
> [7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
>       commit: 25d952902dee
> [8/9] drm/amdkfd: Free queue in procfs_queue_type kobject release callbac=
k
>       commit: 6d4ff4a020cf
> [9/9] kobject: Require explicit initialization of struct kobj_type::relea=
se
>       commit: 45eeed1f8094
>
> The patches will appear in the next linux-next integration (typically wit=
hin 24
> hours on weekdays).
>
> The patches are in the driver-core-testing branch and will be promoted to
> driver-core-next after validation.

I've now picked this up; I will keep this series in driver-core-testing for=
 a
few more days before moving it to driver-core-next. Please let me know if t=
here
are any concerns with the series, particularly the comments in patch 9.

Thanks,
Danilo
