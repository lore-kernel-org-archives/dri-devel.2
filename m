Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CB1CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043D910F210;
	Wed, 30 Sep 2026 07:35:49 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E9210F212
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:35:46 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.54])
 by APP-05 (Coremail) with SMTP id zQCowABHtD7Eu7xqdFHBCQ--.5968S2;
 Wed, 30 Sep 2026 15:35:33 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Paul Walmsley <pjw@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>,
 Dominique Belhachemi <domibel@debian.org>,
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Icenowy Zheng <uwu@icenowy.me>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [RFC PATCH 0/2] drm: add a noncoherent mapping checking helper
Date: Wed, 30 Sep 2026 15:35:26 +0800
Message-ID: <20260930073528.3369325-1-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABHtD7Eu7xqdFHBCQ--.5968S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw18XFW7uFWrKrykWF43trb_yoW8AF4rpF
 4akFW3trWUGFWfXrnxAw4jkw4ru3yxJayIgrn3J34DZw4YvFy7XryxGF18WFyDJr1xWF12
 vFZ0kryIkw1vvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
 AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
 17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
 IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
 IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
 C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-Originating-IP: [112.94.101.54]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

This patchset tries to address the lack of uncached mapping support on
several SiFive-core-based SoCs, currently targeting JH7110 but EIC7700
would have the same problem (although it uses DC8000 display controller
instead of DC8200 and real display support is pending).

Because other users (either SoCs with Xuantie cores, which have
Xtheadmae extensions or non-RISC-V SoCs) of the driver have proper
writecombine support, a helper is added to check whether coherent
(cache-bypassing) mapping is available. This helper currently returns
true for all architectures except RISC-V, and checks whether
pgprot_writecombine() is a no-op on RISC-V.

The patch really enabling manual cache maintenance for the verisilicon
driver is picked from Dominique, and reworked to check both
dma-noncoherent property and the platform's mapping capaibility.

Tested on VisionFive 2 with the display enablement patchset at [1] (and
its dependency).

Also tested on Lichee Pi 4A (TH1520, which has Xtheadmae), operation is
not affected, map_noncoherent isn't set and Xorg says kernel dirty
updates aren't required.

[1] https://patch.msgid.link/20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com

Dominique Belhachemi (1):
  drm: verisilicon: support non-coherent DMA framebuffers

Icenowy Zheng (1):
  drm: add a helper function to check availbility of coherent mapping

 drivers/gpu/drm/verisilicon/vs_cursor_plane.c |  9 ++++++
 drivers/gpu/drm/verisilicon/vs_drm.c          | 32 ++++++++++++++++++-
 drivers/gpu/drm/verisilicon/vs_drm.h          |  7 ++++
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  9 ++++++
 include/drm/drm_cache.h                       | 21 ++++++++++++
 5 files changed, 77 insertions(+), 1 deletion(-)

-- 
2.55.0

