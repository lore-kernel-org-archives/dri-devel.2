Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31205606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=ZxcX8BCh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C9D10FBAF;
	Wed, 28 Oct 2026 11:37:43 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F65510E620
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 11:37:37 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C89B34F1;
 Wed, 28 Oct 2026 12:35:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793187323;
 bh=GB91168LCZmaWnYiq32LOE2qoHE3HPCLJzO9vx24/FM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZxcX8BChleYWGT5kbn28zJVL2pWq+SQUsFD60c7Zh3qCDGbQ59FCAH+nP6Kr3UzSA
 6ROQiv2si2OT9hjRmxaXvmJSn75oYsPgYXZ3x+sUfdHro2SifbSimWJWznAiyJYWi+
 oGyXeX3lgy3tKPTueb5T5wK97kVwrOTHp15kOrF8=
Message-ID: <59a88d56-264f-4540-90e3-b9f609681486@ideasonboard.com>
Date: Wed, 28 Oct 2026 13:37:32 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tidss: Fix serial clock reference leak in
 tidss_oldi_init()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, jyri.sarha@iki.fi,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 stable@vger.kernel.org
References: <20260916182950.2092071-1-vulab@iscas.ac.cn>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260916182950.2092071-1-vulab@iscas.ac.cn>
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 16/09/2026 21:29, Wentao Liang wrote:
> The reference to the OLDI serial clock taken with
> of_clk_get_by_name() is kept in the OLDI bridge structure for the
> whole driver lifetime but is never released; neither the bridge
> destruction nor tidss_oldi_deinit() drop it.  Release it when the
> bridge is unregistered.
> 
> Fixes: 7246e0929945 ("drm/tidss: Add OLDI bridge support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/gpu/drm/tidss/tidss_oldi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
> index 17c535bfa057..bd151c83555d 100644
> --- a/drivers/gpu/drm/tidss/tidss_oldi.c
> +++ b/drivers/gpu/drm/tidss/tidss_oldi.c
> @@ -450,6 +450,7 @@ void tidss_oldi_deinit(struct tidss_device *tidss)
>   	for (int i = 0; i < tidss->num_oldis; i++) {
>   		if (tidss->oldis[i]) {
>   			drm_bridge_remove(&tidss->oldis[i]->bridge);
> +			clk_put(tidss->oldis[i]->serial);
>   			tidss->is_ext_vp_clk[tidss->oldis[i]->parent_vp] = false;
>   			tidss->oldis[i] = NULL;
>   		}

I think this still leaks, if the oldi init for a second OLDI fails, in 
which case tidss_oldi_deinit() is not called.

It's probably best to use devm version for the clk.

  Tomi

