Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B69C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7040910E472;
	Thu,  2 Jul 2026 07:12:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VvjZ932v";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E904D10F162
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 07:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782976371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=hxdCQj6NzsZ0fMBpIQu3pY1Ddr/TRKQeJvgNYNHVEJc=;
 b=VvjZ932vnv0LhP9eynVXbFTPPT5lCpBhRGGttsCDm2nKIVgyQrxvM4DEWK4Gg9TNq9yfHu
 UaQ1xpNkaGteHubsAcuLF9i3l3w/OwAYq7bCO36j3iLzbgB1h3WL3hn7rdxcDPzjc3IXtZ
 KVsbPX7QPlC3tDIIuIUeLaxMhTqHQkc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-PeYPgTgwMT2UfDQDZHfuNA-1; Thu, 02 Jul 2026 03:12:49 -0400
X-MC-Unique: PeYPgTgwMT2UfDQDZHfuNA-1
X-Mimecast-MFC-AGG-ID: PeYPgTgwMT2UfDQDZHfuNA_1782976369
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-380b630c4e9so1112756a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 00:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782976369; x=1783581169;
 h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PhGng+hd9qECLzQceD/9OUpAsw5HRAD3GeuzTLZHbzY=;
 b=hHUpFiLr+V17jR5y74DpJIsWkZu+wXYnsWvoElGJjkAeViCoDjdo5f7qWNycj4FTdf
 hXHVx8uWzIQGOdgEQPeZbSsJNpjRwOK00LY0/TW1qtGmaIp/I0TKDZaJEQhX2ZJyPJvd
 kFBNIGL0yfVwuOWTxcFS5LZG6CXu6AJY9aqsO/NBQuvrthW0DmSkTcjcUIughPCDTkzD
 OJxMMBwO9U9PAmaxnzm62R9PGJHOhhusO3qqiV7krtGwp+06O5ZGZUwWx/D2K+vvoF2u
 8qX7xDDlt7x0ARf6WigIiGFpwEk9olQjmSsvTzhsTWYlChhPQV/Y0A80ibUB9UvDpKtc
 9qVg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rql+dDadJvto+3uiqCKJ6E3T/kRjohnR84dhoPmgFLc3MEyORDESWLsrMTzVWX8b9acht79FezxEuI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyA5CfLtaI9q7nCqL6yj2zODpqAgJfeGhCD+J9nl/bUqJEy4Tc
 m5AYhkXKIzDAVmLiG353srseBI5eSdaZUGGG922msxL8rrZglEzoyoHA8XhOGNZ+6dMVTapZwNr
 y5TYTov3pd3ztaEMN5jTAgmKMvJwrVG6RnkqD9R+DxCUB3TPccczOPJxgze/bTeUxW+1uak3EZl
 NGjh/FNIdwfYa/tpBAU3kq6c3Gk7E2SFz0oCJnf93/R7V8Fv7yUsvjTmaN
X-Gm-Gg: AfdE7ck35yZWRZYUO3CxqSkdktws5hHK3eFlhccLSfwzS7uyHj5GGzHlLpR0+xG4iA1
 NOM7Mo/5PjlwUuIyG35RV38/rWRqa66VAnTPKnzFWG5GEc2yqyTjbMLvLPp1VmHEQU29cPGpcn1
 jqLFM/FyeScjnVi3fENDejUffwRfAfA0+6Jsdv4pQJzWhiBMEgSWvDliEGXAm1JbpidwiV7tKXU
 btneKtc1F5QEQCxYGNr4pq3Y9L8X9sWC7acUn0DdJwVvI4s/MEOqxsfkBED6axxpNg1OIL//0dJ
 n2NVcW0a346xJqqkT3JyzOtysP7w+7fRKm77ZtWutb8ZLlr+GiQhcdwpidonlwsMvUrwu2Fr3ac
 QbwrPgCSKneSAeLj/7Q1IRthsb5a+bLeUqMQRMPAJtkIN/Y3T
X-Received: by 2002:a17:90b:5148:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-380ba8d0fd6mr4293599a91.14.1782976368660; 
 Thu, 02 Jul 2026 00:12:48 -0700 (PDT)
X-Received: by 2002:a17:90b:5148:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-380ba8d0fd6mr4293543a91.14.1782976367846; 
 Thu, 02 Jul 2026 00:12:47 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-380e17cb4b7sm577673a91.13.2026.07.02.00.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 00:12:47 -0700 (PDT)
