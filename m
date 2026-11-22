Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CED606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tsv-stahl-riesa.de header.i=@tsv-stahl-riesa.de header.a=rsa-sha256 header.s=kas202608160020 header.b=EeUeGrHk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C57E10E6CA;
	Sun, 22 Nov 2026 17:15:53 +0000 (UTC)
X-Greylist: delayed 375 seconds by postgrey-1.36 at gabe;
 Sun, 22 Nov 2026 09:52:05 UTC
Received: from dd13108.kasserver.com (dd13108.kasserver.com [85.13.135.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A9A010E4C4
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tsv-stahl-riesa.de;
 s=kas202608160020; t=1795340748;
 bh=NUqWKWOOcDbRS46duJP/8iCCJcgyCaOIJmw0ptFYYqc=;
 h=Date:Subject:To:Cc:From:In-Reply-To:From;
 b=EeUeGrHkbqorCKa0YSaMnTKGoxaNQ4q0D4WGxHDXSf1xcqfF4ocGLsdwEDIqKsdIP
 qcul9513YWya2RRw+jZB6uqAfsxZQu+1xf8XKQ/GdlOTN4Gc2wlZ0UliuNdJLUMVyw
 dnH29I/bJBlW5rmbqEYm/FU5805UK7tRLJnOrBvsT/5cYpXSGoDBdOeMjgMLwFhxFJ
 kI2WkAxsa6gC76KFm8mYBSeGAWffjOJ2wkko4T8g+plAG+/jAUrolYD/owsgWLoV2F
 hA+/7vUbQcTQodR6kMoIDahjRv7SE0aHlG6N2vXe028RGBQsRzNi3oW9SVp3p6kpvq
 wgQ7WYEzqliCA==
X-KAS-Sym: v3:f51bdf72230551df:BHLVAvXUbecqCx65KAKRaRfSCRJ/RnepLulMBbwPWwteb
 mripFIUpAml7cCtqERpaMGvp6Ak7OV3lE8iPMOqmpySjQJMXBc3GoUaNiOJ3JYVYJ6TKopF46jn
 q4uVWX6C3Ji3T33tnuwTxe3Tg5o4SRtDYVASaC9EWX+SWjXVbz1MzhyHPUZKqWAoEsfJYQOCr3/
 e8Hmx1pjaNOkVRlBEOwew3D70xuqqwYoYiiy7493mCJFAFA1pSDWWiaM9UqR8fM4BH7M4Lf2I7O
 IPBxu8VLsAFMYOTxjDWwPLNwXk+ftVWkLUIsiPpytvLNorB9dwbxDD9FVg92DyAthgqKyJeg==:
 16bJgjnCgJ+hUB5OphVvHOGT568XHSuF5oT6jNqmKTsx8sTceOUry0dQBkrGGAhxHil+oWGK5WH
 VOR2TpmcuOhBlsmqtRfuMKdZ5/rcLWlpaq6gOa+IMInafbIyaU3Ag+4tznT916BAA8uXN23ZohH
 S68T7EtsSePw2GpZtgoVS/m3H9WnipbbHSCsfgQkeuBQA/ZMcn+SZzZYJXXpJsvaM109xOswaKM
 L1mg1k8PB6/jti1+ipgB8Kgs0EvplUf1preDxlrAGPDEEMekX3tsagG6ElPLjn32CgdUC8Cqs7M
 jmVZdlEiPiwlnlOOqiN48b7gNXf4obWlBSwsI3ezGOR3VA/0Zh0/4KQitF8QSzclHRe3GStbIY5
 2KFAt2f0Zix7H2Yoc2pY2CGPUi838YslnVm8K8GT6xszMIPmxYAUfxiao5htXGWpasPNOVjtl9F
 i3fk38zRekmS0ArgT4Hy1OdRdTpQD6Vq7OGpsLJFvrHXwGmRTaZ9W/QzLt/svYsohOUFgvVIH1Z
 KnS6M6pLw71Xh6GYYJWpQmToih6mt49LbPDWhK42ZDZ4xbRjt7JmNprYjLHjt5iX2Y8dwr6CqZP
 f5fWQF6Q6144gCk=
Received: from [192.168.2.174]
 (dslb-188-098-197-218.188.098.pools.vodafone-ip.de [188.98.197.218])
 by dd13108.kasserver.com (Postfix) with ESMTPSA id B54BC78200C2;
 Sun, 22 Nov 2026 10:45:47 +0100 (CET)
Message-ID: <70952289-159d-4f10-9b41-01387e44633e@tsv-stahl-riesa.de>
Date: Sun, 22 Nov 2026 10:45:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: host1x: mipi: Disable clock again after powering
 down the pads
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org,
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261025-upstream-host1x-mipi-clk-v1-1-6bc6e755b4cb@tsv-stahl-riesa.de>
Content-Language: en-US
From: Patrick Fischer <admin@tsv-stahl-riesa.de>
In-Reply-To: <20261025-upstream-host1x-mipi-clk-v1-1-6bc6e755b4cb@tsv-stahl-riesa.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Thierry,

gentle ping on this host1x fix. It has Reviewed-by from Mikko and
Svyatoslav and Tested-by from Svyatoslav, and still applies cleanly
to 7.4-rc3.

Thanks,
Patrick
