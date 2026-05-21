Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D96CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7209C10F33A;
	Thu, 21 May 2026 14:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="NvnoBZXP";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3330E10F33A
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:44:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779374660; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mDnyxuOYJdXBYOZaQPNGjcUE0g77w3Ui0Tg/awxvsqlFh+ggu79lnlr46p/QHLKTuIRpa3xaJgFpqDlo37MpzZ0ae7npS7uwt5+6dI2V+VKrHIqOjQFsHk+vgDy2/MFowC2YHIg2l8xejKVfLqln6O3FiPHRrspi8O0XYZgE1PA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779374660;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=E5ELqRyr9T7zlrucxkJjUBvAh6fvBHX8FO7DNNZfDWc=; 
 b=N+ZipboFcCP8Z3IHSZZ9mEs4UdTMlvpvAblrNAA9jxO0OJj6Kkl7u7SFIS1K13kjeyu0KDFaxIlIxBcwJ+Z+A+iKma2rKKsgJdFiODpkkZ+6rR7YLQTpCeufvndBCYu8jtLUePewT4BNiO7M+oWrHq5rRN/ysmifnNXltFEoDVg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779374660; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=E5ELqRyr9T7zlrucxkJjUBvAh6fvBHX8FO7DNNZfDWc=;
 b=NvnoBZXPWiqzdoDWMTkEUBB1W+sGJyKKFTg6YweGI4NF2bR7f/g8Ji/7nuyqtFj4
 ft7is7BmuOjfAKrGd8JB+RBi3du/1sdVPcBqjSoJxOLJL0DIT6Mr/0oThzTUbl63cDu
 qnuJNfd7g8h08F4Ma50rRPD/pyC402CRD3BRTO8Q=
Received: by mx.zohomail.com with SMTPS id 1779374659082442.6600190654501;
 Thu, 21 May 2026 07:44:19 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v5 1/2] drm/panthor: Implement evicted status for GEM
 objects
Date: Thu, 21 May 2026 16:44:14 +0200
Message-ID: <dhbTwVh9SgW4h4Fwktewag@collabora.com>
In-Reply-To: <20260521-panthor-bo-reclaim-observability-v5-1-49313994da55@collabora.com>
References: <20260521-panthor-bo-reclaim-observability-v5-0-49313994da55@collabora.com>
 <20260521-panthor-bo-reclaim-observability-v5-1-49313994da55@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Thursday, 21 May 2026 15:51:15 Central European Summer Time Nicolas Frattaroli wrote:
> For fdinfo to be able to fill its evicted counter with data, panthor
> needs to keep track of whether a GEM object has ever been reclaimed.
> Just checking whether the pages are resident isn't enough, as newly
> allocated objects also won't be resident.
> 
> Do this with a new atomic_t member on panthor_gem_object. It's increased
> when an object gets evicted by the shrinker, and saturates at INT_MAX.
> This means that once an object has been evicted at least once, its
> reclaim counter will never return to 0.
> 
> Due to this, it's possible to distinguish evicted non-resident pages
> from newly allocated non-resident pages by checking whether
> reclaimed_count is != 0
> 
> Use this new member to then set the appropriate DRM_GEM_OBJECT_EVICTED
> status flag for fdinfo.
> 

Oops, feel free to drop this paragraph in the commit message when
applying.


