Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6F4C55175
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7596A10E2AE;
	Sat,  1 Aug 2026 07:58:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="yVVqbh4M";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yVVqbh4M";
	dkim-atps=neutral
X-Greylist: delayed 1064 seconds by postgrey-1.36 at gabe;
 Fri, 31 Jul 2026 09:20:18 UTC
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6D910E1FC
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:20:18 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=343OsLc9Zb9EtU0hf0dFUr0LIjlfXP2W9uRjv/2fxOo=;
 b=yVVqbh4MpJL3fIeQEo+IWdd3zP2JlP9VoLLEf9sboA7Bma5OAPkOu+63qiReMIERku73zSvor
 64PN0ik9p2FLWGyAcER7Imhjh3vUo9Hmnhuc+lI+s2HsJDTe7K3ntkeoZZQY45LGz1Mfxk3Mhq2
 Lp3hCjDmKNcw4Y9R+8Aq5SY=
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
 by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4hBKn33blvz126M4f
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 17:01:27 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=343OsLc9Zb9EtU0hf0dFUr0LIjlfXP2W9uRjv/2fxOo=;
 b=yVVqbh4MpJL3fIeQEo+IWdd3zP2JlP9VoLLEf9sboA7Bma5OAPkOu+63qiReMIERku73zSvor
 64PN0ik9p2FLWGyAcER7Imhjh3vUo9Hmnhuc+lI+s2HsJDTe7K3ntkeoZZQY45LGz1Mfxk3Mhq2
 Lp3hCjDmKNcw4Y9R+8Aq5SY=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hBKbJ2mb4zRhVP;
 Fri, 31 Jul 2026 16:53:00 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
 by mail.maildlp.com (Postfix) with ESMTPS id 628354058F;
 Fri, 31 Jul 2026 17:02:27 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Jul 2026 17:02:26 +0800
From: Yao Kai <yaokai34@huawei.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
 <liuyongqiang13@huawei.com>, <jifa@huawei.com>
Subject: [PATCH 0/2] drm/virtio: fix control-buffer leaks on queueing errors
Date: Fri, 31 Jul 2026 17:22:34 +0800
Message-ID: <20260731092236.2262403-1-yaokai34@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.85.180]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemr500006.china.huawei.com (7.185.36.185)
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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

Fix two independent cleanup omissions for control buffers that do not
reach the virtqueue.

Patch 1 fixes the reproduced GEM/VMA leak when fbdev damage work races
with device unplug.

Patch 2 fixes the vmalloc_to_sgt() allocation-failure path, found by
code inspection.

Testing:
- Repeated virtio-gpu unbind/rebind no longer triggers the
  drm_mm_takedown warning.
- Built drivers/gpu/drm/virtio/virtgpu_vq.o with W=1.

Yao Kai (2):
  drm/virtio: release object array when device is unplugged
  drm/virtio: free control buffer when scatterlist allocation fails

 drivers/gpu/drm/virtio/virtgpu_vq.c | 3 +++
 1 file changed, 3 insertions(+)


base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
-- 
2.43.0

