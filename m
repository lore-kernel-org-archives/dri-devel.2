Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4668C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E1C010E8A3;
	Mon, 28 Sep 2026 08:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="knXpC96T";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 825F110E050;
 Sat, 26 Sep 2026 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SX
 4HMIM1TzXt1rGZ0TSFJGAeochb7ps2U/JaupsWzEk=; b=knXpC96TSRqfwoKauG
 5vRzTgd8746fp6cOjqKEgQgiJ4+hBW8hArrTDppVNJ6UsUHHwOHEfKagCZLFaInr
 hbNylVGVzqrTdCh6lDI7aGWWNn81/uUJT7vfvHPLszfXaXcwECl8rI0HmKTv295o
 xx38SzsVO8b89O7f56EjijuEg=
Received: from pc.localdomain (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wD3v6EU8rdq1Ce5Aw--.54526S2; 
 Sun, 27 Sep 2026 00:25:58 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Qiang Yu <yuq825@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Farhan Ali <alifm@linux.ibm.com>, Matt Evans <mattev@meta.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Eric Anholt <eric@anholt.net>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Andreas Baierl <ichgeh@imkreisrum.de>, Marek Vasut <marex@denx.de>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/3] Drain module-owned RCU callbacks during teardown
Date: Sun, 27 Sep 2026 00:25:49 +0800
Message-Id: <20260926162554.163197-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v6EU8rdq1Ce5Aw--.54526S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF4rWrW7uFyfGw43Zr4DXFb_yoWDuFc_W3
 sa9r9rGw1kG3WxKanFyF1xAFWvka45ur1rArWFkr9rKry8Wr45ZrZ8Kr98CF48trWYy3Zr
 Jrn8KF15Xw4v9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUNeOJUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRZKhGq38haJ5QAA3A
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
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

VFIO PCI core, TUN, and Lima each enqueue an RCU callback implemented in
module text. Their teardown paths can run after the callback producer has
stopped but before a previously queued callback has completed. Unloading
the module in that interval lets rcu_do_batch() invoke freed module text.

For Lima, the same window also allows the callback's slab cache to be
destroyed and its global pointer cleared before the callback frees the
fence.

Drain callbacks after their producers have stopped. The three changes are
independent and each patch remains buildable on its own.

The affected object files were built with CONFIG_TUN=m. The series was
also checked with checkpatch.pl. Runtime reproduction was not performed.

Jiale Yao (3):
  vfio/pci: Drain eventfd RCU callbacks on module exit
  tun: Drain eBPF RCU callbacks on module exit
  drm/lima: Drain fence callbacks before destroying slab

 drivers/gpu/drm/lima/lima_sched.c | 1 +
 drivers/net/tun.c                 | 1 +
 drivers/vfio/pci/vfio_pci_core.c  | 1 +
 3 files changed, 3 insertions(+)

-- 
2.34.1

