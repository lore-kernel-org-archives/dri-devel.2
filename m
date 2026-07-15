Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93574C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2981010F201;
	Thu, 16 Jul 2026 08:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=comitia.dev header.i=@comitia.dev header.b="KvqjsRda";
	dkim-atps=neutral
X-Greylist: delayed 596 seconds by postgrey-1.36 at gabe;
 Wed, 15 Jul 2026 11:12:01 UTC
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [83.166.143.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EB010EFD7
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 11:12:01 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h0YCb3l83zHhP;
 Wed, 15 Jul 2026 13:02:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comitia.dev;
 s=20240118; t=1784113323;
 bh=yQHU5F9jk4BFtLjb2XsjC0JTJgJA+5AXT0o85gVvJUo=;
 h=Date:To:References:Subject:Reply-To:From:In-Reply-To:From;
 b=KvqjsRdaw9lsoE/rVhe+c9neAGyCBZUorb9k6amuv6tI4GHvBvS9aKTqQpmrf0lRo
 h9m4BS5CAhQnpNbM7YK1RR3jj2Vjj2/24iLChpxxYxja8MuDDCwp9SBiK1fbsQTlrh
 HbVOaaxWyw1z+4zNLcEi7ELjsgyVS39pFvYzpiK/TVdL8wUZg4mEATyCQXL4lSDEaX
 obInGaytu2N4Grv5P54fXe0M3+a+j/Gycb/wBN9tT5KHpStQZ+nruHpAfwXo2r0zur
 eWFFSxSskfS5mUcaq3pGrB3BeyHoAYDglQLDO3sLo0zEyXye6A1SWLk3uB68WugFEp
 A+sCUK2El0sVg==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4h0YCR2ZcTzlTn; Wed, 15 Jul 2026 13:01:55 +0200 (CEST)
Message-ID: <f6062704-60dd-40c8-bb72-8ba9b0f8ba85@comitia.dev>
Date: Wed, 15 Jul 2026 12:01:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org, mripard@kernel.org, airlied@gmail.com,
 dri-devel@lists.freedesktop.org
References: <20260216204547.293291-1-lkml@antheas.dev>
Subject: Re: [PATCH v2 00/14] drm: panel-orientation-quirks: Add various
 handheld quirks
Content-Language: en-US
From: Luca Frondoni <office@comitia.dev>
In-Reply-To: <20260216204547.293291-1-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:19:15 +0000
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
Reply-To: 20260216204547.293291-1-lkml@antheas.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi all,

I’m writing to express support for this patch series and to ask
whether it can be queued for merging. The handheld panel-orientation
quirks here match the behavior I’ve tested on my devices.

 From my testing, the changes behave as expected, and I haven’t seen
any regressions.

If there are remaining concerns blocking merge, I’d be grateful for
a quick summary so I can help address them.

Best regards,

LF

