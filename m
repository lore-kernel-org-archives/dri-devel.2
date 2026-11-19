Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D673606A330
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MIAIOebx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB3610E1B6;
	Thu, 19 Nov 2026 12:55:52 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E64B10FDBD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:55:47 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so17424295e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 04:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795092946; x=1795697746; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A9m0MKy+gVN2zLdhjCiC0ZccLlxnaGGI2IAP9x2u+h4=;
 b=MIAIOebxrGeKzzKsEg3x19XS/vQ9CndBab9F156Bb7cSwzeIqJ/EBLKCSTsAhE6zCX
 8K4wmKb4NgWUl+MY8xZVIsj0tR5GJnw7vW5f9d7katZTVwR7mqqIRLyzpWR0jnbT8BZb
 XQoejO9unjYQly9H73L/HqrUHhcgT5rvKqgDc5oVy+PURolcBQHru6rQGcUpzTAYI8G3
 IpjyOzPY63GtTe39NOM77pZzq73d6dl3JJRxivTNkAipJ6DIEaAZDlJM72RGqV9bnFAf
 /vmqa7N0Bneh0RB9gPDIKBva2dyLUCTF7yVK1lYHeQWF2TdXgHRA7Qnord/JZBch9kEK
 ARQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795092946; x=1795697746;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A9m0MKy+gVN2zLdhjCiC0ZccLlxnaGGI2IAP9x2u+h4=;
 b=eAM3nkyITkV8EdlY4m6ND5RYgSmMvIuOedz/zFWiLHdGeAHxtiQWfvQ0B47iEDT3j7
 80dG6I6t60/PMUW+AuoEq8MaTVJU1GKyykdgTsJ9xGZDFSah+a1twewqFMujdBWTN2mQ
 Z0TxD/7jyjBzSI4o/Q5R4GmmjYoXS2hfEc3SngMohHexB3mjEp8tVQV0R6k0jFXpIpQ2
 ZCIVHjkzAhktEMJBYlDjBQB/k/BiZylWhxf9BcQjjIbbp8W4wrGRqK8iOCOvePFj23gO
 6e2zt/pzahp/xbLR7nZTwD7dv9ZJ3YYTGyjCgoXEQxiDORh3oYZTic85Ri467FeOAmiZ
 3ZqA==
X-Gm-Message-State: APuU4Z8iwTlEI/CzpWO2X7ktdF31imJFKlF1gd5c9lm3uflxFobNirjm
 VopMLsxy+aM+HxpkZ5FUxUVcVCMwQR+7vb6tO/wGAamP8jF5BiygZCje
X-Gm-Gg: AYBFou33mUh3Phb7x6qyX6EmAtaHj51F6kgrGaJ5Y1dp9F4hjcZlDiwtxq2rVRy1pFp
 iK/ZfelcSTuMtTqGOEE415kwJxlfmXTGN9YlzmaaO3xG9JvwIXW/ojqO3N1aHfLXb90ujDIXghE
 X6hVzRI9NLYDuzCDZJRDZmtPqgLbruEPWOFtz3+6MZHLkDKfEKTD3ULY9G2VQDaMagF7Q0GjU5j
 iukCVvyY7WUlSrlrZMDhO8K+ZCL18c57T5XANyr+PXfnESrbFibqZEgnqFUfVN8FRGIDBCT4rTw
 zbq8BNxDhhSzwf74CwB5MWfUgnGo/VH4o1e2dkR3Kwt2Tl4dPFCWcds+u6tLVZJgm6jYL8BfeNy
 7ahDnX6Y6Wfuw5AyaNwIgVc1yNgPNenPwHkMcn+r0zKoZAO37Be+qPGYGP0CjbIwDxiVCdzXWGx
 5ihX+qys18hiIXol38AUx6kE66kKLIhd/SsbI1TqiBOgUnjAUe4EZOWPJJF7YUEbSsRvNV6JmiL
 CMxv/xfYpPgKZeazZ/eAyGqj8Lt1fm32dKjC3pNR2COYPaKkvOHR2HDaGe9b8KtCLthy7mOkgkZ
 t8wnpC9tuAMqTB9dibLEByJHUOwNljAZU31b7jQq1EmGGY09c8qiJ/2r+/JC0R8=
X-Received: by 2002:a05:600c:4e02:b0:4bb:6994:abf0 with SMTP id
 5b1f17b1804b1-4bb7da4b889mr120201855e9.23.1795092945486; 
 Thu, 19 Nov 2026 04:55:45 -0800 (PST)
Received: from [10.111.176.198] ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a650d2e26csm10198193f8f.4.2026.11.19.04.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 04:55:44 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
Subject: [PATCH v2 0/2] drm/vkms: give every composer user its own switch
Date: Thu, 19 Nov 2026 13:55:25 +0100
Message-Id: <20261119-composer-v2-0-a935e9bae6be@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw7CIBREf6W5azGFCBFX/kfTBeXRXmNLA5VoG
 v5dqFtnd5IzMztEG9BGuDU7BJswol8KsFMDelLLaAmawsBaJmgJ0X5efSkRraVgLad80AaKvgb
 r8H1Mdf2P42t4WL3VfjUmjJsPn+Mr0er9mU2UUCINd0peBBfueh9nhc9zEaDPOX8BaSLoc7IAA
 AA=
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

Split it: the switch belongs to whoever took it - each writeback job keeps
its own record, and so does the CRC source - and vkms_output keeps only a
count of holders.  A get() raises the count for the user that asked, a
put() lowers it for the user that took one, and the vblank reference is
taken by the first holder and dropped by the last.

Patch 2 keeps the lock over the count and the queue, so the state the timer
read is still the state it queues.

---
Oarora Etimis (2):
      drm/vkms: count the composer users
      drm/vkms: queue the composer work under the output lock

 Documentation/gpu/vkms.rst            |  5 -----
 drivers/gpu/drm/vkms/vkms_composer.c  | 39 ++++++++++++++++++++++++++++-------
 drivers/gpu/drm/vkms/vkms_crtc.c      |  5 ++---
 drivers/gpu/drm/vkms/vkms_drv.h       | 31 ++++++++++++++++++++++++----
 drivers/gpu/drm/vkms/vkms_writeback.c |  6 +++---
 5 files changed, 63 insertions(+), 23 deletions(-)
---
base-commit: 97429bac371273886238bfcf63d78e7405cacb46
change-id: 20261111-composer-cc9620515bcd

Best regards,
--  
Oarora Etimis <oaroraetimis@gmail.com>

