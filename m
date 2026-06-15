Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B38ACD98EE
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1EE10EB26;
	Tue, 16 Jun 2026 18:17:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ibcdUB9Y";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC8910E5C7
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 18:13:39 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso27435235e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781547218; x=1782152018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMIhznq4b/swPnkGP6rrvAKBGuzPasq5bzsDh1wVz04=;
 b=ibcdUB9YYvigqcocfOY3SEuz83wxSPBN1bFcGUZHcyJUysjeg4mrQLMRT8n2XqzpZx
 e4t1oUa9k2QrPK3MohvA0ZP2qTd08FzHs53+NMU2o5O0APaLy7SEm5nPVNY5IvVqINzM
 d+YEDczg43rtCUw1pwm4uaUB4w3aJmY0RvufVD9JQgrpIy/n94mHY/tuxiQ1hm56yVuF
 E1GSWAFoG+doLTnxJJjnH1ze+jhYumusfTaN5qqoFTo8EZYOE7D5k5m2Kj17PI20LrTt
 cHnT+Hy6lQOfY6YRcKW/roFpfdQbprlEx6YBBh0obik9y1RS2tJWeRxiS1RD6KDHzkSo
 eGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781547218; x=1782152018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CMIhznq4b/swPnkGP6rrvAKBGuzPasq5bzsDh1wVz04=;
 b=E0F0QIVCZB6n6WEIGQCs8bYeBALGBerRBuXJJjKK6/zrRIBpUCIiYbqXpnX1VvAbaj
 yEZPwKZP6Qzzs/dVBzidE1CbLXumMDto9OPI1xlqoZa8G/Ab3iWgT/33Bem1EZ5aKE30
 1FTS1r2BMbWRCC3fMCQXq2FPTSUWu9L77qCkMpw9O9JbyXxGbnNTjA5yUGZs7I1N/dV7
 J3mR1c9pP2fY31GNh1tOJdVjsmNGWKfIn4iOKWwpPq9KkQDATc+tIH2BLTF+OQf96Ge+
 6Tqy7ya4BtUI1GMDNInAkPdvE2/5eywWVCXy1tBypTNMyG13aCyIn5fSsjbgJRtBU99S
 4Hgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nbNdJL/ZaxnehS29b8H0CUDA/2PXYnfb+OJ90v2vXlms6AUjKmEl2tu0aCmEzfv1W2YXgjr3S0cM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRAgS3bpEJ+mfU62q3Fx5RhJz4Ep9/kfyBYeQXFB9a7yPOBmsM
 H87oGok5hofTck1A9jjPmZhQZuwZ58ZOdAwUdBgjRELjoxLk/yx9a+KI
X-Gm-Gg: Acq92OFH2UVv4PV4UfJ15W51HMRPp7oF9C2/Eg8AXCkUAPCtRmnmPedVNSpc7uxGqXq
 6Z4+XpsGF7OJ89ixZSDIlQYZ/wuxKDRB23pHdBUlBujNdh/d1RDKbtFRkFlHm5dtAEBQMPTf3e1
 ZZwwxQ5XsgvFZhaiHtruyDjyCEE2e2VIy508a6cegQOE92UCH8oGz7BoyGfJxG+Jaw/kIcp4u8U
 0uYn0w2Ibb0Y2So5swZ8Ebx9Ms8mraq/7wGXj+k0Uw2mI/tCV/upSme0LMyzfcBXEYYqjqWFrLD
 /0iN0Zc4DOqWOANJ63RCuhb6Vv+c3YPJFZQB3UwkVKKr4dhqU1i1UA8JVA0x5CI44SgWaZVgS0L
 khVMTwhcdd8fW8AI4NzGXKF0Tep/ghrHQ1X135CndHDxoqDAcyj0KGZVbNrgYWI8J6ibhhl/RHL
 Rg/KIdOpp+6zTEVzORk8W1eHNg37btzRnnDQTLlx4u
X-Received: by 2002:a05:600c:34c3:b0:490:c2a2:e91e with SMTP id
 5b1f17b1804b1-4922ffc0622mr4405035e9.34.1781547218243; 
 Mon, 15 Jun 2026 11:13:38 -0700 (PDT)
Received: from anthony ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619b9b7750sm8954343f8f.6.2026.06.15.11.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:13:37 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Amit Barzilai <amit.barzilai22@gmail.com>, airlied@gmail.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Subject: Re: [PATCH 0/2] drm: Add driver for the Solomon SSD1351 OLED
 controller
Date: Mon, 15 Jun 2026 21:12:49 +0300
Message-ID: <20260615181253.97551-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <877bo576o1.fsf@ocarina.mail-host-address-is-not-set>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:17:58 +0000
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

Hi Javier,

Thanks you for the detailed review and for the Reviewed-by on the binding.

I agree with folding the SSD1351 into ssd130x rather than keeping it
standalone. My plan for the v2 driver series follows your two steps:

  1. Add RGB565 support to the existing SSD133X family (so the SSD1331 gains
     65k color), gating the format on a per-variant flag in device_info so the
     existing RGB332 path is untouched.
  2. Add a new SSD135X family for the SSD1351 on top of that, reusing the
     ssd133x data path (the update_rect window logic is already
     format-agnostic) and adding only the SSD1351-specific bits - the 0x5c
     write-RAM command and its init sequence.

I'm deferring step 3 (native 256k color) for now since, as you suspected, 
there's no matching DRM fourcc, and I'm dropping the 0/180 rotation support
to keep the series focused; it can come back later.

Two things I'd like to confirm before I send the series:

  - I have an SSD1331 panel, but it is currently unsoldered and I don't have
    the means to solder it myself. I'm trying to arrange testing through
    someone else - I can't promise it will work out. If it doesn't, the
    SSD1331 RGB565 change would be compile-tested only (I do have SSD1351
    hardware to test the new family). Is compile-tested-only acceptable for
    the SSD1331 part, or would you prefer I hold that piece until it can be
    verified on hardware?
  - Could you confirm the RGB565 byte order the SSD1331 expects? The
    standalone SSD1351 code used big-endian (drm_fb_xrgb8888_to_rgb565be);
    I want the shared conversion helper to match the SSD1331 datasheet.

Separately, I've sent the DT binding as a standalone v2. Since I dropped the
width/height and rotation properties per Krzysztof's review, I did not carry
your Reviewed-by forward - please re-review at your convenience.

Thanks,
Amit
