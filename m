Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E04C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:35:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B87810E076;
	Fri,  3 Jul 2026 16:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="c1haQNi+";
	dkim-atps=neutral
X-Greylist: delayed 679 seconds by postgrey-1.36 at gabe;
 Fri, 03 Jul 2026 16:35:19 UTC
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk
 [78.40.148.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C441C10E076
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 16:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:
 Cc; bh=FQEgoFdLfoRj49afAxGlPNgay8aUH9uGdQsfXIsb9r4=; b=c1haQNi+zBFWSDbRAT7DeC
 I2z4P3TM+bvyiHNLdyMHN2HXMymcZ6pYRYCKx5sTK3ehzgpL1Z1/hqFiraxMJkYx8Mftiz8UMKvHw
 LcC0Ya+lbv6qnfoBj0EXMVptd+m0tbDLJQxtq14Q/cQkUmaFVOg5t5kjfJ3lnm1FcofNPFMtX5Shy
 liL3PWRjOjSmlVaJu2sj0LNMmUDCCqD8a25hFej6h9KLfSwlPGJxcL5XDBL4c3dj0UVc0Hp8d9adk
 pY7TNESUwBji7CbI2i2N8DqxnhA9/sRYLgjVpIcC7/TGz+DE0VfIjq7ddjNAh/aHu9LkPMLNZEMBW
 lAVNWsySQ2Wg==;
Received: from [167.98.27.226] (helo=[10.35.6.194])
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1wfgr8-00Agof-6F; Fri, 03 Jul 2026 17:35:10 +0100
Message-ID: <b2c5ea38-bb7f-47c8-93ce-db15b66d0e58@codethink.co.uk>
Date: Fri, 3 Jul 2026 17:35:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imagination: make pvr_fw_trace_init_mask_ops static
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260623105341.775693-1-ben.dooks@codethink.co.uk>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20260623105341.775693-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 23/06/2026 11:53, Ben Dooks wrote:
> The pvr_fw_trace_init_mask_ops is not used outside pvr_fw_trace.c
> so make it static to avoid the following sparse warning:
> 
> drivers/gpu/drm/imagination/pvr_fw_trace.c:74:31: warning: symbol 'pvr_fw_trace_init_mask_ops' was not declared. Should it be static?
> 

FYI the Matt.Coster@imgtec.com is reporting recipient failure.

Does this need changing or removing?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
