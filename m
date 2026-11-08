Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A3606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 05:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UT8guxzx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C508310EAB2;
	Sun,  8 Nov 2026 05:22:22 +0000 (UTC)
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00AFF10EACA
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 05:22:15 +0000 (UTC)
Received: by mail-pj2-f3.google.com with SMTP id
 98e67ed59e1d1-3adc0ac3566so92387a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 21:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794115335; x=1794720135; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eohJ0DCIaSvFxowjPTLeEGZzQ8vwQ/i8uAHLdRHVZ2Q=;
 b=UT8guxzx05fEHM/mLbLNvwRLnwMlhEwaLwmC403+1QWxyO0QgopblsVHuK/ahqGOLr
 kgvFQP5ch7sgyd8immYI+ZuaTWMxK5QQMNmmIS4ucAeYRJNSwg4Mbu27FFtJc8Vio7at
 PtZug1pWf+vCW9ekqAxHa9ZmjidQ2jG7s0vEwVP0kq0y2jWgPjFtz7qnbSRtNBdTDg1w
 ICAsNdgxiF8zlXrjK4/zl7dNMrxMOPFj0wSftHZDQGcyeja/XuQsmeBoERcfozBUzPYD
 8KrIDxTmerjDurN2Yhfr9dsm2p9MW5zZcU75klRLjSnWKH1Zfz0ahUpcYCoDwQedCA5k
 PAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794115335; x=1794720135;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eohJ0DCIaSvFxowjPTLeEGZzQ8vwQ/i8uAHLdRHVZ2Q=;
 b=F831EnRMoMR/YjUas1W2fiAg6akbkNN7SfsIDe20X0xIdrizelVKcsHXOVujxSYlvZ
 VrXiK9TyazT/UkaHUuevjUff2vhcgeH54r9rgxR8+jb0bUvBYGmgcJo0mUW59hBsB0z2
 sG54OSNNXIr6PPf9zOlw+Yhpptf6huGSagbvVPWWDP68dgfonqvMTTM4srOAJAsbPdfg
 C3p4XW+t2G7Iyla5jPfmtQ2VA0w6orWV1YrL0+vGXmIKtcTdsclwA0WzAGxVk2f2G9BD
 FYj6UJ7CTxaQTxBfl5dLeYnKCPKhz3fuMMsSDS4rt954MM6OYGLCFfDXG7MsqUjcQ9Lp
 4yXw==
X-Forwarded-Encrypted: i=1;
 AL+hErHJFv4MH6pHY6pz8aX9G6NKo8cdov2POCq5Lt7Do6Zvf/Jy5VGPHD32WSeY+Oc7BJ/pb0AtDhUkMjU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ANl+DugnVfkR182ZHNxegKHWOPb8tksbhUdt5nerodo4pajH5
 NmxZ6jLmotzDO2JyticDIMgFKNFxDpfSHg1xJbKy66A4Ozzt3lxA4PFJ
X-Gm-Gg: AYBFou2ufosa3qdFeC8+bYurL9P73bWKzPU0lwix6sPCynLqq7YWuekEwiP5kpRC4JJ
 59fS1JAwtOQxfDGnnN9xMHYuU9+44qdhEJ5zJwGFR8d9AK/MGgo+YeE+lkcixiMC5uPINgyHaM+
 ILNzZYSMTJrF5Nn5s+3RQ0kMJqIrWsCqRhF8PakVO340l9lkZzw5d4E/V08nsYhVgZg3TxX0JB/
 PLvSDHq5xIdoNrBEYFCGwhVlyDCjpxs2NHW5MtXcR4GGp+QvkmAwIvLep1Qw/4cpQvKOIuzSgZL
 xyHiW3fAIlii8dXVq1dgN1yOcihW+z29iiDFIavsAR8PbsFYMuThtD/fezc7Vopog+tK9h0YxHA
 nb22QKUZyf8uy28RTgM2tD1Um81el2vVqguRra1UjXRmvGZxkIY6eiZ4C9LqNJayInH2fPth+fA
 MBTxYT5oUryiVQwzSGfATf11j6wgw/MNs4eFqfHw4fdwbp4V+D3PxnYoNJQ+Bvjv7IbFM2ff/zm
 fKu/I63qauqxU3lolLyAw5DBzhAqfuThfhZGlf7T6pG1g8o+yS3+h+vZhRmviMEMNbXvCyVSJKd
 pRfFjYteS84Y/pLWcnZcHbc7z/CXFJXALUb2mndXcGTNdSz+cgpjeNYNpO00Okki3thx3fwkGko
 CSm5PoYxFz5HNoesGEh3M+V+avw==
X-Received: by 2002:a17:90b:5903:b0:3b0:9bfa:72b1 with SMTP id
 98e67ed59e1d1-3b12d4dafb6mr493467a91.49.1794115335433; 
 Sat, 07 Nov 2026 21:22:15 -0800 (PST)
Received: from [192.168.50.20] (42-98-155-143.static.netvigator.com.
 [42.98.155.143]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1058a7b29sm5647629a91.10.2026.11.07.21.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 21:22:15 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Subject: [PATCH 0/2] drm/amdkfd: fix SVM error handling
Date: Sun, 08 Nov 2026 16:13:32 +1100
Message-Id: <20261108-kfd-svm-baseline-errors-20261107-v1-0-9ef4008019ab@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNyw6CMBBFf4XM2kl4iKi/YlyUdoBRac2MEhPCv
 9uiLM/NzTkzKAmTwjmbQWhi5eAjFLsM7GB8T8guMpR5eSiK/Ij3zqFOI7ZG6cGekESCKP4PDVZ
 1bSqX231zKiFqnkIdf9bE5fpjfbc3sq/kTY+kwlaMt0OatkIXhLj3OIkZN321dmFZvi4pfai5A
 AAA
X-Change-ID: 20261108-kfd-svm-baseline-errors-20261107-355a3d0c4792
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Philip Yang <Philip.Yang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, 
 honghuan@amd.com, honglei1.huang@amd.com, psirt@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These patches fix two error paths found while reviewing KFD SVM range
handling. A failed interval notifier registration can leave a published
range without a notifier, and an HMM allocation failure can lead to a
NULL notifier dereference during validation.

The fixes were tested with targeted KUnit tests under KVM with KASAN and
lockdep. The error paths use injected failures or equivalent failure
states; no AMD GPU was tested.

---
Aveline Noir (2):
      drm/amdkfd: handle SVM interval notifier registration failures
      drm/amdkfd: check HMM errors before testing range validity

 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 58 +++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 14 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-kfd-svm-baseline-errors-20261107-355a3d0c4792

Best regards,
--  
Aveline Noir <jm5905938@gmail.com>

