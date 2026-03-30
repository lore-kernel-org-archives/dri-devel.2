Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE771061B20
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F39010E792;
	Mon, 30 Mar 2026 19:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.b="fiw8TMjt";
	dkim-atps=neutral
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4FD10E792;
 Mon, 30 Mar 2026 19:57:15 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B305840E015B; 
 Mon, 30 Mar 2026 19:57:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id PkiD68faWknn; Mon, 30 Mar 2026 19:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1774900628; bh=05cgH8e7z9VyRU1oNe/6JFJYrO6kARIEvJ9rEv3XzTE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fiw8TMjtOef4iZDsbI+JLE2WoWWt4Ghl4ROIa3E6+GyVfsfPa1SxqC1fUfcenKVfO
 OydrCktpqDvMIWPlsqX95puhDfF6q3m/a5doymwrtANnn3/gV+JTUrHRs0PuYeI8Cp
 LRsaHu2NravLVV0UNgqZgfEawwnnO/xsMWlw53u3jH9sPrtD3q9oHX2wUajQrgkftE
 KpgewwbccWoDBeL68W769XLyDq5gHOlLX/36f5KGun6r6pKQEP28kQAPzREZdgp4P2
 V4QBarpQUEVwcMcyUvdW+zJEVhzLrqcSWG8cuLniWKbzjmNqvIjOfeBYFHCmdROHVH
 +xSMMQE8F2LPPxOgDEo/9bcwsOkeMZxtfrUku/AH0cCVJU/QBYBzErFo3Dcp/5DFaY
 Fr+LMZtwyivdi++GGfRkqOSgLi5b00PvrhgQitEi9Tv7xwaSqOVvXNTwTwSaFvqLE/
 w74bB0fDmkMmBTF4lDxH6w8Q+0o8F+3scoo8m28XpwBfNKTcgV/rDW/a7SmoajNARg
 iT/CvN3NiiQCEf/iXzpJ4rcKRbFnVlnCFxgvKE0mB5mH5RMBNzN3+4WMtn808OjHDz
 zr1CcmJSI5Bff1lASOASmPHsyeAgD8M5owKEZ3InP6++D2qpFrua6xgAhIF67y7Zph
 +4DlipwOHEVFfDwrty0UN10c=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id
 5892540E016E; Mon, 30 Mar 2026 19:57:00 +0000 (UTC)
Date: Mon, 30 Mar 2026 21:56:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Eric Huang <jinhuieric.huang@amd.com>, Arvind Yadav <Arvind.Yadav@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: 7.0-rc6: amdgpu: BUG: sleeping function called from invalid
 context at ./include/linux/sched/mm.h:323
Message-ID: <20260330195654.GFacrVhlD8v7nqFir0@fat_crate.local>
References: <20260330134700.GBacp-1CFyWlXo7LcZ@fat_crate.local>
 <CADnq5_N+PSqi7Lf2Y1ZnKvWyy8jST4RZkCYAjFB7tdUc-ZkswA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADnq5_N+PSqi7Lf2Y1ZnKvWyy8jST4RZkCYAjFB7tdUc-ZkswA@mail.gmail.com>
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

On Mon, Mar 30, 2026 at 02:18:13PM -0400, Alex Deucher wrote:
> Should be fixed with:
> https://patchwork.freedesktop.org/patch/713383/

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
