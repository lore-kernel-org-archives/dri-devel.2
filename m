Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CCAC5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5521910E03D;
	Sat, 15 Aug 2026 19:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rNDCyg8L";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367D710E03D
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 19:54:24 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954c08a7c8so1925265e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786823662; x=1787428462; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XKMY3jaHWrX5uq0Uxf4PZXTjVd1WvSfsCCpcygAO8bM=;
 b=rNDCyg8LL9pBW9pZpSFfAVYZ59klv0fy+NsWzrbEPgt4JBcJHUvWLu9wBfPMm0bVKD
 DG6gqVltzgdAoyLsf5DZDPZMOjhMVIde1y/GmcTTLv61AzUrjeAqm6adFT5WWZk9fFw/
 25ugKCwPYasmNQ85bDV/MXQ01vzJHr4qewSSbQmoxRKfTFKxMTbRI2q97G/EwHFCdVez
 TLrm/FUKCkeSwERH++esHtdRNse/dJVYUS8jNROOMi3kh7gRQYEmidrXz1vxo8LA8RAq
 l6S42k84pimAFcEASZPnNBbniQs4G5vIrArPoRtkhXu24AV3QUbPwqqK9hyHMEYB28eo
 /DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823662; x=1787428462;
 h=mime-version:content-transfer-encoding:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XKMY3jaHWrX5uq0Uxf4PZXTjVd1WvSfsCCpcygAO8bM=;
 b=FVMCruVYJ53vtCqRBpEj24c6ccfSbquU4z1yjOk+OKVBb8aJ4/UpCw6Qiez9ATNz37
 7jBCbgA3j1pQD7+n0aTtLE1ZojoXwlItVKOMklQ5+XZrXo+BtVyeS/n8K5GbLzsBv2sa
 hHR2hh7hGdxyHf367ovyOiYEu5r17UQNYslJFM42UwpM9VAA2NPxtiVcWiSHaDTr7YZz
 Dr2d4YRfX4zNnWOA/H1owQ+pJK9M3O81Fa7+qFLSVFUm6ZoyK46j7UR7aLsAJ+613U6Z
 JCfMIYaQMapJxksJr2fHldDo5ETf+sB16S4w1R2JHbTaEtPY8SRHwMQNNXUVfSOx7mmB
 WF9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3cS+8EOzh0dGOXim11cViy87jEhTg5GAmXltAxE8wH5hOwLkxQhgq5/g/RFgAmYn5FuUkzMyhovE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYh5wJwpTJJBWa03fslBTDcK9BZJvEXOHFQQJRA701KKIMQIga
 p4HKcFxCphEajnWvEs4gYYMkRSzp7bAbXWKamnnHzlCY7/9n9XdR4ogB
X-Gm-Gg: AR+sD10nIAZ+abjJYc9TATYYM6tW1l00WUkL62x5ZEup9qVvkqdRvQ7w6uF4o1MEIGy
 QPx+fCxvsdnPDwmSRMC7sl1HDQi478EuQqys3uLdwyzE2QA/y1uHQ/+y5/dbZWTJgvtZ0dWgnlh
 xH+D3X0uFv59jfqUJjEcpqNYyWkKwN0PiodB9/VHRHLRPRmzxFfB5eIeLIqVRZ68Gy1rNSsShAm
 aH0XymeuNImNWxS7EwtKVte26zDb2J76qYJXXpsq5kSKEqpR7w9VjraZGaWkLpzeBz23k0icxnV
 +d11p0iMrx7cH1cLMyc0aYNLluvoJnLNbT1TwVUmlq3389GB85Cb7T+jzan91SI+EsSvwkwncJB
 RmQjsAIg8f6iloC+EtPQ1MCLgGS1fXBzdPTqx0PVj5vfnJYWWTlFC3PedHBXlAzrSMolLkiWrvv
 cLc4GOQ2LICBumZKfmsI6wmXyOv4DDveuEcrAPDQvIiNhcOy5PlZON1D/R7xbLsLro4z/KWONGc
 LBOcwXbGbcFbuGxsGcvxbTpD5VX/1pmMQ6G3ZDQDg==
X-Received: by 2002:a05:600c:1c1a:b0:493:f42e:1b3f with SMTP id
 5b1f17b1804b1-499879a41ebmr109626065e9.3.1786823662270; 
 Sat, 15 Aug 2026 12:54:22 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899bff2csm133743775e9.7.2026.08.15.12.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:54:21 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/3] drm/nouveau: teardown ordering fixes for events and work
Date: Sat, 15 Aug 2026 21:54:20 +0200
Message-ID: <178682366001.3748010.7798811159846779765@gmail.com>
X-Mailer: python-smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

From: Marek Czernohous <marek@czernohous.de>

Three teardown fixes in nouveau, all the same shape: something that can
still run after the thing it points at has been torn down or freed.

