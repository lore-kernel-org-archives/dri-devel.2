Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E902CD37B2
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 01:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7797010E1CC;
	Mon, 11 May 2026 01:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hI7DyGDF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619EF10E1CC
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 01:46:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CD3B43DDF;
 Mon, 11 May 2026 01:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B65C2BCB8;
 Mon, 11 May 2026 01:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778464013;
 bh=gHX8SpJXTygTiACEpPlwK4PNbVPnp6HjiQ6tG04hNT8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hI7DyGDFCiRZeHHgubmTnvnWfkz7cur69oVffvTxaLmyKWSePR+RaVmdkmK59Ia7t
 G2XZcBs2Xv3XUB8644XQK3934j9GV++cT4Ri14AksHp/XeuYKQsWwGUYTPVoDF1qch
 cfqecAUBjI0fOSUECPf+BW2g66e+ofLNirU3rJRfnt2JxTOgUvcFrMmd/TsN7b9rg/
 Gxizfc+7X+JSOe/uuDSCocOndIiXjX7SZObJAfMw+rJFOzvGcckwE17Txuc2VqJN1i
 B1ozvF7+h+P7L0Dx3We01Fs0OErTWHcyB54675qJWFSHcJ2FOMUwuFqVohtVagkeF6
 n2NMas2Pelbuw==
Date: Sun, 10 May 2026 15:46:52 -1000
Message-ID: <c6b89ff53b603350fe53b0d47f3399ed@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>, cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: return -ENOMEM on failed pool preallocation
In-Reply-To: <20260511013150.7235-1-zhangguopeng@kylinos.cn>
References: <20260511013150.7235-1-zhangguopeng@kylinos.cn>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hello,

Applied to cgroup/for-7.1-fixes with Cc: stable@vger.kernel.org # v6.14+
added, as the bug is in released kernels. Also capitalized the subject.

Thanks.

--
tejun
