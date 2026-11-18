Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0A360A2607
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C846010FDF5;
	Wed, 18 Nov 2026 15:35:03 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736E710FDEC
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:35:01 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.23])
 by APP-05 (Coremail) with SMTP id zQCowAB31bqdxf1qc3xpAQ--.6681S2;
 Wed, 18 Nov 2026 23:34:54 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Joey Lu <a0987203069@gmail.com>, Han Gao <gaohan@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>
Cc: David Airlie <airlied@gmail.com>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH v3 0/5] drm/verisilicon: misc fixes
Date: Wed, 18 Nov 2026 23:34:43 +0800
Message-ID: <20261118153448.375639-1-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAB31bqdxf1qc3xpAQ--.6681S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4xZw13Kr4UCryfGFWrGrg_yoW8JFW8pr
 43tFZ0yF4DXFWaqasrJw48t3yfAFs7tayIgr1xKr18Zwn0yw4UXr18KryfWFWDXrZ7Gw1f
 trs2krW7uryIy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
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
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patchset fixes several problems. The first one fixes a bug when the
firmware did a modeset with different mode than the one picked by Linux,
and others are fixing problems pointed by Sashiko.

During the reviewing process of previous revisions of this patchset, I
found that the atomic_enable/atomic_disable hooks are not suitable
because of poor off-screen plane process, so I dropped both hooks and
let atomic_update handle everything now.

Changes in v3:
- Remove atomic_disable along with atomic_enable.

Changes in v2:
- Reworked the fix for atomic_disable NULL dereference.
- Fixed the problem that clearing FB_EN would prevent showing
  bound-but-invisible planes.

Icenowy Zheng (4):
  drm/verisilicon: disable the output before enabling it
  drm/verisilicon: nuke planes' atomic_enable hooks
  drm/verisilicon: check old state CRTC in plane atomic_disable
  drm/verisilicon: nuke planes' atomic_disable hooks

Joey Lu (1):
  drm/verisilicon: fix DC8200 primary plane disable clearing FB_EN

 drivers/gpu/drm/verisilicon/vs_bridge.c       |  8 ++++
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 40 +++++++---------
 .../gpu/drm/verisilicon/vs_primary_plane.c    | 48 ++++++++-----------
 3 files changed, 44 insertions(+), 52 deletions(-)

-- 
2.56.0

