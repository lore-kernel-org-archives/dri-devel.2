Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0888560A261D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M+svyMyM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ABB010F819;
	Tue, 20 Oct 2026 22:50:18 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C365E10F7F3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 22:50:11 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4956869750eso569015e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 15:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792536610; x=1793141410; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fTuhXEhm4uQNNaPcVdFpwpAupMps3PVyoq78rLHpKEo=;
 b=M+svyMyM8StOYlCmzz6CUZ8FP5Qh2VZkiqIy3kkZT63dX3FjGTjaEviXXJB9+obinZ
 dzFTNT5QPjF1eimQxR7DGBDvDSXrZ8uqWPFD9J85/SDOyDZQEKfW9imI+ifpplfd+quk
 HH4TIZEb9KonRiG6LeosFvkkVG9ewf+uqKPEScA9O68laDDJyVq6TjPcdIC0qgKwIJgC
 SH+Kpw2lyJc6KMNSvj52k94vuJ+MejpExSczW1cQ6BCgX9VEGVi+ZJFfHpESIqB2jz74
 T3fcmLzRnGuviYDi8dREsZgRu/74n7ri51856X62F0sbjannyOoReGSgURnMSAWjBUOh
 eQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792536610; x=1793141410;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fTuhXEhm4uQNNaPcVdFpwpAupMps3PVyoq78rLHpKEo=;
 b=B6iPYnN77DA/nD5rWTBiI1mJFjCHc2Lhly8SNxUOHlwvC61kEZUw0OXASuHtOaZBEV
 oVA5zU6AONNd7ivDUoKkvo9YMRjqQEtxPXS5RxdFjCT2YUtRd3keAHvKoX0XI0dKlHZT
 hf1DEEH3+RO+XX7rEOYB262N0evBZhXOtLUTgAVARjMpziNsA/dqaLxuy1PmYzS4Nb7Z
 lzSMJP1D2m0odo1WkvGfLvDgSVmkVIYjttXYV9ucLn7cnK2AXlQ5k45CZ2p0tqzeKAgb
 v5JyGmv5tAnhQV8y9om8fT/ICYPOSxTKH23hKUpcZn0E9HMpU226yNFP1oi4GoEv40A1
 6WYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaf/8mDC/tw/rZer/8XZCV9S6te7vpv/UxZ789oyuDCBVlu8lrE8JDNC1eKeoxnb7tZNhGeNw1V8c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKQ6Qvc1/JHPrE7AH8lU4fe9v8tXR2o9EsHXxDze1k6YsHBUdIu
 qwJl7R1fGMkjzf0IrnidJcX3YmmZksrxlm196Z3KiByxgjbTbgDkwLC/
X-Gm-Gg: AYBFou09tJXdZ/uTbLlzN5SHiZgQokDuPq3ouzV1Z+HZAuMRlddP+TpVFBV9GISU8HP
 TgPR7oEDUWWhSokXwVNuvh1X99plmpJcXsen90PICBTmnk+mFLf5Zfb6q5EiNIvTr1jOCvC8yuK
 aD60DuEQBtynXgMlPEAth4wI0m1+kueq1azbTCnPGRoQS1XJaNFgtRSIxIoo13IMKnkapwtZ2OM
 45Tkeib13LTgOH7d/L3Nq6M9dVHjDJO9gTFgQkhrGil5HPNWpmP+Qek65xY19V5tttFu3K5Ir62
 4EFBtP7eIhDq2Yo6bkB7mNsuiGG6NhHmUNrAhqT55Y1nFHWmUS6fmjFMp45PW0qTK+ryAT+Vh+q
 EPG0l2j/ay5gmwjMRCyUwF1eizXMFgT6Ii0hZm/y1bRt1s6MzIm1lorkt0U9UnyYmFucixg/kl3
 kqIqjKMIXWetd+e5AlXkGEfNtzikk6P/8Kn36zNxUqPKuLn+Z8w2GMsrEROu2/VrSEkI0MkoCpQ
 iTm0u6rP0C2ue9guqKZqISe
X-Received: by 2002:a05:600d:82c1:b0:4a1:811c:8069 with SMTP id
 5b1f17b1804b1-4a1fdd20c2amr2908965e9.8.1792536609700; 
 Tue, 20 Oct 2026 15:50:09 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0b42bdsm17511805e9.0.2026.10.20.15.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 15:50:09 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/13] efi: bgrt: add accessors for the boot graphics
Date: Wed, 21 Oct 2026 02:50:00 +0200
Message-Id: <20261021005006.2341200-1-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <1d3aecdb-2537-4f08-a4d2-22c81ebaca03@suse.de>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
 <20261013093243.505776-3-maximpedraza@gmail.com>
 <1d3aecdb-2537-4f08-a4d2-22c81ebaca03@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thomas,

Am 20.10.26 um 11:13 schrieb Thomas Zimmermann:
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks! One change since v5, so you know before I carry the tag:
efi_bgrt_has_image() now also checks that the image address, a u64 in
the table, fits in phys_addr_t. On 32-bit kernels without PAE an image
above 4 GiB would otherwise be reported as there, and
efi_bgrt_image_address() would return the truncated address. I'll keep
your Reviewed-by unless you object.

Best regards,
Màxim
