Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2FAFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 01:39:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787F310E080;
	Tue,  5 May 2026 01:39:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PkaCwOXL";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E74810E080
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 01:39:24 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-67b8d9c26bbso6161284a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 18:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777945163; cv=none;
 d=google.com; s=arc-20240605;
 b=gPxV5eGzEa8POnI9Di9fp+dqH8pzCNRGiJ9PnS9KHrGhbb+eDSC5H66v4/He9SUjdK
 3ZikkLe/zJzZQgnBjaLOE1t42VdfWbf9Np/SwzGBIf0j3FULSC8bjD1zupP7ckot5eAo
 cjRr+DAcIr/2J3M6IKPYVsmxfCFMRXSS/pVkivAMP5SMhBzxrXSQueaTQ6koqwVNFw0D
 i+T1/I/7fTwweztbkatmQKrNT5rl/rs1e8Bq/ZXRnQBIiYr8V24t/EjavtcWkhp5YBW3
 EWIiGApe8p63nXu2b/5qxWJ7HRXrvgnIaETQCEhcN6I62ZmWOJa03biPgwlKbLnxecc5
 wryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=zW9srXy5sasOXgSYMEpoWBjtDtHo2tnh16UC7yjH1Xw=;
 fh=iUd8alvYAWOPuT59m1VJutpShpTfulV9PF54eDoJB7s=;
 b=BWjzI+X+/pskS8e4+l7JnfHQ5D3vq5nFZGfecwHiZNOrOuCBlLyc71Ulzs03msY3vh
 VHd3D2kiSg9HHp/7eM3fbDkV1FCKpwizi2sfCh6ORnghh4x/QmK38n6rOWHmtcBHWGPS
 uAoBnf6sywJI9ZCSP30TWcVLP9BOJgpAC9+CfIp+/e5RNejPvn3Mkkiy7bwkzVPrFUs/
 yAM4qcHBm4e4qkBv8Svye7Qcimnci402jbJIkUVYWdv8sCEjPKVAKdvW1wfX0RP2yqYh
 FmrQ5oA2yXl0cb99jTuUGq1LT5xV/vWRckusPDTYsQuj6cFb4RJ7Hxd8d8NxGdL4rNWR
 pDyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777945163; x=1778549963; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zW9srXy5sasOXgSYMEpoWBjtDtHo2tnh16UC7yjH1Xw=;
 b=PkaCwOXLHA04JCMttG1/A2DNk3gUE8gpQsKj379mpJ9a6f/KAP7+dG9//ukb9JYqgS
 LmsbGDz1eGeMfjAZXWmbFF7JxFKXJY4uuTnvRdppsleag2/I5HKMKZGLbMCZLBvJpxAc
 OMaZhQqGGmu0vZ8YF3dvcDO8RgjBaSlxx7GnBtfjoaFca9MkxnL2HbkNkPd0C8Y+b4vh
 6s2+wiDeAXsR5N4caD8hkIdkqhVz9y709IJMij8gfdmngsA4Sf4ug6INmCbLI8MN7sm0
 mOlRmWK1acfO2kTHa1A9SUQkfwiUeV2pdCpvTypNSAxd0z55oQm7Vgb34rvmlDxGxefR
 yU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777945163; x=1778549963;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zW9srXy5sasOXgSYMEpoWBjtDtHo2tnh16UC7yjH1Xw=;
 b=ETKn7eX9a/C8Z0AFT8QNJPDAcrg9qz53bi7zlu1ve9FDk1JMshPx4nsUr57xH+8hih
 FbvMzSn8J4CK65zMX0Y9r3OEXrbNNhAwFhUGxUfS2Lh21x/s5Fdg6Bb5V77ekv7lQAT/
 nnDcQp9uw2cw1s3xD9/tz8cscYPEzOp3yvEzs614h3IQCz+aTkP/BPjGQ42Ak/oxO0Qp
 LntwG2XmfAJDuaOExY6xXg8hbF+s7QsgHhoJx45UqIagd604sEFpTp34dMj3F1qvlFbk
 bNNDEUYfVferTp3n9VQpnMnr1f+9mUS/p4HcTVQESVBluIv8mRh54nwyqxc+gopQSmOj
 gUlA==
X-Gm-Message-State: AOJu0Yx4AkEbmo2C5nEF/0EbEtpxnJWWcwV/PwLJrIH64rredtjxn5Ew
 1UqbQX2++ocqZxEVnCAbCP7ehISxagO+733FYkMtUBMl/XM0RkU3v5D2c7+yupJegs7PjqNytrH
 +S+lBApED6AX4pOgMM8aTaf3q6BqH/v8=
X-Gm-Gg: AeBDieuMvW9yL72VPqEXmOLS1bPBr6ufqmmcJzAiWmNCkAYgHiyyxPYMC+3yICBhrX4
 /1feb1JTo139re5eJ5BGu0j4zbeOesGwfXifiB6qcsImHi4fgZ8KOnYOA76NugtXE7UaqbV4/D+
 23CmW9NhKxi1ZVNHExvNf3KQaXKzXQY6H0qhV51RPAlpmSPZNV0ZImE+0WJXcFDH0yxI4tXTMVu
 rCLZjf9P9SowHFi0Jmy830HiG1LQPCFHticPk/zKSSiPuXfE8OLHec27z+7p4LHaI02YlTUbSbF
 k+VaEZBIp+1riwHB
X-Received: by 2002:aa7:ca45:0:b0:672:a1df:9c6e with SMTP id
 4fb4d7f45d1cf-67c1b2ba7d3mr3855060a12.25.1777945162456; Mon, 04 May 2026
 18:39:22 -0700 (PDT)
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 4 May 2026 18:39:22 -0700
Received: from unknown named unknown by gmailapi.google.com with HTTPREST;
 Mon, 4 May 2026 18:39:22 -0700
MIME-Version: 1.0
In-Reply-To: <20260420010118.17960-1-dbgh9129@gmail.com>
References: <20260420010118.17960-1-dbgh9129@gmail.com>
From: dbgh9129@gmail.com
Date: Mon, 4 May 2026 18:39:22 -0700
X-Gm-Features: AVHnY4Kw6-D4RoLgxVbTrSVYepdJksfw9sC-SZytHwR6bu9D1ZYkczGjKA77IZw
Message-ID: <CACrCO_VZg_2PXG011qQ7NWo3iz-u2HE6DdHZWQdQ_UnRk4A0Eg@mail.gmail.com>
Subject: [PATCH v1] fbdev/offb: fix PCI device reference leak on probe failure
To: deller@gmx.de, Jason@zx2c4.com, linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 mhun512@gmail.com, ae878000@gmail.com, tmk5904@psu.edu, dbgh9129@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

Dear Helge and Jason,

I am sending a gentle ping on this patch. Please let me know if you
have any feedback or if any changes are required.

Best regards,
Yuho Choi
