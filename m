Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B207CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42ACE10E876;
	Tue, 16 Jun 2026 07:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IBm4jAtU";
	dkim-atps=neutral
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E7310E876;
 Tue, 16 Jun 2026 07:21:10 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gfdh31D4Vz9tHd;
 Tue, 16 Jun 2026 09:21:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781594467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nE49FpUiAmb6Y1+uDOtAxVOfoHmPp7grMB2vEXcHP7o=;
 b=IBm4jAtUKL94H7E36joCasUHmklSeL1XNau1vJ5p2jmHbYFkU5biiKY3rSXAmVxn6HK+lC
 2nvGFHadlN6TSdESs7oTKScOM0yxYTnUewIAn2d6KNpoKMjvi5tWymIAn4xHQmp/SwPOxu
 RI0l/b/dInBK2tT+tar01OwMGezYnM1OyLVpuZB8kjzHk/Bi+0OxAYYpAyaC62pXHTSvN+
 PhzJdExNkVCtoX/uCrItTcYDbnyHkDHbJUhL4bAcxou925ZMOYw5cjo4v8xI8aSLta7Pko
 52bgJcluHnSOpbcoaCbaESEizRCVPYnB4VHOn3xAF8T1X4MFeuIoEiwSs5GX0g==
Message-ID: <18f0c14b-f973-4e1a-948b-5274cc36895c@mailbox.org>
Date: Tue, 16 Jun 2026 09:21:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] drm/i915: Work harder to enable VRR based refresh
 rate changes on eDP
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org
References: <20260612144203.31715-1-ville.syrjala@linux.intel.com>
 <3d441831-71bc-49fd-823f-3af443e55b20@mailbox.org>
 <31da350f-adfc-4b2c-a7c5-5ed884ffd9ca@mailbox.org>
 <ai_40qUa-MVdbOEf@intel.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <ai_40qUa-MVdbOEf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: sbdbgcpnh31xpk64ojmys9mx1u8b6r3n
X-MBO-RS-ID: 92707d3f935cd46cae9
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

On 6/15/26 15:06, Ville Syrjälä wrote:
> 
> What we're doing here is selecting the actual timings to drive an internal laptop 
> panel, given some random cooked up modeline from userspace.

How can user space know what cooked-up modes it can (not) expect to work with this?


> We pick the actual mode from the set of "fixed modes" (ie. the modes
> that the panel/system itself has reported as supported via
> EDID/VBT/ACPI/etc.). For non-VRR panels we just pick the fixed mode
> whose refresh rate is closest to the user specified mode, and reject
> the commit if it's not close enough (<= 1 Hz).

Can't programming different mode timings result in the panel blanking intermittently?


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
