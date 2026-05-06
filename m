Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57456CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF10910E211;
	Wed,  6 May 2026 17:56:26 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A72310E211
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:56:24 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.82])
 by APP-01 (Coremail) with SMTP id qwCowAD3oW3AgPtpT_RzDw--.33952S2;
 Thu, 07 May 2026 01:56:16 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH v3 0/2] drm: verisilicon: add hardware cursor support
Date: Thu,  7 May 2026 01:56:08 +0800
Message-ID: <20260506175610.2542888-1-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3oW3AgPtpT_RzDw--.33952S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKry8AF1DJr43Jry5ZF4DCFg_yoWDKrgEkr
 nruFy7uwnFka4DX3W7Ar1v9Fy2yF409F4rAay0gr9xGr1DXry5Gr1UZFWxuw1UJ3WUWFZ5
 Cws7WFn7XFsxAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
 kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
 67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
 CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
 MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvf
 C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-Originating-IP: [112.94.100.82]
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

Verisilicon display controllers have the hardware cursor feature.

The hardware cursor layer is a simplistic and restrictive layer as the
topmost layer of the display output. It can only support ARGB8888 images
and some certain square power-of-two sizes (32x32 is supported on all
DCs).

This patchset adds support for the hardware cursor as a cursor plane.

Icenowy Zheng (2):
  drm: verisilicon: add max cursor size to HWDB
  drm: verisilicon: add support for cursor planes

 drivers/gpu/drm/verisilicon/Makefile          |   3 +-
 drivers/gpu/drm/verisilicon/vs_crtc.c         |  11 +-
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 272 ++++++++++++++++++
 .../drm/verisilicon/vs_cursor_plane_regs.h    |  44 +++
 drivers/gpu/drm/verisilicon/vs_hwdb.c         |   4 +
 drivers/gpu/drm/verisilicon/vs_hwdb.h         |   5 +
 drivers/gpu/drm/verisilicon/vs_plane.h        |   1 +
 7 files changed, 337 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/verisilicon/vs_cursor_plane.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h

-- 
2.52.0

