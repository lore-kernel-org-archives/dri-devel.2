Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4B4D58CC9
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977FF10E63B;
	Tue, 24 Mar 2026 09:12:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=subdivi.de header.i=@subdivi.de header.b="JKAPjxDh";
	dkim-atps=neutral
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4445110E43F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdivi.de;
 s=k26.isilmar-4; t=1774302345;
 bh=TNfXuXilpGkss9Aq4f5JZ8vo6eDA8dwLNHFfHhVrB3E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JKAPjxDhpfMLJJ38Y8lUJxgeIXReotnHZr+xMkMt+Cc7qB7nz/dWocQOLyykCt+jG
 jI9fNkdAhH1O185jkQouBYmuGRatBRIp59L5HhA9K2bIaq1QGFn+EG3QU6XJwPDWHR
 u/ZiOw61xzLqVNofpRKOXa5OHBaoT8qxvRlq9ZzCXtOSW7IKLoQCQvfDWggIujWqgS
 o6/ZEF7Kkhv+6zfvvA15FYE9tS9kym676lZ3UTeN/nx6GufND/sxCR4VpjpsbodGCT
 1CXckBYSPUw599HN6ASHy8h/XI1RukhyuOHKQJZtjZDFzXH/ZiW3Rl5joSRS3fGwS9
 fQ83lx3Lto8zw==
Received: from isilmar-4.linta.de (isilmar.linta [10.0.0.1])
 by isilmar-4.linta.de (Postfix) with ESMTP id E9D81200321;
 Mon, 23 Mar 2026 21:45:45 +0000 (UTC)
Date: Mon, 23 Mar 2026 17:58:52 +0100
From: Helmut Grohne <helmut@subdivi.de>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Min Ma <mamin506@gmail.com>, dri-devel@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: amdxdna: firmware <-> driver compatibility
Message-ID: <20260323165852.GA13049@subdivi.de>
References: <20260320162634.GA1515@subdivi.de>
 <fa6faa70-04fc-72b3-8f6e-4d1ef062799e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa6faa70-04fc-72b3-8f6e-4d1ef062799e@amd.com>
X-Mailman-Approved-At: Tue, 24 Mar 2026 09:12:22 +0000
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

Hi Lizhi,

On Mon, Mar 23, 2026 at 09:25:01AM -0700, Lizhi Hou wrote:
> Thanks for reporting this. Does your linux-firmware have this change?
> 
> https://gitlab.com/kernel-firmware/linux-firmware/-/commit/58cf579b98c0c4878deeda1acb5db70e699875b5

No. My report is a duplicate of
https://gitlab.freedesktop.org/drm/amd/-/issues/5009, which is the one
resolved via the commit you point at.

I'll take it from here and ensure that Debian includes that commit.

Helmut

