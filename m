Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E396C44501
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D2F10EBA0;
	Tue,  7 Jul 2026 07:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QSfw3KvU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4431C10EB87
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:33:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD8EC618BA;
 Tue,  7 Jul 2026 07:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4E11F00A3F;
 Tue,  7 Jul 2026 07:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783409613;
 bh=v1oOPeTvAISVGM6dIZHjUhBxaruZEjK+yszFzabP8u4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QSfw3KvUGNZyD7K+Ri51UddKzPhCdjdOv03qy7E+nKKgDOsoW3/CQ8Mf81PzRpIia
 EbmDLmX9p9ll7l5XkJfT8XUfBYnpRdDLRHwZL36we+Oh3zPNUeLaFCTuqQnmNWLhLs
 aWzAG8Jqhd7kyNJsjzUTg1/xyI/m3a8TDszXv52OcmXtPkFGNHwf/EFFr7N05IHSiD
 FrmSQS2vop7nP0YO+eG+IlYnaB6jf8vNsKbuC7XKjVDMjqyx47Fp36h/bb4fEOXTwa
 bC6S0keNYhDt20jg/Vg0x1n9HJ2pZPpcc8/xyqBOMXnuicNXJc9TiTu201NVxmO3Mf
 oCefMA6azR8tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 06/40] dept: distinguish each kernel context from
 another
To: "Byungchul Park" <byungchul@sk.com>
Cc: cassel@kernel.org, dri-devel@lists.freedesktop.org,
 "Anna Schumaker" <anna@kernel.org>, ojeda@kernel.org, tytso@mit.edu,
 linux-modules@vger.kernel.org, "Jeff
 Layton" <jlayton@kernel.org>, "Chuck Lever" <cel@kernel.org>,
 dlemoal@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
In-Reply-To: <20260706061928.66713-7-byungchul@sk.com>
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-7-byungchul@sk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 07:33:32 +0000
Message-Id: <20260707073332.DB4E11F00A3F@smtp.kernel.org>
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

Pre-existing issues:
- [High] cur_cxt() incorrectly identifies a hardirq interrupting a softirq =
as a softirq context, mixing dependencies between unrelated execution conte=
xts.
--

commit 504ac1eb7d0a4081c645648037ec455b5ec741d7
Author: Byungchul Park <byungchul@sk.com>

dept: distinguish each kernel context from another

Each unique kernel context, in dept's point of view, should be
identified on every entrance to kernel mode e.g. system call or user
oriented fault.  Otherwise, dept may track meaningless dependencies
across different kernel context.

> diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
> index fd091ae28ae27..1c4de1b55730a 100644
> --- a/kernel/dependency/dept.c
> +++ b/kernel/dependency/dept.c
[ ... ]
> -static int cur_irq(void)
> +static int cur_cxt(void)
>  {
>  	if (lockdep_softirq_context(current))
> -		return DEPT_SIRQ;
> +		return DEPT_CXT_SIRQ;
>  	if (lockdep_hardirq_context())
> -		return DEPT_HIRQ;
> -	return DEPT_IRQS_NR;
> +		return DEPT_CXT_HIRQ;
> +	return DEPT_CXT_PROCESS;
>  }

[Severity: High]
This is a pre-existing issue, but does cur_cxt() incorrectly prioritize sof=
tirq
over hardirq context here?

If a softirq is executing and is interrupted by a hardirq, both
lockdep_softirq_context(current) and lockdep_hardirq_context() evaluate to
true. Because the softirq check comes first, cur_cxt() will return
DEPT_CXT_SIRQ instead of DEPT_CXT_HIRQ.

Could this cause the waits and events triggered inside the interrupting har=
dirq
to be erroneously attributed to the interrupted softirq's context, potentia=
lly
mixing unrelated dependencies and leading to false positive circular depend=
ency
reports?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706061928.6671=
3-1-byungchul@sk.com?part=3D6
