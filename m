Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CE1C44536
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD1C10EB97;
	Tue, 21 Jul 2026 22:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PWEnHDH+";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B42C10EAE7
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 17:27:21 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so29984025e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784654839; x=1785259639; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=42pW+71pg0Jh6s4IcFPEIBJFPC+m1EF8ujgkpv3uhhg=;
 b=PWEnHDH+9vnddRv8rTmcT74n7IwEeG8/hB6rV81qR5b9NBPTrfpMHM0H5KMwVyWBNE
 fJfzfsaIWgJHJmCkV4FEOaJigeSgqsQ5dqEdeR0RpM7NXt6/OMbWisi8fUpDUZyW+/iy
 13KadtVlWPKtHZwxD8A8XoVNqr827W0Yz2QSwr0KVC0BBy7wX5HKJt+CgD7nzPBIsETE
 9H/QE7mWxc1WltLaCfhgdMVOQLvaU0+PtWpRjgYOSAS4R+IZytOa8J7JDNpARXYTFTaR
 eJVv9Vjl9YaXsh7iR5saloJc1SVXbtv7h65531E2l6E8g8mUYDVuxEjQgXKyYSfaqTph
 JMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784654839; x=1785259639;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=42pW+71pg0Jh6s4IcFPEIBJFPC+m1EF8ujgkpv3uhhg=;
 b=pGRycVm1T0ewSGw8MvEOxgYKLZC9bSUHVECUqLyLESwx/wan8CElOEnh5yG5+xgUFU
 zMmB5sYgu0JXD54iuqqnyDoBwNKkZ7dG4WdbEhFhy252XcISSTWGx9ktNpbGvrl/b7uN
 pRk9gIjnEbb2a253mjvqJNYXw5qO+LVPzTghzCu0X6mRUlgR/8K7AmV4dXmZ1SMCHaCa
 VbTmYXwOw4dW4T7Nd37mQ7Y+araBJLAac+g+8Q42mFmu0rERGsaqLEdtzwfFFqAm16KT
 yW/65ZssPz9sy2zfX7jKOEREq1Iosf1qkntsZtjKWgtNCePAb/Oqw9I5Ey/kOqRhxzJf
 Ta/g==
X-Gm-Message-State: AOJu0Yw3iknbm/wHGL4CXW6ADSIGkNBdZ3tDHsepUbV9519YMogM4FNz
 w5Me0pK6OF50Qxouuw9p2TIg+zh3+Na1gdAKsdUYoMC/jDWqeVdk7fkd
X-Gm-Gg: AfdE7cmw2kTNIMX+gWuvROq9B7X73Q23nLZh9s8r/9Z65NseUijjIFh2WU4piaUifZ1
 vdMmzu4gWNN5ASsVtJCtnU/1mXsEWOjLLLaKK3ZdDnr2W+9iA3olWsSsv3L9PBqw6NliME863LV
 fgjpGBYlAviqG/kXxD5eCm3vNgq+AYA5moqgxQqme5YEKdBjN61Dr515MkDl3Vri4AWznpavl7T
 +ONqAKA4xgP+W71GZvqSur9XSRWOzZ4I1YSuH+BGhLOphIV4Z8cPvwX7cPxWozz4PbrXdB0knkN
 Y9nIVBdzakcgRgS6r6MuF6rDjslITbeVk2otgkpn67X73VUyxetrrH8BINmzV3+7jNpYEOvi53F
 jcpHD5FW4EbTSEHek9FrYhW464TweExKzDkBMQ5m59TVs3ccaqZCvEfLeuyej5UzxPF8ufbZ7/N
 mDK/4KFGFt9wcS7egt0mx3O/NMFu4/qrnpOfldWQ==
X-Received: by 2002:a05:600c:3b19:b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-4954a3db76amr224885175e9.11.1784654839240; 
 Tue, 21 Jul 2026 10:27:19 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4f25b6sm8214605e9.2.2026.07.21.10.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 10:27:18 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: michael@amarulasolutions.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v3 0/3] drm/panel: ilitek-ili9805: convert to *_multi API
Date: Tue, 21 Jul 2026 20:27:12 +0300
Message-ID: <20260721172715.602196-1-michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

This series converts panel-ilitek-ili9805 to the
mipi_dsi_*_multi helpers and cleans up the resulting code.

Patch 1: Convert the individual DSI calls to their
*_multi variants

Patch 2: Replace the ILI9805_INSTR table with per
panel init functions using the *_multi API, dropping
struct ili9805_instr

Patch 3: makes ili9805_power_off() and ili9805_deactivate()
return void, since no one checks their return values.

Michail Tatas (3):
  drm/panel: ilitek-ili9805: Use _multi variants
  drm/panel: ilitek-ili9805: Use dsi_multi in init
  drm/panel: ilitek-ili9805: make cleanup funcs void

 drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 211 ++++++++-----------
 1 file changed, 87 insertions(+), 124 deletions(-)

-- 
Changes in v3:
Addresses review feedback from Doug on v2
- Convert hex to lowercase
- Align to match open parenthesis
- Change lines to not cross 100 chars

Changes in v2:
Addresses review feedback from Doug on v1
- Patch 1 remains the same as v1
- Added patch 2 dropping struct ili9805_instr and used
  per-panel init functions
- Added patch 3 making the cleanup functions return void

Revisions
- v1: https://lore.kernel.org/all/allWpYxgHfpKughy@michalis-linux/
- v2: https://lore.kernel.org/all/20260719190358.438699-1-michail.tatas@gmail.com/

The changes are compile tested only. Also I run checkpatch.pl --strict, 
sparse, smatch, gcc W=1, clang W=1 and coccinelle.
2.43.0

