Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE9606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XEkM7F8h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F646112053;
	Thu, 29 Oct 2026 07:59:12 +0000 (UTC)
Received: from mail-dl2-f8.google.com (mail-dl2-f8.google.com [74.125.229.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 192A610FC8D
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:26:08 +0000 (UTC)
Received: by mail-dl2-f8.google.com with SMTP id
 a92af1059eb24-1379d236149so335191c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793193967; x=1793798767; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DOaHU7ZgVC+P0bPSjaN43IEeRLa3GiPBavjQ4gEWVdI=;
 b=XEkM7F8hAS5UtnSG+u1jUHWncIpP7kPNDxTUk0VavQWJQpiGJv3y48aN8J8kCL/D+w
 j05e8hhpEFOJKc72frRPe97fFYbrdGFqr+Mw8NiZFij60oIrmx31GF3NyscYgKtM+T3F
 k/PkqD0FlDZMnPk4H0UZzhD9CUCBZiq1zV1ZpG/QxQEP5jT7d85rQ1qHj0pCznVNzAfc
 Fo8g2jmrtrDcMTuDPvZVHtqrH1TDpj6iXtS2TJHWxMitVbQ12oE6d+KtUJzYDAYezreN
 2psGKPYftu0zPk+SaYN6ZZqBFZwA+6W6jhmIVFidsYhlBzK8IpEgYSCPHPGYo6t4Avgm
 pwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793193967; x=1793798767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DOaHU7ZgVC+P0bPSjaN43IEeRLa3GiPBavjQ4gEWVdI=;
 b=lKxej/D4InjqQWG65FmnZS12Ds9e58Rozt967eKElfO5b5ovo7NxOPqKHsn6tCA5K7
 hut5Yc4TFUWbl2OzRNBiEix9Js8dcQC7qcT7vqOnrxqW5cvAGjz9BptgGqxwDHRHzHMs
 CBVCyOcrTWCU06GVBjZHLJJs9nCZTR5i6yItbVMFYq+7qSOxXiFpaSbyqpQH3NaLWtrV
 JvvnqYBa3ZhOY/AP4t9kNScAkBisOI92oL2l9bJPuqVKvS8YuqkHnI4IHLPDD6DwxItS
 SnS2bR+wgO6VZSrRbjbyBxtyngv4/qSoLI/q3UdNbYXhrJzKLylNx+vVlcUMjsdQ5W+F
 BJoQ==
X-Gm-Message-State: AFq9FYJtJIoYpST8fdeT78uSLnDvCmlTssfDJ9unjTov64WHP8JD34Gk
 4JLbQz9VKlc7eDs12vn7v0HZCEmW4r1fNni6l+PCyVXFbcKj6ZV3RlXFCqN4QMMIV6hfeA==
X-Gm-Gg: AYBFou1+KaYiwH3dJ7mcjZm9m9IPgVeX8PxBwjmgItfP4701+SJ0meoyqLr0JGY+CKH
 9gVFW1teCZtFiFXmV/MfZ7i9B8av29An6b8gMDD2y9xgNBGbfjuJG5KcdAGYfGC89zA0Bjn2zCy
 kUpXLi47bOGJWW+893S1r7BvIzSursdst8JhfqVWk0X+f751KGCUfaER/T8RdYAdeJ07/IyBtY4
 Qc4EatrBNZ8nWFGfIjgDmDrxa2Dx8eX1X9fTrLTiUQSDTdtvSOllyzPTrdvPghe2qFZLmOqeHhk
 Qtq//TCA8IMGdDoDywqtpJxFsvML7DK0emGwvM7A+DbBO0iyxN38qXj1yP7UEPrU6ZJ35xcO/6E
 t13XIY5GOE5vEeIcNifIhQ60CHi7NYxZbrvP75Bj7lltCZujhYbaEyAQkjLWn8l6gbK6ZP7k36h
 nMiX0y36apT6dnP1WIqh11NlG44bGx+J31Z1rXSooWv5fjWZdT8/fEk3tHvWGXSwbWYirPiiTot
 yfl7QuJJ7hFpu8pJmOmC29uRvfLXdA8rwPYGciFo9nCgU4PX7/w/m/LVEkLgQVhS+7bFe0XBJ6s
 Dn0oj8Wv4sxYaKl2quy2q8JUmmsUL/+1B3mFWbPa4TJEu1kwVBu24si8tBRdPFeDE3CU
X-Received: by 2002:a05:701b:2803:b0:1a7:a79e:224c with SMTP id
 a92af1059eb24-1a7a7bca75bmr1729249c88.34.1793193966766; 
 Wed, 28 Oct 2026 06:26:06 -0700 (PDT)
Received: from toolbx (2607-8700-5500-3d9a-0000-0000-0000-0003.16clouds.com.
 [2607:8700:5500:3d9a::3]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75c814aa1sm10708639c88.7.2026.10.28.06.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:26:06 -0700 (PDT)
From: ZiAo Wang <ziaowang2007@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ho Jie Feng <hjf3108@gmail.com>, ZiAo Wang <ziaowang2007@gmail.com>
Subject: [PATCH 0/3] Add support for Valkyrie USB LCD displays
Date: Wed, 28 Oct 2026 21:25:33 +0800
Message-ID: <20261028132536.375927-1-ziaowang2007@gmail.com>
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

Patch 2 prevents the HID subsystem from claiming the display control
interface. Patch 3 adds the Valkyrie DRM driver.

I wish merging this series through the DRM tree, with an Ack
from the HID maintainers for patch 2.

I tested both supported variants on physical hardware using the
Sway compositor and verified that rendering, suspend, and reset
work correctly on all of them.

Thanks,
ZiAo Wang

Ho Jie Feng (1):
  drm/format-helper: Add XRGB8888 to UYVY conversion

ZiAo Wang (2):
  HID: quirks: Ignore Valkyrie USB LCD devices
  drm/tiny: add driver for Valkyrie USB LCD displays

 MAINTAINERS                           |    7 +
 drivers/gpu/drm/drm_format_helper.c   |   73 ++
 drivers/gpu/drm/drm_format_internal.h |   21 +
 drivers/gpu/drm/tiny/Kconfig          |   15 +
 drivers/gpu/drm/tiny/Makefile         |    1 +
 drivers/gpu/drm/tiny/valkyrie-lcd.c   | 1413 +++++++++++++++++++++++++
 drivers/hid/hid-ids.h                 |    3 +
 drivers/hid/hid-quirks.c              |    1 +
 include/drm/drm_format_helper.h       |    4 +
 9 files changed, 1538 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/valkyrie-lcd.c


base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
-- 
2.56.0

