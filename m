Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F251ECA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399C910E198;
	Tue, 29 Sep 2026 03:27:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HjVYVgo2";
	dkim-atps=neutral
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2E510E198
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:27:55 +0000 (UTC)
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc769b0498cso195244a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790652475; x=1791257275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CZw5mMt24fjggJ7CV/G4ShOOKQS8QFK14O73CG5mjTo=;
 b=HjVYVgo2RUULXYA5dUKM+XNnhWGXk4yg0U4/FQ+YuSk4bUAZhDAPoyK+TtURzDKb5D
 1RORwAyutDElyAGmU+vAshZcggAGWsWZDhUNokq0OBzjYPuFGewIXKyupnV/aKjFNl9M
 U1DFHr9/b1BaM2zg59GHZKFlUfxHbCgKScxs/iVZsG1gBSyj7Bzee+Eps34nNuodhmBT
 B2JN6jYlSXqTFD+9pWCMTuhycdG3cggOlr+zhxKan97+vE9UkOf7rG18zHuKo8tGKFpS
 KPixuOZjWKS4FxFarw8QWxrjXjvaulA7+aUaHoAB1XxnSFiB3qj6zOY/BQMt1YPNNbm/
 sN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790652475; x=1791257275;
 h=content-transfer-encoding:mime-version:content-type:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CZw5mMt24fjggJ7CV/G4ShOOKQS8QFK14O73CG5mjTo=;
 b=V0HnYIYR/ald3XBfaBeXojTYW7jFTUMaPEk24CoMPZ+lVv7Qb3iZT/Aq9abFZ2kjNM
 aC0Lo/0BSO3AM0IBM2MJ7cGJuTuzXNEjCd3+gzsHDzk9W+Xae8cO1bElrdMMBdO4gLRn
 O8nw0oVy0E+fMqJ6hxPpNLsoG5n5uiUXG2OBrilddKZvpMZ3ft5Ck8+mIgQq1TrChS3V
 oS0pt0TifAvVhWzHboL8kRR5V/ZcSSbvCqt9jyvyXrrck75tGtSoWX54a30TXY3Oe5m1
 3bAJqiWWdvNI4LZVxUIZzUxHfaBKcMbPFnzJ9GDPQIxaeqzY3wipDQ2U/byr61Mx1zRm
 vu4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxJhnY8jwIWFZ9i3q9piwp7NWu4KgqBTkpgoLsSZ1Tyg+Qt+8LRx4Q+HF9vAFv4uzcTj8/MQkc5ic=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mF9lhBk9S/D4C74bSJeWQkAewTQRVV1XHO35HIuSAaZJz0xqVB
 imbqZbl8R/vEEGa8TpAohcmoJ+pq05jbkh1TCL8Lq2/iKPs1nXwJbJIB
X-Gm-Gg: AYBFou03q5XogqImAJJZgVxVcWifN0gDZirNHuim/KAOPkQ5zrGQxF8qMlhnTFaNF5+
 aL0Avr1jmFiv/B0Qb9nj56K2RzbZ4Rlu+9ToF7MU2lDBpQZQjE1d3YAH4pSz3zaH5JKuo27HLWD
 Hp3lqejanYeWeStf+QmrEFoaJykvYMc8hYQyF5JDupXgsH1iPOC8ldbaak2lfMyqKsLZymEEyfh
 WvYQIvZhjC+F7gGDeeth7KBwIDftCXJn8cfg6/hsVesCf9Uj3YRTJOcb+Mh/QAFQ/TbPpAePIsG
 cYe3mmxdEqx+CowAieIwE5IRRwZWYPymJqQwTZ62Mf2osUGFQq7ae5ArUkO0krmxxb959yR9Ipj
 Dj0AWjq0fCaI+JMAw5pbCaKWTaoJay9Hg52DxOMfNiVTefL6Kl5CoQCLjYbMK1saKMarZKge6KV
 qpdajkuzGB9J6xxa82Wers3kbjNO9ZtVqgl1IIoMH1F3LbyQuGw2npsywhKnOpzlH2+keN/BUMQ
 QgQDpeJQoyBgA==
X-Received: by 2002:a05:6a00:7106:b0:881:4a2d:5c3c with SMTP id
 d2e1a72fcca58-8814a2d614emr7689172b3a.2.1790652475306; 
 Mon, 28 Sep 2026 20:27:55 -0700 (PDT)
Received: from jfliu-sfa1411.. ([129.227.183.200])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066926sm48883b3a.19.2026.09.28.20.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 20:27:54 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
 Rob Clark <rob.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Bryan O'Donoghue <bod.linux@nxsw.ie>,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/msm: map page-less imported sg_tables from
 their DMA addresses
Date: Tue, 29 Sep 2026 11:27:35 +0800
Message-ID: <20260929032744.37269-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <bd4e5ece-1358-4e0b-bb04-ba9de62d26f6@amd.com>
References: <20260928053901.7270-1-liujianfeng1994@gmail.com>
 <20260928053901.7270-3-liujianfeng1994@gmail.com>
 <bd4e5ece-1358-4e0b-bb04-ba9de62d26f6@amd.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Christian,

On Mon, Sep 28, 2026 at 12:09 PM Christian König wrote:
> That is not in any way better than illegally using struct page. The
> point is we need to get away from using phys_addr at all here.

Agreed, I won't push this further.  With your "import a shmemfd, not
a DMA-buf" remark in mind, the direction that makes sense to me is
the allocation model one: userspace allocates the decoder capture
buffers from msm GEM and the V4L2 device imports them, so msm stays
the exporter and never has to interpret memory it did not allocate.
Rob's series (drop the page array, mmap via the exporter) is the
prep work for that and is already in good shape.  It is also how
panfrost/panthor already work - they program their own pagetables
from the sg_table's DMA addresses and never look at pages for
mapping.

I'll withdraw this series and come back once Rob has had time to
look at the msm side.  Patch 1 is withdrawn too - Robin NAKed the
iommu_get_dma_domain() export, which is moot now anyway.

Thanks for the review, and for the earlier pointer to what msm is
doing wrong here.

Regards,
Jianfeng
