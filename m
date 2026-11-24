Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08779606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BWfsSYXx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA4410F637;
	Tue, 24 Nov 2026 15:14:18 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080E310F637
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 15:14:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 3423CC2C661;
 Tue, 24 Nov 2026 15:14:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B42F0601E1;
 Tue, 24 Nov 2026 15:14:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5CB2E11E699CF; Tue, 24 Nov 2026 16:14:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795533245; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=G/LXvyy4L1eBU0ZwJpiLjTkZhv8irQ9vdoW7JoGoatk=;
 b=BWfsSYXxS1HkkK9KQsmFBx8aKtJvhIhmtaq7H8vFB9d9+ueE5Z1CtMHCMPGq3CRhv6NdUY
 OKoCZFXEf5UZUexD+PdSLCWPrOsbxp1xgCRkCEb+QmEt9FzKjr9jNsNB8vVLUoD6o5ftt+
 O/CljaecePy4h6dLtDJDfrGDL1Ls0rVwQrPNUsf77G6ORngz87Lb64xo9JHu4CxgGhLTfn
 qvOlbY2mc6pTO5nx1h2n/p+le/LdduwMXVxSJLDAzuWOAGCrCAo1iz3lN4laO/T2dyGdH0
 ypDx4Npfl28JjVIi+OdXAk/2eWtywSidrlZz0eDx8tThsAgJCxswPff31zT1LQ==
Message-ID: <e28993bc-834b-4ae2-921a-09234e9ec176@bootlin.com>
Date: Tue, 24 Nov 2026 16:14:01 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/4] drm/vkms: use the gamma LUT of the state being
 composed
To: Oarora Etimis <oaroraetimis@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Harry Wentland <harry.wentland@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Arthur Grillo <arthurgrillo@riseup.net>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261123-lut-v1-0-5556c89a2ebd@gmail.com>
 <20261123-lut-v1-1-5556c89a2ebd@gmail.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261123-lut-v1-1-5556c89a2ebd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/23/26 17:20, Oarora Etimis wrote:
> The worker can fall behind a commit, so crtc->state may be newer than the
> state the frame is built from, and the frame would mix planes of one state
> with the LUT of another. Take the LUT from crtc_state->base.gamma_lut.
> 
> Clear lut_length and channel_value2index_ratio in the else branch as well,
> so that gamma_lut is either complete or entirely empty. Nothing reads them
> while base is NULL - apply_lut() returns on that - but the next patch
> decides whether to rebuild its table from lut_length alone, and a non-zero
> length next to a NULL base would have it build from a NULL LUT.
> 
> A zero-length blob takes that branch too. It used to leave lut_length at 0
> and channel_value2index_ratio at drm_fixp_div(-1, 0xffff), which nothing
> read either.
> 
> Fixes: db1f254f2cfa ("drm/vkms: Add support to 1D gamma LUT")
> Signed-off-by: Oarora Etimis <oaroraetimis@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
