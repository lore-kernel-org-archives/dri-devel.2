Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253FACA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AAE710E476;
	Wed,  7 Oct 2026 12:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.b="medp0nLK";
	dkim-atps=neutral
Received: from dormouse.ash.relay.mailchannels.net
 (dormouse.ash.relay.mailchannels.net [23.83.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564A610E476
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:23:47 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 44F7E62A40;
 Wed, 07 Oct 2026 12:07:52 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com
 (trex-green-8.trex.outbound.svc.cluster.local [100.96.22.25])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 0AA2C62A30;
 Wed, 07 Oct 2026 12:07:52 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Attack: 3f935f035fb35f93_1791374872123_1820721641
X-MC-Loop-Signature: 1791374872123:2778721703
X-MC-Ingress-Time: 1791374872123
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.96.22.25 (trex/8.0.2); Wed, 07 Oct 2026 12:07:52 +0000
Received: from offworld (90-182-211-1.rcp.o2.cz [90.182.211.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4j0Bhk1jC5z2Q; 
 Wed,  7 Oct 2026 05:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1791374871;
 bh=ZDxz2d9KR/r1DvvGUR/3d7d34BgV8xYPWHjrmAVWSBI=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=medp0nLKQ8GaAcrCj2DY6DQeIHb36/EGpbFWXtLdoLBJhDGeTjk/N6sUJnJ5RMml7
 X5cwzPgOPZXRAPGdlIAA8H3JtytaPDeRJA4HwDpEAPybRfvJ0xDdMdBt3RHsNwD+Kv
 2xrPS3fiAdDt+iBHKSN4prB5cGkd4YCrAS6Sub5Y8FKRev1FYzSNIOtAOy4Xh5ZtGw
 GIoREUbqjOigu40CYCSWAsGp+UZM44DWS2vj8NX84drolknccSVQ2aXk6Io/1QmYmM
 fI6zL7ApernjyAcIP5xy4+ukxGfPstbY4m297Mj3hovP/GCvuqESGMqcVcIoxTUBnJ
 pqVysgb3CYPCA==
Date: Wed, 7 Oct 2026 05:07:45 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org
Cc: benjamin.gaignard@collabora.com, jstultz@google.com,
 tjmercier@google.com, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/2] dma-buf: system_heap: 2MB chunks on x86
Message-ID: <20261007120745.bvhqqa6cowqnt3jc@offworld>
References: <20260928195850.1982569-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260928195850.1982569-1-dave@stgolabs.net>
User-Agent: NeoMutt/20220429
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

ping? if nothing else patch 1 should be picked up.

Thanks,
Davidlohr

On Mon, 28 Sep 2026, Davidlohr Bueso wrote:

>Hello,
>
>Changes from v1 (https://lore.kernel.org/all/20260914212258.2657788-1-dave@stgolabs.net/)
>
>- The bug fix is now patch 1, unchanged from v1, picked up tags.
>- Removed patch that adjusts per base page size (arm).
>- The 2MB order is x86 only, so Arm keeps what it has. Left other platforms
>  as is as well to reduce the change impact. (Christian)
>- The orders and the fragmentation trade-off are documented, both in the
>  code and in the userspace heap documentation. (Christian)
>
>Thanks!
>
>Davidlohr Bueso (2):
>  dma-buf: validate the attachment before asserting its reservation lock
>  dma-buf: system_heap: allocate 2MB chunks on x86
>
> Documentation/userspace-api/dma-buf-heaps.rst |  4 ++++
> drivers/dma-buf/dma-buf-mapping.c             |  4 ++--
> drivers/dma-buf/heaps/system_heap.c           | 24 ++++++++++++++-----
> 3 files changed, 24 insertions(+), 8 deletions(-)
>
>-- 
>2.39.5
>
