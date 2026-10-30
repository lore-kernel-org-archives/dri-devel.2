Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBEF606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=winSr+tx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B81B11272F;
	Fri, 30 Oct 2026 10:38:01 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4C411272E;
 Fri, 30 Oct 2026 10:37:54 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jGHcH3GwzzMlbY;
 Fri, 30 Oct 2026 11:37:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1793356671; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SfbowGU8+zvwq17FTuEev/To1GaQJjEXXQFNhkfWinU=;
 b=winSr+txBnuADjaMUZ9hdqYj2HQVp68/Jn+KEM0UHCmy6m9viBAAOPL7u7wrMk3tZ8KVS3
 iT+OMRD03n8OyQdVQyxDsD1zT/+zJfwPQB1GVv5gDoFWMWXo5kinu3b6rv8TdSgMpjU3UE
 bZrHhFgUOYgqMu3AtO5cuH3KR9FzrvN3ILHETazkOPQJeC81MwMmmcT0ecks2GAg4E46YT
 3nQFVvnCMOQ1p/6DXQTOf8OH7wJkwr+ewDWsfKnCz45QqcZ/yr9/VegB/YaGEBysstIjq3
 nNdLX1mw6UoWhl2QJ5KLjP0iEbtP35ncGCOWQPWfnoNm+V++nTUWvCAswuINYQ==
Message-ID: <ec1799db63823edadc573cd162e721d60fc87bb6.camel@mailbox.org>
Subject: Re: [PATCH 1/2] drm/etnaviv: etnaviv_fence: Put base class first
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Lucas Stach
 <l.stach@pengutronix.de>,  Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie	
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sumit Semwal	
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date: Fri, 30 Oct 2026 11:37:48 +0100
In-Reply-To: <20261028103129.1036380-2-phasta@kernel.org>
References: <20261028103129.1036380-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: uxy477boyjn9j791yzpg1pq6p5zrhigm
X-MBO-RS-ID: 7c4ecb2865ed2b71141
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-28 at 11:31 +0100, Philipp Stanner wrote:
> struct etnaviv_fence contains a struct dma_fence, which is its base
> class. The base class should always be the first member of a class.
>=20
> This allows for removing a deprecated callback in a subsequent patch.
>=20
> Make struct dma_fence base the first member of struct etnaviv_fence.

Applied this and the following one to drm-misc-next

Thx guys
