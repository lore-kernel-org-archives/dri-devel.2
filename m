Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F114C624DA
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 965F410F502;
	Thu,  3 Sep 2026 10:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G38Jo/We";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B66710F501;
 Thu,  3 Sep 2026 10:43:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F4F4600D4;
 Thu,  3 Sep 2026 10:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E491F000E9;
 Thu,  3 Sep 2026 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788432206;
 bh=3WtGjmXyy8ESK1v2+AY/2+j4fymQ2vsKqVMdj3paIxY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G38Jo/WeqNRMGlJxWDbAvytbz+2WJcpgaoyVuLqBTgaNUITK2lHWQktYarOL7V6bl
 qHQ6ado5focIEF3Qku6VTXmva8KH7y4Bi1pM5aaBLf7v72T959o7nbbqRGcNhfHiD+
 ySRIxAB6+Xg/aztbPkiVQ6i6tIt4TA2QOFWpjnvlpf4h/Js5z3ZXpdPF3NnsLYNXOC
 nl0/jXd8kv+dZ8AmnMwd3x6mkNHPQgy6ZNgJ/pHPZECgnCFHvndQHx7OTZuhKgxJi9
 eWd6BkffYWPsMgNxjxf0wcw62S5GMUL7O8RAzUJ/rMEhyLn2wvbgIH/0YGQY6Zv5kJ
 9uI/WU4dpqfBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] xen: use hw_pte_t for PTE range callbacks
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: damon@lists.linux.dev, intel-gfx@lists.freedesktop.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260903103002.1091859-9-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-9-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:43:26 +0000
Message-Id: <20260903104326.77E491F000E9@smtp.kernel.org>
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

> Generic PTE range and remapping helpers now pass pointers to PTE table
> storage as hw_pte_t *. Update the Xen callbacks to match those interfaces.
>=20
> Keep software PTE values as pte_t and continue to access them through the
> existing PTE helpers. This is required when Xen is built for an
> architecture that selects the distinct hw_pte_t wrapper.
>=20
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D8

