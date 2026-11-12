Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A03606A332
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPOKXG9F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4FD10E5B6;
	Thu, 12 Nov 2026 12:57:00 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6373810E4EC
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 01:27:08 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-36e895f329cso71898eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794446827; x=1795051627; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Pf+orCI2rLpYXGk3dzBIrPS1HgJeZ6wmt3S+jICR+IQ=;
 b=qPOKXG9Fg80z/K+XoYqweakXYXzvJxlq3AggyS6CttXa/drgBWKi0dZ7JT2Jc/V7n2
 zeWPOA7PMVe53qQaSOFroqbfMOBO0E3IAExhUPkGnHODh6uPALHJeYwGtRHHmVK0ZsEG
 sIuLV1wuxCdTE4gyPCDx51wnqprthnK64ezGS924BCEP9nJYH8+p+RHILHEj+1jt8+4K
 VAbQudZvZkuC1w2gWDS1L2JKyYP5s8yX0wOeJ29BOuS2saAmBQ7H41QRKiKHwxlRsAe5
 gpwqAyDITjMe6s0UhKuw3xPo1mVgW7MflUsEEpZ02DLb3o7+1vCorbPGZJlaTz3wHi96
 0SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794446827; x=1795051627;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pf+orCI2rLpYXGk3dzBIrPS1HgJeZ6wmt3S+jICR+IQ=;
 b=g/RrunE5b1CaQ0iTlMLA84p2YhKyDs3Y9Us5MRjHLksy2lsgdMvZNXHmBv7dbPpPYs
 ih/mrcFluZzcRIsaLGtYGG1OwDVbHB0oTzkRd+g+Kl9gMGzgREM0bzUdFvt6hRxXSsb0
 nNwVNTUc+y1ZS4meWvGX8JriKQ+bVl2TTDPEWx3APJFux3+D/TdisccPuCWES1uUfxKT
 CkXeEFZjlnJUl8l/nhTkHHaHZ4ueUrGLPQjTkdGylrnhhv2LzaWmijbyQAEnSjSRCzo+
 EQ2hUjYgm8Fgb5rd604v/wfIslYLDmL9UMz/z0eWiAW/yla7pfw9qPsAuVNqC/hBDk9r
 oDXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGFYzuAD5jwSVi8IW0l/WXwymF0pNHkPy5x5sGPaDWhlEy+5Nidt6ZNfI9XEkfFldubIG2b8fcQRJw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8B/X6xRTFZ6uwecIBOdmR+Dh4DDIaLEXKB6i2f4xdblSTmYSuq
 Vcl6itPcRfmK4bebCrUkVSexfZRIIaK7TnCutkJHVAwDV40nzG+47HN52mawH8vSj2u4Kw==
X-Gm-Gg: AYBFou1mwRikjyPd9kpG+NOI7r7IaxM21KlgnjvdLkzjF6YXosll/+FoaOSb7nsvPm4
 5wh8nkHziIlW4NE7SKBUKxvwLgD6lJjvw3PNEKXuEyVUluJsHCOq7ZtUjRXdyJ4+nDZ+s4uqcH8
 fQgA/nTOVGIRWcLe9X8Ky0t7RJNqMjcNSCussNSQl4NXVlYq2c9j3xMwvqOKH3Pvev78YUc0/Wa
 /ZEMCmAKh/pp9RgipfnMNfHNMNEcC6a0fYQxSdm3bP6yf/rVn6ERkWVEsQ2OIESYCzngsCCwtl+
 qQamwxaNsqHHDp0vmtdtSCq9jU2gJBuBsueLcOxpdQghiRbEErfUQd+jiNG3m0nAnYM2cTJXHQT
 WgKjmVQPTuRW04ZF84Q0n9JskUann39Lq/L+NnHsnjGggGG+vamdJGAJzpzTpfInEyNRZMl1oW1
 3s2HZnSdSXlZ5HeUzjcXMpu7mMQGWL3wB0yuhOjN3bsp1mZtaS+8SCMy2sAvpnVqlXyIohXfSFc
 x3vdJa9GNIlnDp73ThnQ2af0bwO36iI+o5bi37ETwEKxDxeLQ457qvnqZ0dkydKwBcgQcqowKSs
 MBG6nF4dH6UMu5QlHrLy2wWq1+KR6cfBa+RDfEAzCzsnFDxRguvHOLrELjZKuV0jjec=
