Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA3606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s5ajHXxy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA2111207A;
	Thu, 29 Oct 2026 07:59:31 +0000 (UTC)
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 289FB10E12B
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 17:46:32 +0000 (UTC)
Received: by mail-dy2-f9.google.com with SMTP id
 5a478bee46e88-3678f64d078so1591211eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793209591; x=1793814391; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OE8OEA2joPPITRGS+av4AQ4EjtvJjhIqiZj/74OJ5qU=;
 b=s5ajHXxy6bnkyjl8CYMes85J8yAYCfYcmCZ6mTAqUunH15eKvKCLbiz0JtLBd25G7/
 FCHpnY0ChWqUx33HytG2kG1bIfxYmv5KKJEVtycIWmd7zyJkjeZgPRAAZiUQUfUPDMdg
 cDBfiXCzlXvpf8rfkL8cIYtDs4QwfgEHwfag26QgQNqMNW65D4Fo2qjjFS/U+A5QKmjo
 jTeJ9heD3bGTP1FMlAKfLEvlj6m6NgLJMg3XxBsHAD2PDYuPdDnVbx1TZNTv+qnHo51U
 Dw1dqK3ezBsLfLikr+Intf6e0Ko4A5+d/ZqYRQ570Ez1HaKv1xaQCjt6nFBxHKBVeBd0
 nH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793209591; x=1793814391;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OE8OEA2joPPITRGS+av4AQ4EjtvJjhIqiZj/74OJ5qU=;
 b=pGjfO6HdyiZbala2j98FSj9EdeR6vRUjpqXiZdJ3kl791AjcDaCegHG18AH1JpWTmR
 Ui5fptNbwOhe4GcFRiPhLqDcZgJy8SrwPBm2Dm8XSZRKfzMN7RW+lErdPspZXlIoDVTM
 Cg71ixCH5aIPVD90uMwzD10kaMNBkf4VYQ5351rydT2t+LxHhzAbYZ0c5xM8+Wk63Fvx
 IgignV6qoCykODt8Mc6p3FdKUqK55iXWps6f4LeoHD07rpOhB2Ond79OeeS9qYAgDhrj
 f1kOridQ04jTKi3OhK7ol59Lufi19eayx2NLufOiG0Z7q5y7qT2Qms4RK02sH7Xietp8
 A7Wg==
X-Gm-Message-State: AFq9FYKAo92cDF0oLfmy+vQiSxP/kI609mV/SU+oAv9i4/wr/fVIG9jL
 hd4TXyZO2vahZ+S5QpJBUMVymUKpVAohEO0Eodylg0LsKQgUrZL66YEi3ud8EhkZvqxiHg==
X-Gm-Gg: AYBFou271XhogaSQyc95rrCzZfdSEp85/SnvDNLB4o4QrhWK9/mMvChb6h6umd/SOau
 Gn9gscWnKowFkeK47YtJa7eoN9Sa8JkVKw/rWoQEVALodAFi6b7sjkEa+SJlyEscBmKP0ghnHKC
 AhoC8a/Y0zZvvfTOW92SD08zA7HHNhtOIhLCzayRHj846kB2OHwUWsWZwJxI73lcGETSZSMsRis
 JvQ1JZZytfQ1sIqpSgvLWYfsqrMfqnASmgLVLrM2d1v7BpVPc4Tjva8HGFEVHejKk/9ja6wYT95
 irf/QuLcFHT3wcWlBwgpZACKegyHXVQiGPCZ99f2zZNYbEX7xq7nTRNjFftID7eiSoWsofzszVY
 rio7GHozl6vD8U8UkGlJHIM9EA53avxw+pQ0x48WXCEvDFNJPtlt1MoiSqpOMKxce6KVjfITu8q
 u+bqlkPgVRa3mksNr2MYcGOyvdIEMlqb8jmCC/ksNbkFRCS9S7sHoUfCw5mQZjK1c5P+nvJlGvm
 dvhN+ohTtrYl6tGjD4XLmUt5oCnxpt1nO1j/XAzOh9THNoJO2GFlOiDVSh3oOCtYrMyxKGqtuDi
 WKK441qDxsFQo9y+mCHcy2j3CH9IRyv34nrJ3sjo97kXmCM6IstNnloTOoOolY52DIZn
X-Received: by 2002:a05:693c:2411:b0:36a:1bd4:628a with SMTP id
 5a478bee46e88-36a203abe0bmr4120169eec.9.1793209590886; 
 Wed, 28 Oct 2026 10:46:30 -0700 (PDT)
Received: from toolbx (2607-8700-5500-3d9a-0000-0000-0000-0003.16clouds.com.
 [2607:8700:5500:3d9a::3]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a237be80csm17883633eec.2.2026.10.28.10.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:46:30 -0700 (PDT)
From: ZiAo Wang <ziaowang2007@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Ho Jie Feng <hjf3108@gmail.com>, ZiAo Wang <ziaowang2007@gmail.com>
Subject: [PATCH v2 0/2] Add support for Valkyrie USB LCD displays
Date: Thu, 29 Oct 2026 01:44:23 +0800
Message-ID: <20261028174425.21704-1-ziaowang2007@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This series adds a DRM/KMS driver for Valkyrie USB LCD displays.

Vendor website here:
https://www.my-valkyrie.com

This driver is devloped from scratch via black-box analysis on
vendor software. Currently only supports two variants, I'm sure
there are more variants, but I don't have them.

The devices use a vendor-specific USB protocol. The driver exposes
them as standard DRM outputs and converts XRGB8888 framebuffer data
to UYVY, the only format device accepts.

Patch 1 was authored by Ho Jie Feng and provides the XRGB8888-to-UYVY
conversion helper used by the driver. It was previously posted but
was not merged because it lacked an in-tree user. It is included
here without changes to the original code, with my Signed-off-by
added as the submitter. Ho Jie Feng is CC'd on this series.

Original posting:
https://lore.kernel.org/lkml/20261019154820.68659-2-hjf3108@gmail.com/

Patch 2 adds the Valkyrie DRM driver.

I wish merging this series through the DRM tree.

I tested both supported variants on physical hardware using the
Sway compositor and verified that rendering, suspend, and reset
work correctly on all of them.

Thanks,
ZiAo Wang

Ho Jie Feng (1):
  drm/format-helper: Add XRGB8888 to UYVY conversion

ZiAo Wang (1):
  drm/tiny: Add driver for Valkyrie USB LCD displays

 MAINTAINERS                           |    7 +
 drivers/gpu/drm/drm_format_helper.c   |   73 ++
 drivers/gpu/drm/drm_format_internal.h |   21 +
 drivers/gpu/drm/tiny/Kconfig          |   15 +
 drivers/gpu/drm/tiny/Makefile         |    1 +
 drivers/gpu/drm/tiny/valkyrie-lcd.c   | 1416 +++++++++++++++++++++++++
 include/drm/drm_format_helper.h       |    4 +
 7 files changed, 1537 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/valkyrie-lcd.c


base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
-- 
2.56.0

