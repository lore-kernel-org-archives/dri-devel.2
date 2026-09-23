Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFE5C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:22:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF3610E2A8;
	Wed, 23 Sep 2026 16:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T2cm1NPn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8861510E2A8
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:22:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 27EE242202;
 Wed, 23 Sep 2026 16:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC951F000FF;
 Wed, 23 Sep 2026 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790180521;
 bh=+Vscb6nc1+PsJsBSmh8R6hPQfd7DCJSJT003TJOw19Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T2cm1NPnlKDhE9+IoeJ84Aoy41jAn2wI8TrRMiJG9fFUuFLeeyT2XfkDJ4TRTfQXD
 Xr+08drzdCz9vrdyYwcRRTGzYe04Trhixxpgi3g9hER7urSl5XAP+guGcZ+P9+HDNi
 SF4lkEAQx/nIhyU6O6DB+g7kKhgKdsw9/WKIjFUufoW5AJUPTyjNa1vezpL+oeBFXh
 xmmqloaCvAfCggQzCOHrUMGMRcj57iM+o3psASiQtYplewg3wbMq2poXPkXiQPX3pW
 PWT/qcDx7bPCd+A89Khire2hBSpdL4ls11VoiTVrEBiKscRC5ceS/pkA7b+k2XRjob
 OHLpQfabOdMaQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v5 1/3] workqueue: Simplify unbound sysfs attribute
 registration
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260923161251.45428-2-tvrtko.ursulin@igalia.com>
References: <20260923161251.45428-1-tvrtko.ursulin@igalia.com>
 <20260923161251.45428-2-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:22:00 +0000
Message-Id: <20260923162200.DFC951F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] workqueue: ABI breakage by renaming sysfs attr affinity_scope to a=
ffn_scope
--

commit 2efe6031e6371199ddd3b670919f910c5c5f043a
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

workqueue: Simplify unbound sysfs attribute registration

This commit simplifies the registration of unbound workqueue sysfs attribut=
es.
It replaces manual attribute registration loops with an attribute group
visibility check handled by the device core. This streamlines both registra=
tion
and error unwinding.

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 8fb31947c4c7a..a9e96329547c9 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c

[ ... ]

> -static struct device_attribute wq_sysfs_unbound_attrs[] =3D {
> -	__ATTR(nice, 0644, wq_nice_show, wq_nice_store),
> -	__ATTR(cpumask, 0644, wq_cpumask_show, wq_cpumask_store),
> -	__ATTR(affinity_scope, 0644, wq_affn_scope_show, wq_affn_scope_store),
> -	__ATTR(affinity_strict, 0644, wq_affinity_strict_show, wq_affinity_stri=
ct_store),
> -	__ATTR_NULL,
> +static DEVICE_ATTR_RW(nice);
> +static DEVICE_ATTR_RW(affn_scope);

[Severity: High]
Does this change the userspace ABI by renaming the sysfs file?

The previous code exposed this attribute to userspace as affinity_scope.
Using DEVICE_ATTR_RW(affn_scope) implicitly sets the sysfs file name to
affn_scope instead of the original affinity_scope.

Will this cause userspace tools or scripts expecting to find the
/sys/bus/workqueue/devices/*/affinity_scope file to fail?

> +static DEVICE_ATTR_RW(affinity_strict);
> +/* Avoid naming clash with the other cpumask */
> +static struct device_attribute dev_attr_unbound_cpumask =3D
> +	__ATTR(cpumask, 0644, unbound_cpumask_show, unbound_cpumask_store);
> +
> +static struct attribute *wq_sysfs_unbound_attrs[] =3D {
> +	&dev_attr_nice.attr,
> +	&dev_attr_unbound_cpumask.attr,
> +	&dev_attr_affn_scope.attr,
> +	&dev_attr_affinity_strict.attr,
> +	NULL,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923161251.4542=
8-1-tvrtko.ursulin@igalia.com?part=3D1
