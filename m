Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C8BCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 16:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF7B10E0BF;
	Fri, 19 Jun 2026 16:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="GuCkHs+v";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBC410E0BF
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 16:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781887667; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=k3aBI+CremmlUBfuqdxbNOJsq5m1owkuKwYK3vXilka7k4czcNo2KC3RCfLQTfFiLHFv1rgdawZ1fmxU02cWoXwJVk7g27VWMDH0FXKmirD7tFtbM+/h/SVlU2avMvzm8Z4yqji4BO33f4HxY5UeFqd417wHUdc3XPKbAFmqDKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781887667;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CBwu3+zGcp0kLcK+AkvJAKJVprFz3T4SXzCLOXEuPiM=; 
 b=NspFGz+FclpNYDYrvVtphcS9YFwej5ZXGdslp9CO7PCcjSPfEqNqFNa4e1wdzKotklZkz7lva3+hay9y+aG2A6t/sNBq2uCHpNstF3GsoTuSX12zHgVO1AVVT1EPLhjYkUYTS5nSI091UzzZQ0nkemxTMXCKlglUktkHesvGnWc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781887667; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=CBwu3+zGcp0kLcK+AkvJAKJVprFz3T4SXzCLOXEuPiM=;
 b=GuCkHs+v8NiTFeAmg3jIKsLYKn94mvktFm6Czv0dSWvfr2kXQ9wbIXV5WkJuJLot
 7B7YuQvS2+s0ix9vw0qNKVTCsBAEvgKn4M9vOBCJuOLp2wHsCbE3FBTta0fd22ubMmq
 1ico+pwG47pfnOaA+T+y4uvpXCTeLIUZGSD9B5MM=
Received: by mx.zohomail.com with SMTPS id 1781887666159611.7240700911418;
 Fri, 19 Jun 2026 09:47:46 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] drm/panthor: Add vm_bind region with kbo range
 overlap check
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260619145906.3b78b357@fedora-2.home>
References: <20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com>
 <20260619-vm_bind_checks-v2-1-b51abab35f71@collabora.com>
 <20260619145906.3b78b357@fedora-2.home>
Date: Fri, 19 Jun 2026 17:47:37 +0100
Message-Id: <178188765712.2027515.1485808731432603029.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=rZ0U1SNvXE0Jg5QWFayhbEYuDkszYODK+EMRTWfzdek=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqNXKvZPD7C4i73VHzRLA1cc/wn3GFfQJCzfcl1
 iCaHpiO412JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajVyrwAKCRAOJn5M7lND
 PfMaC/9wd+1U5YLXnA4eqh/MkzzW1Pqo+zgSYg/e1Y2W6ZIudAAtu+VJiEXSeVvy/P0bPZQD4BO
 9ekLgRI/7ds37JAd99Y7PDYamySgbS06FerufcP4sk7DfFVRffyMb7rzIUztcZ/dXJ7wevdqkpe
 3XWuFlE/n/Q536q052uKewkBJAFtMLixgqxY/pN92KWhV5+d0iLCL6nx6QJRsFHui3rj6kkT9N6
 35U8zCWTjOjtMUx9IdHuRL2iaqi+zGAtjpMoCoe4YIjuzZmgnvwkx/+C/WlUDlKnBdzUFpUTXJY
 rfUBj6TidYDXx+GWBy/oXzdbzZQm4UiqIsiwSYD+Ow9ky23c6IYbZsVLkLB/Zxt3Cl8Oy03AT51
 rVSzlPkysfTEvV8Zs9bmKzt0hd7JVuakPfb4mi/11L4/mr3PQ/TEqoU/wTVoC7xY1a8hYlCmlwb
 1011/SwwmI0RQIseo/zZWRcnlpFyTMAa/qKa1RtgCx0TTsm6BbDraxJSh7T+hmEceMy4A=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On 2026-06-19 14:59:06+02:00, Boris Brezillon wrote:
> On Fri, 19 Jun 2026 13:41:22 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > When a VM is created, caller has to specify the range of the address space
> > carve-out set aside for mapping kernel BO's. That means vm_bind mappings of
> > UM-exposed BO's should not intersect with that region, but at the moment
> > we're not checking this.
> > 
> > At first, I thought of giving these values to drm_gpuvm_init() through its
> > reserve_{offset, range} arguments, but it turns out that is meant for VM
> > address spans that are not managed through the usual drm_gpuvm split/merge
> > circuit, so storing the end of the user VA range at VM creation time and
> > doing a quick check in the vm_bind ioctl path was the simplest workaround.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> 
> Ah, we need a Fixes tag here.

Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
