Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4B606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iDL9+0VC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB7310FA27;
	Wed,  4 Nov 2026 07:53:25 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 292B410FA18
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:52:52 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso169583f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793778770; x=1794383570; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RkebxhepJ78TZB3fnHTnhlAKTz7Sll4zIjTAt/wCAtw=;
 b=iDL9+0VCjoJfWQWe00+bF9rSHaTSK5RHgEBpKSREP5jT8lbVvshnUiOWTJ94Mog5Fs
 grxBltxKe1VfogI+2PaxqhKA593jrCtF8H9m6bR/2EovXf5th43PSGatKgwAmOzTV6EM
 ke1WzIzSMJxpdyRJKQfEn9OO/O2vML2kATYvZMZNcxPaI3ZdrMvaLX3QxoMYqZ34WQ4p
 e8hnlWofZWhxSz1LN895jmUnceN/kQjslXrBLGwEFM9usW9+seKWOotrE6+dO6moMpfk
 bVGC3ZqKbWtBw3y8qGs816LLQpxrut6REoErqoDfXETUeA+SDqtyk1mtAApzJVRToH9E
 EwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793778770; x=1794383570;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RkebxhepJ78TZB3fnHTnhlAKTz7Sll4zIjTAt/wCAtw=;
 b=BF37c0tHouCx40a8P9EO1Zs4lN4o2dZhMDGHXIF02zJAP7kiExPmSajPoqtN6G/XWM
 wjiOvI0MLWll9p8fr5F49HbM/VXEiy82uAoOQJzkGVbvWhzp2evZyIuwGriZ3qf10Sbp
 Icb4csM7yl/oX24+IESHtEMaNbZfkKbffAMPwccY3rHWOFpeWKYX4wyCNjVNtJNYia4E
 Rr6ini7U8FzI+iwfmNb99M+/fLsX/aR64p1AVm+w55Oluk6bXXKSP3Ymg/7bw+5d7U+y
 yw71ih0ooU3ORXRIw1IwW7ecuFMc17gjRgUebPtyZ672IYQCn0TaAqFyTWRpSlCGf5i1
 QMgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiX6mLaf6MqvdmDpMdx1wHMvkU3ZH3Lpo+BNRHg4Z+1gxf9QlRztBybBtn/ABBn4b2TNpLxdh2RL0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+1vjnWcm0662Moxuz+lnRyHr3uLTaEEhEdKZVzJcnt9e1AlSSx
 fkIozwRn9XEgQLGLCwLEf7mbohWzcAbQyxu+9s/vv6ZsNpv1/XeksXA2
X-Gm-Gg: AYBFou1QkUwlak7dRm7SiE4Vu6deoZQ6EM7c60+BnvzHWlpRa5wnrYpXbPY/fJfe9HO
 bMUz5mvK/HDPbMn4PgjDSwxvrPU0opMdllQNVBrd8NNg3/Ey2sMG8BHiCMWDqKQEptRGj41ih4K
 UJZ2KHoSbf9jqT3WY4POaycZNGQSAgAPuTUAlAxxlBCmkKqvAs0MqfkN7rNsP+nySoEmVZizrnR
 LhETOxYEhVSAMZYK3PcCOknkdwgsPs83QFeq07rp/7deJ5s33QkY58o5fdRaH2Q/OrKOPr++j1g
 0+v6zjH56gRKjvzPniJWsS7XVJ/e8P/Ff9kW/DCK8BTxMop32XepPokf35nQAJ3OiGfxVA4XCgc
 +CQbjOobw8sbWQLR4GCzb7hZuEQI7FwY9MXOFA/wldQKU3F70CmCaeyjrEjj2da+EuXz5MWrDFI
 +KvGKBvvv6cNUfh67aplh12zQOwIujz4N0KtwjRo4Iuk5KeKraWJggN1uJlwHdHj0necVmc0gWf
 j8mq9wJqLHcvb5Ax34PdXQhduVS1ZUbCNlVImur90sJqTtr5awYD2Y0brj8GOk3aQ9RPN08L5Ry
 eE714SBAkz5Q4Qp3kKupo0yPHeSm2hZXifMbrKfYx7/ZZ2d6s7Yal8VJrPjPpgPa7U2H5515U3U
 BZS0qAb6VLRik5DaAMGMlfcVto2DmMwaUGnQ4yDgtRY0DPzhFIYs=
X-Received: by 2002:a05:6000:40dc:b0:48d:fbf4:895e with SMTP id
 ffacd0b85a97d-48e6e30721fmr34220157f8f.11.1793778770275; 
 Tue, 03 Nov 2026 23:52:50 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda207d8sm2200785f8f.52.2026.11.03.23.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:52:49 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH v2 0/3] drm/panthor: Report fault information to userspace
Date: Wed, 04 Nov 2026 08:52:38 +0100
Message-Id: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1gb6EUWvIi6KJhqQVlotgnh3i
 8u3mHkgURRKMFQPRMqSJPgCU1cwb86vhLIUg1Gm1Uo3eDh/biEiu2s/UTwHzAatVa7nrtO8WCj
 tEYnl/r/j9L4fPFXOTGcAAAA=
X-Change-ID: 20261014-panthor-fault-info-v2-330a9f771fd3
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 Paul Toadere <paul.toadere@arm.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Panthor CSF firmware and hardware report extra information when a
fault happens. Two kinds of faults matter here:
* faults raised at the address space level. These are fatal for every
  group bound to that VM.
* fatal faults raised on one of the queues of a group. They stop
  further submissions on that group.

This series exposes that information to userspace, so the
VK_KHR_device_fault extension can be implemented on top of it.

VM faults are reported through VM_GET_STATE. The VM keeps the raw
AS_FAULTSTATUS and AS_FAULTADDRESS of its last fault. Queue fatal
errors are reported through GROUP_GET_STATE. Each queue keeps its raw
CS_FATAL and CS_FATAL_INFO, and the ioctl returns them in an array
indexed by queue. The kernel does not decode the values, userspace
does. Nothing is allocated in the fault paths.

Changes in v2:
- Report VM faults through VM_GET_STATE instead of copying them into
  every group bound to the VM.
- Pass the raw register values to userspace instead of decoded fields.
- Keep one fatal slot per queue. A queue stops at its first fatal
  error, so no allocation is needed.
- Store the uAPI structs directly in the kernel objects.
- Dropped the recoverable CS_FAULT reporting for now.
- Bump the driver version to 1.10 in a separate patch.
- Rebased on drm-misc-next. The queue fatal info is protected by
  events_lock now that fatal events are processed under it.

Link to v1: https://lore.kernel.org/r/20251215115457.2137485-1-lukas.zapolskas@arm.com

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
Christian Gmeiner (3):
      drm/panthor: Report the last VM fault through VM_GET_STATE
      drm/panthor: Report the CS fatal errors through GROUP_GET_STATE
      drm/panthor: Bump the driver version to 1.10

 drivers/gpu/drm/panthor/panthor_drv.c   | 26 +++++++++++++++--
 drivers/gpu/drm/panthor/panthor_mmu.c   | 33 +++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_mmu.h   |  2 ++
 drivers/gpu/drm/panthor/panthor_sched.c | 32 +++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_sched.h |  5 +++-
 include/uapi/drm/panthor_drm.h          | 52 +++++++++++++++++++++++++++++++++
 6 files changed, 143 insertions(+), 7 deletions(-)
---
base-commit: 6f7098738fff3ec7393f924343188cb8e6ebc5d2
change-id: 20261014-panthor-fault-info-v2-330a9f771fd3

Best regards,
-- 
Christian Gmeiner <cgmeiner@igalia.com>

