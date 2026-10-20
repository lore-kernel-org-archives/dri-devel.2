Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D512606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c5PDZklB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 879AE10F2E0;
	Tue, 20 Oct 2026 07:36:26 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FE1F10E7C7
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 05:29:13 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so196244a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792474153; x=1793078953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c9R77y7CmEav0rC77XG2mhErQJ4vnSWiNFq8rafLmTg=;
 b=c5PDZklB9qZRedSiu70AZIY0UqXHzE0OaAmd84Ps9xnAhLOz6vRRx9NHpkWc9z34LW
 s3Vjh4WtItKgcxnZ2aO+iyoL3zdwcXCNBPzvfKveRv/HzkGTDni8s8d00UptWwzb7Qss
 vEvx7JyljOe/eEVZYrjKxZAzJqHkqhsUtluj/CQ9Q67KPNdhLokzcKUcIVdeoGPZte3o
 XBBP8aScDDyuLOcteoEg0uUFP8m+HmjtX16Gqep13s2ujZyCXrWmjtZQyo2jIeR0SQDx
 XlXgxiX2L6JRvNktA8MfE7I7sjYj7kBuqmJnoGOsqo3ea91/VDBHqDonq4R0GHKNOSbY
 jYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792474153; x=1793078953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c9R77y7CmEav0rC77XG2mhErQJ4vnSWiNFq8rafLmTg=;
 b=iGBvaDlWNd+ubsRQgwFuEzj+dDhODz14eC5g6YlEntpWufVviWkCWHioOV/THfmB2Q
 4aBJgWqfv3xmsgdIH8k8XPentwj9S9sQrcjBZyKfGNkaiXHHJjBkGFeNgrwaiLfx6Ne5
 lXfr76X8Ny5/upmDlznBifcssPmjuS/Yb23HlZ266OKkZuEY5FdZQdpj6+4NY+8Ss29T
 BJfYCcm/qIf8oDAl8Rregc6itqnyUMZoMCvKXq3JKTU3uslQCrjzCPoox3KlEeaTAoGE
 n9ijH9T82f7f8XR5DfHA1BRw0E9ShRRvVSl/2ud27ey8AaAth3m4yREuy2pZbyG+fXv7
 +W8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByf0CAlbHEXkip3JVzdY5GOh9a4HSyWtaYECZhJlPSO0sEEq32b8Pa/U4LyWDqBRwvRJ4kucs7cyj8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJiQ2IIwQ+fyPNYWxylt2V2aQxcioKhPm6Z9KdDNbCwDnddnilq
 jwxrtCwLSYzZHyoB/31XHWyThhjloxQ2iHrP3FyQDvef2RrZ7z19ANTj
X-Gm-Gg: AYBFou37TyAwdWngQxw+TKAh/JjSSKEBa/6sLBkdgVcGsu38pLPr1vn9tXlTWknPBy6
 kU3D/lzGpmcgaoBQBzi8PWC/wKgywwZpgS9uCA8HjHnFudTusnaIyBID294B1W1CBG7V7xH8j1v
 plNDLqpdNgvpwV6frWb0zEFQbCAFji5ymi3eM19AdBj4WlZ/HsXEX7dL8pbNVeQC+9RHwnhMU18
 ppU1hj6YpdHkHTL8GdDWu8yYbCXjCUjgWnOMRj3Ma8cW4RAyTMsPMA4OhGaN8/CedKfsLuUVoGU
 5eq5DUbvBC28x+89XV8Y/ZCmdt5PfYYOXrR3KK9NbjwcUdsKW5ouoCfMpsjdBY3/RgzBjXQhYkN
 xKHNarTcK7uYfL2LD6hZ2G34BndATmQOMPJmO1csSECOWAJ92zVm47/PQp68Tj5cP++ZYmygGc9
 OkTU8qG6GYbNWdait0Q4uDM1h3yOEyWtcysyZ/9lfwuIaNSOaGMeWh5j/NEcpsI8Hiy43LZTO5I
 U5L
X-Received: by 2002:a05:6a20:c885:b0:3de:57da:7fa6 with SMTP id
 adf61e73a8af0-3e26fb93cc3mr773371637.39.1792474152912; 
 Mon, 19 Oct 2026 22:29:12 -0700 (PDT)
Received: from hachimi ([101.5.175.4]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd654eaf4e3sm4406759a12.26.2026.10.19.22.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 22:29:12 -0700 (PDT)
From: Lanfeng Wei <xlfylawarthur@gmail.com>
To: hamzamahfooz@linux.microsoft.com
Cc: airlied@gmail.com, decui@microsoft.com, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 longli@microsoft.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, regressions@lists.linux.dev, simona@ffwll.ch,
 ssengar@linux.microsoft.com, stable@vger.kernel.org, tzimmermann@suse.de,
 xlfylawarthur@gmail.com
Subject: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
Date: Tue, 20 Oct 2026 13:28:47 +0800
Message-ID: <20261020052849.9241-1-xlfylawarthur@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <atZjtSlZAocUWYBS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <atZjtSlZAocUWYBS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 14:38:45 -0400, Hamza Mahfooz wrote:
> I actually have been working on cursor plane support for hyperv-drm.
> I'll post a patch soon.

That will be great. When the patch is ready I'll validate that the
problem at hand is settled.
