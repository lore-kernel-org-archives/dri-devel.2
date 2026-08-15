Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB8BC5DF70
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA48A10E5EE;
	Sat, 15 Aug 2026 20:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jiTwSg9L";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD09F10E609
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 20:25:31 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4957799b92fso2739175e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786825530; x=1787430330; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+ZlAyzPLsV68fOC9YLcWPEXPgYOdEPUukx8GNRQ7w8g=;
 b=jiTwSg9LNdtzNtmaFKSyaAZkxPUqs24apWBa8SgUi2/PzQWXJiJJnNnr3Y0zEPNoe9
 4ubqU2c6bJPFIk3zv79N0FW+cV2RY5gtt8EKGe2hEDoP/E6GtPH25Xg7Hbugk8OjoZsH
 F87gcbXfnmGDbldb40A7buhHwhQvosz12m32AisQKjtIj3SNXPxTUowaAGxddIGH9SE1
 kkzmWYct3maGiYP009qLikSOH57WSk/5JLBm1tFBoi46bbUKHZguOs9bMZ3xJqkAAgSr
 RyytnmEtm3QL4J2OssErgtAZZWVj900lkfPKMUgYw8tAOYKPt+P82tOcX6szzq7FupGb
 DtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786825530; x=1787430330;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+ZlAyzPLsV68fOC9YLcWPEXPgYOdEPUukx8GNRQ7w8g=;
 b=pyf3G8r/ycSt1bQXARPg0GHZt0d4GX8U50lZZktseedug834V3FIox8NXlyfvAdQbQ
 sVgeEfLEkSu6Yw7y9e0RarOWckNehyawK2qcszkLCb8faQtdlI8Ay5PE1gUfSOgl6yet
 2lH52GeNbtIxe5sa6en7qPDC2X9exdRj6GLfLhgKJ4kUQa3AftBsJpVIxihPSHBh4x0j
 vM2S/pnBBegwWYH+OeqBHuOtXh72yH4UN1hZjPwtps1+4lWEsZzVXW+Q57xfz9ooY6jv
 LVLZHVi2AaF+z7AY5KAm/ET2la7Dqu05fXjRRX8V/W3yZm8FY/l1HtvHbna5h3wNfDcO
 BoWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RobW/xzErYPWsaQH0n4MoS9w4IfRhqI5Lb3TdwRRzvz015gCA8S0IvIj5T0Gzs7ZTddaBiaSIQ+De8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZXoUH2SjkAB1kr8PbAltasUm6hFSezbRUQJOLxH2x+I9PBCNl
 UBG+wSM7r/MU9Whlcc3XSKnxowEKMpCpocAy2hUoGx22U6WVZ/bI5/XK
X-Gm-Gg: AR+sD119ktAV+1SMVnHE6UiQnUZbpVb7sp9S39FqZDuZcdGyDQk6JmonHwfVuxcgyQW
 BXLgrA9uCQaCT2BvKNltr5rQhVU7KK7jS2CqCkADWlKbcdNXUdHDDarFHKKSOsUbbfZj/lN80eF
 y+tqKzy1oqDd3hODU71xZEtcUx3nFjmoxJumZg0zlyJl1N9ieeP+FX3tcOQS+kHUevgCst6vo+J
 8tjCICzcEIYUA729fNBr4UtjxwZUZ04+JR6+jykC2lDKxkyBYa5EUfy8EAyOtKxllbjB4CKPHkY
 puRWWsTI0i+5PCTHVa3RtnYyVueI5JyBY9aFWTMYs7j2phaAyTSoeaQqL+CCatZyHzl/F2JSp33
 ThR6ex1kHmwmibF0fR4wmG7s/ytlZybYm6Y/sM7AZHCkN9UBITRFZThQQZcXD809O8HB/UIYxrM
 4mqn2ezQDRD2n4UB0x7xNBI45EekqMGooEwkYwROVllrHvuSU4guovdwgNJCWJ2Lj71NsAgWTlF
 0oa4MLU1ayFNhnHMBNNtA46oM6PylHW1cV+DjByY485hLbJs+7i
X-Received: by 2002:a05:6000:60b:b0:47f:946b:d3fc with SMTP id
 ffacd0b85a97d-481607a9661mr9883130f8f.2.1786825529846; 
 Sat, 15 Aug 2026 13:25:29 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1fc2sm19576914f8f.20.2026.08.15.13.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:25:29 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: sashiko-bot@kernel.org, linux-kernel@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH 1/3] drm/nouveau: destroy the fence event before
 cancelling its work
Date: Sat, 15 Aug 2026 22:25:28 +0200
Message-ID: <178682552848.3774290.16460050233438707000@gmail.com>
In-Reply-To: <20260815200914.8A1131F000E9@smtp.kernel.org>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366002.3748010.12779628082366287968@gmail.com>
 <20260815200914.8A1131F000E9@smtp.kernel.org>
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

The bot is right, and this is worse than a wording problem: 1/3 does
introduce the race, it does not merely fail to rule it out.  Please
do not apply 1/3.  2/3 and 3/3 are independent of it and unaffected.

What I missed is why the old order was safe in the first place.  It was
not an accident of ordering, it was load-bearing:

  nouveau_fence_context_kill() signals every fence on fctx->pending,
  and dma_fence_add_callback() returns -ENOENT for an already signalled
  fence before it ever reaches __dma_fence_enable_signaling()
  (drivers/dma-buf/dma-fence.c:707-710).  So once the kill has run,
  nouveau_fence_enable_signaling() is no longer reachable for those
  fences, and nvif_event_dtor() afterwards has nobody left to race
  with.

Moving the dtor to the front puts it exactly where those fences are
still live, so nvif_event_allow() can be in flight on another CPU with
nvif_event_constructed() already evaluated to true.  There is nothing to
serialise the two: nouveau_fence_context_del() takes no lock at all,
enable_signaling() runs under fence->lock, which for nouveau is
fctx->lock (nouveau_fence.c:218-219), and the dtor cannot take that,
since the nvif ioctl may sleep and fctx->lock is taken with interrupts
off.  The window is then held open for the whole of cancel_work_sync(),
which can block arbitrarily long.

So my patch traded a narrow re-arm window for a wider NULL-deref window.
That is a bad trade and my commit message argued for it with a "guard"
that is a plain unsynchronised read of object->client.

The re-arm problem the patch was aimed at is real, but the fix has to
keep the kill in front of the dtor.  The obvious shape is to move the
drain to the back instead of the dtor to the front:

	nouveau_fence_context_kill(fctx, 0);
	nvif_event_dtor(&fctx->event);
	cancel_work_sync(&fctx->uevent_work);

The kill closes enable_signaling(), the dtor then stops the handler, and
the drain last picks up anything the handler queued on its way out.  I
want to convince myself properly that kill-before-drain is safe, rather
than send a second version tonight on the strength of it looking right,
so I will post a v2 once I have.

Thanks to the bot for catching this before anyone applied it.  For what
it is worth, my own review pass had found the same mechanism a few hours
earlier and I mis-filed it as a wording problem in the commit message
instead of asking whether the patch itself was wrong.  That one is on
me.
