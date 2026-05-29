Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1092CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 17:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353321122B4;
	Fri, 29 May 2026 17:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HA0VAkF+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78E01122B4;
 Fri, 29 May 2026 17:14:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 72C684059E;
 Fri, 29 May 2026 17:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641991F00893;
 Fri, 29 May 2026 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780074842;
 bh=FOngmApMBrQO8uj3ai8G4vkQzIPcP8Ggyb/B7X9jiE0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HA0VAkF+ZdznJDiNbldi/HgfrVJ63DSBEyskhz9QG5BShGd6nJbuCc2syGLjeSSNm
 T7PXFS3KuDO1NZd1sVmSFVTLFEoQ8nTqgOHE9n6dRa+42IDw60MmR3Byr9fK60d9Xq
 ruSedHMfqJUmUYqACtYtwFixkVtMfwJymIs4r/AeiHwdXJ4aAGlIWszCoSn8H52Kxh
 sAOsuHxIO/IgTsNtnmbJ5r5bFTmRoFCKdKJg9vBILH5me9x4Gqiy+5Dn/Xu6Eq8e8R
 cOCViNu8yP/qJ9MQgacQcQ7exaMK4MNot6MbMH2gmEaZjdFbbA1Lj3xisTdWGVWoti
 4CA6fblr3QY3g==
Message-ID: <f1ee6c54-25b5-4d9d-864f-26e349bb22c5@kernel.org>
Date: Fri, 29 May 2026 19:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Remove DRIVER_GEM_GPUVA feature flag
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Laura Nao <laura.nao@collabora.com>, steven.price@arm.com,
 liviu.dudau@arm.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 kernel@collabora.com
References: <20260421084701.24227-1-laura.nao@collabora.com>
 <20260529191027.40e1ec5b@fedora>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260529191027.40e1ec5b@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 5/29/26 7:10 PM, Boris Brezillon wrote:
> I took the liberty to queue this one to drm-misc-next even though it
> was lacking R-b/A-b from Nouveau/Pvr maintainers because
> 
> - it's pretty trivial
> - it's been posted more than a month ago
> - we need it to make progress on the Tyr side
> - if it's broken (I honestly doubt it), we still have a full release
>   cycle to revert
All good, thanks for queuing it up; I saw you message this morning and had it on
my list to reply.

- Danilo
