Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B79CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46EF410E67D;
	Mon, 22 Jun 2026 12:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VkCCYN2y";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2675610E67D
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 12:26:42 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490bc6a7958so40173255e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782131200; x=1782736000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ky0ztwMTGVkkCVwFdAwLamT10MF/bEObQGJBUe16vrs=;
 b=VkCCYN2yayUoRZayv2BJBui2gOfYVd6q033scfHbF9CO18y7WJ/54/F+7HH6USWPIZ
 sxiLkKgtElXB97fcV9++MOJsz5ri9gAjzy4K9YIywH0P9gqSaN1hoG5vDZaxXqF7Du0r
 P5JLxHBA7gnR+O2sTYdFyvFP6FYYAhbvhbZABGWrDcimP7b7niZc1AFz3NngclVMNiMz
 r3ge+LukQq9Ro0IjNIpUjWeSGimGbghjLhdjRsM3EJY9VRC0cNQ37El0EGUQIsOl/IbG
 ImFZw4Zbq8oMFj7CcTcYVPnVdCAtautBTAsU7qY7CdbbsNaoP6I9qFOmi+9gO6bwiauk
 qhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782131200; x=1782736000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ky0ztwMTGVkkCVwFdAwLamT10MF/bEObQGJBUe16vrs=;
 b=n4RBNBspOne2LPU7Og/EUUJprjxXC6oTkXLPR0m8LwebWYSitlixxtSfk+3XbJq6HI
 iP7jak4oJvy271wLklRaenBK74N4wA5V58Pyv8HXBUFI3rBzjkwsbWI0gY2PKu9gjdqt
 l6XhM/8p4p4zqcFipUCZ+tJAOkrKl1xXGP8Xol1twh/qkYam16LjCpjEED/3djUV4XjR
 SVBMpx92l3ZeUA/s5sqflT1BaSCchLNdf73EAanxdNotWxuB7GHAvqFZ3BFsFsiMpkpN
 yimxHEiiAjV03ae4PuEtOIl2kZA8ZkY7VnD6Nf7OvJ6iRlLwfvU360nhTD6m1F7BGjBP
 4RYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UEHdr93V5jK2n41YbHDCuE48iOj6uneFluGnzMvljdhcIPZTb5qHFXf5Qr/WcW6cVTYy0NmIN00E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsZet2oBH0klNd+eVzHmMWqhS90zv5O9m1BGX3hN5AQfcypb7s
 6QsUFLc1O8IMuLxkioOrcFUC2UgjZZCQfYWCSdXZg3XrMlhHyTt/le5P
X-Gm-Gg: AfdE7cm1b3GaOMiYavDJ7a0SB+f0nk8sU2//rqgyXYVqdcs8BH7WFhBtsJXtYnV3m6I
 RGkpEwh30MCfoipOhvJ4yHVuqeZie7QA0wDqk3Y5aUCz/wmLc80Em9ExrygrNqlcFu7dbdQzyf7
 BbxCi/pugi9gFMmmDlt5feaxV7+141lAfAgqeBOo1rY4qo2loTwllDraIGqR1Ww23wQUbWlk04I
 xeQxHocfThtUdVDzai5H70BHh2qt0itSakwvtpGIRxJH9qOc8YgkiXhskPEyGfj0Km646W1or1H
 MrXRr8XJVrqkQur49vSKOfuPXtmQz6bqQfPX/Omqoizjg5pZc6uE2lSnmCj4H+W+KIyckMDQCwg
 TC6q3sphdgp0S2wB1mfVzEPHwTdRYtNFooeB9cMly0eO7ePSjCX7RTbIMoqwg8Cof3uST17nbJe
 plHXTM5Jh4Tin4C8pxJWrZRpg39u57HrnP+xbCfQ==
X-Received: by 2002:a05:600d:84ca:10b0:490:e180:2e0 with SMTP id
 5b1f17b1804b1-492409fbfb9mr129984275e9.3.1782131200325; 
 Mon, 22 Jun 2026 05:26:40 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240ee9bc2sm208803975e9.1.2026.06.22.05.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 05:26:39 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 0/3] drm/ssd130x: fix column and row end address in partial
 updates of ssd132x and ssd133x devices
Date: Mon, 22 Jun 2026 15:26:01 +0300
Message-ID: <20260622122604.32500-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
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

While working on adding SSD1351 support to the ssd130x driver - I
noticed that the area of the cursor was refreshing in a weird state.
I would fill the screen red while the flashing cursor was on the screen,
but the screen wouldn't refresh the entire 8x8 rectangle each flash. 

After reading the SSD1351, SSD1331 and SSD132x manuals and manual
testing on the SSD1351, I was able to be sure that the problem was the
end addresses of "Set Column/Row Address" being sent as relative addresses
instead of absolute addresses.

I assume these bugs went under the radar because testing would usually
be done where the dirty rectangles would start from the 0,0 coordinates.
In these situations, the bug would be invisable, since adresses relative
to 0 are the same as their absolute value.

It is important to note that I didn't test these changes on a SSD132x 
screen or a SSD133x screens, only on an SSD1351. Manual testing is
advised.

This series contains the fix for ssd132x_update_rect, a simple clean-up
patch for ssd132x_update_rect to keep the function clean, and the same
fix on ssd133x_update_rect.

Amit Barzilai (3):
  drm/ssd130x: fix column and row end address in partial updates for
    ssd132x
  drm/ssd130x: hoist column and row addresses out of repeated division
  drm/ssd130x: fix column and row end address in partial updates in
    ssd133x

 drivers/gpu/drm/solomon/ssd130x.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.54.0

