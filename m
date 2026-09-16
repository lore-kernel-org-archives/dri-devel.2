Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B0BC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5321810E0C7;
	Wed, 16 Sep 2026 13:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LfoVsNzt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEFA510E0C7
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:22:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AE5760234;
 Wed, 16 Sep 2026 13:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366A81F000FF;
 Wed, 16 Sep 2026 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789564923;
 bh=YFiTkxY4NnahRWADkTjvK32t/QFawfHXHLOvPkMD0aQ=;
 h=From:Date:Subject:To:Cc;
 b=LfoVsNzttzZqw9jnVkyiKm1jz+gqn9MVzP6upZW+Cvpfvd4RJMlUv/W2EVBdpN0m2
 P3IcsjsLZkLuPbbV1Po9K1gKylmprm58C01Y6VUd4HfGIvZUQ1aIMc6/QMX45+Yiug
 67hZhEMDg5EDO5cSZQN1Sjh9DvQ2vEer22SvLAYt4+ougxk1Gf8cxREmBiwnm+1+oo
 s1wyueL5y+UtLChAJcCAuTmJxca04manCul/6PI8joa9F8k7or12RIyQHchxNQxdwd
 sigzQkzEyKLH9Vz2yV+suHMRGb6MY12IVj+DdC4BHEUGYZLBexHNDh3uL1/69jMw/T
 fdiz1E6L9WFkg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 16 Sep 2026 16:21:58 +0300
Subject: [PATCH] MAINTAINERS: DMA BUFFER SHARING FRAMEWORK: tighten F: matches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-maint-dma-buf-v1-1-0f8d6c5bf1cd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7tBEQbBXKV1MkolOIbFMtBTEu
 zdpl+/z3zugsAoXuHUHKL+lyJor2EsHfqE8M0qoDL3pRzPZERNJ3jAkQrdHHAZrycXgJ8NQnZd
 ylM+vd3/8uezuyX5rkfZwVBidUvZLm1aVWfI1UdlY4Ty/DQzjNJEAAAA=
X-Change-ID: 20260916-maint-dma-buf-3311abfdc90e
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=83=C2=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>
X-Mailer: b4 0.17-dev
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

F:	include/linux/*fence.h

in "DMA BUFFER SHARING FRAMEWORK" entry matches include/linux/kfence.h
although that header has nothing to do with dma-buf.

Replace it with explicit 'include/linux/dma-fence.h'.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2414447892c2..656bc5ed8d2ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7688,7 +7688,7 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/driver-api/dma-buf.rst
 F:	Documentation/userspace-api/dma-buf-alloc-exchange.rst
 F:	drivers/dma-buf/
-F:	include/linux/*fence.h
+F:	include/linux/dma-fence.h
 F:	include/linux/dma-buf.h
 F:	include/linux/dma-buf/
 F:	include/linux/dma-resv.h

---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260916-maint-dma-buf-3311abfdc90e

--
Sincerely yours,
Mike.

