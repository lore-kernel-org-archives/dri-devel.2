Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCB0C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A671A10E2C3;
	Fri, 11 Sep 2026 14:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gYyTGXyi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8254510E2C3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 14:52:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 02E5D6025A;
 Fri, 11 Sep 2026 14:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1981F00898;
 Fri, 11 Sep 2026 14:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789138351;
 bh=ozHRLiliFMnW1SlnGtObXJsv2wh4qQXUNrJrJq2vbBY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gYyTGXyiongFnx2ZCzh5d07wpg7CShCsdCRZkalAoax++3dgFnh3zWhDdjULqb/EL
 YCGgAJG4TFH7mPOz1Jm9Lcm4LxJ+WxU8u/X68cq0SnxKi2kzYOYnmdbGukbv4MOXge
 znV40VohLRIwK7f6qcq9MpgLhGl9qidTJ1/A1hqePyKrtgb+4P/9L3br4xSgHRZzdU
 GwdUFGU3R442JNmDxHhN0usRzgKMYxKA3McRrBNqkUe2dUY5pbgUJBlyLkkioQFsWj
 okjaDXeHx2/uSACNEF8vyi+B5IZOD39cSRXlJI0NwVBlCOVx0O0J+qOaI6ZnzPSEro
 cCt20HtI1DDTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] module: Bring includes in linux/kmod.h up to date
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org,
 "Mark Fasheh" <mark@fasheh.com>, "Joel
 Becker" <jlbec@evilplan.org>, "Anna Schumaker" <anna@kernel.org>, "Chuck
 Lever" <cel@kernel.org>, hannes@cmpxchg.org, mkoutny@suse.com,
 "Joseph Qi" <joseph.qi@linux.alibaba.com>, "Jeff
 Layton" <jlayton@kernel.org>, linux-modules@vger.kernel.org
In-Reply-To: <20260911-module-include-kmod-v3-3-6ebccc3e0731@suse.com>
References: <20260911-module-include-kmod-v3-0-6ebccc3e0731@suse.com>
 <20260911-module-include-kmod-v3-3-6ebccc3e0731@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:52:30 +0000
Message-Id: <20260911145231.1D1981F00898@smtp.kernel.org>
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

> Including linux/kmod.h alone results in 1.5 MB of preprocessed output, ev=
en
> though it provides only a few functions and macros.
>=20
> The header currently depends on:
>=20
> * __printf() -> linux/compiler_attributes.h,
> * ENOSYS -> linux/errno.h,
> * bool -> linux/types.h.
>=20
> Include only these files, reducing the preprocessed output to 10 kB.
>=20
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-module-inc=
lude-kmod-v3-0-6ebccc3e0731@suse.com?part=3D3

