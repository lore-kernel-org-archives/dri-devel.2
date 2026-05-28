Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5317ECD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 08:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52ED10ED80;
	Thu, 28 May 2026 08:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="sigEYBE9";
	dkim-atps=neutral
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A4510ED80
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 08:01:18 +0000 (UTC)
Message-ID: <9189701d-168e-1e63-8a6c-f6926029c336@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779955275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BqU1KULHNpKd+dvxOvwz5A4nP7Cq63wMOTMOE8f41c=;
 b=sigEYBE9VG+Z7WKjCq6mMqJ6An2dyD6r9Lrla0s3BB0zMiKJHdpR3N+nLodLHJ+C5XkfeO
 Di2f0oyz2YX9JdWcKHiX+SyjMdr12qfPYBbptiY4A19UMS9A86esUUFaKuFuL/C+oO0Tdc
 Sbn3/wI0m2vOEP9/ScSKCwsqmq4+IO8=
Date: Thu, 28 May 2026 04:00:53 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] drm: zynqmp_dp: Fix uninitialized variable in debugfs()
Content-Language: en-US
To: Dan Carpenter <error27@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Michal Simek <michal.simek@amd.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <ahP3Xagt1LJrhmFl@stanley.mountain>
 <935aaec5-5417-3cde-f944-3c04ffbd3458@linux.dev>
 <ahfeOh091V3BuuaB@stanley.mountain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ahfeOh091V3BuuaB@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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

On 5/28/26 02:18, Dan Carpenter wrote:
> On Wed, May 27, 2026 at 08:31:59PM -0400, Sean Anderson wrote:
>> On 5/25/26 03:16, Dan Carpenter wrote:
>>> If the *ppos is non-zero then simple_write_to_buffer() will not
>>> initialize the start of the buf[] buffer.  It doesn't really make sense
>>> to allow non-zero values for *ppos, so check for that at the start and
>>> return -EINVAL.
>>
>> non-zero ppos seems to be handled properly by simple_write_to_buffer.
>>
> 
> It's not an overflow bug, it's an uninitialized variable bug.
> 
> The simple_write_to_buffer() is designed to handle partial writes so it
> leaves the first "written" (scare quotes) part of the string as is.  But
> in this case, we can't handle a partial write and the first part of
> buf[] is left uninitialized.
> 
> https://staticthinking.wordpress.com/2026/05/23/simple_write_to_buffer-is-complicated/

OK, that's a bit strange. Can you add this to the doc comment? I certainly
missed it when looking around for appropriate functions.

And I like the explicit copy_from_user variant better, especially since
we are setting the nul-terminator anyway.

> Also this appears to be dead code since fops_zynqmp_dp_pattern is never
> used.

It's of course used in zynqmp_dp_bridge_debugfs_init.

--Sean
