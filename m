Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEC5C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B132610F653;
	Fri, 11 Sep 2026 14:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ThdpLp6Y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 513ED10E2C3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 14:52:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED1DF44815;
 Fri, 11 Sep 2026 14:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6C61F000FF;
 Fri, 11 Sep 2026 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789138352;
 bh=d1e660q0bqMHeE8ElCfB3GFaNqo5AA3j2Q/7I7qwMQk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ThdpLp6Ymp5+O0IUZh/x1c1uKFk57bactIjasF2JEoRcD+0AKJpQv9Z8ZCKr1Oavr
 5SbW9nTADz2NMJRaxp4D1FnX6hxl07Qrp07Vju9Li/g9/xmO5gVX8MAd7aYlXKFNAK
 KkU4qnzN0azbJ8JXQP8IC3Mjj4rrJPQl1X6iRAeatsSlspWQXQK/XRja7995aTPRQf
 0ZUnLtX5ZvAQqOhPlqlt/mRmtSBs5wAuF/c1mw9X+XRG+KxwoknkFd1Yj2h3KMNUkO
 pzQeXzlshdCqAYci9Pfcjk2Yis7lmn3gVW3KSw6UdKuTk11E0VY2Ks90abvl0AUisU
 IuvVj0imyY+9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] umh, treewide: Explicitly include linux/umh.h
 where needed
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: "Mark Fasheh" <mark@fasheh.com>, "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Anna Schumaker" <anna@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 hannes@cmpxchg.org, linux-modules@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Chuck
 Lever" <cel@kernel.org>, mkoutny@suse.com, "Joel Becker" <jlbec@evilplan.org>,
 tj@kernel.org
In-Reply-To: <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
 <20260911-module-include-kmod-v3-1-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:52:31 +0000
Message-Id: <20260911145232.3A6C61F000FF@smtp.kernel.org>
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

> The usermode helper declarations were previously provided by linux/kmod.h
> but commit c1f3fa2a4fde ("kmod: split off umh headers into its own file")
> moved them to linux/umh.h in 2017.
>=20
> Add explicit includes of linux/umh.h to files that use usermode helpers a=
nd
> remove linux/kmod.h where it is no longer needed.
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-kmod-v3-0-6ebccc3e0731@suse.com?part=3D1

