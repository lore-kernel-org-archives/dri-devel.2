Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45FB606A331
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=KXIvGTeQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AEDB10ED3C;
	Mon,  2 Nov 2026 11:41:31 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E4B10ED57
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:41:24 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 75328BE;
 Mon,  2 Nov 2026 12:39:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793619547;
 bh=T+o17ojaeL3LXS8MEZRII4Gziximst2Yab1GxPQcvhM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KXIvGTeQ97m5HZMByM/E2aPK96z4htwSQbPZrQMzUkZbrLZoiUZPDBa1x8s/HV906
 rvr66VS1WTemwmFC6/KPrpMpywOuNSz8/BNKd3fSRFMNtpomPGSXe8lU6Ko7K8KeVU
 Zx94ahRVzU7xrC2xlIMX5hWiKAfF0T8eWNmSRigE=
Message-ID: <02facf72-2b1e-4e31-a84a-cd18913469c2@ideasonboard.com>
Date: Mon, 2 Nov 2026 13:41:19 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/14] drm/tidss: oldi: Drop unnecessary forward
 declaration
To: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Swamil Jain <s-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
 <20261029-beagley-ai-display-v4-6-dc7f2b532478@ideasonboard.com>
 <5044b7a0-5eaf-4008-9653-11027b8055b5@linux.dev>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <5044b7a0-5eaf-4008-9653-11027b8055b5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 01/11/2026 16:11, Aradhya Bhatia wrote:
> 
> 
> On 29/10/26 10:18, Tomi Valkeinen wrote:
>> Nothing needs "struct tidss_oldi" in tidss_oldi.h, so drop the forward
>> declaration.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> Should this perhaps have a Fixes tag?
> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
I think this is more a cleanup than a fix. The forward declaration 
doesn't cause any issues, so there's nothing to fix.

  Tomi

