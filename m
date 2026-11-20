Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8B606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=R7OTAPPh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E119E10E0B5;
	Sun, 22 Nov 2026 17:13:43 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2E8C10E0C5
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 20:10:07 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-3866a784546so1011424eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 12:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1795205407; x=1795810207;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M68LbjcTJ3E++0vyBdIVrjiqmT6srx4BEI+V4obs4pE=;
 b=R7OTAPPhiZabhyhSkVlmdRF60mtiBT4JSDs7AiDV/yQcHl3IshRYURO/D2C6xyLKiX
 VIP7Kl8soa9FjUA4ahUYkRyzg0u8o0yzT+3yVAIhQEzPWJesFtQ7Pmqx8kV3zHqt55Ee
 bJYc6Inehmi641poqhdIU/U1HEX8beOWyPL1ugdQIHE2Sqboufzh3ZSS5bTtoxqUgnfL
 E+jy5KKWgyvSnFuoI1pBLfBYS9Wc6MvlJ8SwZJEQpwmYn3IaugMhllpM4sscMCKG7zno
 DZkX68LAqHN3SYjBY4cFvYk6i7tzHzWjwCY8hqic9D34pWNdR52Lgj9Pe1fCAhLuPzba
 xDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205407; x=1795810207;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M68LbjcTJ3E++0vyBdIVrjiqmT6srx4BEI+V4obs4pE=;
 b=cGNIp0dNFuZUHgB2vaaW+Z0ImsBBaJYHdWHwK9mb+QsR07tjTPf2XUH9jRjcorv/gW
 LUVGTr+TI82bz8QZMQFCjRO9QtkVraWP6ubAzkX/Pb9uEwKL1pyslRE30sYUl6arFKxy
 eQU70UsIAKNVtlBkcWva78UUkHk2IYEFMaGEASBJfErTfBm3gsr2Tbm8M48S+COS3inn
 0ScXBkGo46j048DQRF2I0uphdkIQhTRreNoibsIaUEOqs7zkl76I/KzZ46mVqSGU+sBA
 VOC8lhd85N9UrVNde+pO+Jym8PbJJ92aS2ell7GuIhQ+brC8ba9SqsP2Svw6YkOAvO8t
 4Sgg==
X-Forwarded-Encrypted: i=1;
 AL+hErGlSgsIDcKWRFo6GtK9xrJ4RILDEGb6N1js4ucxi8xA/+p0gYqbuqLjk7utZduLkrG0CpDrwfbsxB0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/SeMqEKoDrmKLBvsOXGL3+dZwgmQQ051XKYDg4zMcYl9Mop4hm
 nvizEr+KCxOmNEj7JRNtPxmqbSRWSSxvx3ihdi7WDugvulKavNoBQKUljqWi5GjUXlQ=
X-Gm-Gg: AYBFou0zuXyqkUWKDwAWmGT7X/xQjDdGrlgzgIACCmwCbvkRcHssl0KBM0p3Adbk9L0
 C2UQSK8peK8SdMSiDLDVCrfBZ0xOQhJCZ2jIFw+aNgqbnAjO9J6juPYVnJeLRwxoUi8lKiZF7Hl
 2b5A+yXpOxIgpYXt2gd+yYb0LgmmHy9yNlxx58+DKYyM2fkuH56RwaIugwVyB8qdTjO5r+tyBCR
 PWfzU+o5f9M+6G9xSQdZ1uksRwR8TqSn4/yprGqoz1+Iig/Fj591dfA1Ym/ap1K5NeYzrxmUACx
 tb1iMteYJWh7G4L9FtzvA5ErN8TQ6EdDALuJX5N0Y0I6TECmS/WM1I7yW6nYXnwitPGXyiXreWb
 v+HMNgiXIacLOVDXUHC+k4aHhrfcLnz9K8OesNUZ9dS1+PPDiGTp73IRfOQGLuK+qP93qKW0cpb
 hduqD+JWjs32g5fn6MsS0Tlf4s2xNrVETTmisclVUFKy0keJGXN05Cnqp4O+E9NS/ygjkEjcFtr
 8c5xRnG5q2DMlACq33Br19HgeEom05oHlRB2Gc5uIURnqhPFqpTWw6de6YHtE4qDGR1uFU2Yjqs
 It0KdhV88rlc6L21ZXa/xboDj/oSVK44JJjHumzhx6aR0w8lVBwh7BBF0Gv8nnzG82TrtfPgFFW
 UUMWMWLmf1nn1u4Yb/bLfMGQ=
X-Received: by 2002:a05:7300:88:b0:386:959c:11ac with SMTP id
 5a478bee46e88-386959c141bmr1391312eec.6.1795205406871; 
 Fri, 20 Nov 2026 12:10:06 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:dd51:675:4b81:7ba])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567abb870sm8771267eec.25.2026.11.20.12.10.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 12:10:06 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: deller@gmx.de, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, mlbnkm1@gmail.com, simona@ffwll.ch
Subject: [6.18.y] Please pick three fbdev mode-sysfs fixes
Date: Fri, 20 Nov 2026 15:10:03 -0500
Message-ID: <20261120201003.42046-1-artem@trailofbits.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Please pick these fbdev fixes for 6.18.y, in this order:

  d15d51fb26e830af58f3f21964f1c09c239077ea (CVE-2026-80580)
  ("fbdev: bound mode sysfs output to the sysfs buffer")
  95e647d2a5304a8fd11f1ba3c8502de700650131 (CVE-2026-80579)
  ("fbdev: clear fb_info->mode before deleting a videomode")
  061db6b7a910b8378f3b2df64f8c0a3ddc6e85f2 (CVE-2026-80785)
  ("fbdev: serialize mode sysfs access with lock_fb_info()")

They bound the modes output to the sysfs buffer, clear fb_info->mode
before its modelist entry is freed, and serialize the mode sysfs readers
and writers with modelist replacement in store_modes().

The fixes were tagged "Cc: stable@vger.kernel.org # v7.1+" and are so
far only in 7.1.10/7.1.11 and in mainline since 7.2. The affected code
is older: the CVE records list all three bugs as present since 2.6.12,
and 6.18.64 has the same unlocked show_mode(), show_modes() and
store_mode() paths. If the v7.1+ limit was intentional, please let me
know and disregard this request.

The prerequisite, upstream commit 6f611e5e5f33 ("fbdev: Wrap
user-invoked calls to fb_set_var() in helper"), has been in 6.18.y since
6.18.57. All three fixes apply unchanged, in order, on 6.18.64, and no
patch currently in queue-6.18 touches the same files. 6.12.y and older
stable series lack these fixes as well; this request covers only 6.18.y.

Compiled drivers/video/fbdev/core/fbmem.o and fbsysfs.o on 6.18.64 from
a cumulative x86_64 tree using allmodconfig. No kernel boot or runtime
test was performed.

An LLM was used to check applicability and stable-queue history and to
draft this request; I reviewed the result.

Thanks,
Artem Dinaburg
