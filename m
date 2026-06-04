Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8D4CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1025113B34;
	Thu,  4 Jun 2026 15:26:09 +0000 (UTC)
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net
 [83.223.95.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F929113B34
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 15:26:09 +0000 (UTC)
Received: from h08.hostsharing.net (h08.hostsharing.net
 [IPv6:2a01:37:1000::53df:5f1c:0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
 client-signature ECDSA (secp384r1) client-digest SHA384)
 (Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
 by mailout1.hostsharing.net (Postfix) with ESMTPS id 6D3EF38B;
 Thu, 04 Jun 2026 17:26:07 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
 id 519AE600C2BD; Thu,  4 Jun 2026 17:26:07 +0200 (CEST)
Date: Thu, 4 Jun 2026 17:26:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: w15303746062@163.com
Cc: airlied@redhat.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH v2] char: agp: amd64 - fix broken error propagation in
 agp_amd64_probe()
Message-ID: <aiGZD7c3bYb47viQ@wunner.de>
References: <20260504074823.99377-1-w15303746062@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504074823.99377-1-w15303746062@163.com>
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

On Mon, May 04, 2026 at 03:48:23PM +0800, w15303746062@163.com wrote:
> A NULL pointer dereference was observed in the AMD64 AGP driver when
> running in a virtualized environment (e.g., QEMU/KVM) without a physical
> AMD Northbridge. The crash occurs in amd64_fetch_size() when attempting
> to dereference the pointer returned by node_to_amd_nb(0).
> 
> The root cause of this crash is broken error propagation in
> agp_amd64_probe(). When no AMD Northbridges are found, cache_nbs()
> correctly returns -ENODEV. However, the probe function erroneously
> checked the return value against exactly -1, rather than < 0.
> 
> As a result, the hardware absence error was masked, allowing the driver
> to improperly proceed with initialization. It eventually called
> agp_add_bridge(), which invokes amd64_fetch_size(). Since the hardware
> does not exist, node_to_amd_nb(0) returns NULL, leading to a General
> Protection Fault (GPF) when accessing its ->misc member.
> 
> Fix the issue by correcting the error check in agp_amd64_probe() to
> abort properly when cache_nbs() returns any negative error code. This
> prevents the driver from erroneously proceeding without hardware, thereby
> resolving the subsequent NULL pointer dereference at its source.
> 
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Fixes: a32073bffc65 ("[PATCH] x86_64: Clean and enhance up K8 northbridge access code")
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v2.6.18+
