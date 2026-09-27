Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C79C98328
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 00:13:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750B710E37B;
	Sun, 27 Sep 2026 00:13:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=sina.com header.i=@sina.com header.b="MDbJGjx2";
	dkim-atps=neutral
X-Greylist: delayed 574 seconds by postgrey-1.36 at gabe;
 Sun, 27 Sep 2026 00:13:11 UTC
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn
 [202.108.3.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE44F10E1F1
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 00:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1790467992; bh=t1NV1h1nSPt4cYWoKLftL9MH2NWX+QPNIV0D+GSaeoE=;
 h=From:Subject:Date:Message-ID;
 b=MDbJGjx238QgfjMhWFwYxQccnzfKc8hJI5p+VGQqFeKF0Zq2gR9+lerqX7OQb5mXg
 gOEP0MjOCaz7zq51lvgYImAxefsoeMMjOFXWv2i7MhG0AdNQjqb97C3CD9On6WxECz
 EXQRTiqtTYvbrxIAOAKRQNETnDHOPbR9M8ZysVjc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
 by sina.com (10.54.253.32) with ESMTP
 id 6AB85D5200006D2A; Sun, 27 Sep 2026 08:03:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=hdanton@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 924834456770
X-SMAIL-UIID: F10C53ADF8B44D0E820DF1EC2C9DBC9C-20260927-080333-1
From: Hillf Danton <hdanton@sina.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
Subject: Re: [PATCH] drm/virtio: share one vbuf cache across all devices
Date: Sun, 27 Sep 2026 08:03:21 +0800
Message-ID: <20260927000323.299-1-hdanton@sina.com>
In-Reply-To: <20260926162452.136863-1-ngocthang2710.1999@gmail.com>
References: 
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

On Sat, 26 Sep 2026 23:24:52 +0700 Nguyen Ngoc Thang wrote:
> virtio_gpu_alloc_vbufs() creates a kmem_cache with the fixed name
> "virtio-gpu-vbufs" for every device and destroys it from
> virtio_gpu_release(), which only runs once the last drm_device
> reference is dropped. If a reference outlives the PCI removal (for
> instance an open /dev/fbN), a rescan probes the device again while the
> old cache still exists:
> 
>   kmem_cache of name 'virtio-gpu-vbufs' already exists
>   WARNING: mm/slab_common.c:111 at __kmem_cache_create_args
>   Call Trace:
>    virtio_gpu_alloc_vbufs
>    virtio_gpu_init
>    virtio_gpu_probe
>    ...
>    pci_rescan_bus
>    rescan_store
> 
> kmem_cache_create() then fails and the new device does not probe.
> 
> The vbuf size is the same for every device, so create the cache once
> at module init and destroy it at module exit instead of per device.
>
What is unclear -- why is kmalloc failing to work in 2026?
