Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF37C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21DF010F4D4;
	Fri, 17 Jul 2026 09:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RMKxXvhH";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA4C610F4E0;
 Fri, 17 Jul 2026 09:43:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 87BFCC2B9F7;
 Fri, 17 Jul 2026 09:43:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CBB0F60361;
 Fri, 17 Jul 2026 09:42:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6AD1111BD03DD; 
 Fri, 17 Jul 2026 11:42:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784281378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=wDA7PH6SG+1IbJdVpWIYnNVXI6eysPHFkoxwDGzOMF8=;
 b=RMKxXvhHqCyFi8shz1mt3PWQBGeeER7Fz63dXsty2lJq9WFTgV+UppFmeBRyFTM1jgSX23
 dlA6ZLOzvmha37E6UpGdJB3A119HyfzvdI1ZqH9+7LX/UstQaJ8W/IwKooNM/fbpslfux/
 Jh5L9npxcSw3UUDG9t35gEaTOM3TSrCbk8B5QhcMWcd6vwtzc1wMa5Jt44+xti8j8pSf6P
 Dm3Isj+PTvNjQqgHJ7nIMbpzVxzfFZWDMmiSDnJ45dBOOCLDguLfeKLcOpWh9okoQRklkm
 vCdnSp/IPYT1hBoV4xzIQVSyIgu02dEPeoHpGLjjKKP/odSR0OLpLEpzEgId0Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Matthew Brost <matthew.brost@intel.com>,  Thomas
 =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,  Rodrigo
 Vivi <rodrigo.vivi@intel.com>,  David Airlie <airlied@gmail.com>,  Simona
 Vetter <simona@ffwll.ch>,  linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org,  intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] mtd: mtd_intel_dg: add survivability partition
In-Reply-To: <20260715-cri_surviv-v1-1-61763a6f1076@intel.com> (Alexander
 Usyskin's message of "Wed, 15 Jul 2026 16:45:29 +0300")
References: <20260715-cri_surviv-v1-0-61763a6f1076@intel.com>
 <20260715-cri_surviv-v1-1-61763a6f1076@intel.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 17 Jul 2026 11:42:54 +0200
Message-ID: <87qzl2j6jl.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Alexander,

On 15/07/2026 at 16:45:29 +03, Alexander Usyskin <alexander.usyskin@intel.c=
om> wrote:

> Add option to expose additional fixed-sized partition starting
> from the beginning of storage.
> Xe driver can request this partition exposure if firmware or hardware
> have detected failure that may involve corrupted partition table.
> Fixed-sized partition allows full storage re-write in this situation.
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

I'm not sure I follow the exact use case, but I don't see any major show
stopper from an MTD standpoint, so feel free to take this through drm.

Thanks,
Miqu=C3=A8l
