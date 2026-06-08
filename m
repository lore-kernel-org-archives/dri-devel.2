Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE48CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA6D10F71C;
	Mon,  8 Jun 2026 16:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I6niaMOg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C00C10F71E
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:37:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7462460098;
 Mon,  8 Jun 2026 16:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D561F00893;
 Mon,  8 Jun 2026 16:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780936663;
 bh=92FbV1Okgp8r+Sh0xvK1D17MGvbjqqbutVZw89jzoNg=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=I6niaMOgfMIa88cpbcCXUX3j+YvXFwsh9XGbccX6l0LeHNv/xkywkv/qht1Q9fhFw
 ekHpDl5UVYTdQoTTaEDaZ1FoTtqFNx37Gc0pn2U9bLj3f6wHLem7LML+vUn/g/bj9W
 2h3wcp1xFYtaqP6Rx9JuaC64BZ349WKcIuuPNYHHjQnBQEfzoqoNCrd/cjg+u3CaHb
 a+ceDefpIbZ8xhGztkedW31HSolGi/eLoc5QkePpzFXp36SOxkUly8uSU64qxwR/n2
 qtXlECxZ/8ZmR7dhVciV5joBE5Rmw7idY9fX279f3wModnbhlmaaxFRehqAF+77wna
 qXbKU2bwn13bg==
Message-ID: <17557800bc330c00d686411486959af4@kernel.org>
Date: Mon, 08 Jun 2026 16:37:40 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Eric Chanudet" <echanude@redhat.com>
Subject: Re: [PATCH v2] cgroup/dmem: accept only one region per limit write
In-Reply-To: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
References: <20260608-cgroup-dmem-write-single-region-v2-1-b0cd6c4ccf1b@redhat.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Albert
 Esteve" <aesteve@redhat.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Maarten
 Lankhorst" <dev@lankhorst.se>, "Maxime Ripard" <mripard@kernel.org>,
 =?utf-8?b?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>,
 "Natalie Vock" <natalie.vock@gmx.de>, "Tejun Heo" <tj@kernel.org>
Content-Transfer-Encoding: 7bit
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

On Mon, 8 Jun 2026 11:53:51 -0400, Eric Chanudet wrote:
> Accept only one "region value" pair entry for the dmem.max, dmem.min,
> dmem.low files.
> 
> This changes the UAPI that otherwise accepted multiple lines for setting
> multiple entries in one write. No existing user is known to rely on
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
