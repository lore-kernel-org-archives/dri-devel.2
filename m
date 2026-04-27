Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57987FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11EE10E8B5;
	Mon, 27 Apr 2026 18:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lPKdfqAq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3854510E8B5
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:24:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4AC9260138;
 Mon, 27 Apr 2026 18:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA4EC19425;
 Mon, 27 Apr 2026 18:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777314239;
 bh=RZcKzhKXqkXILopall1OZexxEW+DmWizquUvLq+yznI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lPKdfqAq7GsoZNomc7Oq/rfWMQbw7dT53mvVON0+aNc2nx0Sl3p1UmzlLTWI696SK
 8aBHUXpXQ61Q8cmPjK3/TCmDjpZvroaWyn8pcpOegEGiJ/6ajIP82Hxm+KL+M5LXte
 m4jkPuhRuDYV/2mnlu8N3FpbIYyNk6HBd6zroS7lfxAIw3cLXsAJx08KxtsectFlZT
 puPItX7wISsAQNwc/rpl71Bl/gZpJ3OIaajaU+3cIfxKrz8zmu+7s1KIAtNnHyOs0L
 blwbMDDHG5WqDQ2EhkuIKCzny8DPZn50VlCwWxpHNgvSe1ubSaXgvdhu5LxZ71r2bn
 wCPekKh0nHdnw==
Message-ID: <ce9545e0-bb73-48a7-95e7-267292701480@kernel.org>
Date: Mon, 27 Apr 2026 20:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: simplify and_then with condition to filter
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl
 <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260423-fix-filter-v1-1-b3b197c65daf@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260423-fix-filter-v1-1-b3b197c65daf@nvidia.com>
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

On 4/23/26 9:11 AM, Eliot Courtney wrote:
> This code is more simply expressed using Option::filter instead of the
> and_then with conditional.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
