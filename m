Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83841CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 06:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0FF910E5B3;
	Mon, 18 May 2026 06:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YO9wDGjw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6999D10E5B3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 06:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779086722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=lb4D9I8LCWFY3eDV+BXkeQ/GVQwuSR0y7Ch7qCZIx6o=;
 b=YO9wDGjwVbHF+VLOoxgxGHUW1Gk0H80MvCABjh1WRY3nSVH4pz/JTHbamcolaTZuGg0Vo9
 5OqB/wMxrKMRM2uLBEhALpafqceIfsZC3Urji9XXDiK0D1MV45IlrCv4hmJLdONLvs/Eea
 +LxA7KdmP5VAfsuKSydSKcinoiPsu3U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-h5pfrFGGNLmeQH880MMnkQ-1; Mon, 18 May 2026 02:45:20 -0400
X-MC-Unique: h5pfrFGGNLmeQH880MMnkQ-1
X-Mimecast-MFC-AGG-ID: h5pfrFGGNLmeQH880MMnkQ_1779086719
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-367bb9caa54so1666983a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 23:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779086719; x=1779691519;
 h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nIbbyJCYg8R6Fd/O6iKvRYV24FiZuro4jX0wJ+biCCI=;
 b=gpqS/qp8+MatBRdMLKZDRBdlIpYF+kp2+OoP9eF4I7vsW+shhH/zrl9lGrihdKUgwF
 3ydTaLfPa17OKPmy4Rp+J9cIcPm2Q056ynBxotNp7gRIIlNkF3oQkBRxipRNXEtGl8L7
 VATIHRaidrZTDNcKczdsgkqsvq+D6yUPV4AOAfqAhxpXYD4huSoq6JAOUNVBcd0ipOxJ
 sW8zfEOYkO3LQFEutNdLL7KbW+kxm/65EQYgYeEImqMvZNJXGyYFez6YDPvKOuJz8X/d
 AbSaR7IleWmWBWlo73YqTzPeDxsADeN8/EEwckhAPWJThlDPI6AojmxNJr80biyZFD5v
 +snA==
X-Gm-Message-State: AOJu0Yzk7gsldLxg81Pmpry5/dL6FDDP0geRiKY/0OV9zX8+RCg++HUM
 nWMU99mUyvc4pVcyw/KobJsb5jiL98mYlCzVdJNhU7BEJqQuVVOPl21nxqsgyw/diokWRW3U4tV
 ZS0QTJD0BaA761u6+wobcLSgnASn4osodKv7+KpEdlmJCkUrEHp31QSC8sLIN1WBtl4HIyA==
X-Gm-Gg: Acq92OFRTDrYfvmlPHOjDhluYNS8ZlVTDJc3KjIHhNvkRogh7R2w6fwnwXxNTPtQUcE
 xVuCcgyeHhG1K0CWmehJLc2jHZk6s/bACa0lVe3ybK9EFIugV0fGr2/ZD5+etDPKKheUYM9lu/s
 LRfMsvQ/w+TiNCE9QtUPdBRNf87hO/eEIUPfvTPJspnDBNz1JM/qqZMgf57aWCRCvRI+JYsvzuK
 AGmHGK4ZANAQkr7llPXaXs13hisnl49q/7Cze5MpkZMIvTfIA4gDftvzUefyFotw50CNBAJ5pdr
 Iumbnhswmn2hmoMMN/yJChqMcb6OGeAVMZ9bGE4dNVaFvM3XwMKl88lPM1NgqbxAp7lX0ZSAESO
 SafP2TCC/p6NHGTap+MgZ7SQ+PIJ8+b7lWrMpo18uVkpTnOqibE9FK0hhch0=
X-Received: by 2002:a17:90b:57e4:b0:367:b819:2214 with SMTP id
 98e67ed59e1d1-36951b82d4dmr14013359a91.13.1779086719376; 
 Sun, 17 May 2026 23:45:19 -0700 (PDT)
X-Received: by 2002:a17:90b:57e4:b0:367:b819:2214 with SMTP id
 98e67ed59e1d1-36951b82d4dmr14013324a91.13.1779086718859; 
 Sun, 17 May 2026 23:45:18 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695a09e95esm3849670a91.9.2026.05.17.23.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 23:45:18 -0700 (PDT)
MIME-Version: 1.0
From: "Ryosuke Yasuoka" <ryasuoka@redhat.com>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>, 
 "David Airlie" <airlied@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>, 
 "Gurchetan Singh" <gurchetansingh@chromium.org>, 
 "Chia-I Wu" <olvaffe@gmail.com>, 
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
 "Maxime Ripard" <mripard@kernel.org>, 
 "Thomas Zimmermann" <tzimmermann@suse.de>, 
 "Simona Vetter" <simona@ffwll.ch>
In-Reply-To: <8a986c52-964f-42a5-b063-fbe2b242ca36@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung
 task
Message-ID: <18b095f06dafb7a0.57d57ad28d13539f.2240916b4a5459e2@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Mon, 18 May 2026 06:45:12 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bnWgwQfTFnwbMR9UK3AsH07-IXLm7ldt8auWsaKF2Mg_1779086719
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


Hi Dmitry,

Thank you for your review.

On 14/05/2026 00:54, Dmitry Osipenko wrote:
> On 5/14/26 00:40, Dmitry Osipenko wrote:
>> Hi,
>>=20
>> On 5/12/26 11:59, Ryosuke Yasuoka wrote:
>>> virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
>>> wait_event() without timeout when waiting for virtqueue space. If the
>>> host device stops processing commands, these waits block indefinitely.
>>> Since callers may hold DRM locks, this can make the entire system
>>> unresponsive.
>>>
>>> Replace wait_event() with wait_event_timeout() using a 5-second timeout=
,
>>> consistent with the existing timeout pattern in the driver. On timeout,
>>> clean up and return -ENODEV, following the same error path as
>>> drm_dev_enter() failure.
>>>
>>> Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.=
appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?id=3Dd6dd6f86d3aaf7eebe7406e4=
5c1c6e549453f224
>>> Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.=
appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?id=3D908bd910da5dd79b88de4cf7=
baf376cc873a922e
>>> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_vq.c | 20 ++++++++++++++++++--
>>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>=20
>> If host stops processing commands, this is a problem on host side. Isn't=
 it?

Yes, it is. But the guest has no way to recover from this situation on
its own. The wait_event{,_timeout}() is inside the device critical
section between drm_dev_enter/exit(). Removing the device via sysfs and
graceful shutdown call drm_dev_unplug(), which is blocked until the
critical section completes, so they cannot proceed either. Also, IIUC
the virtio-gpu device cannot be hot-unplugged from the host side. The
only option left is a forced reboot.

> It may be acceptable to have wait_event_timeout() in a loop, printing
> warnings about unresponsive host.

I considered this approach, but it does not solve the recovery problem
described above. The guest would still be stuck in the loop with no way
to remove the device or shut down gracefully.

> Don't think we can assume that 5 seconds is enough to say that host is
> busted, unless spec says so.
>=20
> There could be a driver module parameter, specifying the timeoout. This
> will be acceptable as user takes responsibility for the special timeout
> behaviour.

Agreed. In v2, the default behavior is preserved (wait_event, wait
indefinitely). A new 'timeout' module parameter (in seconds) lets the
user specify when to give up. When set to a non-zero value, the driver
returns -ENODEV after the specified duration with a warning message.

Also, I'm considering proposing a host response timeout in the
virtio-gpu specificaiton. If a spec-defined timeout is accepted in the
future, the driver could use it as the default instead of relying on the
module parameter.

Best regards,
Ryosuke

