Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC94CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 18:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55EDC10EC47;
	Tue, 23 Jun 2026 18:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="HmuvRFHe";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585FA10EC47
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 18:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8gavGOESHLq3+poxJrUxbYbmCuo9oiYFM15F/Tg6AEA=; b=HmuvRFHeDE7oJMQz0vOstfzrQZ
 caCfhKNV7npiQ9lxy2BfPq+mh/C3C0nm5oPCSr7DO2Ubc61J6uJxhYZAcprNT9gWiDtpO3JhMIZH2
 c+B9CuXL30eQZ5nTU+FlHZlGMM2IvnROwgBxPkEkByNe8jxasvwd57rX42o3l8KDJrWErQVxVtP1N
 1fQSn62S/yX4og+7pYw/D3lQZaO50zuxLbxspWGoPQ9PCq14W+crmwXsT//eJqlEDBqfpHLwo7E7W
 AM2fCdu0SwaipdbFyBVeOXcAWPMIYGJ8MbM0jgjYmElkgn/tir72WYvOGIew7cMxKvt6S9NmfddqV
 ZYaUEwqA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wc5wM-00000006cwF-1Y3h;
 Tue, 23 Jun 2026 18:33:42 +0000
Date: Tue, 23 Jun 2026 19:33:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Christian A. Ehrhardt" <lk@c--e.de>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Check VMA boundaries for PMD mappings
Message-ID: <ajrRhpVH6uhOABnV@casper.infradead.org>
References: <20260623181942.1536598-1-lk@c--e.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623181942.1536598-1-lk@c--e.de>
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

On Tue, Jun 23, 2026 at 08:19:42PM +0200, Christian A. Ehrhardt wrote:
> The panthor version is only compile tested because I don't
> have the hardware. However, the code is identical to that
> fixed in [1] and I have a reproducer for that.
> 
> No need for for stable backports. The code is new in 7.1.

What documentation did you need to see to persuade you to use
map_pages instead of writing a huge_fault handler?

(yes, you're all Doing It Wrong, please stop, but help us help you)
