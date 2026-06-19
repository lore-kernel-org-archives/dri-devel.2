Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F49CD98F8
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 08:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073E810F4BF;
	Fri, 19 Jun 2026 08:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jiBdkZw6";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C4E10F4DF;
 Fri, 19 Jun 2026 08:48:50 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ghWTq2RlHz9tFZ;
 Fri, 19 Jun 2026 10:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781858927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tgi+e4fw/0Sq4qycaZoRwYfCNcM5LXB+zap2ccrBmwc=;
 b=jiBdkZw6reU91amguLwH+nZtrpbcp6kZssaUTb2TSp3P7IZumnUyzthW4sHZiv6EkdWfDc
 0Y5rLVDOBGwV5VnaT7jZyNAPHaDwC7rKYfA2Ar8Zc0vGtKj/8wba4M/yZUALyQ0V0l6L4w
 pFnRZgK3R/WkIhUjJR8LRXZeXBklqYi34ayYT6jcGS+DbebfHsfaN4UCekKGwRAxPhw1oe
 RnKljANYY/viJS+QRyp3bnR5OYTxB2fxhz3jZd9pniTKVVNjAXoypwto/2A4H49sK65M6S
 ZirbnaSOPporFCZXLEiJsNkAXGre1tPfib8vPAyK3wWVCjwf+di94JROQGvnrg==
Message-ID: <159d862f-f06d-4ed7-bf81-082220cdfdd6@mailbox.org>
Date: Fri, 19 Jun 2026 10:48:45 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] drm/i915: Work harder to enable VRR based refresh
 rate changes on eDP
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org
References: <20260612144203.31715-1-ville.syrjala@linux.intel.com>
 <3d441831-71bc-49fd-823f-3af443e55b20@mailbox.org>
 <31da350f-adfc-4b2c-a7c5-5ed884ffd9ca@mailbox.org>
 <ai_40qUa-MVdbOEf@intel.com>
 <18f0c14b-f973-4e1a-948b-5274cc36895c@mailbox.org>
 <ajQ7W44qv28-i6Pq@intel.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <ajQ7W44qv28-i6Pq@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: k86p14pr5asizsd83yumi9s95nugbmrk
X-MBO-RS-ID: d157202689a012c1026
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

On 6/18/26 20:39, Ville Syrjälä wrote:
> On Tue, Jun 16, 2026 at 09:21:01AM +0200, Michel Dänzer wrote:
>> On 6/15/26 15:06, Ville Syrjälä wrote:
>>>
>>> What we're doing here is selecting the actual timings to drive an internal laptop 
>>> panel, given some random cooked up modeline from userspace.
>>
>> How can user space know what cooked-up modes it can (not) expect to work with this?
> 
> Without VRR support it can only expect modes that have the same refresh
> rate as one of the modes on the connector's mode list to work.

This seems to contradict "For non-VRR panels we just pick the fixed mode whose refresh rate is closest to the user specified mode, and reject the commit if it's not close enough (<= 1 Hz)" below.


>>> We pick the actual mode from the set of "fixed modes" (ie. the modes
>>> that the panel/system itself has reported as supported via
>>> EDID/VBT/ACPI/etc.). For non-VRR panels we just pick the fixed mode
>>> whose refresh rate is closest to the user specified mode, and reject
>>> the commit if it's not close enough (<= 1 Hz).
>>
>> Can't programming different mode timings result in the panel blanking intermittently?
> 
> Userspace can specify that a modeset is not allowed, thus if the
> driver can't achieve the refresh rate change without blinks the
> commit will be rejected.

How can the refresh rate change without a modeset (without VRR)?


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
