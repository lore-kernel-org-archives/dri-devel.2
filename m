Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE3BC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F90210E1C0;
	Fri,  4 Sep 2026 11:21:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FMBp0wjt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D072A10E1C0
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 11:21:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9373C415C8;
 Fri,  4 Sep 2026 11:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBFB1F00A3D;
 Fri,  4 Sep 2026 11:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788520911;
 bh=/KF3xIMezszoztZEf/AbVIn9xAa0yrrHaiMLrWyR4VM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FMBp0wjtBsDxxH7kMkMJhyGyNRoWWvc3eBHpHZcVhuM+mliKNO5VAlUPiLxQSxnwm
 YIJEUjPlSNVKIKvvTwbFUZTDdajSlDfp1bQ8ULRwG/GGUguJ4nDwX7ppr14R9z8KNp
 M6k7sVO4VKYjhjQf+30n1/LMqFX9cDQe6Cp5Xvf38fc+X01w7mJMJPH5CkOnqB/tnO
 2ZTXNrZa/38ZeNZVhcfZu95/Nsf82Lewi3RnP+0M65ftEAiYPqGD+V8Mz+axs3ZveX
 quxLslG1pCFWra3rrVdFyMglvQH5FDwaESD0L/TMgtSxjqI7u2ARvDQH0YzLKVwdFz
 KXtz0lLQFaRXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/12] of: Export of_node_to_nid()
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, media-ci@linuxtv.org,
 dri-devel@lists.freedesktop.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, robh@kernel.org, conor+dt@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904-tegra-vpr-v6-6-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-6-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:21:50 +0000
Message-Id: <20260904112150.9CBFB1F00A3D@smtp.kernel.org>
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
- [Low] Missing #include <linux/export.h> for EXPORT_SYMBOL macro.
--

commit 44baf41b1565a3ea5c2669a320dc9b29217d32c3
Author: Thierry Reding <treding@nvidia.com>

of: Export of_node_to_nid()

This commit exports of_node_to_nid() so that drivers buildable as modules=20
can use it.

> diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
> index 230d5f628c1b4..da2e9bd1717c2 100644
> --- a/drivers/of/of_numa.c
> +++ b/drivers/of/of_numa.c
> @@ -171,6 +171,7 @@ int of_node_to_nid(struct device_node *device)
> =20
>  	return NUMA_NO_NODE;
>  }
> +EXPORT_SYMBOL(of_node_to_nid);

[Severity: Low]
Should this file explicitly include <linux/export.h> or <linux/module.h>?

Using EXPORT_SYMBOL without explicitly including its defining header relies
on transitive includes. This could potentially cause build failures=20
if those implicit includes change in the future on certain configurations
or architectures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D6
