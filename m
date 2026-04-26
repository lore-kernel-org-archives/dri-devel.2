Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD943FF885C
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 08:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4313510E06B;
	Sun, 26 Apr 2026 08:22:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GN4kCVpQ";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5441C10E06B
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 08:22:47 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2b24fdac394so89469055ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777191767; x=1777796567; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ul9ZtatMmSZUhyR2nVk3wynb1YIvXtkXr30NlopXkrk=;
 b=GN4kCVpQDiPJf9Vqc46R0ldZs9ERK8vT1668ZfXMQJvSJXekP2vuOILssQMgV3/Smv
 FaX+aeX6MoBcP1JqAjOcKuohiXS5Qi4ZU8qc6n9fIcM5HyOtyKuOd4xEDZKpFZtYF5Xk
 IgnYvnHjZgDg5rp0mgnNXBQPJ1nSnAUbV6CwIOvxxGGMrEBNUcmyeAde3pW2HyrGZ56J
 kXyj0wHk+NZtVKdK5KyyyyhbD/p0RX1/fiMIOo6p2FhCClrholHybwRsr1xCur9Mqjz1
 rHpf+l/i+21rh6L8bzMj/zTcY1KnSX9kCTcYi+jmkPPXXPtdQLdNQ3PUyqR4/BLo6+vG
 KhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777191767; x=1777796567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ul9ZtatMmSZUhyR2nVk3wynb1YIvXtkXr30NlopXkrk=;
 b=jbDxNOoBx/ZVBzteN4GEsJD3QmpabaKsH5NAtk6qtxgKu5OKAVoGz+FDaEksz3mA6b
 FBvvivBc8G2NtbxS+T97hQag7bnUwf3PxrhgsSu6AluNfiFv6sJeT4ZLUX+qPGKF1rn/
 XjWFml8mr3hhkrtayq818iFcPIkkE6kH3EsRCsdUWwo2JXUwgvVjSvU9WlnBG+iG0wtc
 6glzz883ZMO0aC3fwoblkDS27p627u3nGe2lv2w7my9y9TA8gfe/ayPvOze39CnHyUXy
 F/X/s7oOAkGfyizPdKG3fJV18l9hbjS3SL8WmPHLp8O056nspwutvhu1CvG3H+L0xSVw
 3gIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RnuKBPPWWanhnXCxclBKRCEXsSZ6e6AFakUbuSTaRiNjVaFgg3JGYa4W/vVHZCDOqVk09SDOf0q4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjrgPTvnayQ3bAv0UqgW+ik6CPPAhOguH4nWnDD02hHbZlUgan
 qtrQKWs24ybfAe81Iw8DthLrtpH68xOTIWfB6BWmS3ad6CnYFzrib4JB
X-Gm-Gg: AeBDievTCpWCP7Yqt3Kli6yepK9pbL5oTPUoeMX4F5h6sCYCSmI2Sg4GP5gen9WneNs
 FcOOXB7nhrrqBmjNY9Pub/NaF0VRWsW+v5CligPmzLPoz8X4SCgSvcgCxkcZbyp5jKx1E/KgGVm
 /Rz/SZsMXkGlRK/DadwXqk9FUBQEL28Vd0U0iwlpiXlnw/kkTeUcsfhWOe6EIqeNAlsdzHVl75q
 4h9mn+h1qJWFY7K9A0r5PPRwoAWStaKjDNZrDRE1edBKVt1XeD/9AVTy8nA7RzJQRS53bY+3u46
 Og+Ci1v4GDYCTOyQX7KiYCiyGcPzEMlK/5KYgLDrWHw5t4K6uSh6RuFe3L1Z4yO1jntK1+U1xvF
 SQJ7anCtlO6wkEc6bcWSMXKpKGNO03N4tMVRhSHXWqswM7TRosoCrVOdG1EPLVZgXtosMWvYP6N
 v45Pall8DnxoRePkCJ9px7Kdk5Bdv41qGlI75g+wyY/wwZ7zdqrphrGGvaBmVeHH95/h9Ijbc7o
 tD+vL6lHKgZyq8=
X-Received: by 2002:a17:903:1aa4:b0:2b2:5771:4ce5 with SMTP id
 d9443c01a7336-2b5f9d5f6dfmr383386905ad.0.1777191766686; 
 Sun, 26 Apr 2026 01:22:46 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com
 ([106.51.164.157]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0dafcsm284770165ad.52.2026.04.26.01.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 01:22:46 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dakr@kernel.org, aliceryhl@google.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, daniel.almeida@collabora.com, lina+kernel@asahilina.net,
 j@jananu.net, mkchauras@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH V1 0/2] Rust DRM build fix
Date: Sun, 26 Apr 2026 13:52:32 +0530
Message-ID: <20260426082234.2026908-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

rust drm gem shmem doesn't builds due to an import error of ARef from
types instead of sync.

This series fixes that and also makes CONFIG_RUST_DRM_GEM_SHMEM_HELPER
dependent of RUST and making it selectable from menuconfig.

Mukesh Kumar Chaurasiya (IBM) (2):
  rust/drm: import ARef from sync crate
  drm: Make CONFIG_RUST_DRM_GEM_SHMEM_HELPER selectable from menuconfig

 drivers/gpu/drm/Kconfig      | 4 ++--
 rust/kernel/drm/gem/shmem.rs | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.53.0

