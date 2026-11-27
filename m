Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E049606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VxVnACFB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FC310E1BE;
	Fri, 27 Nov 2026 11:39:56 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA759112899
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:39:49 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e47347279so4879733f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 03:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795779588; x=1796384388; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YwGjvP6ctTxZun8XTu6GbbqiRyztei0tj/DC1LKv/lo=;
 b=VxVnACFBaUJBHhAjndIgABTK3mEruPNvHIwpzc8UnhaEdCw8l6QPi43TnRhNoFlcZ4
 1XXKHvwWeyrev9VNq3Z+Q6UO05Jwo239y+zw1F7cW8FMe2vICQVkHns8lTkj3yvvzfry
 WVtl0PYWZ5djSFOSvGp5lKAJD/8RX3DDZloGt80acBO7P8Z7CkTamhZo5XKYJpPGHmnx
 s69Fb49uvoP/4hwuidWvrNOf9Fid/cxEGd/gAhqa3Ojh2NOKV8gVe8jAwQ/C3PTXTuyw
 dODo/X6ykafOepIL3YZ08CWqm5g+jXpswKSnybNoB0JWSmqiyYG1lNPyWA+UxrfdeQa3
 ODTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795779588; x=1796384388;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YwGjvP6ctTxZun8XTu6GbbqiRyztei0tj/DC1LKv/lo=;
 b=ACc9XtZve8VYNSpLoWMGU/ao3hArO+vvbqEZkWDfrjftSXiZr48A8QxsjwL6EWI+bc
 k1BNuloJjx9MBl6YKFrrIn1d58up2UGY7l+b/qgocbqFGV4q5wsxrsX3ouwB7N6oDdis
 yvqf+IRMFzXUpDM7FQ63sltw3YpkGkJhaN+G2d72se6kBN6djIRd2HzQmciPQhlcamJj
 Yrt3EkpU7bMXEycjWlAGaQxQwxUZHaQGp6ySZlW0lZ2fio0GHUP7AZvzWUEHsQQ6KtoG
 knu/gU4kp0PgAsR07hth368/ZyV/14TT8Ao/w6/Zz4NBjIHMPrHP9UqwTWU6C9MFcakb
 MgbQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGtpEkelDZwdyKr55K0rHlSoYTpe5TkwgdyAOdBdBsW8IGbIUETGzjrD27g17UpjVl8dpfagwzEWg4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9xdI7KizlUDH3HCdHrm1pNIVIYRWN6zv83zRp3/xZ3jkMP+GTA
 1JkazQXb+f7PzT89LI0wldISKwd0Rd+oQOM9ZM8/HgcLnbUxPUFHfQEc
X-Gm-Gg: AZFdTZeMd1VEyIO4Dh0eBKHkkNsbVr3+I6BeME/3BlkX0ADsfl5uVyfN8XBFe58PqnQ
 t/q+SrX04qych2kQgZ1bSfQWLpmXRqvx1RfNB7XlenY/migOrhsK4YQHYIonPYadUAparPN9SK3
 pUCADJGXcaLtFb2NaQAs78EC2An3ZcHuRl3L8zYusTPPgFy55RrqidjBwMHQXdKj+lffjz7Meuw
 lys0bMkN0B5Ws7UvZRgynfi8JZf4MZ52qXD1eKz5liP4ScZdlDC0scNk8wRyF2Z1kUYXCSHg2HD
 OxhHT7ryqrmf7TsSDdAY8CGqYUCeWMx/QoWOuh/J+H84zQOHrWqZv7J5h6naRXRw4oiYZGPDTUU
 x1CmcxZqyD3j+oxSzsC/SZorl6vPqlC/WtmjcXw4U3I9MiwPk8GRATluBw4Lamm3lPWaATG3Fh7
 IkhNf6SQI7r4/OXpnJQVVYzdHVOd03P7EyllfQUiUYNqDQOmBZJ+7ATA4cv+Ro9q9l2ZFH0AE4o
 QwwTvGWSyGlXa6MoYjwJ2znma7RoTGjUqU03zxGEAaV1LSpyhHPYHCJU/0iJbtsdh+6IGUPy3XG
 HSN4aTKMaOWKhWdCck5+51QXHXvWtT4=
X-Received: by 2002:a05:6000:184d:b0:48c:7386:af18 with SMTP id
 ffacd0b85a97d-4abacfea55cmr51711565f8f.8.1795779587982; 
 Fri, 27 Nov 2026 03:39:47 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b34e9c3ffesm31135419f8f.19.2026.11.27.03.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 03:39:47 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 jose.exposito89@gmail.com, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v7 17/43] drm/vkms: Introduce config for plane name
Date: Fri, 27 Nov 2026 12:39:33 +0100
Message-ID: <awlqNR4-W6a8w6QN@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126-vkms-all-config-v7-17-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-17-21194cda2468@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Hello,

vkms_config_destroy_plane() frees the plane through call_rcu() and
vkms_config_plane_rcu_free(), which is module text. vkms_exit() has no
rcu_barrier(), so a queued callback can still run after the module is
unloaded.

Thank you,
Oarora Etimis
