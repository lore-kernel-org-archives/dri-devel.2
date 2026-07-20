Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9BCC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356A710E96E;
	Mon, 20 Jul 2026 14:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hSlUE3Az";
	dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6266D10E96D
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 14:39:53 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id B854120B7169; Mon, 20 Jul 2026 07:39:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B854120B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1784558381;
 bh=Yd929J3oLULnC2Sok0hZvBBnQSG7U/e/XUsxCPLGcUE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hSlUE3AzN2EUZz2YFHVo5D5SD0tr6qkYbMQaTSO79rDpo9+dqa5MuzhUjOSSZhlUe
 whqoetTceWcsTYT1dLm6Aoj5TSOAFYnTPmmtKwzWK2vDwdJ81SGNLPFzkTCKenmi3v
 d8aLjVYfewxaA+3oxtKQDN9rnQBJRtxI8XO4HnQc=
Date: Mon, 20 Jul 2026 10:39:41 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Deepak Rawat <drawat.floss@gmail.com>, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] drm/hyperv: A fix and a few cleanups
Message-ID: <al4zLadVFWOaPXp8@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
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

On Wed, Jul 01, 2026 at 07:05:18PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> while working on a tree-wide cleanup I found a few issues in the
> drm/hyperv driver that are addressed here.
> 
> While the first patch is a fix, the issue is so old (from 2021, included
> in v5.14-rc1) that applying the series during the next merge window is
> probably the right choice.
> 
> Best regards
> Uwe

Applied (sans patch #3), thanks!

> 
> Uwe Kleine-König (The Capable Hub) (4):
>   drm/hyperv: Unregister pci driver in error path before module unload
>   drm/hyperv: Explicitly set subvendor and subdevice for pci match array
>   drm/hyperv: Drop useless empty remove callback
>   drm/hyperv: Move MODULE_DEVICE_TABLE to the device_id arrays
> 
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> 
> base-commit: be5c93fa674f0fc3c8f359c2143abce6bbb422e6
> -- 
> 2.55.0.11.g153666a7d9bb
> 
