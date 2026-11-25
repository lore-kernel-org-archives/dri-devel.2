Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C9606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=retsim.com header.i=@retsim.com header.a=rsa-sha256 header.s=abaygg6onarqet2uti4t4yyiczbpngnf header.b=n9EJaXqI;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=hsbnp7p3ensaochzwyq5wwmceodymuwv header.b=Xw7a4k3F;
	dkim=temperror header.d=retsim.com header.i=@retsim.com header.a=rsa-sha256 header.s=dkim header.b=DQqf6kmE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD76C10E90E;
	Thu, 26 Nov 2026 08:09:00 +0000 (UTC)
X-Greylist: delayed 384 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 08:54:15 UTC
Received: from a27-35.smtp-out.us-west-2.amazonses.com
 (a27-35.smtp-out.us-west-2.amazonses.com [54.240.27.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0288910FA44
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=abaygg6onarqet2uti4t4yyiczbpngnf; d=retsim.com; t=1795596470;
 h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:Content-Transfer-Encoding;
 bh=d/yl+vck61lXSmVP41IN7VueHC4X7NY9GxB6VsCVKOQ=;
 b=n9EJaXqIHSYzeMtteApLwO54Yo28hUi/O0f6RjvIOxLz1s9lT7GtBquOx6II9MEj
 MKk0cdNca06obS+C/ay5JxFD7kfy1bTwYVVKWHJngr7vnH/bvUlUrQSaVZ//ltLPX9n
 jYZ2BuQ36MQqStURYMhcwtPt0YGjLqz/6eNan8WM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1795596470;
 h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=d/yl+vck61lXSmVP41IN7VueHC4X7NY9GxB6VsCVKOQ=;
 b=Xw7a4k3FnL2pHaJuHkRteHtXR7IUKb18RDzKReVSKT6bcvd65MqJBn/5PC/XzXb1
 OsBT3tlmFZc4swLUb/I1CsWz+tmZhdK4CVJwTKTjPHHlaDA2En+B75aqBH3rzAQ/ogD
 O3e8hJO/LhizWsMOzNMPLwcEoCeIlfvfDGrrEvTo=
Authentication-Results: mailserver.retsim.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=retsim.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=retsim.com; h=
 content-transfer-encoding:content-type:message-id:user-agent
 :references:in-reply-to:subject:to:from:date:mime-version; s=
 dkim; t=1795596466; x=1798188467; bh=d/yl+vck61lXSmVP41IN7VueHC4
 X7NY9GxB6VsCVKOQ=; b=DQqf6kmE2u5TgsWdtSrRjS6VsksRTlC+EC1CnNrNKCt
 Cu8g3Nx24eayB0Dxr6zUiDYfGzA81pOpndZzHmq8OpiBhXwQ+grBLbLdw9YDFs59
 q7KW04GCHp7W97IhM/u4vravxNvmyUAyP8Gd68aQN6WJjyq96UQh5kWdCcRlIpF4
 +CQ6cfWrmdlgtR1WOseuTH07kgr8Q0ioi9uqLfsL4rT0L8fdfSRBrwWDcd8wW4bF
 YwExgAV5isqEH9VYdIXnzl2B75mok0kJZS3kCRmoiiMYBMMz1iIfoHsWJS1tfHU3
 Vn2f6RBPHTAj3PGueuOOdvOO4Ml+zb9wNPgcHBE2GiQ==
X-Virus-Scanned: Debian amavis at 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Nov 2026 08:47:50 +0000
From: lewis@retsim.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/imagination: guard fence release against device
 removal
In-Reply-To: <sashiko-outbox-232926@kernel.org>
References: <20261125082637.2839673-1-lewis@retsim.com>
 <010101a211d07983-72e5379a-adfd-4134-b23d-3e2b1422bc2e-000000@us-west-2.amazonses.com>
 <sashiko-outbox-232926@kernel.org>
User-Agent: Roundcube Webmail
Message-ID: <010101a211e3c747-fb7c38a8-2ba0-4b54-bb1c-7c0758b44f7b-000000@us-west-2.amazonses.com>
X-Sender: lewis@retsim.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.us-west-2.jZ+gdeR9TqNTaB6Dq50UPG8S0IjuYZETsFsi7SlhF6Q=:AmazonSES
X-SES-Outgoing: 2026.11.25-54.240.27.35
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Yes, that leak (including the drm_gpuvm -> drm_dev_put() reference on
pvr_dev, and on pvr_device_lost() as well as pvr_remove()) is
intentional here.

pvr_queue_fence_release() runs under rcu_read_lock(), and
pvr_context_release() tears down FW objects against kernel_vm_ctx and
fw_mm, which pvr_remove() -> pvr_device_fini() destroys after
drm_dev_unplug().  Avoiding the leak cleanly requires moving device
teardown to drmm_ / refcounted lifetime (noted in [PATCH 0/2]), which
was left out so these use-after-free fixes remain minimal and
backportable.

On 2026-11-25 19:42, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] drm/imagination: context and drm_device leak in
>   pvr_queue_fence_release()
> --
> 
> commit 98562e29f0071aecadfba68150e688168073f7c8
> Author: Lewis Lakerink <lewis@retsim.com>
> 
> drm/imagination: guard fence release against device removal
> 
> This commit guards work queueing in pvr_queue_fence_release() with
> drm_dev_enter(), freeing the fence directly and skipping 
> pvr_context_put()
> when the device is unplugged.
> 
>> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c 
>> b/drivers/gpu/drm/imagination/pvr_queue.c
>> index 34b826381aa2b..2a6bfb090fadd 100644
>> --- a/drivers/gpu/drm/imagination/pvr_queue.c
>> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
> [ ... ]
>> @@ -122,8 +123,19 @@ static void pvr_queue_fence_release(struct 
>> dma_fence *f)
>>  {
>>  	struct pvr_queue_fence *fence = container_of(f, struct 
>> pvr_queue_fence, base);
>>  	struct pvr_device *pvr_dev = fence->queue->ctx->pvr_dev;
>> +	int idx;
>> 
>> -	queue_work(pvr_dev->sched_wq, &fence->release_work);
>> +	/*
>> +	 * Fences held by drm_syncobj are released in drm_file_free() before
>> +	 * postclose. After unplug, sched_wq and kernel_vm_ctx may already 
>> be
>> +	 * torn down; free the fence directly and leak the context 
>> reference.
>> +	 */
>> +	if (drm_dev_enter(from_pvr_device(pvr_dev), &idx)) {
>> +		queue_work(pvr_dev->sched_wq, &fence->release_work);
>> +		drm_dev_exit(idx);
>> +	} else {
>> +		dma_fence_free(&fence->base);
>> +	}
>>  }
> 
> [Severity: High]
> Does leaking the fence->queue->ctx reference here also permanently leak
> pvr_dev and trigger teardown warnings?
> 
> drm_dev_unplug() is called not only during pvr_remove(), but also at
> runtime when a GPU reset or MMU flush fails:
> 
> drivers/gpu/drm/imagination/pvr_power.c:pvr_device_lost() {
> 	if (!pvr_dev->lost) {
> 		pvr_dev->lost = true;
> 		drm_dev_unplug(from_pvr_device(pvr_dev));
> 	}
> }
> 
> Once unplugged, dropping the context reference in the else branch 
> prevents
> pvr_context_release() from ever running. That leaves the context in
> pvr_dev->ctx_ids and its firmware objects in fw_objs.list and 
> fw_dev->fw_mm
> (triggering WARN_ONs in pvr_fw_fini() and pvr_context_device_fini()), 
> and
> never drops ctx->vm_ctx, whose drm_gpuvm manager and GEM objects hold
> drm_device references that prevent drm_dev_release() from freeing 
> pvr_dev.
