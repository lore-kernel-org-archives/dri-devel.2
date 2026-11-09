Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37864606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UugrfTfQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67AE010E83B;
	Mon,  9 Nov 2026 06:33:15 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E30C10E83B
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:33:09 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-8b0d126f631so4185017b3.2
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 22:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794205988; x=1794810788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mJcjAX142MLT6BzJGS09GRbDUHvNzznxVDecvSK3IU4=;
 b=UugrfTfQ8sWHEpO971EEXcjvIjr4rrAl0RL05CE3OWLL+ds2+kHhDvnYlAe34mP73Y
 gt2QgAHdwrc9NtlN/wlx/nZZa9tD2CXML8M4Vj2JN301jO+2iu7/cH9Mcg2Itvnojw9y
 I6pUxzT3Qt4qlPPdUX1WPkKJN2HctYI7H5cUD667jnyeHEPuPG01htgZUitzS28hgok2
 dSppAbZ8B6HCM6JY6r3vS8U9tyDBiDjyPLGTsP5/g4qCL/3bDICl8QGhoBHYuXLnghZj
 t7BtW64aiqHtkigNxJ6UZN3yYrAU5v6oj+6OKFqo6/38JFHOTP48pX3cgLhVImXdVi/i
 cIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794205988; x=1794810788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mJcjAX142MLT6BzJGS09GRbDUHvNzznxVDecvSK3IU4=;
 b=azlgD0vpkGp9pFEia1Peo9Px70prmx40GkoblM1LaH+zQkhZYRhC8E/GQKWX8qHsPy
 9/c9Ba0tk50rxLn9XktdHg9GAeIaHqQfBxxhKdxq8L/4fPSH3PlozB0XomZtY+FvxdIk
 DkpcD/TkVhRrydMqP1Ib3HakGKf4jgstQo9XRHz+Rfa9nIICzhnDZQtPFX5G/qlj/Pny
 TpjAKaNLZBy/mVazh1qya7Qnk6XYU92Q/UT+bAhWdMsf/qoRuAQD800NDfXUqbl8/HIy
 FEdo5O5LyrpKHNhB4NzgP/ROzzzPTfiXTCAPrQCQn2MhPP/Tx4Bcl5RksQOGJWZOtqKo
 cYrg==
X-Gm-Message-State: APuU4Z9l25tz6rFX8MsELNa1ukf1uNIqMalrsXFklqY0N4w2Dg64bjx3
 HKLiqjyEJzc1rGOfjq37rnbDMiz5U5pewFxzAF/ewh14+n81XlpBqmHKjR8YGg==
X-Gm-Gg: AYBFou2z3OnhbNKJMyOgyBg3mvmPMJ2PeFVobpFXJSgR17goWV6bN7gKddrTAL1gFL8
 0ZNaMYwW+fT2U7j45Xz0EbV15BhZgjYD2cWlsi7wHt1LMJIyAD7j4T9+dNQU57CxOo3018skjBH
 gezcG7/iD+IYcj1/0L28cGl9oqdxRZ77iiysCcKTYzILCNQYlRmyvRFrmB/P3HQN4ZRqWoZDbB3
 lgkpqp/IsVYNQ/rUgQkbiHA6zHFs7L97vqc0mr83CVIiiEshD/NxL+cuya4ZE82D/LjHExK+tj1
 ZoYn9dPiM6G+mrXVXki0j6kT4q9yf3i9N3Hsi5suB/yySVbBzSA+ABP3h0yjrkv0yKwp434GKE7
 2k3VhSx3RZK944xq1MdVrBVESwBacVJIQt5fIx662id+GPnjObgak8TDSUO+CFxPYgj3xH3JFYo
 XmsfpKiiXMK/SAsTw2ThXuqCO+OHYNjpLw8Z5BKFi7HLwqsy+aquo5y+s09VmRWfZhPm1HPuUSz
 42OJeN3M39MfnsIj8OSLnnW80WzuDTY5viRymtmmD/VXf+4QUz9oNRqzuS6ercA2QVROXQ6j/j+
 xR/cR65Y2IGqGVO8DdGe1cSq4BQ/2TT+b6/u4OgccPuKce2Nf/f4U9IMaqeZ3tkPD+M=
X-Received: by 2002:a05:690c:102:b0:8b3:56bc:49ad with SMTP id
 00721157ae682-8b36cbf9ab1mr23057907b3.67.1794205988238; 
 Sun, 08 Nov 2026 22:33:08 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b36bc43733sm29035827b3.33.2026.11.08.22.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 22:33:07 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com
Subject: [RFC PATCH v2 0/6] drm/gma500: prepare GEM and MMU for 3D rendering
 and hybrid 2D
Date: Mon,  9 Nov 2026 03:32:57 -0300
Message-ID: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This v2 targets Linux 7.4-rc2 at
7475ea8b58616b33c04afb976cf0fbaad9dd63fb. The six patches improve existing
gma500 GEM and SGX MMU handling as prerequisites for future 3D rendering
and hybrid CPU/GPU 2D. They do not enable either rendering path or add a
userspace ABI. Display GTT and SGX page tables remain separate mappings.

Since v1, I verified the introducing commits for patches 3 and 5 and added
Fixes tags. Patch 6 now handles initialization failure correctly: KUnit
still invokes the per-case exit callback, so partial resources are released
once through a NULL-safe cleanup rather than freed again through stale
pointers. The successful fixture path is unchanged.

Cross-builds and native/UBSan checks ran in Debian AArch64 Linux userspace
under PRoot. The i386 LLVM 19 W=1/HIGHMEM4G kernel linked successfully, and
all nine MMU KUnit cases passed in a QEMU TCG guest. Eleven host allocation
budgets checked fixture init failure and repeated cleanup. Physical Mini12
testing remains pending; no hardware rendering result is claimed.

Changes since v1:
  - Patch 3: Fixes tag for 8c8f1c958ab5.
  - Patch 5: Fixes tag for ae012bdc5799.
  - Patch 6: safe partial-init cleanup, checked with allocation failures.

Patch list:
  1. Use the common dumb-buffer size helper.
  2. Prevent GEM unpin underflow.
  3. Fix SGX page-table cache-flush mapping lifetime.
  4. Make MMU insertion checked and transactional.
  5. Propagate MMU setup and GEM pin failures.
  6. Add software-only MMU KUnit coverage.

Previous version: Message-ID
<20261109055451.17458-1-operatingsystemsdepression@gmail.com>

Thanks,
Gabriel Gama
