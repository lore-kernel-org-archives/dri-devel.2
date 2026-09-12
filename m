Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F73C88E45
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 01:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3661D10E3FB;
	Sat, 12 Sep 2026 01:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CrAR+VvO";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C6D10E3FB
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 01:48:19 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso1627387a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789177699; x=1789782499; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AJTaf2bDSpdzSk6z7WG/DeZkUq5zAHBzTOO9sxhYvuY=;
 b=CrAR+VvO4ILgOjzlBueONCeaOy1Oh5iMD1c6ofKUHELG5KpFGuD0BN/p4tauFO6KNN
 B2l9l7IgLi/clbWkJG3J7YLP6LwwzLjuDjXrt8CMYicsAuNFX8UFOIjtmhgb6H/q8oaw
 Me3cHn38mfPQKKjAS4zEVWZ8aBNKEu77tYMTbStkdqVaxFYPITWkJ983dkZCeTvtet4t
 8AwhkVMw5Zx1hB9rKOJx1tCyPmm5hgF5oDX9kdT/lV29QmS2s2KjuBkoFGu6bM0OnX/a
 MSpfwGwVimPwxtTP3FTVHfwTCdd5VlZIpddmR8zPzlX2HN6L145y+cUkV+59pi+KUhng
 urgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789177699; x=1789782499;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AJTaf2bDSpdzSk6z7WG/DeZkUq5zAHBzTOO9sxhYvuY=;
 b=r4opWkKME+eLfRuiS8OFoDZb/T1ajUPKMj4l/8CQET2hPkSOuTEngo6G7u//SHayPn
 jfOaJdRPwfiJ5q0vjoqd+23cGoifVHjwrI8BYV0qkpVwWjFcxuCWt4tA4WlBQWy6UV8V
 ZUegSMrtyUA2lo8lZSO1aKY2nOlKUX0QkodWdlRGDj8L7t7PDSA1Mzxf0RK6gZHErdDA
 /jb0b18x/m+gsZH96DNjeppgS4ISMFvd+oMfuIQ+NL/tN76ilrGTBeovxGi8+g7heNjp
 r34ybN/uiyOIRlF77dPMnDvBtLTaounov3b0Iq606UHH/VaVF8USqfbk5TsBxS2ZlVEu
 5HPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3qaziSz7iuMzmWPjcpzVbJFJ6e/5tu5jttTUwLnXVTn5c1qbxmsJYUhzBKHZh+CLnMvohGGueQW4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mXYxv6gmdcjlMGRGiM9yMwc7xnvvynG+/rgWBnkD6Jly6g+NxT
 FDTspC+CVDovUULp3QPbjGmIdRV+VURlOq2/rtXYg/wFE9+U2848BTY=
X-Gm-Gg: AYBFou14M4qnJdjStVTL/6t5sxRyGUNFAw2fYSoUGqWakhNsN30S8e62GwJS2CBckBc
 7CMct8YenBYtXG62dmkZApNfG9DRz8rt+Bxwrd8/p51SW+Mec3NqOHZr/uAzfbjLlhjN1vppYle
 y54sFCri8h/0RMpNDLXYXyLiJOX+QKrAovGPvdvO5E6ddmA/QXRNdtQRHBeB+UtOrF6t1RCN1XW
 MGQTSrFtZyJdV92o35hMKjJCHM/LlZOxG8UGFKN0k5ND1iGHkhI3gAIX2o6RImBf5/h+7qW9nT4
 jfA07+om4FY4fwjbnEcYM6lZRP+5QP5i6K8TOhpB0gibtbL8KDPmSXM6vHw1XPo9De4oujMbr/z
 OKxzCVeLubydLakCAPZNkcBcwF3LXJwWFrN9u72034Rb1NUneSSiLaaJPRzepjdNntJCXuXVmcV
 Z2aF3FUyrpDciGAhEk8WsIjiOb283hoSM0Uwf9H4hPRSMDSMcsAeQvLW1vsSJfcACGEB7fZCc8v
 KY58QjkcEg6mxLuI/JU2Lw3RA==
X-Received: by 2002:a17:90b:2689:b0:398:9bd1:3211 with SMTP id
 98e67ed59e1d1-39d9c21eb06mr10847998a91.18.1789177698853; 
 Fri, 11 Sep 2026 18:48:18 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d94bafb3bsm7912064a91.1.2026.09.11.18.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 18:48:18 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 phasta@kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 Philipp Stanner <phasta@mailbox.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: drm/sched: run queues freed before the TDR that drm_sched_fini()
 waits for
Date: Sat, 12 Sep 2026 10:48:12 +0900
Message-ID: <20260912014812.2115452-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <363aa83e-7c72-4592-a8ca-46f0ab56e4c5@amd.com>
References: <20260910054605.634135-1-donggeunyoo.kernel@gmail.com>
 <6f52dcbb040b8ba796b56311e9a77465d111c868.camel@mailbox.org>
 <df7b0d1e-5a74-445b-90fe-fae30cee4cb3@amd.com>
 <20260910084408.703333-1-donggeunyoo.kernel@gmail.com>
 <363aa83e-7c72-4592-a8ca-46f0ab56e4c5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 9/10/26 15:58, Christian König wrote:
> That is a really good point, canceling the timeout handler should indeed
> happen before freeing the runqueues.

Posted, in a separate thread:

  https://lore.kernel.org/dri-devel/20260910121601.805032-1-donggeunyoo.kernel@gmail.com/

> Oh, that is completely broken behavior of the KUnit test case. I suggest to
> fix that as well.

Agreed - it never signals the hardware fence, on purpose, only to find out
whether the sequence was reachable at all. A local probe, not something
meant for the tree.

Regards,
Donggeun
