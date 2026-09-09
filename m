Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC198C79FB8
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 08:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C6E10EFD4;
	Wed,  9 Sep 2026 08:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aicharmers.com header.i=@aicharmers.com header.b="R+kP+yg3";
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCFE10EFA3
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 08:02:48 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-6b1a0d75a4fso3235852eaf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aicharmers.com; s=google; t=1788940967; x=1789545767;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NVqqZQHFQjLI1fAxKN559sk1nfYU8tizBv/uHckeKLc=;
 b=R+kP+yg3QJNTk72tu7e2BL89ydoHMmTyFAf1NnZqgDDuZzvSBUQ/IawE+XHztjVMiE
 UAY79cO3rMCvP3KkFs3qQWVTZ9LmsX+0Hfjfzblf6pDuj8wjz6EIkCpMuvqffdLWjO6z
 9sRIVEG3M33H/f7yut6RDJSL/azMr2GmBL0ov4tszynWEYQBbetYUdiPT0kwrlOhL6vC
 P6iAhyCgSjglgybU1hyFfN6zLocYWMc8IjSE2ObrPFN+rOoHl73Xu3GUP0oW/QsBwSd1
 YYOZ5rCuPr6M/SSQ3MCKS7/FiOI+JrmeqR26cspU/WCyGoD8Cg4YXwQj4KmY5NVLlxvF
 hoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788940967; x=1789545767;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NVqqZQHFQjLI1fAxKN559sk1nfYU8tizBv/uHckeKLc=;
 b=F376ADxZXRt7NSdwAbgQMqBPh6jUFe2SOyPbn3c1WWKq+aO6tJH1owBcDb9ZhvjxNF
 jvbLhvmL+ttRRc1O8RoWAvWRzWcOlqgqTQEVwtKr7utlSWI8UePe4s450hczfEf0QXtN
 KbWf9ojK5VqymhWrW4gbz6l0I9/qeFuI0INGS8MD7riIlVDK5JWS/Z0/gs0Up8TVYLO5
 w4flFFsG4qRBgRA+5BE3It/9JZXxlbWNvi1H4FqQbGAqH4QId/sHwFYpvbt8UruW9ix3
 6iwmgl7DvbWnjQWU3nE4mov4caf+w1BMNR0SGIGTH0FWZifQu5W19/i1sM6ynYo/JLBO
 tjSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhAXSFxTG8TIHbg74r4VxclS7NNEs0JRg3ngRo+HLe4wr/mbJY1+SZp1fpU9f31T9HfQJqqYUR8s4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mJdnwmpcLrqZ/iTqGINMfbsy6qJlciWJ9kKcLsfR+dIU4in2HS
 mhLnZ5skw2tQnT41PUF/5/FEahnmr53hs4ekBx4ufolist5WeSerdGRMKKsNbopSgFA=
X-Gm-Gg: AYBFou2sIyuAB6skeYLWU/AB3ZIAFVYKohzk9LQlksUXMMNst+pd2BaxJRhhxNnWVgu
 aObqirmdYsI+Fmwhbey0O5h6xE/P0dEkDRZNVqutXwdzmEWE/meZXxUypBF5KdIltbVTQscF60M
 hzQOcRB6yweDEg59oeS9Ci/l8bTzD3zhgVZWE1AAdxPfg/gypLpGsnvZ3kcAYm1/Ypw5RxeCt0b
 D/R6mNILnufQmN5LkeyxEdXf81489CDUBmKCadTBfRC6mI3WOZpA+MGvZ4xbvojJa54kxL6PUHA
 c7vhWpmTkgWoM4BtQHt+6G2Vpe8G5DFbBl+JY6xBn4QuEuq7423DNAswENNkv5A9Jw/Flpz9MiZ
 Ew5cy0y7lyB0Bquc52E11TW2NHY66W9tUKOwM+4LNHk33vZccDJ8WwNgYYokD6el2xeWpqrwxkO
 EJDuOVcqXifmrIeWs7osmqCIo/FrKLGnoeiC96Xs7ocVwnSA79Yx15X4wOgw2JEg+Kkyk0wvjdA
 X2oTszzFA6uioIBOEFCT3JNFB0unPrMgeyPy1u89J0AiWsFRtUMhKFXANWmXwolihiuBlUjKtme
 8pBfxwEKIi+QJnzhSt3CDNK+rB8JJhv28fO0CKV2yDNU
X-Received: by 2002:a05:6820:16a1:b0:6be:9627:196 with SMTP id
 006d021491bc7-6be962710ffmr414461eaf.7.1788940966464; 
 Wed, 09 Sep 2026 01:02:46 -0700 (PDT)
Received: from ip-192-168-20-24.ap-southeast-2.compute.internal
 (167-179-142-232.a7b38e.mel.nbn.aussiebb.net. [167.179.142.232])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbf1feesm42549886eec.26.2026.09.09.01.02.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 09 Sep 2026 01:02:45 -0700 (PDT)
From: Ed Schofield <ed@aicharmers.com>
To: Kenneth Feng <Kenneth.Feng@amd.com>
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
 "Guna R . Bharati" <062bel313@gmail.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>, airlied@gmail.com,
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu/smu: Enable UCLK after init in AMD Radeon Pro
 5300
Date: Wed,  9 Sep 2026 18:02:09 +1000
Message-ID: <20260909080231.85025-1-ed@aicharmers.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260824190409.1724-1-atharvatiwarilinuxdev@gmail.com>
 <MW4PR12MB6803F4CF9FA37FAE2FB0C5778EB02@MW4PR12MB6803.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 08:38:27 +0000
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

Hi Kenneth, hi Atharva,

Thanks for bringing the two threads together. I've tried your suggestion on my iMac20,1 (1002:7340 / 106b:0218, revision 0x41), with SMU firmware 53.38.0. I tried two warm boots and both failed.

On the same AMD staging base as my RFC, I moved UCLK enablement to the beginning of navi10_set_default_dpm_table(), along with the readback check and supported-feature update. I removed the later enable and refresh from post-init. UCLK was still excluded from enable-all, and both memory-voltage features stayed the same. I didn't add any delay or extra mailbox tracing.

Both boots reported:

    SMU: No response msg_reg: 8 resp_reg: 0
    in params:00000008
    Apple 0218 default-table UCLK enable failed: -62

AMDGPU failed to bind in both cases. I checked that the experimental module was loaded and the firmware files hadn't changed.

This also fits an earlier test with T2 7.1.8. With UCLK excluded from enable-all, I tried enabling it separately immediately after smu_v11_0_system_features_control(smu, true) returned successfully. The trace shows EnableAllSmuFeatures returning 0x1, then EnableSmuFeaturesLow with argument 0x8 timing out with response 0 and -ETIME.

The default-table function is reached only after enable-all returns successfully, so waiting for that acknowledgement doesn't seem to be enough on this board. I don't yet know whether it needs more time or some other initialization step. I'd keep post-init for now: that version passed the ten recorded AMD staging warm boots. These tests don't establish the earliest safe point.

As for Apple, I can't speak for Apple or confirm their approval. I'm testing this as a Linux user. Do we need their input before merging an Apple-specific workaround? If so, could AMD help find the right contact? I'd still welcome a fix for the underlying firmware problem.

I agree we should coordinate the two patches. Mine covers only 0218/rev 0x41; Atharva's covers 0219. We'd need to test the combined change on both boards before broadening the match.

Thanks!
    Ed
