Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757D606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cC80X1hW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06551121A8;
	Thu, 19 Nov 2026 13:36:32 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0493D1121A8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:36:27 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4a9be758734so449071f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 05:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095385; x=1795700185; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1o95545vLBlL7TyXtLwPVUZGaN8C7nShjfd8XxYNHPA=;
 b=cC80X1hWUkrcusBaNpFHL4ULKrDAt7cz9W5yAKUcFnWYmLZ1kZlfa4We7v80SexrdL
 mCNL1doaXw7QwUxIPiunee88ZDVFmAkUJDIPTScYfY1B5CmKss3FdXfO640nGNwOTfwS
 +/We76flzd30nMS1J7ROcGWGrWFItNE8RqpHjWGNjxG8VaapWlnV3qU1pX5v9n0mjdmq
 Q7Jn0Ciyk4MayBzqgbDFbgc5lq6U9vL8gD+UB5Urf8vu6vjAQigEwUzke5WswCgKYBev
 BSN8z3e0JL7KhKOuv0Mcq1vYZlrRH/Dp8DWIkiXJiTFIfgmMpJoBsFoezyrRlM90eY83
 oppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095385; x=1795700185;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1o95545vLBlL7TyXtLwPVUZGaN8C7nShjfd8XxYNHPA=;
 b=sAoxeml90uRnj+CzwaWUw2kS5Gc7b3BsAPW2e1u30CcmY0aGjHngvajHBOnNiL7vyw
 P0iGzDO2j+86OSVollX4EcE9LRNg/eZ7Xno7gNwSuKn/vwShPV7Apv79fGeswOltTvF7
 BMkWL6DYQY4dUyFQptCG3PKUMtcJVMnnxOxx9DblBmcrCq1JxDmxUQci8xhDMO85HxhL
 yj8MtByMGlXFzvgxDyHhlDzdoi/DpxjaX5cO72IOgg8GqYsIlkRzVt1bjP5wvAywWZwe
 eWQzvQD5t/emIWWX6KpRoVhmvFYc0YKvw8f2fO/eo8647jU95cQaE9F9IaL/yBlzKnNM
 XyNA==
X-Gm-Message-State: APuU4Z/VLHgNPPl02XyEGbD2Loq97AVB2EaJqubVvXjtnvq8eqXgxhjY
 cljdsJPgXuo0oJ9H8Cb7pg6Cxqz6W80+/EtL3yAjC/OvVRvYB5nsLpJ5
X-Gm-Gg: AZFdTZes96j4QxUu+ZB752+8iERRYcueS+UGOke49/ajDQCnw0jgYcJwnJxVrHBC18A
 wWGMRIVzFxS0W3Qgxohw7wFaSEZZirP6CsFzEKGkuQIx4J+6OKhHMvu1pjgD6jfsWn3rAMApGZx
 skHGOtGx/VT4qWt3tbu4Pu5HgVRFEEpFf3vzPJFjuh3YOdmtbg/znZVDVF25Y98LuATzbqJ3tfO
 MCUodCd7gfaON9j2XyeutBArORr6jPhF9qguRiRxAopNXPbur6Ty3sjT4Xf7sr+ZPnHBPpjyRTR
 UwRVqJTF6hNuY+SF5H+X8O4fhw2TEE6+8aOksDnRqwlAGq7PuVn/7uLqqyyq8sNXNJWUdjtXziX
 bfcE5miphMPyvMgCUnJ+RLj7abc3t+/JrzzhBnubgRg10bctrfZ0MR1Qo4DMejMF4z4O3MT+SCz
 nw3JlN0NJeNVkAxuKAT9Tj8jwsZQaGNM5IIETHWbBCi13rYd8y9qR2X5wY6as1Sy/B+ZcASn4rQ
 sVFnzAvSOJ/8/YKdavUrlTqY5tuX2QIinS0U2YMf7bxUk9nsdw8Gou45dRxCnxAn+3T/WWuXRT9
 v6JlKmlq5XTLID8n4Z4llsTIrQOcqaqQBhqhgKNRqA==
X-Received: by 2002:a05:6000:610:b0:48e:3085:7cf0 with SMTP id
 ffacd0b85a97d-4a63ce05ddemr14483518f8f.51.1795095385263; 
 Thu, 19 Nov 2026 05:36:25 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573ba95csm11547911f8f.56.2026.11.19.05.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 05:36:24 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Subject: [PATCH v3 0/2] drm/vkms: give every composer user its own switch
Date: Thu, 19 Nov 2026 14:36:02 +0100
Message-Id: <20261119-composer-v3-0-dd470a820303@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ7CIBBFr9KwdkyhQsSV9zAugE5bjC0NVKJpu
 LtQN104u5e892clAb3FQC7VSjxGG6ybMjSHiphBTT2CbTMTVjNB84Fx4+xyBMZIwWpOuTYtyfr
 ssbPvbep2/3F46QeapfTFGGxYnP9svyIt3p/ZSIGCbHmn5Elw0Z2v/ajs85gFUmYj24dyFzKoQ
 cmGo9QKhcZ9mFL6AqkcbqHrAAAA
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

Patch 2 keeps the lock over the count and the queue, so the state the timer
read is still the state it queues.

---
Changes in v3:
- the CRC source no longer keeps a flag of its own: it takes and drops one
  reference per open()/release().  With a flag, a second reader skipped its
  get() while the first one was still releasing, and that release then
  dropped the reference for both.
- vkms_composer_get() returns whether it took a reference; a writeback job
  keeps that value and only drops what it took.
- Link to v2: https://patch.msgid.link/20261119-composer-v2-0-a935e9bae6be@gmail.com

---
Oarora Etimis (2):
      drm/vkms: count the composer users
      drm/vkms: queue the composer work under the output lock

 Documentation/gpu/vkms.rst            |  5 -----
 drivers/gpu/drm/vkms/vkms_composer.c  | 33 +++++++++++++++++++++++++--------
 drivers/gpu/drm/vkms/vkms_crtc.c      |  5 ++---
 drivers/gpu/drm/vkms/vkms_drv.h       | 29 +++++++++++++++++++++++++----
 drivers/gpu/drm/vkms/vkms_writeback.c |  7 ++++---
 5 files changed, 56 insertions(+), 23 deletions(-)
---
base-commit: 97429bac371273886238bfcf63d78e7405cacb46
change-id: 20261111-composer-cc9620515bcd

Best regards,
--  
Oarora Etimis <oaroraetimis@gmail.com>

