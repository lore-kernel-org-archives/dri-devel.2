Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EC4C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:07:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA4610E541;
	Mon, 14 Sep 2026 08:07:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aslbRqxm";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7852C10E541
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789373248;
 bh=2AfN/zuzcXz2rERtX+l5Z4PCLd8URiu4rtP3kdK3Dq4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aslbRqxm/Te+ffUi3iG85l42oEtBYSXQpUzr46vCz8jPU4oK4qbQWv+a59K9KaeZQ
 Jlvap2UO+3D1AJrCfA+C/Z0wXHV/+6lAvHJLif0GDLdCL1NHe1wVj8NYiYeVzIABel
 7s9qWae9DuG8ZcQgrAYce7Ucx82Yo5rqfE67C1Ln9T6rsHXsscSlEbk9jpN5Msa7ts
 KVusV93w/6W+GpsCgBTjlpjA7VdeK39MWn7NHw6xdhtAjK+GiCC0J611We5HaIfMon
 Rqnic60btLZglX4nbw9cUo8nW1g2Zw7oXCrKgbotASkpgX/rL5dfiV1kTVdOKkfqMH
 DgRpQ3dr+ZemA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4F7BD17E005A;
 Mon, 14 Sep 2026 10:07:28 +0200 (CEST)
Date: Mon, 14 Sep 2026 10:07:22 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Adrian Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/18] drm/panthor: Add debugfs knobs to simulate
 reset failures
Message-ID: <20260914100722.279b6532@fedora-21.home>
In-Reply-To: <aqWmIbT_46Enz8VH@sobremesa>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
 <20260826-panthor-unplug-fixes-v4-18-982cc8f4234b@collabora.com>
 <aqWmIbT_46Enz8VH@sobremesa>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sat, 12 Sep 2026 20:27:28 +0100
Adrian Larumbe <adrian.larumbe@collabora.com> wrote:

> I've tried poking the knob that fakes an error in the reset path and got two different kinds of oputput:
> 
> Either
> ```
> [ 1950.080236] panthor fb000000.gpu: [drm] *ERROR* Failed to boot MCU after reset, making device unusable.
> [ 1951.167384] panthor fb000000.gpu: [drm] Timed out waiting for MCU to halt
> [ 1951.167543] panthor fb000000.gpu: [drm] Failed to cleanly suspend MCU

Hm, I guess that happens when the unplug work has been queued but not
executed yet, and something tries to interact with the FW after that. I
suspect it's some autosuspend request kicking in after that, and asking
the FW to suspend, which it can't do because it's not even booted.
What's weird is the 1sec between those two events (I don't expect
unplug to take that long to execute).

As for the race, I'd say that's not a big deal if the final outcome
still is that the device is unplug. This being said, the more I look at
this, the more I think triggering an unplug on a FW boot failure is not
the right thing to do, but that's another can of worms I don't want to
open now.
