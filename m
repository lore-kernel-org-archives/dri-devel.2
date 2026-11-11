Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E491606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OtH4+NTt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC7A10F930;
	Wed, 11 Nov 2026 08:22:47 +0000 (UTC)
Received: from mail-dy2-f4.google.com (mail-dy2-f4.google.com [74.125.229.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9215C10E114
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 04:42:03 +0000 (UTC)
Received: by mail-dy2-f4.google.com with SMTP id
 5a478bee46e88-36f2f262b19so1948464eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794372123; x=1794976923; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LBWMkcN1tef9AYjk2Bp3If0hhjn0Q863wdyvj1dL6Dg=;
 b=OtH4+NTtFl5Xmd1Wn/3VrdF3GKXbX5rD2oK8wIJXTaFZhycWvog16YyozsFhspnNuT
 OvOHStY/+VcFjBRxsdmFq/AZrJ141Y5A1Cl76FDCUSx2ff/jEGV35hSdVnFzKjynL9B5
 ZWF/hRkyMcrD7FV3wDGBef8xdGfgPkmGz7YW4MQYrO7s7OGnBOvFZ4K2tq55mEd4gJQk
 f4SuzN20zY0vWEDHVVcph6Dc/e1WEOI1kqdKcYfXtq7nD0jxeKU7v9rjBe7z1wJvKctO
 /H3YVdx98D8pxeqy6iVAksMbfmYimyQItzMgGLscZ7jE21ELwomKUWBRCo6/kIoR2j5/
 nB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794372123; x=1794976923;
 h=mime-version:content-transfer-encoding:content-type:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LBWMkcN1tef9AYjk2Bp3If0hhjn0Q863wdyvj1dL6Dg=;
 b=ZylaUPoGTQIjuvZJQXqmasoQxKEea+8xuALHiP6uMWQ3kORnjG8kHabWrGR6AwxASm
 UNw6F05ejkUjIh9wMtkGUI2X3BynLMRhxPNLji9OZeQDU/4gBdki+obXuqsI4hWVUz72
 6exba8mFT+vfl4S0pjEc5ph8R4JwrMa2yhVtexwZOi6cfM9zpGVW/3OKILJrpJbB6LI0
 jTn0PMVk7rLBuwGf/vrsSegscZ9q8G80aD1180EVVbvaqPjFqzV5j+G5yYzUm6zbL6u5
 xcN27EtKwuTeiiZtI0rkimt9jVzSN9tF+XMrhgjuHkuCwVW7OJTObc+cvfR1Uae+1Zb0
 J/Ow==
X-Forwarded-Encrypted: i=1;
 AL+hErFjDVDwiq+a0dIiT3tn1wqnVYQd0K7AW2zx9LBvSk86QWOoayuYUHZIcH2cdp+GNT5DmbTjYMB7rOc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8wqvlbkc+7F8yX41gqB9uqA5LwHRW9B52y4u0tN+hrJxdNafJ
 cDRqRNAl8DqAivA35qoHYJ/y04RQ1gTMFJ3/W5xC7VxvxxShElrpnfE0
X-Gm-Gg: AYBFou1nXe99aI8USAGOR1AQcfwTSTBUjf9NqlpfkjSaTe4I62MsVKOJZEUnEFckJKp
 2WL+/PV1MsQmRu+GAURNAW10invxfvDonoW+4/iSXv6ew34sQ3IEk1Wq0SoKqhLMJFwpPVI8HVr
 ZmeNIcPKp9zMLI7JBDp+HejSGk2aasw0mGUSXakNn0dfdDjyCiCk4Mi599ZA7jQqzrIRqm/S5Fs
 urUyST5FraqlBmkDWDW+PRkeehtoV4w7wTJ5a19kYaCavQPeS5m1RJzwJjqM+5brt0PZPWDqQpR
 o81s3I5Yel9exjVAucvuKyBQSAYGrbRV8MM1rG9Z+MupUZkAfPEVTXNHNTt+ZMFYAI0BmG/kNYq
 F/qCeLXAzpiwDumFWfRuTD/j6ivtiKOA5xqRS9EZ8Ng5+it5G3Iceb+q6joiP/+3DBKR3+0hQR7
 1pvH5uaB2aoBLQBXxwj/MjIo1QNHsQk8GKeN+QZIzaRsnC+sxz3OrWxTtx7G/u8OC2g33r8MOL2
 cD6v8hwHUpPyAV/kMtWmiFgjxPjV9iLk/ai4cvFiMLloba3HU0PecXcmgxhDdcSA01fJ2hc0elW
 u7EtaxkIqQHUviUYLR7KDFoU
X-Received: by 2002:a05:7301:4184:b0:36a:1f4f:3e9 with SMTP id
 5a478bee46e88-37685d753c3mr2904495eec.20.1794372122835; 
 Tue, 10 Nov 2026 20:42:02 -0800 (PST)
Received: from localhost ([2403:2c80:6::10d9])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520512ec1sm11023535eec.12.2026.11.10.20.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 20:42:02 -0800 (PST)
Date: Wed, 11 Nov 2026 12:41:58 +0800
Message-ID: <531e628a379b6733632a25d998337d77.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Sarah Emery <sarah.emery@canonical.com>
Cc: airlied@gmail.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
 bmasney@redhat.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dlan@kernel.org, docular.xu@gmail.com, dri-devel@lists.freedesktop.org,
 heylenay@4d2.org, krzk+dt@kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-riscv@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 me@ziyao.cc, mripard@kernel.org, mturquette@baylibre.com,
 neil.armstrong@linaro.org, p.zabel@pengutronix.de, palmer@dabbelt.com,
 pjw@kernel.org, robh@kernel.org, sboyd@kernel.org, simona@ffwll.ch,
 spacemit@lists.linux.dev, tzimmermann@suse.de, u.kleine-koenig@baylibre.com,
 vkoul@kernel.org
Subject: Re: [PATCH v2 11/17] drm/spacemit: add Saturn DPU DRM device driver
In-Reply-To: <546efd00-ddaf-47f4-9387-2635785a1bf5@canonical.com>
References: <20260809-k3-display-v2-11-327d7910bf71@gmail.com>
 <546efd00-ddaf-47f4-9387-2635785a1bf5@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Sarah,

On Tue, 10 Nov 2026 18:02:42 +0100, Sarah Emery wrote:
[...]
> I'm sending this here in the hope that it will be useful for a future 
> revision.
> Is there a v3 in preparation?

Thank you for the fix, and yes, a v3 is on the way. I am working on it
with a friend, and it may be posted by him rather than by me.

I am glad you brought this up here on the list. I had already noticed
your work: the series, with your two fixes on top, has been running in
the Ubuntu 26.10 release on the SpacemiT K3 boards.

I would be honoured to have your Tested-by once v3 is out. Thanks
again, and thanks to the Canonical team.

Cody
