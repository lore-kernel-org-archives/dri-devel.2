Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73427606A327
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=hQD9mPgX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3728810F964;
	Wed, 11 Nov 2026 08:22:48 +0000 (UTC)
X-Greylist: delayed 377 seconds by postgrey-1.36 at gabe;
 Tue, 10 Nov 2026 17:09:04 UTC
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5E410E070
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:09:04 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4ABC84029D
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 17:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1794330166;
 bh=ozoC35JH09JXF0SoFXDETE/OXFxO44zArTqmVJlRrnw=;
 h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
 In-Reply-To:Content-Type;
 b=hQD9mPgXugfhtIhDcvsq4SZThekNRzFT3sMIjicEtPufbY6ARxAAxLQP9WwXgY4CC
 aR/wvfhIAOuf3xGqJZo7ygWk+aKNtZBVp7lmCnO9LJjMhM5KrxcmeB8bpIIiHRMrzY
 PrQkHf/lANfXuOSU36xUjcvWW5YuG7yc9cPxFeqpveHCwXebfEbaeOUTnysB/U1Bfa
 CPGExOBT+QlJol/ka/7z/wx722r0mcwCR5XGgD0Q5CsXjt2jIbL03XUfyNoMmsSoTh
 azWcf7ngIBV/oFBaUnd03Yo25hSnHRyOScMrPajLZzJy5tRQmcPlyGJChgcodsy58N
 FmaWQlVn+De1Ouo/qWit8uxUXwv+CoTiMTgzmtBj9+o9QGitYLGM8c7Q/jbx1Yas5Y
 Y/48ZWEGk1Yw3ZMsowhzD+KSuKGreYgOQSxMwuhcsT8w3gjGieQ12dOUI6ZXkWpzhG
 8sMIACnv7Y4gRSVmbu8/sq3RVbNdvF6kvTeBTqiOTSECV65jVm7E9GQMzEHXuE4I6+
 4yxISxem7RcOd1JlrFHtBjJWAIfBc13cDpxb24Pe6pnOiyz2sJ0yOQF8Nn30Xsj4Se
 9g6K+eeCapUKBWNEHlb7hd/cxrT1Mr+c02r8iPBVBUvKS9yvI67OBzeGZE5fHy1WgH
 wOfMNs7ArNDVqstymZ1zmUTA=
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-49323e268aeso1770742f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:02:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794330166; x=1794934966;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:subject:references:cc:to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ozoC35JH09JXF0SoFXDETE/OXFxO44zArTqmVJlRrnw=;
 b=cy6ODCZ+iUt/YwiKaxlVv2AEZ6xV/xe4/jHnOJc3wkzS04pWrutRc9O9AcoDXiqe7X
 7bMVwhbV6QOneG830KWVNpwrVlCQ2o7/YeFW9w/HayDQcbvyGxT2NPz4gjIqhNOY8B+D
 Iu2ol61BCVDxoJo0DOvxkocdYX9l6zRu49rQBHbexWWVK0YrcssG2q6b28nsHd9oJ0qN
 WrOGekaFjoswydDDEowOcQ9wZUt9YZIum0IwOUBq8FzrMcHJTPnQh7pjjnYFEjUvwxYq
 1PkggcR+1Sr8/dePlGaQSTOrO+fcQ/1jDhwwXLVo7/EECdLbFen3FKd4Hl6I0Yeifo+6
 bhiw==
X-Forwarded-Encrypted: i=1;
 AL+hErFeEu+gNNQATfpvOi7y3phhuEzz1qguVuO9wtcaq0YLIDFD+W+1sN+jHlVageDAt1C1tSzGJ7cY2g4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9zjJ/sWbm8SDLtS6ubsHj8BVnlB/lxHVZ6nAfFptuo/0NaaTpr
 VZfCUWDwdu66cPlYW9621H/kOT11BoX/Os//bQ0pP9dbE6eDjsJ/nAThBS3HmQyY6meNtgRL8KJ
 m2BqEvkZ3nD9tkOU7RKzSV6y8qdbhvyGkVyMlhcisFIvb+AfTohRNqN7Zb4zr8mftAU9oWW5n9h
 1sCisjTkCbXw==
X-Gm-Gg: AYBFou38ND0X6yf9xHHklfsI2O+urwsSQitNi+iUrO9gcBXY8p2D8kjTJ1xft4SujPn
 fHR4/X+ilWz4VzcX8894Z47+qMVNhF9vnp83d9Ok9mZpletKGyK8NQPd84ewZVqtSkMhL2WkIUK
 WSpJw5yF9aEP1S6qS4NV84j5ZzTc8e0tHB7vduA1jMT/eMQ8pP1AGt0dVZftC08Pt00W7xe86Lf
 beXAA6SIFoXqJf1S0uek6b9S5Nu66f4c/Y5pKq31ux9zueK9YAjWpbRtytV3M9aRP/IKzm8bC95
 gx97A83CB4Nd8GHQvDRDhUHLOk2TVLgScWB22ZSLvwy0bdEj8sMaI3cXKbegbeRjy3C1g4BZHjj
 tkrnohTiKk15vGh/pPGmxAJULIfrJDuywYHCNIUdntGEiLIdqIBzdHxCJywFjLCpbuDIoXFmpCD
 CZkPzbby3eLKBncj3GsTEvS/gRFbsD+QetJKg+gDjyv657E/X6no3r
