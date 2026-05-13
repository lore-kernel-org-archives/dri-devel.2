Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4912CD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 21:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F0D10E37A;
	Wed, 13 May 2026 21:41:12 +0000 (UTC)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D00C10F086
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 21:41:11 +0000 (UTC)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6948c46e69aso8071285eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 14:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778708470; x=1779313270;
 h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tqk0Slr65mDNKAZF2Vaic14WCI6WBEKE9EJXBGKW5II=;
 b=qzg1pyEVcwdWtIxK/ufDzB9VcttDeGeQywxjucDXZo38l/CUgP22WAxC1wnsA6Q21O
 QkdVIwmTXDh0rTeAkcRkVqzKskmfsMbbo9HCcroalMmeXA0/zQwcRxRDPuy+YB6JHXM1
 clhpdygdOgJA2GcdOb7vwnkaj+cnRNEDz3NvsiGhV6YZzo14kcKvTUuGjGczGB24LO/z
 ihArPYmn2VfMAnmPRrDLkCLmREYX7nZGbFaBcV8UGwUHw0Y+uK8c97i4uZUfgapyCGX4
 bPL/CKS75kS2qKtSefBowd83VWVK0kGJbKAgKxaFcwbcm8O6LAZGKVF7UZKKl3NVgaLv
 hy7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XvdOqyq/hp4Pqx2MSe+Rx8BW0sXc4tKYvgdKI36ZytrxTAelmPbDfouOQIMryOsl/QNTxNZJ5iok=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCmYuO/n/L2e01+2hdBrN8B+qzr6y36nxdzrDDcozDEc52icH5
 t2WDfNzf2cbFKZcGP1JTy1hPjtdJ/CBBi5y1YsDDRoMpTFwiWkFrSzsoghXwa7m1sGxwOwkbhaH
 OSyHBAz8ueVIPp4cN8ASmv+R4ZAeONEWm63cpmK1ak6oLiSMXqrErsHQeKCE=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:178f:b0:68e:b81b:d81b with SMTP id
 006d021491bc7-69b78dfac2amr2764182eaf.31.1778708470309; Wed, 13 May 2026
 14:41:10 -0700 (PDT)
Date: Wed, 13 May 2026 14:41:10 -0700
In-Reply-To: <82aeba42-7872-4e92-ade8-2b7b6a8a5e43@collabora.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a04eff6.050a0220.190576.0001.GAE@google.com>
Subject: Re: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung
 task
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: dmitry.osipenko@collabora.com
Cc: airlied@redhat.com, dmitry.osipenko@collabora.com, 
 dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
 kraxel@redhat.com, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
 ryasuoka@redhat.com, simona@ffwll.ch, tzimmermann@suse.de, 
 virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
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

> Hi,
>
> On 5/12/26 11:59, Ryosuke Yasuoka wrote:
>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
>> wait_event() without timeout when waiting for virtqueue space. If the
>> host device stops processing commands, these waits block indefinitely.
>> Since callers may hold DRM locks, this can make the entire system
>> unresponsive.
>> 
>> Replace wait_event() with wait_event_timeout() using a 5-second timeout,
>> consistent with the existing timeout pattern in the driver. On timeout,
>> clean up and return -ENODEV, following the same error path as
>> drm_dev_enter() failure.
>> 
>> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
>> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_vq.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> If host stops processing commands, this is a problem on host side. Isn't it?
>
> -- 
> Best regards,
> Dmitry

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

