Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ED4C624DD
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8061910F504;
	Thu,  3 Sep 2026 10:46:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R8HsYZ4W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B5510F504;
 Thu,  3 Sep 2026 10:45:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9DEB43E22;
 Thu,  3 Sep 2026 10:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBE51F000E9;
 Thu,  3 Sep 2026 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788432358;
 bh=C0oL3UqeyZdGOSjmzc4EZnL/cchO/VVWF0NIt1FY0P0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R8HsYZ4W8Z1zqOJBRdk6tPXXobFFOVhpamfriWZn7izV417VMmiZ4zpB4ugB8H4NK
 Pm+4KLtdGoRwCNN3oVzK6gKH35pgwdJo9yXIG2j9qJUJ61xrsPn2WVyz3Yjsxct+Kg
 Zkvc+s/9XWDxLl5ciRcEr5YOilmyAlntXUCsYdTXT/ycMR+OfY8/vZL4r9hECSGCaK
 N9BytSGfHr8wKhYt6KI25aMiJI3w7qovCflpIV87X157CHhb7EbMzXmSAMok+D0O76
 6GKCDIM9MRwDYvlQFwzer/DXQeJ2BxEvEgUvh3TyRn/l1lr+WHxcAJBBHUGL1UpQsN
 N11g44KXO2wPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] mm: convert PTE table entries in ptep_get()
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org,
 damon@lists.linux.dev, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260903103002.1091859-5-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-5-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:45:57 +0000
Message-Id: <20260903104558.6CBE51F000E9@smtp.kernel.org>
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

> ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
> return a software PTE value. Add __pte_from_hw for both generic hw_pte_t
> definitions. Read the hw_pte_t table element atomically before converting
> it to pte_t.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D4

