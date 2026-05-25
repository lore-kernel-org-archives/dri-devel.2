Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B309CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 15:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 824D910E3A7;
	Mon, 25 May 2026 15:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E/6AMGVo";
	dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id BE5B310E3A7
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 15:32:19 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id 59B8D20B7166; Mon, 25 May 2026 08:32:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59B8D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779723130;
 bh=bwMuIe2pYJ9lckE+M2axekk85mrakFk9ZnH9KNYYavA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=E/6AMGVorOZ3AXYjoUxkF9z/jlIXSHy+Rt01CpmS+2Uoew8uCOtiDeJ5QvIbh7z9d
 ACcD2sm7tXjyB4LqTt9zY+DR9IBJ2cZDlL3H7XDhEEn4ZNAooNpvEisH6sRV+mmBbm
 Ddo2q8/ZTD2RzL1sLbyqaXDtE2If2A8bx+aoyOFg=
Date: Mon, 25 May 2026 11:32:10 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Berkant Koc <me@berkoc.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Deepak Rawat <drawat.floss@gmail.com>
Subject: Re: [PATCH v5 0/2] drm/hyperv: harden host message parsing
Message-ID: <ahRrehOc3ypcxOpY@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <cover.1779542874.git.me@berkoc.com>
 <ahQ0NS1jrfU8ms1U@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157F72302D2B4B86ECE553FD40A2@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F72302D2B4B86ECE553FD40A2@SN6PR02MB4157.namprd02.prod.outlook.com>
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

On Mon, May 25, 2026 at 02:57:24PM +0000, Michael Kelley wrote:
> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, May 25, 2026 4:36 AM
> > Applied, thanks!
> 
> Hamza -- which tree was this applied to?

drm-misc-fixes

> 
> Michael
