Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5A8C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B31D410E582;
	Tue, 28 Jul 2026 14:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="gvKUagFu";
	dkim-atps=neutral
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4E2610E582
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:39:10 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-496b4cc049fso8540795e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785249549; x=1785854349;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0XSJlAL0oJRgavLZJ2pbR+4e0/apKArSpd9q4NmNpMM=;
 b=gvKUagFuGJvXGxoBnej9Mh5TvZLEmDc+AQSHqXUvkpSSD34NxHWQmTQiGNlrKORllI
 /Tgp8q1LAj1u7xTH5NLYW/ms9ky5J50Rar0H7BfWorJiLFXkYTJC/nz0AK1X8QbLF5WJ
 kPSpNqy+AGIo6ppxAJQZNB+f3qYR2VYqapsgH9xtNUMx/UNlVuF/ACpM3hlen0qvBArt
 RTVNX4C1G0F1ooRi2QMMxXWLx0wLd4dyW1kUpr2a1L2DOtlYofth1ASysi9TRXDGj+Hy
 QM6QF0xZUBquOQQqXR4NZbTSOXZQ+DTRVXc6zvPyTv+X03X+792HXNd4vJtpTabzjDgi
 8irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785249549; x=1785854349;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0XSJlAL0oJRgavLZJ2pbR+4e0/apKArSpd9q4NmNpMM=;
 b=Gobdc+AGyfnKpz8es4rY2OjcqumyFkRIkAS58pZzhUYFim8FXhMh1JLYwKcbF1BPra
 iFPvWSf8Jgstlnwf6j2uxvu+q0bP9dew/KoeGXwXxiizYTQWAH/OPurT37QF1RUrMS0y
 aBVpJxIV6jFsHdJaDisM5hqK4ccoijeQHQ+JRM5bdHv1ku8V7JxiVfb9EiYW4kpjk7y7
 r+L+7na7ssHl/X5ln1q5E13C0zeTxMNGqrXowEPQB5XMZy4F1Vn11ieQyYcynlb/yjA8
 drHNVOG5vWFkPTEm6waAuBj7tty0aHVOxgvjKf0Ln2TmKFhyrEpPehnI9tUnRXzP+m/7
 tQrg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrnw3u+TTg7AnEclqibOv/CmyySsnvEF5idHkh2eqasix5si6DWc5Wsqsi0oZRG5E6xj+teoTTYclg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9VU9romvx1Hbo3a5rvbhmMFNzVJu7StaWbStCCv5fZQC9pgSC
 zRIVwNWl22WRyfLKxqmXQKnZXZ98/v7TrgBHwlpnT7G1u+JMY5g5HSRsOCDx4btF1UeJ6ok6JVr
 TYA==
X-Received: from wrfa12.prod.google.com ([2002:a05:6000:50c:b0:472:9520:f359])
 (user=pimyn job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:564b:b0:495:4f89:8117
 with SMTP id 5b1f17b1804b1-496c64122e4mr21664665e9.1.1785249549118; Tue, 28
 Jul 2026 07:39:09 -0700 (PDT)
Date: Tue, 28 Jul 2026 16:38:59 +0200
In-Reply-To: <d65b4673-007e-41f1-ad8a-b21c018be3e7@bootlin.com>
Mime-Version: 1.0
References: <d65b4673-007e-41f1-ad8a-b21c018be3e7@bootlin.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728143858.1498697-2-pimyn@google.com>
Subject: Re: [PATCH] [PATCH] drm/vkms: Advertise PREMULTI blend mode
From: Pimyn Girgis <pimyn@google.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, melissa.srw@gmail.com, 
 michail.tatas@gmail.com, mripard@kernel.org, simona@ffwll.ch, 
 tzimmermann@suse.de
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

Hi Louis and DRM maintainers,

Now that Louis has reviewed and approved this fix, could someone please
pick it up for the appropriate branch for linux-next?

This bug is currently breaking one of our syzbot managers, so getting
it merged there would help unblock our fuzzing.

Thanks!
