Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE14F89251
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4846710E882;
	Tue, 21 Apr 2026 11:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="wwc/GDLg";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C00F10E882
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 11:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1776771229; x=1777376029; i=markus.elfring@web.de;
 bh=b78PmUzf4IJam8ebpyiEFjBc7r/1t/LRu1VipZp3g+M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=wwc/GDLg1NxGj6qdNuctSRfFepTAqLbMWolFz8I8oh/69s3OxehLXj7NsH0ekZGe
 hxcuwEpX0IL6VDtc7fIYr9XCGe+/70yJg9NURHSFwJL4YcBh0Lj1pWDOKKC5aU9VL
 Ty6hy1KX76ePJY+IfhWH138fsn7qs/obxyw4mCHAMi9nYpyovbYAxvyDsDDCnByMb
 g4HC0tnwvSTlIvCPPbXsl9b03ZeqZ557UR68/zpneOwuHAHzEx88JJMvuKgwG+40m
 0KLMMaZDc+gOPcZVLNLAPUt8TQhXO/1b5M8UNndfN23prM51O5T7ruTBqtFzNH+TA
 8rv1A6sStGYGBbgsEw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO9K-1vg5an2Ts8-00qCRo; Tue, 21
 Apr 2026 13:33:49 +0200
Message-ID: <7cd7b467-90d8-48a4-bbb0-7b76b7ae57e3@web.de>
Date: Tue, 21 Apr 2026 13:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yuho Choi <dbgh9129@gmail.com>, Taegyu Kim <tmk5904@psu.edu>,
 Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, David Airlie <airlied@gmail.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <CACrCO_UK-XtK+0=AVO5uw_pi7rxfaP70cjU0bTkJAF-g0z+08w@mail.gmail.com>
Subject: Re: drm/sysfb: ofdrm: fix PCI device reference leaks
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CACrCO_UK-XtK+0=AVO5uw_pi7rxfaP70cjU0bTkJAF-g0z+08w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZttYVow/8HVn88IpeE1yUyPA/wR6sC44wOPSCaxEnhYI9FT+C+D
 Zbq+Ce+oHWFdtsjpDoEccqpjgST/8IhwCBuzCQFDGEgFLJglYkoXZ9RZbELpd2GF0bo0Ts5
 mH+/P1gwZmVKsrE1F/b+hqKUA7/z0SFYJarAy4X0FwReYf1ANtWgLrxmF921NH8p3UjZUgV
 J/SUDKzsqcysm8FywZmMQ==
UI-OutboundReport: notjunk:1;M01:P0:MX0I0BS5eNw=;0lvPCxtS5BuZEKwxBtwhRT81rCj
 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
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

> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code. Specifically, an experimental static analys=
is tool found
> that we are currently developing. The tool is not public yet, so I prefe=
r not to disclose
> further project details at this stage. =E2=80=A6

Will any additional background information become available?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/researcher-guidelines.rst?h=3Dv7.0#n5

Regards,
Markus
