Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB4606A336
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jklgyYEv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C72710EFC3;
	Tue, 10 Nov 2026 11:30:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id F131F10F058
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 11:30:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 466791516
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 03:30:03 -0800 (PST)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 14CF03F632
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 03:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794310206; bh=rsCGYOGTSBUcdVShCpc2QjxywBTq8SQYSTxbo5VBt2s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jklgyYEvZAZ4ltbKAd5bJ9aS/OiZRVMerlPmx6CsH/Xc0oM9eLePhvX1OTRCvkLoB
 INYCP17W5OT1MOyfMgaabYNf+EDHU2q2RyXKr6cMonF3Zr8pRdgrR2RmugOSoze96W
 rHu4yUUAv/2tecUHIzFQ6gAUA5KZf4sf1VSb+q/o=
Date: Tue, 10 Nov 2026 11:30:01 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Chris Diamand <chris.diamand@arm.com>
Cc: Akash Goel <akash.goel@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Florent Tomasin <florent.tomasin@arm.com>,
 Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH v2] drm/panthor: Add more reviewers
Message-ID: <avMAOa8ujH5Qrf7D@e142607>
References: <20261030144305.666845-1-liviu.dudau@arm.com>
 <20261030144805.667158-1-liviu.dudau@arm.com>
 <6ce83db8-f696-4507-88e1-0e113b8da8a3@arm.com>
 <42f8e9e9-858a-4a0a-bbf7-daaeba368736@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42f8e9e9-858a-4a0a-bbf7-daaeba368736@arm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 12:40:54PM +0000, Chris Diamand wrote:
> On 03/11/2026 10:58, Akash Goel wrote:
> > 
> > On 10/30/26 14:48, Liviu Dudau wrote:
> >> We now have more people that can do reviews and contribute patches
> >> to Panthor, so add their names to the list.
> >>
> >> Signed-off-by: Liviu Dudau<liviu.dudau@arm.com>
> >>
> >> ---
> >> v2: Forgot to add Chris Diamand to the list, fixed.
> >> ---
> >>   MAINTAINERS | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 89ea35a35c680..ef92c462a8381 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -2321,6 +2321,10 @@ ARM MALI PANTHOR DRM DRIVER
> >>   M:    Boris Brezillon<boris.brezillon@collabora.com>
> >>   M:    Steven Price<steven.price@arm.com>
> >>   M:    Liviu Dudau<liviu.dudau@arm.com>
> >> +R:    Akash Goel<akash.goel@arm.com>
> >> +R:    Karunika Choo<karunika.choo@arm.com>
> >> +R:    Lukas Zapolskas<lukas.zapolskas@arm.com>
> >> +R:    Chris Diamand<chris.diamand@arm.com>
> >>   L:    dri-devel@lists.freedesktop.org
> >>   S:    Supported
> >>   T:    githttps://gitlab.freedesktop.org/drm/misc/kernel.git
> > 
> > Acked-by: Akash Goel<akash.goel@arm.com>
> > 
> > Best regards,
> > Akash
> >
> 
> Acked-by: Chris Diamand <chris.diamand@arm.com>
> 
> Thanks Liviu!
> Chris

Pushed to drm-misc-next.

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
