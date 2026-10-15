Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8417CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FACB10FAB3;
	Thu, 15 Oct 2026 13:51:28 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9CBC10F0A5
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792072278;
 bh=03mvS8mzxYiW/ci8MPdxpZH/zvc+bJ9cEm0B1kgFwRI=;
 h=From:To:Cc:Subject:Date:From;
 b=EuVh0zdRbUUS5I5k9l2LuCP1lQDurb7vFLFM8vzhOWDgDrw/hwEQLwctyPLVz7LEz
 1jX5x7IB5E6neEMjFJGDfMGL4j9of2VLGt1cPpG3moJ9aFyGFz44hsKMel610s2n2E
 B3mLC80kZzJ0iMnkhSqcPVQR1KLOZzNZrLVtHxj8rpQ44PJ+GJvQzXkTqE2y3+h9Ns
 adfgD6/CTecONYPrTvYEHv2FlSOCvhaLpfCjDiBSyADR96vUr51FNAxvsoZ7aTG2YN
 JRYHEYtQT9zkbv8yA/fk7kN7TzJ0tX39Dcla4capKzCJgaF2XbyGX8ot8zXQRaSofC
 J62IJxyajquXg==
Received: from reinforced (unknown [100.64.0.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: daniels)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 230B717E05A6;
 Thu, 15 Oct 2026 15:51:18 +0200 (CEST)
From: Daniel Stone <daniels@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: boris.brezillon@collabora.com, laura.nao@collabora.com,
 adrian.larumbe@collabora.com, daniel.almeida@collabora.com,
 liviu.dudau@arm.com
Subject: [PATCH v2 0/2] drm/panthor: Consistently delegate shader power
Date: Thu, 15 Oct 2026 14:50:25 +0100
Message-ID: <20261015135116.713461-1-daniels@collabora.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi,
When trying to bring up a v14 platform, one trap I fell into was
inconsistent power-domain delegation. When delegating a domain, all of
its child domains need to be already delegated, so the firmware can
exercise effective control.

We unconditionally delegate the L2 domain to firmware power management,
along with the tiler and shader domains, however the neural-engine power
domain is also a child of L2 and not delegated. Failing to do this
results in the firmware going into a loop when attempting to power up
the shader cores for the first time.

Changes in v2:
  - send the patches from the right tree so they actually compile

Cheers,
Daniel

