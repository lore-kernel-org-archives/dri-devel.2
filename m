Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6283FCD6E50
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 15:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559471120A4;
	Fri, 29 May 2026 15:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=emersion.fr header.i=@emersion.fr header.b="niIIe0Sb";
	dkim-atps=neutral
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch
 [109.224.244.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5B81120A4
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1780067615; x=1780326815;
 bh=d691E7S4JKA5N68J6xXEM88T/qhhchag9EyvFIrpysk=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=niIIe0SbsrgFgIWzUerbTL3OYy1SItXIwLo/fqR4TCg2PHWfyiWDLnkLqEDywmqyB
 7doUTo0jXEwpOojaJGjEFhMCtXfK/Ul82Fw5pVKRprTJ2hlJNXGtq2TjiyiXPs3+K2
 MgezpEXWOpXmU0MCpv6KACvAXtF4syxeU4XiMu92Sm0T4mHXX57XbDn12SQbOeVf1q
 5d2JWqV3wwLkB6dJUC2XZL8kZRbHwMeIUmAVHFtN0kBtDzoQ47IiFmIqFTc4u8ays8
 mmuqfblyoMBjbXIPPslQ6s9K9kODYBl0eRi+FRoazk2BHUPXoeXxVZtgSMVxBsbtld
 8yBnwBaJ5v+1Q==
Date: Fri, 29 May 2026 15:13:31 +0000
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/9] Add support for a DRM backlight capability
Message-ID: <Wzxf7qbcz7oFD46p92-mmJpW82TODVKgEavQ0dHVNQwURYo37sTqHP05phH6LTa5e4b1Mkyui1R_tjXbNIGBap8WRgIQDAkglCBfnutGFEU=@emersion.fr>
In-Reply-To: <20260528054911.1513208-1-superm1@kernel.org>
References: <20260528054911.1513208-1-superm1@kernel.org>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 59a38964a4fbfa6445c3598da4efb7b41e03ef5a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Very nice to see this moving forward! :)

I've tested this patch series and I've written patches for wlroots:
https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/5384

Tested-by: Simon Ser <contact@emersion.fr>
