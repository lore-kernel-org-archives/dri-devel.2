Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319AFC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 974A810E47A;
	Thu,  2 Jul 2026 08:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=sina.com header.i=@sina.com header.b="PUSpCL5l";
	dkim-atps=neutral
X-Greylist: delayed 31337 seconds by postgrey-1.36 at gabe;
 Thu, 02 Jul 2026 08:25:34 UTC
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn
 [61.135.153.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 645E810E47A
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1782980734; bh=dmmoJgg+0zg52YaXd3a/e/RT6muwcoryyA80mm/IHAU=;
 h=From:Subject:Date:Message-ID;
 b=PUSpCL5lwxeEBPT9oHxZCbzDy+tmi6JozGCXvjKPyOYHDpYGuyzro5/Nu+SNi9nhP
 eq0gYkz4Uo91usdSTWwhREr/bo2uL5MrKr2hErTO9oGsP3tvPH6BSTHpkzr1Qu3bol
 MSJbv1wHJhkgaVhyevceVc1Q+BPvPrYjMuqLm15A=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
 by sina.com (10.54.253.34) with ESMTP
 id 6A4620780000166B; Thu, 2 Jul 2026 16:25:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=hdanton@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9223576291952
X-SMAIL-UIID: 05424C4F371B4537B8CFE6310E47270C-20260702-162530-1
From: Hillf Danton <hdanton@sina.com>
To: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
Cc: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>,
 "Dmitry Baryshkov" <lumag@kernel.org>,
 "Javier Martinez Canillas" <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: defer hotplug event from dequeue worker to
 avoid deadlock
Date: Thu,  2 Jul 2026 16:25:16 +0800
Message-ID: <20260702082517.380-1-hdanton@sina.com>
In-Reply-To: <18be678e97322160.8f56a0770e5621ab.8d175eba8a62d6be@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
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

On Thu, 2 Jul 2026 07:12:44 +0000 Ryosuke Yasuoka wrote:
>On 02/07/2026 07:43, Hillf Danton wrote:
>> On Wed, 1 Jul 2026 09:23:05 +0000 Ryosuke Yasuoka wrote:
>>>On 30/06/2026 16:46, Dmitry Osipenko wrote:
>>>> Could you please move drm_kms_helper_hotplug_event() to virtio_gpu_init(),
>>>> placing it after wait_event_timeout(display_info_pending)? This will avoid
>>>> additional work_struct that otherwise needs to be cancelled in
>>>> virtio_gpu_init() on the timeout.
>>>
>>>IIUC, moving the drm_kms_helper_hotplug_event() and _hpd_irq_event()
>>>into virtio_gpu_init() after wait_event_timeout() would not prevent the
>>>issue.
>>>
>>>Looking at the syzbot call traces[1][2], the deadlock occurs during
>>>drm_client_setup(), which runs after virtio_gpu_init() has already
>>>returned. The display_info_cb that triggers the deadlock is called from
>>>the dequeue worker while drm_client_register() holds clientlist_mutex.
>>>
>>>Thread A:
>>>virtio_gpu_probe()
>>> -> virtio_gpu_init()   // sends GET_DISPLAY_INFO and waits up to 5s
>>> -> drm_dev_register()
>>> -> drm_client_setup()   // deadlock happens HERE
>>>     -> drm_client_register()   // holds clientlist_mutex
>>>     ...
>>>     -> virtio_gpu_queue_fenced_ctrl_buffer()
>>>         -> wait_event() // waits for free space
>>>
>>>Thread B:
>>>virtio_gpu_dequeue_ctrl_func()
>>> -> reclaim_vbufs()   // make free space
>> 
>> I wonder if the deadlock could be cured by alternatively adding a wakeup
>> before the responce cb, given that free space is available.
>
>Thanks for your comment. I agree that moving wake_up() before response
>cb would help in most cases, and I think it is a reasonable aproach.
>However, there are a few rare scenarios where the deadlock can still
>occur:
>
>1. If reclaim_vbufs() does not free enough slots to satisfy
>num_free >= elemcnt, wake_up() fires but the wait_event() condition
>evaluates false. Thread A remains asleep holding clientlist_mutex, and
>the dequeue worker proceeds to display_info_cb which blocks on
>clientlist_mutex.

	task0		task1
	lock clientlist_mutex
	wait_event(for enough free slots)

			free some slots
			lock clientlist_mutex
			unlock clientlist_mutex
			wakeup
	deadlock

The clientlist_mutex will not be released without enough slots freed, so more
free slots and wakeup are needed to cure the deadlock, with nothing to do with
acquiring the mutex in the workqueue context.

Your workqueue approach works by removing the dependence of wakeup on acquiring
the mutex, without enough free slots guaranteed.

In short, wakeup before acquiring the mutex is the right thing to do, I mean
it is not the only one at all.

>2. Even if enough slots are freed, there is a small window between
>wait_event() returning and Thread A acquiring spin_lock(&qlock) at the
>"goto again" path in virtio_gpu_queue_ctrl_sgs(). Another thread can
>consume the freed slots during this window, causing Thread A to loop 
>back to wait_event() still holding clientlist_mutex.

Ditto

>3. Reordering wake_up() before resp_cb inverts the natural "process
>response, then signal completion" pattern, which could introduce subtle
>issues if a future resp_cb depends on side effects that should happen
>after wake_up(), I believe.
>
Different taste

>These scenarios are likely rare in practice, but the schedule_work()
>approach avoids all of them entirely by ensuring the dequeue worker
>never touches clientlist_mutex. It also follows the same pattern
>already used by config_changed_work in this driver.
>
>Best regards
>Ryosuke
>
>> 
>>> -> resp_cb()
>>>     -> virtio_gpu_cmd_get_display_info_cb
>>>         -> drm_helper_hpd_irq_event()
>>>         -> drm_kms_helper_hotplug_event()
>>>             -> drm_client_dev_hotplug() // need to lock clientlist_mutex
>>> -> wake_up()   // never reached
>>>
>>>IIUC the hotplug notification in display_info_cb is needed because it
>>>notifies DRM after updating by the callback with fresh data from the host.
>>>
>>>This work_struct ensures display_info_cb never blocks on
>>>clientlist_mutex in the dequeue worker, while preserving the hotplug
>>>notification with fresh data.
>>>
>>>[1] https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
>>>[2] https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
>>>
>>>Best regards,
>>>Ryosuke
