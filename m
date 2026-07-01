Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F56C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 23:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C67D10E3F6;
	Wed,  1 Jul 2026 23:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=sina.com header.i=@sina.com header.b="iCkV6Jbj";
	dkim-atps=neutral
X-Greylist: delayed 537 seconds by postgrey-1.36 at gabe;
 Wed, 01 Jul 2026 23:52:52 UTC
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn
 [202.108.3.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F011610E3F6
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1782949973; bh=xQ23ltzGIx0al3TzodxktcL0AEOqsC47kRrB7dugiMI=;
 h=From:Subject:Date:Message-ID;
 b=iCkV6JbjprlQ15IuGcKxslak+c9iEBfb2FxrZNxMBF2ogZWFmLjwnhsCtL+LIv+x9
 Sx+xoHs96lbShUsmqPsULPgCIEBqNr5TteUDRat3dXkiwLm0RkBMOAnzRJuX7hrEjq
 kTE7mFVb5Xl3hN8aNeZylWrjNC/+cF5Ax+1By0Gs=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
 by sina.com (10.54.253.32) with ESMTP
 id 6A45A60F00003880; Wed, 2 Jul 2026 07:43:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=hdanton@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6550824456920
X-SMAIL-UIID: DBFA2DA1DDDE481C94AB2F6835CD65D8-20260702-074314-1
From: Hillf Danton <hdanton@sina.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: defer hotplug event from dequeue worker to
 avoid deadlock
Date: Thu,  2 Jul 2026 07:43:00 +0800
Message-ID: <20260701234301.361-1-hdanton@sina.com>
In-Reply-To: <18be2016e26ade27.a6e9e2496bc1f978.9bc3a62421115997@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
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

On Wed, 1 Jul 2026 09:23:05 +0000 Ryosuke Yasuoka wrote:
>On 30/06/2026 16:46, Dmitry Osipenko wrote:
>> Could you please move drm_kms_helper_hotplug_event() to virtio_gpu_init(),
>> placing it after wait_event_timeout(display_info_pending)? This will avoid
>> additional work_struct that otherwise needs to be cancelled in
>> virtio_gpu_init() on the timeout.
>
>IIUC, moving the drm_kms_helper_hotplug_event() and _hpd_irq_event()
>into virtio_gpu_init() after wait_event_timeout() would not prevent the
>issue.
>
>Looking at the syzbot call traces[1][2], the deadlock occurs during
>drm_client_setup(), which runs after virtio_gpu_init() has already
>returned. The display_info_cb that triggers the deadlock is called from
>the dequeue worker while drm_client_register() holds clientlist_mutex.
>
>Thread A:
>virtio_gpu_probe()
> -> virtio_gpu_init()   // sends GET_DISPLAY_INFO and waits up to 5s
> -> drm_dev_register()
> -> drm_client_setup()   // deadlock happens HERE
>     -> drm_client_register()   // holds clientlist_mutex
>     ...
>     -> virtio_gpu_queue_fenced_ctrl_buffer()
>         -> wait_event() // waits for free space
>
>Thread B:
>virtio_gpu_dequeue_ctrl_func()
> -> reclaim_vbufs()   // make free space

I wonder if the deadlock could be cured by alternatively adding a wakeup
before the responce cb, given that free space is available.

> -> resp_cb()
>     -> virtio_gpu_cmd_get_display_info_cb
>         -> drm_helper_hpd_irq_event()
>         -> drm_kms_helper_hotplug_event()
>             -> drm_client_dev_hotplug() // need to lock clientlist_mutex
> -> wake_up()   // never reached
>
>IIUC the hotplug notification in display_info_cb is needed because it
>notifies DRM after updating by the callback with fresh data from the host.
>
>This work_struct ensures display_info_cb never blocks on
>clientlist_mutex in the dequeue worker, while preserving the hotplug
>notification with fresh data.
>
>[1] https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
>[2] https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
>
>Best regards,
>Ryosuke