MIME-Version: 1.0
From: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
To: "Hillf Danton" <hdanton@sina.com>
In-Reply-To: <20260701234301.361-1-hdanton@sina.com>
Cc: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, 
 "Dmitry Baryshkov" <lumag@kernel.org>, 
 "Javier Martinez Canillas" <javierm@redhat.com>, 
 <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: defer hotplug event from dequeue worker to
 avoid deadlock
Message-ID: <18be678e97322160.8f56a0770e5621ab.8d175eba8a62d6be@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Thu, 2 Jul 2026 07:12:44 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DpFlMeieRNZ_W-7jnkr7ebxMVvN-ESe6Qxk4RMUC12o_1782976369
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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



On 02/07/2026 07:43, Hillf Danton wrote:
> On Wed, 1 Jul 2026 09:23:05 +0000 Ryosuke Yasuoka wrote:
>>On 30/06/2026 16:46, Dmitry Osipenko wrote:
>>> Could you please move drm_kms_helper_hotplug_event() to virtio_gpu_init=
(),
>>> placing it after wait_event_timeout(display_info_pending)? This will av=
oid
>>> additional work_struct that otherwise needs to be cancelled in
>>> virtio_gpu_init() on the timeout.
>>
>>IIUC, moving the drm_kms_helper_hotplug_event() and _hpd_irq_event()
>>into virtio_gpu_init() after wait_event_timeout() would not prevent the
>>issue.
>>
>>Looking at the syzbot call traces[1][2], the deadlock occurs during
>>drm_client_setup(), which runs after virtio_gpu_init() has already
>>returned. The display_info_cb that triggers the deadlock is called from
>>the dequeue worker while drm_client_register() holds clientlist_mutex.
>>
>>Thread A:
>>virtio_gpu_probe()
>> -> virtio_gpu_init()   // sends GET_DISPLAY_INFO and waits up to 5s
>> -> drm_dev_register()
>> -> drm_client_setup()   // deadlock happens HERE
>>     -> drm_client_register()   // holds clientlist_mutex
>>     ...
>>     -> virtio_gpu_queue_fenced_ctrl_buffer()
>>         -> wait_event() // waits for free space
>>
>>Thread B:
>>virtio_gpu_dequeue_ctrl_func()
>> -> reclaim_vbufs()   // make free space
>=20
> I wonder if the deadlock could be cured by alternatively adding a wakeup
> before the responce cb, given that free space is available.

Thanks for your comment. I agree that moving wake_up() before response
cb would help in most cases, and I think it is a reasonable aproach.
However, there are a few rare scenarios where the deadlock can still
occur:

1. If reclaim_vbufs() does not free enough slots to satisfy
num_free >=3D elemcnt, wake_up() fires but the wait_event() condition
evaluates false. Thread A remains asleep holding clientlist_mutex, and
the dequeue worker proceeds to display_info_cb which blocks on
clientlist_mutex.
2. Even if enough slots are freed, there is a small window between
wait_event() returning and Thread A acquiring spin_lock(&qlock) at the
"goto again" path in virtio_gpu_queue_ctrl_sgs(). Another thread can
consume the freed slots during this window, causing Thread A to loop=20
back to wait_event() still holding clientlist_mutex.
3. Reordering wake_up() before resp_cb inverts the natural "process
response, then signal completion" pattern, which could introduce subtle
issues if a future resp_cb depends on side effects that should happen
after wake_up(), I believe.

These scenarios are likely rare in practice, but the schedule_work()
approach avoids all of them entirely by ensuring the dequeue worker
never touches clientlist_mutex. It also follows the same pattern
already used by config_changed_work in this driver.

Best regards
Ryosuke

>=20
>> -> resp_cb()
>>     -> virtio_gpu_cmd_get_display_info_cb
>>         -> drm_helper_hpd_irq_event()
>>         -> drm_kms_helper_hotplug_event()
>>             -> drm_client_dev_hotplug() // need to lock clientlist_mutex
>> -> wake_up()   // never reached
>>
>>IIUC the hotplug notification in display_info_cb is needed because it
>>notifies DRM after updating by the callback with fresh data from the host=
.
>>
>>This work_struct ensures display_info_cb never blocks on
>>clientlist_mutex in the dequeue worker, while preserving the hotplug
>>notification with fresh data.
>>
>>[1] https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e45c1c6e=
549453f224
>>[2] https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf7baf376=
cc873a922e
>>
>>Best regards,
>>Ryosuke

