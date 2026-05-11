Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10FACD37B9
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 12:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1743B10E6E2;
	Mon, 11 May 2026 12:13:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=scd31.com header.i=@scd31.com header.b="DLIQDVwF";
	dkim-atps=neutral
X-Greylist: delayed 310 seconds by postgrey-1.36 at gabe;
 Mon, 11 May 2026 12:13:19 UTC
Received: from scd31.com (scd31.com [205.209.125.10])
 by gabe.freedesktop.org (Postfix) with ESMTP id A258B10E06E
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 12:13:19 +0000 (UTC)
Received: from localhost (static-23-234-100-92.cust.tzulo.com [23.234.100.92])
 by scd31.com (Postfix) with ESMTPSA id 9AE1714012E;
 Mon, 11 May 2026 09:08:08 -0300 (ADT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=scd31.com; s=mail;
 t=1778501288; bh=ae/xcyGfqvWSFM3Vz72IIHThoirIKhFlGbNZj8scaNE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=DLIQDVwFt4l5WIYIMutF6yczEN6655jC2FMXmb29WtE8r5aeSpV1kP2z529PTP8vQ
 1uC3hD/1RE/Bj4OURBclu/fD9tqp4MWUDF4QI31POtqFeVlwgGAd/dQKdN7L5bjaNV
 oFO3t14EFbTbMqIT9TwirX0aY5DXgBYHik7Zl+LKtzpB+ln4PS8k4PfQMJ6/nMEonw
 +qxdylV6xp8tPvdLwyicG5rjOFZ3UW6/j1Et9jBzmZqRRzoHTe30tC0/tCYAJ21Fqo
 eTZ2lLEtdRkpSfUfLdmrOmA6iEo77zKoI7oFICGh3YOsZ4NksrZdvVall1CdUqYZj5
 xQSCkxpL1vkBw==
From: Sophie D <patches@scd31.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Sophie D <patches@scd31.com>,
 dri-devel@lists.freedesktop.org
Cc: rubenru09@aol.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gud: Add RCade Display Adapter VID/PID pair
In-Reply-To: <13469286-2252-4da2-96eb-979cc121f8b9@suse.de>
References: <20260509122037.4189266-1-patches@scd31.com>
 <13469286-2252-4da2-96eb-979cc121f8b9@suse.de>
Date: Mon, 11 May 2026 08:08:08 -0400
Message-ID: <871pfidu8n.fsf@scd31.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hello,

> That's pretty cool. Are these devices somewhere available for
> purchase?

They are not. I used to sell other hardware devices a few years ago but
found it took just a little too much time. Since they're open source,
maybe someone else will sell them eventually.

Thanks,
Sophie
