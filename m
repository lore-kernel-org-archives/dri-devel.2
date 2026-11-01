Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134F606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Zs2i6Qn8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5617A891AA;
	Sun,  1 Nov 2026 14:11:44 +0000 (UTC)
Received: from mta0.migadu.com (out-154.mta0.migadu.com [91.218.175.154])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E8310EA45
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 14:11:37 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=Yj3Ch96OSSiVTVr2M7wDl8PeUGqNkknXjeKIRpqUwXI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793542296; v=1; x=1794147096;
 b=Zs2i6Qn8YKMyOPGaNdhbAu2b7U0EA/3LcCViZ0RuxYcPDVIGA5UW6VqTu1iv6HTBpTCTSlT6
 GjTz7mDywqSZYwaSpNWW7IRoJg2Mvz52a07DJvY3kfXOMe8mV6Y78BM588PkZkp6OQMjPra/nAT
 jZPTjpOn9xPTnSadfer61qmw=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 785229cc940770b9;
 Sun, 01 Nov 2026 14:11:36 +0000
X-Mizu-Trace-ID: 785229cc940770b9
X-Migadu-Flow: FLOW_OUT
Message-ID: <5044b7a0-5eaf-4008-9653-11027b8055b5@linux.dev>
Date: Sun, 1 Nov 2026 14:11:31 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/14] drm/tidss: oldi: Drop unnecessary forward
 declaration
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Swamil Jain <s-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
 <20261029-beagley-ai-display-v4-6-dc7f2b532478@ideasonboard.com>
Content-Language: en-US
From: Aradhya Bhatia <aradhya.bhatia@linux.dev>
In-Reply-To: <20261029-beagley-ai-display-v4-6-dc7f2b532478@ideasonboard.com>
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
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 29/10/26 10:18, Tomi Valkeinen wrote:
> Nothing needs "struct tidss_oldi" in tidss_oldi.h, so drop the forward
> declaration.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Should this perhaps have a Fixes tag?
Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")


Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>

-- 
Regards
Aradhya

