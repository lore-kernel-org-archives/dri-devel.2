Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6E0F3380B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E73910E51E;
	Tue, 17 Mar 2026 08:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fff9f8qR";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5B310E394
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 07:17:46 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c741692db4cso19884a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 00:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773731866; x=1774336666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tFnPL5x7ivygrIkdRXEnLlp1R6tWrg85WLqUxl13qlY=;
 b=fff9f8qRoJCz76KlUJybXKiUNKjWLFmyRUTnu7+749M0qWdI1kIJT0weeZttX8AJ6J
 34luqOZuloypqZIME59/ocOGMDzbsShrMpI8V329gwOc8NycpLxRGJbSRug8Ek9egvFM
 hUIoSLqqYTFj0wm+a7Cinj92mk+7AWzS2bqqIV746T4shlD+o5DP0j/UA2mc6FYo7vOv
 etv6FlOR8PBv0zuwAaG8/Dp6aIqgI18GgmP+V/VAJAlthqOrxcSzU5EiUEZXtZhHoulh
 lbO3EIfx22Rr2GeVm9pdW+EX9HfuEAUGo1MfSB3BK6vkrd8KTXya0xLCRv5lTLdPiboa
 GWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773731866; x=1774336666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tFnPL5x7ivygrIkdRXEnLlp1R6tWrg85WLqUxl13qlY=;
 b=cr/7QXoGLGsc/3k7kDb7tlORAWF+nLmYSaA15SdQKXDirG6DdHypn78jTKdg141ucp
 jiMFkfCpdqipxoLWOCRFmvUMFcSJ4eOlbIJqXE9fv3whO1Ma4JoxhkhxSA+8kfjDYqFZ
 g3AP5LhkKGPwBIwhTYB/9YtbS3/7LsbEagAFhTcsVvoHe5yKOGW8wM3IftpwybDooAt3
 aTJIqVcIbbOBppV3zCrdUT1bWEPOCrraM3ZFbH3q0blCUzxbn04zIgeUTZ+4IQM5Uw1h
 Ke77beK0pGT+yfYJHRq6IVeUEQbPm3QYrR51dUlrcB2u9YJ+9NRZPQ9kt6tzlZQ5SWwt
 3iDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAKK/GngHBkU+ZJ/aaSgS+uO/roDws8Q6JNaqZJ2r9v2ARWER8oyCFiN0mN4Bktkln68btcXedZno=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsLH/G8NpixNGnFt2YnEDIMEB11CY70X2jPMSRkvl5nZ/wCjya
 ooJ5DDSYQ19kfOPqCEkaUPl1m7Bi2dv4gtoDKSeKwkYQAOcT5NFmmhSE
X-Gm-Gg: ATEYQzxkytuWvrJ+6bCEALmbnmCKbE+wxUiKn9Jx+5N+wetobH963ryQOAzmYZd0Ogq
 g53oevjOvM6MGXfNzac/piiVdl+KNu4MpaEL3QuKXbms4p9wULZPC1eSPy+M/WloG9y5JPMk2gR
 QiJaa1txYiNHOzR+RSTDkls/UZmdIzIIW444Zyx0/ikg79SP2L6mbUcOCZdpZvw80JP8PMX9Xvn
 oD/XuSd42JLyP3gAzw2UV8Dg1XmgST6TJmkF7mTJt1riSKSDyMwqQyO3NsR+VAZzTlZWeikjA+P
 MAodafkYJNhwYI+scLmF5C4aXdip8UyvTypL+fKikmV2Y6uRCfZwxiOZ4AIuQ2vsMFFEwsBxHiL
 xzf6x2Yc42xIP4Am2Vo0mvED/VYGZYpgsOW5Ar4bpsYfQTQTPIQtMFnSocMOgzoxNSaaC96EpU5
 EmWra7ir2NpCvMT38ME+j3hbSPiZ1UR4JDi5Jom0FKyWsyc2frbCo9seNz3OyEWR5BtTZhWPzM7
 B3Dww==
X-Received: by 2002:a05:6a21:888c:b0:35d:cc9a:8bc1 with SMTP id
 adf61e73a8af0-39b7dfd49e4mr2000340637.27.1773731865863; 
 Tue, 17 Mar 2026 00:17:45 -0700 (PDT)
Received: from localhost.localdomain ([14.160.25.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a0725ca0asm18751443b3a.17.2026.03.17.00.17.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Mar 2026 00:17:45 -0700 (PDT)
From: phucduc.bui@gmail.com
To: geert@linux-m68k.org
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, phucduc.bui@gmail.com, simona@ffwll.ch,
 tzimmermann@suse.de, wsa+renesas@sang-engineering.com
Subject: Re: [PATCH v2] drm: shmobile: Fix blank screen after resume when 
Date: Tue, 17 Mar 2026 14:17:38 +0700
Message-Id: <20260317071738.3660-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <CAMuHMdUBwNtdhZYnA3+nwe-CEmrUdPu_K7923uMY5qi9edbkbg@mail.gmail.com>
References: <CAMuHMdUBwNtdhZYnA3+nwe-CEmrUdPu_K7923uMY5qi9edbkbg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Mar 2026 08:02:43 +0000
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

Hi Geert,

> Thank you, that explains the difference!

Thank you for your confirmation. I am glad that we were able to
identify the root cause.

I also appreciate the support you and Morimoto-san have provided in
the past. It is a pleasure to work with you again.

If there are any further changes or improvements needed, please let
me know and I will prepare a v3 accordingly.

Best regards,

Phuc
