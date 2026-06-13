Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753BFCD98C5
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE6010E0D1;
	Sun, 14 Jun 2026 15:44:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oorfsEyg";
	dkim-atps=neutral
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733AA10EBC5
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 02:04:00 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id
 d2e1a72fcca58-84226d0f1d2so1159736b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 19:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781316240; x=1781921040; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mPoSyMAZC6nuaPbHwX1o/fpMkBKd3DvivicT6BAaRnA=;
 b=oorfsEygrNhbu3pd49lNp/kl/SkB0sts1oOovH+mdTA7fK9QzNGWt0vyuZvh3gL3Qg
 C9qy6vH7ebs24KIStM1ea6ngl3Aiqm5D1GU3mlNBWaskvZ1B2rbvMmkb4fcNMy47lufa
 jKmj4g9qwl/4EJc5hrGRw4HHtnD2icKlJcXofGPAkZcLvkAeRzhoG9NcEjah1jAv5IpW
 ft3Qk60M7/dIvnR+24Ahmz3Lk8GTiPeo1HG/2fF32aeTxccc/V4nJlYHQcF00V8zS87T
 HwgUwi7t5EySR3tabfCyFz/DNUv2EEZS9rsG/7qd0DOwcg0wHnu6Yg08mdUPezDyj1Mz
 xw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781316240; x=1781921040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mPoSyMAZC6nuaPbHwX1o/fpMkBKd3DvivicT6BAaRnA=;
 b=h8+nmEnoI7g56LDUeXjDUZ1l7v0lRR/X7xcBcjwW3qp7sB1Ymva1xGbd7D6/aUIFKR
 m/Fuo6BwoHK6Z7fTLCOf4BtQetU2fMSiEYAIJK9WO1b9mV7tZSEHb/UlL0ZM0ozTns1g
 03t6of2gcBY9tzr870SQFnkY58bxzgEPomQhRjxA64PGs4aj+WriLeEzsUYdXhGpGRjb
 wxzGyGzHCeT+AXP77e05yXsxrKO3AxNCp++5+S6qNuamdFjOFqrdt1NoTRGWkU7Qck7q
 Gjtl2fDzbqU9w1Y4bOWqzVmk1/NE/1XDM3DPhYBufVp7pnQb2Z8rbJWVNKEoNmkOwVUk
 OHdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hdfiaJU6zrSn3KdkiY7MlvRhGpJSxVFE1sXy+3dOTFzXgeH8aDQj+bictxNRVOedugGpyS87DJGc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxzaBYEw69lopqMb/vAl9+4ajnxlvYuVoh5KHhcBS94vbv9mAF
 fX/QnXTH+fWHBjO0tjh5WtkKFGGg8Aru2U9VzA5Znf3yNjrRAReDfYoL
X-Gm-Gg: Acq92OGuI9ptQUeEEqL6y/TFgWyijILDUhFUE/d1HTVjwPJ71BDgucZqjoGZ77hxsVP
 0VR/eOPmwdfXiLfMI+MVzKN1JCve5Vq87wSq+S9Z/3V18r6nu/gKSgqkxbQwTJq22WXNfWgdldX
 HVIAn2eY/Ap6WQtz176zHQaoBf47d9eVcauVJFQDcsZxUq/5YTX9d4IRfd0jLQ7aKhPcewZvkhu
 bDUaPleJUaphSXMJmkaq803eQXS1Wd5OZB+bNeMzJfQBY3BYjUX4fUB530x6T8SwKdF/7z8jeez
 S1iotFm6pTvAmHp8shRJis1jsMd15e18ODpzvle5muyd71A10nTXh5c2umI0k+03Tc8/y+FRqb0
 qtiUf6Bd9LPzpyiI3ZW8slMz7TUfSL+QZnsrhZG+Q0WA3qbiDkhQKRAPc/i+yAvAubDokhdoM7s
 nmkrIWN7OrS1yRTV8V
X-Received: by 2002:a05:6a00:1d9b:b0:842:6c02:2fa4 with SMTP id
 d2e1a72fcca58-8434cd42d57mr5864692b3a.14.1781316239902; 
 Fri, 12 Jun 2026 19:03:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434afc8a5bsm3623847b3a.33.2026.06.12.19.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 19:03:59 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:03:34 -0700
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
Subject: Re: [PATCH net-next v3 3/4] selftests/net: ncdevmem: add -b option
 to set rx-buf-size on bind
Message-ID: <aiy6bh2IAHDtBX2L@devvm7509.cco0.facebook.com>
References: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
 <20260612-tcpdm-large-niovs-v3-3-a3b693e76fcb@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612-tcpdm-large-niovs-v3-3-a3b693e76fcb@meta.com>
X-Mailman-Approved-At: Sun, 14 Jun 2026 15:44:15 +0000
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

On 06/12, Bobby Eshleman wrote:
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
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