X-Received: by 2002:a05:6000:607:b0:48e:eb:56c5 with SMTP id
 ffacd0b85a97d-49992cc6a24mr288614f8f.8.1794330165622; 
 Tue, 10 Nov 2026 09:02:45 -0800 (PST)
X-Received: by 2002:a05:6000:607:b0:48e:eb:56c5 with SMTP id
 ffacd0b85a97d-49992cc6a24mr288536f8f.8.1794330165190; 
 Tue, 10 Nov 2026 09:02:45 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9432:11ec::c98?
 (2a01cb19943211ec0000000000000c98.ipv6.abo.wanadoo.fr.
 [2a01:cb19:9432:11ec::c98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49836c83432sm5386247f8f.58.2026.11.10.09.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 09:02:44 -0800 (PST)
Message-ID: <546efd00-ddaf-47f4-9387-2635785a1bf5@canonical.com>
Date: Tue, 10 Nov 2026 18:02:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: devnull+codykang.hk.gmail.com@kernel.org
Cc: airlied@gmail.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
 bmasney@redhat.com, codykang.hk@gmail.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dlan@kernel.org, docular.xu@gmail.com,
 dri-devel@lists.freedesktop.org, heylenay@4d2.org, krzk+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-riscv@lists.infradead.org,
 maarten.lankhorst@linux.intel.com, me@ziyao.cc, mripard@kernel.org,
 mturquette@baylibre.com, neil.armstrong@linaro.org, p.zabel@pengutronix.de,
 palmer@dabbelt.com, pjw@kernel.org, robh@kernel.org, sboyd@kernel.org,
 simona@ffwll.ch, spacemit@lists.linux.dev, tzimmermann@suse.de,
 u.kleine-koenig@baylibre.com, vkoul@kernel.org
References: <20260809-k3-display-v2-11-327d7910bf71@gmail.com>
Subject: Re: [PATCH v2 11/17] drm/spacemit: add Saturn DPU DRM device driver
Content-Language: en-US
From: Sarah Emery <sarah.emery@canonical.com>
In-Reply-To: <20260809-k3-display-v2-11-327d7910bf71@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

We have incorporated this patchset into the Ubuntu kernel for display 
support on the K3 platforms.

During testing, we found an issue: the screen would display artifacts 
all over, kind of like black lines blinking.

I have implemented the following patch to fix the issue:

drm/spacemit: map scanout buffers write-combining

The K3 display controller is not DMA-coherent: the DPU fetches scanout
buffers straight from memory while fbcon and userspace write them through
a cached CPU mapping. The shmem helpers clean the buffer only once, when
the sg table is first built, so nothing flushes later CPU writes. Dirty
cache lines shadow what the DPU scans out, and erased fbcon text lingers
on screen until the lines are evicted by chance.

Add a gem_create_object() hook that sets map_wc on the shmem objects.
The K3 harts implement Svpbmt, so the CPU mapping becomes genuinely
non-cacheable and writes reach memory immediately; the one-time clean in
dma_map_sgtable() still covers the initial contents.

---
  drivers/gpu/drm/spacemit/spacemit_drm.c | 16 ++++++++++++++++
  1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/spacemit/spacemit_drm.c 
b/drivers/gpu/drm/spacemit/spacemit_drm.c
index 12b2fe8b6fc99..fe354219b996d 100644
--- a/drivers/gpu/drm/spacemit/spacemit_drm.c
+++ b/drivers/gpu/drm/spacemit/spacemit_drm.c
@@ -12,6 +12,7 @@
  #include <drm/drm_fbdev_shmem.h>
  #include <linux/component.h>
  #include <linux/of_graph.h>
+#include <linux/slab.h>

  #include "spacemit_drm.h"
  #include "spacemit_crtc.h"
@@ -75,6 +76,20 @@ int spacemit_drm_mode_config_init(struct drm_device *drm)
         return 0;
  }

+static struct drm_gem_object *spacemit_gem_create_object(struct 
drm_device *drm,
+                                                        size_t size)
+{
+       struct drm_gem_shmem_object *shmem;
+
+       shmem = kzalloc_obj(*shmem);
+       if (!shmem)
+               return ERR_PTR(-ENOMEM);
+
+       shmem->map_wc = true;
+
+       return &shmem->base;
+}
+
  DEFINE_DRM_GEM_FOPS(spacemit_drm_fops);

  struct drm_driver spacemit_drm_drv = {
@@ -82,6 +97,7 @@ struct drm_driver spacemit_drm_drv = {
         .fops = &spacemit_drm_fops,

         DRM_GEM_SHMEM_DRIVER_OPS,
+       .gem_create_object = spacemit_gem_create_object,
         DRM_FBDEV_SHMEM_DRIVER_OPS,

         .name           = DRIVER_NAME,
--

I'm sending this here in the hope that it will be useful for a future 
revision.
Is there a v3 in preparation?

Thanks,

Sarah
