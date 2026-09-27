Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAD4C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0766610E82F;
	Mon, 28 Sep 2026 08:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eTOxx5Wm";
	dkim-atps=neutral
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C6D10E0C2
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 04:09:18 +0000 (UTC)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0d2c37b0bso529043a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 21:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790482158; x=1791086958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2LjSmy5wQ+RbKF7JAhK6ovvEPU2UEhSF5hUQSR7JJEs=;
 b=eTOxx5WmgH76mLxBUlztb50Ce+Rzt0R0I/ZGSiOa5jdZ8cHquFYi6tC5+M1FwPr57+
 ymQxd6Y0lmN/QnUcFWtoEmVDC84webNyewnnORS6NfFASSizwnB9e47Fllu/2J0h1oUA
 /k21AAA7yrjRVd42CLy7dHgP5E3WhUweXFFJed7igkZhMUPjwk2TYXA5K4dEizLwY/qj
 ctFa9p0JbO84q9vBd0du/nNVfJqeh99MbzsStvkf43gq8wxgV2qDwL6DeD8jp+TeZ6nz
 zORvcYK9IvWn/0GeJHTyMmDXd4c3zDb5T/5xVD5bXpLo/G0taHVdCJmyS9UMUWx8OExF
 wYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790482158; x=1791086958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2LjSmy5wQ+RbKF7JAhK6ovvEPU2UEhSF5hUQSR7JJEs=;
 b=0hmMvSn+9sqjhbs9RRBb8hW0VhZ3075JhBIRhAbSjL6tilUSNYWnfERLDOnCRVQaHK
 d5UiyQxe/jR+A/IiQfdqbCEmXJbHMy9MvVhHEsIQDtQLSD5SQ2oi2Ad/qMEucOKhXfNI
 uJ+imRXuaScWaxIHyZPfJPICinYjyvU3PNNuJtFfNfuqVebcDLznjTKKQBo8Gj++HVwo
 ZZNgkadjxGOgMz+FQAENtWl8wfkhygTPriiTpF5lzhqvAscg5ZOP2LlFVk+Z1b154gtO
 BBBm3fS32tpOhZuG2sFXCNwYea63rD1/2FhNmwGgaiYVlho3zNQJCNA4o+sJRlWe6EJt
 xC9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhR8gPgE9wQNFqnBgUazA/GKBA+DDkvWZxWjyThUgvk80Al5bfDpNSnBZaIWBE15PUAI/d2PsblMY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYINaw2Om0gYdmdfAtVC9dtq+cT9cVzBxxFQ9lQpZ8g8qjoWdrgX
 mr0jyhU4QLrcVxGvmIs6fOqg9L5737NXifBYHOGF3In2SZ/KcgdqjO7P
X-Gm-Gg: AYBFou1b5YpJfoK4p79lVy2sI4pKyh6VWcMOajRbcjl5UmyTxhP/rWFFLHfVNSeWYKZ
 IX8ps/R+IEAa1ylq66ObuhVdH8kaEs5bEySeKJvMs/tTE33XDPJEn0DeK4XCjBv47N+EpTRuizy
 230rY8Gry4G/yDZMWrzCgvqvdUaMK57Lru6IgcBK9bMpUfanoxEc6edcZRKj/A/tmFKeI9+luhk
 wLlUpritHyf8T9fXt6aIalQ4uiz0SG/jjrrNcieMtQA7pqlBTRF2/8iz8ojMj40OfuUG9EOIBU2
 Zd5HFuKonyXzyy8LctrnIuT7xYs2o9DwUfySaqYYoqBInZ1XGcd6Hub5SmGsSSaCsccrf5szXbU
 Xt8aJ0ZRNOXYFQfzN+au5ANp/yBDmcRhke9CpMgn/BrMZ3dxCIIcRKCCXC6Gxe9vnGXnKrSagFE
 zSJR/03yxDd5Gn1H623iL51uRud7VBCsNt+uzlbgUMDdzDPfhpaA3a7MS5Wy+gneGXBiYpHVfMC
 CVUAxATIaXqiSLZ
X-Received: by 2002:a17:90b:5107:b0:3a0:d823:c750 with SMTP id
 98e67ed59e1d1-3a0d823cb37mr3049456a91.49.1790482157721; 
 Sat, 26 Sep 2026 21:09:17 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:3a0c:2ea9:4ab7:bd1b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09766210bsm18717708a91.8.2026.09.26.21.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 21:09:17 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH] drm/virtio: share one vbuf cache across all devices
Date: Sun, 27 Sep 2026 11:09:11 +0700
Message-ID: <20260927040911.15181-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927000323.299-1-hdanton@sina.com>
References: <20260927000323.299-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
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

On Sun, 27 Sep 2026, Hillf Danton wrote:
> What is unclear -- why is kmalloc failing to work in 2026?

kmalloc isn't failing. The failure is in kmem_cache_create(): the driver
creates a dedicated cache with a fixed global name for each device, so a
second probe while the first drm_device is still alive (release is
deferred by an open /dev/fbN) trips the duplicate-name check.

Your question made me look at whether the dedicated cache is needed at all.
A vbuf is sizeof(struct virtio_gpu_vbuffer) + 96 + 24 = 216 bytes, which
lands in kmalloc-256 anyway, so the cache buys nothing over kzalloc()/kfree().
Dropping it also removes the lifetime problem entirely and needs no
module-level state.

I'll send a v2 that switches the kmem_cache_zalloc() calls and
kmem_cache_free() to kzalloc()/kfree() and deletes the cache setup and
teardown.

Thanks,
Nguyen Ngoc Thang