Two of them are not my finding. The Sashiko review bot flagged them as
pre-existing issues in its review of my nv04 FIFO series,

  https://lore.kernel.org/nouveau/20260812231330.705425-1-mczernohous@gmail.com/

naming nouveau_fence_context_del() and nouveau_connector_destroy()
directly. It was right about both. 1/3 and 2/3 carry a Reported-by
accordingly. 3/3 is mine, found while following the irq_work of 2/3
into its handler, which is nouveau_dp_irq().

1/3 nouveau_fence_context_del() cancels the uevent work first and drops
    the event afterwards. In between, the event is still armed and
    nouveau_fence_wait_uevent_handler() queues the work unconditionally,
    so a non-stall interrupt in that window re-arms the work that was
    just cancelled. The callers free the context immediately after,
    which leaves nouveau_fence_uevent_work() walking freed memory.
    Destroy the event first, then drain.

2/3 nouveau_connector_destroy() drops the connector's two events but
    never drains nv_connector->irq_work, which is what the DP IRQ event
    schedules. The work can then run against a connector that is about
    to be, or has already been, freed.

3/3 nouveau_dp_irq() looks the encoder up and dereferences it in the
    declaration block, five lines above the NULL test that the same
    function already carries.

2/3 and 3/3 both point at the same commit. Commit 773eb04d14a1
("drm/nouveau/disp: expose conn event class") turned nouveau_dp_irq()
into a work callback, and that single change introduced both the
undrained work and the early dereference: the drm pointer used to be an
argument, and recovering it from the encoder put a dereference above the
existing test.

All three carry Fixes: and Cc: stable. 1/3 and 2/3 are use-after-free
windows, and each commit message names the trigger, the window, and the
freed object the work then touches. 3/3 is a NULL dereference sitting
above the function's own NULL test.

I also looked one level up, since it would have been the obvious next
instance. drm->hpd_work is drained in nouveau_display_fini(), right
after the hotplug events are blocked, under
"if (!runtime && !drm->headless)". That guard does not exempt the
teardown path: nouveau_drm.c:597 calls nouveau_display_fini(dev, false,
false) immediately before nouveau_display_destroy(), so runtime is
false there. The runtime exemption belongs to the suspend path
(nouveau_display.c:781), which frees nothing. So there is no fourth
patch here.

Testing

  Reference hardware: Apple Macmini3,1, MCP79 / GeForce 9400M (NVAC),
  Core 2 Duo, Wayland (labwc). Note for 1/3 that this chip takes the
  nv84_fence path, which is the one where the event exists at all.

  Build. The series is built against the stated base commit, as a full
  kernel build rather than a module-only one, so modpost actually
  resolved the module's symbols instead of being skipped for want of
  Module.symvers: zero compiler warnings, zero compiler errors,
  nouveau.ko produced. checkpatch.pl --strict is clean on all three
  patches and on this cover.

  What the testing does not show, stated plainly: I have not managed to
  hit any of these three windows deliberately on this hardware. They are
  ordering bugs reasoned out from the source rather than from a
  reproduction, and I would rather say that than dress up a crash I do
  not have. Each patch names the file and the function it argues from so
  the reasoning can be checked directly.

AI assistance

  Lyude asked on an earlier thread whether these patches were written by
  a human and pointed at Documentation/process/coding-assistants.rst.
  The answer, repeated here for the archive: this work is AI assisted. I
  use Claude (claude-opus-5) as a coding and analysis assistant. Every
  patch carries an Assisted-by trailer accordingly, and no Signed-off-by
  is added by the tool.

  Nature of the assistance, so you can calibrate your review: the
  assistant did most of the code archaeology and drafting. I described
  symptoms, asked for the mechanism to be traced in the source rather
  than guessed, and asked for each claim to be backed by a file and a
  line. The assistant also reviewed its own drafts adversarially, which
  is how two errors in 1/3 were caught before this posting: an earlier
  draft claimed nouveau_fence_context_kill() does not touch the event,
  which the source contradicts, and it illustrated the freeing caller
  with nv04_fence_context_del(), which is precisely the case that cannot
  reach the bug, since nouveau_fence_context_new() returns before
  nvif_event_ctor() unless nv84_fence_create() set priv->uevent. Both
  are corrected. I reviewed the result, I understand the code, and I
  take responsibility for it.

Marek Czernohous (3):
  drm/nouveau: destroy the fence event before cancelling its work
  drm/nouveau: cancel the DP IRQ work before freeing the connector
  drm/nouveau: don't dereference outp before checking it in
    nouveau_dp_irq

 drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
 drivers/gpu/drm/nouveau/nouveau_dp.c        | 4 +++-
 drivers/gpu/drm/nouveau/nouveau_fence.c     | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)


base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.54.0

