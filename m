Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20280606B046
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHBPkGQr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90F91124E0;
	Thu, 19 Nov 2026 14:49:31 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7352B1124E0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:49:25 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so33366265e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795099764; x=1795704564; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iJQag5fmr8Xznr8HhT+POicXK/yHDqrGNFeMZ62CJB4=;
 b=JHBPkGQrZ/5Pz+Fe5rMI9fRsqty25sjde9Y3g1pb40zNVSRykPZeMAlZlRDmNueNR+
 Dwtdz3c3kkkmz0XdTUav9ZgNdM0ocZ28nqCRQnRMw2hgP3J6ijPwrSY7psYoGqWgwKzO
 iHfq2sPR86GH3NCpqEcNqJPOjBzikb1vnjyprQYO3xbbmdp4Xn2i0rtnZDvlZcOgsZ4O
 zQdAPayZRdip7MXce/XIkcfkV8KiGAAe3f2zbt3zvGdd5ICsQO3jOoeEgOwn5FEAwUdO
 5vAukHL8an8PhsfYPOPp2niDchzYEa3ysnWkFK4r3EGbHct355FB2/iUFjqkg8pXomW0
 EDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795099764; x=1795704564;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iJQag5fmr8Xznr8HhT+POicXK/yHDqrGNFeMZ62CJB4=;
 b=zfbJ6d8Ae1A4OW3OsiJ0WMf4/e/xheBrd/JuQpRTE9qjReMJkU2n3J1AcHkBBm1sXl
 gPIqSisfo6xGKBprlhzh89EK3lDwfjdKZJx/bPeQS3VFWHi6hK5wdiZEFSCRJGniXPYq
 EWrBVkyrq3/sriTk7MZr6eIpQHoEvnhA5GJTn7fmWbYm8BPEFinENSbTvI0PAEMCrHL8
 6nNYYYW5b6vam1Nmbx5EU3aHH8HKkT8vnlVNItYewabzNC+lFxaNKkUuM0DcSOMAi/d5
 VDcxhT1USNJJHIDNoezKG+Z4r1PeaEe8EMm5+OGDUZr9oLLgXqj12jYG05kkWowXwNc7
 R+yQ==
X-Gm-Message-State: APuU4Z+2KHLTXN4DXTTBgs/V6IL8amLFa9OC5FeGv0hJZaBTDg0aokxr
 pLhcFcIMMmSJhA3aV/E3HgBJSzrCfE3j8be8VarLcIt9yTc3MGnfCBw4
X-Gm-Gg: AYBFou36PDn+ISHigTXfIzt6X7eLffC9vrMu3HoQxIaVvEoDPH53HrRzB9sPKdP4hZ4
 06ER4baYcBatT/Ugf+SEtA8InOoKA9RudJhEkTcoqM2wCSjiemJG/ryZIZ/ZPGGSyjKExX0iZSk
 Dk8rDG8oFWlw1XHqLPtYKrWwlyDyVzabV499uxvkdfmf6Oa8OAg7gxMp6tZXm9Sx+oEpKy4tmTA
 dFPa9pha7KmPBV9R26VKY7BQyTLQEAj008U+m6vuWD6C8nBcPNYNXVfD8lBnXWPNRrs5/PX07s7
 DDyvqCx+iXqDNVFfpHLUw3UKbZ+oxBzRYRGMIrxoisBmQrZNtPkhBvdp1+QK2DNaqWMcR6/A/4L
 juslWj49W+Hat7+gXTpkhOT8hXO0cZ9dSWwarPi8sRP4S2D5m3WrP331GqT3baRYxvAeF1JCI4z
 Yv7CHWMXbVk/XPiZcz3pplIrRYdsZ+4S0+q2IfXla8yu1e/2MpVzoYN9CW20sSk4oJgyVV5JO3J
 ZzdbXPlzuH3rosymSimF57Ttp3tU8qih/39/SWAuMsH6CbMNTu45IFmMXI42Aeozcz2EJZ1RRBg
 eMAlS4TvHOZ3jDK2HNyKTFuLNoXarloGQRfmSFbnP7QsmQdrc7Op49Z4tOScA8w=
X-Received: by 2002:a05:600c:4f05:b0:4bb:73ad:c1f0 with SMTP id
 5b1f17b1804b1-4bb7da21b8emr136305805e9.23.1795099763457; 
 Thu, 19 Nov 2026 06:49:23 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e4df2bsm38881785e9.3.2026.11.19.06.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 06:49:22 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Subject: [PATCH v4 0/2] drm/vkms: give every composer user its own switch
Date: Thu, 19 Nov 2026 15:49:06 +0100
Message-Id: <20261119-composer-v4-0-5973fc9296ee@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNyw6CMBAF0F8hXVvTB63Ulf9hXPQxQI1SQpFoC
 P9uixtidHY3uefOjCIMHiI6FjMaYPLRhy6Fclcg2+quAexdyogRJmk6bMO9Dwlha5VkRFBhrEO
 p3g9Q++c6db58cnyYK9gx+9xofRzD8Fp/TTT3fsxOFFOsnKi1KqWQdXVq7trf9qmA8uzEtlBtI
 MMEa8UFKKNBGviG/B/kCTpXHoiuGOGEb+GyLG/BPc0mJAEAAA==
X-Change-ID: 20261111-composer-cc9620515bcd
To: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Melissa Wen <melissa.srw@gmail.com>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Liviu Dudau <liviu.dudau@arm.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The composer has one switch, shared by the CRC reader and the writeback
jobs, so either of them turns it off for the other.

Split it: vkms_output keeps a count of holders, and a get() raises it while a
put() lowers it, so the vblank reference is taken by the first holder and
dropped by the last.  The CRC source takes and drops one per open()/release(),
which the core always pairs; each writeback job keeps its own record.

Patch 2 keeps the lock over the frame accounting and the queue, so the state
the timer read is still the state it queues.

---
Changes in v4:
- vkms_composer_get() returns the error from drm_crtc_vblank_get() instead of
  a bool, and vkms_set_crc_source() returns it, so a failed take no longer
  looks like a successful open followed by a put() with no matching get().
- vkms_crc_parse_source() failing now returns before the composer reference is
  touched, instead of falling through to vkms_composer_put().
- the kerneldoc of @composer_users no longer claims a READ_ONCE() that patch 2
  removes.

Link to v3: https://patch.msgid.link/20261119-composer-v3-0-dd470a820303@gmail.com
Link to v2: https://patch.msgid.link/20261119-composer-v2-0-a935e9bae6be@gmail.com
Link to v1: https://patch.msgid.link/20261111-composer-v1-1-9d5fa94656f8@gmail.com

---
Oarora Etimis (2):
      drm/vkms: count the composer users
      drm/vkms: queue the composer work under the output lock

 Documentation/gpu/vkms.rst            |  5 -----
 drivers/gpu/drm/vkms/vkms_composer.c  | 39 +++++++++++++++++++++++++++--------
 drivers/gpu/drm/vkms/vkms_crtc.c      |  5 ++---
 drivers/gpu/drm/vkms/vkms_drv.h       | 29 ++++++++++++++++++++++----
 drivers/gpu/drm/vkms/vkms_writeback.c |  7 ++++---
 5 files changed, 61 insertions(+), 24 deletions(-)
---
base-commit: 97429bac371273886238bfcf63d78e7405cacb46
change-id: 20261111-composer-cc9620515bcd

Best regards,
--  
Oarora Etimis <oaroraetimis@gmail.com>

