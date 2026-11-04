Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5A606E829
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z2b4S2S7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A29E10E25C;
	Wed,  4 Nov 2026 20:02:16 +0000 (UTC)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837F910E25C
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:02:10 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1aefd1bf74aso1000800c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793822530; x=1794427330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=snH4D1yne3D/mpsYO+9jWAO5X0a2o/1BALUeP4JZhFE=;
 b=z2b4S2S7dCHAVIqPziUiUnGvsyS4K0YYbBQgdMNqO5PH09cwJPJWOPN2cvYwxRgpnT
 D/64ngDMooroJ0m9oOW58Kww49UDC8wQCRDdgZEG6g7TDq9wnJtNRjS/YcG9QswWfbpa
 4v/kiIXjb81z6bkraCLSlucp4AqDEk/Vb5Qh7xTePyXGd8yWyo05rAbnyz0d5t1zoyN/
 dHb/gNtrNhUlcGNOJKQaTZ+O7PNBnc2X0VOrzb8+1iYV1cLqvJKK8j/8Jy6x9fDPBVVV
 sWq58pZRyhbfEwCJL+VpI7/GXzeZffVjPoALPpGRP+saYhM8VPfnuytrJeubepDvSFtb
 LIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793822530; x=1794427330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=snH4D1yne3D/mpsYO+9jWAO5X0a2o/1BALUeP4JZhFE=;
 b=PMW35z4q6vQz1kqYuCSL199tE7yonjyRaJ0dxYggtec14FlgM4ENM63DgcYymsBeWR
 9oQqSBR659lYtecKV2CYQmHU2mmXOp3xlrNWdTRYzM85BnKsggjdBNLa0p+iFRucwLqZ
 K1AJ/Wg3bnvv9Pv9bMZIuXd+36pZATP+lns3NngCC4j7feSB4fsLJ/dJkOx9c1SK9YXQ
 fkm1oOogal9YDUB1WVNWK1dr2eDN2N97u8EKfqK5cv2fQ0thyJsnuOH089qvikZ+bB+R
 i06D2sZX9DhcOZzM37d/l/ad8SBr2boywQ8VF84MTSkXND8vZm/8mQWgZIGy/KG4cttu
 8enQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyFNMHqUaFJfqaewanU8So8Q6bxysplmRyMhHYT0afMDc9k15HvVD5zavWU3R4loellA1KkUZbeQY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/QBofgMvdZSVQ2ltnn5WuupnU8FmUt27yGxSB1Wn4YQWTxPf8X
 cwrrDzsL3iKTFuH8KNd7B11zNZPSG7xPSLoWX1E6CvguC8gOTpje2W4=
X-Gm-Gg: AYBFou0s702AVLYgAKrqzl0sMhxnj1NnN7uRlSLB9DWK/eraAflm8a5Zl6CpY88gpJz
 j/6OIDABruQWZ5sXaewDAPZluMntajeRVtBcQ22fN5sIe/LJcW2J6fltYfhEdK/Q5m7RG0PETvI
 Zu4+Zgrq7aJ7P97UbAme1YN9u+a7dYRvDCFOYiaQTMByXbEAPm+VuGIBH6O/BihdOLBm0o/MR0S
 mvVTvz+HmvDc5erIe7RVpAYD/KkbbAQ2aLXnw3jjqS498OUtiGlwsOd7yqN1ocb2zGXKMeBUtzi
 ZKm8CKPIVkMDql03jzyjYf/1A7sbySI490JmqcEZzmBUh+VzLPUyh4Shr1bweLIMtlclt2Zn3ya
 R/6xmfGbJa7E9ry5bpbV+FlhmQUD+lQ+qZA4IifywYwHppwNCHtr30nNI4v51r8EgQi8SmZ9MG7
 JSNDwZgekMCwSv9yLokfzDl1Pd9/keNaTFNMfzH3AYOudIUuB9mTVtIMFuvvz9WYR0HFleQOOAs
 VTuyFvyF4bIYQvZroiiVtGaWxrhYNeDLuteEpBKF9ERLDVRrTbH/x2f6K48fzfNPnyPddDMlRGl
 bsuRdeE0d5ruRMMps9EyypRpfr9xGZPVI41v/kEKu2ID89GsIZBwWLvn+F5VnZQl
X-Received: by 2002:a05:7022:f90d:b0:151:7831:e403 with SMTP id
 a92af1059eb24-1b24f44df52mr534313c88.13.1793822529479; 
 Wed, 04 Nov 2026 12:02:09 -0800 (PST)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.194.66.249])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm12453149c88.15.2026.11.04.12.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 12:02:09 -0800 (PST)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: alexdeucher@gmail.com
Cc: airlied@gmail.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, atharvatiwarilinuxdev@gmail.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 harry.wentland@amd.com, linux-kernel@vger.kernel.org, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com
Subject: Re: [PATCH] drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2
Date: Wed,  4 Nov 2026 15:02:01 -0500
Message-ID: <20261104200201.8358-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_PjiWHEDzS5DJgB1wS72_tHp4Ju5Wwr0R0N5EK-i9fXfQ@mail.gmail.com>
References: <CADnq5_PjiWHEDzS5DJgB1wS72_tHp4Ju5Wwr0R0N5EK-i9fXfQ@mail.gmail.com>
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

> What's the reason for this change?

This is the code that fixes the SMU boot issue, that we discussed eariler:

https://lore.kernel.org/all/20261103160553.1431-1-atharvatiwarilinuxdev@gmail.com/

Its confirmed to be 0x4F1 as OCLP enables it, and with OCLP and no patches it booted fine.

I plan to add 5K support to efi libstub or something in the future, hence the TODO, so we
get 5K in simpledrm and get rid of this not good looking quirk.
