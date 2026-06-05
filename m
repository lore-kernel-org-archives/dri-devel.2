Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79B4CD8C90
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A610112D67;
	Sat,  6 Jun 2026 07:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OKY8qgXG";
	dkim-atps=neutral
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 201B8112BE2
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 15:35:36 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id
 d9443c01a7336-2bf30d530bdso20866455ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780673736; x=1781278536; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fcdauWu6kB0J8jFGQyoE+3xe804PkmDYTAOAHNlgs3o=;
 b=OKY8qgXGyv3TMeEcrTejo1gTIHMsbVavbf/YqG6c0AifBXzRRPIQAJM4OJeTs3ZIGK
 v40Oi+/0xos6KrhBJRpAfT5sM7VRGowyvvMwQ1Htn40JS0gAQX5OkrFavjmga263NKE8
 IUPEcc0UwpdEmbnX7F86CINN5FOgnXAjPjv7I7UmZZkLtZ60yu5YY3HM6ET+GlikD/xT
 6jxKWMVa5m0WrwlYHCcw2vOkbSzkyjJzkHtJ5wnrNhIXKAPww6yglkQX6rzr+MmPQTte
 0zP4W5wT2B3C7nj42iNFpDSqSaGET8+GAeIlApUVSEoDjPa3NmUhExaljiXgenCiAezY
 nBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780673736; x=1781278536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fcdauWu6kB0J8jFGQyoE+3xe804PkmDYTAOAHNlgs3o=;
 b=fak9cc9Of4KPGUXKMPU1TFm6xM7NTe3fz3FRDkZqA7UfjPLKvA8+e2kzl6gT+6zefd
 oJakeGbxcv6ILkzPKgigTFioapYLOWrLsx8vj8W61IL+NCt/henex0Em7+AhVNqoFJTi
 rH2ym2+SekGs7Htt1htZRbfy5z/2kVJhskHVnAAzN4CEmeuJrB9DZjLWSzXSRQ0mAxXD
 E4Zpz3vRrOUhGLbPQxtif5WZI7hBCnZwBcD/zNaoyrEfvLey/vIkMaRS45wInJGXuAJW
 qfF1a54ZqouuzLZTIi4DQ1BjSXVYU6+iBuixzi++UjRs+rpOndQa5D8u7xxdxl20UbjM
 PXjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vByrMDssLRZGoVee/64kEQiSMnmUyrkTUJefu0K+NqJhZc1GRWVQVvWGXM4G2t8P6ikhG2icV/QY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHrVhGwG+oLejiCJ3D255cy4J44ALCTZAoPkw6+3NSgX3e9gWQ
 MJyhVkvEF7B86xnE/SJTh4kETVKLEY7z8n0LU1k9KDQ5ibRmNp4v8AYP
X-Gm-Gg: Acq92OFjnagPgWBtOOP5ke17rDBpAM5QhF6uDtLDDtoI8Xxv+VDK5ccThyhhFEcG9+F
 z54z1GTGgpLAgfnF9PWZ8MtWoYpD2ulRZsPyq/vqKTqgPDsU5C1hTfsuUMKcuOeG5QxFrSIWZgH
 mntJAV8cHtp/sNWtE1Uu+JuXJL3lEVYOPgCDHaHho5D8xyR17j9jc3n71hns4sD0xemwUVWvt5s
 5fBDE21wnqeb8eZSGZXiQ5kiayuvhIMBadj5rM1mbTyxzOnUpYBydO4eNnJjslaoBGBF6RK/MIW
 bTy1NF6HLNnw0jipA4VnWv8EuSuQiYBzMdFvExK1VkPyj0Bkdabm32Yt3cjO2O9VjUQ+4sf3dJf
 GYE6EznFsTXkN0hivK9GFZGgDOsB15sl3Af+pHURBgzhipUxhFzu4Yfzx83ec6IDPErYvbqYEE1
 1J9ylTLYDsQaAp5u5z+Jxv6+lbYgk=
X-Received: by 2002:a17:902:d4cb:b0:2ba:7749:f89a with SMTP id
 d9443c01a7336-2c1e7e55623mr43588465ad.11.1780673735644; 
 Fri, 05 Jun 2026 08:35:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5e::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c166391d53sm127920285ad.65.2026.06.05.08.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:35:34 -0700 (PDT)
Date: Fri, 5 Jun 2026 08:35:25 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
 sdf@fomichev.me, 
 razor@blackwall.org, daniel@iogearbox.net, almasrymina@google.com,
 matttbe@kernel.org, 
 skhawaja@google.com, dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 3/4] selftests/net: ncdevmem: add -b option to
 set rx-buf-size on bind
Message-ID: <aiLsegSEGviNluv1@devvm7509.cco0.facebook.com>
References: <20260603-tcpdm-large-niovs-v1-0-f37a4ac6726c@meta.com>
 <20260603-tcpdm-large-niovs-v1-3-f37a4ac6726c@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603-tcpdm-large-niovs-v1-3-f37a4ac6726c@meta.com>
X-Mailman-Approved-At: Sat, 06 Jun 2026 07:19:14 +0000
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

On 06/03, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add -b <bytes> to request a non-default niov size via
> NETDEV_A_DMABUF_RX_BUF_SIZE. When the value exceeds PAGE_SIZE,
> udmabuf_alloc() switches to an MFD_HUGETLB-backed memfd so each 2 MB
> hugepage produces one naturally-aligned sg entry.
> 
> Reject values > 2 MB up front: MFD_HUGETLB + udmabuf can only guarantee
> 2 MB per sg entry (one hugepage), so a larger rx_buf_size would fail the
> per-sg length/alignment check.
> 
> Add CONFIG_HUGETLBFS=y to drivers/net/hw/config so the new path is
> reachable in the CI kernels built for these tests.

I vaguely remember there was also some kernel cmdline argument to
reserve these? Do we need to also do something to NIPA to reserve 2MB
pages for this test? Or was it for 1GB pages?
