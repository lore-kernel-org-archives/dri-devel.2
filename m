Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C85606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kuXqBQo9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62A110ECB0;
	Wed, 18 Nov 2026 21:11:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290A510ECA3;
 Wed, 18 Nov 2026 21:11:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2624E63DC5;
 Wed, 18 Nov 2026 21:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4625B1F000C4;
 Wed, 18 Nov 2026 21:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795036290;
 bh=fYW7C7ZSeq/hMphn21Jk8+ekBniTzrghgjy5BvzP2bc=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=kuXqBQo9E+h9GfS4TOHEmqgk/yUMmLyRthOV87kyoVvVOAzwMpnvqD7A1XkucwxwG
 +Vl7bpZlxX0JE1vzCQVuNBvbZMaKuIBAvlXTPAUK/GTa7v0LsXaOQ5W64VpbC1VuJl
 uqJ8OInlapAXmctcRxyW0008D6Xzwyp9lCFH5W/hdRpNqLETcSMRWepnBuLx7zwxxU
 Sylw1ch5ITJRoQmWb3zw4zYMMrzwKyJn/UZhs2/85dIxkfhwlxjTdBpT9dCJJryN21
 FmmGw4YgDxUh6xSvFjYiQgrHT7xeYbJw48awVnPj+qHidKGuRNABBugA/RDx9fw+YY
 xy76njp+TsmiA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 22:11:20 +0100
Message-Id: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Kees Cook"
 <kees@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>, "Nayna Jain"
 <nayna@linux.ibm.com>, "Srish Srinivasan" <ssrish@linux.ibm.com>, "Mimi
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
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Ian Rogers" <irogers@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of
 struct kobj_type::release
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-10-irogers@google.com>
In-Reply-To: <20261108223913.3624571-10-irogers@google.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
>  static const struct kobj_type cpuregs_kobj_type =3D {
> +	/*
> +	 * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> +	 * cpuid_cpu_offline() only calls kobject_del().
> +	 */

All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but t=
hat doesn=E2=80=99t
distinguish cases with broken lifetime management from those where the stor=
age
remains valid despite the API misuse.

For example:

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_xcp.c
> index ab14079d1c42..0847134a1391 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_ops =
=3D {
>  };
> =20
>  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> +	/*
> +	 * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> +	 * rather than freed individually by kobject_put().
> +	 */
> +	.release =3D NULL,

Being embedded in another structure doesn't explain what guarantees that th=
e
enclosing allocation outlives the kobject=E2=80=99s final cleanup.

Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make t=
hat distinction
explicit? For broken cases, describe the lifetime problem and mark it as ne=
eding
a follow-up fix. For cases where the lifetime is safe, explain what guarant=
ees
that safety, while acknowledging that omitting release() still violates the
documented API contract.

Also, do you plan to follow up on those cases?

Thanks,
Danilo
