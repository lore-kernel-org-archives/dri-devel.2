Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DDDC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B87810ED5C;
	Tue,  7 Jul 2026 14:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=mark.filion@collabora.com header.b="EBnO+0ul";
	dkim-atps=neutral
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com
 [136.143.188.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7538D10ED5C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783433323; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ktgr9v1uqP0SAOm6jgPGVmnQX9oWtLuYuEepuh2ote6SGFjYWWhnQdDOmIahKxqXsX9cfIcg3xxfHBA5cv7Hu/LDXlFRk3X9Ea+tmJb5zLEdfuh8DNTKjfV5Fv89f2MliwgRK+VZtv6BYoIbbkROvwM0CTQ5kokp8OpUdW61YL0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783433323;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=OuwODL/Y0Ylpe2Edfe8HjsUVpS8t3ywZf1afa7GP1VQ=; 
 b=GxW1lGI2SfX9+O8p+LDQ+MMNydjic6V32P+E1u4CmFNrr6PWfYFyo+2wXkpJV+NKL34wPUuFgF4x6QQxwGgdb82Y2XMfx4fHea47hALNM8y1DYm/lwlc2uGvIu/zckP3p2kAsXTvNWTnrA6rLlUO8VbZJvKvnEcaCV7Vs95H88A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=mark.filion@collabora.com;
 dmarc=pass header.from=<mark.filion@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783433323; 
 s=zohomail; d=collabora.com; i=mark.filion@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=OuwODL/Y0Ylpe2Edfe8HjsUVpS8t3ywZf1afa7GP1VQ=;
 b=EBnO+0ulrU5syddu2NTeFI4Fu4GMj3Xkhu1IR80sjdiv54xU3s2BjOMAYiV515Qd
 +ANnK/jkQtJ4AE8YKczV9W8eH8QSR9+PwxlW0gmpp5/zQ+8MBkkIBWYQ7ttxsPXuJ2U
 BO+rKvZrdtwbwVLJLdtzIW1mM9Dv2mBVj3iuufOE=
Received: by mx.zohomail.com with SMTPS id 1783433322584458.16417302144635;
 Tue, 7 Jul 2026 07:08:42 -0700 (PDT)
Message-ID: <4a7449ee9e9e570f142e81bb42c4a4a0af0cb0e0.camel@collabora.com>
Subject: XDC 2026: CfP deadline extended to July 15. Submit your talk,
 workshop or demo!
From: Mark Filion <mark.filion@collabora.com>
To: dri-devel@lists.freedesktop.org
Date: Tue, 07 Jul 2026 10:08:41 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44app2) 
MIME-Version: 1.0
X-ZohoMailClient: External
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

Hello!

The CfP deadline for talks, workshops and demos at XDC 2026 has been
extended to next Wednesday, 15 July 2026. You have one more week to
submit, don't wait!

https://indico.freedesktop.org/event/12/abstracts/

We're especially interested in talks across all layers of the graphics
stack, from the kernel to desktop environments and graphical
applications, and about how to make things better for the developers
who build them.=20

Worked on a cool project? Don't let the bar seem too high, you don't
need a polished, groundbreaking result to have something worth sharing.
If you're excited about it, chances are others will be too, so don't be
shy: submit your talk! Head to the CfP page to learn more.

As usual, the conference is free of charge and open to the general
public. If you plan on attending, please make sure to register as early
as possible!

And don't forget, you can follow us on Mastodon for all the latest
updates and to stay connected:

https://floss.social/@XOrgDevConf

Best,

Mark