X-Received: by 2002:a05:701b:42c7:20b0:1b2:5884:a039 with SMTP id
 a92af1059eb24-1b3c0151554mr6228487c88.0.1794446827180; 
 Wed, 11 Nov 2026 17:27:07 -0800 (PST)
Received: from o6.lan ([2602:fce1:44f:115e::])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3b5b2ff3bsm24887181c88.11.2026.11.11.17.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 17:27:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] mm/zsmalloc: remove CONFIG_ZSMALLOC_STAT
From: Xueyuan Chen <xueyuan.chen21@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Xueyuan Chen <xueyuan.chen21@gmail.com>, 
 Minchan Kim <minchan@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Helen Koike <helen.fornazier@gmail.com>, 
 Vignesh Raman <vignesh.raman@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Nhat Pham <nphamcs@gmail.com>
In-Reply-To: <a7b1d671-18b0-44e8-b112-ab66893b3bf4@infradead.org>
References: <20261111-zsmalloc_stat-v3-1-2d85ed51570e@gmail.com>
 <a7b1d671-18b0-44e8-b112-ab66893b3bf4@infradead.org>
Date: Thu, 12 Nov 2026 09:26:55 +0800
Message-Id: <179444681565.2553194.6533752746321637708.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:57:00 +0000
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-11 16:26 -0800, Randy Dunlap wrote:
> 
> 
> On 11/11/26 4:41 AM, Xueyuan Chen wrote:
> > CONFIG_ZSMALLOC_STAT only controls the debugfs interface. The class
> > counters are updated regardless of this option.
> > 
> > Remove the CONFIG_ZSMALLOC_STAT guards and rely on the debugfs API
> > stubs when CONFIG_DEBUG_FS=n. Skip statistics setup silently when
> > debugfs is unavailable.
> > 
> > Remove the Kconfig entry and replace the existing CONFIG_ZSMALLOC_STAT
> > settings with CONFIG_DEBUG_FS=y. Update the English and Chinese
> > documentation to match, and clarify the pool name in the debugfs path.
> > 
> > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > Signed-off-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks!
> Thanks.
> 
> > ---
> > Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional. The
> > option only controls the debugfs interface, while the class counters are
> > updated unconditionally. Removing it simplifies the code.
> > 
> > Following Nhat's suggestion, remove CONFIG_ZSMALLOC_STAT and rely on
> > the existing debugfs API stubs when CONFIG_DEBUG_FS=n.
> > ---
> > Changes in v3:
> > - Squash the three patches into one (Nhat, Sergey).
> > - Add Nhat's Reviewed-by.
> > - Update the documentation wording.
> > - Link to v2: https://patch.msgid.link/20261109-zsmalloc_stat-v2-0-caee41684aba@gmail.com
> > 
> > Changes in v2:
> > - Drop CONFIG_ZSMALLOC_STAT instead of making the counters conditional.
> > - Update configuration files and documentation.
> > - Link to v1: https://patch.msgid.link/20261106-zsmalloc_stat-v1-1-b574f4714adf@gmail.com
> > ---
> >  Documentation/mm/zsmalloc.rst                    |  4 +--
> >  Documentation/translations/zh_CN/mm/zsmalloc.rst |  2 +-
> >  arch/s390/configs/debug_defconfig                |  2 +-
> >  arch/s390/configs/defconfig                      |  2 +-
> >  drivers/gpu/drm/ci/arm.config                    |  2 +-
> >  drivers/gpu/drm/ci/arm64.config                  |  2 +-
> >  drivers/gpu/drm/ci/x86_64.config                 |  2 +-
> >  mm/Kconfig                                       |  9 -------
> >  mm/zsmalloc.c                                    | 33 ++----------------------
> >  9 files changed, 10 insertions(+), 48 deletions(-)
> 
> 
> -- 
> ~Randy
> 
> 


