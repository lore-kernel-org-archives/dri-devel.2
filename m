Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F390C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:30:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1303110E13D;
	Mon, 14 Sep 2026 13:30:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UKWtQRMR";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EEEA10E13D
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:30:50 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7c6dbc60so307255e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 06:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789392648; x=1789997448; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z5aiyrhYPeBObaaSyxfH7WZ8K4IPKS8wAjD2TNWaDSc=;
 b=UKWtQRMR9j+6BFs15d5oEgIyKbYH/MI12QMv4mBmRjw7IXq81jWe0UkA/04EMmECiX
 24a5ALdB+HcltUE8RP68LhcfVOoxmumq/SFDLbgSGsz4awC2O60tCQJQ7M9IyidRH1hU
 D6lTmphf1NKZh2Ayq6rdagBquuQUdHEviFLHxbtadGc7BpQPynVYWTgFORLFgtmqBr8E
 JPgpU6NCGe/+WT3cITzeNv+MSwjVkMhzKHOFi4fecdmg5/QzJXMxjSCrZsKEOq71LWdF
 8HsLQKaFCm80BVCvANx0AsvaZiSRaWIZZOBhCkTbG7hebgRWKqfEYpZwV2gg5UaYxr6N
 HKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789392648; x=1789997448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z5aiyrhYPeBObaaSyxfH7WZ8K4IPKS8wAjD2TNWaDSc=;
 b=OZGmxKccfCc6uZIXcvZ51Ml5xODyA2XYOdj/SNE03xXNDvFpfid9TUhXS5Qfl4gRre
 TqXqjNoEDBkV5kQuksvbddaTMk2dbwZ8lwfhG/pxcpj244oSoXF6gyGjkCC3Mqu8zFhF
 NuJRObKJDarTrjXL00xQ7UcVrfmAlmg2pQTpTXEUJC+uDmBrquKATm1Qm2Xo1qJaaLQd
 kASzS0celV9yal3WDNkwBR9cVDexlmSrQn/0a0qZNKdOZ3ZvkdcpijegbByCm+SgR0U5
 R4r5ZMaBD/2IV2rda+ZhVbefcxffT8w6IG9KCM5QsbgvlA4PA1FJKHLUl5jfqY0vf3SE
 HgZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaIhK7inrW1+GeDEyn7ZOACyuk0Ww6++J8mNxsqbjddmsQfVJ03+SYbn7YbMlCmL1rtQycJhQLSGM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lCaGyYhBYPQ3rwWg4fGiB6eRVJZJ7UFvQ10ygT/tcdjevga2fl
 DsMxB+vGtSwi3mVYW+rLUquHOEHAmqp1SURiut8GqXxJnvU3txGSc2zA
X-Gm-Gg: AYBFou2a9jnPUQmHzGrMKnfVnjyUVDPNaJ1HlUdcoHAtfd00d8S5ELXHV2XIgbFzUuX
 RWxiOLmQwXsMKfM8MEfg1yuK1IV1VXx2BXqZZ+lIi1SXGdH66r3S6CAFiX6FoqOvHrC2lIaEUT5
 2K2kGjywZWD3fKU4ZoGHaHyG3u16mTVHMKuJ4DvSJHRVFJeXmDqYUKJKK1y34mqxajsZVcEUlHS
 8V02welCacOZ8YiQAVG3fNHG+Y6Lf5ukZ2LH7YB5rWYDUUSp7T5CjcvA56N7hAX6QfoYTAmaEd5
 kLWpy9XgtJlWACl36+CL6fafyiFFXA3RRhCLjtLEc6Ar1hKq5Ju+v8p1F383qbbWJkrMdHV3+NN
 XCjhylZlCtoNyI3fpk0bTL+xwkgzpaw9lktU6ukjzD/Z82KxsA94G/q2gtWogYo/MxS74e01DCm
 uHPFTIXZ2g7HPxVamECHnNcDgBYlSCEUDR8oAff0cVVy9ZhACKUlLSIIFkH3ueWTAM/VsJY42Sw
 /y73oWEIl2oo8F0XBNfuDjHJKBXuF4zFI47SJY1nqqXCxGtnJepJ6FD5/Tkl0J7uBA4Zor/uvdn
 YkOD
X-Received: by 2002:a05:600c:4e53:b0:49c:ff81:e062 with SMTP id
 5b1f17b1804b1-49e7a68b774mr27446575e9.2.1789392647985; 
 Mon, 14 Sep 2026 06:30:47 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B85A6000F50888CB3F3FDEE.dsl.pool.telekom.hu.
 [2001:4c4e:1b85:a600:f50:888c:b3f3:fdee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7548d99bsm152380015e9.1.2026.09.14.06.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 06:30:47 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v6 2/2] drm/rocket: Keep scheduler allocation in
 rocket_file_priv
Date: Mon, 14 Sep 2026 15:30:19 +0200
Message-ID: <20260914133019.6523-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914045605.381933-3-triet.hoang.dev@gmail.com>
References: <20260914045605.381933-1-triet.hoang.dev@gmail.com>
 <20260914045605.381933-3-triet.hoang.dev@gmail.com>
MIME-Version: 1.0
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

Hi Triet,

Same run as on 1/2, on v6 as posted: ten pairs of concurrent clients,
so two rocket_file_priv instances with their own scheduler entities
alive and submitting at the same time, then closed, with the kfree()
now after drm_sched_entity_destroy(). All output bit-correct, no
lockdep or atomic-sleep report, clean autosuspend afterwards. The tag
stands for v6; please keep its comment:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, concurrent clients

Regards,
Igor
