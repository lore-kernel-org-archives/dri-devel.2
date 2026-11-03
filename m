Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54B606A32F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuKAd+2p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1AA10E7E9;
	Tue,  3 Nov 2026 22:01:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E9610E3E4;
 Tue,  3 Nov 2026 22:01:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B58204026B;
 Tue,  3 Nov 2026 22:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E5C1F000C1;
 Tue,  3 Nov 2026 22:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793743281;
 bh=R6uA9hX7fD85rhN6sNXcNNPGP4g4K/KhTQ6rqqOfAX0=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=AuKAd+2pAiWxmodz6a5kLrzOGag2dQXGCvIWfiU2SqiHPwjnt+DZeZOIZzwDoeFgW
 f5tvI82TTyJbTTJBeMupREcEqkEJOTnvm2tcg6rR6KzI977TOiUnB4XfJblBR0m8Ko
 3on7l/RW87okd18TkMziqprxQ9KNwBaxunuTpwN+wdELBok8svqqglFYItI7OaAie9
 SaIAxAjUUZc0FGMB/GEzff7Fem5FCCZW2y7K8Ha9aPGJ34HwNpxMac8F2DMTukXzX4
 NMMYmaBoHXuYiAJmGYwn0YL5KCqaN+IzO8Fe7/dimMO7SXev4BOPXOSMGcMZiQPmb5
 yEemvUz0AwJZg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 23:01:15 +0100
Message-Id: <DMLWX8NY1N1N.2OMQMQCIVRR18@kernel.org>
Subject: Re: [PATCH v2 0/9] Add __must_init and require explicit
 kobj_type::release
Cc: "Kees Cook" <kees@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Zhihao Cheng" <chengzhihao1@huawei.com>,
 "Zhongqiu Han" <zhongqiu.han@oss.qualcomm.com>, "Sumanth Korikkar"
 <sumanthk@linux.ibm.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, <driver-core@lists.linux.dev>,
 <llvm@lists.linux.dev>, <linux-hardening@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-sh@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <gfs2@lists.linux.dev>,
 <xen-devel@lists.xenproject.org>, <linux-mtd@lists.infradead.org>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Ian Rogers" <irogers@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261027223847.652884-1-irogers@google.com>
In-Reply-To: <20261027223847.652884-1-irogers@google.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 27, 2026 at 11:38 PM CET, Ian Rogers wrote:
> Clang supports the 'require_explicit_initialization' attribute on struct
> fields to enforce that the field is explicitly initialized when an
> aggregate object is constructed, emitting -Wuninitialized-explicit-init
> (enabled by default) if the field is omitted.
>
> Following discussion at the Linux Plumbers Conference [1], patch 1 adds
> the attribute to include/linux/compiler_attributes.h as __must_init. In
> v1 it was called __require_explicit_initialization. Kees picked up that
> patch with a first seq_file user [2], and in that thread Greg suggested
> the shorter __must_init spelling, which Kees and Miguel agreed to. As
> the attribute did not land in the v7.4 merge window, Kees asked that
> this series carry the renamed attribute. The Acked-by/Reviewed-by tags
> on patch 1 were given for the original spelling; the rename is
> mechanical.

This looks ready, and I plan to pick it up through the driver-core tree wit=
h the
minor commit message correction.

>   powerpc/secvar: Add missing kobject release callback to secvar_ktype
>   sh: sq: Add missing kobject release callback to ktype_percpu_entry
>   xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type

Some ACKs would be appreciated. :)

Thanks,
Danilo
