Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40F8C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D226A10E80D;
	Mon, 29 Jun 2026 10:43:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZePC5gdl";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F67D10E80D
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:43:38 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gpjYg3zfmz9v78;
 Mon, 29 Jun 2026 12:43:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1782729815; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKXo9kS8UPvQyEKtU98KqOyTUanqfXLW03eEjmWvD6I=;
 b=ZePC5gdle9c/KcEU/FYbGda+2I6PpG34VSg5jS1oI8JgrZ4DYtByZwiZmyIRlYjqHM90L6
 88cfHBWbJXwtxgJxRAWLba+JOsqISencpdXFGXBDXV8RG48OUMnFM6ipDZDObdTMG4BZBU
 Kz9OMQ9mlXDPUHOBoTHXvChLOSM5Uqz28Me4XbK//lcfDdtNjhiknw7n2mup1zNgkZ8TUI
 wb/+P7Ovd6uuF9E8c1Ptlueqkbtl/CfUnu4Cz3F0F0KgadF2WXB0atXvhPyjUBqpOVPqvk
 ve4bd45yRdq/NwFwF5Z2nhGGhcBnoTEjXEE79+wfjEj49O+nB8+q9+YmRP1Ouw==
Message-ID: <2f4ee171084d82235e23017886662b2d5b3506c0.camel@mailbox.org>
Subject: Re: [PATCH v2] dma-buf: dma-fence: Fix potential NULL pointer
 dereference
From: Philipp Stanner <phasta@mailbox.org>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Boris
 Brezillon	 <boris.brezillon@collabora.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>,  =?ISO-8859-1?Q?Andr=E9?= Draszik	
 <andre.draszik@linaro.org>, Danilo Krummrich <dakr@kernel.org>, Gary Guo	
 <gary@garyguo.net>, "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng	
 <boqun@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Mon, 29 Jun 2026 12:43:29 +0200
In-Reply-To: <688077c3-903d-4cf5-837f-40621175cb30@amd.com>
References: <20260629075636.2513214-2-phasta@kernel.org>
 <688077c3-903d-4cf5-837f-40621175cb30@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: fyurinxj6p8ugeguzshhwdjorkkaou3a
X-MBO-RS-ID: f215f38f57b359d7c56
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, 2026-06-29 at 10:49 +0200, Christian K=C3=B6nig wrote:
> On 6/29/26 09:56, Philipp Stanner wrote:
> > Cc: stable@vger.kernel.org
> > Fixes: f4cc3ab824d6 ("dma-buf: protected fence ops by RCU v8")
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

As the maintainer you push that one, don't you Christian?

Regards
P.
