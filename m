Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB887606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=BoR2VswV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E45110E06A;
	Wed, 28 Oct 2026 09:28:51 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3A410E5A3
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:28:43 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261028092842euoutp02b33ff1b1ef104a8f499d7a85d4ef885e~ip3TwswzV0524605246euoutp026
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:28:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261028092842euoutp02b33ff1b1ef104a8f499d7a85d4ef885e~ip3TwswzV0524605246euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793179722;
 bh=IIRTDkX7+h/RwK3bxBmKmbtA5TspSsmHCX/HJK+b2oM=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=BoR2VswVYLFw6g4uLULuGOQwInKC1Wz4+kzlKZD0C/5mkScHaPPljBRlY2lf45NjL
 feQfoQWedEBUPxz8w+uM9Y4hAes5if8IgVDMWSYf7yO5ka4AWerLSV256gYnSUNfDs
 TMB3NL0OAfAilHTLL4OVWkOI5ZZf3aOgJVt4Cr1E=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261028092842eucas1p2dc55792e353ac1acf432f2059760c162~ip3Tj7_-M1592115921eucas1p2U;
 Wed, 28 Oct 2026 09:28:42 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261028092841eusmtip1edf4abe538f7d2aeecee72325b60ab70~ip3TR6mn70726307263eusmtip1Q;
 Wed, 28 Oct 2026 09:28:41 +0000 (GMT)
Message-ID: <2a42bea6-00ab-4d5e-ad8d-facfb51d7a2f@samsung.com>
Date: Wed, 28 Oct 2026 10:28:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5] drm/bridge: sii9234: use extcon cable detection
 logic to detect MHL
To: Henrik Grimler <henrik@grimler.se>
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260723095127.B41251F00A3A@smtp.kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261028092842eucas1p2dc55792e353ac1acf432f2059760c162
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261028092842eucas1p2dc55792e353ac1acf432f2059760c162
X-EPHeader: CA
X-CMS-RootMailID: 20261028092842eucas1p2dc55792e353ac1acf432f2059760c162
References: <20260723-exynos4-sii9234-driver-v5-1-44b31b5597bd@grimler.se>
 <20260723095127.B41251F00A3A@smtp.kernel.org>
 <CGME20261028092842eucas1p2dc55792e353ac1acf432f2059760c162@eucas1p2.samsung.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Handling this patch takes definitely too long, but maybe You will find a few minutes
for the v6 with those fixes:

On 23.07.2026 11:51, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Use-After-Free due to race between `flush_work()` and devres teardown.
> - [High] Missing initial state check breaks display on coldplug.
> - [Medium] Missing `return` statement after `dev_err_probe()` ignores initialization errors.
> --
>
> --- Patch [1]: [PATCH v5] drm/bridge: sii9234: use extcon cable detection logic to detect MHL ---
> commit 15547772b748ad5e9e79681b157e1cae684d850d
> Author: Henrik Grimler <henrik@grimler.se>
>
> drm/bridge: sii9234: use extcon cable detection logic to detect MHL
>
> To use MHL we currently need the MHL chip to be permanently on, which
> consumes unnecessary power. Let's use extcon attached to MUIC to enable
> the MHL chip only if it detects an MHL cable.
>
>> diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
>> index be67642ab7d31..bf211906fefc6 100644
>> --- a/drivers/gpu/drm/bridge/sii9234.c
>> +++ b/drivers/gpu/drm/bridge/sii9234.c
> [ ... ]
>> @@ -864,6 +870,63 @@ static int sii9234_init_resources(struct sii9234 *ctx,
>>  	return 0;
>>  }
>>  
>> +static void sii9234_extcon_work(struct work_struct *work)
>> +{
>> +	struct sii9234 *ctx = container_of(work, struct sii9234, extcon_wq);
>> +	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
>> +
>> +	if (state == ctx->cable_state)
>> +		return;
>> +
>> +	ctx->cable_state = state;
>> +
>> +	if (state > 0)
>> +		sii9234_cable_in(ctx);
>> +	else
>> +		sii9234_cable_out(ctx);
>> +}
> [ ... ]
>> +static int sii9234_extcon_init(struct sii9234 *ctx)
>> +{
> [ ... ]
>> +	ctx->extcon = edev;
>> +	ctx->extcon_nb.notifier_call = sii9234_extcon_notifier;
>> +	INIT_WORK(&ctx->extcon_wq, sii9234_extcon_work);
>> +	ret = devm_extcon_register_notifier(ctx->dev, edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
>> +	if (ret)
>> +		dev_err_probe(ctx->dev, ret, "failed to register notifier for MHL\n");
>> +
>> +	return 0;
>> +}
> [Severity: Medium]
> Will this ignore initialization errors?
>
> If devm_extcon_register_notifier() fails (for example, returning -EPROBE_DEFER
> or -ENOMEM), the error is logged but ignored since there is no return statement
> after dev_err_probe(). The probe function completes successfully and assumes
> ctx->extcon is active.
This is the lack of return dev_err_probe(...) similar to the ones already reported
for the earlier versions.


> [ ... ]
>> @@ -919,12 +982,17 @@ static int sii9234_probe(struct i2c_client *client)
> [ ... ]
>>  	i2c_set_clientdata(client, ctx);
>>  
>>  	ctx->bridge.of_node = dev->of_node;
>>  	drm_bridge_add(&ctx->bridge);
>>  
>> -	sii9234_cable_in(ctx);
>> +	if (!ctx->extcon)
>> +		sii9234_cable_in(ctx);
>>  
>>  	return 0;
>>  }
> [Severity: High]
> Does this code skip setting the initial state if the cable is already plugged
> in during boot?
>
> Extcon notifiers trigger on state changes but do not automatically emit an
> event for the current state upon registration. In sii9234_probe(), if an
> extcon device is found, sii9234_cable_in() is skipped, but the driver never
> queries the initial state.
>
> If the cable is already connected when the driver probes, the hardware will
> never be powered on, and the display will remain non-functional until the user
> physically unplugs and replugs the cable.

This is indeed an important remark. Just call

schedule_work(&ctx->extcon_wq);

in the else branch for (!ctx->extcon) check at the end of probe function.

>> @@ -933,7 +1001,13 @@ static void sii9234_remove(struct i2c_client *client)
>>  {
>>  	struct sii9234 *ctx = i2c_get_clientdata(client);
>>  
>> -	sii9234_cable_out(ctx);
>> +	if (ctx->extcon) {
>> +		flush_work(&ctx->extcon_wq);
> [Severity: High]
> Does this code introduce a race condition with the devres teardown?
>
> Since the notifier is registered via devm_extcon_register_notifier(), it will
> only be unregistered after sii9234_remove() completes. If an extcon state
> change occurs right after flush_work(&ctx->extcon_wq),
> sii9234_extcon_notifier() will queue the work again.
>
> Once sii9234_remove() completes, devres will unregister the notifier and
> free ctx (allocated via devm_drm_bridge_alloc()). When the queued work executes
> in sii9234_extcon_work():
>
> 	struct sii9234 *ctx = container_of(work, struct sii9234, extcon_wq);
> 	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
>
> it will dereference the freed ctx, resulting in a use-after-free.
IMHO this is a generic issue with devm_extcon_* API and for now I would suggest
getting back to non-devm extcon API.

>> +		if (ctx->cable_state > 0)
>> +			sii9234_cable_out(ctx);
>> +	} else {
>> +		sii9234_cable_out(ctx);
>> +	}
>>  	drm_bridge_remove(&ctx->bridge);
>>  }

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

