Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD3606A5A3
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Rn5s9j9l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 066D910E0E2;
	Mon,  2 Nov 2026 17:02:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 14FB710E691
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 17:02:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67AE416F3;
 Mon,  2 Nov 2026 09:02:31 -0800 (PST)
Received: from [10.57.58.9] (unknown [10.57.58.9])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 679C23F59E;
 Mon,  2 Nov 2026 09:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793638954; bh=EAEGPCUEjp9DZayF0ozcFHCgquqk3FNBZ41Ra9Fk05c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Rn5s9j9ls5bKvEVDBXCKJuqjXnnZU6XbwHCxBXXUyo00zD3F0BGCuzcwfA74GX8zR
 bxDdTRMru51skMIObZ/cJ+dQPCVMXFZ8Qn4nLo/1g3qDrxKlYEEhVroxn+eFVMOgjD
 ExB9/ip8YgfNgluxtu7nCRRltVHb9CgcNsI3Ylk0=
Message-ID: <b43d7467-e6a2-42db-b6dd-bc58996e9d81@arm.com>
Date: Mon, 2 Nov 2026 17:02:30 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Add more reviewers
To: Liviu Dudau <liviu.dudau@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Akash Goel <akash.goel@arm.com>,
 Karunika Choo <karunika.choo@arm.com>,
 Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Florent Tomasin <florent.tomasin@arm.com>,
 Daniel Stone <daniels@collabora.com>
References: <20261030144305.666845-1-liviu.dudau@arm.com>
 <20261030144805.667158-1-liviu.dudau@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261030144805.667158-1-liviu.dudau@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 30/10/2026 14:48, Liviu Dudau wrote:
> We now have more people that can do reviews and contribute patches
> to Panthor, so add their names to the list.
> 
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Steven Price <steven.price@arm.com>

> 
> ---
> v2: Forgot to add Chris Diamand to the list, fixed.
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 89ea35a35c680..ef92c462a8381 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2321,6 +2321,10 @@ ARM MALI PANTHOR DRM DRIVER
>  M:	Boris Brezillon <boris.brezillon@collabora.com>
>  M:	Steven Price <steven.price@arm.com>
>  M:	Liviu Dudau <liviu.dudau@arm.com>
> +R:	Akash Goel <akash.goel@arm.com>
> +R:	Karunika Choo <karunika.choo@arm.com>
> +R:	Lukas Zapolskas <lukas.zapolskas@arm.com>
> +R:	Chris Diamand <chris.diamand@arm.com>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

