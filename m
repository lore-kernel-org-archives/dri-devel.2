Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EE3C44537
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D840710EB9F;
	Tue, 21 Jul 2026 22:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KFZoL5//";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3583D10EA81
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:19:50 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38e3efab7e0so3678352a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784647190; x=1785251990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qL09Eop8cdj7UJn+0E38QRn0GdJkNtat019HBLfKjCk=;
 b=KFZoL5//UW9dGFhlcD/Gq7IyuWrG9Vr92YEm+elQRsFnTtz5NqLTJiFr85J3uXiE92
 3M5IZtClilRn5XxCLkanqq7ptem+RXHTPfjd5uXPQXC9TD+k5h7JBe+beiFBPMxPoLkk
 MqApNR0pXs6vweZDIzVZFyUwg0Cr+RJgnRuoulmq4sPx6i5JBuvjIyMnChgNHwYj4MRq
 fP0V9trUyQJkfo3t0rPx+Z740BRQZSk6yPVORXSQvnTHVIp2pJzEhyCQD24Nv0NTFkQz
 P506NUFfLGHJ2FX0V/06ciH31tNaEyfgoF4uRgTOcEF8CyPUvVchUa/bYYrBtYQMvORk
 UCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647190; x=1785251990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qL09Eop8cdj7UJn+0E38QRn0GdJkNtat019HBLfKjCk=;
 b=BvFkolbsn71SCyov0t58FiGyQcQ96O/RPlTVdTTRZt77HxdBqRkgHyJEcbN348vGWF
 JBH8MZeE49f+XxXojFqKQ+qTFaZ07+PRQ2GpYqEhE2a+ig9Mb55IMfwvYU2ya1gpb6T2
 mua5ruYxKA946q3fzcbLbivxRpdSKFO3/tAmAq0yQsSe+YQTzF8PAkFpL7DhvBlO+pSF
 hsqt7yNECKMszbMyyyjhWr5JZwoycGKvYUfKilFC3M/IeuupIWdVHLzC9b6nV/owVjwE
 UPaTUl/Fp3mYalCoEw8ChmngA8MIdfb7Zv3xychpDHfTG2QN+qAc5cDK36J24I/eXs2y
 rORg==
X-Gm-Message-State: AOJu0YwOF6UCN1XIsqGKDdm4EXiYlHRzm0hhWa9si9Gz2163T2QWTFIy
 OyFipAfKyfx5MlDVwkLDcKCsds+GQSSN7UUvaxbS9QHJEQAscoDycbjB4W/PZcPoKf8=
X-Gm-Gg: AR+sD12u6+Bu5ZTey5Ic+XlOu6BDnGrlbkzBfwoODv4FZISlJiyue0rmvdbqN5ikMVP
 qdvYtCUAsT9U7uihp3po64aTk8t+yL9oiHgLBfWqW2PvOkZK90nXFS5tNR43SdG6quST0xCUuhC
 v9HGBNAQzSmT2TYW6+dPSqGIsRhcXDLNZTzOxbY3/HBGNnLn/SfIj1vbLm5AmIuHEL5mXD/e7Gu
 OL1CowXnFgq9TO5zJlUo6EqdxomDARGDVi3wN4q5j5C/b2nUQLr0/AbMzEUOkaW8P8QuZnu/da+
 9/BW0fsU3dkNEIK/YflgDdQgNyPVA1t5QK8UeiIDVymgeUYTY1xjNYbYwDlOIvZiU0leRAH3Uwe
 nN2AAsasJO8uPJ/qnIm/UOwDIuxzkqnBLc4UGVTfPZoe8R2I/i2WJGgAyR8OB0E3blJOBlYNuVE
 sVDCxkGTo3I6ighN09vLuoapAmCr/fWSFjzwubKEoWTpWm
X-Received: by 2002:a17:90b:5485:b0:36d:b12b:f57d with SMTP id
 98e67ed59e1d1-38ea372b521mr28247a91.12.1784647189542; 
 Tue, 21 Jul 2026 08:19:49 -0700 (PDT)
Received: from fedora ([2405:201:a412:78a0:40cb:342e:9c1b:a9a3])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2ddfb35sm44345770c88.14.2026.07.21.08.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:19:49 -0700 (PDT)
From: Shivank Sharma <shivanksharma2376543@gmail.com>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org, Shivank Sharma <shivanksharma2376543@gmail.com>
Subject: [PATCH v2] doc: ABI: sysfs-class-backlight: update outdated HAL
 userspace references
Date: Tue, 21 Jul 2026 20:49:38 +0530
Message-ID: <20260721151939.331067-1-shivanksharma2376543@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721132253.256422-1-shivanksharma2376543@gmail.com>
References: <20260721132253.256422-1-shivanksharma2376543@gmail.com>
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

Replace all deprecated HAL userspace references in sysfs-class-backlight
ABI documentation with modern references (systemd-logind, udev, general
userspace).

Signed-off-by: Shivank Sharma <shivanksharma2376543@gmail.com>
---
v1 -> v2:
 - Update 'Users: HAL' entry under actual_brightness which was missed in v1.

 Documentation/ABI/stable/sysfs-class-backlight | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-backlight b/Documentation/ABI/stable/sysfs-class-backlight
index 40b8c46b9..e77bd574a 100644
--- a/Documentation/ABI/stable/sysfs-class-backlight
+++ b/Documentation/ABI/stable/sysfs-class-backlight
@@ -8,7 +8,7 @@ Description:
 
         - 0 (FB_BLANK_UNBLANK)   : power on.
         - 4 (FB_BLANK_POWERDOWN) : power off
-Users:     HAL
+Users:     systemd-logind, udev, general userspace.
 
 What:      /sys/class/backlight/<backlight>/brightness
 Date:      April 2005
@@ -19,7 +19,7 @@ Description:
        are between 0 and max_brightness. This file will also
        show the brightness level stored in the driver, which
        may not be the actual brightness (see actual_brightness).
-Users:     HAL
+Users:     systemd-logind, udev, general userspace.
 
 What:      /sys/class/backlight/<backlight>/actual_brightness
 Date:      March 2006
@@ -32,7 +32,7 @@ Description:
        may treat blanking differently or have custom power saving
        features. Userspace should generally use the values in
        'brightness' to make decisions.
-Users:     HAL
+Users:     systemd-logind, udev, general userspace.
 
 What:      /sys/class/backlight/<backlight>/max_brightness
 Date:      April 2005
@@ -40,7 +40,7 @@ KernelVersion:    2.6.12
 Contact:   Richard Purdie <rpurdie@rpsys.net>
 Description:
        Maximum brightness for <backlight>.
-Users:     HAL
+Users:     systemd-logind, udev, general userspace.
 
 What:      /sys/class/backlight/<backlight>/type
 Date:      September 2010
-- 
2.55.0
