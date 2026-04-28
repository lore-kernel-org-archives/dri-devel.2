Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0286FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 10:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 153F110EAF3;
	Tue, 28 Apr 2026 10:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aT1FMpft";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C80510EAEB;
 Tue, 28 Apr 2026 10:46:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 15A8660141;
 Tue, 28 Apr 2026 10:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604CCC2BCAF;
 Tue, 28 Apr 2026 10:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777373165;
 bh=d4rj0BZX1ytRHLP1lNIfMn0jk3ciMqjsZ+Jr2lBEjd4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aT1FMpftdzYUl4F2Y8kKGE64sJH0CyW4NzJ/PP+yCZDuHwojLCD3tywhP2E23I7mW
 mhotwsCknk/Ko3UeBqLybTU+H+PnmNSqUg+99e3uX+ou8PFD9A3s5tmBZmAbgPSN0n
 sqc6U7f4B7V3V9cbi0oWly7LgefNIWiAoYRX9OE2K5aMEp07WPAPTIbrrJ7Xic5q9D
 nvlycBUCKrNZWcnh3y12tVcawet5n2flGHWxpXRRiI2H8KqPG+TV/f11RWTaqj8Xc3
 7opso3pwPSco+OWqN177s/72XoVlVGIoSICV078PHdkTyX84n2rkBAF2KC0DPuN1Gd
 49h6cWqx4VCoQ==
Date: Tue, 28 Apr 2026 12:46:02 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>, 
 Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH v2 4/5] drm/xe: Set TTM device beneficial_order to 9 (2M)
Message-ID: <afCP1fmeOUQCEHPX@zenone.zhora.eu>
References: <20260423055656.1696379-1-matthew.brost@intel.com>
 <20260423055656.1696379-5-matthew.brost@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423055656.1696379-5-matthew.brost@intel.com>
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

Hi Matt,

On Wed, Apr 22, 2026 at 10:56:55PM -0700, Matthew Brost wrote:
> Set the TTM device beneficial_order to 9 (2M), which is the sweet
> spot for Xe when attempting reclaim on system memory BOs, as it matches
> the large GPU page size. This ensures reclaim is attempted at the most
> effective order for the driver.
> 
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi
