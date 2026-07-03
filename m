Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C242C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3C310F6CC;
	Fri,  3 Jul 2026 07:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BEYRKLYc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF4F10F6BF
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 07:52:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3193060103;
 Fri,  3 Jul 2026 07:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84601F000E9;
 Fri,  3 Jul 2026 07:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783065121;
 bh=74bvzfUp7EME08ZTAhmXme2kCENou4dKxY3jwP7p3EQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BEYRKLYc8bV2pzu1oaPiM5VivJW5kYa037AmXQhrjwQ0T/jWGDT8du7N/JeYjWfCH
 GXb4Q5efW3qHzpikjuV2n+cJKCm6kXfzPyk8sSUEWVwgNW1QqCDr/CczTiny//iLDS
 BU9GMm8ITpGuWk711fBSYpgmdFZlD7d16wicQVApM9RjwzzoiSwxQvhutb9nwCgTit
 cUivMEgV2DQN8FoPREJ5tkxsJLBUFG0oDBBJWpn/0W75e14GPRWrpVfpKktheNMaMO
 y5EtxjeYNQNGh+gxDQEoQrU29yTtSzp2oTfqM3ZKNtfaOP9yNXYXOPEIiz2BzZHsj9
 1szhejTL+gh4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 2/3] selftests/net: ncdevmem: add -b option
 to set rx-buf-size on bind
To: "Bobby Eshleman" <bobbyeshleman@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-tcpdm-large-niovs-v4-2-ca4654f37570@meta.com>
References: <20260701-tcpdm-large-niovs-v4-0-ca4654f37570@meta.com>
 <20260701-tcpdm-large-niovs-v4-2-ca4654f37570@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 07:52:01 +0000
Message-Id: <20260703075201.B84601F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message claims to add 'CONFIG_HUGETLBFS=3Dy' to 'driv=
ers/net/hw/config', but this file modification is missing from the patch.
--

commit c7b1ce8ddda374f6cdcda3fac83aafea966343ab
Author: Bobby Eshleman <bobbyeshleman@meta.com>

selftests/net: ncdevmem: add -b option to set rx-buf-size on bind

This commit adds a -b <bytes> option to request a non-default niov size via
NETDEV_A_DMABUF_RX_BUF_SIZE. When the value exceeds PAGE_SIZE, it switches=
=20
to a hugetlb-backed memfd to produce naturally-aligned sg entries.

> Add CONFIG_HUGETLBFS=3Dy to drivers/net/hw/config so the new path is
> reachable in the CI kernels built for these tests.

[Severity: Medium]
Is the commit message out of sync with the actual patch?=20

The message explicitly states that CONFIG_HUGETLBFS=3Dy is being added to=20
tools/testing/selftests/drivers/net/hw/config, but this file modification is
completely missing from the patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tcpdm-larg=
e-niovs-v4-0-ca4654f37570@meta.com?part=3D2
