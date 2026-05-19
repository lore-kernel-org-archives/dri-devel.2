Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED73CCD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BCBB10EAF7;
	Tue, 19 May 2026 08:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DNUvMIm5";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A4B10EAF7
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779177638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=3d4rILdlilDFDSw76hiIyNlmPop0Z7DV66rhMlxLZi4=;
 b=DNUvMIm5stfACutOEDTWEfgYvN2yNRqQ11e2S+diBy/7UxzSqxaihV8fLRv2hA7Td79WRJ
 y8apcDUvZr4A3kPbPrXyXb160l94zEgRfnczK1EDPhmuk8U2Aib8xJ7CbJjlyfO7JBu1QD
 t+4LP+nTbmZvVZisk0YE2CVxsk0imfE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-7rKNgJyAPDSzKoelowqX4A-1; Tue, 19 May 2026 04:00:37 -0400
X-MC-Unique: 7rKNgJyAPDSzKoelowqX4A-1
X-Mimecast-MFC-AGG-ID: 7rKNgJyAPDSzKoelowqX4A_1779177636
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bc763c7256so77442215ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779177636; x=1779782436;
 h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gE08M1SuyC2hJeQGP9oQiMi2Xo7VgIAhPzD+PrSXSZY=;
 b=cJOAj48hDTe+Hwrj8+k8XXi3pBOPtQKmHk4LNU22ZfenD1++YXGpq0erFYmBQFaEsg
 3BT6Ms1zck1UloVdW1z9HNhcxfuwyaFk5jdJK1cnGUPuxhoJWNko7473xKWIQY7vMqSE
 kmuAEHjxccTG9Lt+gtZpuRfnxkMk8oft5/jWiH7T5ccOKGxFMPCDgenUGjw1eqifj2py
 rV2qQkSB6yohxAQ5zYjYunwlMBFr250avzC6VnEWqQ9cwFIwIfPu9gCb69YZ4AN4x58e
 7570pUPxaW/YgY9RAfiysR8ldxbY6wWXwyMx7Qr4L66g9cjBgeKwJQoyo/nZwvP7/mpT
 3V3g==
X-Gm-Message-State: AOJu0YxCZ9jg9u8qSBKeWYT3YxDhHwwSSb7KfmQNNjcxVOaoNk79A2T6
 +3sx5YdZQZElLtAT2yGBq433FM9t8G2Qscvlf+73ODsEzp4xg6H/jKQN7T1Yiy1YV3K7Aq2yzRi
 /CCkMcnKqR+GrsK/4fWpla+w4wSzSvTJclCfSQmDaG6bfz0aTSOQ2otssAVJG0zRaJZT0AA==
X-Gm-Gg: Acq92OFqXXoj1EXpT3O88lAHNlcLISN4aIMuZTeS335k+6vNMYZwGmcyavq+4cLe+Mw
 mdgCDN9NnZ37Vwfu1v2Ca2S+m5lQGp7XeafvJcyMMBY7uw07RRMjxXA/2uY5YoQ2Bc0duCzjwgc
 nxLIVNFEBnFwYwzpaOzhGg/2j9Ersf9peu1e3hr9fnRGHkaqoTKv2XFl6u+PKYbzYd+DgeN8NaC
 zgvb53NzFeGLi7ICFjc+6hZ3cuAI3AL+MrpzFyiNGwR5969FiLHND9r9f9ZUHQyYTjgUjrQNIwp
 IXwDge03HTTpRs77zVL5CxWC1kdXKAOCLV0pv/Vz3rdIx3jp8d8WaJkFQEmCvXzbdeU0XE6MXfn
 eHXxoCt/uYJrS7mWL5AVPVW9CaHmDVE1+BT9z5E+4qMCmR7//qxZ3G8LvGMg=
X-Received: by 2002:a17:903:1b70:b0:2bc:810b:5c0c with SMTP id
 d9443c01a7336-2bd7e8cbd1dmr212913165ad.34.1779177636014; 
 Tue, 19 May 2026 01:00:36 -0700 (PDT)
X-Received: by 2002:a17:903:1b70:b0:2bc:810b:5c0c with SMTP id
 d9443c01a7336-2bd7e8cbd1dmr212912815ad.34.1779177635540; 
 Tue, 19 May 2026 01:00:35 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe49a4sm161905065ad.38.2026.05.19.01.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:00:34 -0700 (PDT)
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
In-Reply-To: <70e966d1-ca74-4f5c-8527-9e34ffe19095@collabora.com>
Cc: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>, 
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung
 task
Message-ID: <18b0e8a0fd7e47ff.9be20be20a12ad9a.4495158120858bb1@ryasuoka-thinkpadx1carbongen9.tokyo.csb>
Date: Tue, 19 May 2026 08:00:30 +0000
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lL4PJbyHQ7EPJMbQft1Gam9ek4erB7gSvdrx9oTSZgc_1779177636
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

Thank you for the suggestions.

On 19/05/2026 09:11, Dmitry Osipenko wrote:
> On 5/18/26 09:45, Ryosuke Yasuoka wrote:
>>> It may be acceptable to have wait_event_timeout() in a loop, printing
>>> warnings about unresponsive host.
>> I considered this approach, but it does not solve the recovery problem
>> described above. The guest would still be stuck in the loop with no way
>> to remove the device or shut down gracefully.
>=20
> Could `system_state !=3D SYSTEM_RUNNING` be checked in the wait loop? Thi=
s
> may allow to handle system shutdown, aborting the timed out wait in the
> special case.

Instead of checking system_state directly, I'm planning to add a driver
flag (e.g. vqs_released) to struct virtio_gpu_device. The shutdown path
(virtio_gpu_shutdown) will set this flag and wake up the wait queues
before calling drm_dev_unplug(). The wait loop checks the flag and
aborts if set. This may cover both the shutdown and the unbind cases
with a sinble check, so I believe a separate system_state check is not
needed. If my plan turns out to have issues, I will use system_state
check.

> Userspace may also get stuck in a zombie state. For that, code should
> use wait_event_interruptible(). But driver has code unprepared to be
> interrupted, it all needs to be reworked first [1].

Agreed. I will leave wait_event_interruptible() for follow-up once the
interruptible is prepared. For now, userspace stuck in D state remains a
pre-exsiting limitation.

> Similarly, for unbind there could a driver flag that the wait loop will
> check and handle specially.

Yes, the driver flag described above will handle this as well.

Best regards,
Ryosuke

> WDYT?
>=20
> [1]
> https://lore.kernel.org/dri-devel/20260515084030.21986-1-kartikey406@gmai=
l.com/

