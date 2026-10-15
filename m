Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BF5CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4F410EBBA;
	Thu, 15 Oct 2026 13:13:16 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC9AD10EBB0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792069983;
 bh=+w/hJLCCMyEdp4e1WWFSz9dgpP+JmJ8rtpINE2kTLJ0=;
 h=From:To:Cc:Subject:Date:From;
 b=mOaJNR+fG2n9R4tlaR/IiXgNneSG/ajRhaDP9eZ/KQb/2u8S3+pG8bm/zedC71qr3
 2l39G1NeWL+TSK9oWeZqqrYexrWOsOO0H+Pwk64ER7zhwd2oJDb3NjnHOEdAtz41zR
 fb4TZLfvraOtUmLwY8sz+wTeuvnJ3lnjebbsqVlCAFmNrLgyA1ys2dyWDTUrV4EOcp
 t9w+np0tDP/F6/9AoOrvD5xQG7OC2sq28jBhPVowOrfkzMwyvSbkOjANy8YvWuAuTM
 DaggDmRpRtXntdjcjZyDztwl3EKTIe6RKW30LUEoNZ1Poqe0bXjhhlvaLujkMuHa6e
 hs7m3a1yu3dOg==
Received: from reinforced (unknown [100.64.0.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: daniels)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2D29717E0036;
 Thu, 15 Oct 2026 15:13:03 +0200 (CEST)
From: Daniel Stone <daniels@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: boris.brezillon@collabora.com, laura.nao@collabora.com,
 adrian.larumbe@collabora.com, daniel.almeida@collabora.com,
 liviu.dudau@arm.com
Subject: [PATCH 0/2] drm/panthor: Consistently delegate shader power
Date: Thu, 15 Oct 2026 14:10:39 +0100
Message-ID: <20261015131301.711153-1-daniels@collabora.com>
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

Cheers,
Daniel

