Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931FDCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F6A10EADF;
	Tue, 12 May 2026 13:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=scd31.com header.i=@scd31.com header.b="BQweqzmL";
	dkim-atps=neutral
Received: from scd31.com (scd31.com [205.209.125.10])
 by gabe.freedesktop.org (Postfix) with ESMTP id CC82A10EB01
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 13:16:40 +0000 (UTC)
Received: from localhost (static-23-234-102-236.cust.tzulo.com
 [23.234.102.236]) by scd31.com (Postfix) with ESMTPSA id 0601414012E;
 Tue, 12 May 2026 10:16:40 -0300 (ADT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=scd31.com; s=mail;
 t=1778591800; bh=74iUMAD/7JluPfRK5w0aDMdt1JSir5ERbcQM8FVvY0o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BQweqzmLEIvf2P7w6KnQiGP4BDi6J+XefNMLr7b6i9Yj166M4xu8ge5HHCITfRnxY
 lB++5yNBxHzo8OIRVJKYuTFV6vJTyessWIQ821hRdJZxFFFoS5cbdcADX8AhfjPUeX
 I3mfE2h01NQldvyr71q3Beu2CXCo+Dngdsm3emb9Vnn2518VhGBlOyeXDDXWR6R6n/
 mhygLaNqxfD0JmpUcAPiZTKq1hcYWJ6sG3pg3eEQ5lVO4WYycfW0UudI9Yf5ixkfOD
 ENVKvutLEN+l9fHyzcQeT07/LDS5vrrbRoh5BgYl+kILREYZ6BWDCd3CZrNiO43UUN
 Fc27sG4i6FZPg==
From: Sophie D <patches@scd31.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Sophie D <patches@scd31.com>,
 dri-devel@lists.freedesktop.org
Cc: rubenru09@aol.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gud: Add RCade Display Adapter VID/PID pair
In-Reply-To: <af49bbcf-58d3-4fe4-a742-ba4da4493cbd@suse.de>
References: <20260509122037.4189266-1-patches@scd31.com>
 <13469286-2252-4da2-96eb-979cc121f8b9@suse.de> <871pfidu8n.fsf@scd31.com>
 <af49bbcf-58d3-4fe4-a742-ba4da4493cbd@suse.de>
Date: Tue, 12 May 2026 09:16:39 -0400
Message-ID: <871pfgahu0.fsf@scd31.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Ok. Patch is now merged.

Thanks so much, this is my first kernel patch (:

Sophie
