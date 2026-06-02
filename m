Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C18CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 10:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55FA010EF19;
	Tue,  2 Jun 2026 10:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="YUUzW8UD";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB7610EF19
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 10:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780397771; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=im9nJq32cMf/AaxOxw7ddKE2oAtPjIbuXXkQpZQIdgGGixPBBslhvCjQx3udsv+RcDEyidaE2+17AVkqzIpIEpkKlM9+dIqzFDi8GS3LH6sd9jgTP6ZaI0yRtkqkQ9NJl8BFhFebUXy7jvGU+PNyAOIP/0s3aOHI5xIJhZXiEj4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780397771;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iiBqjoD4EsYqN1Fal3BhE3EeXjYiDrKSSSa/8jY4Bko=; 
 b=LGfetZ4eXbSXt35OSAULZH1+55ZJvj5MvYjnwFx6g2LMJCzhYhn+pZlVEn54/SJYezbPt28ndPAxT8+4NkozqcLqdLbvXN81+dbwGSTpqw2LVC/DbPtQCrzC+Qp6ULwA+pckr+nFR+1uZrM2I68JLFFtmSDH2ILS7ttxQHM0O7I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780397771; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=iiBqjoD4EsYqN1Fal3BhE3EeXjYiDrKSSSa/8jY4Bko=;
 b=YUUzW8UDzKIpQy4JqBRBbq5zO5hi8klUbS4R6CTmYQk8S0/vRAd7dhA/EjYSt8KV
 qYCWpQdzfBnyngNV0ewDghksfysVyQPjm2IQmQDgCnlirloQLZeg6p4krD/ArrZ0RGZ
 D6PCx4RtKqVy4C3yvArUu1GSk0u6O9nnNpE+sLQw=
Received: by mx.zohomail.com with SMTPS id 1780397764062323.93913048628724;
 Tue, 2 Jun 2026 03:56:04 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 0/2] drm: tyr: use lifetime-bound IoMem
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260529000106.2257996-1-dakr@kernel.org>
Date: Tue, 2 Jun 2026 07:55:27 -0300
Cc: aliceryhl@google.com, boris.brezillon@collabora.com,
 deborah.brouwer@collabora.com, gary@garyguo.net,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <17A1BFA7-A5E1-430B-A954-9C2AC9439FE3@collabora.com>
References: <20260529000106.2257996-1-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 28 May 2026, at 21:00, Danilo Krummrich <dakr@kernel.org> wrote:
> 
> Adopt the driver core lifetime infrastructure for tyr.
> 
> Separate the driver type from the driver data and use lifetime-bound
> IoMem directly in probe instead of wrapping it in Devres and Arc,
> simplifying register access.
> 
> Changes in v2:
>  - Don't return Result from GpuInfo::new()
>  - Use "drm/tyr:" commit message prefix
> 
> Danilo Krummrich (2):
>  drm/tyr: separate driver type from driver data
>  drm/tyr: use IoMem directly instead of Devres
> 
> drivers/gpu/drm/tyr/driver.rs | 29 ++++++++++++-----------------
> drivers/gpu/drm/tyr/gpu.rs    | 17 +++++------------
> drivers/gpu/drm/tyr/tyr.rs    |  4 ++--
> 3 files changed, 19 insertions(+), 31 deletions(-)
> 
> 
> base-commit: a3e50e7279996cd987001fd8a3db36e72665f8f7
> -- 
> 2.54.0
> 


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
