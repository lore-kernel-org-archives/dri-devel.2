Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE59C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23DE110E1D0;
	Sat,  5 Sep 2026 18:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZpZiwIHP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E21DF10E1D0
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 18:31:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B539601FB;
 Sat,  5 Sep 2026 18:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFC81F00A3A;
 Sat,  5 Sep 2026 18:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788633081;
 bh=Is1ERzeA0TVbo6445ZfCRd9CWvVeUJ9Wl0WbMpFatq4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZpZiwIHPzH7hMwiNS+Jwym6ruPlxYVreUdt/DUWCv6Ie58C9dd8Q34SDrYXk+xoi8
 updFZpFoU7rxxLsBcPpTsxalNHTNc96ViHf1gzD/JLDaSQ38bsiK9uqzI2RviNSPAJ
 MpNL/2ekImbbmEP2Zft15ihqTOXWttAtpub/xaZ9pHerf16scr5fXL9n7Iu3Ljw+cM
 cAMHq7k8A0dxttUXjZZFglApMWt9UkKjT740zo03f8YpW+NoHjiFURNirft/zZSOz7
 OiGCsLNL2/uXuYnuPmAjqJmxAZp8rrgrnRUFknxJ9hksr70kxaA7JruS94O2iKI2pE
 GF1UqacwY+aHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 31/43] dyndbg-test: add do_bulk testpoint, rename
 do_prints to do_classes
To: "Jim Cromie" <jim.cromie@gmail.com>
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-31-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
 <20260905-dd-cmap-part2-clean-v8-31-a4cc0674f6fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:31:21 +0000
Message-Id: <20260905183121.9CFC81F00A3A@smtp.kernel.org>
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
- [High] Infinite loop in do_bulk() due to signed/unsigned comparison and m=
issing CPU yields in test module loops.
--

commit a7ab45223d01dd1193ddd552d158d079f7cd23de
Author: Jim Cromie <jim.cromie@gmail.com>

dyndbg-test: add do_bulk testpoint, rename do_prints to do_classes

This commit enhances the test_dynamic_debug module by renaming the do_prints
sysnode to do_classes and adding a new do_bulk parameter. Both parameters
now accept a work-count to generate significant workloads with a single
write.

> diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> index 01ce07001d4c7..39499e52d7c04 100644
> --- a/lib/test_dynamic_debug.c
> +++ b/lib/test_dynamic_debug.c
[ ... ]
> @@ -213,17 +236,40 @@ static void do_levels(void)
>  #endif
>  }
> =20
> -static void do_prints(void)
> +static void do_classes(unsigned int ct)
>  {
> -	pr_debug("do_prints:\n");
> -	do_cats();
> -	do_levels();
> +	/* maybe clamp this */
> +	pr_debug("do_classes %d times:\n", ct);
> +	for (; ct; ct--) {
> +		do_cats();
> +		do_levels();
> +	}

[Severity: High]
Since this loop can run for a very long time if a large value is written to
the sysfs node, could it cause CPU or RCU stalls? Would it be safer to add a
cond_resched() inside the loop to prevent lockups?

> +}
> +
> +static void do_bulk(unsigned int ct)
> +{
> +	int i;
> +
> +	pr_debug("do_bulk %d times:\n", ct);
> +	for (i =3D 1; i <=3D ct; i++) {

[Severity: High]
Does this loop condition introduce a potential infinite loop?

The loop counter 'i' is declared as a signed int, while 'ct' is an
unsigned int. If a user writes UINT_MAX (4294967295) to the do_bulk sysfs
parameter, 'i' will be promoted to unsigned int for the comparison. Since an
unsigned int can never exceed UINT_MAX, the condition 'i <=3D ct' will alwa=
ys
be true.

Could this lead to a hard kernel lockup if an extremely large integer is
provided? Should 'i' be declared as an unsigned int, and the loop bounded
or clamped to avoid wrapping?

> +		pr_debug("bulk msg %d.0\n", i);
> +		pr_debug("bulk msg %d.1\n", i);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-dd-cmap-pa=
rt2-clean-v8-0-a4cc0674f6fd@gmail.com?part=3D31
