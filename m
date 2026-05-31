Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5639BCD5BD1
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 09:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE3610E464;
	Sun, 31 May 2026 09:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kde.org header.i=@kde.org header.b="D1cv/4ss";
	dkim-atps=neutral
Received: from letterbox.kde.org (letterbox.kde.org [46.43.1.242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E1D410E464
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 09:10:46 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) (Authenticated sender: zamundaaa)
 by letterbox.kde.org (Postfix) with ESMTPSA id 5173032918C
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 10:10:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kde.org; s=users;
 t=1780218644; bh=PVTg4p1NKI4OjS7cks2lMxBtlOlhHThdA+insuJ/xEc=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=D1cv/4ssDaEvO5VFztA7VKSKHfbF63gbuF4nYwqY6fO55e/ovKIvBeJXYMVj5S7Wl
 V8/7iaN96vS79koEPOIea5Nl+Itw9rQHUbOwCWvU09jJlhs5P+73lFncS/fqjqn5TJ
 g/bSnoKgWimAqu3LJl8v1uEjgqkQuyzdNXQz7Aq8JyBRGzH6cTxL0nlNM5g+0arffX
 nrt1VJsqrEjDnsNio3jrDk8WLImbwzxP4GKMuUuIoRqjUBBLAwhiorFm7YgFf+Aj1a
 +hC1FClfzk0YP6Nb5quUQrLf25dGZuidpLa1NACMh7pFXPRYMspip3Y2iGNeHbK5be
 8K1wCIUMElP0Q==
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-8cbe69b122bso96980136d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 02:10:44 -0700 (PDT)
X-Gm-Message-State: AOJu0YzDnXLbn1EXd+ixQ9NX+Udv441sExxThDKg3bNyJESljCPH9buX
 TyPTj+GaCeLNxtP1gTaCM0/hTaRukZrNCOEqjg4k3q/ditBuGfMiWPh5wXzkyEKBrYfQO6dSMTw
 C9q9md4Q7Bm7mVgwX/zwYUhqZxrVt05E=
X-Received: by 2002:a05:6214:2dc6:b0:8cc:e8f4:1630 with SMTP id
 6a1803df08f44-8ccefd92dabmr101100206d6.30.1780218643016; Sun, 31 May 2026
 02:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260530171422.4615-1-contact@emersion.fr>
In-Reply-To: <20260530171422.4615-1-contact@emersion.fr>
From: Xaver Hugl <xaver.hugl@kde.org>
Date: Sun, 31 May 2026 11:10:30 +0200
X-Gmail-Original-Message-ID: <CAFZQkGwNviB36JDMXnzVb7APRqjmdh3pXSXGJftJbBYCUXXpjg@mail.gmail.com>
X-Gm-Features: AVHnY4K7r2fjvgwTh567CP2ikBVCq0RlSKYEYmiRFVMLNa9CLfzJkJrHLrj_d1w
Message-ID: <CAFZQkGwNviB36JDMXnzVb7APRqjmdh3pXSXGJftJbBYCUXXpjg@mail.gmail.com>
Subject: Re: [PATCH] drm/atomic: introduce PAGE_FLIP_EVENT property
To: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org, 
 Daniel Stone <daniel@fooishbar.org>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
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

+1, this is very useful. A KWin implementation for this is at
https://invent.kde.org/plasma/kwin/-/merge_requests/9308

- Xaver
