Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A4606A8A7
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAB91127C4;
	Fri, 13 Nov 2026 21:10:55 +0000 (UTC)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6126A1127CB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 21:10:54 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-67c246c0c60so2472544d50.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 13:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794604253; x=1795209053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GN0ortW4nQvstQDFiIJ5PqM8QgjEi3y1N04o3CsU+ao=;
 b=SA23eO2eae9E+6TYjKMSGmYrBXgIkwGBLWlO29+i8MzkzByhLD4eZCRhRVyHQsTdKH
 OgModVm2nCoWt5GrIaglQLcExLTEYz31OtA13h4HbLwYTonM6T2LzmjCHj8EPYk0+QYt
 C3i60AjVkZLmRCYjPLJcPhZ+gS6mWpAsLs2+u98SVNlmKpLq2EmFNPBHhBpM8fgkzx2n
 m3lksZw/kwwSy3GiLqi3Q80VnTU7L3Y4279gzONgFGSWMV265Ac3nCrCLb4ZyL/p0oxI
 VxigtzoNb02EeL240CNW+xK6qmtDdvW8//HeJ3pP95oa6hYmiB3l4GmIl6JyzlC/+j3J
 zJFQ==
X-Gm-Message-State: APuU4Z9frkPG5FAYhAhb1m517FHuflKyNuYpYRl365hCqrh+wEM7ivCj
 Sb1oaWswIZfT8+Mj3l1DKH5vAuKst9DQNZnjZn5ihBfY+4tp2pKZIDnrQjZsdJ7UUQs=
X-Gm-Gg: AYBFou1RX7xxRyN8kNlZ+kIfYu4dmpeBxg41y0IXkRfvF+TvpymXhgSb/1uDHqjUCin
 3TmWbEjorIF5FSc/O/0vkQ483wRqxs8U81SULGVJeL6cYVElE5MOx1fzr1yrFSe2nDoHjO6zvHU
 OyQRaSeH/qb0capTvUgx2ME4Lk1bJJyUv/b1QJ6qamlQujcgVq63ibxTDnRppyYhR+uPJbGF8TK
 EZcrM2gZ+oIQyw6hKMr3lh05Lx7r/JsWUqZOV97OzRmQrsVDtpM2zpBY0zJJFsn6FKmDQ89zy2g
 0Bkg0Hggungb/ae8jXhwC+UvsUo9rIw5cdexRwctUkeYo56y1ATWIaD1FNFfFFm0Poa2P8wrj1m
 NB2z8lgJGRHYI+5jH0NKBs9Ntmuk2REdss7i0SwQBKoQSj80F81QGpRny8uHZvtJYPWfovxbmyM
 vRuYy8fpNNcvgpkPMbiaSHXxxs+nOkkYmok5ZCu0mws2bLIMpGeiJLaSzgjHZIJVF54OBawqjl3
 wKqJPRiePSFrFSKZFGnv1+lzNqnC6vl4I08Lvur0zxAqGfq1SVbOz/9lE1hKtj7+8xXp7WQJ66A
 LRFYxI+ZUC7JXJDcc2NmIE/CJX2+l3W/Waq142Lb5WrBL1x0+PVksHEhSEtTvH1D5ckcqFHq6co
 ntgwT029CLdFat8BuBIUEi3A1Im/D3SbwtvdtC68YR0NlBBocr5Qi
X-Received: by 2002:a05:690e:190d:b0:67b:fc94:86d4 with SMTP id
 956f58d0204a3-67c78c3c92emr4305281d50.8.1794604253368; 
 Fri, 13 Nov 2026 13:10:53 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67d8a64b04bsm3050965d50.23.2026.11.13.13.10.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 13:10:52 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 christian.koenig@amd.com, thomas.hellstrom@linux.intel.com,
 imagination@lists.freedesktop.org, frank.binns@imgtec.com,
 operatingsystemsdepression@gmail.com, matthew.brost@intel.com,
 dakr@kernel.org, phasta@kernel.org, sumit.semwal@linaro.org,
 linux-media@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH RFC 00/13] drm/powervr_sgx: Add a DRM driver for PowerVR
 SGX5xx GPUs
Date: Fri, 13 Nov 2026 16:10:51 -0500
Message-ID: <20261113211051.88798-1-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Mesa side of this was declined, so I'm withdrawing this series.
The driver will stay out of tree. Thanks to everyone who took the time
to review it.

Joseph
