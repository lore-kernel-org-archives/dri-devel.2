Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E702606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=apT/I5X8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CC210E55E;
	Mon,  9 Nov 2026 01:50:03 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A2110ED08
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 01:49:57 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso555078eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 17:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1794188997; x=1794793797; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bWqnOxZVfuZbyPbSFQZbitavJOjkRpGgRKNzw8RjBj0=;
 b=apT/I5X81PobcQkp+6uut9Y158YtfT9/VhNe6ZviYO64xwduQRoQME9Fzq88R0wMfd
 5CKeIA1zfA2TBRsGnB0DyjiGVMxuEOXn77QOu6Haaye2Z1SivOzK7OHbnOvDWZbfWbof
 +1QeyUR9Ok04GuTbGoBZRL43jctVMZVSRlBEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794188997; x=1794793797;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bWqnOxZVfuZbyPbSFQZbitavJOjkRpGgRKNzw8RjBj0=;
 b=tZ6dpZCyT+qP56Lszxh2SwCP51ffHNBVU92gzxQ/bKbG51VXEgCw+pkj/r/5SSAPQo
 wZGpFu4FDctFY7qDLA1G9+IRdi9iOlvNul2kkP1XxrP/O9ChCOIb4OXIZWCA3I62Mg7n
 4sylRhp//ty/mU6vDa2/V6EN0K8hj1d1Aaez/d0559iESig5KLYrJX2sCN8BJF54TWUl
 zIrTC0drCQsbOmfFKOxD0jQCQban7aUqncEVLZeaUtCuoVN2wTXbKQKrIFG/UmbBHwE/
 um3NqIRKRtFYlMQMKh41+klseBdi8PFHMGt2QXwMmD0iEKD52kqaRR0WQHtdHQQCzuKB
 SPvA==
X-Forwarded-Encrypted: i=1;
 AL+hErFfFYiYOHTn22zckzGMueKeUfvPEZPQl9FNTpYO2IDtsMz8087S+ZN4f07OVgf98YambGSLI2CSVz0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+OHj3f+KqLowqO21ks/upyrJIE//JuRAH+XVtcOTU4nMgsmvf4
 FgHnuf8c7Bx3L5WFzx6PFd/17oIaA9e5fOk1RdS3jJekXRaNp168508HdT16qbWsM2M=
X-Gm-Gg: AYBFou19JP1NzfTvAXLfA1wc1KH+8pSM3elb8dr5uRAjEDH8z0sGe0COhZFzfgWh/re
 OKFwFpXXZjzOTvpzUvKVtrng8eZpdpIfotyy+QgObohj8nK+QeI1LNtXwaE8l3dpr3F+jxW5sKe
 Y+9qVKRf6RwwTszj250XneNWmZ0IJ0bIGRTdhSvgrhoZDOZ0F4GxlS2fZ415CVNO3dD5UJkjoCh
 EnhQpS5rrUZilwYmK0hBmPgQAE20lctAWSWvvTInkVXNgwPmBHdZWDyw29QdfJ2tbHLa0OexrrX
 pOGY6R1Sbq0Ig+RiX5tWiKQPv7umttlDmEqr+canWYJxlsiN7oRe6z0VeZC5CU3jPBL6wUdeJmH
 1p55wDfjuBc/1c02k2KyfqNP2Z03oILlFWcq+qfEve5Vkz1k0XDOuVF/kE6Jaf9jAgj4dpdcLie
 W6kK5GbcPhjLQzTyz5xJTjVCeYOh1+LWDAfRzprDYMAt6SEGy3zd0K9mOMSqh2Nwf+Z5YH7DVnK
 LUn1XLYKpoHCgs2jIAhBd+qNTc9D+yOFMZcPcBlih/333ygAIzWrYPCVaqRbGOmSVOA4QkZA7r8
 xmuY4UBzj0/acAJ19GbOL8MqrMOQnjhxdyCiCP2Ktq8M0vj4HN3kViLN6ZOtazw0XfixqS8Ws6a
 /UGIDoDuLhtQt
X-Received: by 2002:a05:7300:b296:b0:36e:dd5:fb08 with SMTP id
 5a478bee46e88-3725670f4famr5119010eec.40.1794188996697; 
 Sun, 08 Nov 2026 17:49:56 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-372631df629sm8829844eec.1.2026.11.08.17.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 17:49:56 -0800 (PST)
Date: Mon, 9 Nov 2026 10:49:46 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-dev@igalia.com,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Luben Tuikov <ltuikov89@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Simona Vetter <simona@ffwll.ch>, 
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>
Subject: Re: [PATCH 4/7] drm/sched: Remove the single scheduler special case
Message-ID: <avEmpPCAQJhoId6M@rock-5b-plus>
References: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
 <20261106145702.61640-5-tvrtko.ursulin@igalia.com>
 <avA9ACE9ar1MEdtD@rock-5b-plus>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avA9ACE9ar1MEdtD@rock-5b-plus>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 06:12:40PM +0900, Sidong Yang wrote:
> This breaks rocket.

Sorry, please disregard this. I was looking at an older tree. In
drm-misc-next rocket already keeps its own pointer to the array since
91c7da1f42ca ("drm/rocket: Keep scheduler allocation in
rocket_file_priv"), so this patch is fine for rocket.

Thanks,
Sidong
